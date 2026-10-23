Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792741738;
	b=GGpGjMcISI3HERk4mw1XuLzFl4CE+kp44M5xfyo4GeGWc/a6VB3ZxH1sCY5OM/DFbYN/
	 acuct3X3LkB7VnUK6e80HTaCoLZwYqhzcF7XqZb4oj4SeXQo4HsfLYD1wMa0dhBnL8BeA
	 rpz9BQQV1DgDPXkWSRdX3tm4XbjE7B/uWwIWoaNMXTzRRk4OjsZaGsRqkpbtTArAvPc31
	 XOuYw4mkhuuILxfvjlMPIHqs9hVVD/E2e73uu37p04vqZar+4QpsQUeXROnv6cD41NlaT
	 b5sI5pOajVM6/OSfibTh40GfXLVAHPMUCTmEDvUe0g+xz83sjbnKdDvmPsNy1EYkAhQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792741738;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-ID:References:
	 In-Reply-To:To:CC:X-Mailer:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=XDD8Vaq6MQCXwR6NekrNsLGqPebrwlF98tXoPxUnYqE=;
	b=we1EyCKcU4ZCw1CihaQjgqAEDeO7QpKGGJT8JhpQkk0IQkNNfgXDI+vJMD38myZF8sQ+
	 7LgsoRTTS1w2++4jyBeSA2pzC5Q0N7E4QJIEBqydh2m9l53vNbxXXbkzNoCWxlt+iXSWo
	 6/0YxnyuiV1HCnE/u2F61gYjRX6VrS3sVLesjAp/MJ7acWFZsd4El3v7HCzKQGnvEevAk
	 PRjJ51gGsev7bL7Gq42BmhczV/CNUKpgaDk9jWJAGuXsoFZW0tokPKYA0PNq8hpOYaZSt
	 y/7/4+gSyqYtKz0X+g9p9CyjTASTBnnUbxtJbfQ/1A/UuHF0k7PT3M050wrQrxkm6eA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=QWxld8Vm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.11
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011011.outbound.protection.outlook.com [52.101.65.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022F3606A338;
	Fri, 23 Oct 2026 07:48:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 022F3606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=QWxld8Vm
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SnomUNzEnaxVGJuYKz5Z4e73UC9pKJXzsc5+pZp5lVyqzepE482wc9k7g5AJtoKMiuoWmneWv6nlpV6uuaIOJ+O2sbKRdtbcSUd8HfcFjPdgGF710kHaHn1zpByb++Fzp7BARVNP+uki14dQspwd6rt4bQgOWo88GlQNp1W1bmZCLeHCeJ+ozvAhU3yldxenwDql9f2y+tYyh1xzYNrngRqd6gKBEs0Ab4lV53VAM7WRqR3PQX3KLhov28AuMhluxl80WL4Nfk1cpVTIZIY1x8AudbDsU0LfuEUUUQBzlXUzqpsI0jOU0Bs4PWza4G1c93J92N0stGNj1SnA65Vs8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XDD8Vaq6MQCXwR6NekrNsLGqPebrwlF98tXoPxUnYqE=;
 b=Gje4LdbnuHsE+xgtWOAUd/lpBvkvMd03c56xRe1pQ7pXe9M+MS4Fe3/SRuEv0zqgesrRFmuOyCV1nilYytWOoz/jc3yZyN6V9fORsvZePZygldPnWl/Go9hF/8gbq5zYbOIFCq2kAeHjFaui1UGMZ6UYDIHJaQ0DJKeAROGyR1r8vA0qqqugJVQfVDC+dN8KbpIYF/8z7EktuPDVJCJOWZIe3TOF6UKtZGwO3mwUFpwqX7yozkHi8NV32UkVbc7RmgLcYWllaZyJ1LZ9lpe5ORB+PDYMtYApnNICmH/K/BeoounJcdFxUOtzdwuh6OZAjQCcEZCu/caIaUwjnFEl+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XDD8Vaq6MQCXwR6NekrNsLGqPebrwlF98tXoPxUnYqE=;
 b=QWxld8Vm/tc0y6VEZ7yRgXjE+mjdV2fKDgTs1JjUAZ2JxCr6MjrAM39lyWoFW9K++07OPsScA1U7GgIrCOoifcG4CB9q5Mw+kU9K5g8Pl0E2vIOeh9ff1+4Swh3T0uaAWdMU9dPNXKbgI8h+/OUsy0uoWWqKpEZJl2U5d5nhnIk=
Received: from WA1P291CA0001.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:19::12)
 by OSKPR02MB11337.eurprd02.prod.outlook.com (2603:10a6:e10:95::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 07:48:51 +0000
Received: from WA1PEPF000099D0.eurprd04.prod.outlook.com
 (2603:10a6:1d0:19:cafe::8a) by WA1P291CA0001.outlook.office365.com
 (2603:10a6:1d0:19::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.19 via Frontend Transport; Fri,
 23 Oct 2026 07:48:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 WA1PEPF000099D0.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Fri, 23 Oct 2026 07:48:50 +0000
Received: from se-mail11w.axis.com (10.20.40.11) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Fri, 23 Oct
 2026 09:48:48 +0200
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Fri, 23 Oct 2026 09:48:48 +0200
Received: from pc46036-2141.se.axis.com (pc46036-2141.se.axis.com [10.94.180.139])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 19E014233;
	Fri, 23 Oct 2026 09:48:48 +0200 (CEST)
Received: by pc46036-2141.se.axis.com (Postfix, from userid 16197)
	id 14EC5584AC3D; Fri, 23 Oct 2026 09:48:48 +0200 (CEST)
From: Jesper X Nilsson <jesper.x.nilsson@axis.com>
Date: Fri, 23 Oct 2026 09:48:15 +0200
Subject: [PATCH 3/3] iio: light: opt4001: add support for opt4041
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
Message-ID: <20261023-opt4041-v1-3-45227f82d05c@axis.com>
References: <20261023-opt4041-v1-0-45227f82d05c@axis.com>
In-Reply-To: <20261023-opt4041-v1-0-45227f82d05c@axis.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Stefan
 Windfeldt-Prytz" <stefan.windfeldt-prytz@axis.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jesper X Nilsson <jesper.x.nilsson@axis.com>,
	<kernel@axis.com>
X-Mailer: b4 0.16.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: WA1PEPF000099D0:EE_|OSKPR02MB11337:EE_
X-MS-Office365-Filtering-Correlation-Id: c7d6fab7-19aa-46c9-40f0-08df30da1420
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|82310400026|36860700016|261022105027099003|261022075727099003|56012099006|261009221227099003|11063799006|261021123027099003|261009223027099003|261021121427099003|261021135927099003|10067099003|18002099003|22082099003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info:
	bHCHvqgqb87/x3E/QRmynhW6cTnTOezgJN2oM2TzgilCCx8leSb7atYAoqP0amQ2EPT2KQVqvmoa66CKAf0GB5ovsRfHAW4hYhkL3kRqu7hfL0jXdpMsprEz7mVHUDQVE/crogNxKtHDtSflMpe7Acot6o8Q6LtZaDTE831O3ghqZrbHnxvF+1rld8eQKTJ7IEYd1hna9Y9fbLuU+cSwk3mbtZRQMek28po6iiZao2WZ/M82lCu0TWJbOuOARrEzOiSGhj+6OHttFvFswCtGtrgBCYHW9lIgOp/fdzNbdS96EzyxkA64mTRKLAokaTM57I5JX6lTR31ATmNFWnsuOxwstK6Y1qwZo5k2KuocuR/ZMuHAfH1jMDfHqSLmxgvyLdAulPVhbh8L7GQKmS2d3cgwNpkiFxZMP5Enq6tlf7zBA1hhwP0Ju9kKQsBaAf8wrYMTsvGWOHH3GqC3426yO6Tr7eKuBSAzt4XhS0soNhtW6RY/ITucsdiSGv6i50hIn237LEKxgoomSCCZsxhqHdJAr93/jGQOkg51tKNybEls1KsKF6MM7WkMuPiHLTmZhtvjxfFf9iUq8vf33KUheNASGHHZHXnHE5Xl+oyjNsNJExbPZdudORl3o5Q1D895ahlXucWRhhxKswoJ3l87bXQNMzDAAt0seKkg0NvPpa8/DczlivAXq13cIYKq3JV7BMCxrrmiRXQpD7aI6BNl4Q==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(261022105027099003)(261022075727099003)(56012099006)(261009221227099003)(11063799006)(261021123027099003)(261009223027099003)(261021121427099003)(261021135927099003)(10067099003)(18002099003)(22082099003)(13003099007)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dbOQuRS8BN9FVr00kxFabchS7MTESIoGuv4z9higPibnHGx01KC84fNp3qrAg43YTY9bFDMeeTL/92seZhTVEGWcWl72x042zMTah17G0YaU0tyv4LDrQjOmUzGUR9aHLEOLMSZPzt2a8VNYFwJ8z7wJWdEZOEFVxkJRfz7h0D6K4OS4I+AtHD4+0Xf9ljP5D7fvZwvdyPgIODnkP6DOAdhH+VLOf6dvJt9gTOkr+VxOGRkv3AmNTP4ugclcCsenziGt5VCuqV1pwti3E0PRng/soPFU8eWg9NSWR+LXNUhVGJOTvIm2GViFH8T09XElO3AGg3IVHOjDx8pNWGdSI7X9byD/3LHRo3+jW7vIRZep6VhstSgg2EEaa9QMHWUGtsSP/NH7ojrfG96lsWeM1FcUO2VuNJ9e0NOwPqOogomsodMyqj8Hg9+a1GzA6AlS
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 07:48:50.8062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7d6fab7-19aa-46c9-40f0-08df30da1420
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	WA1PEPF000099D0.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR02MB11337

Extend the opt4001 driver to also support OPT4041. The devices are very
similar, with the difference being OPT4041 having two channels, one
visible and one wide band channel ranging from 380nm to 1000nm.

The register map is almost the same. OPT4001 has registers to read out
the last four values sampled. OPT4041 maps to the same registers, but
has two channels, saving the last two samples for each channel.

Datasheet: https://www.ti.com/lit/gpn/opt4041
Assisted-by: LLM
Signed-off-by: Jesper X Nilsson <jesper.x.nilsson@axis.com>
---
 drivers/iio/light/Kconfig   |  2 +-
 drivers/iio/light/opt4001.c | 67 ++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 64 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 462fff1ddef2..625ebb10ad1b 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -508,7 +508,7 @@ config OPT4001
 	select REGMAP_I2C
 	help
 	  If you say Y or M here, you get support for Texas Instruments
-	  OPT4001 Ambient Light Sensor.
+	  OPT4001 and OPT4041 Ambient Light Sensors.
 
 	  If built as a dynamically linked module, it will be called
 	  opt4001.
diff --git a/drivers/iio/light/opt4001.c b/drivers/iio/light/opt4001.c
index bf5dc1c8514c..ff142591fcba 100644
--- a/drivers/iio/light/opt4001.c
+++ b/drivers/iio/light/opt4001.c
@@ -2,9 +2,11 @@
 /*
  * Copyright (C) 2023 Axis Communications AB
  *
- * Datasheet: https://www.ti.com/lit/gpn/opt4001
+ * Datasheets:
+ *  https://www.ti.com/lit/gpn/opt4001
+ *  https://www.ti.com/lit/gpn/opt4041
  *
- * Device driver for the Texas Instruments OPT4001.
+ * Device driver for the Texas Instruments OPT4001 and OPT4041.
  */
 
 #include <linux/bitfield.h>
@@ -19,6 +21,8 @@
 /* OPT4001 register set */
 #define OPT4001_LIGHT1_MSB    0x00
 #define OPT4001_LIGHT1_LSB    0x01
+#define OPT4041_LIGHT2_MSB    0x02
+#define OPT4041_LIGHT2_LSB    0x03
 #define OPT4001_CTRL          0x0A
 #define OPT4001_DEVICE_ID     0x11
 
@@ -43,6 +47,7 @@
 
 /* OPT4001 constants */
 #define OPT4001_DEVICE_ID_VAL            0x121
+#define OPT4041_DEVICE_ID_VAL            0x221
 
 /* OPT4001 operating modes */
 #define OPT4001_CTRL_OPER_MODE_OFF        0x0
@@ -72,7 +77,7 @@
 
 /*
  * The different packaging of OPT4001 has different constants used when calculating
- * lux values.
+ * lux values and OPT4041 has one additional wide band channel.
  */
 struct opt4001_chip_info {
 	int mul;
@@ -100,6 +105,25 @@ static const struct iio_chan_spec opt4001_channels[] = {
 	},
 };
 
+static const struct iio_chan_spec opt4041_channels[] = {
+	{
+		.type = IIO_LIGHT,
+		.address = OPT4001_LIGHT1_MSB,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME)
+	},
+	{
+		.type = IIO_INTENSITY,
+		.modified = 1,
+		.channel2 = IIO_MOD_LIGHT_BOTH,
+		.address = OPT4041_LIGHT2_MSB,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME)
+	},
+};
+
 static const struct opt4001_chip_info opt4001_sot_5x3_info = {
 	.mul = 4375,
 	.div = 10000000,
@@ -118,6 +142,15 @@ static const struct opt4001_chip_info opt4001_picostar_info = {
 	.device_id = OPT4001_DEVICE_ID_VAL,
 };
 
+static const struct opt4001_chip_info opt4041_sot_5x3_info = {
+	.mul = 5850,
+	.div = 10000000,
+	.name = "opt4041-sot-5x3",
+	.channels = opt4041_channels,
+	.num_channels = ARRAY_SIZE(opt4041_channels),
+	.device_id = OPT4041_DEVICE_ID_VAL,
+};
+
 static const int opt4001_int_time_available[][2] = {
 	{ 0,    600 },
 	{ 0,   1000 },
@@ -270,10 +303,30 @@ static int opt4001_read_raw(struct iio_dev *indio_dev,
 			    int *val, int *val2, long mask)
 {
 	struct opt4001_chip *chip = iio_priv(indio_dev);
+	u64 raw_value;
+	u32 rem;
+	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_PROCESSED:
 		return opt4001_read_lux_value(chip, chan->address, val, val2);
+	case IIO_CHAN_INFO_RAW:
+		ret = opt4001_read_raw_value(chip, chan->address, &raw_value);
+		if (ret)
+			return ret;
+
+		*val = div_u64_rem(raw_value, 100, &rem);
+		*val2 = rem * 10000;
+		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_SCALE:
+		/*
+		 * OPT4041 CH1: datasheet specifies 0.1923 nW/cm^2 per ADC code
+		 * with a 520 nm stimulus. Convert to nW/m^2 (x10000) and
+		 * compensate for dividing the reported raw value by 100 (x100).
+		 * The resulting scale is 192300 nW/m^2 per reported unit.
+		 */
+		*val = 192300;
+		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_INT_TIME:
 		*val = 0;
 		*val2 = opt4001_int_time_reg[chip->int_time][0];
@@ -340,6 +393,8 @@ static bool opt4001_readable_reg(struct device *dev, unsigned int reg)
 	switch (reg) {
 	case OPT4001_LIGHT1_MSB:
 	case OPT4001_LIGHT1_LSB:
+	case OPT4041_LIGHT2_MSB:
+	case OPT4041_LIGHT2_LSB:
 	case OPT4001_CTRL:
 	case OPT4001_DEVICE_ID:
 		return true;
@@ -363,6 +418,8 @@ static bool opt4001_volatile_reg(struct device *dev, unsigned int reg)
 	switch (reg) {
 	case OPT4001_LIGHT1_MSB:
 	case OPT4001_LIGHT1_LSB:
+	case OPT4041_LIGHT2_MSB:
+	case OPT4041_LIGHT2_LSB:
 		return true;
 	default:
 		return false;
@@ -448,6 +505,7 @@ static int opt4001_probe(struct i2c_client *client)
 static const struct i2c_device_id opt4001_id[] = {
 	{ .name = "opt4001-sot-5x3", .driver_data = (kernel_ulong_t)&opt4001_sot_5x3_info },
 	{ .name = "opt4001-picostar", .driver_data = (kernel_ulong_t)&opt4001_picostar_info },
+	{ .name = "opt4041-sot-5x3", .driver_data = (kernel_ulong_t)&opt4041_sot_5x3_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, opt4001_id);
@@ -455,6 +513,7 @@ MODULE_DEVICE_TABLE(i2c, opt4001_id);
 static const struct of_device_id opt4001_of_match[] = {
 	{ .compatible = "ti,opt4001-sot-5x3", .data = &opt4001_sot_5x3_info},
 	{ .compatible = "ti,opt4001-picostar", .data = &opt4001_picostar_info},
+	{ .compatible = "ti,opt4041-sot-5x3", .data = &opt4041_sot_5x3_info},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, opt4001_of_match);
@@ -470,5 +529,5 @@ static struct i2c_driver opt4001_driver = {
 module_i2c_driver(opt4001_driver);
 
 MODULE_AUTHOR("Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>");
-MODULE_DESCRIPTION("Texas Instruments opt4001 ambient light sensor driver");
+MODULE_DESCRIPTION("Texas Instruments opt4001 and opt4041 ambient light sensor driver");
 MODULE_LICENSE("GPL");

-- 
2.43.0

