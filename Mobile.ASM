.model small
.stack 100h

.data
    welcome_msg          db           "Welcome to the Tech Online Store!", 10, 13, "$"
    select_msg           db           "Select a Category:", 10, 13, "$"
    categories_msg       db           10, 13,"1. Phones", 10, 13, "2. Laptops", 10, 13, "3. Accessories", 10, 13,"4. Exit", 10, 13,"$"
    mobile_items         db           10, 13,"1. Samsung", 10, 13, "2. Apple", 10, 13, "3. Xiaomi", 10, 13,"6. Exit", 10, 13,"$"
    accessories_items    db           10, 13,"1. Headphones", 10, 13, "2. Phone Cases", 10, 13, "3. Power Banks", 10, 13,"0. Back", 10, 13,"$"
    laptops_items        db           10, 13,"1. Dell XPS 15", 10, 13, "2. MacBook Pro", 10, 13, "3. HP Spectre x360", 10, 13,"0. Back", 10, 13,"$"

    purchase_prompt       db           10,13,"Would you like to purchase this? (1: Yes, 2: No): ", 10, 13, "$"
    input_purchase_msg    db             'Please Enter Your Purchase Code: $'
    input_chars           db             10 dup('$')
    purchase_code         db             'UBIT$'
    correct_purchase_code db             'Successfully purchased.', 10,13,'$'
    wrong_purchase_code   db             'Your Entered Purchase code is Wrong !', 10,13,'$'
    try_again             db             'Would you like to retry? (1: Yes, 2: No): ', 10,13,'$'
   
    specs_msg            db           "Specifications:", 10, 13, "$"

    ; Mobile Brands
    samsung_phones       db           10, 13,"1. Galaxy S21", 10, 13, "2. Galaxy Note 20", 10, 13,"0. Back", 10, 13,"$"
    apple_phones         db           10, 13,"1. iPhone 12", 10, 13, "2. iPhone SE", 10, 13,"0. Back", 10, 13,"$"
    xiaomi_phones        db           10, 13,"1. Mi 11", 10, 13,"2. Redmi Note 10", 10, 13,"0. Back", 10, 13,"$"

    ; Mobile Phones
    galaxy_s21_specs     db           10, 13,"Galaxy S21 Specs: 6.2-inch display, 12GB RAM, 128GB storage", 10, 13, "$"
    galaxy_s21_price     db           "Price: PKR 150,000", 10, 13, "$"

    note_20_specs        db           10, 13,"Galaxy Note 20 Specs: 6.7-inch display, 8GB RAM, 256GB storage", 10, 13, "$"
    note_20_price        db           "Price: PKR 120,000", 10, 13, "$"

    iphone_12_specs      db           10, 13,"iPhone 12 Specs: 6.1-inch display, 4GB RAM, 64GB storage", 10, 13, "$"
    iphone_12_price      db           "Price: PKR 170,000", 10, 13, "$"

    iphone_se_specs      db           10, 13,"iPhone SE Specs: 4.7-inch display, 3GB RAM, 64GB storage", 10, 13, "$"
    iphone_se_price      db           "Price: PKR 90,000", 10, 13, "$"

    mi_11_specs          db           10, 13,"Mi 11 Specs: 6.81-inch display, 8GB RAM, 128GB storage", 10, 13, "$"
    mi_11_price          db           "Price: PKR 100,000", 10, 13, "$"

    redmi_note_10_specs  db           10, 13,"Redmi Note 10 Specs: 6.43-inch display, 6GB RAM, 128GB storage", 10, 13, "$"
    redmi_note_10_price  db           "Price: PKR 50,000", 10, 13, "$"

    ; Accessories
    headphones_specs     db           10, 13,"Headphones Specs: Bluetooth, Noise Cancelling, 20-hour battery", 10, 13, "$"
    headphones_price     db           "Price: PKR 5,000", 10, 13, "$"

    phone_cases_specs    db           10, 13,"Phone Cases Specs: Compatible with iPhone and Samsung, Shockproof", 10, 13, "$"
    phone_cases_price    db           "Price: PKR 2,000", 10, 13, "$"

    power_banks_specs    db           10, 13,"Power Banks Specs: 20000mAh, Dual USB Ports, LED Flashlight", 10, 13, "$"
    power_banks_price    db           "Price: PKR 3,000", 10, 13, "$"

    ; Laptops
    dell_xps_specs       db           10, 13,"Dell XPS 15 Specs: 15.6-inch 4K display, Intel Core i7, 16GB RAM, 512GB SSD", 10, 13, "$"
    dell_xps_price       db           "Price: PKR 200,000", 10, 13, "$"

    macbook_pro_specs    db           10, 13,"MacBook Pro Specs: 13.3-inch Retina display, Apple M1 chip, 8GB RAM, 256GB SSD", 10, 13, "$"
    macbook_pro_price    db           "Price: PKR 250,000", 10, 13, "$"

    hp_spectre_specs     db           10, 13,"HP Spectre x360 Specs: 13.3-inch 4K display, Intel Core i7, 16GB RAM, 512GB SSD", 10, 13, "$"
    hp_spectre_price     db           "Price: PKR 180,000", 10, 13, "$"

    press_key_msg        db           "Press any key to continue...", 10, 13, "$"
    wrongInput           db             10,13, 'Wrong Input$'

; Macros for input and output
PrintMessage macro message
                                      mov          ah, 9
                                      lea          dx, message
                                      int          21h
endm

GetUserInput macro
                                      mov          ah, 1
                                      int          21h
                                      sub          al, '0'
endm

PrintMsgs macro specs, price
                                    PrintMessage specs
                                    PrintMessage price
endm


.code
main PROC
                              mov          ax, @data
                              mov          ds, ax

                            ;Welcome Message
                              PrintMessage welcome_msg
                              call         categories_selection
                              jmp          exit_program

print_headphones_specs proc
                              PrintMsgs   headphones_specs, headphones_price
                              call buyLink
print_headphones_specs endp

print_phone_cases_specs proc
                              PrintMsgs   phone_cases_specs, phone_cases_price
                              call buyLink
print_phone_cases_specs endp

categories_selection proc
                              PrintMsgs select_msg, categories_msg
                              GetUserInput
                              cmp          al, 1
                              je           mobile_selectionLink
                              cmp          al, 2
                              je           laptop_selection
                              cmp          al, 3
                              je           accessory_selection
                              cmp          al, 4
                              je           exit_program
                              jmp          categories_selection
categories_selection endp

print_power_banks_specs proc
                              PrintMsgs   power_banks_specs, power_banks_price
                              call buyLink
print_power_banks_specs endp

print_dell_xps_specs proc
                              PrintMsgs   dell_xps_specs, dell_xps_price
                              call buyLink
print_dell_xps_specs endp


print_headphones_specsLink PROC
    call print_headphones_specs
print_headphones_specsLink ENDP

categories_selectionLink PROC
    call categories_selection
categories_selectionLink ENDP

exit_program proc
                              mov          ah, 4Ch
                              int          21h
exit_program endp

accessory_selection proc
                              PrintMsgs select_msg,accessories_items
                              GetUserInput
                              cmp          al, 1
                              je           print_headphones_specsLink
                              cmp          al, 2
                              je           print_phone_cases_specs
                              cmp          al, 3
                              je           print_power_banks_specs
                              jmp          categories_selection
accessory_selection endp

mobile_selectionLink PROC
    call mobile_selection
mobile_selectionLink ENDP
print_macbook_pro_specs proc
                              PrintMsgs   macbook_pro_specs, macbook_pro_price
                              call buyLink
print_macbook_pro_specs endp
print_hp_spectre_specs proc
                              PrintMsgs   hp_spectre_specs, hp_spectre_price
                              call buyLink
print_hp_spectre_specs endp

laptop_selection proc
                              PrintMsgs select_msg , laptops_items
                              GetUserInput
                              cmp          al, 1
                              je           print_dell_xps_specs
                              cmp          al, 2
                              je           print_macbook_pro_specs
                              cmp          al, 3
                              je           print_hp_spectre_specs
                              jmp          categories_selectionLink
laptop_selection endp

mobile_selection proc
                              PrintMsgs select_msg,mobile_items
                              GetUserInput
                              cmp          al, 1
                              je           samsung
                              cmp          al, 2
                              je           apple
                              cmp          al, 3
                              je           xiaomi
                              jmp          categories_selection
mobile_selection endp


samsung proc
                              PrintMsgs samsung_phones, specs_msg
                              GetUserInput
                              cmp          al, 1
                              je           print_galaxy_s21_specs
                              cmp          al, 2
                              je           print_note_20_specs
                              jmp          mobile_selection
samsung endp

apple proc
                              PrintMsgs apple_phones, specs_msg
                              GetUserInput
                              cmp          al, 1
                              je           print_iphone_12_specs
                              cmp          al, 2
                              je           print_iphone_se_specs
                              jmp          mobile_selection
apple endp

xiaomi proc
                              PrintMsgs xiaomi_phones, specs_msg
                              GetUserInput
                              cmp          al, 1
                              je           print_mi_11_specs
                              cmp          al, 2
                              je           print_redmi_note_10_specs
                              jmp          mobile_selection
xiaomi endp

print_galaxy_s21_specs proc
                              PrintMsgs   galaxy_s21_specs, galaxy_s21_price
                              call buyLink
print_galaxy_s21_specs endp

print_note_20_specs proc
                              PrintMsgs   note_20_specs, note_20_price
                              call buyLink
print_note_20_specs endp

buyLink proc 
        PrintMessage purchase_prompt
        GetUserInput
        cmp          al, 1
        je           inputPurchaseCode
        jmp          categories_selection
buyLink endp

print_iphone_12_specs proc
                              PrintMsgs   iphone_12_specs, iphone_12_price
                              call buyLink

print_iphone_12_specs endp

print_iphone_se_specs proc
                              PrintMsgs   iphone_se_specs, iphone_se_price
                              call buyLink

print_iphone_se_specs endp

print_mi_11_specs proc
                              PrintMsgs   mi_11_specs, mi_11_price
                              call buyLink

print_mi_11_specs endp

print_redmi_note_10_specs proc
                              PrintMsgs   redmi_note_10_specs, redmi_note_10_price
                              call buyLink
print_redmi_note_10_specs endp

inputPurchaseCode PROC
    PrintMessage input_purchase_msg
    mov         si, offset input_chars

        inputPass:       
            mov         ah,1
            int         21h

            cmp         al,13
            je          checkPass

            mov         [si],al
            inc         si
            jmp         inputPass

        checkPass:       
            mov         si, offset input_chars
            mov         di, offset purchase_code

        compareLoop:     
            mov         al, [si]
            mov         bl, [di]
            cmp         al, bl
            jne         wrongPassword
            cmp         al, '$'
            je          passwordVerified
            inc         si
            inc         di
            jmp         compareLoop

        wrongPassword:   
            PrintMessage wrong_purchase_code
            PrintMessage try_again
            GetUserInput
            cmp         al, 1
            je          clearRegistersAndRetry
            jmp         categories_selection

        clearRegistersAndRetry:
            xor         dx, dx
            xor         si, si
            xor         di, di

            jmp         inputPurchaseCode

        passwordVerified:
            PrintMessage correct_purchase_code
            call press_any_key
            call categories_selection
inputPurchaseCode ENDP

press_any_key proc
                              PrintMessage press_key_msg
                              GetUserInput
                              ret
press_any_key endp

main ENDP
 

end main
