source /mnt/vol_NFS_rh003/estudiantes/archivos_config/synopsys_tools.sh;
rm -rfv ls |grep -v ".*\.sv\|.*\.sh";
vcs -Mupdate test_bench.sv  -o salida -full64 -debug_all -kdb -sverilog -l log_test.txt +lint=TFIPC-L;
