CREATE DATABASE IF NOT EXISTS toy_center;
USE toy_center;

CREATE TABLE IF NOT EXISTS toy_table (
    toy_code INT AUTO_INCREMENT KEY NOT NULL,
    toy_image VARCHAR(255) NOT NULL,
    toy_name VARCHAR(255) NOT NULL,
    toy_brand VARCHAR(255) NOT NULL,
    toy_price DECIMAL(12, 2) NOT NULL,
    toy_description VARCHAR(255) NOT NULL,
    toy_details TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS category_table (
    category_code INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    category_name VARCHAR(255) NOT NULL,
    category_image VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS toy_category (
    toy_code_fk INT NOT NULL,
    category_code_fk INT NOT NULL,
    PRIMARY KEY (toy_code_fk, category_code_fk),
    FOREIGN KEY (toy_code_fk) REFERENCES toy_table(toy_code),
    FOREIGN KEY (category_code_fk) REFERENCES category_table(category_code)
);

CREATE TABLE IF NOT EXISTS user_table (
    user_code INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    user_email VARCHAR(255) NOT NULL,
    user_password VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS toy_log (
    id INT AUTO_INCREMENT PRIMARY KEY,
    toy_code INT,
    toy_image VARCHAR(255),
    toy_name VARCHAR(255),
    toy_brand VARCHAR(255),
    toy_price DECIMAL(12, 2),
    toy_description VARCHAR(255),
    toy_details TEXT,
    operation VARCHAR(10) NOT NULL,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS category_log (
    id INT AUTO_INCREMENT PRIMARY KEY,
    category_code INT,
    category_name VARCHAR(255),
    operation VARCHAR(10) NOT NULL,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS toy_category_log (
    id INT AUTO_INCREMENT PRIMARY KEY,
    toy_code_fk INT,
    category_code_fk INT,
    operation VARCHAR(10) NOT NULL,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS user_log (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_code INT,
    user_name VARCHAR(255),
    user_email VARCHAR(255),
    user_password VARCHAR(255),
    operation VARCHAR(10) NOT NULL,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$

CREATE TRIGGER insert_toy_log AFTER INSERT ON toy_table
FOR EACH ROW
BEGIN
    INSERT INTO toy_log (toy_code, toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details, operation) 
    VALUES (NEW.toy_code, NEW.toy_image, NEW.toy_name, NEW.toy_brand, NEW.toy_price, NEW.toy_description, NEW.toy_details, 'INSERT');
END$$

CREATE TRIGGER insert_category_log AFTER INSERT ON category_table
FOR EACH ROW
BEGIN
    INSERT INTO category_log (category_code, category_name, operation) 
    VALUES (NEW.category_code, NEW.category_name, 'INSERT');
END$$

CREATE TRIGGER insert_toy_category_log AFTER INSERT ON toy_category
FOR EACH ROW
BEGIN
    INSERT INTO toy_category_log (toy_code_fk, category_code_fk, operation) 
    VALUES (NEW.toy_code_fk, NEW.category_code_fk, 'INSERT');
END$$

CREATE TRIGGER insert_user_log AFTER INSERT ON user_table
FOR EACH ROW
BEGIN
    INSERT INTO user_log (user_code, user_name, user_email, user_password, operation) 
    VALUES (NEW.user_code, NEW.user_name, NEW.user_email, NEW.user_password, 'INSERT');
END$$

CREATE TRIGGER update_toy_log AFTER UPDATE ON toy_table
FOR EACH ROW
BEGIN
    INSERT INTO toy_log (toy_code, toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details, operation) 
    VALUES (NEW.toy_code, NEW.toy_image, NEW.toy_name, NEW.toy_brand, NEW.toy_price, NEW.toy_description, NEW.toy_details, 'UPDATE');
END$$

CREATE TRIGGER update_category_log AFTER UPDATE ON category_table
FOR EACH ROW
BEGIN
    INSERT INTO category_log (category_code, category_name, operation) 
    VALUES (NEW.category_code, NEW.category_name, 'UPDATE');
END$$

CREATE TRIGGER update_toy_category_log AFTER UPDATE ON toy_category
FOR EACH ROW
BEGIN
    INSERT INTO toy_category_log (toy_code_fk, category_code_fk, operation) 
    VALUES (NEW.toy_code_fk, NEW.category_code_fk, 'UPDATE');
END$$

CREATE TRIGGER update_user_log AFTER UPDATE ON user_table
FOR EACH ROW
BEGIN
    INSERT INTO user_log (user_code, user_name, user_email, user_password, operation) 
    VALUES (NEW.user_code, NEW.user_name, NEW.user_email, NEW.user_password, 'UPDATE');
END$$

CREATE TRIGGER delete_toy_log AFTER DELETE ON toy_table
FOR EACH ROW
BEGIN
    INSERT INTO toy_log (toy_code, toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details, operation) 
    VALUES (OLD.toy_code, OLD.toy_image, OLD.toy_name, OLD.toy_brand, OLD.toy_price, OLD.toy_description, OLD.toy_details, 'DELETE');
END$$

CREATE TRIGGER delete_category_log AFTER DELETE ON category_table
FOR EACH ROW
BEGIN
    INSERT INTO category_log (category_code, category_name, operation) 
    VALUES (OLD.category_code, OLD.category_name, 'DELETE');
END$$

CREATE TRIGGER delete_toy_category_log AFTER DELETE ON toy_category
FOR EACH ROW
BEGIN
    INSERT INTO toy_category_log (toy_code_fk, category_code_fk, operation) 
    VALUES (OLD.toy_code_fk, OLD.category_code_fk, 'DELETE');
END$$

CREATE TRIGGER delete_user_log AFTER DELETE ON user_table
FOR EACH ROW
BEGIN
    INSERT INTO user_log (user_code, user_name, user_email, user_password, operation) 
    VALUES (OLD.user_code, OLD.user_name, OLD.user_email, OLD.user_password, 'DELETE');
END$$

DELIMITER ;

INSERT INTO category_table (category_name, category_image) VALUES ('Bonecos', 'image/dataBaseImageCategory/boneco.jpg');

INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) 
VALUES 
    ('image/dataBaseImageToy/homemAranha.webp', 'Homem-Aranha', 'Hasbro', 49.99, 'Figura de ação articulada do Homem-Aranha com traje detalhado.', 'Inclui teias, mãos extras e base para exibição, 30cm.'),
    ('image/dataBaseImageToy/pikachu.webp', 'Pikachu', 'Pokémon Company', 129.99, 'Boneco do famoso Pokémon Pikachu.', 'Ideal para decorar a pratilheira do seu quarto, 18cm.'),
    ('image/dataBaseImageToy/vader.webp', 'Darth Vader', 'Hot Toys', 199.99, 'Figura colecionável de Darth Vader, com detalhes impressionantes.', 'Edição limitada com acessórios e base personalizada, 25cm.'),
    ('image/dataBaseImageToy/buzz.jpg', 'Buzz Lightyear', 'Disney', 359.99, 'Boneco articulado do famoso personagem de Toy Story.', 'Com luzes, sons e asas retráteis, 20cm.'),
    ('image/dataBaseImageToy/elza.jpg', 'Elsa', 'Hasbro', 89.99, 'Boneca da princesa Elsa do filme Frozen.', 'Vestido brilhante e cabelo trançado, 20cm.'),
    ('image/dataBaseImageToy/homemdeferro.webp', 'Iron Man', 'Hot Toys', 249.99, 'Figura de ação detalhada do super-herói Homem de Ferro.', 'Edição limitada com acessórios e base personalizada, 25cm.'),
    ('image/dataBaseImageToy/mickey.webp', 'Mickey Mouse', 'Disney', 59.99, 'O boneco do tão famoso Mickey Mouse', 'Desing clássico de suas primeiras versões nos desenhos, 15cm.'),
    ('image/dataBaseImageToy/hulk.webp', 'Hulk', 'Hashbro', 149.99, 'Boneco articulado do gigante verde Hulk.', 'Braços e pernas articulados juntamente com um belo desing, 30cm.'),
    ('image/dataBaseImageToy/woody.jpg', 'Woody', 'Pixar', 434.99, 'Boneco do xerife Woody do famoso filme Toy Story.', 'Com chapéu, lenço e cinto, 20cm.');

INSERT INTO category_table (category_name, category_image) VALUES ('Pelucia', 'image/dataBaseImageCategory/pelucia.png');

INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) 
VALUES 
    ('image/dataBaseImageToy/urso.webp', 'Urso de Pelúcia Marrom', 'Hongyao.', 39.99, 'Urso de pelúcia macio e fofo para abraços aconchegantes.', 'Alta qualidade e desing, Tamanho: 40cm, Material: Pelúcia de alta qualidade.'),
    ('image/dataBaseImageToy/unicornio.webp', 'Unicórnio de Pelúcia Arco-Íris', 'Melissa & Doug', 419.99, 'Unicórnio de pelúcia com cores vibrantes e asas brilhantes.', 'Muito bem colorido, Altura: 35cm, Material: Pelúcia e tecido de poliéster.'),
    ('image/dataBaseImageToy/coelho.webp', 'Coelho de Pelúcia Rosa', 'GUND', 259.99, 'Coelho de pelúcia adorável com laço na orelha.', 'Ótimo desing e cor chamativa, Tamanho: 30cm, Material: Pelúcia felpuda.'),
    ('image/dataBaseImageToy/gato.webp', 'Gatinho de Pelúcia Cinza', 'Disney', 120.99, 'Gatinho de pelúcia macio com olhos brilhantes e nariz bordado.', 'Pelucia com um ótimo material, Altura: 25cm, Material: Pelúcia e algodão.'),
    ('image/dataBaseImageToy/panda.webp', 'Panda de Pelúcia Gigante', 'Ty', 49.99, 'Panda de pelúcia grande e fofinho para abraços apertados.', 'Altura: 70cm, Material: Pelúcia de luxo.'),
    ('image/dataBaseImageToy/elefante.jpg', 'Elefante de Pelúcia Roxo', 'Build-A-Bear', 99.99, 'Elefante de pelúcia com tromba levantada e orelhas grandes.', 'Grande elefante fofo, Tamanho: 50cm, Material: Pelúcia macia.'),
    ('image/dataBaseImageToy/cachorro.webp', 'Cachorro de Pelúcia Dálmata', 'Fofy Toys', 65.99, 'Cachorro de pelúcia com manchas características da raça dálmata.', 'Material excelente e desing chamativo, Tamanho: 35cm, Material: Pelúcia e enchimento de poliéster.'),
    ('image/dataBaseImageToy/leao.webp', 'Leão de Pelúcia Selvagem', 'Jellycat', 54.99, 'Leão de pelúcia com juba majestosa e expressão realista.', 'Material com alta qualidade, Altura: 45cm, Material: Pelúcia e tecido de poliéster.'),
    ('image/dataBaseImageToy/girafa.webp', 'Girafa de Pelúcia Marrom', 'Aurora World', 39.99, 'Girafa de pelúcia com pescoço longo e manchas marrons.', 'Pelucia com belo desing, parece até de verdade! Altura: 30cm, Material: Pelúcia felpuda.'),
    ('image/dataBaseImageToy/coruja.webp', 'Coruja de Pelúcia Fofinha', 'Toyng', 99.99, 'Coruja de pelúcia com olhos grandes e asas macias.', 'Cores chamativas e desing criattivo, Tamanho: 30cm, Material: Pelúcia e algodão.');

INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) VALUES ('image/dataBaseImageToy/JogoDetetive.webp', 'Jogo Detetive', 'Estrela', 100.99, 'Jogo Detetive com App - Estrela', 'Jogo Detetive com App - Estrela! Um jogo de investigação acima de qualquer suspeita! Tudo começou na mansão de um rico industrial, Dr. Pessoa, a vítima do crime. Como um verdadeiro Sherlock, você está lá. Só que além de detetive, você também é um suspeito! Para chegar cada vez mais perto da solução deste mistério, vá entrando com seu peão nos possíveis locais do crime e dando palpites sobre o culpado e arma usada. Tire sua deduções e descubra a cada partida, um novo e emocionante mistério!');
INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) VALUES ('image/dataBaseImageToy/JogoBancoImobiliario.webp', 'Banco Imobiliário', 'Estrela', 120.99, 'Jogo de Tabuleiro - Banco Imobiliário - Estrela', 'O sucesso do Banco Imobiliário agora com realidade aumentada! O jogador poderá interagir e ver seus imóveis se formando no tabuleiro para uma experiência ainda mais completa, com mais diversão nesse clássico jogo clássico da Estrela.');
INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) VALUES ('image/dataBaseImageToy/JogoFrozenTiraVaretas.webp', 'Frozen 2 - Tira Varetas', 'Elka', 75.99, 'Jogo - Disney - Frozen 2 - Tira Varetas - Elka', 'Você está preparado para momentos de grandes emoções? O Jogo - Disney - Frozen 2 - Tira Varetas - Elka é uma brincadeira muito simples, mas muito divertida! É pura emoção! Encaixe as varetas e depois coloque as bolinhas na torre. Gire a roleta para descobrir quantas varetas você deve tirar. Depois remova uma a uma. Quem deixar cair menos bolinhas, é o vencedor!');
INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) VALUES ('image/dataBaseImageToy/JogoCartasPokemon.webp', 'Jogo de Cartas Pokemon', 'Copag', 30.99, 'Jogo de Cartas - Pokémon - Ev04 - Blister Triplo - Copag', 'Descubra as anomalias da Área Zero! Mergulhe nas nuvens e explore uma terra que parece estar desvinculada ao tempo! Com ataques ferozes, Pokémon Ancestrais, como Lua Estrondo ex e Choque Areia ex, aparecem ao lado de Pokémon Futuristas sintéticos, como Valentia Férrea ex e Mãos Férreas ex. Enquanto isso, Garchomp ex, Mewtwo ex e outros podem Terastalizar para ganhar novos tipos, ao mesmo tempo que Armarouge ex, Gholdengo ex e mais Pokémon ex juntam-se à batalha. Muitas aventuras estão à sua espera quando as linhas do tempo colidem na expansão Escarlate e Violeta — Fenda Paradoxal do Pokémon Estampas Ilustradas.');
INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) VALUES ('image/dataBaseImageToy/JogoCaraACara.webp', 'Cara a Cara', 'Estrela', 93.99, 'Jogo Cara a Cara 2018 - Estrela', 'O clássico jogo infantil de perguntas para desvendar o personagem misterioso está ainda mais divertido! Cada jogador seleciona um dos personagens e outro faz perguntas sobre as características. O vencedor é quem adivinhar qual é a cara do seu oponente primeiro. O game é indicado para dois participantes!');
INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) VALUES ('image/dataBaseImageToy/JogoCartasUno.webp', 'Jogo de Cartas UNO', 'Copag', 19.99, 'Jogo de Cartas - UNO - Copag', 'O Jogo de Cartas UNO da Copag é diversão para toda a família. É preciso ser esperto para vencer e atrapalhar os adversários. Livre-se depressa de todas as suas cartas combinando cores e números. Use as cartas de ação para atrapalhar os oponentes. Vence quem conseguir ficar sem cartas primeiro. Mas quando restar uma única carta na mão, não se esqueça de gritar o nome do jogo: UNO!');
INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) VALUES ('image/dataBaseImageToy/JogoPlantaPiranha.webp', 'Planta Piranha - Super Mario', 'Epoch', 154.99, 'Jogo de Tabuleiro - Planta Piranha - Super Mario - Fuga - 2 a 4 Jogadores', 'Super Mario Piranha Plant Escape! é um jogo de tabuleiro emocionante. Siga as instruções nos dados e mova sua figura no tabuleiro. Quem for atacado pela Planta Piranha perde. Duas figuras de personagens do Super Mario e duas placas de personagens estão incluídas. Adequado para idades a partir de quatro anos 2 - 4 pessoas podem jogar ao mesmo tempo. Você pode jogar o Piranha Plant Escape com qualquer uma das figuras dos jogos da LINK SYSTEM (vendidos separadamente)');
INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) VALUES ('image/dataBaseImageToy/JogoGenius.webp', 'Jogo Genius', 'Estrela', 61.99, 'Mini Jogo Genius Para Viagem', 'O clássico jogo dos anos 80 agora com uma versão de bolso! Aceite o desafio e leve para onde quiser. O objetivo do jogo é pensar rápido e conseguir repetir as sequências de som e luz. São 4 níveis de dificuldade, 3 jogos diferentes e 5 maneiras de jogar! É diversão garantida. Especificações: Idade: A partir de 6 anos Contém na Embalagem: 1 mini Genius Composição: Plástico Selo de Segurança do Inmetro: CE-BRI/INNAC00471-32A NM 300/2002 Alimentação: 3 baterias LR44 Funcionalidades e Benefícios: Memória, lógica e raciocínio Interatividade do Produto: Eletrônico Objetivo do Jogo: Conseguir a maior pontuação, acertando as sequências dadas pelo Genius Jogadores: Para 1 jogador ou +');
INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) VALUES ('image/dataBaseImageToy/JogoWar.webp', 'Jogo War', 'Grow', 177.99, 'Jogo War - Edição Especial', 'Jogo War - Edição Especial da Grow! Com War, uma batalha nunca é igual a outra, e cada jogador precisa usar toda sua inteligência, astúcia e muita estratégia para derrotar seus adversários e conquistar territórios e continentes. War Edição Especial traz todo o requinte que o jogo War merece, com miniaturas de soldados e tanques representando os exércitos, tabuleiro maior e embalagem diferenciada. Confira o melhor jogo de estratégia de todos os tempos em uma versão de luxo.');
INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) VALUES ('image/dataBaseImageToy/JogoBloqueio.webp', 'Jogo de Tabuleiro - Bloqueio', 'Grow', 61.99, 'Jogo de Tabuleiro - Bloqueio - Preto - Grow', 'O jogo onde o caminho para a vitória é uma desafiadora mistura entre avanços e barreiras. O jogador deverá escolher entre avançar ou colocar uma barreira para impedir seus adversários. Eles devem criar estratégias únicas, antecipando jogadas e surpreendendo seus oponentes. Cada partida é uma batalha de inteligência! Vence aquele que atravessar o tabuleiro primeiro!');

INSERT INTO category_table (category_name, category_image) VALUES ( 'Jogos de Mesa','image/dataBaseImageCategory/jogosTabuleiro.jpg');

INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) VALUES ('image/dataBaseImageToy/InstumentoMixer.webp', 'Brinquedo DJ Mixer', 'Multikids', 249.90, 'Brinquedo Eletrônico - DJ Mixer - Multikids - Preto', 'Aperte o play e divirta-se com diferentes ritmos e estilos musicais! - Saída de áudio alto-falante externo. - Mixer controlador. - Controle dos ritmos dance beats e Hip-Hop. - Entrada de áudio media player / smartphone. - Controle de batidas por minuto. - Botões de efeito. - Efeitos sonoros e melodias. - Ritmos dance beats e Hip-Hop. - Controle de volume. - Painel de Led 9 teclas separadas. Ideal para 4+ Anos Alimentação: 3 pilhas AA (Inclusas).');
INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) VALUES ('image/dataBaseImageToy/InstrumentoBarbieMicrofone.webp', 'Microfone - Barbie', 'Fun', 81.99, 'Microfone - Barbie - Rockstar - Fun', 'Sempre incrível! O novo microfone da Barbie com MP3 possibilita realizar uma grande performance onde quer que você esteja. Conecte seu celular ou MP3, com o cabo, para tocar suas músicas preferidas e cante junto sem perder o tom. Sua voz e a música soaram pela pequena saída de som que fica na base do microfone. O show fica ainda mais completo com as coloridas luzes de LED que brilham em seu bocal. Funciona com 3 pilhas AAA (não inclusas). Recomendação: 3+');
INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) VALUES ('image/dataBaseImageToy/InstrumentoPianoCachorrinho.webp', 'Piano do Cachorrinho', 'Fisher-Price', 149.99, 'Piano do Cachorrinho - Laugh & Learn - Fisher-Price', 'Com quatro formas de jogar, o Piano do Cachorrinho - Laugh & Learn - Fisher-Price mantém o seu mini-músico ocupado a “compor” e a aprender durante todo o tempo de jogo. Como seu bebê pressiona as teclas do piano iluminado, eles são recompensados com notas de piano real, ou com deliciosos sons de pato, sons de vaca tonta, ou canções lúdicas e frases sobre números, cores e formas! E com um identificador de fácil alcance, você pode levar a diversão musical boba onde quer que você e seu bebê forem');
INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) VALUES ('image/dataBaseImageToy/InstrumentoBarbieBateria.webp', 'Bateria Infantil - Barbie', 'Fun', 141.99, 'Bateria Infantil - Barbie - Dreamtopia - Fun', 'A Bateria Dreantopia Fabulosa contém: 3 tambores, 1 chimbal, 1 par de baquetas, 1 pedestal e vem com suporte para baquetas. Auxilia na coordenação motora e na percepção sonora. Fácil de montar, desmontar e guardar. Vai despertar as habilidades musicais das meninas descoladas, Vem curtir um som! Idade: +3 anos');
INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) VALUES ('image/dataBaseImageToy/InstrumentoPianoMundoBita.webp', 'Piano e Percussão Mundo Bita', 'Fun', 159.99, 'Piano e Percussão Infantil - Mundo Bita - Fun Divirta-se', 'Piano e Percussao Infantil - Mundo Bita - Fun Divirta-se: Impossivel ficar parado com o Meu Primeiro Piano Mundo Bita! Com ele, as criancas vao poder fazer muito mais do que apenas se familiarizarem com as notas musicais. Multifuncoes, as teclas do piano reproduzem os sons dos animais e ainda as musicas mais conhecidas do Bita, como Fazendinha, Fundo do Mar, Dinossauros e muitas outras. Nos coloridos botoes com diferentes formatos, tambem ha a versao de alguns dos principais hits do personagem de bigode laranja em versao instrumental. Os batuques da conga, timbal e bongo fecham esta aula musical com tipos diferentes de percussao, que podem ser explorados a vontade pelos pequenos.');
INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) VALUES ('image/dataBaseImageToy/InstrumentoGuitarraEletrica.webp', 'Guitarra Elétrica - Maria Clara e JP', 'Multikids', 120.99, 'Guitarra Elétrica - Maria Clara e o JP - Multikids', 'Junte-se a Maria Clara e o JP nessa aventura musical e cheia de diversão! A guitarra elétrica Maria Clara e JP é uma super guitarra com diversas melodias, luz e som e botões sonoros para ser um(a) guitarrista de verdade! Com correia ajustável que se adapta ao crescimento das crianças. Estimula o aprendizado musical, desenvolvimento cognitivo, motor e criativo.');
INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) VALUES ('image/dataBaseImageToy/InstrumentoPianoOrquestra.webp', 'Funky o Piano Orquestra', 'Chicco', 307.99, 'Brinquedo Musical - Funky o Piano Orquestra - Chicco', 'Com o Funky, o piano orquestra, as crianças podem descobrir as notas musicais, reconhecer os sons típicos de cada instrumento musical dentro da orquestra e aprender o rítimo das músicas. Um caminho educativo através da música, que vai além dos brinquedos tradicionais! Este piano é um brinquedo evolutivo que segue o crescimento da criança: primeiro, brinque com o piano no chão, depois coloque-o em cima da mesa e continue a brincar até a idade adulta! Possui 2 modos de jogo: 1) Modo orquestra: mova o botão circular e toque em todos os instrumentos musicais na orquestra, um por um ou todos ao mesmo tempo; 2) Modo compositor: ouça as notas musicais e siga as luzes para compor passo a passo todas as melodias.');
INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) VALUES ('image/dataBaseImageToy/InstrumentoConjuntoMusical.webp', 'Conjunto Musical - PJ Masks', 'Candide', 49.99, 'Conjunto Musical - PJ Masks - Kit Musical', 'PJ Masks - Heróis de Pijama é uma série de desenho animada desenvolvida na Europa e transmitida no Brasil pela Disney Junior! Baseada nos livros "Les Pyjamasques" do autor francês Romuald Racioppo, conta a história de de três crianças de 6 anos de idade: Connor, Amaya e Greg. De dia eles são vizinhos, colegas de classe e melhores amigos. Mas à noite eles estão prontos para viver incríveis aventuras como Menino Gato, Corujita e Lagartixo! Veja como esses pequenos corajosos combatem o crime, lutam contra vilões, enquanto aprendem lições valiosas! Juntos, eles são o PJ Masks, e estão prontos para salvar a cidade! O Conjunto Musical - PJ Masks - Kit Musical da Candide é ideal para auxiliar no desenvolvimento da coordenação motora, da audição, da sensibilidade musical e da interação social da molecada!');
INSERT INTO toy_table (toy_image, toy_name, toy_brand, toy_price, toy_description, toy_details) VALUES ('image/dataBaseImageToy/InstrumentoMesaMusical.webp', 'Mesa de atividades Musical', 'Fun', 184.99, 'Mesa de atividades Musical - Mundo Bita - Branca', 'Luz, sons e muita música para desenvolver a visão, audição e estimular coordenação motora do bebê. A Mesa de Atividades Musical Mundo Bita Fun Divirta-se foi desenvolvida especialmente para incentivar os pequenos a explorar os sentidos de forma divertida, por meio das luzes, sons e peças para encaixar, girar e tocar à vontade! Criada para ser 2 em 1, a mesa interativa pode ser pendurada no berço, com suas alças. Ou ser utilizada no chão, pois acompanha pezinhos removíveis, fáceis de acoplar e guardar. O produto requer 2 pilhas AA, não inclusas. Indicado para crianças com mais de 3 anos.');

INSERT INTO category_table (category_name, category_image) VALUES ( 'Instrumentos Musicais','image/dataBaseImageCategory/Instrumentos.png');

INSERT INTO toy_category (toy_code_fk, category_code_fk) 
VALUES 
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(8, 1),
(9, 1),
(10, 2),
(11, 2),
(12, 2),
(13, 2),
(14, 2),
(15, 2),
(16, 2),
(17, 2),
(18, 2),
(19, 3),
(20, 3),
(21, 3),
(22, 3),
(23, 3),
(24, 3),
(25, 3),
(26, 3),
(27, 3),
(28, 3),
(29, 3),
(30, 4),
(31, 4),
(32, 4),
(33, 4),
(34, 4),
(35, 4),
(36, 4),
(37, 4),
(38, 4);

INSERT INTO user_table (user_name, user_email, user_password) 
VALUES ('admin', 'admin@admin', 'admin');

