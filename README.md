# SOGrupoBash
## Grupo de SO: Alex, Bruno e Duarte

O objetivo deste trabalho é o desenvolvimento de um programa que permita efetuar a gestão simples de um backup de pastas/ficheiros. O objetivo é produzir um protótipo duma aplicação informática futura usando a linguagem e comandos do BASH Shell.

- Pode-se indicar ficheiros individuais ou pastas inteiras (recursivamente)
- O sistema de backup deve armazenar os ficheiros e pastas utilizando a aplicação tar.
- Para poupar espaço, os ficheiros de backup (tar) devem ser comprimido utilizando a aplicação bzip2.
- O sistema de backups será constituído por dois tipos de ficheiros: *.tar.bz2, ficheiros de controlo *.db e um ficheiro de configuração backup.cfg (por exemplo onde estão guardadas os ficheiros tar e db)
- Haverá um ficheiro backup.db principal que deve ter uma entrada por linha contendo, pelo menos, o tipo de ficheiro (pasta ou ficheiro normal), o caminho completo para este, o seu md5 hash (no caso de
ficheiro normal), a data do ultimo backup e qual a periocidade de backup.
- O md5 hash servirá para verificar se um ficheiro necessita de ser atualizado no backup.
- Para cada pasta (ex: ~/bin ), deverá haver um ficheiro de backup (ex: bin.tar.bz2) e um ficheiro de controlo (ex: bin.db).
-- Estes ficheiros de controlo devem ter os nomes dos ficheiros (nomes) e md5’s
- O ficheiro de configuração deve ser guardado na home (~/backup.cfg) e deverá ter a informação necessária para a execução do programa (pasta onde os backups são guardados, pasta onde os ficheiros de controlo são guardados). Deverá ainda conter a informação necessária para realizar todas as tarefas pedidas na interface.
- O backup deverá ser incremental, i.e., apenas devem ser substituídos os ficheiros atualizados dentro do ficheiro *.tar.bz2
- O sistema de backup deverá correr na crontab com uma periocidade no mínimo diária.
- O sistema de backup poderá ser acionado manualmente (fazer backup agora)
