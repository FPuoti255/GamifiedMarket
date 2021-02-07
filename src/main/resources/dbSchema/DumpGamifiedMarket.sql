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
INSERT INTO `product` VALUES (1,'Sausage',_binary '�\��\�\0JFIF\0\0\0\0\0\0�\�\0�\0	\Z\Z\Z\Z\Z\Z\Z( \Z% !1!%)+...\Z!383,7(-.+\n\n\n\r/% &/----+---7/-5---+-5-+-/---/.--5---------/---------��\0\0\�\0\�\"\0�\�\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\�\0G\0\0\0\0!1AQaq�\"����2�\�#BR\�br�S����$34�s�\�\�Cc\��\�\0\0\0\0\0\0\0\0\0\0\0\0\0�\�\06\0\0\0\0\0\0\0!1AQ\"2aq�����#B�\�\�3Rr�4b�\�\0\0\0?\0E����\�\Zh\�\�\�=��VHRL���|*~G�\��x��\�5}�\�3�fϘ��Z��c�Xr\�9ﶗ�h���)����(\n4y�1@�6��D.h�<��h\09-Q�/\�\��Zs\�^�\�ِ\�\�y��H*Q^[�D��\�T#Ӧ~Qʲ�$\'RS{k�p\�|\�\�ʔ�t��08�5\�\�6`�\�$�B��\�\����ɽ#�g�Q \�\�$�\�eEJ?���5\0|�_8��ǿb%ٓJ�D�x\�+��X\�@g�2\�߱�&\�\���9ӌI\'�\��\�Ia�ұ̃�b:J��\0O\Z�\�$��M3oa�\�\�\�N|�\�\�5��;:>��a?3\�t�,\�\�?O~\�E�!iʾ�ĒH\�\�\�4\�\�f\�\�GxSx\��!s@JRK\��\�8\�RgUK7�kJ���R��5�F\�\�H�q\�Z�\�\\ŹQ �<p�\�\�L\�\�j��x�8\�+#��\�\�-\�2d\r�\�q�햐�R\�\�j��GO,\�Y�#sH6�d�9����EU\�	��Ojo1(�2\�� @�Dn4\�\��\�ج�VŬ\�)g\��T�-e�b��\0�7�ط7\�>�U\�_˶_\�W��dL���c�d�������h�`�\�\\��M`%.Y\r�jx>�<!j�Y\�Zl]�d���\0��8S\�9�������΀�\�C\0�7���b�54�\�\�?\'�+\�KOİ:\�\�2y@\r�\�Cn��\�J���lJ\�\�4H��$ڳ\07�K����D+e�(h\��I\Z���M�e	��4�IwI���͛�)QHI+�\�NI\�\�M@Q�^65�|�ۡIK|/�*�Ԧ�El\�\�\�$���\0r\�\��\"\�\�M�2T$N��6\�\r\����t\�unf\�O�3l\�6H3%\0\�f�saT�\�]�:�\�\�.L��[MZ\n�\�l	\'��˜Lr\�X��v�k\"�Ӯ\�\��\�R\n�0ʅ<\\\��R��l-a�Ү�\�\�}=\�D3�-}\"2��\�=���\'ffR\�R�$+���o�)8���ď|�L�Z}\�ޱ))Mn$�7m���J	\�:\��Ҝ	�D���~G�p�[��-(�\�\�f�D�(%��*\"�4\�\�\�4(<\���t��M8�M\�\rQ�[\�/&z\��O�\�\�\�7D�\��G��\�e�J���Gt�\r�{:C���c�%\'\�8\�o!倐\�d�	�y��>�\�:\�=�1fmL$\0�	\�*�G\�\0�\�\�e:\\-5\���A�\��x�1�؊�8�6*��J�le+k����P\�\\��B�\�0\�\�C�\�݊�7\ZOᮤ\�-�!\�yÅ`\�\�\'e*\�1\�\�ZӆС��\��<�e�]�bT3\�z��0���ݭR\��+����\�	\'�nmŇM�,SD��ĺȕ\Z�\0`R��y�ʠ\����\�\�\�\�\�\�t�~��f��J����r�lFA�9o�\�\�\�vQ�\�:>:ʒ��{�\�J\�d�4\�!DUA\�P\��\�[�\���-!LR�\Z�4�\�Kf	�\�1��B�\�	@𦻄	�\�tj\�5#��km �\�VRX\�tVlǞ�\�\�	�3�̌����A��\�8��O\�@](�!\ZZWg�*\�g)��\�g��w\�\���E٭k\�rei�\�\�`�\'\'�\\7i�ZPԦh�\0\nO/���}Ʃ\�\�e\�	N<\rA`Fe˾���y\"\�>B����\�>Df\�a�h\�N�D2�p��]�Ț�S\�\Z�92�%��Z\�r�*a8B�\' �\�o!\�M��f�Z/9M�\�M�C\�=k\�Ll�ӯTa&\�\����ę��e\�o,���,�\0���xD�\�\�&04a���|3\�z���D�\�\�0�\�:!\n[`I\�Ì�]R��S)�{\��\ryc�؜bC�i�ƽ`J�\�;\"����e�TO\�;\r��\�} Ղ\�,U#�\�3\�c��f2�툰=\"<�ZRX�\rH-\�r\��QΦ2����A\rJ��;��1\�\� $�zR1$ʫ\�\"L�Z�%û7�פS=�̿Bx	=S�\���3���\�\�`m\�k���Q:��\���#~�n{M�����0)@JR�u\'~�-�K\�ж�]�{̓$���\Z�\�S�W8#��\�9?��/g���\�\�\�,�7\n\�2�>N\njۈ\'\����iwN��\\ܽ=\�p4�\�gP��\�i�LJ\�T��B\\�?\�O�6N�\�-�cJ�\�~q^R\�p���\�u�S�\�cA�@d\�\��.z\nMq\r�I\�Mʹ\nT=�\0\�.\�	\nF,D4\��V _�(�/\n�PЁQM\�H+[,\�C7����\�1�\�\�\�\"t�d�ŁH�#��N���D\"\�\�.B�lHz(|\���\nĒ\�A΢�\�	N�Qk|�\0b\�\�L�\0\�/�\0�{���\��\�\��{|�\�!�\0?�\0�$[BHqM\�q�DO!��z�Cxo�j ��꓀\�J{��?)\0Q:֧�\�\"�e�@<bRm��ن\��E��|ߤB\�\�\�\\�v�S�*�\�\"�S�4\�R̉�KK�r�8\�:Ϻ�\�$���nK�|,\��8D1\�5C�\�\�d[[\�l�J�eP.�D\�}�\�L\�\��}�B\�Z�\"H+¢Tj�E���t\'��k�|�%\�.e�D*D\�ɑ��,�,\�\Z���V�\\�O�X�\n,vP�RT�TK�*Q��\�\�cz��\�L_�\�7:�Z]T�]c�\�b�\�L���2NTR�r�͘W\�\�U\��).\�X�kP*y��r\�R\�8$W0\�c��^I�\�C�α�0�\�c�Bi|>�6c���K�j���;\�G��?(;a\�\� �\�Ϻ8�\��TZ�	k�}r�\'[�.u�_\��</�ͅ�ZP��\�\'^)I	�zxD;m�A9����(�\�L�sP(\�TԼ\�\�S��\�K�\\\�f,Tbb\�	��{\�\��-�-\"`H]AR�,bwqr����ЩA&����\�M쥹(p\r�5s\�_�M\�ޙ\�\�\�\�E�ZBҐ�DCQ\�/7\�	]�	�$\Zw@f	��m��f^ҐR�K��j���2x\�:\�W(�\�\0Fi͊�W]\\�;\�1r-�1ٿ(��f]iAJ��\�}@\�\�\�\rYP\nA\��Ñ�l)@b\"g\��\�\Z\�\�\'�O٫\�Gk7�P	wJH`ˊ\�\�Վ�U�3\n\�%\�o\�)*Ą����P\n\0������x`���2�$Ѕ\n(�918[�\�9[/kLĤ����\�W2 ڌH)@ І!#=�\0��\�\\�M�\�3��oX\�e�K�I\\���BH)�gf �\�\�MZf�P�K�r\�S\�(W�\��ôR� Ҽ����^I��\0�8\0T�\�kf$\r��*ҳiڑo\�\�Rp��Մ�XUN�9�\�2PI��\�\\��b;Z\��;E:A,�@)�\�k�)?�޾5�S�͔�^�>L\�0\"��#U \�;���ռDAU��0fKP�\�\�\�\�x�=�1�\�&.l.b\�\�bfh�\��؅K\�a%�G�8T\Z��J�BY�YkV\�\�d*e\nso�h*2lfyV�\�*\��z:��d]�=�����\����>_Y��ɑ`\�N -�\0.3SH��E�\�!X\�MLդ�R\�	q��\�\�;�\�6b�\�EM	S\�|��L\���\�\\V�]����~]�/�s0��s�N]`�m\�\��4&��\r�\�\�-B� �\�m\ZT����\�)\�\0SNeܞ��\�S�0}ư�\�b�hR1�	d��z����=bE�\�,\0S��D+��J\�\n��Զ�6\�0\'�Z\���u\���\�b����\\����e�\�,#BäQ\0��\�͙ۖq\�\�@uv\�\�CbT\��\�\��Ee)�\0)\'*\�~FWei\\6%����LQ�L��q\�p�����f�#�┦b��\�Ԇ\�2x�1\\S1\��v��0#H6�>\r\�_P�!Ax�.\�?.̥\Z�ۿ�\�x]���\�/�B�X&\"�i+g6�(a\'\n�1�CD\�~&4*4�\�\�밊�\�qˬH�\�\�#3�\r\�G\��A_�%\Z\�Z3\�\�*Yd�\�J��:�\��{K.1pHP.\�\� N�԰\�Ix\�ьF�jCP�\'�~O�H�ưߚ�F�-j G��\�7Q\�??Xe��jU\�3���\�\�\��܄����9�H#\�k\�,��`N�}9ba��$K%a�$\�S)SK�-\�.�\n٥��W%�N,Z\�C�;b���|[\��\�\�%\�\"N-\�_�(\�c� �L�\0U[��;�&`Q\�C�l�\�11Dȧ*�*n�H\n��\�·��\�\�Xyޠ���\�C\r�\0d\�X�(�`�$\�\�¢���6�ڥwu\�\�/f\�\�{\�x˳V�$��ت)��e\\7\�&��\�;u\�L\�\�\�IC�	fB�-Bl�\0�0 -鉝�@f1\�R\�|\"T�bu���!e���ߚ_q�cBaV�Y�h2���]\�k\Z��o��%\�-kR\�\0�*vʄ��\�\�\�D�^���wf\���-JdX^g\�G\�W�5}# }R�\�گ?~�L�9���ͦD�ǳ�P&���Gpܭ\�\"iH\�s\�\�H	Rf%�$O�c�\�`4�b�2\�	8娠��2s��f�\�SiC�l��\�O\�\�x\��]ed[ko~�+�Ŕ\��\�N$)%*\�@X!-RR_�\�f#$[q4�0~f\�S���ˆV,h�QFe�ߘ���k� �.ϑ\��G�b��ML�{��I!BXS\�F�\�����t��t��R��\�,���\�_�5y%h\�x\�36�J\n.�Ed\�\r\09м���ie\��\�|ML�L�R]*e%@fP�\��@�[Tf�cN R\��0��.{\�\�\\��r��-c�JI��_��	\�C1�)�m) �?7>�$S\���cL�]׫m!`�\�P\�\r\0�\��\�<*>��l\0��\'s3�O�E��b�b��ɠk\�\�\"I�\�/\'��E��3��c,�\�;�*W\�8\�nţ\�1-�\n�\�o9�B�N4��5H\�2t�{5\�-R�� S�p�	 T���͛p3n\"r����ʆu��\��`-�v\�<0\�;ut�Ȥ�[�L\�J�f�\�\�q\�{+wv�\���S�z�!X\�v�����\�avbT�?z�\0��\r\� :\�Õ�h�\�R��U�H`X\�Z�\��[\�j��R\�``\�cG,38]W*\�f�̕�N�\��b\�8UZ�&�Bk1�#\�h\0�Ͻ��݆T\�_y����<Ā����\�ʫ2\�&-� V��\�6�S�\�-�J\"B��@�p39p\�^E{�\�N�\�~�b�U����\�8\�b��y)\�\"]��\�ɰ�2�\�J��4bt\�F�\�V��\�q��h#\'ߺ-�ڒ�	�\�$\0\\=j\�g\n�\�\�\"�7�\�ـR�@;im���0%U\0�\����N͙�Ѐ�,�\�[̥.\�4�q�l)A\�v\�,I�\��=��^��P���zA*(VU\��iJҤ��H\�,�\�Z�\r:�4�*JL��\�\Z��,FlFC�\'J$p����fg�\�:�\Zn\�F쵌��#AcL�K\�-aш\0��u;S*\0¼\�\�	H�1g���\0K�N*�\0(Б� 0\�\Z�\��\�0�\�j\�\���9�c:�|\�\�\"�{8/\�cr�G��\�+r����\�\�6k\�K�LÈ�2@\�2\r���{8N5�|O�\'{Q@qc\�Жn\�`��h��3$�N\�\�⩀�ܾ�37S,m�,�\�\� ,�33���\0OdkGnP�kN3�,6\"���mF\�r�Yx�x�:1A!\�p \����\Z\�\�6��Rm;��\����u\�MHJ�\�Ј}��V�H\n,ĥY��c�-Y,x�L���»,\'0X7\��$\�}4jkĦvC*\���#\����2��\�2IO\�|�e))z��y=a �\�\�\����KR4��\�ٕ�uٛ\�fW\��\�t�*ɳ�\n�f����\r��.\� Pb#\"xC6\�^*����BN&���Ck\�9M\�\�\nu�L�-B���DO�]���U:[�QӞ\�MHv�:\�U��&\�g��b\�A �JA|���\�\�ݶP�NP*)P7\�#^�\"�HA��ᝰ\n֮�m�0A\n\r�f��6v\0�p_�4K���\�<=\�ƅ8�x���Uvb@3Q-P\�S�\�3\�}[�7j�\�1\�-G攒�Ji���~ܔ\"zD��RT\n�i	`\�5\�Fb恝�n��M���WU�[p��hV�}\�bp��kB��8s.j�7\��ȑ٣y�j�hf�G�UwNP�B�ڻ-0�sK)D��\�	!��i\��M\�W��ǋM���\0�[@\r]�ܵ-\rvB�,)%�¤��Ij\��3¥�ȹ���0�j9�\\(=z`Ղ\�jX2���d(�\��\�\�eW\�\�\�-;���4\�\0M��\�\�\���1{�yƐ�w�\�I��A	g�\�l�\�r����\���Z\�,�y\'�\�+`i�a\�(�7�\"Y\0W\�\�B	\�m\�����!�򐑍�*\�\�\�cѳ\�\�\�$�8Y\�\'`_�;�H�\��\�%�v�+\�%A�\�AZ\�\���\�VD�\�\Z�Xѷ���f�pم\�\�ue�9(\\\�\�(�\�\n�vE\�hO�S7\�\�r\�	�E�k�\�\�-\�\\��l\�N+�ķ�G\�\�Ye�\�)IWT�����mo{�\�h��CӃkj4�\'ZC5o���aF��$�KoG͏\r*ʞ\�{�4\�ݶev���8\�ZU��:�4�ke�t\�օ bF-HHg:����X�\rXg̚r�\�|� )(�A	bY�\�u�&�\���[veߺC�\���0\�C�;�v��@\�,6�;><��\n��^ki�\��?�E1#���:k����\�������2��\��|!\�U΄D��\�X�F��ґ��3�\��0dY\�Fx�ˉ|�\�9Z��Io^M�f\�#�MVkg�?o\�AO�3o\�\�\�\�KN\�W=\�\�%]\�\�T��xD�\�go\�Aw��j��5\�;K@z�n4\�\'ߓR@\�\�!\�|�S\����\�ɂ���\�\�J!!�Y@ϔ4\�}\�@�\�dī%\�h\�C�\"rf�]�����!�x\�fʠ�\n\�\�.	\�\����k}c\"����Ӯ\�\�\�IK�t\��p�Nf*��S,R�,h�\�t];_7�MF�s\�\�*]�Wid)�%C�c\Z�C��\��PT��\�O\��g̳\�\nĤ(�`�=\�N(\� ��n\�|&\�/?\�\�MC�*\�\�e,��P\�\�l�)0:Dov�:C�\�\\��e�3�0�Q\�;\�\�]cW\�\�\�&lp\�lNú�RW\�=�)�&�<)IvbN1R7\�ww�!(�.�\�M\�\�\�Đ��ҝ/�\0\r~QQ]SA�,\�\�N\\@9\�+.ZayLp��c\�����J|ggm\�\��[`R�1d�����\0��S\���&X,\�\�7\�N�w��˚�\�*�{\�=�(�mǁ\�J\�\�\�X(�-�\0�K���[d�\� ��\0�\�\�\�>\�d�YVI?�0;3bK���F\���\�4V#M< \��Qv���u�����>0z\�L\�mE�uMj2`SQPxa\'*vI\�[(�Ҡ\���$t4\�#�\�\�\�˜�1 �c�\��V���j8�xb3w\�5�4�F��J�-nF)��\�	c��\�>tL\�fbQ$�9$ԒjI:\�\�X)�>��\�n�t��6�\�2-��f�gL�J�O�H���2���~�&%���w\�\�i.u���\�\ZeHa���x�=_(v\��	�H\�~��\�	]�P��\'Ѡz\�M7\�\��\�\�\�`JW����jqPSV\��N\�\�%[��*Y\0)\�U\�Cw	�!|&Z�fc	$_�P\'L��\rFZ���3U8\n5^�\�5\���c\�֦V����\�\�\�\�o\�8\'߄{\��\0i�t\�>P�.\�K0�DT�}K?c\�}�[��F#\"�٠���h�\�SS������kz�s�(�\��\���\�a�������4\�)	�R�\�\�J`�v�v�\�~q\n\�k�\�tt�\�*�� U�\�rˌqTgk@\�����{�s�К�?BìC�Mcݕ��К8:�����0�e�]�\�D\�?\��f\�\�p+\���`\�0�R\���\��\��;)+.G5\r�\�J	q\�kQ6��\�\�WbRIs��Qҏ\�\�\�q=?�b\�\�.���S�#�]=\"��;�։�\�rTK\��\��\�Yb�;uW��\�2v2\�4%N	g,	\�1\�n�J���2F���\�8/�\�B��\�4�����$8\�:��!\���K)N%%*�\�89�)K�>qL:5�c^��\�\�b\��ͻ\�\�Q\�*II.�\�Fl�+&\�\���d�0�\����\�hQ�\���s@4p\�C�\�:^Q\"�(�R��i93��\�\�\np\�\�x�\�^���`�	H*Q\��\0\�\�!�g\'��ą�@a=բ�\�\�L\�j\�}�%A���bX�\�@;�`\�ܫ@�.ш0�(µ:@|US\�B�+�\�\��\�t�Y�	\�L̊�Ls)�G�I�Sd\'�\�lI\�\�/��\�3\�O�C	�\�\0͜0nQ�̳.z1wYLx���b��~eidY�/�!��n�!�㖅\�2�����=1�@1\�s(	T�,)b�Ի>Z\�#ɼ\�$��)\�\�\Zҵ\�\�=\�\�>=t*7�M�z���T;>\'�)�VlwJ~��\�\�\�l����0�\�%\�m�Ĝ!8P8\�J�H��f�9\�\�D-����a#9\�rH����\�H-@\�\rRV�\�\�\�#��]wYLl���N\�c1�!��\�\'X\�.uT\�dզ\�kt�\�h���r7\Z�x�0\�u\�M�8D\�Qi\��+}k�\r+\�\��ǜ\�\\M��\r\�5(��$�*`_&\�յg�\�Y�\�rX�	\'<OSF\�b��g(��\�\rBܳ}xE�f�RҚ(��\0T\\ϗ��\�X\�]\�\�k�i\��G���\0�n��dg�>>���|�J	i\�X�iDN\"#MLz���9R�%i�J�.+-���x\\(+\�N\�Q\r�k+��d\�\��\�\�\�\�̡�C�Ur�^q�K�O\�G`u\�(�\�\�|w \�<�4\�FZ�!\�\�&^Y�\�<��㣜e\��E�\�\�5qx�Gt^�\�A\�U�bYE�8��Ed;;�T�0_g\��L�y\�5ʢg^jZ\�Mӄ�/\0�\\k�\\�}a�\\\�Czzne�y\���B�}ԏ�,v��\�K*\�LZK\r�:G\��\0}T\�P�@\0Oˈ�\�V�1�&\��\�\�\�\��/|!�&*��+�\�\�ߓ}�U�*zfm�\�\�Cy\�V\�\�I��h��ف��T�Ù7(O�^]��(\�(��\���Dy$*n\r�������\�\�Ǆi�mO��K\�\�KP\�L3I(\�rB�(AC^\0fZ+����E�\0:I\nf�_\n��؛�(X\�Y-�#*�q^\�@\�\��ߊD\�*\�\�-eC�kS\�P�C\��ԵU�\���)r�v�m�z��\�\"��xx�;p\�\n���\Z0����\�C�H\r�9z\�gr�3�f�R�\0\�Q\�\r6[\nDԤ�\"�»��1�QMɆR=\"\�?\�\�:\�7�ٲ�)\n��\�t�,S�T7qF��\�w���\����m	=��`�\"-k�J&-���BjN#E\0?�7\��϶��A2�1d(��\n\0�g�u\��\�k\\lw�\�i\0-\�{�`ݎ��r�\�E�v��\��H\�0��5;�\�\�\�\�}���\0\n�x\�,I�Ɛ\�\�\�\�m<a�<F`/\�\�w\�a\"RC��)L*\�M�g4`�mU�re$*g|0p�#6wz\\!\�*]B[�\08;\�z\��}N��)t��\�\�\�\�\�ŅE�L���\�\�\�q�\�\�\�I�oRQIe\"j_ nV<	�\�\n\0�)\�\�1\�\��C\�\�\�\�:Ρ,�,\�\��(�����\�m�\�JRe\'q$��=c3_.Ry�ը@��K\�dڳ(f�9�t�͝�M�1�g\�\�D�\�`\�[��mYɆ;5�qA��**7ڍZ�W\�m\�\��Ǳ*�zFE2�)ۙGO�\�\�1�J�\nh����\0�SE��j:8}GQ�;&n̖\�!is�@�UJ���&O%�߫��GHx�,l�Fa�F\�\�8\���ݭ(_\�.�>\��,| �,I�~d�x����jrkGLꒄ-�E�e\�\�\�H>���=�m}��j\�L\�r\�<��m� �N[���r�G����5�+Qo\0�!t0e-�54k\�\"瘠��A\�P\0 T\�_�4\�2\����¾\�ZV�2Җs����r\�Tф��+U����a�־	+�\�o��\�,JXG+�YT��*�	 U�C\�nq@\�&Ԭ90�9�\��wHHK�\�\�Q[e(�\�2�%/�\rC����<>�\Z�jo\�\"�\�m2UZ�\�C��-h��N�C�ox>CD˦\�>��\���\�=!�E� \�z\�:�h\�`�����3rWc�\�\�贕�W�d\�$��0N�C�\�A�\�\\\�S�2\�`�$-),\�3�4\�\���)\�VCw�I���\�Hp\�s\���*N�!o\\-E\�ݩ\��Evv\�\�\�ﳶYf<��\�y\�����`j�갣�f�-s�\�-EG2\\�\�:\����P�\��h\�z�2\�\�:�\����u��J\�\�F)�\�8Niw\0�f\�ڦ.ĉK-\�UR\0�\\w#�,\�\�\�\�R�E�S�NU#�\� \�\�C�I�c�!0�&\�\����ͪ\�R}�g\�[����!���\�\�WBMjx�\�!����n\�\�\��\�\Z\�9Y�\�pe�|G��$�Bi@\�3f�ҧYWf�U\ZH\�<�\�\'\�Rg$��V�\��˛==�\�p\�<t\�\�\0z@�\�Z\�\�X�-\�&YP�jI;2X��\�@\�ЧxY@�f%�$�Ƙݨw\�Ɯb\�w�PlN����!M&Mu\�}\�\�9S�\�0\�]�Ӝ�k\�\\yfbL�\�!\�8�c��je�$��\�i\'\��1��I+�\�\�E����I\��5\'�\�>c�F�\���\0�a�\0T��u��V�R��\�P��t�#�wZX\���$\��\�2\�\\�Ғ���_([�o���\�ě:۟ݗ�y�zŐʴ)����\�1b�\�\�g�\�!\�?�����寔X\�e$\�E8�\�~p�+fL����\�N0l�0\�k�\0��k�v�J\�Xű��%�bPHJ�N���;�0���vP_\�ub��\�2\�P\�!�7�Qp\�\�-hH�&\�\�Q�Ь%{F;�K�aG�\�x5)�V\�f�V�H!+\�P{\�Q\\�x��\�L�d�ɜ��\r��dɋ#��@�\�5l\�Y\�l2e$�\�iP�[�d�\"|\� S\�H�\�\�Nr�*2]�j��F�l!6�\�\r\�$�>p\�h��\�%�) ֠f*���j��I\\b �\�J2\�\�\�\�pFu�hh��-J3�HQ|\"�J@P�\�7M�xFj�f�ᰌX;�_sբT�9�8e\�(\�d3\�\�6,c@�y&@M\0\��\0\�:}\�\�\��s�\�D�*w!��\�\�V��N\�A\'\�~�����\�6���\0X!\�S��t�0ȯ�\0�r\�\�i\�\\�\�+�S\�(�.H\�\�i���� \�ZS��=>��ym��eK,rR���h�]��Q�c��\rz}`%�jl��5\�b��޳\�\�Z�\�A%KIQP\��i��\�|p���g5O٤$o50�z[\�,��M�\�Κ�\Z\�jsM2\�%M�\r�s&vR��;�\0\�G\�1\�N�a_��	>\�\�\�%L\Zɯ��=��2\�W�\��\0U2��2mxPaQj\�\�\�\�\'�\0g��	`�O3I \�v�[sb\��:���3%�\�Q*_��l��-\�:��t\�C)	fϺ�\��wiX)\ZR\�gR\n�&6N\�&I�j�w|?/\�\��H�{1l\�灢��\�z�Ĭ��i�|�#�\�.��Zl�\�\��#X�]�\�\0�fɛH���=D�YT�\�<�zAAf\�ı*�g\�(�T��H	\nL�K��w�\�\�K|�\�\�@\ZGpt�1�(�-W`Q\n��yn�)))R�ܲA����\\c���n��E݄�\\�\0h\�\�u\���#��GH\�J\�\�߄T\�@�I�3j���c�0<s��1�T��:��a\�\�W!\n	��\�\��Ɲ\"*3\��GX\�0�\�\�+mV\�KK�A#��P�x\�}�e���EO��4�Y\�L!KQ[�w�\�\������5gX�n\�9I��VxPu\�\�Ai�\��O<\�B�\�p�\rO��\�@=�`�\�S^�\�\�\�n6�c��{\�x��\�\�0#�4\��W!\�t`�oM%Y9�5�F�8��\�\�v�a�e\0\�F��\�M��^\�V\�\�\�D\�\\��\�)>�Aݔa->>��\"�ZwX\�\�xAS��\�\�\�-��\�! \�\��\�c%\0�U,- �������\��mt����D��Ȃ m峈�9S&-3S4(Шa�IȺ�\0\�BNT��N�\�o\�Z�~�Te\�X��J�\0�N�R���y���Q��FG~g�i�x�\��\�Y��T�J&�62\�\r�5\�y\�,\�\Z@RjѸG\�6t�\���\�/6��a\�\�]�.\\��\�n�I;�3u��\�+^u\�9\�\�\�\�(-\nB\���%�\��\��z�#�7��Z5���\�\�\�gyQ�\�H\�V\�d\�s#OK�遌��hDZpK\Z\�	�P�REt���Yn!7a�\�\�\�O��C�滏\�\�L�DyA�3wGI`��\�a\��_^1�\�\�g�&7Ll\���#��\�*Hu�\'���s1\�\�i\���\�%IH\�\�p�n\�$\�)_Ī�\n\�{Z\'\�S򦃠�\�\rQ�\���I������D��`��SS\�6����S�o5=!r]�$˕�}`51\���\�h�6iy�R��t�\�yl\�v�tJ\0�\�n�\r�����\�%lrVJ\�i�h�\�\Zɖ{\��Gg\'_�i<1i�q�iG\�\�m�\�bI53��~�\�tY\0\0D�\�<�\�}D>\�&�{սD.\�\�OS�*H)3�m��m\�\�E��Q\�^P�a�\�\�6e�&�\�Wu�\�\0S�\�\�̻\�S,\�D\�h���Jeʛ٨��h�<�� T*;\�\�F��K[�F\�\�P�$b��U=cYר�w���6r\�o�?b\\���!)��{�\Z�o��d%i�(�J \�L����\�\'~\0ƭ�\�}fk�iݩ\��\�\�\�{�\0��\�\��j�FB_��\���\'\�������\0�\�wz2?�\0�\�=DZ��\0A_��?�&G��U]�ONV��\��Q���\�q1\n\�vL\���rW�LXR5\�\0b�~Q��\�%\�!S���c 	\��\0�\�+K\����\0�\�`�P��\�/\����\�=��q4�/?{�m��22$\�\�|>Q�\�\�FD�zcY�(\�ȒH���B!\�y�\�I\�\����\0ݗ\�l\���􌌀1�\���|!yPl\�\�\��\���\0\�\";\�B��������I�\���\���227�\�qn���\0#��Lddd;�V�\�','2021-02-07'),(2,'Potatoes',_binary '�\��\�\0JFIF\0\0\0\0\0\0�\�\0�\0	 \Z\Z\Z\Z( %!1!%)+...383-7(-.+\n\n\n\r-% %+-2/-7--//--/----//------/------------------------��\0\0�,\"\0�\�\0\0\0\0\0\0\0\0\0\0\0\0\0\0�\�\0<\0\0\0\0!1AQa\"q��2����B\�\�#R�b$3r�����\�\0\Z\0\0\0\0\0\0\0\0\0\0\0\0\0�\�\01\0\0\0\0\0\0!1A\"Qa#2q����\���R�\�B�\�\0\0\0?\0-�\�U���\nݯ\�鐧>Mɴ\�\�\0Q\�G~�-\�?\�G�\�\�Z\�Lټ\�CI\�H\n[j\�\�\�:\�$�N��N�L\�\�S1?�_H}ɱ�e\�J��2Eh(<\�7\�W<��+c�aB��L*f\0�B\�J\��\�$SH��ߣs��惢Ze�Qs\�,b���2j�\�\�\0Hv,\�jB�\\�{�קr9�\�HO�JH(���>\�\�ԡ-�>7�TAL4g8tʔT��I\n.,nA;\�! \�MYZ\�\�(�5U\�c\�\�\�OY[&\�\�0s\�i�yI!\��\�y�%�x�	I.�\�\�q\�L�&J�3�>��l\�*\�$8޵wqHΦ�k#�v\�ix��:uiI%�\��\0Q1R���\�\�f~�����J��\0\ZF\��\�l9\07$���+�V:�0.\�2�\�MPhw	x�X�\��\0crlyG�\�J�\�\r��|E+J���Q��<C�z\�9�\n�� �N�h����\Z�Z���\�r\�A?\n\n��������\�H)R��v<\�+��R�\�\�D�ML�\�\�HF���?��\�>`8;�\"�\�(�Z���\�\��Wՠ\�*j�e�,�^-ڒ��\�3�\�fe\�]�Ú֬�CN�\�:n9\��T��b�\�\�(L\��,(mjQ\�c\���d\�i��\���\�\\�\'TX�\�G<ɣ\�M\�&հ\�\�W!\��\�$]�;\�,睕\�(��OR\�\�`�<Nz���V���\ZҦC�2\�a\08�\�@��\n���\0q�T�JVR�\�\�\r}c\�M\�F��V(\�\��h#��)(*(*\�\���~ў\�\��cUف*\�y�g�T#Q�[�V��d�I3\��1kp~�&w�R&jҐ*va\�Qw\�$=�Sq�\�d�5ھ��ڜY\�UPI	o6s�%m-,�,3@c\�5�\�d\��S�,�	��\0ΪU\�1��qv�\0q\�ٜ0�iIL�]J�n@ߤiҲ\�\0���\�d�W(�R��X$%uqFohc�e�Q�\Z]�`z\�=[0\0\�\�N�b�\�\'��KPט��\\�$\�h�.c)ATm\�_\�RR�<o�byS�\\\�0s\�\����q (\�).?V\�0ʵ�\�JN\�MǬ�\0�^\�z6�9\�\�Gl\0r!\�\�=�x�Xe\0�\�(\�\�`f3�x@%\�\�q\�/f�1��M=G��0�\�5�\\\�,h@y�\�\�\�*\�H�Lr�e��yX�\�\�\��\nD\�It�� �{D\����6\�l��گ�KS�b\'\� �\��ȼX\��:T�L�\�4 ��֐\�>h--l\�Y*-c� ��\"ZS�$\�\�\��\�\�j�\��\�g/\�\Z]�\�$��\�\�\���4��\�\��,\���Y�57;_����X�W\�{X�c-�=�|���6{�R\�Lc�;Q\�X�6be�?��=:�,\�5\\�-l\n\�AbK�z@q���o\�\�f1SgI\�$����߭�3�$K�؂�r\�\�Y�$�\0��\�&a&�� �u$�Z\�h-ղ ��*-�\�*v�eL*6!�z(Z�����\�TZ��ϧ�6g�e͓���X\�32��i\�jo\�*\�<�-v\��Q�y�u*\�L*�T\��c԰�cOM\�h��8�IU@w<pz�N\�\�\�V���C6�#fؐ\�*�\�q\�@\��3\�\0�3Iң�\n?\�\�\�\�1JR��ڭO/�2a{?4�\�,]��>f\�\�s0�MkR�L\0\\\�#0�W�8 �:W_z�\���T@\�ȯ�j{Ǆ�5?5\�\Z	M\�\n�\�դ�GP�\�N_�;YJ�3|:�I�1��Ӹޣ�g�\�\�J��\�~A\�\�\�S)U$Z�#�\n�WA�\����V�N1\�հ�eOBUATՁqc\�-&\�\�i!D����\�\�\n=�\�	�J�X ط\�xk\09������	��!\�\�p�ȥK���֑&\"C�\�\04\�\��\"R\���[x�\��c�/! �\"{^�\�ԅ{�~�,�\�f0\�-��5@4\�;e<\�)Z�HS�4RHsg� \�S\��\�J\�V]˳��?�ݭc�W,\�!�\�\��K���N*b\r	h�+9F�?g\�S5@�DrVg�\�\�RS\�ռ\�\�b��5X����i�\0?�凤%*�\\��\�I\��2P\�#Ju+�Y\�C�>U�QW��r\�\�\�ul��!�\�%j	\0\06\�\�\�PH7&\�w1�織�3�J�J\'C`\�n<\��\0f�\�\"b����R�U�\�\�B�Hʻ��\��\Z�\��@��9P}�xW\�{R�S\�4�ip�6����\�X����\�;E��W1E*S�O\0\0��j�,��Y�\�gZdw�;8S\�z��\�\����di \�Z�\��B,\�I�$�ݬ�&�0s\�w��\�\��Ku\"[�E\\%\�is\�Y� \�2n8\��\'\�Z\��F+�\�\�2zԑ�B�\0��l�p�U,���b�\�ko�!�fZB�6\�\r}�W,�\0���r� \�TO\�eȚ:�~�\�<\�v\"`J�\�Z�?\�dP,(\n��\�\�j��\�\�R�z��\�jm@W\���s�TV\\QE�4o8A\�p�\�\�U��\�\�񠔵%U\n�6�XA��A�\Z��~ \�\����\'\'��I�����B\�#���	�fo\�Ps�{�\�\�\�\��\�R�1\0i\'�~z�PV\��,�\��\�\"�P�*M=X�#7\��x&M\�e+�i�&\�\��O5\�\�\�j�)4>p�&`N�L\'\�n~���JG,\"�\�;Tƞ�\��\0դ�(�,�cL�\n�O���z\�_\�\�\�Zg��:T\nI;V�C���)	@)�\\�P\��\�My;��jW#\"\�0m?ŵ\0\��,�ä-�\0?�����o)(\���C6��ox��%D�^��;y�N�k\�_\�q��`ʸ�B�\��x\�;��Rq�x��\�d�h:�T\�\�>u�K\r�@a,��\�\��v�\�,\�\0��#�~a\�iM��E`~\�(\�\�\nD\�\�(%l\�Ė�\�C<@�BيV*\�M�x���2�^��\�:�V�	�g�K�s\�*�R	ҥY\�Z\�H�3- ��\�\�\�q\�*\"�Q�]\�v\"\�h��\�*$�S����#��wp3!�|˘\��iR�\�\�P)�J,ۅ���YYR>%�\'Φ)/6�>c)��\�\Z0�	BBA\��	a@\�zÖ~\0�\��\�\�T�\�a\�Je$�eֺ�mM���hI\�᮫�CX�\r94��v{G*rP[Sj4srj���pb�\�L�&��.\�\�\�\�*M�+$\�M��+w\0\�t1\�x\0�R86;�\�\�󘬳��\�\�\n��Ġa\��\�\�o�X�����hf�Jg-+�Y	ֶԥ6ե���ߓ.��\���\nI�{��U@$�T>�C\�-/ݥ�4��E�\�J��C_�H;\��^%օ�\0\�\�D�j})Qj\����>c-i\�O��thS˲�U�9r~C\�	fiHԅ1��P�� ]��\�\n\��O��T��{�\���I3ĦRQV��\�`�#�uNo\�\"d�\nU��\��a5e�4\0s�}��峻�}!�\0X�f}\�R\\\n�\�k��\�a:������\�\�ry;F}�R\�hU�٠�G\�t�Zio�P�9�=\�\��J9��HU�� 5 �\�m���:A34��0Qv�_M7�m�Z�u!j�IrP��\�^c\�c��ʦ.����m�\�`D�6��\�&#��\�OӲ*A\��@�����DH��L+.I$�ż����\Z��a\�k\�#uWҨ*�G��+��cFR\�2%�\\z\�+RӨ�sa�\�\n9`y���8H~�\�\Z6��#\"\��l]`)�QX\�G�Jm����\�!\�dF��KT�&\�Иy\�e\�6In�\�*ಥ%,Tz|U\'ږ�,V�>�(3=VJ���\0q`�\�mFk\��\"\�)\��l��cM���jJ�ըn\��(�7��ik\\��!���\�l�$Y�F\�	�8HPX �p\�b�L�s\\�6�y�qY\�geL)@E�\�}\"�A����UN�:*�R>q�5J��8\" �2��Շȥ!)}��U�j?X	�͕-iC�9b\\�^�\��hr\0ZBP���I;q\0��\0�;B\���b\�ކ3��m\�r!\� mX��\�ؤ\0�K֖�#\�EǛ@�2g�\�O�>��{�9^�{ԝ�/�k\�/�)\�\��\�c��\�U��̧�\�3V�	�\�AS>#\�~s\Z\�W�RBQ(\'JhI��5.\��-8�Q %I\�-�[\�\�Q\�d��~=!mK�`_˔�>L�p\nPb�&���%T\�Hp䘿/0\�	S\� �s[�\�:��}T��\�7\"��\�\�����\�n~<\0\�g\�O \�P\0�r!�D\�mJ\n5M�#�S�v7��o�|&\�X��\r6�\�9\�\�c�\���4�	�1�\��ՐQD;��%\�<��Je��TH��r��\�\�(d8ӭ��XTܘ���w4\�˛\�V���C\�\0ٵQ\�]�\�򙒢G��\�����j�T�\�Sۈ����H)3\n�\�o~��B3,aq��\')\�TY�ܒ>Q*i���\�JRN�\�S\�\��bA�u(�z��\�x�{�\�T�K3`~N\�\�\�1��\�\�}<�\�b,�.	HAQQ�\�;�\�yE�\�\0\nt�v\0zoH\�z�֨�X3/:�W�\0\r<�\�;�KLV�R��\�l\�a�@f\"�����P\�ߞ�P�g�*��O��\�EyӔ\\_����қ\�֯\�+�����\�@;�\�Q\�Ɠ�Fڛ\�*g�RPLĻ�y3�M�M(ZJ\�\r\�\�@\�s�\�U\"Y\�\�ܖ\��y�%a�B�\�@\�x�\�zB��6�b\�\�\�%�\�R�-Nu\n\"��\�\�.��\��	#\�4hB��)u��F�8��I jH\�^<ϑ;�\�П����XRd��\��KK�(\�l:������Z+v9�D\��qUҦ�gdS�;�IJ� ���:r�\�� ֤�JEj�ܰ��r0\�E�u\��]G��\0��P��L��$q\�\�RS\�%ؾ��j��ߘ�{C6I(R�R\Z1\�hV�I`��\�3L<\�L%	ArH�4!Uޡ��4��{f�f!�\�+&)��+Rv�)�ܕ*d\�$�2�,\�u��K/4	Wx�\�\�Y��*} d\�r���\�8�RjjUG��s�,#��Ұvd���i`|\'�PH;P߬t\�v���s�����\n�?�JJhH��K�`\�A��k��5+\�\r\��P\�3Dʔ]@���O.�P��\�I��KjB_p5��\�w\�\�P�qܜ�%��Ŷ�a7�y\�K\�꽮!�d\�\�I\0���\�/\�\�3\�\�i�0\��(�ON����\�7Qz�\'0#���\�#.��T\nV�;�\\���j\�N�c/\�\�b	L�P]E�砆\���8<�G��~�\0�\�$�z�o�h���]�g�4+\��T��s�i��\0\�!�Of�~)\�.�\��79\�\�\�hɄ.]Xx�ɿV>\�;R�o\�<P \�\��KT\�\�XQ�uP�\����ݥjA.\�\�\\��+��`F7\�\�-�₴\����\�f�r巏S�\0\�Z��\n;�G�\�Bfm��JJJ<L\�2�X��� �Y�$%	wJ��ۭ\�{ʜ�\��\��{YjtM�	�ܞ��\�.`�\�Z5\n\Zy\Z\�\�\Z{Cݧ�RU�(�$��T\�!���7:�Rj\�j)\�)��X̋\�\n\�f\�R\�\�*-D��moS\'�	e)j\0\�N\�pZ�\�2�RG5��e\��� <4\�E��\�\�!�\�\�6�( s��\n\�q���jr�@\�\��\\�\�R��;\�\�\�?�J����_�H\Z�HW�Ā֡�X%t�@�\�]�pl\�W,���\�t�~s�J�4�\��\�>_�2�\0�K�d���+\���\�6t�0\0ƀ�#���Ƭ�GXn\�	p\�B�$ާϬTL��\0:Y�\�z&(���4������A�$>\�\�)\��BFddȗ2`^�iҢ\�g*���x�^��-,Ṩ�ǬY��\�o��9�aB\�\��g�3�\�x�\�O|E\�X=\�\�\�V���#cw���eq�\\\�$�\�a�\�NZRPAu�\�\�O��\�,j`I2���&#\'�k\�>\�\�����Y~\nZ�\�\\\�\���\�\�0��H�\���\�Җ�-@$ҤF��\�i\�~ ��(��}�\�0\�\�p�jQ,��z�K�N!��\�@S\�`\�\�4\�~L�KV�8������6\"5l�*3Z\���@��G�\�uXڝ�\�\��:RJ��.�\�\�\\\\\�\�\�Z�sR܂C�\��n�\�\�\n�$\��M\�=\"\\�Ik/�\�=�ǜ\�2�\�#���XT�WŦ�ˤF�O\��\�\�\Z\�`���\�ޔ-�x��\0 �+c���\�F�#2�\�t��Δ���*\�ܗ0#�!(BHS$�:\�TcJ��E<n-!JO�\�\�Hb\� d���Y\�G\�\�O\�K\�\�l�O\�@\�\0\�øZ��ov0ҙ#\�8\�s�<\n�s\��\�\�8\�\��\0�\�8�\"oh{1���wN��Iۣ�Adv�t�dj\���ZIa_	nw�85��K!�w�V�E�OA�J��J��0�j�\nFqe��\'\�ɘ\�))v�\Z�\�n)h]\�3�	R\�\�\�H��gr\�^<ᐥ�H$���Ju���@!H)�Z|\'\�}\�2�\r\�<�&}���Q|A9\'gU���L��\'T\�w;���\�2���iN�������\�a�\��\��S�l\�j��\�-\�\�\�I!\�:�.o\�\�m��\�Q��߬��r�)�D���y\�\�\�K\Z��\�3�x\'.X�+�h�b�b\�j�b\��ۻ\�\�X�$�\\X\�,<\�S�\�r���,���A\�7\�$F��Ed��k3�\�D�\��ޕ\�9\"vTs��EHW����NaV>b�\0\�m�\0ht\�\�J\�j\"\�\�h#/̳�@b\�%��\���SW�0aق�L+�\�aZBMC\�\�HhFT���$\��~�ѐ�zv,�ZM	\�\�g����\0\nZSoZ\�&�^�\�t\�\�\�\�/V�\�E��/^�3$�Q\�^�W*\�\���J�h<F\�\�<\\\�+P@*f��:s�\�;`\�\�(�\�,uT��\�S\���1ꔠ��)Pَ\� ̃$L\\\�$�@%L�I\0҃\�\�*f\�r���Ru�\�\\\�٠�	1iuK\\�\Z�!�\�9\�#\�\\p\�j��3\�e)�*\�\�͸k�^+��u3�\0�!�<�\�=Oʧɞ��W\�\���.9x�4�\��-\�b�b\nWp\�0�\�E#?d\0庚�\�l\�SW�	*W7�˲2c�$K.\�I�R[\��7`0)�\ZZ4�5:~�{\�V@\��\0(\�+7\'��3+��#R�T�	\�O��E\�&��%v�E/�����)c\�#�5\�h�^Z��)�MiS�\�)^�\�$\�٬\Z�T\n\�Z���\�q΁\�m_��� 0f��\�g�R���p\��>}c̎ڠ�YJKX��\0\�Dj.��؈�\�\�&\n\�R;\�,�(k\�\��z=`�f0faT��{�\"���\�&c*ciJ�\0)\�$��}�ͻ�\Za��u>�g޴dg�L{\�rt��&���/�\�RE��/�y�#w��M�\�\�Ғ�5�`Y��b� �\�\����( \�\��D�K�@�#r�\�\"�\'�\�\�\�\�S$%�B��5\�+\����=C�v\�D\Z�2%�Ȑ`qEA�#I).ކ�X�0!%\�v[�J�q\������\���IMB\�l7�l9�g0L�C��.Q�+T\�\�@I���kssP!l\�$\\��8�ٯ\�w��\�I,�N�\Z��1��V\�\r�0���h�L�1w3\�ʔ%\�:ԭ@�b|��\� \�\�Ґ	\r�q�,[,x���>�f�JU<�\0l\�\�o^�~�r�7��O\\\��\�R�u\�\��~\�c�w�\�1SI�	!\�W\�}c=�*t����\�*\Z\�m�\��<\\�\�\0���[�\0\��\�chR\0�\�Л��v\'�Y\0�\�@\0!��B��	R�\�r\�Ya@R\�h9�\�=を\n\\\'\"��GG\�\�9\�i�))���J\�ć�}�	�xLJ4�]\�hG��\�!K\�>$�k\�\�~�$�1?\��	�t��\�\�-��\�BJ��q\�F&���w*@\\~w+B\�1*kR�n\�_�X\�QU \r ��\�\�G\r��\�\�Ѓ^�\�U\�L��~t�\�-Ȏ\'��	$�P�%�0\�ڼ�:�uP�}>\�=v!B�.�TҠX��X\�+0�\�r\�@>#F_�҄��j\�\r�O�;\�A\�\�L�QHUEH�ys\�Z�;�*\���<����\�%Q/�A6R\�\'\�\�\�_\0�BV\�K ia�k��N9ːdҤ��\�Jc̙\�\"��\����\�\r�ba\��N�L�\�! \�)\����o�&bp\�*	J�\�սC��\���4�E$tc�\0\�U�XW�D�S��?�\�\�n̅�!먞[\�eʓz޵��\'�{t4���a\�]6~x\'��f80�_\�x@��<\�\�$\�ZK�\�U\�ffҀ\�T	_�\�U���J\0*5�ox\�ۨP�\�,ɸ`;��w#\�\�\�:cH\��!I)+pX��\�ȏU�a?w\0�ș\Zыs�$�d�Pq\�<�����d����8�*J��\�\�㬠͙\�҂\0\���`\��Ƣ�Ueψ�j]�!~\��\0Z��rɔ,V�ӊ\�y\�r�\�n��\n\�K7�\��7n_x��\0G��˱`1��\�|qa��\"�C�Q<\��s$�R�\Z\rB���͖SZW\�\"\� ,2��O� D�\��=\�y\��\nk�D�\� �*T�,l9O�\"�2_�D���5��\�Gr�A\�	\�q2�\�!JҝJ ��\�\�\��\�ࡨ\�\�\�\��aL�AԒ_Շ\���\�\�\�\n�t�Iٙ\�4��\�a\�?x\�u\\B،�nBV��.\�4\�fJYK�\�\r\�1K\n		�~���{)��\�)N�00\�Α}J�H,9�\�L����:�98�s��CO���\�V���\�#6_�++5	��\���<r\�*V�\�D3\�z�?\�\����\�\�x\�{}\�\�Q�\n\0�\�?+]\�Vz���JҭHs��\�\�!�F\r\�|�~^<�\0וȘ�$V�/ՠ\�\�[ښ��s\�\��\�a@@�X��/\r�<Ĺ.]\�~\�*�_+L�%>jUrZ�ǔ[VVR�H\'`\��c��(\�(Y@\�a�4\���w���D\�h:X�0�\'�O\�U<�Q�\�e����ԕ�#�^�e,����\�\��JHp�w-��Z<d\�f\�J���:W\�\r]ΤxUR(Y۫@~\�&J�U4�A-�\�[|A׷~fg\�,B� Z>\��\��\0c��\0e~�?�*v�\�!\�\�b\�a�aݤ]A�&���:1��\"i��eT\�ho��\Z\n�8\�/�\�*b���\�\�cAs|�(,�\�\�{\'ϓ\n�~\�J��!�&�%!7���@��!JQ\��\�.@X��B³�J:�Z\�kCқ\�6[�!DQ^\�~\�{\r�9\�2i\n09�$\��TK k!_\�\�I�`\�\�jZ�h��N�}K8n#\�\�zSߘ`G\�S�e�T)\0�\Z0$��\�\�cL��@I-W0\�զ����@ď\�4�Ґ�d�\�\�V,�.8\�(}��8\�V������7��\Z����\�\�\�\�\�&�@Z����1\�\��2ҝ-\�\�;W[0齆D_���Be�%\\�}\�|_�*>\r���\�\�\�2����T\��\�Tha\�\�&�N\�(w$�ү}P\�`�0-�q��f�IT�z�M���1$\�Ц,����ᔤ3��\�\Zb0\n	\0��|���\�^?�Y�KO��������\�؃��?�\�`\�8p�Q�\0\�I&K���zҔ��ř\���[ʳ4�D����$xH���=�_W��\�Coy\��}3�\�<\�<㔤���R��\�>p����\�x��̑0:T\�Z��-�g�Ij\��<\�I\0�\�\r�<RL\�#\�Iul�\�\�k�msl9PJ�ԣ�nɁ�62�Η���cÃF\�!�-$\�\��fw�Kv4؆�D�\��V�8R>9����Ժ�Ǻ$cV%R�\�\0G%�3Xw$�\n�~׏x�Fr҇5�nb~\nnĐC�(T[֢�fOfu\�\�ǌ�,$��V��T�\\�\�\�!ϳ�\r)\�C9�<BOa�ŭJ\�\�wX\0\r\��XXC,���\ZR�)�T�U�&�\�7\�pЖ��l��j[��\�\Z�:t\�qd=-s\�A��S�\�X4$5B}\�\"B�\�*\�\�}/h\'�F�T\�2�����Xi� g\�V�CH�\��Al<��0�\�;J$�_Ε4a\�\'BB�@��\0x�\���^\�d�Ji�1>\0���\�;	\�e�\��G�U\rA�ݪ_|�m\�x\���6K��B�ڞ������N�P�I\�p\��`�\�Oi&.o�z%/c\�0S Ƅ\�\�A=`ƅfo:�|\�\��\�<w�\\V�z\�YX?�s�\��\�G��\��R\n���<}!g�����\���Y~w!2HL\�k�\��yDX9\�P-\ZQR\�U]\�O_�\n\�\�\0\"/M`�\�\�3�k�5.�i4,|\�G��\"pp��(\�u�7&\�S�̑�@?�y�T\�L��l\�TyA~�lu\�q8\�>�h2\�\�IJ岘�;7Q՛�R\��\����B�\\\�1\�\�%\�+(��R+�\�E)������\�#\�\Z�\���~{�C&\�\�\�\�\�U��\��\�У1�%\'\�N��\nYhV�=k��RZǓ-r��hjj�<|ɪ\�f��\�\"�)\���Ӧ�r�u���:!���\�h9?1:	F�@�%���!S�\�\�9̖v!E\�@�\�y�c\�~4�4��P���\�̔�J\\\�J���vޑ��B��wrI�/\Z�e\�ُ\�\�۵@c\��w�Wr��\Z\�$Klk�\��7!�����^�\�\�\�wJf\�\�Ĳ\��`~�5L���(���\rv��j\�_BS�*���\���\�k9bz6�S�!!G\�\np�g\��C-I*J]@P?\�B�\"a����cpG�et<\���\�\��\�\�\�)��T�\�T�T�ց�+N&bҝ/o�O\��zT��>��4G��\�捣�䙔\�K	f�?\rs]�g�*i`\�+�x�=\�\�iBj+\�\�\�{�\�~q�!��Ʈ|�\��PQ�\�\n\�\"Y�OP&U�R\�\�ho\��\0>�\�\�	)z\�\�R\�\�\�T\�v]r�iUO\�~�\�d\���F�o�ox%�,��N����v\�\�F�b\��\�\�$\�\�4��	~*\�\�\�M̴���SPs\�d9��u�Rǌ\'MK��`��\�aRDe���\�k�RRJI;#Ĝ\�0�}\�<NR�)\n��\�O\�h��gR0\�\�\�\�����\�J؈�a�#����`����F��\�\��x���RYE$��z��\�\nH\�1��?�\�\r`{(P+1J���@=\�Q�ڀ\�LDR�\�\ne�aPa1�D\���\�l��?M\�X\�d2P뙤�j�3\�>�G��S��5���\�\�ǁǺ�\�Dĥ\�<j\�\�x�D�C\�!���E\�F #>\�\�{�\�Je�~tm\�zy�����aU�#>#\0�xHQ/\��1k)\�	� ��z\�`�H�+\0��h-{����\�,�!J�IR�P)`=`�U�T�\�\�9���)=\�T�$�S�c�\�$��	đ\�\�R\�.c;6�m j\�mJr_�b\��() �[Ģ\�?�>\�s�2];��c1.nM6P}.\�m�\��E�\�>ѷ�*�-%,�\�:�\��hr3B\�Z����\�u\�\�> 5ۅ�,�\Z\'f\�\�;�,4&\�\�\�s\0�hA�\�䘕,�K�\�F�t����CufF�[\�����g�zW��s�+O�/@)4\�\�$�\�L�\�\�5>�T癱��$y\�\�z4�U�7\�hG\�r\�&g��Eûu\r\�H\�&,M\\��\�\�+�ms\�	\\�\��\'\�w�\�\n\�|y�څ\�f_��EV�z�\0\",\�\�,0�Rl�o\�M_�AI!\��xa��! $��:J�\����K\�T������\�Q���7T�B��T�oAx\�pr�\�<2V���\�s\����ʤ��њ/�\0M(�4>��Ń�e\�}l6\�\�\�7D\�\�\�\�\��\0\�#H�R:�!_���\�΄�\�\�W,\ZK�Ox�\�ƷPp-gP֟\�\n�v\�s\�7c�+&\�\�I\�|*}*\0\Z�\��hӰ8�)��<y�%##J��E!�\�H�G�@\0\�\�H:�{yB�X���r�F��\�հ\������l���R�~\�	/k�Ԕ\�⡁;1��f��X���\�\�1F�#��)a�,\�vx\r`wFT\�@+N��7�\�!�\r�<\�8\�2f\r*�\�>ɗ\��E��{ǣm�X��9&qc\0��eɘ�c �\��E/\�Fx�\�I�)P�±A$\r&��}h۷�\�qU�dv��\'\�2�͔\�d�9�Ǽf�xMX�l(\�\�Ѭv?�@J�\Z�\��b\�q\�ʕFP~�\�\\\�{���<3�j���� oh�9\�\�\�N�4�[\�~�ǁ�J�\ne�$\r��Lg�`\�Kdg D\�\�c���P��\0v`\\�\�\nX�\�\Z��\�\nU*5�#\�th\�v�\�*$&�ѓ*\�\'NB\�\�@\0��ܝ\�\�%�Y�ޱ\�Ўw��%�O�\�P\\�\0�٩\�\��I�ʘJ\�HX9\�\�Z�`\�\�$.DM\�a\��oH�fx\�LL�d(���ÒO\0V::6��	 J1$�f���D�%G��bM��\���8\\,����\�y������Da\�c̸�(��=c8\�&[1\�CP_Ƃ�t!\�v���Կ�\�U�p؅��\�@H�\'S�(9�aP��\nSrI��}c��ִ��q��v\�1$�TR���_��y�IM*8�1\�ћi��r9�0�	Hp\0�y��2�RRX�4�\�::��,x����MJ\��\�;uxѰ\�dM�!JH)\��sSm�c��A���\�g8\�i\�f�e�\Z�K�&\��[�\�A@\�6\� ۃ�{#\�\�}%�I4r~�w.\\�Z٭oǎ���K��\�\�F�\�a�!B��7Q�еڬ�dաI�,0)K��\�\�8\�趘�|�Ǩ]e|\�d�4�R\�zm⇎\�cBP5FI$\\\�\�\�tt\Z��+{�&\�\�(*@u\0Y�7�\�vC���<�8(Lo�_8\�\�y��ndȁx�x\�\�q,`L���ֺ\r�(c\"NQ0!DU\0\�\�\Zg��h+�q;5�J�����\0+ΰo���13B\�Gx|)w $|Oj��tt�\0\�\�B�!!z�%%��Zřr��	s\�1\�і�f�\'�\�','2021-02-04');
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
