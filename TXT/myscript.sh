bash Generating SHA256 keys
rm -f SHA256 SHA256SUM.asc

FILES="my*.txt my*.sh"
SHA="SHA256SUM"

echo Removing previous instances of SHA256 hash
rm -f $SHA $SHA.asc
echo Removal success

echo Generating SHA256 hash
sha256sum $FILES > $SHA
echo Hashing successfull

echo Signing SHA256 with keys
gpg -o $SHA.asc -a -sb $SHA
echo Signed!

echo Verifying
gpg --verify $SHA.asc $SHA
echo Verification Success

echo Do you want to submit to GitHub 1/0?

read send

if (($send == 1))
then 
  
  echo Sending to Github!
  git pull
  git add "*"
  git commit -m "Automated Update '%H:%M'"
  git push
  ls -al
fi
echo done

exit 0


