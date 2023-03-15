CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
git clone $1 student-submission
echo 'Finished cloning'

cd student-submission

if [[ -f ListExamples.java ]]
then
    echo "File found."
else
    echo "File not found."
    exit 1
fi

cd ../
cp TestListExamples.java student-submission
cp -r lib student-submission
cd student-submission

javac -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar *.java

if [[ $? -eq 0 ]]
then
    echo "Successfully compiled!"
else
    echo "Not compiled!"
    exit 1
fi

java -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar org.junit.runner.JUnitCore TestListExamples > test.txt

if grep -q "OK" test.txt
then
    echo "You passed all the test."
else
    echo "You didn't pass!"
fi