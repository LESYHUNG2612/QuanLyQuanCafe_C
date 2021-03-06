USE [master]
GO
/****** Object:  Database [CoffeeShop]    Script Date: 12/2/2020 9:10:42 PM ******/
CREATE DATABASE [CoffeeShop]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CoffeeShop', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\CoffeeShop.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'CoffeeShop_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\CoffeeShop_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [CoffeeShop] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CoffeeShop].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CoffeeShop] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CoffeeShop] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CoffeeShop] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CoffeeShop] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CoffeeShop] SET ARITHABORT OFF 
GO
ALTER DATABASE [CoffeeShop] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CoffeeShop] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CoffeeShop] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CoffeeShop] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CoffeeShop] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CoffeeShop] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CoffeeShop] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CoffeeShop] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CoffeeShop] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CoffeeShop] SET  ENABLE_BROKER 
GO
ALTER DATABASE [CoffeeShop] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CoffeeShop] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CoffeeShop] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CoffeeShop] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CoffeeShop] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CoffeeShop] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CoffeeShop] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CoffeeShop] SET RECOVERY FULL 
GO
ALTER DATABASE [CoffeeShop] SET  MULTI_USER 
GO
ALTER DATABASE [CoffeeShop] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CoffeeShop] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CoffeeShop] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CoffeeShop] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [CoffeeShop] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [CoffeeShop] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'CoffeeShop', N'ON'
GO
ALTER DATABASE [CoffeeShop] SET QUERY_STORE = OFF
GO
USE [CoffeeShop]
GO
/****** Object:  UserDefinedFunction [dbo].[fuConvertToUnsign1]    Script Date: 12/2/2020 9:10:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fuConvertToUnsign1] ( @strInput NVARCHAR(4000) ) RETURNS NVARCHAR(4000) AS BEGIN IF @strInput IS NULL RETURN @strInput IF @strInput = '' RETURN @strInput DECLARE @RT NVARCHAR(4000) DECLARE @SIGN_CHARS NCHAR(136) DECLARE @UNSIGN_CHARS NCHAR (136) SET @SIGN_CHARS = N'ăâđêôơưàảãạáằẳẵặắầẩẫậấèẻẽẹéềểễệế ìỉĩịíòỏõọóồổỗộốờởỡợớùủũụúừửữựứỳỷỹỵý ĂÂĐÊÔƠƯÀẢÃẠÁẰẲẴẶẮẦẨẪẬẤÈẺẼẸÉỀỂỄỆẾÌỈĨỊÍ ÒỎÕỌÓỒỔỖỘỐỜỞỠỢỚÙỦŨỤÚỪỬỮỰỨỲỶỸỴÝ' +NCHAR(272)+ NCHAR(208) SET @UNSIGN_CHARS = N'aadeoouaaaaaaaaaaaaaaaeeeeeeeeee iiiiiooooooooooooooouuuuuuuuuuyyyyy AADEOOUAAAAAAAAAAAAAAAEEEEEEEEEEIIIII OOOOOOOOOOOOOOOUUUUUUUUUUYYYYYDD' DECLARE @COUNTER int DECLARE @COUNTER1 int SET @COUNTER = 1 WHILE (@COUNTER <=LEN(@strInput)) BEGIN SET @COUNTER1 = 1 WHILE (@COUNTER1 <=LEN(@SIGN_CHARS)+1) BEGIN IF UNICODE(SUBSTRING(@SIGN_CHARS, @COUNTER1,1)) = UNICODE(SUBSTRING(@strInput,@COUNTER ,1) ) BEGIN IF @COUNTER=1 SET @strInput = SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)-1) ELSE SET @strInput = SUBSTRING(@strInput, 1, @COUNTER-1) +SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)- @COUNTER) BREAK END SET @COUNTER1 = @COUNTER1 +1 END SET @COUNTER = @COUNTER +1 END SET @strInput = replace(@strInput,' ','-') RETURN @strInput END
GO
/****** Object:  Table [dbo].[Account]    Script Date: 12/2/2020 9:10:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[UserName] [nvarchar](100) NOT NULL,
	[DisplayName] [nvarchar](100) NOT NULL,
	[PassWord] [nvarchar](1000) NOT NULL,
	[Type] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Bill]    Script Date: 12/2/2020 9:10:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bill](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[DateCheckIn] [date] NOT NULL,
	[DateCheckOut] [date] NULL,
	[idTable] [int] NOT NULL,
	[status] [int] NOT NULL,
	[discount] [int] NULL,
	[TotalPrice] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BillInfo]    Script Date: 12/2/2020 9:10:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BillInfo](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idBill] [int] NOT NULL,
	[idFood] [int] NOT NULL,
	[count] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Food]    Script Date: 12/2/2020 9:10:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Food](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[idCategory] [int] NOT NULL,
	[price] [float] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FoodCategory]    Script Date: 12/2/2020 9:10:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FoodCategory](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TableFood]    Script Date: 12/2/2020 9:10:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TableFood](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[status] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT ((0)) FOR [Type]
GO
ALTER TABLE [dbo].[Bill] ADD  DEFAULT (getdate()) FOR [DateCheckIn]
GO
ALTER TABLE [dbo].[Bill] ADD  DEFAULT ((0)) FOR [status]
GO
ALTER TABLE [dbo].[Bill] ADD  DEFAULT ((0)) FOR [discount]
GO
ALTER TABLE [dbo].[Bill] ADD  DEFAULT ((0)) FOR [TotalPrice]
GO
ALTER TABLE [dbo].[BillInfo] ADD  DEFAULT ((0)) FOR [count]
GO
ALTER TABLE [dbo].[Food] ADD  DEFAULT (N'Chưa đặt tên') FOR [name]
GO
ALTER TABLE [dbo].[Food] ADD  DEFAULT ((0)) FOR [price]
GO
ALTER TABLE [dbo].[FoodCategory] ADD  DEFAULT (N'Chưa đặt tên') FOR [name]
GO
ALTER TABLE [dbo].[TableFood] ADD  DEFAULT (N'Bàn chưa đặt tên') FOR [name]
GO
ALTER TABLE [dbo].[TableFood] ADD  DEFAULT (N'Trống') FOR [status]
GO
ALTER TABLE [dbo].[Bill]  WITH CHECK ADD FOREIGN KEY([idTable])
REFERENCES [dbo].[TableFood] ([id])
GO
ALTER TABLE [dbo].[BillInfo]  WITH CHECK ADD FOREIGN KEY([idBill])
REFERENCES [dbo].[Bill] ([id])
GO
ALTER TABLE [dbo].[BillInfo]  WITH CHECK ADD FOREIGN KEY([idFood])
REFERENCES [dbo].[Food] ([id])
GO
ALTER TABLE [dbo].[Food]  WITH CHECK ADD FOREIGN KEY([idCategory])
REFERENCES [dbo].[FoodCategory] ([id])
GO
/****** Object:  StoredProcedure [dbo].[DeleteBillInfoByFoodID]    Script Date: 12/2/2020 9:10:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[DeleteBillInfoByFoodID]
@foodID INT
AS
BEGIN
	DELETE BillInfo WHERE idFood = @foodID
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteFood]    Script Date: 12/2/2020 9:10:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[DeleteFood]
@id INT
AS
BEGIN
	EXEC DeleteBillInfoByFoodID @id
	DELETE Food WHERE id = @id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_CategoryInsert]    Script Date: 12/2/2020 9:10:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_CategoryInsert]
@name NVARCHAR(100)
AS
BEGIN
	IF (NOT EXISTS (SELECT * FROM FoodCategory WHERE name = @name))
		INSERT FoodCategory(name) VALUES (@name)
END
GO
/****** Object:  StoredProcedure [dbo].[USP_CategoryUpdate]    Script Date: 12/2/2020 9:10:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_CategoryUpdate]
@id INT, @name NVARCHAR(100)
AS
BEGIN
	UPDATE FoodCategory
	SET name = @name
	WHERE id = @id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_CheckoutBill]    Script Date: 12/2/2020 9:10:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_CheckoutBill]
@billID INT, @discount INT, @totalPrice FLOAT
AS
BEGIN
	UPDATE Bill
	SET status = 1, discount = @discount, DateCheckOut = GETDATE(), TotalPrice = @totalPrice
	WHERE id = @billID
END
GO
/****** Object:  StoredProcedure [dbo].[USP_CreateAccount]    Script Date: 12/2/2020 9:10:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_CreateAccount]
@userName NVARCHAR(100), @displayName NVARCHAR(100), @type INT
AS
BEGIN
	IF (NOT EXISTS(SELECT * FROM Account WHERE UserName = @userName))
	BEGIN
		INSERT Account(UserName, DisplayName, Type, PassWord)
		VALUES (@userName, @displayName, @type, 'password')
	END
END
GO
/****** Object:  StoredProcedure [dbo].[USP_DeleteAccount]    Script Date: 12/2/2020 9:10:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_DeleteAccount]
@userName NVARCHAR(100)
AS
BEGIN
	DELETE Account WHERE UserName = @userName
END
GO
/****** Object:  StoredProcedure [dbo].[USP_DeleteBillInfoByFoodID]    Script Date: 12/2/2020 9:10:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_DeleteBillInfoByFoodID]
@foodID INT
AS
BEGIN
	DELETE BillInfo WHERE idFood = @foodID
END
GO
/****** Object:  StoredProcedure [dbo].[USP_DeleteFood]    Script Date: 12/2/2020 9:10:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_DeleteFood]
@id INT
AS
BEGIN
	EXEC USP_DeleteBillInfoByFoodID @id
	DELETE Food WHERE id = @id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_GetAccountByUserName]    Script Date: 12/2/2020 9:10:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_GetAccountByUserName]
@userName NVARCHAR(100)
AS
BEGIN
	SELECT * FROM dbo.Account WHERE UserName = @username
END
GO
/****** Object:  StoredProcedure [dbo].[USP_GetAllAccount]    Script Date: 12/2/2020 9:10:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GetAllAccount]
AS
BEGIN
	SELECT UserName, DisplayName, Type FROM Account
END
GO
/****** Object:  StoredProcedure [dbo].[USP_GetAllCategory]    Script Date: 12/2/2020 9:10:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GetAllCategory]
AS SELECT * FROM FoodCategory
GO
/****** Object:  StoredProcedure [dbo].[USP_GetAllFood]    Script Date: 12/2/2020 9:10:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GetAllFood]
AS SELECT * FROM Food
GO
/****** Object:  StoredProcedure [dbo].[USP_GetBillInfosByBillID]    Script Date: 12/2/2020 9:10:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GetBillInfosByBillID]
@billID INT
AS
BEGIN
	SELECT * FROM BillInfo WHERE idBill = @billID
END
GO
/****** Object:  StoredProcedure [dbo].[USP_GetCategoryByID]    Script Date: 12/2/2020 9:10:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GetCategoryByID]
@id INT
AS
BEGIN
	SELECT * FROM FoodCategory WHERE id = @id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_GetFoodByCategoryID]    Script Date: 12/2/2020 9:10:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GetFoodByCategoryID]
@catID INT
AS
BEGIN
	SELECT * FROM Food WHERE Food.idCategory = @catID
END
GO
/****** Object:  StoredProcedure [dbo].[USP_GetListBillByDate]    Script Date: 12/2/2020 9:10:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GetListBillByDate]
@checkIn DATE, @checkOut DATE
AS
BEGIN
	SELECT TableFood.name, DateCheckIn, DateCheckOut, discount, TotalPrice
	FROM Bill 
	JOIN TableFood ON Bill.idTable = TableFood.id
	WHERE Bill.status = 1 AND Bill.DateCheckIn >= @checkIn AND Bill.DateCheckOut <= @checkOut
END
GO
/****** Object:  StoredProcedure [dbo].[USP_GetMenuByBillID]    Script Date: 12/2/2020 9:10:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GetMenuByBillID]
@billID INT
AS
BEGIN
	SELECT Food.name, Food.price, BillInfo.count FROM BillInfo
	JOIN Bill ON BillInfo.idBill = Bill.id
	JOIN Food ON BillInfo.idFood = Food.id
	WHERE BillInfo.idBill = @billID
END
GO
/****** Object:  StoredProcedure [dbo].[USP_GetTableList]    Script Date: 12/2/2020 9:10:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GetTableList]
AS SELECT * FROM TableFood
GO
/****** Object:  StoredProcedure [dbo].[USP_GetUncheckBillsByTableID]    Script Date: 12/2/2020 9:10:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GetUncheckBillsByTableID]
@tableID INT
AS
BEGIN
	SELECT * FROM Bill WHERE idTable = @tableID AND status = 0
END
GO
/****** Object:  StoredProcedure [dbo].[USP_InsertBill]    Script Date: 12/2/2020 9:10:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_InsertBill]
@idTable INT
AS
BEGIN
	IF (NOT EXISTS(SELECT * FROM Bill WHERE idTable = @idTable AND status = 0))
	BEGIN
		INSERT Bill(DateCheckIn, DateCheckOut, idTable, status, discount)
		VALUES (GETDATE(), NULL, @idTable, 0, 0)
	END
END
GO
/****** Object:  StoredProcedure [dbo].[USP_InsertBillInfo]    Script Date: 12/2/2020 9:10:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_InsertBillInfo]
@idBill INT, @idFood INT, @count INT
AS
BEGIN
	DECLARE @isExistsBillInfo INT
	DECLARE @foodCount INT = 1

	SELECT @isExistsBillInfo = id, @foodCount = count FROM BillInfo WHERE idBill = @idBill AND idFood = @idFood

	IF (@isExistsBillInfo > 0)
	BEGIN
		DECLARE @newCount INT = @foodCount + @count
		IF (@newCount > 0)
			UPDATE BillInfo
			SET count = @newCount
			WHERE idBill = @idBill AND idFood = @idFood
		ELSE
			DELETE BillInfo WHERE idBill = @idBill AND idFood = @idFood
	END
	ELSE
	BEGIN
		INSERT BillInfo(idBill, idFood, count)
		VALUES (@idBill, @idFood, @count)
	END
END
GO
/****** Object:  StoredProcedure [dbo].[USP_InsertFood]    Script Date: 12/2/2020 9:10:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_InsertFood]
@name NVARCHAR(100), @idCategory INT, @price FLOAT
AS
BEGIN
	IF (EXISTS (SELECT * FROM FoodCategory WHERE id = @idCategory))
	BEGIN
		INSERT Food(name, idCategory, price)
		VALUES (@name, @idCategory, @price)
	END
END
GO
/****** Object:  StoredProcedure [dbo].[USP_Login]    Script Date: 12/2/2020 9:10:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_Login]
@userName NVARCHAR(100),
@password NVARCHAR(100)
AS
BEGIN
	SELECT * FROM dbo.Account WHERE UserName = @userName AND PassWord = @password
END
GO
/****** Object:  StoredProcedure [dbo].[USP_ResetPassword]    Script Date: 12/2/2020 9:10:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_ResetPassword]
@userName NVARCHAR(100)
AS
BEGIN
	UPDATE Account
	SET PassWord = 'password'
	WHERE UserName = @userName
END 
GO
/****** Object:  StoredProcedure [dbo].[USP_SearchFoodByName]    Script Date: 12/2/2020 9:10:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_SearchFoodByName]
@name NVARCHAR(100)
AS
BEGIN
	SELECT * FROM Food WHERE dbo.fuConvertToUnsign1(name) LIKE '%'+ dbo.fuConvertToUnsign1(@name) +'%'
END
GO
/****** Object:  StoredProcedure [dbo].[USP_TableInsert]    Script Date: 12/2/2020 9:10:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_TableInsert]
@name NVARCHAR(100)
AS
BEGIN
	IF (NOT EXISTS(SELECT * FROM TableFood WHERE name = @name))
		INSERT TableFood(name) VALUES (@name)
END
GO
/****** Object:  StoredProcedure [dbo].[USP_TableUpdate]    Script Date: 12/2/2020 9:10:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_TableUpdate]
@id INT, @name NVARCHAR(100), @status NVARCHAR(100)
AS
BEGIN
	UPDATE TableFood
	SET name = @name, status = @status
	WHERE id = @id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_UpdaetFood]    Script Date: 12/2/2020 9:10:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_UpdaetFood]
@id INT, @name NVARCHAR(100), @idCategory INT, @price FLOAT
AS
BEGIN
	IF (EXISTS (SELECT * FROM FoodCategory WHERE id = @idCategory))
	BEGIN
		UPDATE Food
		SET name = @name, idCategory = @idCategory, price = @price
		WHERE id = @id
	END
END
GO
/****** Object:  StoredProcedure [dbo].[USP_UpdateAccount]    Script Date: 12/2/2020 9:10:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_UpdateAccount]
@userName NVARCHAR(100), @displayName NVARCHAR(100), @password NVARCHAR(100), @newPassword NVARCHAR(100)
AS
BEGIN
	DECLARE @isRightPass INT = 0

	SELECT @isRightPass = COUNT(*) FROM Account WHERE UserName = @userName AND Password = @password

	IF (@isRightPass = 1)
	BEGIN
		IF (@newPassword = NULL OR @newPassword = '')
			UPDATE Account SET DisplayName = @displayName WHERE Username = @userName
		ELSE
			UPDATE Account SET DisplayName = @displayName, Password = @newPassword WHERE Username = @userName
	END
END
GO
/****** Object:  StoredProcedure [dbo].[USP_UpdateAccountAdmin]    Script Date: 12/2/2020 9:10:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_UpdateAccountAdmin]
@userName NVARCHAR(100), @displayName NVARCHAR(100), @type INT
AS
BEGIN
		UPDATE Account 
		SET DisplayName = @displayName, Type = @type
		WHERE UserName = @userName
END
GO
/****** Object:  StoredProcedure [dbo].[USP_UpdateFood]    Script Date: 12/2/2020 9:10:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_UpdateFood]
@id INT, @name NVARCHAR(100), @idCategory INT, @price FLOAT
AS
BEGIN
	IF (EXISTS (SELECT * FROM FoodCategory WHERE id = @idCategory))
	BEGIN
		UPDATE Food
		SET name = @name, idCategory = @idCategory, price = @price
		WHERE id = @id
	END
END
GO
USE [master]
GO
ALTER DATABASE [CoffeeShop] SET  READ_WRITE 
GO
