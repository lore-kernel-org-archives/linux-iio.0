Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.22
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793893756;
	b=qXaICOJwagNsGEf0ANuvIPic6OWRbf8JVW1MiVLcPCmYf32XLOhwnXdAiIegjOYwvt7E
	 7ZKr18axHCoIDZHRVev+V2fZEAqlrPQwxRjmfkbHNRgAiPIYWQYVp7jODXEaUKQF7AD+q
	 8laNWoufOy9xlAPZvfwsoiSH1Mx23ArH0gFKq2RFW/bKyLu4ynGfeFk7EGacW5ubyb4bP
	 +s32EEnMJaH93ixo4Q2IMscERBqKAR4VZ1O9/LlZA9wHDvuTnXGmLxj/4ZOevYcvjcCAz
	 i880Gl87pT1H3cvHQdAxhIBsoZf3MSXoc716RrLXmZrnVIwg7+pG3VPTCPoUitjH5Gg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893756;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-ID:References:
	 In-Reply-To:To:CC:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=EdXRdi7dF2jKY6Bsuyhju/UpaofjqICOZpUFku29LtQ=;
	b=BA0IT5sx/VzJPMN5pJ6sjUTQ5HRiSdz3ZRt0dazEFDhg3qomt1YwPeKqm8Ckl3eCY/ro
	 IzWMOzqNdCT3UFKmDjJTjDXcVCMiAxG9RRUE4XczPpivYF5qvlqF5jXDSp67UXs6/X048
	 Pu64ExiOwtpsxCDOCR4rxrdlZ/hNZTJ52k0GKYMrff/CUbuFTz0qkBZC8ee3NwGNJtmJ4
	 Z7GjtMtIWgVGStvr9cOw5IEKMs0avqvsSLmaLyu5Gk5/Yd4DNBamC1NiMWKUlmG5hK/Xb
	 +/WMsIPid68paHF3TRn2a9m8717uVFpi83SpPvZEuQ3usvGCfB/ZMKtdpZyVRwk6cyQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=AtfXQHg+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.22
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010022.outbound.protection.outlook.com [52.101.84.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C4C6082BD2;
	Thu,  5 Nov 2026 15:49:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98C4C6082BD2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=AtfXQHg+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=snIkQ80fzI1AwM7JS4ecMZpjhjqlxmc5AMFuy3/jpyRgVb0Pe7VDzuF8kysLF5/L1sLB4ISRhxGQ/ZMrsVl0NEIW3MtSD89LFxTBnDxRCJHB6R1Z5HtbBZZIlWaF1WqryDR2xu/caU3NtKqXeiSMeJO8lLJNSiHnMstEVnOWfbjVC2OVkKf4EObzXoD6bUXl6rR5Td2naxO8ulA6xfIjVS0lmnvEdNXgyDG1BAzxIwKwytJ7sgE7eGMZLk1k2FeNcreWWXCnjkTQCyNL2lZi4i3SYUY6TUt0o6LWZQfs418z5t4mLSrfieNDe3X2WeRW8g9zBTEUg3TpF+XkQ9vRLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EdXRdi7dF2jKY6Bsuyhju/UpaofjqICOZpUFku29LtQ=;
 b=bKEY64uWOZkOLDveOWucSIDj3Elx0MwioR81TMrqr9GBQMBYcUUI0o+3kwB0F8aVNPr22Z/a4tPIRDyfOryqWBO4JUweudnNI4fJsjzsFq9BdPBC+BbgzIpF8fYRcTDW5lWmHoxAOOqGyBpf+zo7lYqOoIj/f7CkXVW3n511LapC6q2ZniLYnOvuxbHU7YvYxY7O0Vlw+ws1XbrFrglMYlEu5MCcnnjvB93ZyuA7F5ETsUsAN8ur1b6qSj+/zRGZ5siQRepfTlTQb/W5AU0H/Bd9nOe5mD1SOEBgM397H7dVWiMvCZMU7BQW5OhnXokqwXG5LDI4naHFYjBW5/3CSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EdXRdi7dF2jKY6Bsuyhju/UpaofjqICOZpUFku29LtQ=;
 b=AtfXQHg+jIrQmF9SCbPIHaeEDtC9w2WzSx6webs7D0DH6/cI4jbqBB6eTOstd7soKaPpRloanSmnSnUZVu9CiRTW8gilnCBE/qHzRCMKDwrBFHZLyChlIDR9asLGICGEJmTVmOH/LvU/NDtkvItr2UQVJ7jpml3aO4Z5XGvHaXs=
Received: from DUZPR01CA0208.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::6) by PA1PPFFDEC473B7.eurprd02.prod.outlook.com
 (2603:10a6:108:1::267) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Thu, 5 Nov 2026
 15:49:05 +0000
Received: from DB1PEPF000509F1.eurprd03.prod.outlook.com
 (2603:10a6:10:4b6:cafe::13) by DUZPR01CA0208.outlook.office365.com
 (2603:10a6:10:4b6::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 15:49:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509F1.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 5 Nov 2026 15:49:04 +0000
Received: from se-mail11w.axis.com (10.20.40.11) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Thu, 5 Nov
 2026 16:49:03 +0100
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Thu, 5 Nov 2026 16:49:03 +0100
Received: from pc66231-2602.sto.se.axis.com (pc66231-2602.sto.se.axis.com [10.133.4.42])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 83BA11865;
	Thu,  5 Nov 2026 16:49:03 +0100 (CET)
Received: by pc66231-2602.sto.se.axis.com (Postfix, from userid 21940)
	id 76F82305D283; Thu,  5 Nov 2026 16:49:03 +0100 (CET)
From: Kanak Shilledar <kanak.shilledar@axis.com>
Date: Thu, 5 Nov 2026 16:48:51 +0100
Subject: [PATCH v8 3/7] iio: imu: inv_icm42607: Simplify IIO channel macros
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261105-b4-inv_icm42370p-v8-3-b44eb96020b6@axis.com>
References: <20261105-b4-inv_icm42370p-v8-0-b44eb96020b6@axis.com>
In-Reply-To: <20261105-b4-inv_icm42370p-v8-0-b44eb96020b6@axis.com>
To: Henrik Grimler <henrik.grimler@axis.com>, Jonathan Cameron
	<jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Jean-Baptiste
 Maneyrol" <jean-baptiste.maneyrol@tdk.com>, Marcelo Schmitt
	<marcelo.schmitt1@gmail.com>, Chris Morgan <macromorgan@hotmail.com>, "Joshua
 Crofts" <crofts@kernel.org>
CC: Kanak Shilledar <kanak.shilledar@axis.com>, <kernel@axis.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jonathan Cameron
	<jonathan.cameron@oss.qualcomm.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3705;
 i=kanak.shilledar@axis.com; h=from:subject:message-id;
 bh=lPbqmw97WHqi9a7JRElEt72C+UI1eV2jc6uPxGQ2Eqc=;
 b=owGbwMvMwCV2JPnG7+2HZqUznlZLYsh6szTPsT2Rx7Otdu9O9f8+FdNqj/bP/vdKK150x8m1G
 kL/dY1fdpSyMIhxMciKKbKcM9oevT/5n+4caadLMHNYmUCGMHBxCsBEztxhZGj7OenwJhORN1V7
 WvdL7nBsP55jbXIn+WEH10Vu7Y48Rn9GhkMlcxyWM6Y+f37YOPyLoSB/A7P+as3Fu5+vz58fbM0
 uzgsA
X-Developer-Key: i=kanak.shilledar@axis.com; a=openpgp;
 fpr=CDB0F1C8EAD5B522C7B3A77928221FF065DB55F9
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F1:EE_|PA1PPFFDEC473B7:EE_
X-MS-Office365-Filtering-Correlation-Id: b0a465ef-1249-4fb9-e7dc-08df3b5451de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|32650700020|23010399003|376014|7416014|10067099003|22082099003|18002099003|921020|3613699012|56012099006|261022075727099003|11063799006|261021121427099003|261102123227099003|261021123027099003|261028144727099003|261009223027099003|261022105027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	ebSZUTocYHU23WE/vnIz37E58u4DMHm/fEEkPulA4d52usLgTzSMRlsAuaD7DsLHejquLtduRYTII8EUTkdiNdQDH6qEwzjAHlMW/BeoAtgnW+hZuPkAMx3DmFs19rVx77vQa+ki01g5bmAVe0AJvt5FXcL3JCfa5qRFjzNwuBc5izxwn0AYP8VvuHVxJY/+y+3omrkpZAnBdRwHoeGLMvfbSZaYxmvlR9HyTI8aYsBTjSBTPHQAU/L6D7WN9RNG6urU9D4u8iuhy/8h03CChlH3APfjk6u/e7ophaKVLvJHg90i3YEyGZmeLG+q/oJ0oJT0wOfr/nbgfVHr0ONeQzV5P993HrLbg/Hw+L/nnI5k/+m0pzvVk7Ma2Wo4VDs9jWwYSxlOdHJ802m00S8K/lFDokiDFaM0uakWDUgDf+mF8Yms4QuSA3J7hl3iSF7z53pYzsVcVHqBsZ5iqediNigvyCSl2WQHo0QWMh6dEK2sH7bexK6GQ2xwSQhIKmNQI7YGxHpUBk6f+n8v/m68kvOPkdzD4CyrmhVTDzbQxJDPhkZpjh1U2TEixkY8PXY4n31xSdfAcPnx2Lh4gHF5Nx+h6mFCI3M6epFSsvekFLrlxq2r5T87yWO8EkNdDeMlCTTIBkGXcnwymRI2IlqyAoBupMIa6UJsFhdbaDzzRlGXbjyx3QB2MK3J1cB9WLJCr0RxOJUmfYVTaaIm1+LHfnzKIM8J2OoikyjJqqlIgSLI32NEFvfEqBIYrkq6+qE/xwLMqfQVUWRUXruThlPHsw==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(32650700020)(23010399003)(376014)(7416014)(10067099003)(22082099003)(18002099003)(921020)(3613699012)(56012099006)(261022075727099003)(11063799006)(261021121427099003)(261102123227099003)(261021123027099003)(261028144727099003)(261009223027099003)(261022105027099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7RmOlwKTr6cK0kW8b2HNWXfUxtuF782/PB56B4F+BUuQniAAjPM00x/jebFF/Gpb3ASMdEYSHjwIy+imReNpOFi75g7/HUklbD9ekrmDduwqMz1FMoUlCrH2DrO3Um7i1hpkud3AUby1IZBJjdJWfgEfF25Lhgdci2McjGQ09+xiY76kznBmoyj6zrOrhcUYQMhUv9TjrkQ30oG5+iAwjcZ/EgFMxh5OYaTeErvSdMJhEl9CVLzt6DIlzrYwuS/Q8r4e+ewv9Iwod58jzZiq9SujteO+kt0RTokt1ydXheVtxmGUZlMHGmMmPuP30v+ndEJBNuHL9RTcvkcPMNKgGOk+840z9V/zeeLAiPveTiVHj2x3kRnbm5Jw7RQZNQvFmcFKDrGkJDy6oH9LnXN6vZHYmycC7NAYNxsgjrGcy8euAI9CjByK25rtftMx4AzO
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 15:49:04.6240
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0a465ef-1249-4fb9-e7dc-08df3b5451de
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F1.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PPFFDEC473B7

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

