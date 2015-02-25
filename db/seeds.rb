def v(debug, msg)
  puts msg if debug
end

debug = false
fin   = 'public/input.txt'
begin
  dict = []
  lesson = {}
  # lesson = {number: 1, entities: [{word: 'tight', trans: 'плотный'}]}
  File.open(fin, 'rb:UTF-8').each_line do |l|
    _l = l.chomp
    unless _l =~ /\A\#/ ||
           _l =~ /\A\s+\z/
      # быть похожим [V] resemble [ризЭмбл] The baby resembles his father a great deal.
      if _l =~ /\ABegin\s+Lesson\s+(\d+)\z/
        v(debug, "in Begin branch")
        lesson_num     = $1
        lesson            = {}
        lesson[:number]   = lesson_num
        lesson[:entities] = []
      elsif _l =~ /\A(.+)\s+\[(\w+)\]\s+(.+)\s+\[.*\]\s+(.+)\z/
        v(debug, "in sentence branch")
        translation    = $1
        part_of_speech = $2
        eng_word       = $3
        sentence       = $4
        entity = {}
        entity[:letter]         = eng_word[0].upcase
        entity[:translation]    = translation
        entity[:part_of_speech] = part_of_speech
        entity[:eng_word]       = eng_word
        entity[:sentence]       = sentence
        lesson[:entities] << entity
      #TODO: упростить формат, засунуть в одно предложение и перевод и сентенс
      elsif _l =~ /\AEnd\s+Lesson\s+(\d+)\z/
        v(debug, "in End branch")
        lesson_num = $1
        raise "ERROR: wrong end of lesson #{lesson[:number]}" if lesson_num != lesson[:number]
        dict << lesson
      end
    end
  end
rescue Exception => e
  raise "ERROR: #{e.message}"
  #puts e.backtrace.inspect
  exit
end

Dictionary.delete_all
PartOfSpeech.delete_all
Lesson.delete_all
Letter.delete_all
Entity.delete_all

d = Dictionary.create!
d.letters.create!([{ name: 'A' }, { name: 'B' }, { name: 'C' }, { name: 'D' }, { name: 'E' },
                { name: 'F' }, { name: 'G' }, { name: 'H' }, { name: 'I' }, { name: 'J' },
                { name: 'K' }, { name: 'L' }, { name: 'M' }, { name: 'N' }, { name: 'O' },
                { name: 'P' }, { name: 'Q' }, { name: 'R' }, { name: 'S' }, { name: 'T' },
                { name: 'U' }, { name: 'V' }, { name: 'W' }, { name: 'X' }, { name: 'Y' },
                { name: 'Z' }])
PartOfSpeech.create!([{ name: 'verb', acronym: 'V' },
                      { name: 'noun', acronym: 'N' },
                      { name: 'adjective', acronym: 'ADJ' },
                      { name: 'adverb', acronym: 'ADV' },
                      { name: 'conjunction', acronym: 'CONJ' },
                      { name: 'preposition', acronym: 'PREP' }])
dict.each do |lsn|
  v(debug, "in dict each")
  l = Lesson.create!(number: lsn[:number])
  lsn[:entities].each do |e|
    v(debug, "in entities each")
    e1 = l.entities.new( word: e[:eng_word],
                         sentence: e[:sentence],
                         translation: e[:translation])
    v(debug, "before entity.letter")
    e1.letter = d.letters.find_by(name: e[:letter])
    v(debug, "before entity.part_of_speech")
    e1.part_of_speech = PartOfSpeech.find_by(acronym: e[:part_of_speech])
    v(debug, "before entity.save")
    e1.save!
  end
end