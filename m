Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793012612;
	b=Gj3LVioZakmgCbOTYRW2pX9WEtFvG5hArNldONIwfQKPnqvRvT3ACRmQiJUO4D8dZj4I
	 YxXsl/E26NSYiqMD6sVIvKo3u0s+srtTc6LRVza0+/6Bwf1RfFVEsPnLmptKcUpJTRra5
	 k/AqeVZXpu2tmkML8GJuWf12h2aAFh5jxLkC63Ro0W+DE55gttt96MC5s24LAw/F3wAr3
	 IfIJbwifI2M2r/rStT3PKUHLbIzvC+2rVd33Fx4sf47CiIWN2wFmDsRi3+5PVQeBAjPeH
	 gxT2FWsZnfsDWikQIPvgsk8KbIcdfrlbdhnPiL4QbkjV0eTP7iXxThCInGAcjkdcLzg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793012612;
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
	bh=aUw3C5XQP9e+0D4SjA/YcsjeDW/M4nwOP1614ergjWU=;
	b=MLTceZ2RCmdCDk9CqLREUwpnHR7QQu1kqn3TF8hkDFuGocim87pO1nAZr4jvb25vls72
	 I1bs2jXKm/OLmrpyiBR43aady7kJhfU4eyLyL4YaKhPAEasQDhVihaS30hRKuap2vh9DI
	 hJGvSbnEE4B7/cZ3pt1aDUkwB81OyTNLZNnALR/kaBC03U56cCNj9HElCdfC8hw9IfwH8
	 eUAHWwKPq3r6tMqaTVInwgbDH3J15H/uq53rYJphQ9NVWNPlejVzktnpQORPZy5c+gNCn
	 0Z/hdtH5FUPvMM/KY94Q/jqB8Ml03C0Jd3/KXe7SQ9eLSiewyz1wXDl2Mx7lA0cdHrg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=m35cZB+X;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.21
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010021.outbound.protection.outlook.com [52.101.69.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF10C606A337;
	Mon, 26 Oct 2026 11:03:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF10C606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=m35cZB+X
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sA0kmGqH4oDfsvS8cyuw6XnqiJ4Vz7ghwY1DigWqw8wJ72C2FwDE8WPE2GHTSyQJpmVjHWYsj1maIUbmAr9LsPup6F6GcvQ+HyBB29gDbJYf5xa7mwZw2yB+mWpx2ive70L44MK47SGetMBT3alOu7hsDSBk4/zcy7f2gcd7IjiYaFG/zLRUMm6HEExz0qQ18RY8WJmCjVsk0nxRqEnbFwv0nYNzA8g23qD5OLJ8wMN6IqmAnlSnC27238aJzoi75jFDtg+GYjkRVBieZVhpyivhgcPX9cBdImiEuqRoSosNU/XF2pleHrR4tQJX7U7TMwLhvErZTmj0NaYlHiTEgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aUw3C5XQP9e+0D4SjA/YcsjeDW/M4nwOP1614ergjWU=;
 b=XqoR3REUXSMpsHtEg3EfD8jwE7cJrBarQIWt8VkvcnWGJYDSICXjoBqwniw27k2NUVP2JT+RpEOJTAb+yCdapQL68QxqyUjDi2ptGICa5g2VdcYLFokNkQfY9y03wcYBwumKz27uspzt0n5wvwG/u1xF+fGnfz+ojW4wBZi001cUqBo9LS4kiTeqgcEYLn1euS4w2zSYZCYI/dNlqItny8SOzTYQiZSzQhbQlMHg7ht0Jbe8YrYiadCp1lGvfN+Cn/C/DXIA3KajcH5ZDWC1TkRXjrzvC7Z1VUVgiMZuDPo9cvQ6Mryj8RN6tyrPtraDLSZm3wS/jQX6HmnHcfNkkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUw3C5XQP9e+0D4SjA/YcsjeDW/M4nwOP1614ergjWU=;
 b=m35cZB+XRjE1RhjUn1tnpxu3zt/nT68pfnwEfejcrEtHtpK4QsrUII1aCj/iGRGgWDxwoNMf7yINGghNN0e0vVZl3enfyX/AY66RAj8zkfzrKHbZI6sOSPIC0R+iXQ+ESDxMBMmZvq8weh6ZHvLpCbxAqcMKmeJftD2iye6fu+A=
Received: from GV3PEPF0001DD9D.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6d1) by BESPR02MB165241.eurprd02.prod.outlook.com
 (2603:10a6:b10:140::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 11:03:28 +0000
Received: from CPH1EPF00000524.eurprd05.prod.outlook.com (2603:10a6:388::1e7)
 by GV3PEPF0001DD9D.outlook.office365.com (2603:10a6:158:401::6d1) with
 Microsoft SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id
 15.21.406.10 via Frontend Transport; Mon, 26 Oct 2026 11:03:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 CPH1EPF00000524.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 11:03:28 +0000
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
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 73E233033;
	Mon, 26 Oct 2026 12:03:17 +0100 (CET)
Received: by pc66231-2602.sto.se.axis.com (Postfix, from userid 21940)
	id 4647630182F9; Mon, 26 Oct 2026 12:03:17 +0100 (CET)
From: Kanak Shilledar <kanak.shilledar@axis.com>
Date: Mon, 26 Oct 2026 12:02:55 +0100
Subject: [PATCH v7 7/7] iio: imu: inv_icm42607: Add accelerometer calibbias
 support
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
Content-Transfer-Encoding: 8bit
Message-ID: <20261026-b4-inv_icm42370p-v7-7-222e296ac1e0@axis.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10021;
 i=kanak.shilledar@axis.com; h=from:subject:message-id;
 bh=+7uxZlPrqOccc0IDk5U9AqEB6L0/+YaqsDWYlPYvWzA=;
 b=owGbwMvMwCV2JPnG7+2HZqUznlZLYsi6b1zqJrBlZ/VClxfx7/xilgjxsB6rsDH496Al5Cpvx
 WSbK2wnO0pZGMS4GGTFFFnOGW2P3p/8T3eOtNMlmDmsTCBDGLg4BWAiBbsZGVZ2bLxSn2UYJdZ3
 95Kd7J2GSY2HW6tSu3sPVKmet6/cvYnhr8ANXocekwW5WVfuyAaWHTHa7bg56p3zYbHVb0WNord
 YsQIA
X-Developer-Key: i=kanak.shilledar@axis.com; a=openpgp;
 fpr=CDB0F1C8EAD5B522C7B3A77928221FF065DB55F9
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CPH1EPF00000524:EE_|BESPR02MB165241:EE_
X-MS-Office365-Filtering-Correlation-Id: 33e43653-25cd-44d1-8b6f-08df3350c385
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|32650700020|82310400026|23010399003|7416014|376014|1800799024|18002099003|6133799003|22082099003|921020|3613699012|56012099006|11063799006|261021121427099003|10067099003|261009223027099003|261022105027099003|261022075727099003|261022113327099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	1BY/zwUJ+X5CWbMnH/Rgcs85c4aquwDc2OJyfoIk2za0Itk4uoKz11MQR5xn1mwnB6SXA1N6j11wY9vBeOEsDPblbclNWmr2f8oPJHfFLr1MbbI1gTJG7ur7d/qhsfWNgAIRCoRxkg2UYJSi2O/SUSMwCXP92hQZ8rS0EthiW7zS4Nqjz6bUx7ue8DV6PJ/LlUTXuDCQUEyqKj0AL5xwdNzZ6QsN0upUU2Y3yeZ4IjrSUN/1bwGyqJwAzmy1pvuFw3Y19QpnUsMT7tqO1tNtkBTuekQ6/VvHSVvMS+2mtKtIIbn12RiVU3W9mOAyBbxT6nTx0Rj5iKdrUCP7irFWWQWrs3pZuNGXnuEPf+8o4N1VLTsnB7vFZN2uVp0f3C6RwxTW9KBSTdepKoz1R9np+4PuNWgj+UrSd9K3cSuUdu/JSa4VX1O2ikBYM/bhiG7blJTYDZ5h9y2boJNtSAVnW2f7kXS3/A7R8pZfLtuQRjU8v5wyENfCnpyEkEwOtbnVgTz4JB5wrqa7Q1k6096G5HbtO95O3k7QIUUD6cMg182Ddb0krVGzVESd8pX43k1yYbPmTkbw2CJ0POReeu1EgdJYpMp8Atvc10QAZIf/qTf469aMWRfPkqPdy7gfg3e7xv4ZWpksZwujQeyGsb19BoW3De4sKh8dI68gRDajLh9sWL9CCzsM69dvkcRysgpgvdcGI4i1ioWVxiNlkIN2Y0PMMyGA8fcmiRHDPzzYCEk=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(32650700020)(82310400026)(23010399003)(7416014)(376014)(1800799024)(18002099003)(6133799003)(22082099003)(921020)(3613699012)(56012099006)(11063799006)(261021121427099003)(10067099003)(261009223027099003)(261022105027099003)(261022075727099003)(261022113327099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oRrL98SxGcyI2iUPakqSQEHKkparBHGesg25wqMUcWl6vQ75EZYj/ENl2brntY2Y2pdaLOeAz7D5ZL5y8132wNToWP0yPFPkX2vGh7NbNUKkbT5fxyqaci2oh1iIr/vVY/NdixbEaGot3ovX25GGQc1dpCdB7kAEZfUBNlsrJBppformVx6U+KXE8S5OD6cIiGik+8eRTZRalRGDKGEgH6wWrHO+2JbbgVrf28YuXGUwf8ALPNKUx2u5Q/zHrCRHd//jYXfDJrhGuFNc7gnjg7pZKPoWPLZWJmJye7pwFAbu0YcYnQWGzkCs1PWPF34S77k8yQA4BwJQsf/cRMlHMpi3QzuZt3raDLOK0SmVfVqt/Qx6gUdpfPtSXw5IpumxC1vFugAh8m09pCQveXXAzWi9kHZnt9ru5FuR2Q6dLVU+GSxY95HMXfq5Db7hE9sQ
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 11:03:28.0411
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e43653-25cd-44d1-8b6f-08df3350c385
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CPH1EPF00000524.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESPR02MB165241

Expose IIO_CHAN_INFO_CALIBBIAS on the accelerometer channels. The
registers are stored in MREG1. The calibration bias is written to
OFFSET_USER4 to OFFSET_USER8 registers in MREG1. Reject the out of
limit calibbias values instead of clamping it.

Datasheet: https://www.invensense.tdk.com/en-us/products/3-axis/icm-42370-p
Datasheet: https://www.lcsc.com/product-detail/C5129967.html
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
---
Note: The accelerometer functionality is tested with Invensense,
ICM42370-P development board.
---
 drivers/iio/imu/inv_icm42607/inv_icm42607.h       |   8 +
 drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c | 189 +++++++++++++++++++++-
 2 files changed, 195 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
index eecf4c46cbdb0..f4b46597a2bc5 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
@@ -437,6 +437,14 @@ struct inv_icm42607_sensor_state {
  */
 #define INV_ICM42607_SUSPEND_DELAY_MS			(2 * MSEC_PER_SEC)
 
+/* OFFSET_USERx shared registers two 4-bit MSB fields */
+#define INV_ICM42607_OFFSET_USER_NIBBLE_HI	GENMASK(7, 4)
+#define INV_ICM42607_OFFSET_USER_NIBBLE_LO	GENMASK(3, 0)
+
+/* 12-bit signed offset value split across two registers */
+#define INV_ICM42607_OFFSET_MSB			GENMASK(11, 8)
+#define INV_ICM42607_OFFSET_LSB			GENMASK(7, 0)
+
 typedef int (*inv_icm42607_bus_setup)(struct inv_icm42607_state *);
 
 extern const struct regmap_config inv_icm42607_regmap_config;
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
index 9a3ace3e7fcf9..2878e35d655d0 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/array_size.h>
+#include <linux/bitfield.h>
 #include <linux/bits.h>
 #include <linux/cleanup.h>
 #include <linux/device/devres.h>
@@ -13,6 +14,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/types.h>
+#include <linux/units.h>
 
 #include "inv_icm42607.h"
 #include "inv_icm42607_temp.h"
@@ -22,9 +24,11 @@
 	.type = IIO_ACCEL,							\
 	.modified = 1,								\
 	.channel2 = _modifier,							\
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),				\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |				\
+		BIT(IIO_CHAN_INFO_CALIBBIAS),					\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),			\
-	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE),		\
+	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE) |	\
+		BIT(IIO_CHAN_INFO_CALIBBIAS),					\
 	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
 	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
 	.scan_index = _index,							\
@@ -56,6 +60,16 @@ static const struct iio_chan_spec inv_icm42607_accel_channels[] = {
 	INV_ICM42607_TEMP_CHAN(INV_ICM42607_ACCEL_SCAN_TEMP),
 };
 
+/*
+ * Calibration bias values, IIO range format int + micro.
+ * Value is limited to +/-1g coded on 12 bits signed. Step is 0.5mg.
+ */
+static const int inv_icm42607_accel_calibbias[] = {
+	-10, 42010, /* Min : -2^11 * 0.0005 * 9.80665	   = -10.042010 m/s²	*/
+	  0,  4903, /* Step: 0.0005 * 9.80665		   = 0.004903 m/s²	*/
+	 10, 37106, /* Max : (2^11 - 1) * 0.0005 * 9.80665 = 10.037106 m/s²	*/
+};
+
 static const int inv_icm42607_accel_scale_nano[][2] = {
 	[INV_ICM42607_ACCEL_FS_16G] = { 0, 4788403 },
 	[INV_ICM42607_ACCEL_FS_8G] = { 0, 2394202 },
@@ -176,6 +190,166 @@ static int inv_icm42607_accel_write_odr(struct iio_dev *indio_dev,
 	return inv_icm42607_set_sensor_conf(st, &conf, IIO_ACCEL);
 }
 
+static int inv_icm42607_accel_read_offset(struct inv_icm42607_state *st,
+		struct iio_chan_spec const *chan, int *val, int *val2)
+{
+	struct device *dev = regmap_get_device(st->map);
+	unsigned int msb_reg, lsb_reg, nib, byte;
+	int offset;
+	s64 val64;
+	s32 bias;
+	int ret;
+	u32 raw;
+
+	if (chan->type != IIO_ACCEL)
+		return -EINVAL;
+
+	switch (chan->channel2) {
+	case IIO_MOD_X:
+		msb_reg = INV_ICM42607_REG_OFFSET_USER4;
+		lsb_reg = INV_ICM42607_REG_OFFSET_USER5;
+		break;
+	case IIO_MOD_Y:
+		msb_reg = INV_ICM42607_REG_OFFSET_USER7;
+		lsb_reg = INV_ICM42607_REG_OFFSET_USER6;
+		break;
+	case IIO_MOD_Z:
+		msb_reg = INV_ICM42607_REG_OFFSET_USER7;
+		lsb_reg = INV_ICM42607_REG_OFFSET_USER8;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&st->lock);
+
+	ret = regmap_read(st->map, msb_reg, &nib);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(st->map, lsb_reg, &byte);
+	if (ret)
+		return ret;
+
+	/* 12 bits signed value */
+	if (chan->channel2 == IIO_MOD_Y)
+		raw = FIELD_PREP(INV_ICM42607_OFFSET_MSB,
+				 FIELD_GET(INV_ICM42607_OFFSET_USER_NIBBLE_LO, nib));
+	else
+		raw = FIELD_PREP(INV_ICM42607_OFFSET_MSB,
+				 FIELD_GET(INV_ICM42607_OFFSET_USER_NIBBLE_HI, nib));
+
+	raw |= FIELD_PREP(INV_ICM42607_OFFSET_LSB, byte);
+	offset = sign_extend32(raw, 11);
+
+	/*
+	 * Convert raw offset to g then to m/s²
+	 * 12 bits signed raw step 0.5mg to g: 5 / 10000
+	 * g to m/s²: 9.806650
+	 * Result in micro (1000000)
+	 * (offset * 5 * 9.806650 * 1000000) / 10000
+	 */
+	val64 = (s64)offset * 5LL * 9806650LL;
+	/* For rounding, add + or - divisor (10000) divided by 2 */
+	bias = DIV_S64_ROUND_CLOSEST(val64, 10000L);
+	*val = bias / (long)MEGA;
+	*val2 = bias % (long)MEGA;
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int inv_icm42607_accel_write_offset(struct iio_dev *indio_dev,
+					   struct iio_chan_spec const *chan,
+					   int val, int val2)
+{
+	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
+	struct device *dev = regmap_get_device(st->map);
+	s32 min, max;
+	u8 msb, lsb;
+	s16 offset;
+	s64 val64;
+	int ret;
+
+	if (chan->type != IIO_ACCEL)
+		return -EINVAL;
+
+	/* inv_icm42607_accel_calibbias: min - step - max in micro */
+	min = inv_icm42607_accel_calibbias[0] * (long)MEGA -
+	      inv_icm42607_accel_calibbias[1];
+	max = inv_icm42607_accel_calibbias[4] * (long)MEGA +
+	      inv_icm42607_accel_calibbias[5];
+
+	val64 = val * (s64)MEGA;
+	if (val >= 0)
+		val64 += val2;
+	else
+		val64 -= val2;
+
+	if (val64 < min || val64 > max)
+		return -EINVAL;
+
+	/*
+	 * Convert m/s² to g then to raw value
+	 * m/s² to g: 1 / 9.806650
+	 * g to raw 12 bits signed, step 0.5mg: 10000 / 5
+	 * val in micro (1000000)
+	 * val * 10000 / (9.806650 * 1000000 * 5)
+	 */
+	val64 *= 10000LL;
+	offset = DIV_S64_ROUND_CLOSEST(val64, 9806650 * 5);
+
+	/* Value is limited to 12 bits signed, return -EINVAL if out of range */
+	if (offset < -2048 || offset > 2047)
+		return -EINVAL;
+
+	msb = FIELD_GET(INV_ICM42607_OFFSET_MSB, offset);
+	lsb = FIELD_GET(INV_ICM42607_OFFSET_LSB, offset);
+
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&st->lock);
+
+	switch (chan->channel2) {
+	case IIO_MOD_X:
+		/* OFFSET_USER4 upper nibble is shared. */
+		ret = regmap_update_bits(st->map, INV_ICM42607_REG_OFFSET_USER4,
+				INV_ICM42607_OFFSET_USER_NIBBLE_HI,
+				FIELD_PREP(INV_ICM42607_OFFSET_USER_NIBBLE_HI, msb));
+		if (ret)
+			return ret;
+
+		return regmap_write(st->map, INV_ICM42607_REG_OFFSET_USER5, lsb);
+	case IIO_MOD_Y:
+		/* OFFSET_USER7 lower nibble is shared. */
+		ret = regmap_update_bits(st->map, INV_ICM42607_REG_OFFSET_USER7,
+				INV_ICM42607_OFFSET_USER_NIBBLE_LO,
+				FIELD_PREP(INV_ICM42607_OFFSET_USER_NIBBLE_LO, msb));
+		if (ret)
+			return ret;
+
+		return regmap_write(st->map, INV_ICM42607_REG_OFFSET_USER6, lsb);
+	case IIO_MOD_Z:
+		/* OFFSET_USER7 upper nibble is shared. */
+		ret = regmap_update_bits(st->map, INV_ICM42607_REG_OFFSET_USER7,
+				INV_ICM42607_OFFSET_USER_NIBBLE_HI,
+				FIELD_PREP(INV_ICM42607_OFFSET_USER_NIBBLE_HI, msb));
+		if (ret)
+			return ret;
+
+		return regmap_write(st->map, INV_ICM42607_REG_OFFSET_USER8, lsb);
+	default:
+		return -EINVAL;
+	}
+}
+
 static int inv_icm42607_accel_read_raw(struct iio_dev *indio_dev,
 				       struct iio_chan_spec const *chan,
 				       int *val, int *val2, long mask)
@@ -207,6 +381,8 @@ static int inv_icm42607_accel_read_raw(struct iio_dev *indio_dev,
 		return inv_icm42607_accel_read_scale(indio_dev, val, val2);
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return inv_icm42607_accel_read_odr(st, val, val2);
+	case IIO_CHAN_INFO_CALIBBIAS:
+		return inv_icm42607_accel_read_offset(st, chan, val, val2);
 	default:
 		return -EINVAL;
 	}
@@ -231,6 +407,12 @@ static int inv_icm42607_accel_read_avail(struct iio_dev *indio_dev,
 		*length = (ARRAY_SIZE(inv_icm42607_accel_odr) -
 			   INV_ICM42607_ODR_1600HZ) * 2;
 		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_CALIBBIAS:
+		if (chan->type != IIO_ACCEL)
+			return -EINVAL;
+		*vals = inv_icm42607_accel_calibbias;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		return IIO_AVAIL_RANGE;
 	default:
 		return -EINVAL;
 	}
@@ -250,6 +432,8 @@ static int inv_icm42607_accel_write_raw(struct iio_dev *indio_dev,
 		return ret;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return inv_icm42607_accel_write_odr(indio_dev, val, val2);
+	case IIO_CHAN_INFO_CALIBBIAS:
+		return inv_icm42607_accel_write_offset(indio_dev, chan, val, val2);
 	default:
 		return -EINVAL;
 	}
@@ -265,6 +449,7 @@ static int inv_icm42607_accel_write_raw_get_fmt(struct iio_dev *indio_dev,
 			return -EINVAL;
 		return IIO_VAL_INT_PLUS_NANO;
 	case IIO_CHAN_INFO_SAMP_FREQ:
+	case IIO_CHAN_INFO_CALIBBIAS:
 		return IIO_VAL_INT_PLUS_MICRO;
 	default:
 		return -EINVAL;

-- 
2.43.0

