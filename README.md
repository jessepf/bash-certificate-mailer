# BASH Certificate Generator and Mailer
Generates certificates and mails them to participants of an event/conference.

There may be tonnes of software which does this. This is a barebone BASH script I developed to ease my job, back in 2018 February.

## What does it do?
* Generate NAME, COLLEGE and EMAIL list of participants.
* Place NAME, COLLEGE (text) on the certificate template (image) starting at given pixel coordinates.
* Fire an email client with EMAIL in to: and addressing NAME in body. I would recommend setting it to manually click send instead of automating it – little time consuming, but I suspect quick, automatic mailing to multiple email IDs may cause provider to blacklist you as a spammer.

## Sample implementation

I used BASH, imagemagick and Thunderbird to achieve the target.
Reason I Chose:

    BASH – cut the codes short to less than 10 lines compared to Java/MATLAB which has its own advantages, but not worth the time.
    Thunderbird – Was already installed and configured to my taste and had option to compose command line
    convert – I’m on Linux Mint and it’s preinstalled.It's preinstalled in nearly all distros.

## Pre-requisites

* Any flavour of Linux
* “convert” from package imagemagick.
* Thunderbird configured with the right email ID.
* Certificate template in any common image format.
* A file named NameList.txt with NAME, COLLEGE, EMAIL  in one line each. File would look like:

    NAME1
    COLLEGE1
    EMAIL1
    NAME2
    COLLEGE2
    EMAIL2
    ...

## Sample Code

```
FILE=../NameList.txt
cd Certificates
while read NAME; do
   read COLLEGE
   read MAIL
   convert ../Certificate.png -gravity North -pointsize 20 -annotate +100+318 "$NAME" Certificate.png
   convert Certificate.png -gravity North -pointsize 20 -annotate -200+345 "$COLLEGE" Certificate.png
   thunderbird -compose "from='someone@somedomain.com',subject='Conference Certificate',to='$MAIL',attachment='~/CGAM/Certificates/Certificate.png',format='html',body='Dear $NAME,<br/><br/>&emsp;Please find the certificate attached.<br/><br/>Regards<br/>Organising Secretary'"
done < "$FILE"
```

This code generates a temporary certificate in the folder Certificates notice that parameter “-annotate +100+318” in line 6 give s x and y coordinates of beginning of NAME text, and similarly in line 7 for COLLEGE text.

Certificate template is placed in the same folder as the script, called Certificate.png. Generated certificates will be placed in subfolder Certificates in  a temporary file “Certificate.png”.
