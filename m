Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010021.outbound.protection.outlook.com [52.101.69.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC85C4E1C7D;
	Fri,  9 Oct 2026 14:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791555157; cv=fail; b=OikxMf7doV9vErdPY/0RKDTc49pdwkxzbw+NS+rSLTZ13Tz5btMYLcu+o7VEhMndI0VQVlae6cINAdDj5R9wZq6z0nDEjGY5XfiqbiGLzWgCGn/7CgzhBvPPVuZHWeG6EEykPwsg941dz4EJtUh3GXKJwd+kIgsjIRxHzVBLpZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791555157; c=relaxed/simple;
	bh=lPbqmw97WHqi9a7JRElEt72C+UI1eV2jc6uPxGQ2Eqc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=GnXP37ZvartWRXSuxrVTO16jRcjvenbaEpbpxn0LOu4lDhzORJxJihRQTiHf/fkJLrUU1acPDp5RM7H99FvsbDIN6ubsI7EAqVZnrW1QZzzP60Ry0D6xZFWy3sYj/bgPZunn7/aTUCroXqVxb+CYjdOlNWngBkLaHMgYm5FDfZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=Q6/9w0MI; arc=fail smtp.client-ip=52.101.69.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="Q6/9w0MI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PyE9uXccc5vjp2FxYzW9A4JynHMHrZBuW9dirnvwZlLin3Uxcex40tEDwhuW+NLv/xLyBpH8JLtGqv5T0PXw1aqVjg6YrjPK5ll6xAdN8oMFLltBvIcXKDLdwnyrZ/qcZNbyHZduvJ3320/utP10A0IohWn4NBjqyrTURCeKOsNH1PBKvNv6k6bCOMNuuIFC5k8B0QBiLE9q9HHFx7DZXaATqdaD5DBFZvjS0qh8Np2vZrcx4UaV4CB9QcTlEQYAZUFbNa0qM15EIoEyCGn5TONVqlHRM9lUYjl90TGGGjF9W04f6DADSWVe48wOpiXFLZkKgHi20O2wk4ZYmjeSMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EdXRdi7dF2jKY6Bsuyhju/UpaofjqICOZpUFku29LtQ=;
 b=Th6usVA0lWGxPpsi/NRO8+ZW6M5PVG1dkaZvraj7RWOuszeioXQoR0wDNInuojyTemOa+rBDmoJ+rb4/qxy4MLzpXygYIg+WEgDpQNWAu9qSliIdyhpEj+1zBMwaBmL94jg2KHg/ef9hIEyXeW5pMrj6qyYZGwEqPQnkRr7khKHKmK6xUYM2TN1UeVzso7/zKFHbhjnxYofwAfPDjMyVV6y8Ez/ASt6KpxtRKi4I4O4JzqtOSwavix4cdq0S+Y3Bxpj9p7yzV9/zOKtn0QY3bTVL/bw6MdeM/xzf2q2JWLalzQseqPvEggSqWF3YdYixCmP577By5NQcb3sIkqR/ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EdXRdi7dF2jKY6Bsuyhju/UpaofjqICOZpUFku29LtQ=;
 b=Q6/9w0MIvIq4auBiJexB6fe2slvHxux+M27ptiTJVXdLYwTTAlV0aCVuH7Hg+6XSGnxLxlsEGN3C8woNBbJD+qX8RHYvM55OK1VyH9EzvfrsBFRqWxSGiFSvGIlhH62Brt/XbyTFc/o7OdfB0OQSD7TMOUbRP7/Y5MvdierIL4k=
Received: from OS6P279CA0180.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:38::14)
 by AS2PR02MB10429.eurprd02.prod.outlook.com (2603:10a6:20b:5f4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Fri, 9 Oct
 2026 14:12:30 +0000
Received: from WA1PEPF00009B3B.eurprd05.prod.outlook.com
 (2603:10a6:e10:38:cafe::9) by OS6P279CA0180.outlook.office365.com
 (2603:10a6:e10:38::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 9
 Oct 2026 14:12:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 WA1PEPF00009B3B.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 9 Oct 2026 14:12:29 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Fri, 9 Oct
 2026 16:12:24 +0200
Received: from se-mail11w.axis.com (10.20.40.11) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Fri, 9 Oct
 2026 16:12:24 +0200
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Fri, 9 Oct 2026 16:12:24 +0200
Received: from pc66231-2602.sto.se.axis.com (pc66231-2602.sto.se.axis.com [10.133.4.42])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 3594F1DD9;
	Fri,  9 Oct 2026 16:12:24 +0200 (CEST)
Received: by pc66231-2602.sto.se.axis.com (Postfix, from userid 21940)
	id 287D330604F1; Fri,  9 Oct 2026 16:12:24 +0200 (CEST)
From: Kanak Shilledar <kanak.shilledar@axis.com>
Date: Fri, 9 Oct 2026 16:12:07 +0200
Subject: [PATCH v6 2/6] iio: imu: inv_icm42607: Simplify IIO channel macros
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261009-b4-inv_icm42370p-v6-2-e53884f185ff@axis.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3705;
 i=kanak.shilledar@axis.com; h=from:subject:message-id;
 bh=lPbqmw97WHqi9a7JRElEt72C+UI1eV2jc6uPxGQ2Eqc=;
 b=owGbwMvMwCV2JPnG7+2HZqUznlZLYsg68c3904Kv69/tcFx/YDHTm4jaEzb6Hg4ZQTGyF0IeM
 W7M3P3Bq6OUhUGMi0FWTJHlnNH26P3J/3TnSDtdgpnDygQyhIGLUwAmso2Z4a/sosDo7R0eH2Yf
 rW8OvfWB1feTJtuc75bPGua4LNG9O/cnw3/fwrLS0p/7T0X9cp7kyeXfWKi3r8uufgbzrs4N+yQ
 177MCAA==
X-Developer-Key: i=kanak.shilledar@axis.com; a=openpgp;
 fpr=CDB0F1C8EAD5B522C7B3A77928221FF065DB55F9
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: WA1PEPF00009B3B:EE_|AS2PR02MB10429:EE_
X-MS-Office365-Filtering-Correlation-Id: 54136205-c3b9-4a62-6acf-08df260f5abb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|36860700016|82310400026|32650700020|7416014|1800799024|3613699012|921020|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	vmjtTWu7bzpH17XCtdL3zgIa1oGazCSMGcmYdQ4P/Kge8jdm/Jwr34cCTi2OLy2Zuxd1MBXGrCmu8yrdelowiRzaxmlw3/njQl62Q5df9g+ciIJmOhSa6/imtDcsnT1IbxG54TVnTUAE04ly+0nqBHmdL5ZkfCuNrd4wg+KIEcPDTNOSBUKEW9md3BB6N15RCnb2WFjXTzSxvQm95RdCsmGIjm+iTRj0mL0b93vsZxqWBJA8CBqKDsEK1/12t/gZWXSUM8QxZoVsanky/wd4FpgCHaex79tYUBt5LS56Sf2l6c/zYDXnY01Ioj7lpKrRM0YXab7AZ0Yy4yDcxJnQ9mX0nNbsa/E41c0f2L14TcMs2tfrRQMhPyQ3YD3J86M9AFgpvvOB5Q84g2NfnBZwLY46jW+hFbg/XlZ7yq8PQO98ZiqVnYdTJuz7eDi5hqtl+WPy+opC+pxa1XKcsgkI8xCCMmDVSw4XlhiGb9ebzpBEfN0jphy5l48RzHfb0dLpQ5FxCKBkhw62w36ooA0hftnlaAdanweXBiE2e9KPKuQJYTwWcRAYJN5/BlOVvOIz/6A8YJc164OwJQW+ORbfniEBUPIPkdrsOH5ElII2TSfMWl5ZiA8FYVpwlnmSrC1LyyGZg1mhHc6rcLhuYn21USznko9qJYFKgox85ays7H6N2wipVQc/0tX2weic4X1atHusM1HAgAGz8/Z2qOBo2bAcGZvntFXio0foOiouRa8o3seOUZZ/2N9KzJdhEwsKsHpZK41QfRjUMZD7844jBw==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(32650700020)(7416014)(1800799024)(3613699012)(921020)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Cp/ZUxn1guOIyP5Ca3QQLYIMAHGszMHKKUD1e/Lu6zOgiEw6wz3i7ZeKtGZpcAHMBKBgxoWXn6a7AValF5XaJCu6gHTZr0/zeI1ZqgU03evXnwXPa+r+H8F4pGJwicHVrBPGjXqvhYod++hwY0MLX6TM0Coy45wFcNglfrH/WnkMoPGTSaqTitZKt3iHGE5+Accpbnmg4I5pHV2c3jAfXPoDtkEONO84U6kxk0bS/zueunmYCeo3Kcq8ukuOHxN5Y6SipzI9gzfH1NbBgH6u0C1V7SAWaqrTO1QJJjvesQD/z2wY/TxZ1Wz2WUPnqgM07ryVbF/wPwSJSD9enlDn2IGWzBQMnzjkTl6mPCfkrvzAVlkL0wQJ3No7Sg9cawc2HwKOgjeCP/CTolvhu7VxLR2ui2dhR1KoIm2e6w8mGAIQNIEAEx7sJELMXw0tncC5
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 14:12:29.7966
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54136205-c3b9-4a62-6acf-08df260f5abb
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	WA1PEPF00009B3B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR02MB10429

The INV_ICM42607_ACCEL_CHAN and INV_ICM42607_GYRO_CHAN macro had a third
parameter of _ext_info, drop it and just point the .ext_info field to
the respective inv_icm42607_*_ext_infos. This reduces the repetitive
calling of inv_icm42607_*_ext_infos struct in the IIO channel spec
struct and makes the code more easy to follow.

Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
---
 drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c | 13 +++++--------
 drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c  | 13 +++++--------
 2 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
index 0b3f035c2da0c..9a3ace3e7fcf9 100644
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
@@ -34,7 +34,7 @@
 		.storagebits = 16,						\
 		.endianness = IIO_BE,						\
 	},									\
-	.ext_info = _ext_info,							\
+	.ext_info = inv_icm42607_accel_ext_infos,				\
 }
 
 enum inv_icm42607_accel_scan {
@@ -50,12 +50,9 @@ static const struct iio_chan_spec_ext_info inv_icm42607_accel_ext_infos[] = {
 };
 
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
index 5b4683c2dd1e4..a3bad6fbc1981 100644
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
@@ -34,7 +34,7 @@
 		.storagebits = 16,						\
 		.endianness = IIO_BE,						\
 	},									\
-	.ext_info = _ext_info,							\
+	.ext_info = inv_icm42607_gyro_ext_infos,				\
 }
 
 enum inv_icm42607_gyro_scan {
@@ -50,12 +50,9 @@ static const struct iio_chan_spec_ext_info inv_icm42607_gyro_ext_infos[] = {
 };
 
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

