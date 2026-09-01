Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011071.outbound.protection.outlook.com [52.101.70.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A053D3CA49C;
	Tue,  1 Sep 2026 14:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788273378; cv=fail; b=cAuLTgcYe0gFw7VT1LvRpTX4OZ/3s84kmiiZjItfqxII1/4w2/0ksvgKGwiW7dipIZ2ABTEDgKLtOI8WzcZPX8wqequ+o7HTLthRdvnfIDxejATF3hPiliMy4bH/IiI6z5b/c1gsNjDRsHG9O8m9atLDmKjwZ1AjpSzu/idUoFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788273378; c=relaxed/simple;
	bh=Q2UjPbNs3Y55RwIsRz/A16YkOazQ9dy47f/QW1pO8uQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=fiDmCKuyy4lESY3myPwskAvLucFgVldp8sSrDVYpi6VxJkxYx9vHwuNkeNSdwelUleoKnYQb3pQ8+OOZzRsFD7OniEM4oKgbwf9TGYdrwgKebbe5L7TPQpzZ7u53sWsJq9GJ7e6jwIiZ1rIkfbIiT4cHg8Buo3DsnTlzxxsIYyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=eIV3xuP6; arc=fail smtp.client-ip=52.101.70.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="eIV3xuP6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JQPioOKdjyUZxijqh0P837ErK3znuRzjHdRvNRomL1NUSb4yOz+dI+/V7lWUF1Eu8q4MRCjfhUUG7tIlebY78N3yMgf3tdJ5prZ5t6I0EsQ1Z1PFwQ34XqG0olIbaS7doVXqYzf3LwHTPnUquF+TW2Q6ycDOBhp6CpbgQ8HNITdOukh3YahKsslJ9aY1dMjVryWSPkyeSywanKKfd8UAQ2YqyDuibL7Zw5VRO3ZH/yLFdYck3FTIJlR2kEzIpnva5lxkyx+hBsNCQQSpsRJMKiweSNery7RAIXR3f/TWahhMQ8OON9XEcKh3b9onZNuMAo665GDWRDEZoNcj5D3OUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQ+vMZqIlMuAJhcSGPDTCwYZNv5Bcg9FFHOV6iz0PXA=;
 b=Uu/jE6HSyl/FPACEChIW3UmzFaEHXGcKGqS5ex0kItHOwC15hkVUPSBIBBl9RK5m/VOALSspGyeBRmcIAxxYVmncxlJMp7BIizLzXY6zWY+bl6WEKzOU1twcErqIEkJwy4F+w9iOFe0J481jw1sX6QDW+6lmmx9TEMEIjgP5TbGJ9QKp7loOcy0SI8QAC0ykg4QninRzDcQkjtTfyISJonOH//kII4gg2q8jpIZ104vzHCgIAzRCT49oRzDSJpmkHzB9r27nMtqECWpo/kU5E2prWYghHqw9ptS0KDbwcvgxFrsl8l4NzBXaO4cnvi45r3DkW7xM+LlKGhHfg1SDqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQ+vMZqIlMuAJhcSGPDTCwYZNv5Bcg9FFHOV6iz0PXA=;
 b=eIV3xuP6b2UmcGXatxmEyS6D036OMoZgPNffeKouFJMvY232w7lDkXu9bdJOEQmDVQC6upRCZJ3+eZRMP36Udo6kYGNzlxn2r4jDC+0jahHuqBZyK3TuuGdZ1iDr24Zl+RVxfkG01zCtkURfFlgqTpTSOMNT9fpzo9uJYX2VB74=
Received: from AS9PR06CA0317.eurprd06.prod.outlook.com (2603:10a6:20b:45b::27)
 by DU0PR02MB9295.eurprd02.prod.outlook.com (2603:10a6:10:470::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 14:36:11 +0000
Received: from AMS1EPF0000009C.eurprd02.prod.outlook.com
 (2603:10a6:20b:45b:cafe::30) by AS9PR06CA0317.outlook.office365.com
 (2603:10a6:20b:45b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Tue, 1
 Sep 2026 14:36:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS1EPF0000009C.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 14:36:11 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Tue, 1 Sep
 2026 16:36:04 +0200
Received: from se-mail11w.axis.com (10.20.40.11) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Tue, 1 Sep
 2026 16:36:04 +0200
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Tue, 1 Sep 2026 16:36:04 +0200
Received: from pc66231-2602.sto.se.axis.com (pc66231-2602.sto.se.axis.com [10.133.4.42])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 831401F10;
	Tue,  1 Sep 2026 16:36:04 +0200 (CEST)
Received: by pc66231-2602.sto.se.axis.com (Postfix, from userid 21940)
	id 75481305CBC5; Tue,  1 Sep 2026 16:36:04 +0200 (CEST)
From: Kanak Shilledar <kanak.shilledar@axis.com>
Date: Tue, 1 Sep 2026 16:35:56 +0200
Subject: [PATCH v3 3/8] iio: imu: inv_icm42607: Update _odr_to_period_us
 formatting
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260901-b4-inv_icm42370p-v3-3-77cc31642115@axis.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2886;
 i=kanak.shilledar@axis.com; h=from:subject:message-id;
 bh=Q2UjPbNs3Y55RwIsRz/A16YkOazQ9dy47f/QW1pO8uQ=;
 b=owGbwMvMwCV2JPnG7+2HZqUznlZLYsia9uiyI9+bGeXRKy9MsTzS7BvxesntI+dmz29sOLXKl
 Hftt/rEJx2lLAxiXAyyYoos54y2R+9P/qc7R9rpEswcViaQIQxcnAIwkfPnGP7XWs6RLH1/Jr6i
 pdNmaVj/i1P1l9s+/JN50Lsxd1OAig8zI8PpjHnzUxMYXGPXmS3V/Vz9cOG/bV3M7nqX4k3uCU0
 Ny+EAAA==
X-Developer-Key: i=kanak.shilledar@axis.com; a=openpgp;
 fpr=CDB0F1C8EAD5B522C7B3A77928221FF065DB55F9
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000009C:EE_|DU0PR02MB9295:EE_
X-MS-Office365-Filtering-Correlation-Id: 3db888f4-9109-4eaa-447f-08df08365e8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|32650700020|82310400026|376014|7416014|23010399003|18002099003|22082099003|11063799006|3613699012|10067099003|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	mJvqkVJlF5AU9mogxQbuMbHA72KCR8dCWbNiXWivk3U6PWhkywuuZJku7u4+qagfPrxn1gtUB304VlqMjDgp258dTll2qXRu4tESQd++CICs1N33CpSbMnNV4C6NAve9xJi068m1+bUFSOtzDT15JMNXbhf3Lcys+2+91b32sBFrgAmzxAqPdrvBcsREsMiEJsupEmc/YPMT53M2HOVeykhoPnqwcYpUNvCcMnwwRTx7VCeAmAPKYh89UgtOlQF8muI9xJx+mThAxjAAqykXa5PTDVeGrS7uKOaigpDzLMx7o9QUp9NGqrUQsPXCwUB2NQaG6uO2N5IpA7wclZn74KcDaXg5Sc+B3CekA9c/yooh8SIlQ0/c3haUAJRIuv1MrIJ31bJhj5rNyx2HDlkA5cLWDq49GYfr6FxwJyXWmFxiMtdlbDSBhsTsZ0GefuB6cICDFRv+RwZxEUEujcilCYHTzYsQ7Stt8WYrRmdz6zdSrk/MV5mj1klmOc7AGfyThORuaWSY1XXRHjOCixQT8FOP38QVugNOOmqtae4GXz87Yj5/9K4kFTtw1/0kr6dkBIV45Qk6q08hJsGuCR2AcD5CWO3UXoX1oKB3WlApJZQNRqtLA+DUwpSEa1rPGhcAb1+pjdMpRXxMs3lFxmUMKXis7O8C60FjFx8DEESTsN+exKTVDu+7FO99SV/5zhtYiD3aKKlCs8vvttBwcARcuWPwWlkfMU1kD+dUqGT7DKs/8aH2bignBw574NdpzXXCGtQj59wtRilg3Y9qU6pplg==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(32650700020)(82310400026)(376014)(7416014)(23010399003)(18002099003)(22082099003)(11063799006)(3613699012)(10067099003)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aKSLuK6FvwJFppvtEFeZ+BHzeQpwdBuaYI04Xy1gou0LuqMCsXzhgmUoFSKZe/EQzKKR92bDsPyxb+rAI1dIRStekSwNNA4FtvMjhMQ72ldgzLgBs4+mMpaTI7rOfTQrmn7q0d1jn4HX4WArtkj2uEqGT1O7FRssGtBVz8KiPJTWv9uC9Q3kmNVPB/UGNG9Ta1HmuNbUiIq275asacaD2ijfeo8ZWVjfvBhmcKQ5iAvqdmhX77ZdlTU7YprEIDapE0ncdTnnFGhKojHVfINu4O/3NdhYhOAV/ikVB8bmaZBXSoL6jGMaDGOdeE++EDYOlQk5PtyzU+JR5zGRzitV7U4nIIDD609WrChVbS5oW/Mt/EV9rYEVDPyfZe1vojRCIJQ0RVQbShHiO4/gfoy0UVTeERZ4Fv2KaMAa42TgaFhU1puSgydTYZmb4bBgsmUR
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 14:36:11.6929
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db888f4-9109-4eaa-447f-08df08365e8a
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000009C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB9295

Update the function formatting for the inv_icm42607_odr_to_period_us
function. This enhances the readability of the function and drop the
unnecessary comments in the array elements.

Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
---
 drivers/iio/imu/inv_icm42607/inv_icm42607.h      | 20 +++++++-------
 drivers/iio/imu/inv_icm42607/inv_icm42607_core.c | 35 ++++++++----------------
 2 files changed, 21 insertions(+), 34 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
index 4d51b0da1aa1..fa85cf738cc0 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
@@ -62,16 +62,16 @@ enum inv_icm42607_accel_fs {
 /* ODR values  - Note Gyro does not support ODR less than 12.5Hz */
 enum inv_icm42607_odr {
 	INV_ICM42607_ODR_1600HZ = 5,
-	INV_ICM42607_ODR_800HZ = 6,
-	INV_ICM42607_ODR_400HZ = 7,
-	INV_ICM42607_ODR_200HZ = 8,
-	INV_ICM42607_ODR_100HZ = 9,
-	INV_ICM42607_ODR_50HZ = 10,
-	INV_ICM42607_ODR_25HZ = 11,
-	INV_ICM42607_ODR_12_5HZ = 12,
-	INV_ICM42607_ODR_6_25HZ_LP = 13,
-	INV_ICM42607_ODR_3_125HZ_LP = 14,
-	INV_ICM42607_ODR_1_5625HZ_LP = 15,
+	INV_ICM42607_ODR_800HZ,
+	INV_ICM42607_ODR_400HZ,
+	INV_ICM42607_ODR_200HZ,
+	INV_ICM42607_ODR_100HZ,
+	INV_ICM42607_ODR_50HZ,
+	INV_ICM42607_ODR_25HZ,
+	INV_ICM42607_ODR_12_5HZ,
+	INV_ICM42607_ODR_6_25HZ_LP,
+	INV_ICM42607_ODR_3_125HZ_LP,
+	INV_ICM42607_ODR_1_5625HZ_LP,
 	INV_ICM42607_ODR_NB
 };
 
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
index 190e998f7b8e..de3b158f446c 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
@@ -118,30 +118,17 @@ inv_icm42607_get_mount_matrix(struct iio_dev *indio_dev,
 static u32 inv_icm42607_odr_to_period_us(enum inv_icm42607_odr odr)
 {
 	static const u32 odr_periods[INV_ICM42607_ODR_NB] = {
-		/* Reserved values */
-		0, 0, 0, 0, 0,
-		/* 1600Hz */
-		625,
-		/* 800Hz */
-		1250,
-		/* 400Hz */
-		2500,
-		/* 200Hz */
-		5000,
-		/* 100 Hz */
-		10000,
-		/* 50Hz */
-		20000,
-		/* 25Hz */
-		40000,
-		/* 12.5Hz */
-		80000,
-		/* 6.25Hz */
-		160000,
-		/* 3.125Hz */
-		320000,
-		/* 1.5625Hz */
-		640000,
+		[INV_ICM42607_ODR_1600HZ]	= 625,
+		[INV_ICM42607_ODR_800HZ]	= 1250,
+		[INV_ICM42607_ODR_400HZ]	= 2500,
+		[INV_ICM42607_ODR_200HZ]	= 5000,
+		[INV_ICM42607_ODR_100HZ]	= 10000,
+		[INV_ICM42607_ODR_50HZ]		= 20000,
+		[INV_ICM42607_ODR_25HZ]		= 40000,
+		[INV_ICM42607_ODR_12_5HZ]	= 80000,
+		[INV_ICM42607_ODR_6_25HZ_LP]	= 160000,
+		[INV_ICM42607_ODR_3_125HZ_LP]	= 320000,
+		[INV_ICM42607_ODR_1_5625HZ_LP]	= 640000,
 	};
 
 	odr = clamp(odr, INV_ICM42607_ODR_1600HZ, INV_ICM42607_ODR_1_5625HZ_LP);

-- 
2.43.0

