CREATE TABLE `tbclientes` (
  `Cod_Cliente` int NOT NULL AUTO_INCREMENT,
  `Nome` varchar(255) DEFAULT NULL,
  `Cidade` varchar(255) DEFAULT NULL,
  `UF` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`Cod_Cliente`),
  KEY `Cod_Cliente_idx` (`Cod_Cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

CREATE TABLE `tbpedidodadosgerais` (
  `Num_Pedido` int NOT NULL AUTO_INCREMENT,
  `Data_Emissao` varchar(10) DEFAULT NULL,
  `Cod_Cliente` int NOT NULL,
  `Valor_Total` double DEFAULT NULL,
  PRIMARY KEY (`Num_Pedido`),
  KEY `idxNumPedido` (`Num_Pedido`) /*!80000 INVISIBLE */,
  KEY `idxCodCliente` (`Cod_Cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

CREATE TABLE `tbpedidoprodutos` (
  `Autoincrem` int NOT NULL AUTO_INCREMENT,
  `Num_Pedido` int NOT NULL,
  `Cod_Produto` varchar(10) NOT NULL,
  `QTD` int DEFAULT NULL,
  `Valor_Unit` double DEFAULT NULL,
  `Valor_Total` double DEFAULT NULL,
  PRIMARY KEY (`Autoincrem`),
  KEY `idxNumPedido` (`Num_Pedido`) /*!80000 INVISIBLE */,
  KEY `idxCodProduto` (`Cod_Produto`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_c

CREATE TABLE `tbprodutos` (
  `Cod_Produto` varchar(10) NOT NULL,
  `Descricao` varchar(255) DEFAULT NULL,
  `Preco_Venda` double DEFAULT NULL,
  PRIMARY KEY (`Cod_Produto`),
  KEY `Cod_Produto` (`Cod_Produto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci