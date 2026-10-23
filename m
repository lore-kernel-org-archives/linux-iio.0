Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.67
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792758649;
	b=t/+nJeJ/Ik+YKGEyMs1ikCG+bnLE2w+fJHW9mFaN4huBt6P9TZNaRqic0DHewuWvHtdQ
	 S+o3YZxGcwjQdkGX7fDCv3Jyw2nUiPkTfCSBrVkQtdFb9fGFzWcZLEt3/rvJc92YmfPMf
	 X2fsfp1Uh4fHAH6mT0tQkU4oVvkb2XUbmcr8DKa0AylJGlnbB5imaGlz7jDGcvse4ltsc
	 O//pvSDG1m8ABb88zORMJKWyroVwxvLGJRLEXhzDuLpqHWBeYPACYa7VKrA+EIGZsQf54
	 5SExBOFiSJgoJrO4qyqX6yVZXzmzn0zHJ4EB2STmqzUy2zU7h8tDVcMX9vc2A659HSQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792758649;
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
	bh=G4XO4J0RuO5haS0B2fTUu4RVG4dbff13WVMNyn8AvdE=;
	b=TZOaMRWp8Ga3KxalSQgbZ7qvW1xGOWQ55XetWDUg4shZYTimwWlS+2c4HRoGDprvz4X+
	 4Atml83AZrFMJGABRum1pDl2AWy2EBGzLzLl9zfDTvmuIJeXryRIR/73PW0lw0AmVSD7D
	 vNAkIpPF8GetpVTo7GyE22LAu54RJAVQ6OuSljJu2mwcB7j/vRIBzWwsabuRvMKi9sp1x
	 oM6dpjZAhlxKlQ36AiQmsKqMskk3rSIOaKptIp8fmzFozj2c7g1HuYp1wTopiQmkrWa8s
	 fMR/nG5E3+lQlF07dSLm1wCMaFiQa51pK21pzSltQ5eaEvQIHiaezz9GCExOhhGajgA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=bRpDvQE6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.67
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010067.outbound.protection.outlook.com [52.101.69.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461EB606A31F;
	Fri, 23 Oct 2026 12:30:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 461EB606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=bRpDvQE6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pfv2XZ2MJUc4kqlBPm2/xuPKlmn2z4cEy/ftVPvNRzGWjcaBsjxtgQ0Shv1IJEvnBxOArilQFenjKZm1MLCcs+k0ZLJWOuhoVH5xNSoqzSvZkTOQZml/RuBpe1DhriMQNiRVNhShXV4/sQHstUKp2XneQ4FaPZ+3m0wgOSLyxxCVm42Fs58CEGnftTqG08CK/QraAkzhspS1hoISJ3D8+yWaDx1t8Nlvqw7VZVgFWahYXlYOehhfi+SQ/BlrsXL/8zZadf4e/4NcDbWkxPvFyHzuM0nSXpmeLCZoictNqv4TkZZI2J3dylgi99/kjMzqo23Q41vwYEs2DsQ3wVe12A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4XO4J0RuO5haS0B2fTUu4RVG4dbff13WVMNyn8AvdE=;
 b=Mk29xjGBvczt0U+ojFDOgYsnReNcjorz2Ka4Bsf3VRYadcdCgUzZn+o0v2HdAr2KE8TO2to3FYg4lm8MkDUgE1IHubLeZ2lHsCkczWQHR58HKvuFp+zbGIe5w2mA7hL6jGQQ1/wuHObX9fiYvOMoeI+9ztlIFWjudZeepiJdtB+jxyH5hy/vpfEmz9Pwk+AWqj0lS5cALRwy6u+T/x/6W8uNt4CWMDQ28Tk0mgFtPi7DYObw2+3dX/kiw4XQHeLWJhGQ6uVAV9tPKTFVzqQe2g80HElWIFGMEawGLHjn8W9a3/AoO0SkUbWibhlyUsyq6ehZ2Lf5r6Edp7pCSczK9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4XO4J0RuO5haS0B2fTUu4RVG4dbff13WVMNyn8AvdE=;
 b=bRpDvQE6npRK6GOYKQruLWXDPPzJwArtdWgfCDVNfgADBClpXSmIzMA66h21Z7A5wFFiawaDU/K2apaqXYPmEAL0NXff0d7j+izfBAM9uPxZMK/KRTRR2a8xrXbwdHyjxzWKJ9JtRgTU9wNWW7j0vDaAdUVUmW7pH11R0n2AI/4=
Received: from AS9PR06CA0337.eurprd06.prod.outlook.com (2603:10a6:20b:466::13)
 by VI1PR02MB6125.eurprd02.prod.outlook.com (2603:10a6:800:18c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 12:30:42 +0000
Received: from AMS1EPF0000008F.eurprd05.prod.outlook.com
 (2603:10a6:20b:466:cafe::8e) by AS9PR06CA0337.outlook.office365.com
 (2603:10a6:20b:466::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.19 via Frontend Transport; Fri,
 23 Oct 2026 12:30:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS1EPF0000008F.mail.protection.outlook.com (10.167.242.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Fri, 23 Oct 2026 12:30:41 +0000
Received: from se-mail11w.axis.com (10.20.40.11) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Fri, 23 Oct
 2026 14:30:37 +0200
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Fri, 23 Oct 2026 14:30:37 +0200
Received: from pc46036-2141.se.axis.com (pc46036-2141.se.axis.com [10.94.180.139])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id B12D83CFB;
	Fri, 23 Oct 2026 14:30:37 +0200 (CEST)
Received: by pc46036-2141.se.axis.com (Postfix, from userid 16197)
	id AE7F1584AC3D; Fri, 23 Oct 2026 14:30:37 +0200 (CEST)
From: Jesper X Nilsson <jesper.x.nilsson@axis.com>
Date: Fri, 23 Oct 2026 14:30:31 +0200
Subject: [PATCH v2 4/4] iio: light: opt4001: add support for opt4041
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
Message-ID: <20261023-opt4041-v2-4-ee320812804c@axis.com>
References: <20261023-opt4041-v2-0-ee320812804c@axis.com>
In-Reply-To: <20261023-opt4041-v2-0-ee320812804c@axis.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF0000008F:EE_|VI1PR02MB6125:EE_
X-MS-Office365-Filtering-Correlation-Id: 76c9f024-57a1-4b66-c466-08df310173d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|23010399003|82310400026|7416014|376014|22082099003|18002099003|3023799007|13003099007|11063799006|261021123027099003|261021121427099003|10067099003|261009223027099003|261009221227099003|261022105027099003|261021135927099003|56012099006|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	GqnyjiugY9/t4YbAtZJdHJHQ9MorVK6hlBVGQtgk6GFcXu0ffkxWcIVBPwVSF4u8LhOnssttTjDhIVhDkJkQ3B8j7yxx9rnO/vb9gbTMy5ziBnaI4IwpIWcQBXlG5RLbkOSCyj1rUmyE6MysEfFafmw7iRriBpo63Byk4qBjTzYJ/ek9lFHa9dlEiwCwJ3bWC/OWDh7FA7ypfO9TcF1wkpKNC956gC7P4czrXz7LmUMc/XBJuKx7UAVqVVsiEjupOFOML4w7VyomZ+KnSCVtLvFdmTHghVhlLc8qzZFeLsnu+I8PAXtwMcqPTvFI5G+NTyPjjMD85OLBi14KaDkt1Q7by70Cupmb8t1u5rWW7sQDcjwNe4Tx9N0RQoK5dtDKjlWxlcbWUtLnxfUXUYJLZ1irljz5dQi71+F9Bukr+59tI5kEthwCDlxLYYAIYVrgzeR3Bcr4HJcZzKkSxTgde5kHxKfGHousqE6A6qrhNH5dOtPqoefBlKjDQa7JsdeW8bH8x6ZDzO5+gg9h99bsORk2SEwKPNYKLlJ7vWXYGygd5t3Mo8m57dqt6JOBqG5z1ueOIQfZU4QVEn+3B/PrMh3RJjxLs1MRjc0Oef57D9TByEkbINVs4F8WkRzFLnpFM21gxijPrGWE/+d+5/8R8tuRbOg0DmtCd47fMIENdfGiw8vEjgViVp01OH2jVkqIH3QzlksKvCgfDvIWDuBr4Q==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(7416014)(376014)(22082099003)(18002099003)(3023799007)(13003099007)(11063799006)(261021123027099003)(261021121427099003)(10067099003)(261009223027099003)(261009221227099003)(261022105027099003)(261021135927099003)(56012099006)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EbDKsjXlWwujBBq/heUVCzz2FU/j+A5SJMRhYxxEc+gvbj9ML9WAq8hmWaRF8zayyJVTnOq4xFBV+u3rutUWHAKyQK5yxjN+Ju+3yxDNnbK0guSwSuPF7tYCvkTxz9YivAXWPYyKPuboygXtvFd689SmIog5ZuVruC9Pu5R9QRioRPv1fVYViVdeySTbAofusRhmwm8k5X1TOb6cDUk0sZ0wUkNP1dM0gps4sycIq2pTyWnPV5L0BWvMKMED+DcJPmNVCLIfaHqSDdkETkSVAszSbmXn+m/n1nV3Kp2nMasX+5FQ31jZF4KLy8q0glEEgmyDKFmBzfRsb644zl/dg2RVkp5nj2pH6RgZ9eOeO2PGtLgXUfOhBq4DvdhK589KOa+1gUWvkp3sBpmUCjlkSauC8oKSXq9Vz9B5m9exASPND9OiqD/n3KBnwCpqSPai
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 12:30:41.7928
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76c9f024-57a1-4b66-c466-08df310173d9
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000008F.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB6125

Extend the opt4001 driver to also support OPT4041. The devices are very
similar, with the difference being OPT4041 having two channels, one
visible and one wide band channel ranging from 380nm to 1000nm.

The register map is almost the same. OPT4001 has registers to read out
the last four values sampled. OPT4041 maps to the same registers, but
has two channels, saving the last two samples for each channel.

Datasheet: https://www.ti.com/lit/gpn/opt4041
Signed-off-by: Jesper X Nilsson <jesper.x.nilsson@axis.com>
---
 drivers/iio/light/Kconfig   |  6 +++--
 drivers/iio/light/opt4001.c | 66 ++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 66 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 462fff1ddef2..26c3fa057a38 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -503,12 +503,14 @@ config OPT3001
 	  opt3001.
 
 config OPT4001
-	tristate "Texas Instruments OPT4001 Light Sensor"
+	tristate "Texas Instruments OPT4001 and compatible Light Sensors"
 	depends on I2C
 	select REGMAP_I2C
 	help
 	  If you say Y or M here, you get support for Texas Instruments
-	  OPT4001 Ambient Light Sensor.
+	  Ambient Light Sensors:
+	  - OPT4001
+	  - OPT4041
 
 	  If built as a dynamically linked module, it will be called
 	  opt4001.
diff --git a/drivers/iio/light/opt4001.c b/drivers/iio/light/opt4001.c
index dc2eac8ad4af..5dcf9fe0aaad 100644
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
+ * Texas Instruments OPT4001 and compatible Light Sensors
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
 	struct s32_fract ratio;
@@ -99,6 +104,25 @@ static const struct iio_chan_spec opt4001_channels[] = {
 	},
 };
 
+static const struct iio_chan_spec opt4041_channels[] = {
+	{
+		.type = IIO_LIGHT,
+		.address = OPT4001_LIGHT1_MSB,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
+	},
+	{
+		.type = IIO_INTENSITY,
+		.modified = 1,
+		.channel2 = IIO_MOD_LIGHT_BOTH,
+		.address = OPT4041_LIGHT2_MSB,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
+	},
+};
+
 static const struct opt4001_chip_info opt4001_sot_5x3_info = {
 	.ratio = { .numerator = 4375, .denominator = 10000000 },
 	.name = "opt4001-sot-5x3",
@@ -115,6 +139,14 @@ static const struct opt4001_chip_info opt4001_picostar_info = {
 	.device_id = OPT4001_DEVICE_ID_VAL,
 };
 
+static const struct opt4001_chip_info opt4041_sot_5x3_info = {
+	.ratio = {.numerator = 5850, .denominator = 10000000 },
+	.name = "opt4041-sot-5x3",
+	.channels = opt4041_channels,
+	.num_channels = ARRAY_SIZE(opt4041_channels),
+	.device_id = OPT4041_DEVICE_ID_VAL,
+};
+
 static const int opt4001_int_time_available[][2] = {
 	{ 0,    600 },
 	{ 0,   1000 },
@@ -267,10 +299,30 @@ static int opt4001_read_raw(struct iio_dev *indio_dev,
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
@@ -337,6 +389,8 @@ static bool opt4001_readable_reg(struct device *dev, unsigned int reg)
 	switch (reg) {
 	case OPT4001_LIGHT1_MSB:
 	case OPT4001_LIGHT1_LSB:
+	case OPT4041_LIGHT2_MSB:
+	case OPT4041_LIGHT2_LSB:
 	case OPT4001_CTRL:
 	case OPT4001_DEVICE_ID:
 		return true;
@@ -360,6 +414,8 @@ static bool opt4001_volatile_reg(struct device *dev, unsigned int reg)
 	switch (reg) {
 	case OPT4001_LIGHT1_MSB:
 	case OPT4001_LIGHT1_LSB:
+	case OPT4041_LIGHT2_MSB:
+	case OPT4041_LIGHT2_LSB:
 		return true;
 	default:
 		return false;
@@ -447,6 +503,7 @@ static int opt4001_probe(struct i2c_client *client)
 static const struct i2c_device_id opt4001_id[] = {
 	{ .name = "opt4001-sot-5x3", .driver_data = (kernel_ulong_t)&opt4001_sot_5x3_info },
 	{ .name = "opt4001-picostar", .driver_data = (kernel_ulong_t)&opt4001_picostar_info },
+	{ .name = "opt4041-sot-5x3", .driver_data = (kernel_ulong_t)&opt4041_sot_5x3_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, opt4001_id);
@@ -454,6 +511,7 @@ MODULE_DEVICE_TABLE(i2c, opt4001_id);
 static const struct of_device_id opt4001_of_match[] = {
 	{ .compatible = "ti,opt4001-sot-5x3", .data = &opt4001_sot_5x3_info},
 	{ .compatible = "ti,opt4001-picostar", .data = &opt4001_picostar_info},
+	{ .compatible = "ti,opt4041-sot-5x3", .data = &opt4041_sot_5x3_info},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, opt4001_of_match);
@@ -469,5 +527,5 @@ static struct i2c_driver opt4001_driver = {
 module_i2c_driver(opt4001_driver);
 
 MODULE_AUTHOR("Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>");
-MODULE_DESCRIPTION("Texas Instruments opt4001 ambient light sensor driver");
+MODULE_DESCRIPTION("Texas Instruments OPT4001 and compatible Light Sensors");
 MODULE_LICENSE("GPL");

-- 
2.43.0

