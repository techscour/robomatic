


statements = [
"[John's Status] is a changeology.",
"[John's Location] is a constellation in (John's Status).",
"(John's Location) is comprehensive.",
"[John H] is a changeable in (John's Location).",
"[At Home] is a checkpoint in (John's Location).",
"[At Work] is a checkpoint in (John's Location).",
"[Visiting] is a checkpoint in (John's Location).",
"[Shopping] is a checkpoint in (John's Location).",
"[Elsewhere] is a checkpoint in (John's Location).",
"(John H) is at checkpoint (At Home) in (John's Location).",
"[Home To Work] is a change in (John's Location).",
"(Home To Work) commences at (At Home).",
"(Home To Work) concludes at (At Work).",
"[John Is Awake Or Asleep] is a constellation in (John's Status).",
"(John Is Awake Or Asleep) is comprehensive.",
"[John H] is a changeable in (John Is Awake Or Asleep).",
"[John Is Awake] is a checkpoint in (John Is Awake Or Asleep).",
"[John Is Asleep] is a checkpoint in (John Is Awake Or Asleep).",
"(John H) is at checkpoint (John Is Awake) in (John Is Awake Or Asleep)."
]



def escape(x)
  x = x.gsub("{","\\{").gsub("(","\\(").gsub("[","\\[")
  x.gsub("}","\\}").gsub(")","\\)").gsub("]","\\]")
end

def comber(query,statements)
  regex = nil
  query = query.strip
  replaced = nil
  if query[-1] == '?'
    #puts 22
    query[-1] = '.'
    query = escape(query)
    replaced = '^' + query + '$'
  elsif query.include?('?')
    #puts 33
    query = escape(query)
    replaced = '^' + query.gsub("?",'.+') + '$'
  else
   return 'EMPTY'
  end
  #puts "replace: #{replaced}"
  regex = Regexp.new(replaced) 
  statements.select{|x| regex.match(x)}
end

q = "(John H) is at checkpoint (John Is Awake) in (John Is Awake Or Asleep)?"
puts comber(q,statements)
q = "(John H) is at checkpoint (?) in (John Is Awake Or Asleep)."
puts comber(q,statements)

