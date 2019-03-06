*** Settings ***
Library     AppiumLibrary
Library     EyesLibrary
Resource    resources/common.robot
Resource    resources/mobile.robot

*** Variable ***
&{LOGO}     id=hplogo                 xpath=//*[@id="hplogo"]

*** Test Cases ***
Check Window
    [Setup]                          Setup                                  Mobile Browser - Check Window
    Check Eyes Window                Google Homepage
    [Teardown]                       Teardown

Check Region
    [Setup]                          Setup                                  Mobile Browser - Check Region
    ${location}=                     Get Element Location                   ${LOGO.id}
    Check Eyes Region                ${location['x']}                       ${location['y']}                             300           50               Google Logo
    [Teardown]                       Teardown

Check Region By Element
    [Setup]                          Setup                                  Mobile Browser - Check Region By Element
    ${logo}=                         Get Webelement                         ${LOGO.id}
    Check Eyes Region By Element     ${logo}                                Google Logo
    [Teardown]                       Teardown

Check Region By Selector
    [Setup]                          Setup                                  Mobile Browser - Check Region By Selector
    Check Eyes Region By Selector    ${LOGO.id}                             Google Logo
    [Teardown]                       Teardown

Is Session Open
    [Setup]                          Setup                                  Mobile Browser - Opened Session
    ${is open}=                      Eyes Session Is Open
    Should Be True                   ${is open}
    [Teardown]                       Teardown

*** Keywords ***
Setup
    [Arguments]                      ${test name}
    Open Application                 remote_url=${REMOTE URL}
    ...                              platformName=${PLATFORM NAME}
    ...                              platformVersion=${PLATFORM VERSION}
    ...                              deviceName=${DEVICE NAME}
    ...                              browserName=Chrome
    ...                              automationName=UiAutomator2
    Go To Url                        http://www.google.pt
    Set Location                     10                                     10
    Open Eyes Session                EyesLibrary                            ${test name}                                 ${API KEY}    AppiumLibrary    includeEyesLog=true

Teardown
    Close Application
    Close Eyes Session