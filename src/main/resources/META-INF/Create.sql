Use telesul;
Use telesul;
create table Funcionario
(
idFuncionario int PRIMARY KEY auto_increment,
nome varchar(50) not null,
rg varchar(50) not null,
cpf varchar(11) not null,
formacao varchar(100) not null,
dtNascimento date not null,
setor varchar(50) not null
);

create table Certificacao
(
idCertificacao int PRIMARY KEY auto_increment,
nome varchar(50) not null,
empresa varchar(100) not null
);

create table Funcionario_Certificacao
(
id int PRIMARY KEY auto_increment,
idFuncionario int not null,
idCertificacao int  not null
);

ALTER TABLE Funcionario_Certificacao
ADD FOREIGN KEY (idFuncionario)
REFERENCES Funcionario(idFuncionario);

ALTER TABLE Funcionario_Certificacao
ADD FOREIGN KEY (idCertificacao)
REFERENCES Certificacao(idCertificacao);

INSERT INTO certificacao(nome,empresa)
values("Desenvolvimento Web","Sun/Oracle");

INSERT INTO certificacao(nome,empresa)
values("ITIL","Foundation ITIL");

INSERT INTO certificacao(nome,empresa)
values("Microsoft","Microsoft");

INSERT INTO certificacao(nome,empresa)
values("Desenvolvimento de WindowsPhone","Microsoft");

INSERT INTO certificacao(nome,empresa)
values("Desenvolvimento Android","Google");

INSERT INTO certificacao(nome,empresa)
values("IPO Office","Avaya");
INSERT INTO certificacao(nome,empresa)
values("Communication Manager","Avaya");
INSERT INTO certificacao(nome,empresa)
values("Session Manager","Avaya");
INSERT INTO certificacao(nome,empresa)
values("Desenvolvimento Delphi","Delphi");
INSERT INTO certificacao(nome,empresa)
values("Scrum","Scrum XP");
INSERT INTO certificacao(nome,empresa)
values("Gerenciamento de Projetos","PMBK");


INSERT INTO certificacao(nome,empresa)
values("CISSP","ISC");

INSERT INTO certificacao(nome,empresa)
values("Routing eSwitching","Cisco Certified Internetworking Expert");

INSERT INTO certificacao(nome,empresa)
values("VCP-Cloud","VMware");

INSERT INTO certificacao(nome,empresa)
values("Professional Advanced PL/SQL DeveloperCertification","Oracle");

INSERT INTO certificacao(nome,empresa)
values("Mobility+","CompTIA");

INSERT INTO certificacao(nome,empresa)
values("MCITP+","Microsoft");
INSERT INTO certificacao(nome,empresa)
values("MCSE+","Microsoft");

INSERT INTO certificacao(nome,empresa)
values("PMP+","PMI");
INSERT INTO certificacao(nome,empresa)
values("CCNA+","Cisco Certified Network Associate");
INSERT INTO certificacao(nome,empresa)
values("CCIE+","Cisco Certified Network Associate");
INSERT INTO certificacao(nome,empresa)
values("RHCE","Red Hat Enterprise Linus");

Use bdtelesul;
SELECT * FROM funcionario;
