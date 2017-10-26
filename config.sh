# Pheno-Import Variables
PH_HOME=$PWD
PSQL_HOST='localhost'
PSQL_PORT='5432'

# write to vars file
echo "PH_HOME=$PH_HOME
PSQL_HOST=$PSQL_HOST
PSQL_PORT=$PSQL_PORT" > $PH_HOME/conf/vars

# download tMDataLoader
cd $PH_HOME
git clone https://github.com/Clarivate-LSPS/tMDataLoader.git
cd tMDataLoader
rm Config.groovy
./gradlew deployJar

# setup tMDataLoader psql user
acc='pheno_import'
pwd=$acc
tmUser=$(createuser $acc -s 2>&1)
sudo -u $USER psql -c "ALTER USER $acc WITH PASSWORD '$pwd';"
if [ ! -f ~/.pgpass ]; then
	touch ~/.pgpass
	chmod 0600 ~/.pgpass
fi;
echo "$PSQL_HOST:$PSQL_PORT:transmart:$acc:$pwd" > ~/.pgpass

# Setup sql scripts for tMDataLoader
cd sql/postgres
psql -d transmart -U $USER -f migrations.sql -h $PSQL_HOST
psql -d transmart -U $USER -f permissions.sql -h $PSQL_HOST
psql -d transmart -U $acc -f procedures.sql -h $PSQL_HOST


