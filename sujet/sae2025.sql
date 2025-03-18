-- Devoir 127
-- Nom: CHER , Prenom: Naick

-- Feuille SAE2.05 Exploitation d'une base de données: Livre Express
-- 
-- Veillez à bien répondre aux emplacements indiqués.
-- Seule la première requête est prise en compte.

-- +-----------------------+--
-- * Question 127156 : 2pts --
-- +-----------------------+--
-- Ecrire une requête qui renvoie les informations suivantes:
--  Quels sont les livres qui ont été commandés le 1er décembre 2024 ?



-- Voici le début de ce que vous devez obtenir.
-- ATTENTION à l'ordre des colonnes et leur nom!
-- +---------------+--------------------------------------------+---------+-----------+-------+
-- | isbn          | titre                                      | nbpages | datepubli | prix  |
-- +---------------+--------------------------------------------+---------+-----------+-------+
-- | etc...
-- = Reponse question 127156.

SELECT DISTINCT L.* FROM LIVRE L NATURAL JOIN 
    DETAILCOMMANDE NATURAL JOIN COMMANDE
    where datecom = str_to_date('01/12/2024','%d/%m/%Y');

-- +-----------------------+--
-- * Question 127202 : 2pts --
-- +-----------------------+--
-- Ecrire une requête qui renvoie les informations suivantes:
--  Quels clients ont commandé des livres de René Goscinny en 2021 ?

-- Voici le début de ce que vous devez obtenir.
-- ATTENTION à l'ordre des colonnes et leur nom!
-- +-------+---------+-----------+-----------------------------+------------+-------------+
-- | idcli | nomcli  | prenomcli | adressecli                  | codepostal | villecli    |
-- +-------+---------+-----------+-----------------------------+------------+-------------+
-- | etc...
-- = Reponse question 127202.

SELECT DISTINCT C.* FROM CLIENT C 
    NATURAL JOIN COMMANDE NATURAL JOIN DETAILCOMMANDE NATURAL JOIN LIVRE
    NATURAL JOIN ECRIRE NATURAL JOIN AUTEUR 
    where nomauteur = 'René Goscinny' and YEAR(datecom) = 2021;

-- +-----------------------+--
-- * Question 127235 : 2pts --
-- +-----------------------+--
-- Ecrire une requête qui renvoie les informations suivantes:
--  Quels sont les livres sans auteur et étant en stock dans au moins un magasin en quantité strictement supérieure à 8 ?

-- Voici le début de ce que vous devez obtenir.
-- ATTENTION à l'ordre des colonnes et leur nom!
-- +---------------+-----------------------------------+-------------------------+-----+
-- | isbn          | titre                             | nommag                  | qte |
-- +---------------+-----------------------------------+-------------------------+-----+
-- | etc...
-- = Reponse question 127235.

SELECT l.isbn,l.titre, m.nommag, p.qte FROM LIVRE l
    NATURAL JOIN POSSEDER p NATURAL JOIN MAGASIN m 
    where qte > 8 and l.isbn not in (select isbn from ECRIRE);

-- +-----------------------+--
-- * Question 127279 : 2pts --
-- +-----------------------+--
-- Ecrire une requête qui renvoie les informations suivantes:
--  Pour chaque magasin, on veut le nombre de clients qui habitent dans la ville de ce magasin (en affichant les 0)

-- Voici le début de ce que vous devez obtenir.
-- ATTENTION à l'ordre des colonnes et leur nom!
-- +-------+-------------------------+-------+
-- | idmag | nommag                  | nbcli |
-- +-------+-------------------------+-------+
-- | etc...
-- = Reponse question 127279.

SELECT idmag, nommag, count(distinct idcli) as nbcli 
    FROM MAGASIN left join CLIENT ON villecli = villemag
    group by idmag,nommag;

-- +-----------------------+--
-- * Question 127291 : 2pts --
-- +-----------------------+--
-- Ecrire une requête qui renvoie les informations suivantes:
--  Pour chaque magasin, on veut la quantité de livres achetés le 15/09/2022 en affichant les 0.

-- Voici le début de ce que vous devez obtenir.
-- ATTENTION à l'ordre des colonnes et leur nom!
-- +-------------------------+------+
-- | nommag                  | nbex |
-- +-------------------------+------+
-- | etc...
-- = Reponse question 127291.

SELECT m.nommag,IFNULL(sum(d.qte),0) as nbex 
    FROM MAGASIN m LEFT JOIN COMMANDE c ON m.idmag = c.idmag
    LEFT JOIN DETAILCOMMANDE d ON d.numcom = c.numcom
    and c.datecom = str_to_date('15/09/2022','%d/%m/%Y')
    group by m.nommag;

-- +-----------------------+--
-- * Question 127314 : 2pts --
-- +-----------------------+--
-- Ecrire une requête qui renvoie les informations suivantes:
--  Instructions d'insertion dans la base de données

-- Voici le début de ce que vous devez obtenir.
-- ATTENTION à l'ordre des colonnes et leur nom!
-- +------------+
-- | insertions |
-- +------------+
-- | etc...
-- = Reponse question 127314.

INSERT INTO LIVRE("9782844273765","SQL pour les nuls",292,2023,33.5);
INSERT INTO AUTEUR(idauteur,nomauteur) values ("OL246259A","Allen G. Taylor");
INSERT INTO AUTEUR(idauteur,nomauteur) values ("OL7670824A","Reinhard Engel");
INSERT INTO ECRIRE("9782844273765","OL246259A");
INSERT INTO ECRIRE("9782844273765","OL7670824A");
INSERT INTO POSSEDER(7,"9782844273765",3);

-- +-----------------------+--
-- * Question 127369 : 2pts --
-- +-----------------------+--
-- Ecrire une requête qui renvoie les informations suivantes:
--  Requête Graphique 1 Nombre de livres vendus par magasin et par an

-- Voici le début de ce que vous devez obtenir.
-- ATTENTION à l'ordre des colonnes et leur nom!
-- +-------------------------+-------+-----+
-- | Magasin                 | Année | qte |
-- +-------------------------+-------+-----+
-- | etc...
-- = Reponse question 127369.

select nommag as Magasin, YEAR(datecom) as Année, SUM(qte)
    FROM MAGASIN m JOIN COMMANDE c on m.idmag = c.idmag NATURAL JOIN DETAILCOMMANDE
    group by nommag, YEAR(datecom);

-- +-----------------------+--
-- * Question 127370 : 2pts --
-- +-----------------------+--
-- Ecrire une requête qui renvoie les informations suivantes:
--  Requête Graphique 2  Chiffre d'affaire par thème en 2024

-- Voici le début de ce que vous devez obtenir.
-- ATTENTION à l'ordre des colonnes et leur nom!
-- +--------------------------------------+---------+
-- | Theme                                | Montant |
-- +--------------------------------------+---------+
-- | etc...
-- = Reponse question 127370.

SELECT nomclass as Theme,(SUM(prixvente*qte)) as Montant 
    FROM COMMANDE NATURAL JOIN DETAILCOMMANDE NATURAL JOIN LIVRE NATURAL JOIN THEMES NATURAL JOIN CLASSIFICATION
    where YEAR(datecom) = 2024

    group by FLOOR(iddewey /100)*100;


-- +-----------------------+--
-- * Question 127381 : 2pts --
-- +-----------------------+--
-- Ecrire une requête qui renvoie les informations suivantes:
--  Requête Graphique 3 Evolution chiffre d'affaire par magasin et par mois en 2024

-- Voici le début de ce que vous devez obtenir.
-- ATTENTION à l'ordre des colonnes et leur nom!
-- +------+-------------------------+---------+
-- | mois | Magasin                 | CA      |
-- +------+-------------------------+---------+
-- | etc...
-- = Reponse question 127381.

SELECT MONTH(datecom) as mois ,nommag as Magasin,(SUM(prixvente*qte)) as CA
    FROM DETAILCOMMANDE NATURAL JOIN COMMANDE NATURAL JOIN MAGASIN
    where YEAR(datecom) = 2024
    group by nommag,mois;

-- +-----------------------+--
-- * Question 127437 : 2pts --
-- +-----------------------+--
-- Ecrire une requête qui renvoie les informations suivantes:
--  Requête Graphique 4 Comparaison ventes en ligne et ventes en magasin

-- Voici le début de ce que vous devez obtenir.
-- ATTENTION à l'ordre des colonnes et leur nom!
-- +-------+------------+---------+
-- | annee | typevente  | montant |
-- +-------+------------+---------+
-- | etc...
-- = Reponse question 127437.

SELECT YEAR(datecom) as annee, enligne as typevente, SUM(prixvente*qte) as montant
    FROM COMMANDE NATURAL JOIN DETAILCOMMANDE
    group by annee, typevente;



-- +-----------------------+--
-- * Question 127471 : 2pts --
-- +-----------------------+--
-- Ecrire une requête qui renvoie les informations suivantes:
--  Requête Graphique 5

-- Voici le début de ce que vous devez obtenir.
-- ATTENTION à l'ordre des colonnes et leur nom!
-- +-------------------+-----------+
-- | Editeur           | nbauteurs |
-- +-------------------+-----------+
-- | etc...
-- = Reponse question 127471.

SELECT nomedit as Editeur, count(idauteur) as nbauteurs 
    FROM EDITEUR NATURAL JOIN EDITER NATURAL JOIN LIVRE NATURAL JOIN ECRIRE NATURAL JOIN AUTEUR
    group by nomedit
    order by nbauteurs DESC
    limit 10; 

-- +-----------------------+--
-- * Question 127516 : 2pts --
-- +-----------------------+--
-- Ecrire une requête qui renvoie les informations suivantes:
--  Requête Graphique 6 Origine des clients ayant acheter des livres de R. Goscinny

-- Voici le début de ce que vous devez obtenir.
-- ATTENTION à l'ordre des colonnes et leur nom!
-- +-------------+-----+
-- | ville       | qte |
-- +-------------+-----+
-- | etc...
-- = Reponse question 127516.

select villecli as ville, sum(qte) as qte 
    FROM CLIENT NATURAL JOIN COMMANDE NATURAL JOIN DETAILCOMMANDE NATURAL JOIN LIVRE
    NATURAL JOIN ECRIRE NATURAL JOIN AUTEUR
    where nomauteur = 'René Goscinny'
    group by ville;

--- +-----------------------+--
-- * Question 127527 : 2pts --
-- +-----------------------+--
-- Ecrire une requÃªte qui renvoie les informations suivantes:
--  RequÃªte Graphique 7 Valeur du stock par magasin
-- Voici le dÃ©but de ce que vous devez obtenir.
-- ATTENTION Ã  l'ordre des colonnes et leur nom!
-- +-------------------------+---------+
-- | Magasin                 | total   |
-- +-------------------------+---------+
-- | etc...
-- = Reponse question 127527.

SELECT nommag AS Magasin, SUM(qte * prix) AS total
FROM MAGASIN
NATURAL JOIN POSSEDER
NATURAL JOIN LIVRE
GROUP BY Magasin;



-- +-----------------------+--
-- * Question 127538 : 2pts --
-- +-----------------------+--
-- Ecrire une requÃªte qui renvoie les informations suivantes:
-- RequÃªte Graphique 8 Statistiques sur l'évolution du chiffre d'affaire total par client 
-- Voici le dÃ©but de ce que vous devez obtenir.
-- ATTENTION Ã  l'ordre des colonnes et leur nom!
-- +-------+---------+---------+---------+
-- | annee | maximum | minimum | moyenne |
-- +-------+---------+---------+---------+
-- | etc...
-- = Reponse question 127538.

select YEAR(datecom) as annee, max(qte*prixvente) as maximum, min(qte*prixvente) as minimum, avg(qte*prixvente) as moyenne
    FROM COMMANDE NATURAL JOIN DETAILCOMMANDE 
    group by annee
    order by annee;

-- +-----------------------+--
-- * Question 127572 : 2pts --
-- +-----------------------+--
-- Ecrire une requÃªte qui renvoie les informations suivantes:
--  RequÃªte PalmarÃ¨s

-- Voici le dÃ©but de ce que vous devez obtenir.
-- ATTENTION Ã  l'ordre des colonnes et leur nom!
-- +-------+-----------------------+-------+
-- | annee | nomauteur             | total |
-- +-------+-----------------------+-------+
-- | etc...
-- = Reponse question 127572.


-- +-----------------------+--
-- * Question 127574 : 2pts --
-- +-----------------------+--
-- Ecrire une requÃªte qui renvoie les informations suivantes:
--  RequÃªte imprimer les commandes en considÃ©rant que l'on veut celles de fÃ©vrier 2020
-- = Reponse question 127574

