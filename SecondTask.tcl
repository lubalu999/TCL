# Задача 2
# ----------------------------------------------------------------------------------------
# Предполагается, что данное значение содержит 4 байта, от старшего к младшему: 3, 2, 1, 0
# Биты: 31 30 29 ... 2 1 0
set value 0x5FABFF01; # Шестнадцатеричное число: 5FABFF01
set binary [format "%b" $value]; # Двоичное число: 0101.1111.1010.1011.1111.1111.0000.0001
set binary_number [string repeat "0" [expr {32 - [string length $binary]}]]$binary; # Новое бинарное число с необходимым числом нулей вначале

# Получить значение 2-го байта: от 8 до 15 индекса в массиве
set first [string range $binary_number 8 15]
puts "Первый дополнительный параметр (второй байт): $first"

set size [string length $binary_number]
set bit [string index $binary_number [expr {$size - 1 - 7}]]; # Получить значение 7 бита с конца
set inverted_bit [expr {1 - $bit}]
puts "Второй дополнительный параметр (инвертированный 7-ой бит): $inverted_bit"

set start [expr {$size - 1 - 20}]
set end [expr {$size - 1 - 17}]
set third_number [string range $binary_number $start $end]
set mirror_third [string reverse $third_number]
puts "Третий дополнительный параметр (зеркальные 17-20 биты): $mirror_third"