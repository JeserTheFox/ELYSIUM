//TimSort interface
/proc/sortTim(list/L, cmp = GLOBAL_PROC_REF(cmp_numeric_asc), associative, fromIndex = TRUE, toIndex = FALSE)
	if(L && L.len >= 2)
		fromIndex = fromIndex % L.len
		toIndex = toIndex % (L.len+1)
		if(fromIndex <= 0)
			fromIndex += L.len
		if(toIndex <= 0)
			toIndex += L.len + 1

		sortInstance.L = L
		sortInstance.cmp = cmp
		sortInstance.associative = associative

		sortInstance.timSort(fromIndex, toIndex)

	return L
