Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.65
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793012618;
	b=FDpjpp5owI6BkoT+1PydmRFPWpfU/oiSTyuflGoT44nddvyXdKeuiAlykHrr1PA5bB3p
	 37lSfF1qLaqZLmHtvU4ZnlNDTQZCURrbpHveyxfOKn+Mg7ZgoRaADgOwCfg+SatBPgJW7
	 53NqZEXinekPwW5riGrwnVHjLNO9svi7BXyhMYJgB0OUUUfXyp1bi9W456pt3i7DMsE/v
	 jUw2C21RPkE1LI9qT0/7ZQy3tCKg/TtrljW4PBMPsg0ahsRJo4ahkUEEo0z1ae0W1Flmk
	 qZJqckB9lZrk6BUPd9E/F7SsXf5cfv1eMBqTDhdqXZC3tKAtq/1+B8rUu0LujG5pPog==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793012618;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:Received:From:Date:Subject:MIME-Version:
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
	b=BGtANB1ZGMyKoWjBB84tJu3wWIBufA4RAvYRTEfPPWBEFYWdiQ8GD3medOk2lnaa2aOz
	 UPRTBiy8sIBAQLKNUsxFtW7zFvbO9cue/t5HNIuQxfnh8orGHS4qZoePyth+s2d0dE+Sa
	 aG1fMnQLjEjfzDmPtQqiCay9f3Eo+g+/QqazKmOvXov6UKuMSZ2v/uGLMpHon8lsjM0m1
	 rrFUvcZ9Ez+QSKxQS+R1B8lkzHvVWU8QJ+xZ1msfRI2UBh1RYULE+f+hHHv5fGJuyHJjy
	 7dZuXhttjFSL+qF7uTZAJQM/kerg/gVLlGspbPNQrQDCGb716iQ7JEOz+kZ8QmiMsnQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=UQtV5mto;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.65
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013065.outbound.protection.outlook.com [40.107.159.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CB1606A321;
	Mon, 26 Oct 2026 11:03:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64CB1606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=UQtV5mto
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nCPG9IXQqAmLJZgxeWUbv+KaO3TTNYU/uzBAAVXLy//1KSZqcU0BQectA3o39KcrdGnjeqtT+B/aie+VeOJyVHu3niyeg1NoZxq4AkT9djKOtnmOkeNM5gkgDYO6f+2f3c2o6hopO1eSJnUXwStCdoZSfaGVnuHKiS1VehhOtMG+nsH8TXiD2F7iA5I0wA57vWCLbXWrfafB6Jzo+iDgkCBr37FJaweSyv/bXSxdBRgBZU+iSz7UeF0FkFr9SAWormn1SmaEmsgdwDUDkNXSdwtA2KvGCAzDjjgr8ZBL99x6021RgVpEUDkjOluhB6/F8vvJHKRdSC9p5we38sx6ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EdXRdi7dF2jKY6Bsuyhju/UpaofjqICOZpUFku29LtQ=;
 b=ATc+AXbBuZ8e7ZC1sAPCcox13rSIKx9Gv8zOYt9TwItFtenSPZO6y6hgYzNhSxDaH4yQfhN52bplRQGBJmgLnyZHRbjWSuKE5LIlkBSDkH9lX8e3w7JT8BVP4lcN6wkTB9VaAbDWDJa4kS2uaYW6e/Jos7SgaO67pA59xNa7p5yrS7CggiLo4OIhdPkKnf7PjgAzTGj12nUCQvMETIeuGI8DSwTOO2rsWjh6tM7bDVcniSCrv15pJWNFSYhhK/dSMVRE2jefG5EcTqjdN2lD4LHfcXMczvrOWTv0nOf3CEHjG+xbKyxabwI4/rWKoVabgZ/xja/qyYcOyiPxknpjYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EdXRdi7dF2jKY6Bsuyhju/UpaofjqICOZpUFku29LtQ=;
 b=UQtV5mtolseLf9x9pAz5+cnD3noJtbpSGBBti3TRl0u21cAvbrJ3WOj+ukw5W2KOHhLM/U12kec+gO18I5zogXO2Diq0IbttjS/17WBl+vbNCunDQVpFNUTseLQ3Y4A7aYldimIJj6A6pwMLlidyNWK3YlVNq0c7th+8c6j9+Sg=
Received: from GV3PEPF0001DDA2.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6c9) by VI1PR02MB10152.eurprd02.prod.outlook.com
 (2603:10a6:800:1bd::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 11:03:32 +0000
Received: from CPH1EPF00000524.eurprd05.prod.outlook.com (2603:10a6:388::1e7)
 by GV3PEPF0001DDA2.outlook.office365.com (2603:10a6:158:401::6c9) with
 Microsoft SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id
 15.21.406.10 via Frontend Transport; Mon, 26 Oct 2026 11:03:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 CPH1EPF00000524.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 11:03:30 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Mon, 26 Oct
 2026 12:03:17 +0100
Received: from se-mail11w.axis.com (10.20.40.11) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Mon, 26 Oct
 2026 12:03:17 +0100
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Mon, 26 Oct 2026 12:03:17 +0100
Received: from pc66231-2602.sto.se.axis.com (pc66231-2602.sto.se.axis.com [10.133.4.42])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 52C082E63;
	Mon, 26 Oct 2026 12:03:17 +0100 (CET)
Received: by pc66231-2602.sto.se.axis.com (Postfix, from userid 21940)
	id 41821308B8D7; Mon, 26 Oct 2026 12:03:17 +0100 (CET)
From: Kanak Shilledar <kanak.shilledar@axis.com>
Date: Mon, 26 Oct 2026 12:02:51 +0100
Subject: [PATCH v7 3/7] iio: imu: inv_icm42607: Simplify IIO channel macros
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
Message-ID: <20261026-b4-inv_icm42370p-v7-3-222e296ac1e0@axis.com>
References: <20261026-b4-inv_icm42370p-v7-0-222e296ac1e0@axis.com>
In-Reply-To: <20261026-b4-inv_icm42370p-v7-0-222e296ac1e0@axis.com>
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
	<linux-kernel@vger.kernel.org>, Jonathan Cameron
	<jonathan.cameron@oss.qualcomm.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3705;
 i=kanak.shilledar@axis.com; h=from:subject:message-id;
 bh=lPbqmw97WHqi9a7JRElEt72C+UI1eV2jc6uPxGQ2Eqc=;
 b=owGbwMvMwCV2JPnG7+2HZqUznlZLYsi6b1zCL7jCer5y3qW/ZktzXwVpLBFZLfxYy/919eFT/
 Xp1BhMvdJSyMIhxMciKKbKcM9oevT/5n+4caadLMHNYmUCGMHBxCsBE2MQZfjJWvLhmnbhqG3OJ
 +OSQS0sdZ7iI3Fx78tj8157JOaf3z13F8Jvl1/aX7mclNRb7iFbuOnb0b2CtaPqW79ZZP8s3H1X
 55swGAA==
X-Developer-Key: i=kanak.shilledar@axis.com; a=openpgp;
 fpr=CDB0F1C8EAD5B522C7B3A77928221FF065DB55F9
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CPH1EPF00000524:EE_|VI1PR02MB10152:EE_
X-MS-Office365-Filtering-Correlation-Id: 77a00d8b-a2a3-42ed-5631-08df3350c52c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|32650700020|82310400026|1800799024|7416014|261009223027099003|261021121427099003|261022075727099003|261022105027099003|261021123027099003|10067099003|56012099006|18002099003|22082099003|921020|11063799006|3613699012;
X-Microsoft-Antispam-Message-Info:
	NV11MzyjVSR+7/CSjRjBWt3ws5cbLGucpOoW1fbdN6TgzCDHUnHVSab73lZylPAjbNfXM96dvux3XkLYCve1Q2X4ifNHPh5GZFZFOvjzPWK5jFltgKHx8KoBRhkMUmiEmjxY69V6eP1+zXuajlIiOBysdIXfBFBswo+GghjFVvOUO14s2qFzwZRE9fCkiw+QvwumB3c+T2Kx7p1ihasDECV9b7gkiv8+iFfrnMAWBkHv17TupssXuLo4I4rLAdsmO13xMVDvPoJ1I3xEjLNP91wwf5iUyMV6/Op49PTKgRsYS7UeenpS8lmidhZcY1XVuje7gWMTwImy3iwimxgknwvOzUeba9frWBRJhHiWAK39CycyC+UTd4nYIuKsKrNPpnstq2Xv6nciKob4hQsQc1SldlLucJr9VDsROx7IFUMDa0F+uY/4dmvMaM07ZNCt25WJ34IVKrJv36KT12BaOn9gXK1H8IrLE3qD4JmyceB6+V9N2jkf2Pu9GvdEaisd3zaPxnssxjjL4UzXyxg+GD3I70kkG7BCGa6blx8gOX7joS2OCazxG2hkkx2y+Oumn4V6/NCDUVeLJbAzoCPuNPu0K/0tPK+IaiVHd/kV7el8mbfBup01d2u/V+ZowlGzEqjNMi2YGsbFbx1LRG3wd+9bwVz0PltzkaZfc0+XONx1GIB/6hoiunF9BIrPBZpKS8LinRKzW9/TfgCPfXrkzJQL/7+yVb9vma8mCowhnTb21T6IGv2b0jmU3QUfPuIPRneaMJEqXhF9/jkA50Ppcw==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(32650700020)(82310400026)(1800799024)(7416014)(261009223027099003)(261021121427099003)(261022075727099003)(261022105027099003)(261021123027099003)(10067099003)(56012099006)(18002099003)(22082099003)(921020)(11063799006)(3613699012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1EDdbPatcs/N7kJGy5jzJc1qhsw0Wjhhqo9z+oj0RzT2QLzrAm0vb95ctCGHczdkgJz8f/qJI46FuIeS/CyrVyK1M6N9KBXtzbn4/oKszfNFcdeIXrOgftALT5WSc39Ka1n38qbuFzncgmRja2x3XwoCLoGyPfn+KU4/ddg/MWKcGyb0Qr6oedkeTh6b5zmB5ui2flR4faQVMguVBWdNtiYotP/GTTflMNzmiqjoC+SuSUcNzGvxKyZW2qMdi4lkDDIbZjjayWOJPeqNzNIqSHcqBX8bGbGUNPDt9KFTRq4f/0BOY3qvasUu7OSpXOaO5Iuq2xR/ttRb1+aF6XZfKV+brGn9J0cEAWUKtY+T699fnIWSO3Zcxvy+/ObKTRAiWcr885xsnKcVzePs0Y8nPDmjNY1e83nnJz50QteS9KUefvQGRutsl+dWm+9R2HRh
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 11:03:30.8097
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77a00d8b-a2a3-42ed-5631-08df3350c52c
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CPH1EPF00000524.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB10152

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

