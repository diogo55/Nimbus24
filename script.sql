USE [Nimbus24]
GO
/****** Object:  Table [dbo].[Avaliação]    Script Date: 6/10/2018 20:06:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Avaliação](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[avaliacao] [int] NULL,
	[obs] [varchar](50) NULL,
	[Servico_id] [int] NULL,
 CONSTRAINT [PK_Avaliação] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cidade]    Script Date: 6/10/2018 20:06:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cidade](
	[Cidade] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Cidade] PRIMARY KEY CLUSTERED 
(
	[Cidade] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cliente]    Script Date: 6/10/2018 20:06:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cliente](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[mail] [varchar](50) NULL,
	[nome] [varchar](50) NULL,
	[password] [varchar](50) NULL,
	[contacto] [varchar](50) NULL,
 CONSTRAINT [PK_Cliente] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Morada]    Script Date: 6/10/2018 20:06:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Morada](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[rua] [varchar](50) NULL,
	[porta] [int] NULL,
	[codPostal] [varchar](50) NULL,
	[Cidade_cidade] [varchar](50) NULL,
 CONSTRAINT [PK_Morada] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Preferencia]    Script Date: 6/10/2018 20:06:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Preferencia](
	[id_Prestador] [int] NOT NULL,
	[id_Cliente] [int] NOT NULL,
 CONSTRAINT [PK_Preferencia] PRIMARY KEY CLUSTERED 
(
	[id_Prestador] ASC,
	[id_Cliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Prestador]    Script Date: 6/10/2018 20:06:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Prestador](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[nome] [varchar](50) NULL,
	[mail] [varchar](50) NULL,
	[rating] [int] NULL,
	[password] [varchar](50) NULL,
	[contacto] [varchar](50) NULL,
	[Cidade_cidade] [varchar](50) NULL,
 CONSTRAINT [PK_Table_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Serviço]    Script Date: 6/10/2018 20:06:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Serviço](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[preço] [decimal](6, 2) NULL,
	[data] [datetime] NULL,
	[estado] [int] NULL,
	[idCliente] [int] NULL,
	[idPrestador] [int] NULL,
	[descrição] [varchar](50) NULL,
	[morada_id] [int] NULL,
 CONSTRAINT [PK_Serviço] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoServico]    Script Date: 6/10/2018 20:06:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoServico](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[tipo] [int] NULL,
	[preco] [decimal](6, 2) NULL,
	[id_Prestador] [int] NULL,
	[negociavel] [int] NULL,
 CONSTRAINT [PK_TipoServico] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Avaliação]  WITH CHECK ADD  CONSTRAINT [FK_Avaliação_Serviço] FOREIGN KEY([Servico_id])
REFERENCES [dbo].[Serviço] ([id])
GO
ALTER TABLE [dbo].[Avaliação] CHECK CONSTRAINT [FK_Avaliação_Serviço]
GO
ALTER TABLE [dbo].[Morada]  WITH CHECK ADD  CONSTRAINT [FK_Morada_Cidade] FOREIGN KEY([Cidade_cidade])
REFERENCES [dbo].[Cidade] ([Cidade])
GO
ALTER TABLE [dbo].[Morada] CHECK CONSTRAINT [FK_Morada_Cidade]
GO
ALTER TABLE [dbo].[Preferencia]  WITH CHECK ADD  CONSTRAINT [FK_Preferencia_Cliente] FOREIGN KEY([id_Cliente])
REFERENCES [dbo].[Cliente] ([id])
GO
ALTER TABLE [dbo].[Preferencia] CHECK CONSTRAINT [FK_Preferencia_Cliente]
GO
ALTER TABLE [dbo].[Preferencia]  WITH CHECK ADD  CONSTRAINT [FK_Preferencia_Prestador] FOREIGN KEY([id_Prestador])
REFERENCES [dbo].[Prestador] ([Id])
GO
ALTER TABLE [dbo].[Preferencia] CHECK CONSTRAINT [FK_Preferencia_Prestador]
GO
ALTER TABLE [dbo].[Prestador]  WITH CHECK ADD  CONSTRAINT [FK_Prestador_Cidade] FOREIGN KEY([Cidade_cidade])
REFERENCES [dbo].[Cidade] ([Cidade])
GO
ALTER TABLE [dbo].[Prestador] CHECK CONSTRAINT [FK_Prestador_Cidade]
GO
ALTER TABLE [dbo].[Serviço]  WITH CHECK ADD  CONSTRAINT [FK_Serviço_Cliente] FOREIGN KEY([idCliente])
REFERENCES [dbo].[Cliente] ([id])
GO
ALTER TABLE [dbo].[Serviço] CHECK CONSTRAINT [FK_Serviço_Cliente]
GO
ALTER TABLE [dbo].[Serviço]  WITH CHECK ADD  CONSTRAINT [FK_Serviço_Morada] FOREIGN KEY([morada_id])
REFERENCES [dbo].[Morada] ([id])
GO
ALTER TABLE [dbo].[Serviço] CHECK CONSTRAINT [FK_Serviço_Morada]
GO
ALTER TABLE [dbo].[Serviço]  WITH CHECK ADD  CONSTRAINT [FK_Serviço_Prestador] FOREIGN KEY([idPrestador])
REFERENCES [dbo].[Prestador] ([Id])
GO
ALTER TABLE [dbo].[Serviço] CHECK CONSTRAINT [FK_Serviço_Prestador]
GO
ALTER TABLE [dbo].[TipoServico]  WITH CHECK ADD  CONSTRAINT [FK_TipoServico_Prestador] FOREIGN KEY([id_Prestador])
REFERENCES [dbo].[Prestador] ([Id])
GO
ALTER TABLE [dbo].[TipoServico] CHECK CONSTRAINT [FK_TipoServico_Prestador]
GO
