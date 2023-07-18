USE [HardWareTEch]
GO
/****** Object:  Table [dbo].[Produto_Venda]    Script Date: 23/06/2023 09:46:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Produto_Venda](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idProduto] [int] NOT NULL,
	[quantidade] [int] NOT NULL,
	[valorUnitario] [decimal](10, 2) NOT NULL,
	[idVenda] [int] NOT NULL,
 CONSTRAINT [PK_Produto_Venda] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Venda]    Script Date: 23/06/2023 09:46:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Venda](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idCliente] [int] NOT NULL,
	[dataVenda] [datetime] NOT NULL,
	[valorTotal] [decimal](10, 2) NOT NULL,
 CONSTRAINT [PK_Venda] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Produto_Venda]  WITH CHECK ADD  CONSTRAINT [FK_Produto_Venda_Produto] FOREIGN KEY([idProduto])
REFERENCES [dbo].[Produto] ([id])
GO
ALTER TABLE [dbo].[Produto_Venda] CHECK CONSTRAINT [FK_Produto_Venda_Produto]
GO
ALTER TABLE [dbo].[Produto_Venda]  WITH CHECK ADD  CONSTRAINT [FK_Produto_Venda_Venda] FOREIGN KEY([idVenda])
REFERENCES [dbo].[Venda] ([id])
GO
ALTER TABLE [dbo].[Produto_Venda] CHECK CONSTRAINT [FK_Produto_Venda_Venda]
GO
ALTER TABLE [dbo].[Venda]  WITH CHECK ADD  CONSTRAINT [FK_Venda_Cliente] FOREIGN KEY([idCliente])
REFERENCES [dbo].[Cliente] ([id])
GO
ALTER TABLE [dbo].[Venda] CHECK CONSTRAINT [FK_Venda_Cliente]
GO
