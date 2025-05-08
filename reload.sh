#
# Commands to run to get this file:
# rm -rf qa-labs
# git clone https://github.com/masterofsql/QA-DA4-M7.git qa-labs
# cp qa-labs/reload.sh .
# dos2unix reload.sh
# chmod +x reload.sh
# ./reload.sh
#
#
cd ~
rm -rf qa-labs
git clone https://github.com/masterofsql/QA-DA4-M7.git qa-labs
cp qa-labs/DEMO5/get_info.sh .
dos2unix get_info.sh
chmod +x get_info.sh
./get_info
