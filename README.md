# Maximización de la supervivencia de especies

El presente estudio tiene como meta principal reconocer y distinguir los diferentes comportamientos asociados a un ambiente simulado de miembros, alimentación y obstáculos, donde la supervivencia y el manejo de la comunicación entre los miembros o individuos son los elementos primordiales a identificar. Basado en el impulso y estructura que permiten construir los algoritmos genéticos, esta investigación busca ser desarrollada basándose en la idea de evolución biologica que nos brindan estos algoritmos. Estudios similares aplicados a la robótica permiten ser de gran ayuda como fuente bibliográfica adicional permitiendo aclarar en gran manera la forma en como desarrollar la simulación en un ambiente de software.

## Objetivo general

Implementar un programa que mediante algoritmos evolutivos, logre que individuos pertenecientes a un ambiente simulado, puedan distinguir que elementos les proporcionan supervivencia y que elementos los eliminan del ambiente, esto a través de comunicación entre los individuos del entorno.

## Objetivos específicos

Como parte de la implementación del programa, es de vital importancia desarrollar los siguientes aspectos dentro de la simulación, y la forma específica de comunicación entre los individuos.

* **Simulación:** simular la forma en que las primeras generaciones de organismos vivos descubrieron la manera de alimentarse y transmitir esa información a las siguientes generaciones.
* **Sistemas multiagentes:** conocer cómo funcionan y cómo se implementan los algoritmos evolutivos en sistemas multiagente.
* **Comunicación entre generaciones:** lograr recrear, de una manera muy básica y en un ambiente controlado, el comportamiento de seres vivos con sus necesidades más básicas (alimentarse y sobrevivir) y como le transmiten esta información a sus sucesores.

## Resultados obtenidos

Se corrió la simulación treinta veces con 1500 ticks cada generación. Las medias de los datos obtenidos se pueden detallar en el siguiente cuadro:

| Estado de los agentes | Sin el algoritmo genético | Con el algoritmo genético |
|:---------------------:|:-------------------------:|:-------------------------:|
| Vivos                 |   128                     |   227                     |
| Muertos               |   171                     |   73                      |

Gracias a la información arrojada por el experimento, se puede concluir que se logró satisfacer el objetivo principal de la investigación. Efectivamente, se logró implementar un programa que hiciera que individuos en un ambiente controlado lograran diferencias entre alimento y veneno. En los datos que se recopilaron se puede apreciar que gracias a esto, la población logró aumentar considerablemente su supervivencia.

## Problemas abiertos

###### Manejo de memoria propia para cada agente

Se propone implementar el programa pero de manera que el manejo del conocimiento sea distinto.
Sería interesante observar el comportamiento de los agentes haciendo el cambio de que en vez de que utilicen memoria compartida, cada agente tenga su propio vector de coordenadas malas y que este conocimiento se lo transmitan a los demás individuos al toparse con ellos durante la simulación.

###### Optimización del tiempo de la simulación

Se propone a los interesados que se determine alguna manera en que se logre mejorar el tiempo de respuesta de la simulación. Se piensa que el aumento en el tiempo se debe a la gran cantidad de agentes que están tratando de leer y escribir en el recurso compartido (el vector de coordenadas). Lo anterior ocaciona que NetLogo tenga que hacer una sincronización entre todos los agentes y esto se cree que es lo que repercute en el tiempo de la simulación.

## Desarrolladores

* José Pablo Ureña [GitHub](https://github.com/SlyJose)
* Fabián Rodríguez [GitHub](https://github.com/fabo49)
