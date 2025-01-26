*** Settings ***
Library    SeleniumLibrary
Library    ../robot-env/lib/python3.13/site-packages/robot/libraries/OperatingSystem.py

*** Variables ***
${URL}    https://www.allonline.7eleven.co.th/
${BROWSER}    chrome
${USERNAME}    test@mail.com
${PASSWORD}    test123456
${PHONETRUEMONEY}    0999999999
${BRANCHID}    04811

*** Test Cases ***
Successfully tested purchasing products on All Online
    Open Browser    ${URL}    ${BROWSER}
    Search for product name    ซอยแคท อาหารแมว
    Check search ซอยแคท
    Close the cookie
    Select product
    Add more products    มีโอ อาหารแมว ปลาทูน่า
    Check search มีโอ
    Log in to pay for products    ${USERNAME}    ${PASSWORD}
    Select to receive products from the branch    ${BRANCHID}    ${PHONETRUEMONEY}
    Pay with True monney wallet    ${PHONETRUEMONEY}

*** Keywords ***
Search for product name
    [Arguments]    ${SearchProduct1}
    Input Text    name=q    ${SearchProduct1}
    Press Keys    name=q    RETURN

Check search ซอยแคท
    Wait Until Element Is Visible    class:item-list-wrapper
    Element Should Contain    xpath://*[@id="page"]/div[2]/div[2]/div/div/div[2]/div/div/div/div/div/div[3]/div[1]/div/a[2]/div    ซอยแคท อาหารแมว 1 มิกซ์ 1 กก.
Close the cookie
    Execute JavaScript    document.querySelector('#alert-cookie-gdpr-allonline__button-less').click()
Select product
    Click Element    xpath://*[@id="page"]/div[2]/div[2]/div/div/div[2]/div/div/div/div/div/div[3]/div[1]/div/a[2]/div  
Add more products
    [Arguments]    ${SearchProduct2}
    Wait Until Element Is Visible    xpath://*[@id="article-form"]/div[2]/div[2]/div[4]/div[1]/button    timeout=10s
    Click Element    xpath://*[@id="article-form"]/div[2]/div[2]/div[4]/div[1]/button
    Input Text    name=q    ${SearchProduct2}
    Click Element    locator=class:input-group-btn
Check search มีโอ
    Wait Until Element Is Visible    class:item-list-wrapper
    Element Should Contain    xpath://*[@id="page"]/div[2]/div[2]/div/div/div[2]/div/div/div/div/div/div[3]/div[1]/div/a[2]/div    มีโอ อาหารแมว ปลาทูน่า

Log in to pay for products
    [Arguments]    ${Username}    ${Password}
    Wait Until Element Is Visible    xpath://*[@id="article-form"]/div[2]/div[2]/div[4]/div[2]/button    timeout=10s
    Click Element    xpath://*[@id="article-form"]/div[2]/div[2]/div[4]/div[2]/button
    Wait Until Element Is Visible    xpath://*[@id="__next"]/div/div/div[2]/div[2]/div/div/div/div[1]/h2
    Input Text    name=email    ${Username}
    Input Text    name=password    ${Password}
    Click Element    xpath://*[@id="__next"]/div/div/div[2]/div[2]/div/div/div/div[6]/a[1]

Select to receive products from the branch
    [Arguments]    ${BranchID}    ${PhoneTrueMoney}
    Wait Until Element Is Visible    xpath://*[@id="page"]/div/div[3]/div/div
    Input Text    id:second-phone-shipping    ${PHONETRUEMONEY}
    Click Element    class:arrow
    Wait Until Element Is Visible    id:user-storenumber-input
    Input Text    id:user-storenumber-input    ${BranchID}
    Click Element    id:btn-check-storenumber
    Wait Until Element Contains    class:address-7_11_store-detail-header    เซเว่นอีเลฟเว่น #04811
    Click Element    id:continue-payment-btn

Pay with True monney wallet
    [Arguments]    ${PhoneTrueMoney}
    Wait Until Element Is Visible    xpath://*[@id="payment-options"]/div[2]/button
    Click Element    xpath://*[@id="payment-options"]/div[2]/button
    Wait Until Element Is Visible    xpath=//*[@id="checkoutData.paymentData.trueMoneyMobileNumber"]    timeout=10s
    Input Text    xpath=//*[@id="checkoutData.paymentData.trueMoneyMobileNumber"]    ${PhoneTrueMoney}
    Wait Until Element Is Visible    xpath=//*[@id="stepModel"]/div[1]/div[2]/footer/div/div/button    timeout=10s