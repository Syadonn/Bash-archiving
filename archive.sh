cd ~/Téléchargements					#Change this line to change this concerned directory

timemonth=$(date -d "-1 month" '+%s') 	#We get the timestamp of a month ago
namedir=$(date -d "-1 month" '+%B_%Y') 	#We get the name of the future zipped dir (monthname_year)

nb=$(ls| wc -l) 						#We count the number of files in the working directory

ls > temp 								#We get all the files names and store them in temp
mkdir $namedir
touch liste_fichiers.txt

while [[ $nb -ge 1 ]] 					#While we haven't scan every file/dir
do
	namefile=$(cat temp | head -n $nb| tail -n 1) 	#We get the file's name
	timefile=$(date -r "$namefile" '+%s') 			#We get the file's timestamp

	if [[ $timefile -lt $timemonth ]]; then
		mv "$namefile" $namedir
		echo "$namefile" >> liste_fichiers.txt
	fi

	nb=$(($nb-1))
done

mv liste_fichiers.txt $namedir
zip -r $namedir.zip $namedir
rm -rf temp $namedir
