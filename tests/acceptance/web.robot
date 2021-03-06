*** Settings ***
Resource    resources/common.robot
Library     DateTime
Library     SeleniumLibrary
Library     EyesLibrary               ${API KEY}                 EyesLibrary

*** Variables ***
&{LOGO}     id=hplogo                 xpath=//*[@id="hplogo"]

*** Test Cases ***
Check Window
    [Setup]                                   Setup                                                               Web - Check Window
    Check Eyes Window                         Google Homepage
    [Teardown]                                Teardown

Check Region
    [Setup]                                   Setup                                                               Web - Check Region
    ${x}=                                     Get Horizontal Position                                             ${LOGO.id}
    ${y}=                                     Get Vertical Position                                               ${LOGO.id}
    Check Eyes Region                         ${x}                                                                ${y}                                       400                        200                                   Google Logo
    [Teardown]                                Teardown

Check Region By Element
    [Setup]                                   Setup                                                               Web - Check Region By Element
    ${logo}=                                  Get WebElement                                                      ${LOGO.id}
    Check Eyes Region By Element              ${logo}                                                             Google Logo
    [Teardown]                                Teardown

Check Region By Selector
    [Setup]                                   Setup                                                               Web - Check Region By Selector
    Check Eyes Region By Selector             ${LOGO.id}                                                          Google Logo
    [Teardown]                                Teardown

Check Region In Frame By Selector
    [Setup]                                   Setup for Check Region in Frame                                     Web - Check Region In Frame By Selector
    Check Eyes Region In Frame By Selector    iframeResult                                                        body                                       Frame Elements             tag name
    [Teardown]                                Teardown

Is Session Open
    [Setup]                                   Setup                                                               Web - Opened Session
    ${is open}=                               Eyes Session Is Open
    Should Be True                            ${is open}
    [Teardown]                                Teardown

Add Property
    [Setup]                                   Setup                                                               Add Property
    Add Eyes Property                         Office Location                                                     Portugal
    Add Eyes Property                         Language                                                            PT
    Check Eyes Window                         Window
    [Teardown]                                Teardown

Batch Test 1
    [Tags]                                    batch
    [Setup]                                   Setup for Batch                                                     Web - Batch Test 1
    Check Eyes Window                         Homepage
    [Teardown]                                Teardown

Batch Test 2
    [Tags]                                    batch
    [Setup]                                   Setup for Batch                                                     Web - Batch Test 2
    Check Eyes Region By Selector             ${LOGO.id}                                                          Logo
    [Teardown]                                Teardown

Full Page Screenshot
    [Setup]                                   Setup for Full Page Screenshot                                      Web - Full Page Test
    Check Eyes Window                         Full Page
    [Teardown]                                Teardown

Match Level
    [Setup]                                   Setup                                                               Web - Match Level
    Check Eyes Window                         Full Page Strict                                                    matchlevel=strict
    Check Eyes Window                         Full Page Layout
    [Teardown]                                Teardown

Is Disabled
    [Setup]                                   Setup                                                               Web - Is Disabled
    Check Eyes Window                         Google Homepage
    Check Eyes Window                         Disabled Google Homepage                                            isdisabled=${true}
    [Teardown]                                Teardown

Stitch Content
    [Setup]                                   Setup for Stitch Mode                                               Stitch Content
    Check Eyes Region By Selector             overflowing-div-image                                               Div                                        stitchcontent=${true}
    [Teardown]                                Teardown

Get Property
    [Setup]                                   Setup                                                               Get Property
    ${batch}=                                 Get Eyes Property                                                   batch
    Should Be Equal                           ${batch.name}                                                       Web Testing
    [Teardown]                                Teardown

Sapo Noticias
    [Setup]                                   Setup for Sapo                                                      Web - Sapo Noticias
    Check Eyes Region By Selector             noticias                                                            Sapo Noticias
    [Teardown]                                Teardown

*** Keywords ***
Setup
    [Arguments]                               ${test name}
    Open Browser                              http://www.google.com                                               gc
    Maximize Browser Window
    Open Eyes Session                         ${API KEY}                                                          EyesLibraryBaseline                        ${test name}               matchlevel=layout                     enable_eyes_log=${true}    batch=Web Testing

Setup for Check Region in Frame
    [Arguments]                               ${test name}
    Open Browser                              https://www.w3schools.com/tags/tryit.asp?filename=tryhtml_iframe    gc
    Maximize Browser Window
    Select Frame                              xpath=//iframe[@id="iframeResult"]
    Select Frame                              xpath=//iframe[@src="https://www.w3schools.com"]
    Click Element                             xpath=//*[@id="sncmp-banner-btn-agree"]
    Unselect Frame
    Unselect Frame
    Open Eyes Session                         ${API KEY}                                                          EyesLibraryBaseline                        ${test name}               width=1300                            height=900                 enable_eyes_log=${true}    batch=Web Testing

Setup for Batch
    [Arguments]                               ${test name}
    Open Browser                              http://www.google.com                                               gc
    Maximize Browser Window
    ${batch}=                                 Create Eyes Batch                                                   Batch Test                                 2019-01-01 00:00:00
    Open Eyes Session                         testname=${test name}                                               matchlevel=layout                          enable_eyes_log=${true}    batch=${batch}

Setup for Full Page Screenshot
    [Arguments]                               ${test name}
    Open Browser                              http://www.sapo.pt                                                  gc
    Maximize Browser Window
    Open Eyes Session                         testname=${test name}                                               matchlevel=layout                          enable_eyes_log=${true}    force_full_page_screenshot=${true}    stitchmode=css             batch=Web Testing

Setup for Sapo
    [Arguments]                               ${test name}
    Open Browser                              http://www.sapo.pt                                                  gc
    Maximize Browser Window
    Wait Until Element Is Visible             xpath=//*[contains(@class, "qc-cmp-button")]
    Click Element                             xpath=//*[contains(@class, "qc-cmp-button")]
    Open Eyes Session                         ${API KEY}                                                          EyesLibrary                                ${test name}               enable_eyes_log=${true}               batch=Web Testing

Setup for Stitch Mode
    [Arguments]                               ${test name}
    Open Browser                              http://applitools.github.io/demo/TestPages/FramesTestPage/          gc
    Maximize Browser Window
    Open Eyes Session                         ${API KEY}                                                          EyesLibrary                                ${test name}               enable_eyes_log=${true}               batch=Web Testing

Teardown
    Close All Browsers
    Close Eyes Session
