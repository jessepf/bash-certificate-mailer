FILE=../NameList.txt
cd Certificates
while read NAME; do
   read COLLEGE
   read MAIL
   convert ../Certificate.png -gravity North -pointsize 20 -annotate +100+318 "$NAME" Certificate.png
   convert Certificate.png -gravity North -pointsize 20 -annotate -200+345 "$COLLEGE" Certificate.png
   thunderbird -compose "from='someone@somedomain.com',subject='Conference Certificate',to='$MAIL',attachment='~/CGAM/Certificates/Certificate.png',format='html',body='Dear $NAME,<br/><br/>&emsp;Please find the certificate attached.<br/><br/>Regards<br/>Organising Secretary'"
done < "$FILE"
