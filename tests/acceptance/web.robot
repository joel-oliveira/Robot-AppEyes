*** Settings ***
Library     SeleniumLibrary
Library     EyesLibrary
Resource    resources/common.robot

*** Variables ***
&{LOGO}     id=hplogo                 xpath=//*[@id="hplogo"]

*** Test Cases ***
Check Window
    [Setup]                          Setup                      Web - Check Window
    Check Eyes Window                Google Homepage
    [Teardown]                       Teardown

Check Region
    [Setup]                          Setup                      Web - Check Region
    ${x}=                            Get Horizontal Position    ${LOGO.id}
    ${y}=                            Get Vertical Position      ${LOGO.id}
    Check Eyes Region                ${x}                       ${y}                              400           200    Google Logo
    [Teardown]                       Teardown

Check Region By Element
    [Setup]                          Setup                      Web - Check Region By Element
    ${logo}=                         Get WebElement             ${LOGO.id}
    Check Eyes Region By Element     ${logo}                    Google Logo
    [Teardown]                       Teardown

Check Region By Selector
    [Setup]                          Setup                      Web - Check Region By Selector
    Check Eyes Region By Selector    ${LOGO.id}                 Google Logo
    [Teardown]                       Teardown

Is Session Open
    [Setup]                          Setup                      Web - Opened Session
    ${is open}=                      Eyes Session Is Open
    Should Be True                   ${is open}
    [Teardown]                       Teardown

*** Keywords ***
Setup
    [Arguments]                      ${test name}
    Open Browser                     http://www.google.com      gc
    Open Eyes Session                EyesLibrary                ${test name}                      ${API KEY}
    #Open Eyes Session    EyesLibrary_AppName   EyesLibrary_TestName   ${API KEY}   SeleniumLibrary   1024    768    OSOverrideName    BrowserOverrideName    LAYOUT     includeEyesLog=True    httpDebugLog=False    branchname=BranchName     parentbranch=ParentBranch   
    

Teardown
    Close All Browsers
    Close Eyes Session