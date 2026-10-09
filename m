Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013066.outbound.protection.outlook.com [40.107.159.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57414E2F22;
	Fri,  9 Oct 2026 14:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791555159; cv=fail; b=U1vi/KSr97TpMEyuV4cZ3cYY0k7dD506B7EgYzzBmaVY29Ny+S9Z5DblM9l9w6B38jYR6aPsFr2pRN14hjXHtCEK1jXfrqn3ZeMSW3NDahoKOnooEoKcVNfhYtWVwNKc5tazXkplchKaCBX2LXHdkrzPBDitPEfjmyuam3iEcLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791555159; c=relaxed/simple;
	bh=yH7H545zGD+/QzJP2SiNtAm3WdIRlDRjge6vefZh6ak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=G2H8eqrSz7TPhliEYwQbRupGbH/bKy9HlVQto/d8MkHx3rNuuCUDpExYwS602U4QAHDl4MegPln0wxlKvnhJEppc6l7uCLb35jtNA9NeMsTPFlPn+9jVNQs5SZxKCsq74IGsjUyvOB9AmmZSrmVSVVi3ebwCXEH0Sboi8bLQARU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=rzXDPrjh; arc=fail smtp.client-ip=40.107.159.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="rzXDPrjh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VbEQPOWpqeEgkLC31fnWfZ67QOJkvPSEwz9Fb6XXJbb7Iad/ODC6DRFmXgoyHB053CefBaW2UhiXQ++xOV9DLKkxTmKA2kovUwAGXZt5bzOVk6XseZ920cVPqhvd43rWujL8uXTP/9d75fCivZmUgx4rRDcmsa1gHAIJHrusIKf5AKCbt5As0LxEORe1K0LUomgusBaIZTDFOL/yLsXQU6ePMvIwXww2lwEPBI/NwIlaKsfF9/TtIvdtCLUXlla/gYFc/1orCZQSddmzsXushtIqnJrVRCRoi3okG4Skyhm3HmSzFBawdyjKHk9CqKSIfb8KOvQ725LUSUKD6FDVyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2fgUoCkGgORmNwuu+wbZQyJgD8FhcaYDR8xOua7eJQ0=;
 b=c43kMTwM3jLUblGUW7ZRMFgaszGL8woPOMZchU8XkJC5/2lQ6yb/gENYF6/h+QwxM1CcluaLLnwU7N5cz+++sf7jjZ7wxR1MLfL0VwldxBwY56HozBKEBmp4ycs4YSB58w7yt+YvZJi3mP20LussXkFnPv9rhk9TOpu3d8Xj/ItJMkWxVyYwPFMTd7rGgUA0mae1znKJ7AqiCgx0uJhE7uHbltHAQf4zDYTcl9N4IXaOncrYG/JRCeW4K1QhPrknxV6+h042VHKkiUpFGCp9iDFIK+MubS7WzI4yDIgXgCNptIQICahdijbXAjJffgSH6MPBJbJ/+QJ0ZrTrVA5N0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fgUoCkGgORmNwuu+wbZQyJgD8FhcaYDR8xOua7eJQ0=;
 b=rzXDPrjhjue56xfQpzISmlLza45l66mFwUu+KnP/uUcmymcqYUhSAVVnimnzFf+LG1pAC5l3moWiqRl4iD4HKQyXOw3TM6HmtO4QDRf4410InhwzCdwUN1u4cyK12+qy0GErKmgG1fkM9AhtWnO2GtJZSdool0OhFRWxbhNKWFk=
Received: from OS6P279CA0168.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:38::7) by
 GV2PPF46F1FA715.eurprd02.prod.outlook.com (2603:10a6:158:401::5ce) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Fri, 9 Oct
 2026 14:12:31 +0000
Received: from WA1PEPF00009B3B.eurprd05.prod.outlook.com
 (2603:10a6:e10:38:cafe::33) by OS6P279CA0168.outlook.office365.com
 (2603:10a6:e10:38::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 9
 Oct 2026 14:12:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 WA1PEPF00009B3B.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 9 Oct 2026 14:12:31 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Fri, 9 Oct
 2026 16:12:24 +0200
Received: from se-mail10w.axis.com (10.20.40.10) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Fri, 9 Oct
 2026 16:12:24 +0200
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Fri, 9 Oct 2026 16:12:24 +0200
Received: from pc66231-2602.sto.se.axis.com (pc66231-2602.sto.se.axis.com [10.133.4.42])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 477721E52;
	Fri,  9 Oct 2026 16:12:24 +0200 (CEST)
Received: by pc66231-2602.sto.se.axis.com (Postfix, from userid 21940)
	id 2C36730604F4; Fri,  9 Oct 2026 16:12:24 +0200 (CEST)
From: Kanak Shilledar <kanak.shilledar@axis.com>
Date: Fri, 9 Oct 2026 16:12:10 +0200
Subject: [PATCH v6 5/6] iio: imu: inv_icm42607: Implement MREGx register
 access
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261009-b4-inv_icm42370p-v6-5-e53884f185ff@axis.com>
References: <20261009-b4-inv_icm42370p-v6-0-e53884f185ff@axis.com>
In-Reply-To: <20261009-b4-inv_icm42370p-v6-0-e53884f185ff@axis.com>
To: Henrik Grimler <henrik.grimler@axis.com>, Jonathan Cameron
	<jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Jean-Baptiste
 Maneyrol" <jean-baptiste.maneyrol@tdk.com>, Joshua Crofts
	<joshua.crofts1@gmail.com>, Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>
CC: Kanak Shilledar <kanak.shilledar@axis.com>, <kernel@axis.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=25333;
 i=kanak.shilledar@axis.com; h=from:subject:message-id;
 bh=yH7H545zGD+/QzJP2SiNtAm3WdIRlDRjge6vefZh6ak=;
 b=owGbwMvMwCV2JPnG7+2HZqUznlZLYsg68c1d/IVSk4ZMw+l30tv+zWC1fR/DkDeb1UWw6rTkH
 9a/ZXuMOkpZGMS4GGTFFFnOGW2P3p/8T3eOtNMlmDmsTCBDGLg4BWAiih6MDKv8Jv7/9LLRTln7
 3fXprxmVX+7SPfj2oMPzpyHspbKHT19mZJio5VS8dOYiX+/My5vK8qZem+XhoFHtxfFK57M3u6i
 rOysA
X-Developer-Key: i=kanak.shilledar@axis.com; a=openpgp;
 fpr=CDB0F1C8EAD5B522C7B3A77928221FF065DB55F9
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: WA1PEPF00009B3B:EE_|GV2PPF46F1FA715:EE_
X-MS-Office365-Filtering-Correlation-Id: 34dfb900-b03e-41e9-d221-08df260f5bbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|82310400026|36860700016|32650700020|1800799024|10067099003|56012099006|5023799004|6133799003|10063799003|11063799006|22082099003|18002099003|921020|3613699012;
X-Microsoft-Antispam-Message-Info:
	cNtjc2gdGi0U4DxFRNcIOdmMQec/KECfy3L+oiHmW9yaIinagflDfR0UOM5bzb/ZqLqajFrkWahNmVDGyxsEh1Z4LawiY5fAEhw5TNcO700CHsCucA4Tp0BYqnvocb2cKY3eGRVWL9aAS9pgJErWahDxZmyhDLQ0gR0XuDJNFtxedJXCMeRhK7NxX9DBdEjJdKLsWLmD8Jvm9knIoyEDkMhU2uWPxndk/p7vyz73evABhWr9vcjvdhuDfAtzUEjYQAWFRXReNBTANmOpLgtCc8gtD/EmC9ndMigAjz45nNCbinUwIIOlVoSkEvtxYokr6J1GF7Z3cBOy7978udt1ovI74i8DMToyYK78RcGHhUQyDgbEQbBGsv6FhKsIumr9uv3ABEFBP0qANnk0lNcXNwMTtMl5aiR0VP65/JYRmMZ5bgr293XnQYjrr+GzOzJzb5M9R/1ihNqIF0QhzljJ8aSOkAc01AWDOn+f/kv6jr2Hm0qHRcPQ+/51dYIn6mSFhBmWjbS8VTNiEDwDgcjrF59jfkBNyUUgFnphJ5qYyBG/u9lE8LjP50K9uwgT+sF5aaDoLeNEz1p2xflldAo+0/2brbX3qaR3uarWi2yrbG89b1iVNleWJpse6WRlnWCFWa+favJ8REM1TTVqYY0qw/tORRAaGHG0+yOCGXkUXZGL3YIyGk6z0sjuwwuywScNH2zbqfvR2Lv83ijXrkLG44Y9GuNJuC312LJ903xdzQ8=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(82310400026)(36860700016)(32650700020)(1800799024)(10067099003)(56012099006)(5023799004)(6133799003)(10063799003)(11063799006)(22082099003)(18002099003)(921020)(3613699012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NKG43ZStOD/p9S5zTqHgttUjiThkUi1ODRMd8XNwtKLW79v7uhwLZBrl0UlL4s3v0e1oqGHW4slIIbNyd7fkBANbHgQegv4gzgvU9Qk3EoxO5vb4KMOT41AMH94j4uNUt5lTWXp21Ikei+kkC7qbjws5S9l2yENosFvYavon3ISH36CvYE3L1DqDfGCor/DsQCaXtsEbgsamdC9lE3s3pV6U+kRDaJHGuBCLFrtBQFNMNv+arQAtFb8LsLBFGS5yrEeYmvLJSNhvn/h+DmcqHhagovw74DoI3F61xqqE0iWwoxrIUCKzI3ZU4HFqZsuYyf5pzW4K/4yow281g2JpJS3QJ01Y3S+xQKGGA2yG+SPb243TGDMr1RRed36bafk4SKVir15ZqaBptYH0kDVxiu394/9u3FD48832ihhICA2JKR1p0+QgolQ63SbELJEC
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 14:12:31.4971
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34dfb900-b03e-41e9-d221-08df260f5bbe
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	WA1PEPF00009B3B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PPF46F1FA715

The device supports indirect register access to different banks. A
specific routine needs to be followed when accessing the registers in
another bank as documented in the datasheet (section 13). This is
required for accessing registers configured via the user and
implementing buffer support. The implementation is inspired from the
icm45600 driver.

The banks are defined based on their initial bank access code which are
written to the BLK_SEL_* regs. However, there is a variation for MREG1
as User Bank 0 and MREG1 both share the same 0x00, so User Bank 1 has
0x00 and MREG1 has 0x01. When MREG1 register is accessed, then BLK_SEL_*
is written with 0x00 instead of 0x01. All the register access goes
through the 16 bit virtual regmap layered on top of the 8bit bus regmap.
Bank id in the upper byte and the register address in the lower byte.
Bank 0 accesses are forwarded to the bus regmap with the bank field
stripped, while MREG accesses are forwarded to bank switching sequence.

Due to the specific bank switching routine, it is not possible to use
regmap-ranges. Only User Bank 0 supports bulk read/writes whereas other
banks can only be accessed serially. Each time some data in the other
bank needs to be accessed, it should go through the complete bank
switching sequence.

Datasheet: https://www.invensense.tdk.com/en-us/products/3-axis/icm-42370-p
Datasheet: https://www.lcsc.com/product-detail/C5129967.html
Assisted-by: LLM
Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
---
LLM was used to implement the mreg back switching support.
---
 drivers/iio/imu/inv_icm42607/inv_icm42607.h      | 166 ++++++++++------
 drivers/iio/imu/inv_icm42607/inv_icm42607_core.c | 241 +++++++++++++++++++++--
 drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c  |   6 +
 3 files changed, 333 insertions(+), 80 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
index 674a9896fabb3..eecf4c46cbdb0 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
@@ -167,31 +167,59 @@ struct inv_icm42607_sensor_state {
 	int filter;
 };
 
-/* Virtual register addresses: @bank on MSB (4 upper bits), @address on LSB */
+/*
+ * Virtual register addresses: bank id in the upper byte, register address in
+ * the lower byte. Bank 0 is directly addressable on the bus. MREG banks are
+ * reached through the BLK_SEL/MADDR/M indirect access window, one byte per
+ * transaction (datasheet section 13, no burst support).
+ *
+ * MREG1 programs BLK_SEL = 0x00, which collides with the direct bank, so it
+ * gets the distinct virtual id 0x01. MREG2 and MREG3 virtual ids match their
+ * BLK_SEL values.
+ */
+#define INV_ICM42607_REG_BANK_MASK			GENMASK(15, 8)
+#define INV_ICM42607_REG_ADDR_MASK			GENMASK(7, 0)
+
+#define INV_ICM42607_BANK0					0x00
+#define INV_ICM42607_MREG1					0x01
+#define INV_ICM42607_MREG2					0x28
+#define INV_ICM42607_MREG3					0x50
+
+/* BLK_SEL value written to the device for each virtual bank id. */
+#define INV_ICM42607_MREG1_BLK_SEL			0x00
+#define INV_ICM42607_MREG2_BLK_SEL			0x28
+#define INV_ICM42607_MREG3_BLK_SEL			0x50
+
+/*
+ * Datasheet section 13, Accessing MREGx Registers: no bus access for 10us
+ * after programming the indirect access window.
+ */
+#define INV_ICM42607_MREG_ACCESS_DELAY_US		10
 
 /* Register Map for User Bank 0 */
-#define INV_ICM42607_REG_MCLK_RDY			0x00
+#define INV_ICM42607_REG_MCLK_RDY			0x0000
+#define INV_ICM42607_MCLK_RDY_BIT			BIT(3)
 
-#define INV_ICM42607_REG_DEVICE_CONFIG			0x01
+#define INV_ICM42607_REG_DEVICE_CONFIG			0x0001
 #define INV_ICM42607_DEVICE_CONFIG_SPI_AP_4WIRE		BIT(2)
 #define INV_ICM42607_DEVICE_CONFIG_SPI_MODE		BIT(0)
 
-#define INV_ICM42607_REG_SIGNAL_PATH_RESET		0x02
+#define INV_ICM42607_REG_SIGNAL_PATH_RESET		0x0002
 #define INV_ICM42607_SIGNAL_PATH_RESET_SOFT_RESET	BIT(4)
 #define INV_ICM42607_SIGNAL_PATH_RESET_FIFO_FLUSH	BIT(2)
 
-#define INV_ICM42607_REG_DRIVE_CONFIG1			0x03
+#define INV_ICM42607_REG_DRIVE_CONFIG1			0x0003
 #define INV_ICM42607_DRIVE_CONFIG1_I3C_DDR_MASK		GENMASK(5, 3)
 #define INV_ICM42607_DRIVE_CONFIG1_I3C_SDR_MASK		GENMASK(2, 0)
 
-#define INV_ICM42607_REG_DRIVE_CONFIG2			0x04
+#define INV_ICM42607_REG_DRIVE_CONFIG2			0x0004
 #define INV_ICM42607_DRIVE_CONFIG2_I2C_MASK		GENMASK(5, 3)
 #define INV_ICM42607_DRIVE_CONFIG2_ALL_MASK		GENMASK(2, 0)
 
-#define INV_ICM42607_REG_DRIVE_CONFIG3			0x05
+#define INV_ICM42607_REG_DRIVE_CONFIG3			0x0005
 #define INV_ICM42607_DRIVE_CONFIG3_SPI_MASK		GENMASK(2, 0)
 
-#define INV_ICM42607_REG_INT_CONFIG			0x06
+#define INV_ICM42607_REG_INT_CONFIG			0x0006
 #define INV_ICM42607_INT_CONFIG_INT2_LATCHED		BIT(5)
 #define INV_ICM42607_INT_CONFIG_INT2_PUSH_PULL		BIT(4)
 #define INV_ICM42607_INT_CONFIG_INT2_ACTIVE_HIGH	BIT(3)
@@ -202,81 +230,81 @@ struct inv_icm42607_sensor_state {
 #define INV_ICM42607_INT_CONFIG_INT1_ACTIVE_LOW		0x00
 
 /* all sensor data are 16 bits (2 registers wide) in big-endian */
-#define INV_ICM42607_REG_TEMP_DATA1			0x09
-#define INV_ICM42607_REG_TEMP_DATA0			0x0A
-#define INV_ICM42607_REG_ACCEL_DATA_X1			0x0B
-#define INV_ICM42607_REG_ACCEL_DATA_X0			0x0C
-#define INV_ICM42607_REG_ACCEL_DATA_Y1			0x0D
-#define INV_ICM42607_REG_ACCEL_DATA_Y0			0x0E
-#define INV_ICM42607_REG_ACCEL_DATA_Z1			0x0F
-#define INV_ICM42607_REG_ACCEL_DATA_Z0			0x10
-#define INV_ICM42607_REG_GYRO_DATA_X1			0x11
-#define INV_ICM42607_REG_GYRO_DATA_X0			0x12
-#define INV_ICM42607_REG_GYRO_DATA_Y1			0x13
-#define INV_ICM42607_REG_GYRO_DATA_Y0			0x14
-#define INV_ICM42607_REG_GYRO_DATA_Z1			0x15
-#define INV_ICM42607_REG_GYRO_DATA_Z0			0x16
+#define INV_ICM42607_REG_TEMP_DATA1			0x0009
+#define INV_ICM42607_REG_TEMP_DATA0			0x000A
+#define INV_ICM42607_REG_ACCEL_DATA_X1			0x000B
+#define INV_ICM42607_REG_ACCEL_DATA_X0			0x000C
+#define INV_ICM42607_REG_ACCEL_DATA_Y1			0x000D
+#define INV_ICM42607_REG_ACCEL_DATA_Y0			0x000E
+#define INV_ICM42607_REG_ACCEL_DATA_Z1			0x000F
+#define INV_ICM42607_REG_ACCEL_DATA_Z0			0x0010
+#define INV_ICM42607_REG_GYRO_DATA_X1			0x0011
+#define INV_ICM42607_REG_GYRO_DATA_X0			0x0012
+#define INV_ICM42607_REG_GYRO_DATA_Y1			0x0013
+#define INV_ICM42607_REG_GYRO_DATA_Y0			0x0014
+#define INV_ICM42607_REG_GYRO_DATA_Z1			0x0015
+#define INV_ICM42607_REG_GYRO_DATA_Z0			0x0016
 #define INV_ICM42607_DATA_INVALID			-32768
 
-#define INV_ICM42607_REG_TMST_FSYNCH			0x17
-#define INV_ICM42607_REG_TMST_FSYNCL			0x18
+#define INV_ICM42607_REG_TMST_FSYNCH			0x0017
+#define INV_ICM42607_REG_TMST_FSYNCL			0x0018
 
 /* APEX Data Registers */
-#define INV_ICM42607_REG_APEX_DATA0			0x31
-#define INV_ICM42607_REG_APEX_DATA1			0x32
-#define INV_ICM42607_REG_APEX_DATA2			0x33
-#define INV_ICM42607_REG_APEX_DATA3			0x34
-#define INV_ICM42607_REG_APEX_DATA4			0x1D
-#define INV_ICM42607_REG_APEX_DATA5			0x1E
-
-#define INV_ICM42607_REG_PWR_MGMT0			0x1F
+#define INV_ICM42607_REG_APEX_DATA0			0x0031
+#define INV_ICM42607_REG_APEX_DATA1			0x0032
+#define INV_ICM42607_REG_APEX_DATA2			0x0033
+#define INV_ICM42607_REG_APEX_DATA3			0x0034
+#define INV_ICM42607_REG_APEX_DATA4			0x001D
+#define INV_ICM42607_REG_APEX_DATA5			0x001E
+
+#define INV_ICM42607_REG_PWR_MGMT0			0x001F
 #define INV_ICM42607_PWR_MGMT0_ACCEL_LP_CLK_SEL		BIT(7)
 #define INV_ICM42607_PWR_MGMT0_IDLE			BIT(4)
 #define INV_ICM42607_PWR_MGMT0_GYRO_MODE_MASK		GENMASK(3, 2)
 #define INV_ICM42607_PWR_MGMT0_ACCEL_MODE_MASK		GENMASK(1, 0)
 
-#define INV_ICM42607_REG_GYRO_CONFIG0			0x20
+#define INV_ICM42607_REG_GYRO_CONFIG0			0x0020
 #define INV_ICM42607_GYRO_CONFIG0_FS_SEL_MASK		GENMASK(6, 5)
 #define INV_ICM42607_GYRO_CONFIG0_ODR_MASK		GENMASK(3, 0)
 
-#define INV_ICM42607_REG_ACCEL_CONFIG0			0x21
+#define INV_ICM42607_REG_ACCEL_CONFIG0			0x0021
 #define INV_ICM42607_ACCEL_CONFIG0_FS_SEL_MASK		GENMASK(6, 5)
 #define INV_ICM42607_ACCEL_CONFIG0_ODR_MASK		GENMASK(3, 0)
 
-#define INV_ICM42607_REG_TEMP_CONFIG0			0x22
+#define INV_ICM42607_REG_TEMP_CONFIG0			0x0022
 #define INV_ICM42607_TEMP_CONFIG0_FILTER_MASK		GENMASK(6, 4)
 
-#define INV_ICM42607_REG_GYRO_CONFIG1			0x23
+#define INV_ICM42607_REG_GYRO_CONFIG1			0x0023
 #define INV_ICM42607_GYRO_CONFIG1_FILTER_MASK		GENMASK(2, 0)
 
-#define INV_ICM42607_REG_ACCEL_CONFIG1			0x24
+#define INV_ICM42607_REG_ACCEL_CONFIG1			0x0024
 #define INV_ICM42607_ACCEL_CONFIG1_AVG_MASK		GENMASK(6, 4)
 #define INV_ICM42607_ACCEL_CONFIG1_FILTER_MASK		GENMASK(2, 0)
 
-#define INV_ICM42607_REG_APEX_CONFIG0			0x25
+#define INV_ICM42607_REG_APEX_CONFIG0			0x0025
 #define INV_ICM42607_APEX_CONFIG0_DMP_POWER_SAVE_EN	BIT(3)
 #define INV_ICM42607_APEX_CONFIG0_DMP_INIT_EN		BIT(2)
 #define INV_ICM42607_APEX_CONFIG0_DMP_MEM_RESET_EN	BIT(0)
 
-#define INV_ICM42607_REG_APEX_CONFIG1			0x26
+#define INV_ICM42607_REG_APEX_CONFIG1			0x0026
 #define INV_ICM42607_APEX_CONFIG1_SMD_ENABLE		BIT(6)
 #define INV_ICM42607_APEX_CONFIG1_FF_ENABLE		BIT(5)
 #define INV_ICM42607_APEX_CONFIG1_TILT_ENABLE		BIT(4)
 #define INV_ICM42607_APEX_CONFIG1_PED_ENABLE		BIT(3)
 #define INV_ICM42607_APEX_CONFIG1_DMP_ODR_MASK		GENMASK(1, 0)
 
-#define INV_ICM42607_REG_WOM_CONFIG			0x27
+#define INV_ICM42607_REG_WOM_CONFIG			0x0027
 #define INV_ICM42607_WOM_CONFIG_INT_DUR_MASK		GENMASK(4, 3)
 #define INV_ICM42607_WOM_CONFIG_INT_MODE		BIT(2)
 #define INV_ICM42607_WOM_CONFIG_MODE			BIT(1)
 #define INV_ICM42607_WOM_CONFIG_EN			BIT(0)
 
-#define INV_ICM42607_REG_FIFO_CONFIG1			0x28
+#define INV_ICM42607_REG_FIFO_CONFIG1			0x0028
 #define INV_ICM42607_FIFO_CONFIG1_MODE			BIT(1)
 #define INV_ICM42607_FIFO_CONFIG1_BYPASS		BIT(0)
 
-#define INV_ICM42607_REG_FIFO_CONFIG2			0x29
-#define INV_ICM42607_REG_FIFO_CONFIG3			0x2A
+#define INV_ICM42607_REG_FIFO_CONFIG2			0x0029
+#define INV_ICM42607_REG_FIFO_CONFIG3			0x002A
 #define INV_ICM42607_FIFO_WATERMARK_VAL(_wm)		\
 		cpu_to_le16((_wm) & GENMASK(11, 0))
 /* FIFO is 2048 bytes, let 12 samples for reading latency */
@@ -284,7 +312,7 @@ struct inv_icm42607_sensor_state {
 #define INV_ICM42607_FIFO_1SENSOR_PACKET_SIZE		8
 #define INV_ICM42607_FIFO_2SENSORS_PACKET_SIZE		16
 
-#define INV_ICM42607_REG_INT_SOURCE0			0x2B
+#define INV_ICM42607_REG_INT_SOURCE0			0x002B
 #define INV_ICM42607_INT_SOURCE0_ST_INT1_EN		BIT(7)
 #define INV_ICM42607_INT_SOURCE0_FSYNC_INT1_EN		BIT(6)
 #define INV_ICM42607_INT_SOURCE0_PLL_RDY_INT1_EN	BIT(5)
@@ -294,12 +322,12 @@ struct inv_icm42607_sensor_state {
 #define INV_ICM42607_INT_SOURCE0_FIFO_FULL_INT1_EN	BIT(1)
 #define INV_ICM42607_INT_SOURCE0_AGC_RDY_INT1_EN	BIT(0)
 
-#define INV_ICM42607_REG_INT_SOURCE1			0x2C
+#define INV_ICM42607_REG_INT_SOURCE1			0x002C
 #define INV_ICM42607_INT_SOURCE1_I3C_ERROR_INT1_EN	BIT(6)
 #define INV_ICM42607_INT_SOURCE1_SMD_INT1_EN		BIT(3)
 #define INV_ICM42607_INT_SOURCE1_WOM_INT1_EN		GENMASK(2, 0)
 
-#define INV_ICM42607_REG_INT_SOURCE3			0x2D
+#define INV_ICM42607_REG_INT_SOURCE3			0x002D
 #define INV_ICM42607_INT_SOURCE3_ST_INT2_EN		BIT(7)
 #define INV_ICM42607_INT_SOURCE3_FSYNC_INT2_EN		BIT(6)
 #define INV_ICM42607_INT_SOURCE3_PLL_RDY_INT2_EN	BIT(5)
@@ -309,17 +337,17 @@ struct inv_icm42607_sensor_state {
 #define INV_ICM42607_INT_SOURCE3_FIFO_FULL_INT2_EN	BIT(1)
 #define INV_ICM42607_INT_SOURCE3_AGC_RDY_INT2_EN	BIT(0)
 
-#define INV_ICM42607_REG_INT_SOURCE4			0x2E
+#define INV_ICM42607_REG_INT_SOURCE4			0x002E
 #define INV_ICM42607_INT_SOURCE4_I3C_ERROR_INT2_EN	BIT(6)
 #define INV_ICM42607_INT_SOURCE4_SMD_INT2_EN		BIT(3)
 #define INV_ICM42607_INT_SOURCE4_WOM_Z_INT2_EN		BIT(2)
 #define INV_ICM42607_INT_SOURCE4_WOM_Y_INT2_EN		BIT(1)
 #define INV_ICM42607_INT_SOURCE4_WOM_X_INT2_EN		BIT(0)
 
-#define INV_ICM42607_REG_FIFO_LOST_PKT0			0x2F
-#define INV_ICM42607_REG_FIFO_LOST_PKT1			0x30
+#define INV_ICM42607_REG_FIFO_LOST_PKT0			0x002F
+#define INV_ICM42607_REG_FIFO_LOST_PKT1			0x0030
 
-#define INV_ICM42607_REG_INTF_CONFIG0			0x35
+#define INV_ICM42607_REG_INTF_CONFIG0			0x0035
 #define INV_ICM42607_INTF_CONFIG0_FIFO_COUNT_FORMAT	BIT(6)
 #define INV_ICM42607_INTF_CONFIG0_FIFO_COUNT_ENDIAN	BIT(5)
 #define INV_ICM42607_INTF_CONFIG0_SENSOR_DATA_ENDIAN	BIT(4)
@@ -327,7 +355,7 @@ struct inv_icm42607_sensor_state {
 #define INV_ICM42607_INTF_CONFIG0_UI_SIFS_CFG_SPI_DIS	2
 #define INV_ICM42607_INTF_CONFIG0_UI_SIFS_CFG_I2C_DIS	3
 
-#define INV_ICM42607_REG_INTF_CONFIG1			0x36
+#define INV_ICM42607_REG_INTF_CONFIG1			0x0036
 #define INV_ICM42607_INTF_CONFIG1_I3C_SDR_EN		BIT(3)
 #define INV_ICM42607_INTF_CONFIG1_I3C_DDR_EN		BIT(2)
 #define INV_ICM42607_INTF_CONFIG1_CLKSEL_MASK		GENMASK(1, 0)
@@ -335,10 +363,10 @@ struct inv_icm42607_sensor_state {
 #define INV_ICM42607_INTF_CONFIG1_CLKSEL_PLL		1
 #define INV_ICM42607_INTF_CONFIG1_CLKSEL_OFF		2
 
-#define INV_ICM42607_REG_INT_STATUS_DRDY		0x39
+#define INV_ICM42607_REG_INT_STATUS_DRDY		0x0039
 #define INV_ICM42607_INT_STATUS_DRDY_DATA_RDY		BIT(0)
 
-#define INV_ICM42607_REG_INT_STATUS			0x3A
+#define INV_ICM42607_REG_INT_STATUS			0x003A
 #define INV_ICM42607_INT_STATUS_ST			BIT(7)
 #define INV_ICM42607_INT_STATUS_FSYNC			BIT(6)
 #define INV_ICM42607_INT_STATUS_PLL_RDY			BIT(5)
@@ -347,11 +375,11 @@ struct inv_icm42607_sensor_state {
 #define INV_ICM42607_INT_STATUS_FIFO_FULL		BIT(1)
 #define INV_ICM42607_INT_STATUS_AGC_RDY			BIT(0)
 
-#define INV_ICM42607_REG_INT_STATUS2			0x3B
+#define INV_ICM42607_REG_INT_STATUS2			0x003B
 #define INV_ICM42607_INT_STATUS2_SMD			BIT(3)
 #define INV_ICM42607_INT_STATUS2_WOM_INT		GENMASK(2, 0)
 
-#define INV_ICM42607_REG_INT_STATUS3			0x3C
+#define INV_ICM42607_REG_INT_STATUS3			0x003C
 #define INV_ICM42607_INT_STATUS3_STEP_DET		BIT(5)
 #define INV_ICM42607_INT_STATUS3_STEP_CNT_OVF		BIT(4)
 #define INV_ICM42607_INT_STATUS3_TILT_DET		BIT(3)
@@ -362,15 +390,35 @@ struct inv_icm42607_sensor_state {
  * FIFO count is 16 bits (2 registers) big-endian
  * FIFO data is a continuous read register to read FIFO content
  */
-#define INV_ICM42607_REG_FIFO_COUNTH			0x3D
-#define INV_ICM42607_REG_FIFO_COUNTL			0x3E
-#define INV_ICM42607_REG_FIFO_DATA			0x3F
+#define INV_ICM42607_REG_FIFO_COUNTH			0x003D
+#define INV_ICM42607_REG_FIFO_COUNTL			0x003E
+#define INV_ICM42607_REG_FIFO_DATA			0x003F
 
-#define INV_ICM42607_REG_WHOAMI				0x75
+#define INV_ICM42607_REG_WHOAMI				0x0075
 #define INV_ICM42370P_WHOAMI				0x0D
 #define INV_ICM42607P_WHOAMI				0x60
 #define INV_ICM42607_WHOAMI				0x67
 
+#define INV_ICM42607_REG_BLK_SEL_W			0x0079
+#define INV_ICM42607_REG_MADDR_W			0x007A
+#define INV_ICM42607_REG_M_W				0x007B
+#define INV_ICM42607_REG_BLK_SEL_R			0x007C
+#define INV_ICM42607_REG_MADDR_R			0x007D
+#define INV_ICM42607_REG_M_R				0x007E
+
+/* User Bank MREG 1 registers */
+#define INV_ICM42607_REG_OFFSET_USER0			0x014E
+#define INV_ICM42607_REG_OFFSET_USER1			0x014F
+#define INV_ICM42607_REG_OFFSET_USER2			0x0150
+#define INV_ICM42607_REG_OFFSET_USER3			0x0151
+#define INV_ICM42607_REG_OFFSET_USER4			0x0152
+#define INV_ICM42607_REG_OFFSET_USER5			0x0153
+#define INV_ICM42607_REG_OFFSET_USER6			0x0154
+#define INV_ICM42607_REG_OFFSET_USER7			0x0155
+#define INV_ICM42607_REG_OFFSET_USER8			0x0156
+
+/* User Bank MREG 3 registers */
+#define INV_ICM42607_REG_ZG_ST_DATA			0x5005
 /*
  * Timings as listed in section 3 of datasheet, all values listed in datasheet
  * in ms except temp startup time... setting all values in us and using
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
index 75c9617e5d1e7..a4393b54cc108 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
@@ -18,63 +18,255 @@
 #include <linux/time.h>
 #include <linux/timekeeping.h>
 #include <linux/types.h>
+#include <linux/unaligned.h>
 
 #include <asm/byteorder.h>
 
 #include "inv_icm42607.h"
 
-static bool inv_icm42607_is_readable_reg(struct device *dev, unsigned int reg)
+static int inv_icm42607_mclk_get(struct regmap *map, bool *idle_set)
 {
-	switch (reg) {
-	case INV_ICM42607_REG_MCLK_RDY ... INV_ICM42607_REG_INT_CONFIG:
-	case INV_ICM42607_REG_TEMP_DATA1 ... INV_ICM42607_REG_TMST_FSYNCL:
-	case INV_ICM42607_REG_APEX_DATA4 ... INV_ICM42607_REG_INTF_CONFIG1:
-	case INV_ICM42607_REG_INT_STATUS_DRDY ... INV_ICM42607_REG_FIFO_DATA:
-	case INV_ICM42607_REG_WHOAMI:
-		return true;
+	unsigned int val;
+	int ret, ret2;
+
+	*idle_set = false;
+
+	ret = regmap_test_bits(map, INV_ICM42607_REG_MCLK_RDY,
+		       INV_ICM42607_MCLK_RDY_BIT);
+	if (ret < 0)
+		return ret;
+	if (ret)
+		return 0;
+
+	/*
+	 * Clock isn't running: we're either in Sleep mode or in Accel LP mode
+	 * running on WUOSC. Force the RC oscillator on via IDLE and wait for
+	 * MCLK_RDY. Datasheet gives 10us (accel startup) to 200us (accel
+	 * transition from OFF) for this to complete.
+	 */
+	ret = regmap_set_bits(map, INV_ICM42607_REG_PWR_MGMT0,
+			      INV_ICM42607_PWR_MGMT0_IDLE);
+	if (ret)
+		return ret;
+
+	*idle_set = true;
+
+	ret = regmap_read_poll_timeout(map, INV_ICM42607_REG_MCLK_RDY, val,
+				       val & INV_ICM42607_MCLK_RDY_BIT, 10, 200);
+	if (ret) {
+		ret2 = regmap_clear_bits(map, INV_ICM42607_REG_PWR_MGMT0,
+					 INV_ICM42607_PWR_MGMT0_IDLE);
+		if (ret2)
+			dev_dbg(regmap_get_device(map),
+				"failed to clear IDLE after MCLK timeout: %d\n", ret2);
+		else
+			*idle_set = false;
 	}
 
-	return false;
+	return ret;
 }
 
-static bool inv_icm42607_is_writeable_reg(struct device *dev, unsigned int reg)
+static void inv_icm42607_mclk_put(struct regmap *map, bool idle_set)
 {
-	switch (reg) {
-	case INV_ICM42607_REG_DEVICE_CONFIG ... INV_ICM42607_REG_INT_CONFIG:
-	case INV_ICM42607_REG_PWR_MGMT0 ... INV_ICM42607_REG_INT_SOURCE4:
-	case INV_ICM42607_REG_INTF_CONFIG0 ... INV_ICM42607_REG_INTF_CONFIG1:
-		return true;
+	if (!idle_set)
+		return;
+
+	regmap_clear_bits(map, INV_ICM42607_REG_PWR_MGMT0, INV_ICM42607_PWR_MGMT0_IDLE);
+}
+
+static int inv_icm42607_blk_sel(unsigned int reg, u8 *blk_sel)
+{
+	u8 bank = FIELD_GET(INV_ICM42607_REG_BANK_MASK, reg);
+
+	switch (bank) {
+	case INV_ICM42607_MREG1:
+		*blk_sel = INV_ICM42607_MREG1_BLK_SEL;
+		return 0;
+	case INV_ICM42607_MREG2:
+	case INV_ICM42607_MREG3:
+		*blk_sel = bank;
+		return 0;
+	default:
+		return -EINVAL;
 	}
+}
 
-	return false;
+static int inv_icm42607_mreg_read(struct regmap *map, unsigned int reg,
+				  u8 *data, size_t count)
+{
+	unsigned int val;
+	bool idle_set;
+	int ret, ret2;
+	u8 blk_sel;
+
+	/* MREG access is one byte per transaction, no burst support. */
+	if (count != 1)
+		return -EINVAL;
+
+	ret = inv_icm42607_blk_sel(reg, &blk_sel);
+	if (ret)
+		return ret;
+
+	ret = inv_icm42607_mclk_get(map, &idle_set);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(map, INV_ICM42607_REG_BLK_SEL_R, blk_sel);
+	if (ret)
+		goto out;
+
+	ret = regmap_write(map, INV_ICM42607_REG_MADDR_R,
+			   FIELD_GET(INV_ICM42607_REG_ADDR_MASK, reg));
+	if (ret)
+		goto out;
+
+	fsleep(INV_ICM42607_MREG_ACCESS_DELAY_US);
+
+	ret = regmap_read(map, INV_ICM42607_REG_M_R, &val);
+	if (ret)
+		goto out;
+
+	fsleep(INV_ICM42607_MREG_ACCESS_DELAY_US);
+
+	*data = val;
+out:
+	/* Restore direct access. */
+	ret2 = regmap_write(map, INV_ICM42607_REG_BLK_SEL_R, 0);
+	inv_icm42607_mclk_put(map, idle_set);
+
+	return ret ? ret : ret2;
+}
+
+static int inv_icm42607_mreg_write(struct regmap *map, unsigned int reg,
+				   const u8 *data, size_t count)
+{
+	bool idle_set;
+	int ret, ret2;
+	u8 blk_sel;
+
+	/* MREG access is one byte per transaction, no burst support. */
+	if (count != 1)
+		return -EINVAL;
+
+	ret = inv_icm42607_blk_sel(reg, &blk_sel);
+	if (ret)
+		return ret;
+
+	ret = inv_icm42607_mclk_get(map, &idle_set);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(map, INV_ICM42607_REG_BLK_SEL_W, blk_sel);
+	if (ret)
+		goto out;
+
+	ret = regmap_write(map, INV_ICM42607_REG_MADDR_W,
+			   FIELD_GET(INV_ICM42607_REG_ADDR_MASK, reg));
+	if (ret)
+		goto out;
+
+	ret = regmap_write(map, INV_ICM42607_REG_M_W, *data);
+	if (ret)
+		goto out;
+
+	fsleep(INV_ICM42607_MREG_ACCESS_DELAY_US);
+
+out:
+	/* Restore direct access. */
+	ret2 = regmap_write(map, INV_ICM42607_REG_BLK_SEL_W, 0);
+	inv_icm42607_mclk_put(map, idle_set);
+
+	return ret ? ret : ret2;
+}
+
+static int inv_icm42607_read(void *context, const void *reg_buf, size_t reg_size,
+			     void *val_buf, size_t val_size)
+{
+	u16 reg = get_unaligned_be16(reg_buf);
+	struct regmap *map = context;
+
+	if (FIELD_GET(INV_ICM42607_REG_BANK_MASK, reg) != INV_ICM42607_BANK0)
+		return inv_icm42607_mreg_read(map, reg, val_buf, val_size);
+
+	return regmap_bulk_read(map, FIELD_GET(INV_ICM42607_REG_ADDR_MASK, reg),
+				val_buf, val_size);
+}
+
+static int inv_icm42607_write(void *context, const void *data, size_t count)
+{
+	unsigned int reg = get_unaligned_be16(data);
+	struct regmap *map = context;
+	const u8 *d = data;
+
+	if (FIELD_GET(INV_ICM42607_REG_BANK_MASK, reg) != INV_ICM42607_BANK0)
+		return inv_icm42607_mreg_write(map, reg, d + 2, count - 2);
+
+	return regmap_bulk_write(map, FIELD_GET(INV_ICM42607_REG_ADDR_MASK, reg),
+				 d + 2, count - 2);
 }
 
+static const struct regmap_bus inv_icm42607_regmap_bus = {
+	.read = inv_icm42607_read,
+	.write = inv_icm42607_write,
+};
+
 static bool inv_icm42607_is_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case INV_ICM42607_REG_MCLK_RDY:
 	case INV_ICM42607_REG_SIGNAL_PATH_RESET:
 	case INV_ICM42607_REG_TEMP_DATA1 ... INV_ICM42607_REG_APEX_DATA5:
+	/* PWR_MGMT0 IDLE bit is toggled behind the cache during MREG access. */
+	case INV_ICM42607_REG_PWR_MGMT0:
 	case INV_ICM42607_REG_APEX_CONFIG0:
 	case INV_ICM42607_REG_FIFO_LOST_PKT0 ... INV_ICM42607_REG_APEX_DATA3:
 	case INV_ICM42607_REG_INT_STATUS_DRDY:
 	case INV_ICM42607_REG_INT_STATUS ... INV_ICM42607_REG_FIFO_DATA:
+	case INV_ICM42607_REG_BLK_SEL_W ... INV_ICM42607_REG_M_R:
+		return true;
+	}
+
+	return false;
+}
+
+static bool inv_icm42607_is_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case INV_ICM42607_REG_MCLK_RDY ... INV_ICM42607_REG_INT_CONFIG:
+	case INV_ICM42607_REG_TEMP_DATA1 ... INV_ICM42607_REG_TMST_FSYNCL:
+	case INV_ICM42607_REG_APEX_DATA4 ... INV_ICM42607_REG_INTF_CONFIG1:
+	case INV_ICM42607_REG_INT_STATUS_DRDY ... INV_ICM42607_REG_FIFO_DATA:
+	case INV_ICM42607_REG_WHOAMI:
+	case INV_ICM42607_REG_OFFSET_USER0 ... INV_ICM42607_REG_OFFSET_USER8:
 		return true;
 	}
 
 	return false;
 }
 
-const struct regmap_config inv_icm42607_regmap_config = {
-	.reg_bits = 8,
+static bool inv_icm42607_is_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case INV_ICM42607_REG_DEVICE_CONFIG ... INV_ICM42607_REG_INT_CONFIG:
+	case INV_ICM42607_REG_PWR_MGMT0 ... INV_ICM42607_REG_INT_SOURCE4:
+	case INV_ICM42607_REG_INTF_CONFIG0 ... INV_ICM42607_REG_INTF_CONFIG1:
+	case INV_ICM42607_REG_OFFSET_USER0 ... INV_ICM42607_REG_OFFSET_USER8:
+		return true;
+	}
+
+	return false;
+}
+
+static const struct regmap_config inv_icm42607_virt_regmap_config = {
+	.name = "banks",
+	.reg_bits = 16,
 	.val_bits = 8,
 	.writeable_reg = inv_icm42607_is_writeable_reg,
 	.readable_reg = inv_icm42607_is_readable_reg,
 	.volatile_reg = inv_icm42607_is_volatile_reg,
-	.max_register = INV_ICM42607_REG_WHOAMI,
+	.max_register = INV_ICM42607_REG_ZG_ST_DATA,
 	.cache_type = REGCACHE_MAPLE,
 };
-EXPORT_SYMBOL_NS_GPL(inv_icm42607_regmap_config, "IIO_ICM42607");
 
 /* chip initial default configuration */
 static const struct inv_icm42607_conf inv_icm42370_default_conf = {
@@ -606,8 +798,15 @@ int inv_icm42607_core_probe(struct regmap *regmap,
 {
 	struct device *dev = regmap_get_device(regmap);
 	struct inv_icm42607_state *st;
+	struct regmap *regmap_custom;
 	int ret;
 
+	regmap_custom = devm_regmap_init(dev, &inv_icm42607_regmap_bus, regmap,
+					 &inv_icm42607_virt_regmap_config);
+	if (IS_ERR(regmap_custom))
+		return dev_err_probe(dev, PTR_ERR(regmap_custom),
+				     "Failed to register regmap\n");
+
 	st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
 	if (!st)
 		return -ENOMEM;
@@ -619,7 +818,7 @@ int inv_icm42607_core_probe(struct regmap *regmap,
 		return ret;
 
 	st->hw = hw;
-	st->map = regmap;
+	st->map = regmap_custom;
 
 	ret = iio_read_mount_matrix(dev, &st->orientation);
 	if (ret)
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
index 9f34199ce2949..61705b162f86f 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
@@ -12,6 +12,12 @@
 
 #include "inv_icm42607.h"
 
+const struct regmap_config inv_icm42607_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+EXPORT_SYMBOL_NS_GPL(inv_icm42607_regmap_config, "IIO_ICM42607");
+
 static int inv_icm42607_i2c_bus_setup(struct inv_icm42607_state *st)
 {
 	unsigned int val;

-- 
2.43.0

