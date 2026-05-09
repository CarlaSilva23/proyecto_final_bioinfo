# Análisis filogenético de Thelephorales
## Carla Elisa Silva-Tostado

Este repositorio muestra los scripts para:
- unir las secuencias de varios colaboradores en un solo archivo .fasta
- correr un alineamiento en MAFFT
- conversión de formato .fasta a .phy y .nex
- corrección de nombres duplicados
- ejecutar un análisis de máxima verosimilitud en RAxML y
- un análisis bayesiano en Mr. Bayes
- notificación al término de cada análisis mediante un bot de Telegram
  
## Estructura de carpetas
```
proyecto_final/
├─ data/
│  ├─ mis_secuencias
│  ├─ secuencias_colaborador_1
│  └─ secuencias_colaborador_2
├─ bin/
├─ resultados/
│  ├─ alineamientos
│  ├─ relación_taxa_corregidos.txt
   └─ phylogeny
