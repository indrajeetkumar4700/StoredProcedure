USE [AdventureWorks2019]
GO
/****** Object:  StoredProcedure [dbo].[prcSaveEmployeeData]    Script Date: 21-09-2022 12:22:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [procSaveEmployeeData]
@EmpName varchar(20),
@EmpEmail varchar(20),
@NationalIDNumber varchar(15),
@LoginID nvarchar(256),
@OrganizationNode hierarchyId,
@JobTitle nvarchar(50),
@BirthDate date,
@MaritalStatus nchar(1),
@Gender nchar(1),
@HireDate date,
@SalariedFlag tinyint,
@VacationHours smallint,
@SickLeaveHours smallint,
@CurrentFlag tinyint,
@Rate money
AS
BEGIN
    -- Set IDENTITYINSERT ON
    
BEGIN TRY
    
    BEGIN TRANSACTION
        -- INSERTING DATA IN MASTER TABLE
        
        INSERT INTO Person.BusinessEntity
        ([rowguid], [ModifiedDate])
        Values(NEWID(), getdate())



       Declare @Id bigint
        Select @ID = SCOPE_IDENTITY()



       INSERT INTO HumanResources.Employee
        ([BusinessEntityID],[NationalIDNumber], [LoginID], [OrganizationNode], [JobTitle], [BirthDate], [MaritalStatus],
        [Gender], [HireDate], [SalariedFlag], [VacationHours], [SickLeaveHours],
        [CurrentFlag], [ModifiedDate])
        VALUES(@Id, @NationalIDNumber,@LoginID,@OrganizationNode, @JobTitle,@BirthDate, @MaritalStatus,@Gender,
        @HireDate, @SalariedFlag,@VacationHours,@SickLeaveHours,@CurrentFlag, getdate())
                
         -- @@Identity
    
        -- INSERT / UPADET DATA in CHILD TABLE(S)
        INSERT INTO HumanResources.EmployeePayHistory
        ([BusinessEntityID], [RateChangeDate], [Rate], [PayFrequency], [ModifiedDate])
        VALUES(@Id, getdate(), @Rate, '1',getdate())
    
    COMMIT TRANSACTION



END TRY
BEGIN CATCH
    if(@@TRANCOUNT>0)
        ROLLBACK TRANSACTION



       EXEC dbo.uspLogError
END CATCH
END

@EmpName varchar(20),
@EmpEmail varchar(20),
@NationalIDNumber varchar(15),
@LoginID nvarchar(256),
@OrganizationNode hierarchyId,
@JobTitle nvarchar(50),
@BirthDate date,
@MaritalStatus nchar(1),
@Gender nchar(1),
@HireDate date,
@SalariedFlag tinyint,
@VacationHours smallint,
@SickLeaveHours smallint,
@CurrentFlag tinyint,
@Rate money

EXEC dbo.uspLogError

@EmpName Indrajeet kumar,
@EmpEmail indrajeetkumar13241@gmail.com,
@NationalIDNumber Indra123,
@LoginID INDRA@1,
@OrganizationNode  2,
@JobTitle = Sales,
@BirthDate = date,
@MaritalStatus = S,
@Gender = M,
@HireDate = 12/03/2o16,
@SalariedFlag = 1,
@VacationHours = 10,
@SickLeaveHours = 10,
@CurrentFlag = 1,
@Rate = 2.3

declare@return
exec @return = [dbo].[prcsaveEmployeeData] 'Indrajeet','abc@gmail.com','1','1',null,'software','2000-09-10','M','M','2022-01-08','0','3','1','1',2000
