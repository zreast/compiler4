loop 10
	$a=$a+1
	$b=$b%2
	show $a
	show $b
	if $b==0
		$s=$s+$a
	endif
end
$z=99999
show $z
show $s
