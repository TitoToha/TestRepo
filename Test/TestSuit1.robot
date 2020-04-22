*** Settings ***
Documentation     Some Usefull Keyboard short-cuts:
...    Press CTR + Shift + / to comment a section

#Press CTRL-1 to initiate SeleniumLibrary
Library    SeleniumLibrary

#Zum ausführen von funktionen vor und nach Testset (suit)/Testfall
Suite Setup        log    I am inside a Suite Setup
Suite Teardown     log    I am inside a Suite Teardown
Test Setup         log    I am inside a Test Setup
Test Teardown      log    I am inside a Test Teardown

#TDas ist der Default Tag für alle Tests, es sei denn es wird überschrieben
Default Tags    MyDefaultTag
 
*** Variables ***
${URL}    https://opensource-demo.orangehrmlive.com/index.php/auth/login
@{LoginDaten}    Admin    admin123
&{BenutzerDaten}    Benutzer=Admin    Passwort=admin123

*** Keywords ***
LoginKeyword
    [Documentation]     Wir geben hier die Login Daten ein und
    ...    Drückern anschließend den Button
    Input Text    id=txtUsername    @{LoginDaten}[0]
    Input Text    id=txtPassword    &{BenutzerDaten}[Passwort]
    #Press Keys    id=txtPassword    ENTER
    Click Button  id=btnLogin

*** Test Cases ***

MyFirstTestcase
    #Dieser Tag überschreibt den Default Tag
    [Tags]    MyOnlyTag
    Log    Hello World...
    
MyFirstSeleniumTest
    #Dieser Tag überschreibt NICHT den Default Tag sondern setzt es zusätzlich
    Set Tags    RegressionTest  
    
    #Der Tag kann auch entfernt werden
    Remove Tags    RegressionTest  

    Open Browser    https:www.google.de    chrome
    Set Browser Implicit Wait    5
    Input Text      name=q       Hasan Toha
    Press Keys      name=q       ENTER
    #Click Button    name=btnK    
    Sleep    2          
    Close Browser
    Log    Test1 Completed
    
MyFirstLoginTest
    [Documentation]    My First Login Demo 
    ...    And Further more to come
    
    Open Browser    ${URL}    chrome
    Set Browser Implicit Wait    5
    
    LoginKeyword
    
    Sleep    1    
    Click Element    id=welcome
    Click Element    link=Logout
    Close Browser       
    Log    Test2 Completed
    Log    Dieser Testfall wurde ausgeführt bei %{username} auf einem %{os}-Rechner!
 
MyForthTestCase
    Log    this is the 4th Testcase - in a DEV Branch
    
#Ausführen von Testfällen von Commandline:
#1. zum Testfall Ordner wechseln
#2. robot -t <Testname> <TestSuite> bsp. robot -t MyFirstTestCase test\TestSuite.robot

#Ausführen von Testfällen von Commandline und ein Tag zuweisen
#1. zum Testfall Ordner wechseln
#2. robot -t <Testname> --settag=<taname> <TestSuite> bsp. robot -t MyFirstTestCase settag=Regressiontest  test\TestSuite.robot

#Ausführen von Testfällen von Commandline mit einem bestimmten Tag
#1. zum Testfall Ordner wechseln
#2. robot include <tagname> <TestSuite> bsp. robot include RegressionTag test\testSui1.robot
#Hinweis: tagname kann auch mit Wildcard z.b. Reg* abgekürzt werden

#Ausführen von Testfällen von Commandline mit mehreren Tag
#1. zum Testfall Ordner wechseln
#2. robot -i <tagname1> -i <tagname2> <TestSuite> bsp. robot -i MyOnlyTag -i RegressionTag test\testSui1.robot

#Ausführen von Testfällen von Commandline und Tags auschließen
#1. zum Testfall Ordner wechseln
#2. robot -e <tagname1> <TestSuite> bsp. robot -e MyOnlyTag test\testSui1.robot
#Hinweis: es ist auch möglich -i und -e gleichzeitig zu verwenden 