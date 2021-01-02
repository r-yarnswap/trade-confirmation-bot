%dw 2.0

fun interpolate(s, obj) =
	if (s == null or obj == null) s
	else if (not obj["now"]?) interpolate(s, { (obj), now: now() })
	else interpolate(s, obj, "")

fun interpolate(s, obj, path) =
    if (s == null or obj == null) s else
    obj pluck $$ reduce((key, res=s) ->
        obj[key] match {
            case is Array -> res
            case is Object -> interpolate(res, obj[key], "$(key).")
            else -> do {
                var matchedKeys = res scan ("\{($(path)$(key))([^\}]*)\}" as Regex)
                ---
                matchedKeys reduce ((k,a=res) ->
                    if (k[2] == null or sizeOf(k[2]) < 2) a replace k[0] with obj[key]
                    else a replace k[0] with obj[key] as String {format: k[2][1 to -1]}
                )
            }
        }
    )