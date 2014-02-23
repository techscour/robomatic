def commander(statement,command)
  case command
    when '(John H) is at checkpoint (At Home) in (John Is Awake Or Asleep)!'
      old = comb('(John H) is at checkpoint (?) in (John Is Awake Or Asleep)!')
      statements.delete(old)
      statments << '(John H) is at checkpoint (At Home) in (John Is Awake Or Asleep).'
    when '(John H) is at checkpoint (At Work) in (John Is Awake Or Asleep)!'
      old = comb('(John H) is at checkpoint (?) in (John Is Awake Or Asleep)!')
      statements.delete(old)
      statments << '(John H) is at checkpoint (At Work) in (John Is Awake Or Asleep).'
    when '(John H) is at checkpoint (Visiting) in (John Is Awake Or Asleep)!'
      old = comb('(John H) is at checkpoint (?) in (John Is Awake Or Asleep)!')
      statements.delete(old)
      statments << '(John H) is at checkpoint (Visiting) in (John Is Awake Or Asleep).'
    when '(John H) is at checkpoint (Shopping) in (John Is Awake Or Asleep)!'
      old = comb('(John H) is at checkpoint (?) in (John Is Awake Or Asleep)!')
      statements.delete(old)
      statments << '(John H) is at checkpoint (Shopping) in (John Is Awake Or Asleep).'
    when '(John H) is at checkpoint (Elsewhere) in (John Is Awake Or Asleep)!'
      old = comb('(John H) is at checkpoint (?) in (John Is Awake Or Asleep)!')
      statements.delete(old)
      statments << '(John H) is at checkpoint (Elsewhere) in (John Is Awake Or Asleep).'
    when '(John H) is at checkpoint (John Is Awake) in (John Is Awake Or Asleep)!'
      old = comb('(John H) is at checkpoint (?) in (John Is Awake Or Asleep)!')
      statements.delete(old)
      statments << '(John H) is at checkpoint (John Is Awake) in (John Is Awake Or Asleep).'
    when '(John H) is at checkpoint (John Is Asleep) in (John Is Awake Or Asleep)!'
      old = comb('(John H) is at checkpoint (?) in (John Is Awake Or Asleep)!')
      statements.delete(old)
      statments << '(John H) is at checkpoint (John Is Asleep) in (John Is Awake Or Asleep).'
  end
end
