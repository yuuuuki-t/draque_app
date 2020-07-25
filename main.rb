class Brave
attr_reader :name, :offense, :defense
attr_accessor :hp

  # **キーワード引数をハッシュでのみ受け取る
  def initialize(**params)
  @name = params[:name]
  @hp = params[:hp]
  @offense = params[:offense]
  @defense = params[:defense]
  end

  def hp=(hp)
    @hp = hp
  end

  # 勇者クラスをインスタンス化
  brave = Brave.new(name: "テリー", hp: 500, offense: 150, defense: 100)
  brave2 = Brave.new(name: "ビアンカ", hp: 200, offense: 100, defense: 50)
  brave3 = Brave.new(name: "パパス", hp: 1000, offense: 300, defense: 200)

  # 値出力 ヒアドキュメント
  puts <<~TEXT
  NAME:#{brave.name}
  HP:#{brave.hp}
  OFFENSE:#{brave.offense}
  DEFENSE:#{brave.defense}
  TEXT

  # hpにダメージを与える処理
  brave.hp -= 30

  puts "#{brave.name}はダメージを受けた！  残りHPは#{brave.hp}だ"


end
