.model small
.stack 100h

.data
    welcome_msg          db           "Welcome to the Tech Online Store!", 10, 13, "$"
    main_brand_msg       db           "Select a Category:", 10, 13, "$"
    main_brands          db           10, 13,"1. Phones", 10, 13, "2. Laptops", 10, 13, "3. Accessories", 10, 13,"4. Exit", 10, 13,"$"
    input_password       db             'Please Enter Your Purchase Code: $'
    wrongCoupon          db             'Your Entered Purchase code is Wrong !', 10,13,'$'
    inputChars           db             10 dup('$')
    tryAgain             db             'Would you like to retry? (1: Yes, 2: No): ', 10,13,'$'
    password             db             'UBIT$'
    correctPassPrompt    db             'Successfully purchased.', 10,13,'$'
    menuPrompt           db             10,13, 'Choose an Option: $'
    wrongInput           db             10,13, 'Wrong Input$'
    purchase_prompt      db           10,13,"Would you like to purchase this? (1: Yes, 2: No): ", 10, 13, "$"
    brand_msg            db           "Select a brand:", 10, 13, "$"
    
    brands               db           10, 13,"1. Samsung", 10, 13, "2. Apple", 10, 13, "3. Xiaomi", 10, 13,"6. Exit", 10, 13,"$"
    
    samsung_phones       db           10, 13,"1. Galaxy S21", 10, 13, "2. Galaxy Note 20", 10, 13,"0. Back", 10, 13,"$"
    apple_phones         db           10, 13,"1. iPhone 12", 10, 13, "2. iPhone SE", 10, 13,"0. Back", 10, 13,"$"
    xiaomi_phones        db           10, 13,"1. Mi 11", 10, 13,"2. Redmi Note 10", 10, 13,"0. Back", 10, 13,"$"
    accessories_items    db           10, 13,"1. Headphones", 10, 13, "2. Phone Cases", 10, 13, "3. Power Banks", 10, 13,"0. Back", 10, 13,"$"
    laptops_items        db           10, 13,"1. Dell XPS 15", 10, 13, "2. MacBook Pro", 10, 13, "3. HP Spectre x360", 10, 13,"0. Back", 10, 13,"$"
    specs_msg            db           "Specifications:", 10, 13, "$"
    galaxy_s21_specs     db           10, 13,"Galaxy S21 Specs: 6.2-inch display, 12GB RAM, 128GB storage", 10, 13, "$"
    note_20_specs        db           10, 13,"Galaxy Note 20 Specs: 6.7-inch display, 8GB RAM, 256GB storage", 10, 13, "$"
    iphone_12_specs      db           10, 13,"iPhone 12 Specs: 6.1-inch display, 4GB RAM, 64GB storage", 10, 13, "$"
    iphone_se_specs      db           10, 13,"iPhone SE Specs: 4.7-inch display, 3GB RAM, 64GB storage", 10, 13, "$"
    mi_11_specs          db           10, 13,"Mi 11 Specs: 6.81-inch display, 8GB RAM, 128GB storage", 10, 13, "$"
    redmi_note_10_specs  db           10, 13,"Redmi Note 10 Specs: 6.43-inch display, 6GB RAM, 128GB storage", 10, 13, "$"
    galaxy_s21_price     db           "Price: PKR 150,000", 10, 13, "$"
    note_20_price        db           "Price: PKR 120,000", 10, 13, "$"
    iphone_12_price      db           "Price: PKR 170,000", 10, 13, "$"
    iphone_se_price      db           "Price: PKR 90,000", 10, 13, "$"
    mi_11_price          db           "Price: PKR 100,000", 10, 13, "$"
    redmi_note_10_price  db           "Price: PKR 50,000", 10, 13, "$"
    headphones_specs     db           10, 13,"Headphones Specs: Bluetooth, Noise Cancelling, 20-hour battery", 10, 13, "$"
    phone_cases_specs    db           10, 13,"Phone Cases Specs: Compatible with iPhone and Samsung, Shockproof", 10, 13, "$"
    power_banks_specs    db           10, 13,"Power Banks Specs: 20000mAh, Dual USB Ports, LED Flashlight", 10, 13, "$"
    dell_xps_specs       db           10, 13,"Dell XPS 15 Specs: 15.6-inch 4K display, Intel Core i7, 16GB RAM, 512GB SSD", 10, 13, "$"
    macbook_pro_specs    db           10, 13,"MacBook Pro Specs: 13.3-inch Retina display, Apple M1 chip, 8GB RAM, 256GB SSD", 10, 13, "$"
    hp_spectre_specs     db           10, 13,"HP Spectre x360 Specs: 13.3-inch 4K display, Intel Core i7, 16GB RAM, 512GB SSD", 10, 13, "$"
    headphones_price     db           "Price: PKR 5,000", 10, 13, "$"
    phone_cases_price    db           "Price: PKR 2,000", 10, 13, "$"
    power_banks_price    db           "Price: PKR 3,000", 10, 13, "$"
    dell_xps_price       db           "Price: PKR 200,000", 10, 13, "$"
    macbook_pro_price    db           "Price: PKR 250,000", 10, 13, "$"
    hp_spectre_price     db           "Price: PKR 180,000", 10, 13, "$"
    press_key_msg        db           "Press any key to continue...", 10, 13, "$"

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

PrintSpecs macro specs, price
                                    PrintMessage specs
                                    PrintMessage price
endm

.code
main PROC
                              mov          ax, @data
                              mov          ds, ax

                              PrintMessage welcome_msg
                              call         main_brand_selection
                              jmp          exit_program

print_headphones_specs proc
                              PrintSpecs   headphones_specs, headphones_price
                              call buyLink
print_headphones_specs endp

print_phone_cases_specs proc
                              PrintSpecs   phone_cases_specs, phone_cases_price
                              call buyLink
print_phone_cases_specs endp

main_brand_selection proc
                              PrintSpecs main_brand_msg, main_brands
                              GetUserInput
                              cmp          al, 1
                              je           mobile_selectionLink
                              cmp          al, 2
                              je           laptop_selection
                              cmp          al, 3
                              je           accessory_selection
                              cmp          al, 4
                              je           exit_program
                              jmp          main_brand_selection
main_brand_selection endp
print_power_banks_specs proc
                              PrintSpecs   power_banks_specs, power_banks_price
                              call buyLink
print_power_banks_specs endp
print_dell_xps_specs proc
                              PrintSpecs   dell_xps_specs, dell_xps_price
                              call buyLink
print_dell_xps_specs endp


print_headphones_specsLink PROC
    call print_headphones_specs
print_headphones_specsLink ENDP

main_brand_selectionLink PROC
    call main_brand_selection
main_brand_selectionLink ENDP

exit_program proc
                              mov          ah, 4Ch
                              int          21h
exit_program endp

accessory_selection proc
                              PrintSpecs brand_msg,accessories_items
                              GetUserInput
                              cmp          al, 1
                              je           print_headphones_specsLink
                              cmp          al, 2
                              je           print_phone_cases_specs
                              cmp          al, 3
                              je           print_power_banks_specs
                              jmp          main_brand_selection
accessory_selection endp

mobile_selectionLink PROC
    call brand_selection
mobile_selectionLink ENDP
print_macbook_pro_specs proc
                              PrintSpecs   macbook_pro_specs, macbook_pro_price
                              call buyLink
print_macbook_pro_specs endp
print_hp_spectre_specs proc
                              PrintSpecs   hp_spectre_specs, hp_spectre_price
                              call buyLink
print_hp_spectre_specs endp

laptop_selection proc
                              PrintSpecs brand_msg , laptops_items
                              GetUserInput
                              cmp          al, 1
                              je           print_dell_xps_specs
                              cmp          al, 2
                              je           print_macbook_pro_specs
                              cmp          al, 3
                              je           print_hp_spectre_specs
                              jmp          main_brand_selectionLink
laptop_selection endp

brand_selection proc
                              PrintSpecs brand_msg,brands
                              GetUserInput
                              cmp          al, 1
                              je           samsung
                              cmp          al, 2
                              je           apple
                              cmp          al, 3
                              je           xiaomi
                              jmp          main_brand_selection
brand_selection endp


samsung proc
                              PrintSpecs samsung_phones, specs_msg
                              GetUserInput
                              cmp          al, 1
                              je           print_galaxy_s21_specs
                              cmp          al, 2
                              je           print_note_20_specs
                              jmp          brand_selection
samsung endp

apple proc
                              PrintSpecs apple_phones, specs_msg
                              GetUserInput
                              cmp          al, 1
                              je           print_iphone_12_specs
                              cmp          al, 2
                              je           print_iphone_se_specs
                              jmp          brand_selection
apple endp

xiaomi proc
                              PrintSpecs xiaomi_phones, specs_msg
                              GetUserInput
                              cmp          al, 1
                              je           print_mi_11_specs
                              cmp          al, 2
                              je           print_redmi_note_10_specs
                              jmp          brand_selection
xiaomi endp

print_galaxy_s21_specs proc
                              PrintSpecs   galaxy_s21_specs, galaxy_s21_price
                              call buyLink
print_galaxy_s21_specs endp

print_note_20_specs proc
                              PrintSpecs   note_20_specs, note_20_price
                              call buyLink
print_note_20_specs endp

buyLink proc 
        PrintMessage purchase_prompt
        GetUserInput
        cmp          al, 1
        je           inputPassword
        jmp          main_brand_selection
buyLink endp

print_iphone_12_specs proc
                              PrintSpecs   iphone_12_specs, iphone_12_price
                              call buyLink

print_iphone_12_specs endp

print_iphone_se_specs proc
                              PrintSpecs   iphone_se_specs, iphone_se_price
                              call buyLink

print_iphone_se_specs endp

print_mi_11_specs proc
                              PrintSpecs   mi_11_specs, mi_11_price
                              call buyLink

print_mi_11_specs endp

print_redmi_note_10_specs proc
                              PrintSpecs   redmi_note_10_specs, redmi_note_10_price
                              call buyLink
print_redmi_note_10_specs endp

inputPassword PROC
    PrintMessage input_password
    mov         si, offset inputChars

        inputPass:       
            mov         ah,1
            int         21h

            cmp         al,13
            je          checkPass

            mov         [si],al
            inc         si
            jmp         inputPass

        checkPass:       
            mov         si, offset inputChars
            mov         di, offset password

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
            PrintMessage wrongCoupon
            PrintMessage tryAgain
            GetUserInput
            cmp         al, 1
            je          clearRegistersAndRetry

            jmp         main_brand_selection

        clearRegistersAndRetry:
            xor         dx, dx
            xor         si, si
            xor         di, di

            jmp         inputPassword

        passwordVerified:
            PrintMessage correctPassPrompt
            call press_any_key
            call main_brand_selection
inputPassword ENDP

press_any_key proc
                              PrintMessage press_key_msg
                              GetUserInput
                              ret
press_any_key endp

main ENDP
 

end main
