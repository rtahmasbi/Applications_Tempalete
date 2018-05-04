
###############################################################
###############################################################
# install
cd /work/KellerLab/rata8212/softwares/
rm -rf GeneEvolve

git clone https://github.com/rtahmasbi/GeneEvolve
cd GeneEvolve
make


my_date=`date +%Y%m%d`
echo $my_date

cp /work/KellerLab/rata8212/softwares/GeneEvolve/bin/GeneEvolve_$my_date /work/KellerLab/opt/bin
cp /work/KellerLab/rata8212/softwares/GeneEvolve/bin/GeneEvolve_$my_date /work/KellerLab/opt/bin/GeneEvolve



# for himem04
my_date=`date +%Y%m%d`
echo $my_date

cp /work/KellerLab/rata8212/softwares/GeneEvolve/bin/GeneEvolve_$my_date /work/KellerLab/opt/bin/GeneEvolve_himem04

###############################################################


