.model small
.stack 100h

.data
    welcome_msg         db           "Welcome to the Mobile Phone Specifications Viewer!", 10, 13, "$"
    brand_msg           db           "Select a mobile brand:", 0Dh, 13, "$"
    brands              db           10, 13,"1. Samsung", 10, 13, "2. Apple", 10, 13, "3. Xiaomi", 10, 13,"4. Exit", 10, 13,"$"
    samsung_phones      db           10, 13,"1. Galaxy S21", 10, 13, "2. Galaxy Note 20", 10, 13,"0. Back", 10, 13,"$"
    apple_phones        db           10, 13,"3. iPhone 12", 10, 13, "4. iPhone SE", 10, 13,"0. Back", 10, 13,"$"
    xiaomi_phones       db           10, 13,"5. Mi 11", 10, 13,"6. Redmi Note 10", 10, 13,"0. Back", 10, 13,"4. Exit", 10, 13,"$"
    specs_msg           db           "Specifications:", 10, 13, "$"
    galaxy_s21_specs    db           10, 13,"Galaxy S21 Specs: 6.2-inch display, 12GB RAM, 128GB storage", 10, 13, "$"
    note_20_specs       db           10, 13,"Galaxy Note 20 Specs: 6.7-inch display, 8GB RAM, 256GB storage", 10, 13, "$"
    iphone_12_specs     db           10, 13,"iPhone 12 Specs: 6.1-inch display, 4GB RAM, 64GB storage", 10, 13, "$"
    iphone_se_specs     db           10, 13,"iPhone SE Specs: 4.7-inch display, 3GB RAM, 64GB storage", 10, 13, "$"
    mi_11_specs         db           10, 13,"Mi 11 Specs: 6.81-inch display, 8GB RAM, 128GB storage", 10, 13, "$"
    redmi_note_10_specs db           10, 13,"Redmi Note 10 Specs: 6.43-inch display, 6GB RAM, 128GB storage", 10, 13, "$"
    galaxy_s21_price    db           "Price: PKR 150,000", 10, 13, "$"
    note_20_price       db           "Price: PKR 120,000", 10, 13, "$"
    iphone_12_price     db           "Price: PKR 170,000", 10, 13, "$"
    iphone_se_price     db           "Price: PKR 90,000", 10, 13, "$"
    mi_11_price         db           "Price: PKR 100,000", 10, 13, "$"
    redmi_note_10_price db           "Price: PKR 50,000", 10, 13, "$"
    press_key_msg       db           "Press any key to continue...", 10, 13, "$"

PrintMessage macro message
                                     mov ah, 9
                                     lea dx, message
                                     int 21h
endm

GetUserInput macro
                                     mov ah, 1
                                     int 21h
                                     sub al, '0'
endm

PrintSpecs macro specs, price
                                   PrintMessage specs
                                   PrintMessage price
endm

.code
    main:                     
                              mov          ax, @data
                              mov          ds, ax
    
                              call         print_welcome_msg
                              call         brand_selection
    
                              jmp          exit_program

print_welcome_msg proc
                        PrintMessage welcome_msg
print_welcome_msg endp

brand_selection proc
                              call         print_brand_msg
                              call         print_brands
    
                              GetUserInput
    
                              cmp          al, 1
                              je           samsung
                              cmp          al, 2
                              je           apple
                              cmp          al, 3
                              je           xiaomi
                              cmp  al, 4
                              je   exit_program
    
                              jmp          brand_selection
brand_selection endp

exit_program proc
                              mov          ah, 4Ch
                              int          21h
exit_program endp

print_brand_msg proc
                              PrintMessage brand_msg
                              ret
print_brand_msg endp

print_brands proc
                              PrintMessage brands
                              ret
print_brands endp

samsung proc
                              PrintMessage samsung_phones
                              call         select_phone
                              jmp          brand_selection
samsung endp

apple proc
                              PrintMessage apple_phones
                              call         select_phone
                              jmp          brand_selection
apple endp

xiaomi proc
                              PrintMessage xiaomi_phones
                              call         select_phone
                              jmp          brand_selection
xiaomi endp

select_phone proc
                              call         print_specs_msg
                              call         print_specs
                              ret
select_phone endp

print_specs_msg proc
                              PrintMessage specs_msg
                              ret
print_specs_msg endp

print_specs proc
                              GetUserInput
    
                              cmp          al, 1
                              je           print_galaxy_s21_specs
                              cmp          al, 2
                              je           print_note_20_specs
                              cmp          al, 3
                              je           print_iphone_12_specs
                              cmp          al, 4
                              je           print_iphone_se_specs
                              cmp          al, 5
                              je           print_mi_11_specs
                              cmp          al, 6
                              je           print_redmi_note_10_specs

                              ret

print_galaxy_s21_specs proc
                              PrintSpecs   galaxy_s21_specs, galaxy_s21_price
                              call         press_any_key
                              ret
print_galaxy_s21_specs endp

print_note_20_specs proc
                              PrintSpecs   note_20_specs, note_20_price
                              call         press_any_key
                              ret
print_note_20_specs endp

print_iphone_12_specs proc
                              PrintSpecs   iphone_12_specs, iphone_12_price
                              call         press_any_key
                              ret
print_iphone_12_specs endp

print_iphone_se_specs proc
                              PrintSpecs   iphone_se_specs, iphone_se_price
                              call         press_any_key
                              ret
print_iphone_se_specs endp

print_mi_11_specs proc
                              PrintSpecs   mi_11_specs, mi_11_price
                              call         press_any_key
                              ret
print_mi_11_specs endp

print_redmi_note_10_specs proc
                              PrintSpecs   redmi_note_10_specs, redmi_note_10_price
                              call         press_any_key
                              ret
print_redmi_note_10_specs endp


press_any_key proc
                              PrintMessage press_key_msg
                              GetUserInput
                              ret
press_any_key endp



end main
