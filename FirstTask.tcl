# Задача 1
# ----------------------------------------------------------------------------------------
dict set packs SD 1
dict set packs M 2

proc compareDelimeter {ind data delimeter} {
  return [string compare [string index $data $ind] $delimeter]
}

proc findValueByKey {key} {
  global packs
  foreach {id} [dict keys $packs] {
    if {$id == $key} {
      return [dict get $packs $key]
    }
  }
  return 0
}

#proc isDateUTC {date} {
#  return [catch {clock scan $date -format "%D%M%Y"}]
#}
#
#proc isTimeUTC {time} {
#  return [catch {clock scan $time -format "%H%M%S"}]
#}
#
#proc isDouble {number} {
#  return [string is double $number]
#}
#
#proc isInt {number} {
#  return [string is integer $number]
#}
#
#proc isPole {pole} {
#  return pole == "N" || pole == "E"
#}
#
#proc checkAllParams {date time lat1 lat2 lon1 lon2 speed course height sats} {
#  return isDateUTC $date 
#}

proc firstParsing {package} {
  set fields [split [string trim $package] ";"]
  if {[llength $fields] == 10} {
    set date [lindex $fields 0]
    set time [lindex $fields 1]
    set lat1 [lindex $fields 2]
    set lat2 [lindex $fields 3]
    set lon1 [lindex $fields 4]
    set lon2 [lindex $fields 5]
    set speed [lindex $fields 6]
    set course [lindex $fields 7]
    set height [lindex $fields 8]
    set sats [lindex $fields 9]
    
    puts "Значения первого пакета:"
    puts "date: $date"
    puts "time: $time"
    puts "latitude: $lat1;$lat2"
    puts "longitude: $lon1;$lon2"
    puts "speed: $speed km/h"
    puts "course: $course degrees"
    puts "height: $height meters"
    puts "satellites: $sats\n"
  } else {
    puts "Этот пакет $package не соответствует формату\
    date;time;lat1;lat2;lon1;lon2;speed;course;height;sats\\r\\n"
  }
}

proc secondParsing {package} {
  set message $package
  puts "Сообщение второго пакета:"
  puts "$message\n"
}


proc findTypePackage {data} {
  # Проверяем, что строка начинается с "#"
  set delimeter "#"

  if {[compareDelimeter 0 $data $delimeter] == 0} {
    global packs;  # Глобальная переменная-словарь
    set type "";   # Тип пакета
    
	  for {set i 1} {$i < [string length $data]} {incr i} {
	    if {[compareDelimeter $i $data $delimeter] == 0} {
	      # Если существует такой ключ пакета, то вернуть его номер
	      set value [findValueByKey $type]
	      if {$value} {
	        return $value
	      } else {
	        puts "Неизвестный тип пакета $type!\n"
	        return ""
	      }
	    } else {
	      set type $type[string index $data $i]
	    }
	  }
	} else {
	  puts "Первый элемент не #!\n"
	  return ""
	}
	
	puts "Тип пакета не заканчивается на #!\n"
	return ""
}

set first "#SD#04012011;135515;5544.6025;N;03739.6834;E;35;215;110;7"
set second "#M#груз доставлен"
set lst [list "$first" "$second"]

foreach pack $lst {
  set type_pack [findTypePackage $pack]
  switch $type_pack {
  "1" {
    set data [string range $pack 4 end]
    firstParsing $data
  }
  "2" {
    set data [string range $pack 3 end]
    secondParsing $data
  }
  "default"	{
    puts "Тип не совпал ни с одним пакетом\n"
  }
  }
}
