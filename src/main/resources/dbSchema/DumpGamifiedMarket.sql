CREATE DATABASE  IF NOT EXISTS `gamified_market` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `gamified_market`;
-- MySQL dump 10.13  Distrib 8.0.22, for Win64 (x86_64)
--
-- Host: localhost    Database: gamified_market
-- ------------------------------------------------------
-- Server version	8.0.22

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `answer`
--

DROP TABLE IF EXISTS `answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `answer` (
  `id_product` int NOT NULL,
  `id_user` int NOT NULL,
  `id_question` int NOT NULL,
  `answer_text` text NOT NULL,
  UNIQUE KEY `answer_pk` (`id_product`,`id_user`,`id_question`),
  KEY `answer_user_id_user_fk` (`id_user`),
  KEY `answer_question_id_question_fk` (`id_question`),
  CONSTRAINT `answer_product_id_product_fk` FOREIGN KEY (`id_product`) REFERENCES `product` (`id_product`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `answer_question_id_question_fk` FOREIGN KEY (`id_question`) REFERENCES `question` (`id_question`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `answer_user_id_user_fk` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answer`
--

LOCK TABLES `answer` WRITE;
/*!40000 ALTER TABLE `answer` DISABLE KEYS */;
INSERT INTO `answer` VALUES (1,9,1,'male'),(1,9,2,'12'),(1,9,3,'married'),(1,9,4,'dsd'),(1,9,5,'dsd'),(1,9,6,'dsds'),(1,9,7,'yes'),(1,9,8,'yes'),(1,9,9,'sure');
/*!40000 ALTER TABLE `answer` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `add_points` AFTER INSERT ON `answer` FOR EACH ROW begin
        update user
        set user.points = user.points + (select q.points from question as q where q.id_question = new.id_question)
        where user.id_user = new.id_user;
    end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `rm_points` AFTER DELETE ON `answer` FOR EACH ROW begin
        update user
        set user.points = user.points - (select q.points from question as q where q.id_question = old.id_question)
        where user.id_user = old.id_user;
    end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `id_product` int NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `product_image` longblob NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`id_product`),
  UNIQUE KEY `product_date_uindex` (`date`),
  UNIQUE KEY `product_name_uindex` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'Sausage',_binary 'ÿ\Øÿ\à\0JFIF\0\0\0\0\0\0ÿ\Û\0„\0	\Z\Z\Z\Z\Z\Z\Z( \Z% !1!%)+...\Z!383,7(-.+\n\n\n\r/% &/----+---7/-5---+-5-+-/---/.--5---------/---------ÿÀ\0\0\á\0\á\"\0ÿ\Ä\0\0\0\0\0\0\0\0\0\0\0\0\0\0ÿ\Ä\0G\0\0\0\0!1AQaq‘\"¡±ğ2Á\Ñ#BR\ábrñS‚’¢²$34“s³\Ò\âCc\Ãÿ\Ä\0\0\0\0\0\0\0\0\0\0\0\0\0ÿ\Ä\06\0\0\0\0\0\0\0!1AQ\"2aq‘ğ±Á#B¡\Ñ\á3Rrñ4bÿ\Ú\0\0\0?\0E¯³„±\å\Zh\Ñ\Æ\Õ=‡„VHRLÁ„…|*~G›\Õùxğ”÷\ï¤5}”\İ3ŠfÏ˜¥¦Z¾¹c½Xr\Ü9ï¶—–h””)’¤€À(\n4y1@÷6ššD.h®<‡ñh\09-Qõ/\Ã\ëZs\é^±\ÎÙ\è\Ñy”öH*Q^[ºD¤Œ\ÎT#Ó¦~QÊ²¥$\'RS{k–p\Ã|\ì\í¢Ê”ªt°‘08¨5\Â\ä6`\Ñ$‚B½û\å\å¤¤—É½#gŸQ \å\Æ$“\ÜeEJ?©ô±5\0|¾_8‰…Ç¿b%Ù“JšD’x\ì+“·X\Ù@g¥2\Şß±&\ç\ß‘9ÓŒI\' \Õø\ÇIa²Ò±Ìƒ¦b:J˜ÿ\0O\Zƒ\Ò$“¶M3oa£\ï\é\åN|«\ï\Æ5õ‰;:>ƒ”a?3\ï¤t—,\ç\Ş?O~\ÌE!iÊ¾úÄ’H\å\î±\à4\ë\éf\Ú\ÊGxSx\ç‘!s@JRK\ç˜ı\Ú8\ÌRgUK7•kJŠ’•RÀğ5úF\ï\çHq\ìZ¥\â\\Å¹Q À<p¾\ì\ÂL\Â\Âj•x8\Í+#µ„\Ñ\èº-\Ì2d\rµ\Ûqí–‘R\Ü\ájô·GO,\ãYŒ#sH6»d©9‚¡‹ùEU\ä	ğ‹Ojo1(ö2\ØŒ @’Dn4\Ã\É÷\ÂØ¬œVÅ¬\é)g\Ç¡T¾-e¢bÿ\07…Ø·7\Ò>øU\Ç_Ë¶_\ëWùŒdLû€ıc¤d•£üôıˆ‹hš`¶\Æ\\‰µM`%.Y\r›jx>œ<!jòY\ÂZl]òd„¨\0€¥8S\Ö9°ˆµ—õŠÎ€”\ËC\0™7ö‚‰bÁ54¦\â®\Ñ?\'…+\ŞKOÄ°:\ç\Ë2y@\r¯\ÚCnÀ„\âJ ´—lJ\É\Ô4Hõ¯$Ú³\07Kœ›¸D+e¤(h\ê©øI\ZùŒ M¾e	÷¾4‚IwI–¹„Í›)QHI+˜\êNI\Õ\ÔM@Q¤^65›|‘Û¡IK|/ª*’Ô¦‘El\Å\Ù\Û$—ª‰\0r\Ë\Şò\"\È\ØM¢2T$N¢ƒ6\å\r\á³õ¡t\éunf\ÛO±3l\ï6H3%\0\äf¤saTñ\Ó]ğ:õ\Ù\Ó.L™Š[MZ\nğ\ál	\'»‰ËœLr\ÃX»¬vùk\"¾Ó®\ï\Âû\ÂR\n’0Ê…<\\\êôR²¤l-a®Ò®\í\Ş}=\çD3·-}\"2š„\ê=üúˆ\'ffR\ÒR®$+¡¹o‰)8¦”Ä|ˆL±Z}\ÃŞ±))Mn$›7mùõJ	\Ü:\á…ò‡Òœ	ùD“²~GŒp¶[Š¿-(ş\Ú\îºf­D¤(%™‰*\"õ4\Ö\É\Ù4(<\ê‡štõŒM8úM\Ó\rQø[\Æ/&z\Í’O±\Ó\é\ì7Dõ\Ô÷G½ğ\Ñe°J”ñúGtŸ\rñ{:Cƒµ¬c¹%\'\ã8\Ïo!å€\Éd	¼yˆ>±\î:\æ=ò1fmL$\0º	\Ñ*©G\ß\0ö\Â\îe:\\-5\å¨÷¸A‚\çóx±1²ØŠ«8µ6*À‰JŠle+kš÷‰P\Õ\\¼¹Bõ\ã0\ã\ÌC¾\ÚİŠ•7\ZOá®¤\î-”!\ŞyÃ…`\Â\â\'e*\Ö1\ï\ìZÓ†Ğ¡½ı\èù<½eª]¦bT3\Âz€˜0‹±·İ­R\æ„+½ü¤¯\Ç	\'˜nmÅ‡M¡,SD¨ÄºÈ•\Zÿ\0`RõŒyğÊ \é¾ó±\È\Ó\Ğ\é\æ\ÉtŸ~òóf²¥J–¤—Œr¼lFA‰9o\Ì\æ\ÓvQ¢\æ:>:Ê’”Š{ö\ĞJ\Éd™4\Í!DUA\ÅP\×ò\Ä[Š\Ã÷•-!LR—\Z‡4¬\ÙKf	¦\Ë1‚³B²\Ä	@ğ¦»„	ˆ\Åtj\Ù5#„©km ®\ì˜VRX\ÒtVlÇö\Î\ß	ˆ3«ÌŒùˆ²¬A„ô\á8ŒÀO\å@](Ÿ!\ZZWg—*\Ğg)À€\İgğ€w\à\äñ€©üEÙ­k\í´ rei²\×\Ç`¬\'\'¬\\7i²ZPÔ¦h«\0\nO/˜Šš}Æ©\É\íe\Ë	N<\rA`FeË¾›´¤y\"\Ï>B”€¢’\Ä>Df\ìah\İN¼D2pŒú]Èš¡S\Ã\Z”92Œ%ı¡Z\å©r‘*a8B±\' ’\á‹o!\ÇMğ‹f·Z/9MÀ\çMŸC\Ò=k\äLl¢Ó¯Ta&\é\åõúúÄ™“‚e\âo,ú˜…,•\0œò›xD„\İ\Ó&04a©®|3\çzŠ›™D¤\ï\Ù0œ\Ö:!\n[`I\ÏÃŒ³]R¥ŒS)¥{\Åù\ryc±ØœbC³i»Æ½`J˜\Ğ;\"˜»˜¥e¹TO\â;\rÁ¼\Í} Õ‚\î“,U#¯\Ë3\âcµ¢f2íˆ°=\"<ûZRX\rH-\âr\ãŸQÎ¦2§…¦ƒA\rJœ’;¢1\Ó\Ü $«zR1$Ê«\ä\"L›Z‘%Ã»7«×¤S=…Ì¿Bx	=SÀ\Ìù3­€”\Ó\ê`m\ãkÁˆ¤Q:œƒ\ï˜»#~€n{M¬…©’¥0)@JRu\'~‚-›K\ÉĞ¶ò]ñ{Ì“$­ƒ‚\Z„\ëSW8#²–\ã9?Š²/g…†…\Í\é˜\ß,—7\n\í2ñ…>N\njÛˆ\'\á¤¹®©iwN†™\\Ü½=\åp4±\ŞgPª¬\íi”LJ\ÆT¡”B\\ö?\åOœ6N³\É-‹cJ’\İ~q^R\èpù‚\ìu‰S©\ÊcAº@d\ë\âÁ.z\nMq\rñI\íMÊ¹\nT=ÿ\0\Ş.\Ù	\nF,D4\äùV _÷(Ÿ/\nÀPĞQM\ßH+[,\ÃC7Œùø’\ã1÷\Ù\Î\Õ\"t¡dœÅHó#ôóNš‘•D\"\í\Í.B‰lHz(|\à´©\nÄ’\ÄAÎ¢ \Ò	N£Qk|ÿ\0b\ìŸ\ßLÿ\0\Ë/ÿ\0Œ{÷ö®\×ı\ì\ÏóŸ¤{|¹\ä!ÿ\0?ÿ\0£$[BHqM\ãqúDO!Á¬z»Cxoúj õ¶ê“€\ÌJ{³€?)\0Q:Ö§¦\è\"­e¦@<bRmıŸÙ†\ÍıE¹³|ß¤B\Û\Î\Ò\\ùvS…*™\â\"¼SŒ4\İRÌ‰¥KK«r¬8\Ö:Ïº„\É$­ƒÁnK³|,\Ù¿8D1\Ä5C±\Ó\Êd[[\Íl³J•eP.‹D\Ç}ı\ÕL\é\Üó…}¡B\çZ•\"H+Â¢TjÁEœ“§t\'¡†k¦|›%\ß.e­D*D\ÙÉ‘…±,©,\é\Z„…¬Vƒ\\¡OûX²\n,vPRT¢TK—*Q£¨\æ\îczš™\ÍL_¼\è7:úZ]Tş]c…\Ïb³\ÈL´¯»2NTR³rõÍ˜W\æ\íU\à…).\ÉXkP*y´±r\ÈR\Ô8$W0\Éc±•^Iü\ØC‡Î±0ô\êcüBi|>«6c Š–K¶j™“…;\ÕG¦ƒ?(;a\Ù\Ö ©\ÕÏº8°\ÌÁTZ’	k¼}r\'[.uò‚_\í¶‘­</øÍ…–ZPğ‡\ï\'^)I	 zxD;m¹A9õ§¬(ª\ŞLô‚sP(\ÍTÔ¼\Õ\ØS´¶\îKª\\\Ğf,Tbb\Ü	¸‡{\ß\Ó±-“-\"`H]ARˆ,bwqr˜›³¶Ğ©A&ü˜\ÆMì¥¹(p\r´5s\Ï_¾M\ÄŞ™\Ì\Ú\ë\ÈE›ZBÒ¤DCQ\Ã/7\Ò	]÷	 $\Zw@f	¯–m©f^ÒRŒKˆ†j°¡¥2x\ë:\ÜW(¥\Ê\0FiÍŠƒW]\\;\ã1r-´1Ù¿(õ‘f]iAJ°¥\Ø}@\â\Ô\Â\rYP\nA\Æ½Ã‘l)@b\"g\ËŠ\Ğ\Z\Õ\Û\'”OÙ«\ÚGk7·P	wJH`ËŠ\Õ\ÒÕ¥Uµ3\n\Õ%\ìo\Ş)*Ä„²¥¤¹P\n\0œ†€’ôôx`¹¤­2€$Ğ…\n(–918[÷\Ö9[/kLÄ¤•€°ù\ÔW2 ÚŒH)@ Ğ†!#=ÿ\0¶§\Ç\\™M†\Ş3ªoX\Ùe·K–I\\³Œ«BH)–gf ƒ\ã\ÊMZf‚PK¹r\ÊS\Ã(Wº\äöÃ´Rˆ Ò¼º“¬µ^I’‚\0«8\0T˜\Õkf$\r¹Á*Ò³iÚ‘o\Û\ÉRp¥ŠÕ„’XUN9’\Ã2PIüÀ\æ\\Ÿb;Z\Éó;E:A,‘@)ó\Ìk»)?¨Ş¾5¤S£Í”„^ù>L\Å0\"Ÿ½#U \é£;–úÕ¼DAU£¾0fKPŸ\Â\î\ë±\Çx‹=Â™±1¸\ä&.l.b\Í\ãbfhú\ï›Ø…K\ßa%­G²8T\Z‡‹Jğ¹BYYkV\É\Ïd*e\nso¤h*2lfyV \ç*\ì£z:¬d]‚=“õŒ‹ü\Ëó™ü½>_YòôÉ‘`\ÈN -‚\0.3SHı EŠ\ä‘!X\æMLÕ¤ºR\á	q“’\ï\î†;ª\İ6bû\ÆEM	S\à|õ¯L\ØğŠ\â\\V°]‡­”˜~]½/…s0¤¹s—N]`ºm\è\Â¼4&‚Š\r›\Ô\Æ-B² Ÿ\âm\ZTôŒ•÷”’\á)\Ğ\0SNeÜ´\ÑS¨0}Æ°¥\éb—hR1™	dŒÀz©†‚Ÿ=bEš\Å,\0S§”D+œ²J\Ã\n‘ Ô¶±6\Ë0\'»Z\êó”u\ê§”\Äb’•´û\\ış“²e©\Ù,#BÃ¤Q\0€–\ŞÍ™Û–q\Æ\ê@uv\ï\ÆCbT\â£\Ò\åöEe)ÿ\0)\'*\ä~FWei\\6%õüLQ´L¿™q\åœp¼—÷›fı#­â”¦b’•\ÄÔ†\Ë2xˆ1\\S1\ÄÁvŒ0#H6ñ>\r\Ó_P·!Ax².\ãœ?.Ì¥\Z€Û¿§\Ìx]‚º\Ô/”B¦X&\"i+g6ˆ(a\'\nµ1¼CD\ë~&4*4©\ë\Äë°Š€\ÄqË¬H³\Û\ç#3ˆ\r\æ½G\ï­A_³%\Z\ÅZ3\Û\ç*Yd€\ÇJ‘ñ:¼\ë“{K.1pHP.\í\Â N¾Ô°\ÊIx\ÏÑŒFjCP­\'ù~O§HÆ°ßš¦Fğº-j GÀ³\Ö7Q\á??Xeµ€jU\È3õı \ß\Ş\æ³ıÜ„œ”  9¸H#\Ók\é,¸ª`NŸ}9ba¨ô$K%a$\ëS)SK­-\Ë.†\nÙ¥”W%§N,Z\àC¶;b’‚”|[\Í\ß\å%\Î\"N-\î_—(\åc³ ­Lÿ\0U[õƒ;±&`Q\ÂC–l³\Ô11DÈ§*Á*n³H\n›À\ÕÂ·ƒ¡\ç\ïXyŞ “›—\ÌC\rÿ\0d\ìX¤(¥`©$\Ğ\ïÂ¢ùˆ®6¢Ú¥wu\È\Ç/f\æ\Ğ{\éxË³Vô$‰“Øª)¦‘e\\7\ê&œ\Å;u\ÉL\É\è–\ìœICğ	fB—-Blµ\0‘0 -é‰·@f1\ëR\ë|\"T§bu–¥¹!e¥²ßš_q¦cBaVğY•h2¦ƒ…]\ék\Zù¦o„ø%\æ-kR\İ\0€*vÊ„ğ\×\é\íD²^€¤–wf\İ¹¡-JdX^g\ŞG\éWş5}# }R¿\ÏÚ¯?~“Lµ9ûô•Í¦D™Ç³–P&ª‰•GpÜ­\Ã\"iH\çs\Ù\åŒH	Rf%ş$O©c˜\ä`4›b€2\í	8å¨ ¯ó2sù¸f²\ÛSiC­l´Š\ÌO\æ\âx\äğ]ed[ko~¢+®Å”\ÚÂ‰ò\ÔN$)%*\Ä@X!-RR_\êf#$[q4±0~f\ÔSøªñ¥¾Ë†V,hQFeŒß˜…¹“k‰ –.Ï‘\äşG„b”…MLŒ{±¥I!BXS\ÔFŸ\Âô÷†tù†t¹¡RŸ\İ,¡¥—\×_›5y%h\æx\ê36õJ\n.œEd\Â\r\09Ğ¼¥’©ie\Öó½\Å|MLµL²R]*e%@fP \áø@µ[Tf©cN R\ÉÀ0Œ.{\Û\Û\\¢Šr“-c´JIÀ¬_–ƒ	\ÜC1¥)¤m) ?7>ù$S\ÔûşcL³]×«m!` \ÙP\Æ\r\0ˆ\è \Ö<*>¿¤l\0¼\'s3úO¬Eš¯bb±¬É k\ï\Â\"I›\Ú/\'ƒûE€œ3¨±c,”\â;€*W\Î8\ÚnÅ£\ã—1-½\n¢\Øo9¶B°N4Š²5H\Ó2t‡{5\ì-R‚¦ Søp¹	 T³±©Í›p3n\"r¢•¶›Ê†u²\Äı`-¾v\Õ<0\ë;ut¦È¤ª[ªL\ĞJšf“\Õ\ßq\ç{+wvóŒ\Ãğ¤€«Sûz˜!X\Ìvƒ‘˜€±\ßavbT‰?z´\0¹„\r\È :\ÔÃ•·h—\ÂR¤¤U’H`X\éZƒ\ĞÀ[\îj¥¥R\Ü``\ÄcG,38]W*\Âf²Ì•‰Nò\Õñb\î8UZµ&†Bk1¹#\Âh\0™Ï½¦·İ†T\É_y”’”¤<Ä€‡ª‡¨\İÊ«2\Ô&- V¤ú\å6ùS¤\Ù-¥J\"B°²@Àp39p\Í^E{±\ÌN­\Ğ~ñb…U»´œ¦\ã8\ä‹b·¿y)\Ï\"]º±\éÉ°­2‚\ÒJ—Á4bt\ÎF¹\å”V˜ª\Ìq•²h#\'ßº-‚Ú’€	ü\ä$\0\\=j\Ôg\n¯\ß\Â\"‚7›\ãÙ€R»@;imš¹²0%U\0‚\á˜—±NÍ™Ğ€ù,\ï”[Ì¥.\Í4’q©l)A\Şv\Ë,Ió\İŒ=£Á^ó‹P½˜ŸzA*(VU\ã’iJÒ¤ğH\Ï,ª\ãZ“\r:£4™*JL¹…\Ê\Z˜€,FlFCŒ\'J$p§¼¡¯fg\Ñ:š\Zn\âFìµŒŒ#AcLøK\Ñ-aÑˆ\0„¹u;S*\0Â¼\Ä\Ú	H”1gˆ–ÿ\0KµN*Á\0(Ğ‘‘ 0\ï\Zš\ä”\Û0®\èj\à\Óù9ıc:€|\Æ\Ü\"¡{8/\ïcrºG°»\Ø+rúöŒ‹\Î\çˆ6k\ÙK˜LÃˆ«2@\æ2\r›õƒ{8N5„|Oˆ\'{Q@qc\äĞ–n\Ù`ö©hŠ¹3$N\ã\Îâ©€†Ü¾‘37S,m½,˜\ì\à ,¬33„“ÿ\0OdkGnP«kN3“,6\"®…‰mF\èr¼Yxx›:1A!\Ãp \Âôô•\Z\ç\ï6…¸Rm;†£\Ò„‡u\â’MHJ™\é‘Ğˆ}³ªV‰H\n,Ä¥Yœ‰c”-Y,xL²‚òÂ»,\'0X7\éı$\î}4jkÄ¦vC*\àƒ°#\Ï÷û2¥©\Û2IO\å|£e))z“¤y=a °\é\Ö\ËÀ•KR4¦„\ÃÙ•„uÙ›\ŞfW\áó\Ğt‹*É³’\n¹fš üó…\r™.\Ë Pb#\"xC6\Í^*˜´¨¯BN&£“Ck\Æ9M\Ô\Ô\nuûL«-B…†€DO´]˜û¢U:[”QÓ\ÇMHvğ:\ÂU†ğ™&\Ìg¡b\ÊA –JA|µ¢«\×\Úİ¶P±NP*)P7\Õ#^¼\"¯HA»¬á°\nÖ®§mõ0A\n\r¸f´­6v\0ñ´•p_†4K’€µ\â<=\âÆ…8‹xˆ°¶Uvb@3Q-P\ìSˆ\ì3\Ï}[²7jŠ\æ„1\Å-Gæ”’¢Ji«±ö~Ü”\"zD…¦RT\n’i	`\ê5\ÇFbæ‹nŠˆM¦µWU¿[pûÀhV…}\Îbp™kB’ú8s.jı7\ÂöÈ‘Ù£yjõhfûG–UwNPøBÚ»-0£sK)D¥\É	!¨›i\ÖûM\è‹WòûÇ‹M¡’’\0•[@\r]ıÜµ-\rvB±,)%†Â¤®¸Ij\Ğ«3Â¥ŠÈ¹ø°“0™j9€\\(=z`Õ‚\ÅjX2°”¡d(…\î”\Ô\ÔeW\Ü\Ñ\Ê-;‹ù÷4\Ä\0M´\æ\Ô\çö1{¢yÆ–wª\ÈI®¬A	g’\Âl¸\Èr¥«£·\Êı´Z\Ê,¶y\'ó\Ì+`i…a\æ¯(±7†\"Y\0W\Õ\ãB	\Ãm\Ì†µ¼!ùò‘”*\à\ä\ÕcÑ³\ã\Å\î$¡8Y\æ\'`_¼;´Hğ\ÏÀ\Ç%‰v…+\î%A‚\ÎAZ\ã¼\Äû®\ïVD¶\î³\Z©XÑ·‡™°fŒpÙ…\í\Õue§9(\\\Ù\Å(ş\Ò\n·vE\ÈhO„S7\ï\Çr\ß	ùEık›\Ú\Ù-\Â\\¶˜l\ÊN+Ä·£G\Î\ÖYeğ\Ä)IWT† ƒ£mo{ş\ßh¶¥CÓƒkj4…\'ZC5o‘†’aF÷¾$°KoGÍ\r*Ê\Ó{4\Êİ¶ev²¥¨8\ÒZU¼£:Œ4­ke‹t\ÍÖ… bF-HHg:õö–X–\rXgÌšrƒ\×|„ )(–A	bY³\Üu¨&¥\ë¶†[veßºC¶\âş†0\ÈC–;ŸvŠú@\Õ,6;><¾\nŒ‹^kió‚\Ó»?¾E1#¼—¯:kûÀ¨\×³±…œ±2¿”\Ğı|!\ÅUÎ„Dô˜\ÚX³Â•Fù“Ò‘¼›3ô\ßó0dY\ÂFxË‰|½\Ö9Z§¡Io^Mºf\à#¡MVkg”?o\ßAOš3o\ë\Ä\Ù\ÓKN\ïW=\Ù\Ç%]\É\ÖT®€xD°\âgo\ÈAw¤jü 5\Ê;K@z‡n4\Ö\'ß“R@\Ï\Æ!\ì|¼S\Ô¬œ¢\ÔÉ‚¹»\ï«\áŒJ!!”Y@Ï”4\ì}\å@°\ÌdÄ«%\àh\áC›\"rfª] …»€ù!¼x\ÃfÊ ¸\n\Â\é.	\Ş\Ì®Œ„k}c\"…¨›ò‡¾Ó®\Î\Ö\ÆIK¨t\ÍÀpœNf*‹‘S,R€,h›\×t];_7şMF´s\å\Æ*]’Wid)ı%Cˆc\Z½C­¶\Ò†PT¾£\ËO\Ş¹gÌ³\Ì\nÄ¤(Œ`‡=\äN(\Ş ¶¤n\Ë|&\Ñ/?\Ä\ÃMC‰*\Â\ïe,“˜P\Õ\Íl‹)0:Dov½:Cş\Î\\²‚e3÷0šQ\ê;\Ã\Ã]cW\Ä\é\Õ&lp\álNÃºşRW\Ú=‘)¹&§<)IvbN1R7\Åww !(©.\ã–M\ç\Ï\ÚÄ«®Ò/ÿ\0\r~QQ]SA—,\å\İN\\@9\Ç+.ZayLpš¡c\Çù¶ªJ|ggm\Ó\Ò®[`R•1d”¬¸£¬\0–şS\Éø´&X,\ä\Ë7\àN¹w»ŒËšŠ\ê*®{\Ü=‘(±mÇ\ÄJ\ë\í\ŞX(±-ÿ\0½Kü¡[d˜\È ñ\0ú\Ğ\Ó\Ö>\Üd»YVI?0;3bKş˜F\Øù§\Ò4V#M< \Û…Qvˆ´u˜µ»ş>0z\ä¾L\ÉmEöuMj2`SQPxa\'*vI\â[(÷Ò \Ê®•$t4\ä#¾\Ï\Ù\äËœ‘1 ¥c\àˆV¹±¡j8Àxb3w\Ç5À4õF»‰J˜-nF)²œ\ï‘	c£\Ê>tL\âfbQ$•9$Ô’jI:\Ç\ÓX)´>º±\çnót6º\î2-¶™f˜gLùJ‰OúHƒ°›2Áş~ñ&%ºù‡w\Ò\ßi.u¡¦ƒ\È\ZeHaºŠx±=_(v\È¤	‰H\Ä~º\Ú	]ŠP±˜\'Ñ z\çM7\Æ\é¾ò\Ú\Ù\Ô`JWŒ¯³jqPSV\Ş¾N\Ï\Â%[“Œ*Y\0)\ÜU\ÙCw	û!|&ZŠfc	$_”P\'L‡³\rFZ” °3U8\n5^ø\Æ5\É¬c\ëÖ¦V©¿‘€\ë¿\×\ë\Ão\Ü8\'ß„{\ëÿ\0i™t\ë>P›.\ÍK0¤DT¸}K?c\í‚}’[¨ºF#\"ûÙ ¡€h\ãSSòş°ƒökz™s•(\Ó¥\Ã÷†\îaú°¦ ª¤õ4\è)	±R¡\î\ÅJ`™v†v¨\à~q\n\Ók£\Ãtt\Ç*ñö U°\îrËŒqTgk@\â÷—÷¤{±sšĞš°?BÃ¬C¾Mcİ•›†Ğš8:Á¥À”ş0–e¥]¤\ÜD\ï?\Şöf\Ä\êp+\í³€‹²`\Ã0µR\ìõ®\çô\á›;)+.G5\r¹\Íï˜„J	q\ÖkQ6…¶\Î\ÎWbRIs¦QÒ\ß\Ù\èq=?¦b\Ç\Î.ı¥‚S¡#–]=\"‚û;Ö‰ò\ÉrTK\ï©\ÉÁ\ëYb¼;uW¼·\Ò2v2\Ó4%N	g,	\ãŒ1\ØnûJ¼¦ò2F¨’’\Ä8/­\ÔB½¢\Ş4„«ø”ª$8\Í:€ı!\Õ…°K)N%%* \í89°)Kš>qL:5¼c^®‚\Ö\ï¼b\Ú´Í»\æ\ÈQ\ï*II.õ\ÂFl¼+&\Ï\Ïœ´d 0‘\Ä¨¢\ìhQ‘\Şøˆs@4p\ãCÀ\å:^Q\"ó›(÷R¹i93šğ\Ï\Ò\np\Ë\İx¯\Å^ıö`¼	H*Q\àÿ\0\å\ä!«g\'•–Ä…œ@a=Õ¢®\Å\İL\éj\Â}œ%AŠ°‡bX–\Ü@;¼`\íÜ«@™.Ñˆ0Â™ˆ(Âµ:@|US\é½Bµ+ğ\è\ßª\ÚtûY²	\×LÌŠ¥Ls)”GøIŠSd\'´\ÅlI\ë\Â/ûö\ï3\äO’C	²\Ö\0Íœ0nQó•Ì³.z1wYLx¼Œ…bô˜~eidY¦/³!¬n©!–ã–…\Î2– ø†¤=1ˆ@1\Ïs(	T…,)bšÔ»>Z\Ò#É¼\Î$ª©)\î\â\ZÒµ\Ş\Ğ=\È\Ò>=t*7–M¶z¬ı›T;>\'¥)”VlwJ~ô™\é\ç\Êlœ§º¯0–\ã%\×mûÄœ!8P8\ÍJ”H ©f 9\ä\ÚD-ª¹şıa#9\ÒrHø”‘˜\âH-@\Ò\rRV¥\ï¡\Û\Ê#¬]wYLl­¦N\Âc1ş!—\é\'X\×.uT\àdÕ¦\ç…kt‚\áh¢õõr7\Z…xğ0\Éu\ÚM¸8D\ÔQi\É÷+}k¯\r+\Ú\ëùÇœ\ß\\M¼£\r\Ñ5(˜’$¸*`_&\î–Õµg‹\îY˜\ÊrX—	\'<OSF\Şb¶•g(›‡\â\rBÜ³}xE…f´RÒš(·˜\0T\\Ï—\ÜX\Ì]\á\Ükıi\éûG°µÿ\0şnŸ´dgó>>§÷€|£J	i\İX‡iDN\"#MLz¨š‘9R¦%i¡J.+-¹¥¥x\\(+\î±N\ÚQ\rûk+–©d\Õ\ÇòŸ\ß\Ö\Å\ÓÌ¡¹CğUr±^q¹K–O\ÂG`u\ë(€\é\Ë|w \ä<¢4\ëFZŠ!\í¨\Ö&^Y±\Î<¸‡ã£œe\ä¼E±\Ì\Ã5qx¦Gt^¦\ÕA\ï—UñbYE™8ƒ¡Ed;;ŠT¡0_g\ÙƒLy\ê5Ê¢g^jZ\ÆMÓ„»/\0\\k»\\¼}a³\\\ïCzzne‹y\Ê‘‡B–}Ô˜,v¿º\ŞK*\ÈLZK\rµ:G\Ñÿ\0}T\ÉP¢@\0OËˆ—\İVğ1ó&\Öù\É\Ä\Ô\à/|!µ&*²ğ+\Ô\éß“}£Uò¤*zfm§\é\æCy\ÃV\Î\íI’¹h˜£Ù…¸T‚UÍ€7(O²^]´„(\æ(¡¸\êş÷Dy$*n\rúœˆ¿öŒ\é\æÇ„iømO†»K\Ò\î·KP\ÕL3I(\ÂrB±(AC^\0fZ+µ›¯E±\0:I\nfª_\n„Ø›Á(X\ÆY-‘#*–q^\Ì@\Ô\îˆßŠD\Ä*\Î\Î-eCòŒkS\ÔP“C\á­ÔµU÷\Ïô¼)r‡vımözñ”¹š\ê¦\"µ­xxˆ;p\Ş\n˜À\Z0•°\áCºH\r«9z\Ågrœ3…f‚Rÿ\0\ÃQ\é\r6[\nDÔ¤À\"¤Â»²ò1‘QMÉ†R=\"\å?\è\Ë:\ï7ñÙ²¦)\n¢\Ét°,SùT7qFı¤\İw·¬§\àø©m	=ñş`ş\"-k¦J&-¼¼’BjN#E\0?›7\Èò…Ï¶›A2§1d( ğ\n\0Šgšu\ß \Åk\\lw€\âi\0-\Ä{ş`İ¶¥rÀ\ÏE§vò»\ÄµH\Â0‚ô5;ú\å\æ\Ê\Ş}„ğÿ\0\n¨x\Ê,I§Æ\ê\á\â¨\äm<a˜<F`/\á\Üw\éa\"RC„³)L*\àM©g4`˜mU™re$*g|0pœ#6wz\\!\íµ*]B[—\08;\êz\ë¾“}Nœœ)t”¨\Í\Í\É\ë\ÈÅ…E©Lƒ¼•\è\â\Ûq•\æ\Ö\İI•oRQIe\"j_ nV<	¶\Ù\n\0)\Â\ß1\æ\ÔºC\Î\Ñ\Ü\ë™:Î¡,’,\Ë\Âù(‚£…÷÷\àm¦\êJRe\'q$±¯=c3_.Ry“Õ¨@‹¶K\ÆdÚ³(f9‚t‡Í¶MÀ1†g\İ\ìD¶\ã`\Ü[‰©mYÉ†;5œqA¦‘**7ÚZ½W\Şm\Ú\ã¡úÇ±*œzFE2¯)Û™GO\Ò\Ñ1ÁJñ\nh¤³¤ñ\0…SE‚¤jÂ‡:8}GQ¾;&nÌ–\å±!is®@¶UJ˜ò£&O%‚ß«¿ûGHx‡,l”FaªF\êŒ\Ç8\ï²÷Ÿİ­(_\å.•>\ãô,| –,I´~d…xƒü¡jrkGLê’„-‹E©e\ê\Ï\ïH>¥š¦=¹m}´‰j\ÍL\Êr\Å<óñmŠ N[²…¡r›G³À´°5ğ+Qo\0ğ!t0e- 54k\Ë\"ç˜ ”©A\ÒP\0 T\ä¾_´4\İ2\ÒõöúÂ¾\ËZV¹2Ò–sœş°r\ìTÑ„®…+U‹”–a™Ö¾	+¨\Ìo¥£\Ê,JXG+ºYT‰‰* 	 U³C\Änq@\íµœ&Ô¬90õ9ñ¡\îôwHHKœ\İ\ÄQ[e(ª\Ù2™%/\rC‘¾•¨<>ğ\Zıjo\â\"õ\×m2UZ¤\ÑC†ø-h™…NC…ox>CDË¦\Ğ>€”\è¬ğğ\â=!•E® \Øz\å:‡h\å`¼Œ°™™3rWc¯\Ñ\àè´•²WŠd\Ô$¤•0N…C¨\ë«A÷\Â\\\ÉSœ2\Ù`†$-),\î3 4\Ô\à„õ)\ÔVCw™I”’\ÎHp\Ãs\Öº”*Nü!o\\-E\Ëİ©\ã¯Evv\é\İ\æï³¶Yf<¡¦\Ãy\á†’ˆ–`jıê°£¹f -s®\å-EG2\\œ\É:\Äû©¨P£\Ñıh\Ñz 2\Ê\Ó:±\ßõ—u÷…J\Ò\ÊF)‹\â8Niw\0´f\ÜÚ¦.Ä‰K-\ÔUR\0‚\\w#¤,\Ù\î\Õ\ãRªE’SNU#ƒ\è \Ä\ÙC¼Işc—!0&\Î\ÙÁ¸•Íª\ÈR}ˆg\Ù[ö’ş!şªú\ë\íWBMjx€\Â!›”‡Œn\Õ\Ö\Æ´\Ù\Z\â9Y¬\êpe¤|GŠˆ$’Bi@\ä˜3f»Ò§YWfU\ZH\Ï<ƒ\Ì\'\İRg$ŠšV \ïœ·Ë›==š\Öp\ê<t\ë\Ö\0z@µ\ïZ\Î\ÂX³-\Ò&YP¹jI;2X³€\Ü@\ŞĞ§xY@f%†$÷Æ˜İ¨w\ÓÆœb\ÇwªPlN€–Ÿ!M&Mu\æ}\å\Ê9S®\×0\Ã]®Óœ´k\æ\\yfbL¿\Ó!\ç8ıc”ûje‡$¼˜\î¦i\'\ïü1ûI+û\Ä\ÆE²´’ŸI\í’5\'Á\Ô>cÀFó\ÒÁÿ\0öaÿ\0TÁò·u­V‰R”Ÿ\åP§¬t¶#ğwZX\ä™õ‡$\ë¤\Ù2\È\\ôÒ’ü„¬_([´o³£ñ\çÄ›:ÛŸİ—ô…yˆzÅÊ´)±¶ò¥\Ì1b‡\Ë\Òg¤\è!\Ç?²š•ş“å¯”X\Ëe$\äE8ô±\Í~pü+fL¼¢ı¾\ËN0l¶0\Ók“\0­’k”v›J\ÕXÅ±—Š%¤bPHJªN—¬;ƒ0¯º—vP_\Ëub¢°\Ï2\ÕP\é!”7Qp\ì\í-hHŒ&\Ò\ÆQüĞ¬%{F;¡K§aG«\äx5)”V\Ûf¼VœH!+\ïP{\ÃQ\\´x²¯\ÚL¹d•Éœ˜«\r€®dÉ‹#¼¢@™\É5l\ÍY\àl2e$¶\ÂiP–[¤d²\"|\Æ S\âHÁ\á¼\ÇNr­*Â„2]±jü·Fòl!6„\à\r\İ$ñ>p\Ïh°¤\Ê%°) Ö f*š¿½j¥´I\\b ¾\êJ2\î\Õ\Ü\ë–pFu˜hh§±-J3°HQ|\"¬J@P£\Ö7MœxFj¶f„á°ŒX;Á_sÕ¢T›98e\ï(\ì‰d3\å\Ò6,c@¢y&@M\0\Şÿ\0\Ş:}\İ\ê\Şüsğ\ŞD€*w!õğ\×\ÇVŒóN\ÚA\'\Ğ~ş‘¸±‚\Ù6÷ùÿ\0X!\ÙS‡¿t0È¯ÿ\0¤r\ä\Éi\Â\\”\ä+ÀS\ß(™.H\á\Èi­—¬‰ \ãZSÀ—=>°»ym¡øeK,rR¨€¤h”]öQ´cº–\rz}`%¿jlò©Œ¹5\êb¾·Ş³\æ\ÅZˆ\áA%KIQP\ÈÁiş\ã|p‘­ûg5OÙ¤$o50³z[\æ,µ’M“\áÎš°\Z\ÛjsM2\ç%M„\rñs&vR·ò;ÿ\0\ÃG\ê1\ìNa_ñ•ù	>\ç\ï\Ú%L\ZÉ¯‚’=­2\åW¿\ïÿ\0U2«­2mxPaQj\Ñ\Ô\Ó\Ò\'ÿ\0gŠ¥	`ŠO3I \ÔvŠ[sb\Ş™:Á€‹3%´\é£Q*_¢¡lˆ±-\×:¥®t\ÒC)	fÏº’\îüwiX)\ZR\ÚgR\n´&6N\Ø&IÀj¤w|?/\Ó\Â­H‰{1l\ìç¢û§\äzúÄ¬¹’i†|®#¤\Ù.ş‚Zl¯\ï\Ê©#Xò]•\ë\0´fÉ›H¸›´=D±YT“\Ü<‹zAAf\ìÄ±*™g\ï(«T¼‹H	\nL‚K¨’wš\Ä\ÔK|©\ë\Ë@\ZGptŠ1š(-W`Q\n•”yn‚)))R‰Ü²A¨²¦\\côò“n¶ò­Eİ„ò\\\0h\ï\Ùu\ßôö#¤¹GH\ÜJ\ß\ïß„T\Í@šI’3jõı½c°0<sıº1T´¤:ˆ‰a\ç\í›W!\n	š­\È\ËüÆ\"*3\ç•GX\Ú0\ï©\è+mV\ÄKK­A#øˆP…x\í}¡e´EO‰ú4´Y\æL!KQ[šw‚\é\à˜ö´¾5gX÷n\Û9I¤°VxPu\Î\í›Aiš\ãO<\ÌB³\Ùp€\rO½ü\ã°@=½`´\ÃS^\Ô\Å\Ôn6ğ™c³‚{\Îxšû\Ï\Î0#£4\æ‹W!\ït`˜oM%Y9¥5òFú8›\Í\ív”a¡e\0\ÄF•\×M›¶^\äƒV\Ô\Ä\ÖD\ä‡\\µ„\ï)>¹Aİ”a->>±†\"¦ZwX\×\áxAS–¨\Ğ\Ø\Ç-Ÿ¸\Õ! \Ã\ç¶\×c%\0 U,- ’´š¥ƒ²°\Ôòmt†Œ¼D¹•È‚ må³ˆ•9S&-3S4(Ğ¨a˜IÈº€\0\çBNT…”N™\îo\ãZ¦~‰Te\ĞX´Jÿ\0„NıRúŸ¤y½ª¿QòúFG~gºiòx¯\ï÷\éYö¢TûJ&„62\ï\r¡5\ày\Ò,\Ë\Z@RjÑ¸G\Ï6t\Ô’©\×/6‹Ÿa\í\ê]™.\\ƒ…\ÎnøI;ª3u¶³\Ì+^u\Û9\Ò\ä\Ù\ç(-\nB\à’¥%˜\èˆ\îˆz„#´7¡µZ5û¤²\ä\İ\ÎgyQ\ïH\ÕV\Âd\Ís#OKÀéŒ˜˜hDZpK\Z\ã´	’P±REt¨¡‚Yn!7a­\ä\Ê\âO¡ùC–æ»\Ò\ÖL®DyAó 3wGI`šû\ëa\å¦_^1…\æ\Ùg¡&7Ll\Ùùı#ª\ß*Hu¬\'™¯‚s1\Ë\ßi\Û©\å¢%IH\Ş\í¦pn\Û$\å)_Äª\n\Ù{Z\'\ÑSò¦ƒ \×\rQ·\ÒøºI¶¾Á¼¶’D¯‰`‘ùSS\å6ı´˜·S„o5=!r]$Ë•¦}`51\Õ³¤\çh6iy‹R¹št\Öyl\Çv½tJ\0÷\ï„n\r …‹™¼\Ô%lrVJ\Üi›h¯\ë\ZÉ–{\ã£Gg\'_”i<1i¯q§iG\ë\ëm“\èbI53Š”~\ÛtY\0\0D¹\æ<÷\à}D>\Ø&³{Õ½D.\Ç\ØOSğ*H)3şm¼£m\á³\éE—µQ\î‘^P‘a¹\Â\É6e…&\ÖWu’\ï\0S˜\É\âÌ»\ï¹S,\ÆD\êh­¶®JeÊ›Ù¨„€hô<Á¡ T*;\Û\ÖFù¢K[F\ã\ÆP™$bŸ¨U=cY×¨‰w ®¦6r\Õo˜?b\\±šğ!)¦Ÿ{”\Z¿o¹²d%i“(©J \ÏL Ÿ…¨\Ã\'~\0Æ­…\í}fkñ’iİ©\Üó\á\ï\Î{ÿ\0™ı\Ä\ïüjúFB_öŠ\Õıòº\'\éü—‡¯ñÿ\0œ\Äwz2?ÿ\0‘\Ì=DZûÿ\0A_ú“?÷&G±U]„ONV²²\éQ‘‘¬\Êq1\n\ÕvL\Ùû¤rWûLXR5\å\0bû~Q¶±\ç%\Ç!SŸˆc 	\ìÿ\0‹\Â+K\ëşºÿ\0›\ë`»Pˆö\ç/\é“Ÿ½\Â=Œ†q4•/?{Œmô‚22$\ì\î|>Q‰\Ì\ÆFD’zcY¹(\ÈÈ’H¿ü¾B!\Şyû\İI\â\Îş‰ÿ\0İ—\Öl\Óü©ôŒŒ€1“\Ğü¶|!yPl\í\×\áş\á°ÿ\0\Õ\";\ÅB§øŸ¡…ıŒIù\Çı¡\æ¿ö¦227ü\Şqnşÿ\0#ô•Lddd;Vÿ\Ù','2021-02-07'),(2,'Potatoes',_binary 'ÿ\Øÿ\à\0JFIF\0\0\0\0\0\0ÿ\Û\0„\0	 \Z\Z\Z\Z( %!1!%)+...383-7(-.+\n\n\n\r-% %+-2/-7--//--/----//------/------------------------ÿÀ\0\0¨,\"\0ÿ\Ä\0\0\0\0\0\0\0\0\0\0\0\0\0\0ÿ\Ä\0<\0\0\0\0!1AQa\"q‘2¡±ÁğB\Ñ\á#Rñb$3r‚’¢²ÿ\Ä\0\Z\0\0\0\0\0\0\0\0\0\0\0\0\0ÿ\Ä\01\0\0\0\0\0\0!1A\"Qa#2q‘¡±\áğñRÁ\ÑBÿ\Ú\0\0\0?\0-‹\ÅU™úñ\nİ¯\Åé§>MÉ´\Å\Ï\0Q\ÏG~¡-\í?\àG\Ğ\ÒZ\ĞLÙ¼\íCI\ÌH\n[j\É\å\Í:\Ù$NöòŠN‡L\Å\ëS1?¥_H}É±²e\ËJ®ñƒ2Eh(<\Ú7\ÙW<™”+c°aB’¥L*f\0B\íJ\Ã¹\Ë$SH«¤ß£s÷“æƒ¢ZeõQs\ì,bª²’2j”\Õ\Ò\0Hv,\ÄjBö\\Š{×§r9“\ãHO‰JH(õ…>\Û\ÏÔ¡-¡>7¥TAL4g8tÊ”T”†I\n.,nA;\î! \á¦MYZ\İ\ç(¹5U\ác\è\Ş\ÑOY[&\î\å0s\Êi¸yI!\Øù\Ìyš% x–	I.\Ş\Şq\êL³&J3>”ô„œl\å…*\é$8ŞµwqHÎ¦ƒk#¯v\Èix“ˆ:uiI%\êÿ\0Q1Rª™¥\Ú\Ëf~‡ˆƒ³˜Jòª\0\ZF\ç˜ó\Úl9\07$ı«¦+´V:‹0.\ï2¼\ÌMPhw	xœX’\Äÿ\0crlyGö\ÊJÁ\Ø\rø†|E+J–¿§Q±¯<C¯z\Ô9Š\n™ ¿N’hõ‹²°\Z”Z‰—¸\ër\ÉA?\n\n€µöµ¶‹“ò\àH)R—v<\î+±…R¹\æ\ÒD“ML©\ß\ÛHF¯Š´?±‡\Ì>`8;õ\"²\Ô(­Z‚\ß\âúWÕ \æ*jŠeƒ,^-Ú’®ù\Ï3–\äfe\É]¢ÃšÖ¬“CN†\â:n9\ĞúTŠb¼\Î\Å(L\ï¢,(mjQ\îc\Üüd\ÇiÁø\Óõ¬\Å\\€\'TXò\ÑG<É£\êM\É&Õ°\è\ÑW!\ÍÁ\Å$]ö;\Ú,ç•\Æ(”§OR\æ£\Ú`ò<Nz»•»V•\ZÒ¦C–2\Ía\08š\Ñ@˜•\n„ü­\0q³T—JVR§\á\è\r}c\ÆM\ÚF•øV(\Ê\ã÷h#)(*(*\İ\Åúú~Ñ\Õ\áòcUÙ*\åyŠg¤T#Q´[„Vµ©dùI3\Ğş1kp~‘&wR&jÒ*va\çQw\á$=¥Sq—\íd…5Ú¾§ÚœY\îŠUPI	o6sœ%m-,¥,3@c\É5¤\Æd\ÓñS‘,	«›\0ÎªU\Ì1§«qv \0q\ÔÙœ0¨iIL³]J n@ß¤iÒ²\â\0¨‹«\Úd’W(÷Rô®X$%uqFohcÀeªQñ›\Z]ı`z\Ë=[0\0\Ç\ÒN”b½\Í\'“„KP×˜‹ƒ\\º$\ßh·.c)ATm\é_\ÃRR«<o…bySô‹¦\\\Ë0s\×\åõŠ“q (\Ë).?V\Ğ0Êµ£\ÂJN\ÊMÇ¬ÿ\0©^\éz6ª9\å\ÃGl\0r!\Ò\Õ=Áx‰Xe\0¢\Î(\í\ì`f3”x@%\Ã\ëq\á/f†1”‹M=GŸ—0™\Ú5¢\\\â,h@yÁ\é\Î\Ó*\ÛHŒLr‹e¾±yX‡\ß\é\Æ´\nD\ÂIt½¨ ª{D\áÀ¦±6\èlˆªÚ¯œKS¤b\'\í ³\ĞıÈ¼X\Èû:TµLñ\é4 ¯Ö\Ù>h--l\àY*-c½  Á\"ZS¬$\Ì\Ü\ìğ\ê¾\Ïj‰\Åò\Ñg/\ì–\Z]¢\ê$‡­\é\Æ\âğø4¡„\Û\á§‚,\Í–…Yü57;_©‰ú¦X£W\í{Xşc-=¢|À¶6{ôR\ËLc°;Q\éXû6be?«=:À,\ß5\\¤-l\n\ÂAbKµz@qûœo\Ò\íf1SgI\Ã$¾¥ñ¸ß­«3°$K‰Ø‚òr\ç\æY©$ÿ\0ü˜\Ğ&a&¯¼ ’u$úZ\àh-Õ² ù÷*-±\â*v¯eL*6!ºz(Zˆ´‚\ÌTZ¿§Ï§œ6gòeÍ“­ªƒX\Ï32’úi\åjo\Ò*\Ø<ƒ-v\åşQ½y—u*\áL*ÀT\í§cÔ°cOM\ïh¯—8–IU@w<pzÁN\Ï\È\ïV¥„¹C6ş#fØ\Ï*µ\äq\æ@\à3\æ\0©3IÒ£³\n?\Ğ\Ç\Ì\ç1JRŒÚ­O/¬2a{?4©\Ô,]€©>f\Ç\ës0MkRıL\0\\\î#0…W‹8 —:W_zú\Ã•¨T@\İÈ¯˜j{Ç„ö5?5\è\Z	M\Ë\n¥\éÕ¤µGPı\ŞN_¸;YJñ3|:‚I•1©Ó¸Ş£§g³\É\ÙJ—½\É~A\Ş\Î\ÉS)U$Â–Z¥#´\n¤WAµ\Ô¨ÁÀVªN1\ÜÕ°“eOBUATÕqc\Ï-&\á\æi!DºŸ‡°\ë\ç\n=š\Ã	“JŠX Ø·\Äxk\09«”¨·¼	€ó!\Ğ\Öp¼È¥K«¼«Ö‘&\"C§\Â\04\Ù\èñ\"R\åù‰[xŠ\ë¸c˜/! ·\"{^Ÿ\éÔ…{¥~—,“\åf0\é˜-’¥5@4\æ;e<\ÌÂ”)ZˆHS¤4RHsg½ \ÕS\îÁ\êJ\ÜV]Ë³ô?—İ­cñ’W,\Ë!’\Å\Ç¯K‡ŒN*b\r	h½+9F¦?g\ÙS5@DrVg‡\Ã\êRS\ÔÕ¼\â\Ïb¥¯5X‰‚‡ûi­\0?®å‡¤%*”\\º\å£I\È©2P\É#Ju+ÀY\éC¹>U¤QW¢œr\Ç\Ï\Òulõ€!\à%j	\0\06\å\ä\ÈPH7&\ìw1ç¹”Á3½JüJ\'C`\èn<\àÿ\0f³\á¤\"bš®…šR´Uª\í\ËB‡HÊ»¡š\ìñ\Z¦\á@„š9P}øxW\Í{R™S\Â4¨ip¥6•±†\ÉXú¡û\æ;E“’W1E*S€O\0\0‘j½,û Y\ÇgZdwˆ;8S\Ğz€\Å\ÙŠ”™di \İZ€\ã’ûB,\ÎI•$‘İ¬ü&€0s\â±wƒ¨\ì\ä°ÁKu\"[E\\%\êis\ÄY \É2n8\Ìñ\'\ÃZ\ÛğF+\â\×2zÔ‘¨Bÿ\0”‡lóp²U,¨¨—b¢\ä“ko¼!©fZB˜6\ï\r}ŸW,ÿ\0°‘©r  \îTO\ÃeÈšÂ‰:€~µ\Ú<\å†v\"`JÁ\êZ‚?\êdP,(\n–õ\å\Õj–¢\È\ÓRöz„ñ¹\çˆjm@W\Èò‚s’TV\\QEÀ4o8A\Ípó\Ô\ÇU‹€\î\Ïñ ”µ%U\n®6ŸXA“€A…\Z’µ~ \ç\ÇÁ“\'\'õ€Iµˆúô¬B\é#‡¿	ùfo\âPs±{·\Ê\Ü\Ç\Äö\ÉR“1\0i\'©~z¼PV\äõ,¬\ã¸\á\"ƒP­*M=Xı#7\íöx&M\îe+ûi¸&\ç\ÎñO5\í\Ì\Õjü)4>pµ&`N•L\'\Än~°ş›JG,\"ö\ê;TÆÀ\Ëÿ\0Õ¤›(ğ,ıcLœ\nüO¥­òz\Æ_\Ø\ì\ÊZg¤¤:T\nI;VùC¢±Á)	@)½\\ŸP\åı\áMy;ö™jW#\"\íÂ•0m?Åµ\0\áø,ğ¥ŒÃ¤-\0?‡ o)(\ï¹“C6®¶ox’¡%D¯^ª;y¼Nk\Ü_\Îq±ƒ`Ê¸œB\ÍÀx\Ö;–÷Rq¹x Œ\êd‰h:‚T\ß\â>uK\r@a,•¤\Õ\ÅvŠ\ë,\Ê\0£‰#’~a\ÅiM¢E`~\â(\Ï\í\nD\Î\ä(%l\ìÄ–·\ÄC<@¼BÙŠV*\ÔMıx¸„2¿^¦º\Å:V„	°gŒKŠs\Ü*¼R	Ò¥Y\ïZ\ïHõ3- “«\Ñ\Ï\Êq\Í*\"©Q°]\Èv\"\çh©‹\í*$†S•ˆ¿ğ#–»wp3!”|Ë˜\ÌşiR´\á\ÔP)©J,Û…±°ˆYYR>%‘\'Î¦)/6›>c)¾÷\æ\Z0²	BBA\Ôª	a@\ç›zÃ–~\0\Ïù\Ì\êT·\Äa\ì¶Je$©eÖº’mMúÁ¹hI\Òá®«CX\r94ø€v{G*rP[Sj4srjÁş‚pb¬\ä’L¸&‹¶.\ï\è\ß\î*M’+$\êM˜+w\0\Ôt1\ìx\0ŠR86;”\Ç\Äó˜¬³©û\×\ë\nı»Ä a\Ê¬\Â\ÉoüX¹ö‚³ñhf™Jg-+Y	Ö¶Ô¥6Õ¥¢õ¸ß“.‰œ\ÈÀŸ\nIò{”U@$T>›C\Ö-/İ¥4ù´E\ÉJªµC_“H;\ë˜ş^%Ö…ÿ\0\ê\ÉD¹j})Qj\Øû†¼>c-i\ÓO¨³thSË²¢U¨9r~C\Ú	fiHÔ…1ù›Pşğ ]²À\æÂ‚\n\ÏòO˜’T”À{“\ï÷…I3Ä¦RQV“ğ\ß`ô#˜uNo\ß\"d‚\nU¥\ì½a5e÷4\0s»} ˆå³»ø}!‘\0Xñ•f}\êR\\\n½\ìkÀ¬\Æa:Š˜´‚Á\î\àry;F}ŠR\ähU«Ù G\Út©ZioˆPğ9…=\ä\ëúJ9ò°HU…¡ 5 ò\æ‡m¹ˆ³:A34‚¥0Qv¢_M7©m Z‚u!j–IrP¦—\Ã^c\Îc‰şÊ¦.ô©¸m½\è`D‚6¬¨\ï&#ö·\ßOÓ²*A\çı@Á–”ò³DH”¥L+.I$ûÅ¼¼”«¼\Z˜–a\äk\î#uWÒ¨*GõŠ+­–cFR\å2%‹\\z\Ã+RÓ¨°sa÷\ë\n9`yú”Ÿ8H~•\ë\Z6€#\"\ÊÀl]`)øQX\äšG…Jmô¸¿\Î!\ÆdF‰˜KT¤&\ÃĞ˜y\Çe\é6Inı\Î*à²¥%,Tz|U\'Ú–€,V—>›(3=VJ‰„ÿ\0q`†\ÒmFk\æù\"\å)\Êõl‡şcM™–•jJˆÕ¨n\Öò(£7••ik\\ø!¯¦¶\Ålö$Y¥F\ä	•8HPX ‹p\İbşL‰s\\­6ñyşqY\ÏgeL)@EÁ\á}\"–A•ø¡UN:*ôR>q¦5Jõ’8\" ô2¸ˆÕ‡È¥!)}³–U«j?X	Í•-iC¬9b\\²^\Éşhr\0ZBP”¢”I;q\0±˜\0¥;B\ÆÀ‡b\çŠŞ†3‘m\Îr!\É mXš\äØ¤\0¹KÖ–¨#\èEÇ›@¼2g«\á–O—>°ö{¬9^“{Ô /™k\Õ/‡)\Û\Îª\åc´\ŞU‘ÀÌ§•\å3V¤	¿\ÛAS>#\Ğ~s\Z\ÆW†RBQ(\'JhI°³5.\Æ²-8—Q %I\â-¿[\Ã\îQ\àd©Ÿ~=!mKƒ`_Ë”«>Lºp\nPb¿&Šø¹%T\ÊHpä˜¿/0\é	S\ê ¸s[¢\É:†–}T¥‡\å 7\"‰Á\ê\Ò”¹Š€\én~<\0\íg\åO \ÊP\0ür!•D\áˆmJ\n5M÷#ŸS´v7‚­oñ|&\ÌX†¥\r6\ç9\ç\ÄcŒ\ãÁ™4¬	‘1—\æ±ÕQD;Ÿ %\Ú<ö¶Je ºTH¨§rÁú\Ó\Ú(d8Ó­ô²XTÜ˜³–±w4\æÂŒË›\áV²‚…C\î\0ÙµQ\Õ]¼\âò™’¢G„‚\ê†§·ŠjœT‚\îSÛˆ¥€’©H)3\nª\îo~¾‘B3,aq–€\')\ÔTYœÜ’>Q*i©õŠ\éJRN\ÏS\Ã\ÄŒbAÁu(°zÀ›\Üx{—\ÆTK3`~N\Ã\Ò\æ1³¡\Ò\Ï}<ô\êb,¿.	HAQQ©\Ù;¹\àyE¬\Ï\0\nt·v\0zoH\ÜzŒÖ¨¸X3/:–W¨\0\r<¶\æ;©KLV‘R¹\êl\Âa†@f\"û“ÁŠP\Æß‘P„gñ*öO­¾\ÛEyÓ”\\_ôö‹óÒ›\îÖ¯\Æ+„†¯‹€\İ@;Š\ËQ\ïÆ“ñFÚ›\Ú*gùRPLÄ»šy3¼MM(ZJ\Ô\r\Î\î@\Ûs±\ØU\"Y\ï\ÜÜ–\Üùy±%aúB‡\è@\Ïx\äzBö6”b\Ö\ß\Ö%À\âRµ-Nu\n\"õ\Ã\Í.¤€\à½Á	#\Ê4hB›–)uƒóF‰8©ˆI jH\Ø^<Ï‘;€\èĞŸü™ö³XRd¹„\ÎüKK¬(\Ôl:ô¡€÷Z+v9‚D\ÕöqUÒ¦óˆgdS‚;™IJÁ º•:rğ\ç‹¥ Ö¤–JEj¢Ü°õ‚r0\éEŠu\ìú]Gõ\0®§P•ŒLš†$q\è§\ÊRS\Ş%Ø¾— j·¨ß˜ª{C6I(RR\Z1\åhV²I`Š–\â3L<\ÅL%	ArHù4!UŞ¡÷4†™{fºf!\Å+&)¬¨+Rv…)¹Ü•*d\Å$¨2€,\×u±¼K/4	Wx’\Ô\ÔYø¥*} d\ár¤¬“\Ä8œRjjUGù¤só,#¾šÒ°vd‚¤•i`|\'ƒPH;Pß¬t\ìv¤´£s½¹¬“­\n˜?„JJhH—Kı`\ÆA—¤kœ 5+\Â\r\íœP\Í3DÊ”]@Š§O.¾PÁ“\ÏIKjB_p5¡š\×w\æ\êPüqÜœ%œ’Å¶µa7µy\ä¤K\Îê½®!¶d\Ä\ËI\0ş–\è/\ï\Ö3\Ş\Öi™0\Ëñ(ON´‚¢®\ì7QzÁ\'0#® ¿\Ê#.“¨T\nV´;Š\\ªŠµj\íNc/\É\æb	L¤P]Eôç †\ÉÀ…8<˜G°ˆ~õ\0€\Å$òzo´h«š ]€gù4+\äŠT­s©i–¨\0\î!†Of–~)\ê.…\Ê½79\Ä\í\ÃhÉ„.]Xx…É¿V>\Ø;Rƒo\Ï<P \Î\È÷KT\Ô\ÎXQ©uPñ\é„¹²İ¥jA.\Ê\Ô\\’ğ+—`F7\Ç\Ì-›â‚´\Ô»¨¨\éf³rå·S°\0\ËZ´—\n;‚GŸ\ÔBfm›ºJJJ<L\Ä2˜Xğ´­ Y˜$%	wJ…ôÛ­\à{Êœ°\ïı\Ëµ{YjtM–	¡Ü—„\Ì.`„\ÍZ5\n\Zy\Z\ß\Ö\Z{Cİ§»RUñ($–¢T\å!ù¡ôŒ7:ñRj\êj)\é)õ²XÌ‹\ì\n\Òf\çR\Ğ\É*-D¦¼moS\'´	e)j\0\áN\àpZ°\Ø2¡RG5´Áe\à¨ <4\ÚEŠ‡\É\Ì!\Î\æ6™( s·¤\n\Éq‹ş jr½@\Ö\æµ†\\—\ÉRÁ¨;\Ğ\î\Ğ?—JŸ‹ş_H\Z–HWŠÄ€Ö¡¿X%t @ı\å]›pl\ÍW,™ú\Ût³~s±Jş4·\àû\Â>_2ÿ\0²K–d—ø€+\Í£Á\ì³6t0\0Æ€¸#¡¯ˆÆ¬£GXn\Ã	p\ÊB±$Ş§Ï¬TL°\0:Y†\Íz&(‰„¿4ô÷÷ˆ¿®A$>\Å\ê)\îñBFddÈ—2`^•iÒ¢\Èg*·‰øx‰^®ø-,á¹¨¾Ç¬YŸ™\ßo©€9aB\Õ\èô‹gş3‡\ÖxÀ\ËO|E\áX=\Ú\Å\éV¤‚­#cw½¼ eq©\\\Å$ª\ïaù\ÖNZRPAu‚\Æ\é¥O•÷\æ,j`I2†Á&#\'¹k\Ö>\æ\àñõö‚Y~\nZõ\Ì\\\Í\Åü„\Ì\Ğ0¦šH£\İø„\ÉÒ–¥-@$Ò¤F–\Ãi\Ü~ ®¬(À}\Ï0\İ\çp‰jQ,¶¦z’KN!¿¢\é@S\×`\å\ã4\ì~LùKVª8£½‡ø¤’6\"5l¿*3Z\Æô½@³ƒG€\ëuXÚ™\Õ\äõ:RJ„. \Í\ä\\\\\Ó\Ñ\àZ°sRÜ‚C€\Âôn›\Ã\Æ\n”$\é­M\Ï=\"\\Ik/ü\Æ=ŠÇœ\Æ2\í#ˆ‰XT§WÅ¦£Ë¤FO\Øô\ã\Ò\Z\ç`„À°\ÕŞ”-±x‡–\0 +c­¶¬\ĞFğ#2—\Öt¤¥Î”„ø…*\äÜ—0#’!(BHS$µ:\ŞTcJ†ùE<n-!JO‹\Ï\åHb\Õ dü™õY\ÌG\Ã\å…O\ŞK\î\Øl½O\ç@\Ñ\0\ÉÃ¸Züov0Ò™#\Ä8\àsó<\nÀs\Ë\ê\ß8\Ú\Äÿ\0Ÿ\Ş8\"oh{1ˆš…wN¯üIÛ£ºAdvŠtdj\Ò“©ZIa_	nw‚85¤©K!Ÿw§V¤EšOA–J˜J¿0újø\nFqe‰Ÿ\'\æÉ˜\Ê))v¹\Zº\×n)h]\Î3¨	R\Ê\Â\ÉH­ˆgr\İ^<á¥—H$ş·ñJu‹³ñ¢@!H)¹Z|\'\Ğ}\Ä2•\r\Ù<ı&}º¢ŒQ|A9\'gU‰˜™L¤¡\'T\Æw;–¾À\×2¼½’iN—·¡õ«À¾\Äaô\àû\àSl\àj¨’\Ö-\é\æ\âI!\å€:—.o\Ğ\Åm°“\ÏQª²ß¬úŒr¦)şD·¸¬y\Â\á\æK\Z‹µÂ›\Ø3x\'.Xµ+ùh’bˆb\éj—b\îÛ»\í\îX¸$š\\X\ì,<\íSü\Är–¢“,¤úA\ê7\Ş$F•©EdŸk3’\ÛDò\å‹üŞ•\é9\"vTs³¹EHW„¹°§NaV>b…\0\Émÿ\0ht\í’\ÚJ\Òj\"\ã–\êh#/Ì³ @b\ê%š»\Ğõ‹SW¨0aÙ‚€L+\æaZBMC\Ñ\ìHhFT¥¶–$\Ñ÷~°Ñözv,…ZM	\ä†\Ûg†™Œ˜\0\nZSoZ\×&½^¦\êt\Ş\Â\Ü\Ä/V´\çE¼/^3$‹Q\æ^°W*\ì\â‚©®Jœh<F\Ù\Ë<\\\Ô+P@*f©¥:sÀ\Ä;`\ê\Ô(ı\Ö,uT“\ÂS\Òˆ¼1ê” °)PÙ\Î Ìƒ$L\\\İ$©@%L’I\0Òƒ\Ó\Ú*f\Ùr”´¥Ruš\Ì\\\×Ù ¦	1iuK\\·\Zô!ª\ì9\Ş#\Ö\\p\Ğj­œ3\Íe)*\è\ÂÍ¸kù^+œıu3ÿ\0‰!<À\æ=OÊ§É™šW\Ü\Ê° .9x»4‚\à-\âbıb\nWp\æ0«\êE#?d\0åºšû\Äl\ÑSW¥	*W7Ë²2c­$K.\ÉI¿R[\Ã”7`0)”\ZZ4ù5:~ñ›{\ÓV@\äÿ\0(\Ú+7\'ˆ³3+š¥#R‚T§	\ÔO«‹E\Ï&’%vªE/¸·õˆÀ)c\ã#¨5\Ïh†^Z”…)ªMiS³\Ò)^¯\é$\ÔÙ¬\Z©T\n\ÒZ†üô\á«qÎ\âm_©‰¡ 0f÷„\Ğg‚Rû•ñp\îö>}cÌÚ øYJKXÿ\0\ìDj. Øˆ•\Ú\Ø&\n\ÎR;\Ú,²(k\æ\Îõz=`Ÿf0faT°{¸\"¤ğ¤\í&c*ciJ”\0)\á·$õƒ}ƒÍ»‡\ZaøÁu>‘gŞ´dgğL{\Ért¡…&¬÷/»\ÃRE¶¤/£y§#w³´M‡\Í\åºÒ’¤5±`Y¼Œb¯ “\Ï\Ö³ÀŒ( \ë\íüDŠKõ@œ#r¯\Î\"ú\'ƒ\ë\Ä\à\ÏS$% Bğ‰5\Ò+\Ó÷ƒ‰=C‚v\ÍD\Z²2%•È`qEAˆ#I).Ş†›X“0!%\àv[‹J÷q\Èüó€ıª\Şô÷IMB\îl7«l9g0L•C»‰.QŒ+T\Å\Ñ@I†€½kssP!l\ê$\\¿8¡Ù¯\êw¬’\çI,úN \Z­ô‰1¸¢V\Î\r·0³§hñL·1w3\ÃÊ”%\Ë:Ô­@‰b|ˆ¡\æ \Å\ÌÒ	\r¿q³,[,xœ·>‚f™JU<ÿ\0l\Ì\Ùo^¤~˜r 7÷®O\\\Êø\çRŠu\Û\Öü~\Ğc—wò\×1SIÁ	!\íW\à}c=*t¹º”š\Ô*\Z\Ômü\à<\\”\Í\0²’[ÿ\0\Åı\ÍchR\0ö\ÌĞ›™®v\'øY\0€\Ş@\0!‹…B˜€	RğŸ\Ør\ØYa@R\Ëh9”\æ=ã‚’\n\\\'\"­ŒGG\ä\Í9\îi))–©J\ÚÄ‡¨}¨	ôƒxLJ4ƒ]\ÒhG¡Š\å!K\Ô>$†k\Ğ\ì~±$”1?\Û¨	³tŠ‡\Û\ã¹-†ü\éˆBJŠ¸q\ÄF&¸°¨w*@\\~w+B\Ñ1*kR¤n\ã¯_³X\âQU \r Š€\Î\ÏG\r¼\í\İĞƒ^ñ\æU\íLöù~tŒ\Ã-È\'´°	$’P·%0\ïÚ¼Á:”uPš}>\â=v!B”.¥TÒ X—ùÂ”X\Õ+0ó\Är\Õ@>#F_€Ò„¥…j\Ë\r„Oı;\ìA\á\âLQHUEHúys\ÍZñ;›*\â„Àı<ûº‹“\Î%Q/¤A6R\â\'\Ş\ß\Ä_\0‘BV\ÄK iaòkÀ™N9ËdÒ¤†°\ÊJcÌ™\É\"†‘\ç’ó\Ş\r¸ba\Ì‹NµL—\İ! \ë£)\İÀ«¸oœ&bp\å*	J¨\ÌÕ½C‘ô†\ïû‘4¥E$tcÿ\0\×U§XWî¿º­D—S—£?•\â\ënÌ…ò!ë¨[\ÄeÊ“zŞµ·›\'ˆ{t4€²±a\Â]6~x\'ˆf80­_\Óx@Œ‚<\Ã\í$\æZKƒ\æU\ëffÒ€\ÔT	_õ\åU¨«J\0*5©ox\å¡Û¨P˜\î,É¸`;µ†w#\Ğ\Û\é:cH\í¼ô!I)+pX”º\íÈUöa?w\0øÈ™\ZÑ‹sò$¸d¤Pq\Ç<½…’©‹dş­Ÿ8§*J˜¨\Â\æã¬ Í™\ŞÒ‚\0\à›Ÿ`\ŞğÆ¢ÁUeÏˆ½j]°!~\Åÿ\0Z‘¥rÉ”,VªÓŠ\Ôy\Ãr¯\îªn¦\n\ÒK7½\á‡ƒ7n_x°©\0Gœ±Ë±`1Ÿˆ\à|qa°Á\"¥C¨Q<\ãñs$£R¨\Z\rB¢‡‚Í–SZW\Ú\"\Ä ,2ƒŸOœ D†\É÷=\åy\æ Á\nk´Dò\Ô ü*T€,l9O—\"«2_D¨À5ö\ÜGrÁA\ê	\Éq2ğ\ä!JÒJ ¨û\Ö\Õ\ëñ\Øà¡¨\Ğ\é\ë\ÅıaL¸AÔ’_Õ‡\Ğ§‚\Î\æ\Ì\n–t©IÙ™\Ç4¤´\Ía\Ü?x\Ğu\\BØŒõnBVš.\Û4\ÅfJYK¶\ï´\r\Î1K\n		»~ó{)”•\Í)N¡00\ÔÎ‘}J­H,9†\×L¨»ˆ•:µ98ös³‰COš˜\ïV¥üş\Ğ#6_õ++5	 «\×ø‡<r\Ó*V„\ÑD3\ÃzŸ?\Ú\Æ— ¥\Û\ëx\Ï{}\Ø\ÏQ\n\0‘\Ü?+]\éVzÀ‰¹JÒ­Hsº\ß\Í!şF\r\Ğ|‰~^<ÿ\0×•È˜„$V/Õ \Ô\ë™[Úš«°s\Ü\Ùü\Öa@@²X–¿/\rù<Ä¹.]\Ã~\Â*ö_+L”%>jUrZ¯Ç”[VVRH\'`\Íô‰c¹‹(\â(Y@\Úa¼4\à…€w¦õ¬D\İh:Xõ0—\'¹O\ŞU<Qû\Úe¹„¹‰Ô•ö#¬^«e,«Áı¢\Ê\ÙJHp¢w-»šZ<d\Òf\ÉJ‚µ:W\ï\r]Î¤xUR(YÛ«@~\Ğ&JU4»A-±\Å[|A×·~fg\Ú,Bœ Z>\Çñ\àÿ\0c¦ÿ\0e~ô?¤*v³\É!\Ü\îb\ïaóaİ¤]Ağ&©œ:1†°\"i²eT\Öhoµƒ\Z\n•8\í/µ\è*b”™ \Ô\×cAs|Á(,–\Ö\Õ{\'Ï“\n‡~\ÈJ÷¶!ó&•%!7¤ş@ù!JQ\ï°\å.@X¥úBÂ³”J:ŸZ\îkCÒ›\Ã6[!DQ^\à~\Ñ{\rª9\ê2i\n09†$\åòTK k!_\ä\ÌIô‰§`\Ğ\ÕjZhø¼N°}K8n#\Ä\é©zSß˜`G\ÌSe˜T)\0³\Z0$ƒó„\î\×cL©ƒ@I-W0\í‹Õ¦…«òŒ“ş@Ä\ê4Òşd¿\í\ÒV,´.8\Ä(} ™8\ÍV´º¦°÷7Š§\Z•¤•¨\ì\Ç\æ\Ñ\Ù&¾@Zª’ö£1\Ş\áğ2Ò-\Ñ\ë;W[0é½†D_•‹˜Be•%\\¤}\â|_ˆ*>\rôº´\ï\Ó\Î2Œƒ©”T\à‚\ÅTha\Ã\à&¡N\È(w$¿Ò¯}P\ç`ş0-¸qˆ‡fñITÂ„§z“Mš›1$\ËĞ¦,³õ¬á”¤3¥\Ì\Zb0\n	\0››|£†º\Ä^?´Y«KO»¹†§¼–¢ƒ\áØƒôş?•\İ`\å8p§Qÿ\0\ìI&K¶‰zÒ”‰‚Å™\ÇŸ¬[Ê³4¢D’¤””$xH¯†=Œ_Wªû\ÅCoy\æº}3“\æ<\É<ã”¤¤”§R¶À\ì>p‰€—ü\ëxµ†Ì‘0:T\ìZ´¨-¼g«Ij\Èñ<\âI\0¡\ì\r½<RL\á#\ãIul\ã\æk¦msl9PJ’Ô£´nÉ°62½Î—Š–·cÃƒF\â!™-$\Ú\ãò¢fw«Kv4Ø†ûD‹\Î–Vª8R>9­¼ „Ôº†Çº$cV%RÀ\Ğ\0G%’3Xw$ù\nŠ~×xùFrÒ‡5únb~\nnÄC›(T[Ö¢¿fOfu\Ö\àÇŒ³,$¬ºV…«T\\‹\ï\ì!Ï³˜\r)\ÖC9·<BOa²Å­J\Ä\ÎwX\0\r\È€XXC,üü©\ZR)˜T„U‹&š\Å7\ØpĞ–©Ál„µj[™\ç\Z¡:t\Óqd=-s\êAöŠSğ\ÆX4$5B}\Î\"Bô\ë*\Ö\Ô}/h\'‡F¤T\Ú2’ùùš—Xi¯ g\ÎV­CH±\ĞûAl<„ 0…\Ì;J$’_Î•4a\Æ\'BB–@“¬\0xˆ\ÍÀñ¤^\íd¹Ji„1>\0’©«\Ò;	\Úe¯\â–‚G˜U\rA€İª_|¶m\èx\àÀü6K›©BÚ¿ø·­£NªP®I\æp\Óú`\å¬Oi&.oŒz%/c\Ï0S Æ„\Ï\ØA=`Æ…fo:Š|\ã\×õ\è•<wŒ\\V”z\ÇYX?”sˆ\Èö\ÖG‰²\áñ©R\n‚ƒñ<}!gµ™†ª·\Ï÷ŠY~w!2HL\äkñ\èšyDX9\ÉP-\ZQR\ÕU]\èO_¬\n\İ\ì\0\"/M`±\Ä\Ï3™k™5.•i4,|\ËG‰\"ppÀ(\Äu7&\ÍSˆÌ‘ş@?yT\ÚL–…l\ÄTyA~ölu\àq8\è‹>õh2\í\ÄIJå²˜‡;7QÕ›¤R\Îñš\å÷üB \\\ã1\Ë\Õ%\Â+(ş“R+»\ÜE)™„€”\Ö#\ä\Z£\Òˆ§~{úC&\ê\Ø\æ\ï\ÉU·¾\ĞÁ\ÙĞ£1€%\'\ÜN™‰\nYhV­=kó†·RZÇ“-r—¬hjjü<|Éª\ì¶f¥–\Î\"”)\ï÷‹Ó¦†rÀu„¬§:!‚‹Ÿ\Ïh9?1:	F’@ %¥£!S´\Ê\Ú9Ì–v!E\Ù@¶\Üyc\í~4¯4µ‹P»¶ñ¡\ÌÌ”‰J\\\çJ˜’—vŞ‘–®B•©wrIõ/\ZŸe\ÒÙ\é\ÕÛµ@c\çüwŠWr—©\Z\È$Klk¾\Ğñ7!”‡˜ø»^À\Û\Ò\ãwJf\Ë\ÔÄ²\Å‰`~‚5L ¥•(¾¤€\rvõ€j\Ğ_BS©* ø‰\ã‚§\Ók9bz6ğS™!!G\á\np»g\éC-I*J]@P?\ãB¾\"a– ™¨cpGˆet<\Ç÷¥\ã\Û„\ã\İ\ê)¶¼TÀ\ÌTÀT£Ö½+N&bÒ/oşO\æñzTùº>û›4G«\âæ£ä™”\æK	f´?\rs]¡g´*i`\Ê+‹xµ=\ê\İiBj+\Ñ\Ü\Ğ{\à~q!ƒÆ®|€\â£PQº\î\n\Í\"Y€OP&UR\Ğ\Äho\Òÿ\0>…\à¾\á	)z\Ô\ØR\Ä\×\é¼T\Äv]rüiUO\Ä~õ\éd\âô¯F“o‹ox%¡,ü‚N§­‰v\È\èF¤b\Ö…\ê\Ú$\Ã\æ4€¢	~*\ß\Ç\ÚMÌ´¤”‡SPs\åd9šuªRÇŒ\'MK’ö`÷¢\ÓaRDe±Á\ÖkRRJI;#Äœ\Ü0¡}\Ø<NR)\n–“\×O\ïh©˜gR0\Ê\î\Ô\ìş†«õ\éJØˆ™a»#¯ˆ‘`–„÷ŠF©†\æ–\èñx°²€RYE$€z‡ò\Ú\nH\Ê1¤ ? \Ú\r`{(P+1J©”²@=\ŞQ¢Ú€\ÜLDR§\Í\ne¹aPa1ˆD\Â…¥\Òl¡¨?M\ÓX\äd2Pë™¤½j»3\Ñ>Gƒ–S¨¥5±¾ñš\Ã\ÂÇÇº€\ÔDÄ¥\Ò<j\Ì\ÛxšDùC\á!”œE\ìF #>\Å\â{™\ÊJe~tm\ázyˆ¯£¼ıaUò#>#\0•xHQ/\íö1k)\Ä	² †¡z\Ú`ûH+\0ª€h-{“©¾ñ\ë,ï‚””!J”IR•P)`=`õU€TÁ\Ø\Ç9‹™–)=\â‚T¥$“Sôc°\Ú$’ü	Ä‘\æ\íR\å.c;6½m j\ÔmJr_ˆb\Éò() ’[Ä¢\×?¤>\Ãs¼2];Œ‡c1.nM6P}.\Ëmù\Ò³E•\Í>Ñ·Œ*ô-%,ª\î:ñ\åŸhr3B\ÒZ˜† ‹\éu\Û\ï> 5Û…‹,£\Z\'f\Ö\Ò;–,4&\Ä\Ö\Ûs\0ğ¹hA§\Îä˜•,¯K§\ÄFtñ÷†õCufFÀ[\á¨„†ügòzWŒ‹sª+O›/@)4\ã\Ê$Á\ÍL¾\Ñ\Ü5>ñ€Tç™±$y\Ò\Ùz4—U7\ÓhG\Ïr\å&g‚EÃ»u\r\çH\Ğ&,M\\¥¦\È\Ä+³ms\ì	\\²\â©ñ\'\Ëwó\Õ\n\Ø|y‹Ú…\Óf_Œ’EV€zÿ\0\",\à\×,0°Rl’o\çM_AI!\Ãôxa““! $¥œ:J‡\Äö©K\íT¹œ”½ÀŒ\âQŸ•7T–B‚¼T«oAx\Ğprğ\Ø<2V¥–¢\Õs\Ãô³„Ê¤ ±Ñš/ÿ\0M(²4>š€Åƒñ·´e\Û}l6\à\â\î7D\Ş\Ü\ç\ß\Ôÿ\0\í#H·R:ı!_™­¤\ÓÎ„ˆ\Õ\ÎW,\ZK¿Ox\ÈÆ·Pp-gPÖŸ\í\n•v\âs\è7c˜+&\Í\åI\î|*}*\0\Zƒ\ÉóhÓ°8û)¼°<y¼%##J‡…E!ª\êH‘G‡@\0\ê–\îH:º{yB÷X–œ§r§Fõ®\ÌÕ°\ÓÁŠù´‰l’´¸R€~\Ï	/kŠÔ”\Úâ¡;1ó‡f…€XûÀ¹\Ø\Â1F’#„ü)a°,\Ñvx\r`wFT\İ@+N—¸7€\í!±\r¿<\Ê8\Ì2f\r*·\Ş>É—\áE•ó{Ç£mùXº§9&qc\0ö‹eÉ˜½Â’c ›\ÚõE/\ëFx¤\ÌI )PùÂ±A$\r&ñ§ö}hÛ·Á\ÛqU†dv¥\'\Ş2…Í”\×d¨9‹Ç¼fò¤xMX»l(\ç\æÑ¬v?®@Jƒ\ZÁ\á€ò¨b\Şq\ÚÊ•FP~²\Õ\\\Ä{¡¼“<3€jú…½ oh²9\Ó\æ\ëN4[\î~ğÇÀJ–\ne¤$\r…«Lg–`\ÜKdg D\ì\èc¥‡–P§ÿ\0v`\\“\ë\nX¬\ã\Z””\Ì\nU*5¥#\äth\év³\ì*$&½Ñ“*\É\'NB\Ù\å@\0ÁşÜ\á\Ç%ƒYŞ±\ÑĞwûŒ%ŒO·\âP\\ÿ\0Ù©\Ã\Ú»I–Ê˜J\ÔHX9\Ñ\ÑZò`\Å\î$.DM\Æa\æºoHó’fx\ÕLL©d(¬·ŠÃ’O\0V::6½»	 J1$fº…¦D´%GûŠbM¯¹\éÀƒ8\\,²’º‡\åyŒşşDa\ÆcÌ¸¬(´ğ=c8\í&[1\ÉCP_Æ‚ªt!\ìv‰Ô¿¦\ÙUópØ……”\Í@Hı\'SŸ(9‘aP¥¨\nSrI©ù}c£¡Ö´¾›q—©v\Ü1$œTR´õ­_ˆ’y IM*8ó1\ÑÑ›iÁ›r9—0¨	Hp\0¼y–¥2•RRX¿4ô\Ú::¼ƒ,xˆ½³ÀMJ\ä’ \å;uxÑ°\ØdM‘!JH)\îÁsSm½c££A˜¾˜\âg8\Ùi\Ûf’e¦\ZˆK€&\Ü°[³\ÈA@\Ò6\È Ûƒº{#\Ø\İ}%óƒI4r~±w.\\¶ZÙ­oÇŠ¥Kƒú\Ì\ÍFª\Äaƒ!B¬”7QøĞµÚ¬¢dÕ¡I˜,0)K³’\Î\Ã8\èè¶˜•|ˆÇ¨]e|\Úd´4©R\Çzmâ‡\ÍcBP5FI$\\\Ù\é\Ìtt\Zğ¬+{“&\Í\æ­(*@u\0Y7µ\àvC‰š¬<³8(Lo¡_8\è\èy‹‰ndÈx¦x\è\è‚q,`Lóı¥Öº\r®(c\"NQ0!DU\0\æ—\é\Zg±¿h+”q;5‡J¤¤¦—ÿ\0+Î°o³‹˜13B\ÈGx|)w $|Oj—¤ttÿ\0\Ê\ÂB÷!!z€%%˜·ZÅ™r´€	s\Ï1\ÑÑ– f\'ÿ\Ù','2021-02-04');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_product_date` BEFORE INSERT ON `product` FOR EACH ROW begin
        IF new.date < current_date
            then
                signal sqlstate '43000'
                    set MESSAGE_TEXT = 'You can\'t insert a product with a date from the past';
        end if;
    end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `mandatory_question` AFTER INSERT ON `product` FOR EACH ROW begin
        insert into questionnaire
        select NEW.id_product, id_question
        from question where points = 2;
    end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `question`
--

DROP TABLE IF EXISTS `question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `question` (
  `id_question` int NOT NULL AUTO_INCREMENT,
  `question_text` varchar(255) NOT NULL,
  `points` int NOT NULL,
  PRIMARY KEY (`id_question`),
  UNIQUE KEY `question_question_text_uindex` (`question_text`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question`
--

LOCK TABLES `question` WRITE;
/*!40000 ALTER TABLE `question` DISABLE KEYS */;
INSERT INTO `question` VALUES (1,'Sex',2),(2,'Age',2),(3,'Relationship status',2),(4,'Employment status',2),(5,'Purchase frequency for product of the same category',2),(6,'Expertise level',2),(7,'Do you know the product?',1),(8,'Have you purchased the product before?',1),(9,'Would you recommend the product to a friend?',1);
/*!40000 ALTER TABLE `question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questionnaire`
--

DROP TABLE IF EXISTS `questionnaire`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questionnaire` (
  `id_product` int NOT NULL,
  `id_question` int NOT NULL,
  PRIMARY KEY (`id_product`,`id_question`),
  KEY `questionnaire_question_id_question_fk` (`id_question`),
  CONSTRAINT `questionnaire_product_id_product_fk` FOREIGN KEY (`id_product`) REFERENCES `product` (`id_product`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `questionnaire_question_id_question_fk` FOREIGN KEY (`id_question`) REFERENCES `question` (`id_question`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questionnaire`
--

LOCK TABLES `questionnaire` WRITE;
/*!40000 ALTER TABLE `questionnaire` DISABLE KEYS */;
INSERT INTO `questionnaire` VALUES (1,1),(2,1),(1,2),(2,2),(1,3),(2,3),(1,4),(2,4),(1,5),(2,5),(1,6),(2,6),(1,7),(1,8),(2,8),(1,9),(2,9);
/*!40000 ALTER TABLE `questionnaire` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questionnaire_log`
--

DROP TABLE IF EXISTS `questionnaire_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questionnaire_log` (
  `id_user` int NOT NULL,
  `datetime` datetime NOT NULL,
  `action` varchar(64) NOT NULL,
  `id_product` int DEFAULT NULL,
  PRIMARY KEY (`id_user`,`datetime`),
  KEY `questionnaire_log_product_id_product_fk` (`id_product`),
  CONSTRAINT `questionnaire_log_product_id_product_fk` FOREIGN KEY (`id_product`) REFERENCES `product` (`id_product`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `questionnaire_log_user_id_user_fk` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='The foreign key ''id_user'' has "on update cascade and on delete no action" because it''s needed to be always available to check reliable statistical data. Therefore, also if a user is deleted, the data of the submit questionnaire has to be retained. Otherwise, on update, the data has to cascading updating since all the data is to be retrieved from that user. It''s different the case in which a product is deleted from the DB: all the data can be deleted as the product is, probably, not under analysis anymore.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questionnaire_log`
--

LOCK TABLES `questionnaire_log` WRITE;
/*!40000 ALTER TABLE `questionnaire_log` DISABLE KEYS */;
INSERT INTO `questionnaire_log` VALUES (9,'2021-02-07 20:28:52','submitted',1);
/*!40000 ALTER TABLE `questionnaire_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `questionnairedetails`
--

DROP TABLE IF EXISTS `questionnairedetails`;
/*!50001 DROP VIEW IF EXISTS `questionnairedetails`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `questionnairedetails` AS SELECT 
 1 AS `id_product`,
 1 AS `id_question`,
 1 AS `question_text`,
 1 AS `points`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review` (
  `id_user` int NOT NULL,
  `id_product` int NOT NULL,
  `review_text` text NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id_user`,`id_product`),
  KEY `review_product_id_product_fk` (`id_product`),
  CONSTRAINT `review_product_id_product_fk` FOREIGN KEY (`id_product`) REFERENCES `product` (`id_product`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `review_user_id_user_fk` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='the primary key is composed by (id_user, id_product) because we assumed that every user can review each product at most once.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES (1,1,'Tutto molto bello','2020-12-15 10:45:24'),(9,1,'Fa cagare','2020-12-10 10:45:47'),(9,2,'ciao, mi piace la patata','2021-02-04 16:08:32');
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `swears`
--

DROP TABLE IF EXISTS `swears`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `swears` (
  `swear_text` varchar(64) NOT NULL,
  PRIMARY KEY (`swear_text`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `swears`
--

LOCK TABLES `swears` WRITE;
/*!40000 ALTER TABLE `swears` DISABLE KEYS */;
INSERT INTO `swears` VALUES ('bitch'),('motherfucker'),('rave'),('whore');
/*!40000 ALTER TABLE `swears` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id_user` int NOT NULL AUTO_INCREMENT,
  `username` varchar(64) NOT NULL,
  `email` varchar(64) NOT NULL,
  `password` varchar(255) NOT NULL,
  `authorized` bit(1) NOT NULL DEFAULT b'1',
  `points` int NOT NULL DEFAULT '0',
  `admin` bit(1) NOT NULL,
  `active` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`id_user`),
  UNIQUE KEY `user_email_uindex` (`email`),
  UNIQUE KEY `user_username_uindex` (`username`),
  CONSTRAINT `user_chk_1` CHECK ((`points` >= 0)),
  CONSTRAINT `user_chk_2` CHECK ((`email` like _utf8mb4'%@%.%'))
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'user1','user1@mail.com','user1pass',_binary '',0,_binary '',_binary ''),(9,'user4','user4@mail.com','user4pass',_binary '',15,_binary '\0',_binary '');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_log`
--

DROP TABLE IF EXISTS `user_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_log` (
  `id_user` int NOT NULL,
  `datetime` datetime NOT NULL,
  `action` varchar(64) NOT NULL,
  PRIMARY KEY (`id_user`,`datetime`),
  CONSTRAINT `user_log_user_id_user_fk` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='The foreign key ''id_user'' has "on update cascade and on delete no action" because it''s needed to be always available to check reliable statistical data. Therefore, also if a user is deleted, the data of the submit questionnaire has to be retained. Otherwise, on update, the data has to cascading updating since all the data is to be retrieved from that user.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_log`
--

LOCK TABLES `user_log` WRITE;
/*!40000 ALTER TABLE `user_log` DISABLE KEYS */;
INSERT INTO `user_log` VALUES (9,'2021-02-07 20:28:08','login');
/*!40000 ALTER TABLE `user_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `userquestionnairepoints`
--

DROP TABLE IF EXISTS `userquestionnairepoints`;
/*!50001 DROP VIEW IF EXISTS `userquestionnairepoints`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `userquestionnairepoints` AS SELECT 
 1 AS `id_user`,
 1 AS `id_product`,
 1 AS `points`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'gamified_market'
--
/*!50003 DROP FUNCTION IF EXISTS `insert_answer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `insert_answer`(in_product int, in_user int, in_question int, in_text text) RETURNS int
BEGIN
    DECLARE swear_num int;

    select count(*)
    into swear_num
    from swears
    where in_text LIKE CONCAT('%', swear_text, '%');

    IF swear_num > 0
        THEN
            RETURN -1;
    ELSE
        insert into answer
        (id_product, id_user, id_question, answer_text)
        values (in_product, in_user, in_question, in_text);
        RETURN  1;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_questionnaires_details` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_questionnaires_details`(IN product_toRemove INT)
begin
    IF current_date > (select date from product where product.id_product = product_toRemove)
        THEN
            delete from answer
            where id_product = product_toRemove;

            delete from questionnaire
            where id_product = product_toRemove;
    ELSE
        SIGNAL SQLSTATE '42000'
            SET MESSAGE_TEXT = 'You can\'t delete the questionnaire\'s data, since the date is not preceding the current one';
    END IF;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `questionnairedetails`
--

/*!50001 DROP VIEW IF EXISTS `questionnairedetails`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `questionnairedetails` AS select `qs`.`id_product` AS `id_product`,`qs`.`id_question` AS `id_question`,`q`.`question_text` AS `question_text`,`q`.`points` AS `points` from (`question` `q` join `questionnaire` `qs` on((`q`.`id_question` = `qs`.`id_question`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `userquestionnairepoints`
--

/*!50001 DROP VIEW IF EXISTS `userquestionnairepoints`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `userquestionnairepoints` AS select `aw`.`id_user` AS `id_user`,`aw`.`id_product` AS `id_product`,sum(`q`.`points`) AS `points` from (`answer` `aw` join `questionnairedetails` `q`) where ((`q`.`id_product` = `aw`.`id_product`) and (`aw`.`id_question` = `q`.`id_question`)) group by `aw`.`id_user`,`aw`.`id_product` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-02-07 20:33:42
