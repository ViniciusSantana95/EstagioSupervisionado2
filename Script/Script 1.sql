USE [ControleManutencao]
GO
/****** Object:  Table [dbo].[Produto]    Script Date: 23/06/2023 08:56:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Produto](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nome_produto] [varchar](100) NULL,
	[descricao] [varchar](500) NULL,
	[preco] [decimal](10, 2) NOT NULL,
	[Estoque] [int] NULL,
	[datacadastro] [date] NOT NULL,
	[marca] [varchar](50) NULL,
	[idCategoria] [int] NOT NULL,
 CONSTRAINT [PK_Produto] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cliente]    Script Date: 23/06/2023 08:56:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cliente](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[CPF] [varchar](14) NOT NULL,
	[nome_cliente] [varchar](50) NOT NULL,
	[endereco] [varchar](50) NOT NULL,
	[cidade] [varchar](50) NOT NULL,
	[bairro] [varchar](50) NOT NULL,
	[telefone] [varchar](20) NOT NULL,
	[email] [varchar](255) NOT NULL,
	[numero_endereco] [varchar](10) NOT NULL,
 CONSTRAINT [PK_Cliente] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Produto_Cliente_Manutencao]    Script Date: 23/06/2023 08:56:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Produto_Cliente_Manutencao](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idCliente] [int] NOT NULL,
	[idProduto] [int] NULL,
	[dataCadastro] [datetime] NOT NULL,
	[dataFinalizacao] [datetime] NOT NULL,
	[Feito] [bit] NOT NULL,
	[nome_manutencao] [varchar](50) NOT NULL,
	[descricao] [varchar](100) NOT NULL,
	[idServico] [int] NOT NULL,
 CONSTRAINT [PK_Produto_Cliente_Manutencao] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Servico]    Script Date: 23/06/2023 08:56:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Servico](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nome_servico] [varchar](50) NOT NULL,
	[descricao] [varchar](255) NOT NULL,
	[preco] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VW_Produto_Cliente_Manutencao]    Script Date: 23/06/2023 08:56:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_Produto_Cliente_Manutencao]
AS
SELECT        C.CPF, L.nome_produto, PCM.id, PCM.idCliente, PCM.idProduto, PCM.dataCadastro, PCM.dataFinalizacao, PCM.Feito, PCM.nome_manutencao, PCM.descricao, PCM.idServico, dbo.Servico.nome_servico, Cli.nome_cliente
FROM            dbo.Produto_Cliente_Manutencao AS PCM LEFT OUTER JOIN
                         dbo.Cliente AS C ON C.id = PCM.idCliente LEFT OUTER JOIN
                         dbo.Produto AS L ON L.id = PCM.idProduto LEFT OUTER JOIN
                         dbo.Cliente AS Cli ON Cli.id = PCM.idCliente LEFT OUTER JOIN
                         dbo.Servico ON PCM.idServico = dbo.Servico.id
GO
/****** Object:  Table [dbo].[Categoria]    Script Date: 23/06/2023 08:56:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categoria](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nome_categoria] [varchar](50) NOT NULL,
	[descricao] [varchar](500) NOT NULL,
 CONSTRAINT [PK_Categoria] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 23/06/2023 08:56:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nome_usuario] [varchar](50) NOT NULL,
	[login] [varchar](50) NOT NULL,
	[email] [varchar](50) NOT NULL,
	[senha] [varchar](50) NOT NULL,
	[datacadastro] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Cliente] ADD  DEFAULT ('sem telefone') FOR [telefone]
GO
ALTER TABLE [dbo].[Cliente] ADD  DEFAULT (NULL) FOR [email]
GO
ALTER TABLE [dbo].[Produto]  WITH CHECK ADD  CONSTRAINT [FK_Produto_Categoria] FOREIGN KEY([idCategoria])
REFERENCES [dbo].[Categoria] ([id])
GO
ALTER TABLE [dbo].[Produto] CHECK CONSTRAINT [FK_Produto_Categoria]
GO
ALTER TABLE [dbo].[Produto_Cliente_Manutencao]  WITH CHECK ADD  CONSTRAINT [FK_Produto_Cliente_Manutencao_Cliente] FOREIGN KEY([idCliente])
REFERENCES [dbo].[Cliente] ([id])
GO
ALTER TABLE [dbo].[Produto_Cliente_Manutencao] CHECK CONSTRAINT [FK_Produto_Cliente_Manutencao_Cliente]
GO
ALTER TABLE [dbo].[Produto_Cliente_Manutencao]  WITH CHECK ADD  CONSTRAINT [FK_Produto_Cliente_Manutencao_Produto] FOREIGN KEY([idProduto])
REFERENCES [dbo].[Produto] ([id])
GO
ALTER TABLE [dbo].[Produto_Cliente_Manutencao] CHECK CONSTRAINT [FK_Produto_Cliente_Manutencao_Produto]
GO
ALTER TABLE [dbo].[Produto_Cliente_Manutencao]  WITH CHECK ADD  CONSTRAINT [FK_Produto_Cliente_Manutencao_Servico] FOREIGN KEY([idServico])
REFERENCES [dbo].[Servico] ([id])
GO
ALTER TABLE [dbo].[Produto_Cliente_Manutencao] CHECK CONSTRAINT [FK_Produto_Cliente_Manutencao_Servico]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[60] 4[2] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "PCM"
            Begin Extent = 
               Top = 14
               Left = 533
               Bottom = 144
               Right = 729
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "C"
            Begin Extent = 
               Top = 13
               Left = 35
               Bottom = 143
               Right = 231
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "L"
            Begin Extent = 
               Top = 158
               Left = 40
               Bottom = 288
               Right = 236
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Cli"
            Begin Extent = 
               Top = 189
               Left = 303
               Bottom = 319
               Right = 499
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Servico"
            Begin Extent = 
               Top = 50
               Left = 768
               Bottom = 180
               Right = 964
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VW_Produto_Cliente_Manutencao'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VW_Produto_Cliente_Manutencao'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VW_Produto_Cliente_Manutencao'
GO
