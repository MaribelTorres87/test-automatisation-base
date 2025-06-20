@Evaluacion
Feature: Test de API súper simple

  Background:
    * configure ssl = true
     * def base_url = 'http://bp-se-test-cabcd9b246a5.herokuapp.com/'

    @id:1 @ObtenerPersonajesTodos
    Scenario Outline: T-API-BTFAC-123-CA01- Obtener Todos los Personajes
        Given url base_url + username + '/api/characters'
        When method GET
        Then status 200
        And print response         
        Examples:
            | read('classpath:../data/user.csv') |

 
     @id:2 @ObtenerPersonajesID
    Scenario Outline: T-API-BTFAC-123-CA02- Obtener Personaje ID
        Given url base_url + username + '/api/characters/' + idPersonaje
        When method GET
        Then status 200
        And print response         
        Examples:
            | read('classpath:../data/idPersonajes.csv') |

  @id:3 @ObtenerPersonajesNoExistente
    Scenario Outline: T-API-BTFAC-123-CA03- Obtener Personaje No Existente
        Given url base_url + username + '/api/characters/' + idPersonaje
        When method GET
        Then status 404
        And print response         
        Examples:
            | read('classpath:../data/idEliminaPersonajeNoExiste.csv') |
    
    @id:4 @CrearPersonaje
    Scenario Outline: T-API-BTFAC-123-CA04- Crear Personaje
        Given url base_url + username + '/api/characters'
        And header Content-Type = 'application/json'
        And def personaje = read('classpath:../payloads/nuevoPersonaje.json')
        And request personaje
        When method POST
        Then status 201
        And print response
        And match response.name == 'CohetePlus38'
     Examples:
            | read('classpath:../data/user.csv') |

    @id:5 @CrearPersonajeNombreDuplicado
    Scenario Outline: T-API-BTFAC-123-CA05- Crear Personaje Nombre Duplicado
        Given url base_url + username + '/api/characters'
        And header Content-Type = 'application/json'
        And def personaje = read('classpath:../payloads/nuevoPersonaje.json')
        And request personaje
        When method POST
        Then status 400
        And print response
     Examples:
            | read('classpath:../data/user.csv') |

    @id:6 @CrearPersonajeCamposFaltantes
    Scenario Outline: T-API-BTFAC-123-CA05- Crear Personaje CamposFaltantes
        Given url base_url + username + '/api/characters'
        And header Content-Type = 'application/json'
        And def personaje = read('classpath:../payloads/camposFaltantesPersonaje.json')
        And request personaje
        When method POST
        Then status 400
     Examples:
            | read('classpath:../data/user.csv') |


    @id:7 @ActualizarPersonaje
    Scenario Outline: T-API-BTFAC-123-CA07- Actualizar Personaje
        Given url base_url + username + '/api/characters/' + idPersonaje
        * print idPersonaje
        And header Content-Type = 'application/json'
        And def personaje = read('classpath:../payloads/actualizaPersonaje.json')
        And request personaje
        When method PUT
        Then status 200
        And print response
        And match response.name == 'CohetePlus38'
     Examples:
            | read('classpath:../data/idPersonajes.csv') |

    @id:8 @ActualizarPersonajeNoExiste
    Scenario Outline: T-API-BTFAC-123-CA08- Actualizar Personaje No Existe
        Given url base_url + username + '/api/characters/' + idPersonaje
        * print idPersonaje
        And header Content-Type = 'application/json'
        And def personaje = read('classpath:../payloads/actualizarPersonajeNoExiste.json')
        And request personaje
        When method PUT
        Then status 404
        And print response
     Examples:
            | read('classpath:../data/IdPersonajeNoExiste.csv') |


  @id:9 @EliminarPersonaje
    Scenario Outline: T-API-BTFAC-123-CA09- Eliminar Personaje
       Given url base_url + username + '/api/characters/' + idPersonaje
        When method DELETE
        Then status 204
        * print response
     Examples:
            | read('classpath:../data/idEliminaPersonaje.csv') |


  
  @id:10 @EliminarPersonajeNoExiste
    Scenario Outline: T-API-BTFAC-123-CA10- Eliminar Personaje No Existe
       Given url base_url + username + '/api/characters/' + idPersonaje
        When method DELETE
        Then status 404
        * print response
     Examples:
            | read('classpath:../data/idEliminaPersonajeNoExiste.csv') |