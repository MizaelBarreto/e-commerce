/*criação tabela usuário*/
CREATE TABLE tbl_usuario(
	id_usuario serial PRIMARY KEY,
	nome varchar(200) not null,
	senha varchar(50) not null,
	email varchar(50) not null,
	telefone varchar(15) not null,
	endereco_rua varchar(150),
	endereco_bairro varchar(100),
	endereco_num int,
	endereco_cidade varchar(100),
	endereco_estado varchar(30),
	tipo_usuario varchar(15)
);

/*criação tabela produto*/
CREATE TABLE tbl_produto(
	id_produto serial PRIMARY KEY,
	nome varchar(200),
	descricao text,
	excluido boolean,
	preco numeric(10,2),
	data_exclusao timestamp,
	codigovisual varchar(50),
	custo numeric(10,2),
	margem_lucro numeric(10,2),
	icms numeric(10,2),
	imagem varchar(100),
	cor varchar(30),
	categoria varchar(20)
);

/*criação tabela compra*/
CREATE TABLE tbl_compra(
	id_usuario int,
	FOREIGN KEY (id_usuario) REFERENCES tbl_usuario(id_usuario),
	id_compra serial PRIMARY KEY,
	status varchar(20),
	data timestamp
);

/*criação tabela carrinho*/
CREATE TABLE tbl_carrinho(
	id_compra int,
	FOREIGN KEY (id_compra) REFERENCES tbl_compra(id_compra),
	id_produto int,
	FOREIGN KEY (id_produto) REFERENCES tbl_produto(id_produto),
	CONSTRAINT id_carrinho PRIMARY KEY(id_compra, id_produto),
	quantidade int
);

/*criação tabela compra temporária*/
CREATE TABLE tbl_compraTmp(
	id_compra int,
	FOREIGN KEY (id_compra) REFERENCES tbl_compra(id_compra),
	sessao serial,
	CONSTRAINT id_compraTmp PRIMARY KEY(id_compra, sessao)
);

/*inserções de dados*/
INSERT INTO tbl_usuario(nome, senha, email, telefone, endereco_rua, endereco_bairro, endereco_num, endereco_cidade, endereco_estado, tipo_usuario) VALUES ('Pedro', '12345', 'pegauro@gmail.com', '14 99172-3654', 'Hamilton Gusmão', 'Residencial Ourives Pobres', '113', 'Itaquaquecetuba', 'São Paulo', 'Administrador');
INSERT INTO tbl_produto(nome, descricao, excluido, preco, codigovisual, custo, margem_lucro, icms, imagem, cor, categoria) VALUES ('mousePad-Amarelo', 'mouse pad amarelo cor de gema, ideal para os amantes dos minions', false, 5.00, 123332111653747, 2.00, 3.00, 1.50, '200.145.153.91/pedroribeiro/imagemLinda.png', 'amarelo gema', 'info'),
('mousePad-Verde', 'mouse pad verde cor de mato, ideal para os amantes do hulk', false, 5.00, 123332511653747, 2.00, 3.00, 1.50, '200.145.153.91/pedroribeiro/imagemForte.png', 'verde mato', 'info');
INSERT INTO tbl_compra(id_usuario, status, data) VALUES (1,'realizada', '2005-05-13 07:15:31.123456789');
INSERT INTO tbl_carrinho(id_compra, id_produto, quantidade) VALUES (1,1,5),(1,2,6);
INSERT INTO tbl_compraTmp(id_compra, sessao) VALUES (1, DEFAULT);

/*seleções das tabelas inteiras*/
SELECT * FROM tbl_usuario;
SELECT * FROM tbl_produto;
SELECT * FROM tbl_compra;
SELECT * FROM tbl_carrinho;
SELECT * FROM tbl_compraTmp;

/*seleção para mostrar a compra de um usuário*/
SELECT prod.nome AS produto, cmp.status AS status_compra, cmp.data AS data_compra, carr.quantidade AS quantidade_carrinho FROM tbl_usuario AS usu 
INNER JOIN tbl_compra AS cmp ON usu.id_usuario = cmp.id_usuario
INNER JOIN tbl_carrinho AS carr ON carr.id_compra = cmp.id_compra 
INNER JOIN tbl_produto AS prod ON carr.id_produto = prod.id_produto WHERE usu.nome = 'Pedro';