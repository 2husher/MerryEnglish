def v(debug, msg)
  puts msg if debug
end

debug = 1
fin   = 'public/input.txt'
begin
  dict = []
  lesson = {}
  # lesson = {number: 1, entities: [{word: 'tight', trans: 'плотный'}]}
  File.open(fin, 'rb:UTF-8').each_line do |l|
    _l = l.chomp
    unless _l =~ /\A\#/ ||
           _l =~ /\A\s+\z/
      # [V] resemble [ризЭмбл] The baby resembles his father a great deal.
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
        entity[:translation]    = translation
        entity[:part_of_speech] = part_of_speech
        entity[:eng_word]       = eng_word
        entity[:sentence]       = sentence
        lesson[:entities] << entity
      #TODO: упростить формат, засунуть в одно предложение и перевод и сентенс
      elsif _l =~ /\AEnd\s+Lesson\s+(\d+)\z/
        v(debug, "in End branch")
        lesson_num = $1
        raise "ERROR: wrong end of lesson" if lesson_num != lesson[:number]
        dict << lesson
      end
    end
  end
rescue Exception => e
  raise "ERROR: #{e.message}"
  #puts e.backtrace.inspect
  exit
end

p dict

Dictionary.delete_all
PartOfSpeech.delete_all
Lesson.delete_all
Entity.delete_all

d = Dictionary.create!
PartOfSpeech.create!([{ name: 'verb', alias: 'V' },
                      { name: 'noun', alias: 'N' },
                      { name: 'adjective', alias: 'ADJ' },
                      { name: 'adverb', alias: 'ADV' }])
dict.each do |lsn|
  l = Lesson.create!(number: lsn[:number])
  lsn[:entities].each do |e|
    e1 = l.entities.new( word: e[:eng_word],
                         sentence: e[:sentence],
                         translation: e[:translation])
    e1.dictionary = d
    e1.part_of_speech = PartOfSpeech.find_by(alias: e[:part_of_speech])
    e1.save!
  end
end