Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011014.outbound.protection.outlook.com [52.101.70.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992FC39CCE9;
	Tue,  1 Sep 2026 14:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788273374; cv=fail; b=Wtfm/q4de0vK4xHUs718cyGW05bjodLOMSvk8N5r6O++2ShMlZ5pmo1RQ3DdfE17wXtzcRQnlTeK/7cnDiA5Sv5v8Z1UMrOwmQfKqIj5uLD75gg4+oKfv8ehsVznyLf9usM6wr4gt8I0Xhz2HijHxgQ2uYvvMjR90Xxuy64GWkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788273374; c=relaxed/simple;
	bh=fjLo5147e2rmVJdCFIh14XSvqBl/OCz+/6xT7YiikiE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=dLC5CggaHiag0mBp8vZKVx93DdWN3VMkxcTd8FIO3yvnqTk0RbNHi+h7WP/BH9RTRN8yOV+08XuE/VUboXQCzmlxNvb72XDNVy86W1IcRjlOZPIiRHFFXnzPOSVQHsIjUp07oz63qXFCnvbN8EkKnDTfauEXPRj7zrKsfX5fpQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=gtXXoKE0; arc=fail smtp.client-ip=52.101.70.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="gtXXoKE0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OgBMV1yvTDV/hz3nFTxrItr0GS9L0ijHDpq5te/fqx82cXKBYbfKIt+RQp1FJzYNGxqlRsjfVyyh+295R3s/JLIxmTdJP1imj1QEoQxrCrcYZXTV2COfGBPWK17uif7INNnPcv+0jtJxkHPbp7XQ/2IbAhQc/2q+Ii2AC7DsROjBmqDQE0bfGTx2IqlbU+xfLrQ8NvfkPAH+P0VXuAP/5jepDUTxPmk1TsoDLPGdXrQb3o6qFtO6wmc2f5JP9RNzf62Hcm5n0nvmKQendMnuV441WN5dKBm/YWk9hA8+6/jqCLOPTXbKeYvyYoar3zADl5iE7J+noL8xsrs3xymmrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdmeLz11TIF6xNirt1K+Ypjn2gLlps/NGkvBL95DXgw=;
 b=fvfO6PYMPAP3mbHPJvqifB1IIGNR1bEmbwfCYXUmVXY7w2WlpNvv2sq7wkiI1czRozTiFOy4qiIiKYAC78sJ+2nVnhBR3ufHjqcR2Gb0ozLcNsgk7AEzIJpkZKr+wdFSmQrva+fNw0ULJ7dCRuiTfBvpKK20Q60Kqrj7WSqYJmLf5mg+nMZN6WD1VSv3ZTxyLp/m/8c08kLUebdkdsNn1TYHvgvpMEARi0dTflTBJALtKeg/v3JZYGfxVXJ1s96IpalSeolfadSz1G+gAtYrN812W9GXOql5ecdp6aVnowidmBQy49hYwS9JG+B7xxfF9O0i5RkNzNJLqGkFaXJi+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdmeLz11TIF6xNirt1K+Ypjn2gLlps/NGkvBL95DXgw=;
 b=gtXXoKE0klcWL9M9vi8dRxQcz4hqeGGQjzgQZe/gxiFtA/GVrYcKWSt9UUCvK90oCc6iBzCCxmHvD++zq31ucfN7DKZkaQLhlQSIqqrrQz+1jLOW5GjddFzwenyDJHgAJkfHGN8gNdvSRZHoc3/EXIc22OLPHcXPrLfs1apK/sQ=
Received: from AS4P190CA0065.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:656::10)
 by PR3PR02MB6492.eurprd02.prod.outlook.com (2603:10a6:102:73::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 14:36:05 +0000
Received: from AMS1EPF0000004B.eurprd04.prod.outlook.com
 (2603:10a6:20b:656:cafe::a8) by AS4P190CA0065.outlook.office365.com
 (2603:10a6:20b:656::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 14:36:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS1EPF0000004B.mail.protection.outlook.com (10.167.16.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 14:36:05 +0000
Received: from se-mail10w.axis.com (10.20.40.10) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Tue, 1 Sep
 2026 16:36:04 +0200
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Tue, 1 Sep 2026 16:36:04 +0200
Received: from pc66231-2602.sto.se.axis.com (pc66231-2602.sto.se.axis.com [10.133.4.42])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 80E6B1382;
	Tue,  1 Sep 2026 16:36:04 +0200 (CEST)
Received: by pc66231-2602.sto.se.axis.com (Postfix, from userid 21940)
	id 742C0305CBC3; Tue,  1 Sep 2026 16:36:04 +0200 (CEST)
From: Kanak Shilledar <kanak.shilledar@axis.com>
Date: Tue, 1 Sep 2026 16:35:55 +0200
Subject: [PATCH v3 2/8] iio: imu: inv_icm42607: Update IIO channel macros
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260901-b4-inv_icm42370p-v3-2-77cc31642115@axis.com>
References: <20260901-b4-inv_icm42370p-v3-0-77cc31642115@axis.com>
In-Reply-To: <20260901-b4-inv_icm42370p-v3-0-77cc31642115@axis.com>
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4379;
 i=kanak.shilledar@axis.com; h=from:subject:message-id;
 bh=fjLo5147e2rmVJdCFIh14XSvqBl/OCz+/6xT7YiikiE=;
 b=owGbwMvMwCV2JPnG7+2HZqUznlZLYsia9ujynznReRkSF6SrPT4wRH3kmcm1KOJGrr9YaRrTx
 oMTuwwOdpSyMIhxMciKKbKcM9oevT/5n+4caadLMHNYmUCGMHBxCsBEGH4w/OELybotdNjj3/KI
 p7mJkjvMVjWfNgo/WnHhfajqIz1BVWeG/7nbI3dnvtsiHLUmwYVl7zlby/KPlxvmqJ17MPFnFVP
 6f24A
X-Developer-Key: i=kanak.shilledar@axis.com; a=openpgp;
 fpr=CDB0F1C8EAD5B522C7B3A77928221FF065DB55F9
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004B:EE_|PR3PR02MB6492:EE_
X-MS-Office365-Filtering-Correlation-Id: fcbdb86e-c7ab-479b-166d-08df08365ab4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|32650700020|23010399003|36860700016|82310400026|1800799024|376014|7416014|921020|3613699012|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	GVDF/oi3y2dnNQXGlLY6vvR06zq8cpwxGV5/tPWoMsIWapj3Tilmeho+SyQy1leQvLe4K59Rg62QYHqFqmb5yB1O97mOOvPM9tICuAymdYjHdnKQ2dCnsCwSHMSjSpbPj5colQtRnlLlsZtkYOoLBJPF1eFvJrrUGW0Sv15dY6rPE1pB287YJKZykdN+vdrFDBTjHzZ81OnQ20h1zE8wJZVoXjVR8syRta+GP+ZFJjKumbbXZKV78C68hTdt/xPcf/N5yZHS1gitTrwsaIJm2PTEcD7N1tFmMrSB1ciQKNXeY4lNIdifalgyj7fH2znoz/VY12aeyTE4eBwxtHwRLT2HXwtnUpObcGErz6IrIH8nMsPP+BQwvj38/xzAW0G/qBo3+cHppddMv3UtAWxGC3l/tjzZPJe8TFOIztR90ftSgxkZZ2tx+OFf5cSeBoSIURTCirYx2xC1xlm7ZX8IPzNQj20RJklT99u1N6YEjEpAIwhw/YSxnaJuxqCIYFU2n3QpXKILLYLekEzsoiv8J0xOaZW7a7SfkCBZHgByguE3hqW9ilAMSF4znAR64k1SrLDeqCpxoILvE9mfVCAGqQrTBu/bwHtZ2FaeJhUjPuzDUH4fworBewZtfspa7DGWkDV+R4d+QAP4Wsfp3DcRT5fPcRbuEVPhEf06iYYSaXQCizyRERRCvq2bYhaSclQax0yHzURguj9uHafjfx27ZQVPx7LWF29wza4I3Q5jki3GF5sfKyNk8Ayl0vcsK/rHZDzuTUOUkuozIdbo4+GXhQ==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(32650700020)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(7416014)(921020)(3613699012)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3sJH6KehxL3orwNL49xKbKKD2afAg1qigPw1+kBwOC3Hf8ZGA2edQzAs/Y1iZntwgCPECghKMGfZ7CJi95FWh0lyClRJufo/g9Emp+1N5ro7HGq4EnRblySflaDdOualN10OlsQixtD1WdXjt0I89ZlORc9dpcRcLN37S0N5rFak535lT24mp4LAKsPkDLkwWgiypgUDvAPE0Z+cL1V+5yjdSfq06HJcYfUhHKf6BNpj38WJCZjzlCiRvJGat7yRSInMiX4Ofh4QP15x5Ypfmf/c4o/BXZ+dQPBmvv7swdujGZECMpJZWgA2521ePuac0iLIWDZf/gGJKQP8gfNlVKICfuvgr1d4uflva3I0TVP+jqHpjH9O3uU/MLU60l/cg3fGphO/2lwH4ybJ8zEVZ0bLW1mEn73kXxp5X728XWJlJ/IjRlJmQudEqidfzqiV
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 14:36:05.2518
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcbdb86e-c7ab-479b-166d-08df08365ab4
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004B.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR02MB6492

The INV_ICM42607_ACCEL_CHAN and INV_ICM42607_GYRO_CHAN macro had a third
parameter of _ext_info, drop it and just point the .ext_info field to
the respective inv_icm42607_*_ext_infos. This reduces the repeatitive
calling of inv_icm42607_*_ext_infos struct in the IIO channel spec
struct.

Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
---
 drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c | 23 ++++++++++-------------
 drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c  | 23 ++++++++++-------------
 2 files changed, 20 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
index 0b3f035c2da0..8f61bc901452 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
@@ -17,7 +17,7 @@
 #include "inv_icm42607.h"
 #include "inv_icm42607_temp.h"
 
-#define INV_ICM42607_ACCEL_CHAN(_modifier, _index, _ext_info)			\
+#define INV_ICM42607_ACCEL_CHAN(_modifier, _index)				\
 {										\
 	.type = IIO_ACCEL,							\
 	.modified = 1,								\
@@ -34,9 +34,14 @@
 		.storagebits = 16,						\
 		.endianness = IIO_BE,						\
 	},									\
-	.ext_info = _ext_info,							\
+	.ext_info = inv_icm42607_accel_ext_infos,				\
 }
 
+static const struct iio_chan_spec_ext_info inv_icm42607_accel_ext_infos[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, inv_icm42607_get_mount_matrix),
+	{ }
+};
+
 enum inv_icm42607_accel_scan {
 	INV_ICM42607_ACCEL_SCAN_X,
 	INV_ICM42607_ACCEL_SCAN_Y,
@@ -44,18 +49,10 @@ enum inv_icm42607_accel_scan {
 	INV_ICM42607_ACCEL_SCAN_TEMP,
 };
 
-static const struct iio_chan_spec_ext_info inv_icm42607_accel_ext_infos[] = {
-	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, inv_icm42607_get_mount_matrix),
-	{ }
-};
-
 static const struct iio_chan_spec inv_icm42607_accel_channels[] = {
-	INV_ICM42607_ACCEL_CHAN(IIO_MOD_X, INV_ICM42607_ACCEL_SCAN_X,
-				inv_icm42607_accel_ext_infos),
-	INV_ICM42607_ACCEL_CHAN(IIO_MOD_Y, INV_ICM42607_ACCEL_SCAN_Y,
-				inv_icm42607_accel_ext_infos),
-	INV_ICM42607_ACCEL_CHAN(IIO_MOD_Z, INV_ICM42607_ACCEL_SCAN_Z,
-				inv_icm42607_accel_ext_infos),
+	INV_ICM42607_ACCEL_CHAN(IIO_MOD_X, INV_ICM42607_ACCEL_SCAN_X),
+	INV_ICM42607_ACCEL_CHAN(IIO_MOD_Y, INV_ICM42607_ACCEL_SCAN_Y),
+	INV_ICM42607_ACCEL_CHAN(IIO_MOD_Z, INV_ICM42607_ACCEL_SCAN_Z),
 	INV_ICM42607_TEMP_CHAN(INV_ICM42607_ACCEL_SCAN_TEMP),
 };
 
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c
index 5b4683c2dd1e..8e8d36461e51 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c
@@ -17,7 +17,7 @@
 #include "inv_icm42607.h"
 #include "inv_icm42607_temp.h"
 
-#define INV_ICM42607_GYRO_CHAN(_modifier, _index, _ext_info)			\
+#define INV_ICM42607_GYRO_CHAN(_modifier, _index)				\
 {										\
 	.type = IIO_ANGL_VEL,							\
 	.modified = 1,								\
@@ -34,9 +34,14 @@
 		.storagebits = 16,						\
 		.endianness = IIO_BE,						\
 	},									\
-	.ext_info = _ext_info,							\
+	.ext_info = inv_icm42607_gyro_ext_infos,				\
 }
 
+static const struct iio_chan_spec_ext_info inv_icm42607_gyro_ext_infos[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, inv_icm42607_get_mount_matrix),
+	{ }
+};
+
 enum inv_icm42607_gyro_scan {
 	INV_ICM42607_GYRO_SCAN_X,
 	INV_ICM42607_GYRO_SCAN_Y,
@@ -44,18 +49,10 @@ enum inv_icm42607_gyro_scan {
 	INV_ICM42607_GYRO_SCAN_TEMP,
 };
 
-static const struct iio_chan_spec_ext_info inv_icm42607_gyro_ext_infos[] = {
-	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, inv_icm42607_get_mount_matrix),
-	{ }
-};
-
 static const struct iio_chan_spec inv_icm42607_gyro_channels[] = {
-	INV_ICM42607_GYRO_CHAN(IIO_MOD_X, INV_ICM42607_GYRO_SCAN_X,
-			       inv_icm42607_gyro_ext_infos),
-	INV_ICM42607_GYRO_CHAN(IIO_MOD_Y, INV_ICM42607_GYRO_SCAN_Y,
-			       inv_icm42607_gyro_ext_infos),
-	INV_ICM42607_GYRO_CHAN(IIO_MOD_Z, INV_ICM42607_GYRO_SCAN_Z,
-			       inv_icm42607_gyro_ext_infos),
+	INV_ICM42607_GYRO_CHAN(IIO_MOD_X, INV_ICM42607_GYRO_SCAN_X),
+	INV_ICM42607_GYRO_CHAN(IIO_MOD_Y, INV_ICM42607_GYRO_SCAN_Y),
+	INV_ICM42607_GYRO_CHAN(IIO_MOD_Z, INV_ICM42607_GYRO_SCAN_Z),
 	INV_ICM42607_TEMP_CHAN(INV_ICM42607_GYRO_SCAN_TEMP),
 };
 

-- 
2.43.0

