# Análisis filogenético de Thelephorales
## Carla Elisa Silva-Tostado

Este repositorio muestra los scripts para:
- unir las secuencias de varios colaboradores en un solo archivo .fasta
- correr un alineamiento en MAFFT
- conversión de formato .fasta a .phy y .nex
- corrección de nombres duplicados (dentro del script de RAxML y Mr. Bayes)
- ejecutar un análisis de máxima verosimilitud en RAxML y
- un análisis bayesiano en Mr. Bayes
- notificación al término de cada análisis mediante un bot de Telegram

Todos los análisis se ejecutaron en un contenedor con Ubuntu CentOS 7.
  
## Estructura de carpetas
```
proyecto_final/
├─ data/
│  ├─ mis_secuencias
│  ├─ secuencias_colaborador_1
│  └─ secuencias_colaborador_2
├─ bin/
|  ├─ unir_secuencias.sh
|  ├─ alinear_mafft.sh
│  ├─ convertir_formatos.sh
|  ├─ correr_raxml.sh
|  ├─ correr_mrbayes.sh
|  ├─ telegram.sh
│  └─ script_completo.sh
├─ contenedores/
|  └─ bioinfo_container.sif (Ubuntu CentOS 7)
├─ resultados/
│  ├─ alineamientos
│  ├─ relación_taxa_corregidos.txt
   └─ filogenias
