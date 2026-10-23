Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.56
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792741739;
	b=R1AqWgvOjxIasQ4F3ZE/WG83zzsjg5vE2HKBpze87BkPuVkrAjk4qkytIch60e71Yf4U
	 bdfo4Wp6xwxvmnc+rbW7yLNwj6eBGJcqiRIH+PgUckBPh/LWgveo9CcRCaPCH/OCHHyQA
	 arrSzWOq2XRgu7XAcEtgyTAwmbupFa+bPWexXqYM6f3VTrl+sn6XbUnlSbhxJKXQzmwze
	 iIzzdHSSlLIaXCl+2+Dvv06CdvKZHqB4xkM7uIAufW+MWscyB/aH1Rvqaw5hipfxJ6o9q
	 nXzdRLdbCOPKHoj7fK+hHErK1IhSf3CCqC2912/nyayu36A7I0FDQqMdxtXn3jBBgKg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792741739;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:Received:From:Date:Subject:MIME-Version:
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
	bh=iB9QfVN3xMXcmrRMG4z8ItvbLPagm6YL6c2H0qHJyLw=;
	b=4LpEg+6VWsexlfbKC3UNr9v/klNBqGpZgmxEYHUYicjRqTXJ19C/qrnded0gcdRFdKGP
	 9N9EQa1abta0bWAXdPHjaHqSiS5ySoPLC+UrY6NoylJCSpsKh69U48O9zrK1JBxct3gtd
	 t/XJWWHaZ4+nb4SQSmtEsWrp1Y9XiiSAyv0MF2cpgcoC8LV9itp4OcTXT89MTVsI6wb71
	 Rt3usDxc2qMd9hvVd5C4+NDO+ARjpxsbHSo7U9OtwdAdOsRrr9So9k2kAiPwLbRZl7loB
	 TLaea1CdUFwkqEHyUp2v3hUwuGpBnq5er45YOY5YFzSlYeRtjK2AVPpf8Md3qGlBZSA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=XPVKAxH1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.56
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010056.outbound.protection.outlook.com [52.101.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C457C60A261E;
	Fri, 23 Oct 2026 07:48:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C457C60A261E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=XPVKAxH1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Saa902aeierhQkm9RFNF9b1jsHgh2l5HP4ql9OTdijQCvr5aGLxWrfsh5+ofnAB7SbCYFPxv7UoAcG+7uoZj5lBP4cQG5F9fEE4LKNyW5kKR71RzWMKcZlEUP/uTXP8jAulxAfAG09S/jD1ooLIcJ0NjLatJFpyz5JqWqAC4ll3/hUDN2AcQxy0/lmSWGvR/C7ZJqZGISCLhpzMf3KlZtNgRkdUgCagxYL0m+f8/8bWZ6gJvFq3D8naX0iGkJ6J2VWaWRF1mrcL4nzwGfAJSysQOeQpQFdaxQD5W43xR70MIvN+TjhJO2Bg14t4RJYiQqADXnMHASS6yBjNhhtsbVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iB9QfVN3xMXcmrRMG4z8ItvbLPagm6YL6c2H0qHJyLw=;
 b=qSDHtvNltDY2VLOjBFIrEqiSzreY+hBINNCnrBA7olYGm3hcf9qLbaymRqD0RLbBef/nyFT0ZIblhbGcydG5bVpvJgb1FsiZlieSpEJOYecc3okcjzvePI2M4yLaJF8FAc0LSYH/ltbnUqInZ5YdpmJKeM7NjmhYP+2kdN2i6drevv3QIyzS1H18Wn311t6NClY7wQtoCR831ZtPinZ5ldood1gS4iubnVKqJqedIjtlAEsKK/8PeYluFMvH7PWBsWdmeLZN1oJU0xH0+pNc/0KSYAqGVVP9JbS6OboMs4WpyDiGTN5DieaMZJcxigogewDaDTkGGPoUk3gieFWdhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iB9QfVN3xMXcmrRMG4z8ItvbLPagm6YL6c2H0qHJyLw=;
 b=XPVKAxH1gVA8mmJM30eP6Ju/thdIBwkXKXU5UsNCR2oj6q/SqxGqoUoeU1OFKfLNlw8luiCXOzN/WTGBaKHGcOhaBZ07gaU/a/fdZemAjfEi42g5wagAJvsfNwW8ayZyZ9CDwC1Q+QZTrnPDWdUUZZifLeq1+XxTQcWCCOTtuSE=
Received: from DUZPR01CA0037.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::15) by PA4PR02MB7087.eurprd02.prod.outlook.com
 (2603:10a6:102:10c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 07:48:52 +0000
Received: from DB1PEPF000509F1.eurprd03.prod.outlook.com
 (2603:10a6:10:468:cafe::7d) by DUZPR01CA0037.outlook.office365.com
 (2603:10a6:10:468::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.19 via Frontend Transport; Fri,
 23 Oct 2026 07:48:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509F1.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Fri, 23 Oct 2026 07:48:52 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Fri, 23 Oct
 2026 09:48:48 +0200
Received: from se-mail10w.axis.com (10.20.40.10) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Fri, 23 Oct
 2026 09:48:48 +0200
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Fri, 23 Oct 2026 09:48:48 +0200
Received: from pc46036-2141.se.axis.com (pc46036-2141.se.axis.com [10.94.180.139])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 153702B99;
	Fri, 23 Oct 2026 09:48:48 +0200 (CEST)
Received: by pc46036-2141.se.axis.com (Postfix, from userid 16197)
	id 107B2584AB8A; Fri, 23 Oct 2026 09:48:48 +0200 (CEST)
From: Jesper X Nilsson <jesper.x.nilsson@axis.com>
Date: Fri, 23 Oct 2026 09:48:14 +0200
Subject: [PATCH 2/3] iio: light: opt4001: refactor driver to prepare to
 support more devices
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
Message-ID: <20261023-opt4041-v1-2-45227f82d05c@axis.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F1:EE_|PA4PR02MB7087:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bcfb5e3-d48a-4f1e-3a4f-08df30da1512
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|1800799024|36860700016|82310400026|261021123027099003|261022105027099003|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003|261021121427099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	Gub23do+uay9WogQOALqnHTZk3E9a7cQnB5cCx6FXjpKpT2SOdkxRjatoNitAHQSDjURjkYLS6987r8r6Je6EM9w8g2lmGABeZDHHjq6PziJ/29N48KzISypgYfdWYg8vu1mSnhShuaZqFbBlqfA0m9O4tMeFFUniOAyDr7IT56EZCcWZcq2XlA1V7cJvkCDIK0HUErAXBqMCCp2S10aqVbLtoYHrivmWCTpbHgvcl6260fTAq3uZGuX9J+eCB19dRJ5Vw4VksJYBsmvXVxDzkpzd761zb/qmVcF8B3EuVXsFKnzUPOruNStWQev6wvvG55nqTqjrDKPYWyZdMekwbWal57fNTJ+hk3w6Jz+VUK4S3zvFFQO1wyqO/xyEtybQ7WXzDaugwo/dC2Y9xwGUF+yeaa9IeMM6vsVVJy9MbOPDMYbG0QS4xZzEEknp375fVh4DGHYMjlCHb4yOrGAV31sKGT3UavaXF44ya//Ma9WgMVeTiCmsZuPDZRKBYeEbHfQ6oUGvTSC/Br6xuYgEGOF36jCNeFsBmGf9XyUuMZQ+MzGEU/ZjuArNEybEY3Q8PR9mNYlwP/gb+YwpX2ZlZ5OdmNndvMpYHlqYtpvcqO1o8aLXJ2vgNAhTodNz34zshWhl6tloj8qdRR9hxx3BS1IeWPKzHbVgft1ev0+OdEWuvHDTuVtW8AY9rhKZ91jhDr4HvOjbtqyN7J4wh1PgQ==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(261021123027099003)(261022105027099003)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(261021121427099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MBNzSoBOsqWzrZ3xhadHSYFdh2tMUFgleKtN/nN8MQ2a4KAGnjNoBm+vqgBWkyp63rvfbkZ646kTR0WvMnkGdMkRnZTCEhaXzUTTg8LX8Cs90sDvVFL84iMhVkRI89PxdWDEYRBph5JpsM8cmLR4aqZu1Dral+18sPdhmOHz6Ibmg6aLOCNy4MjXRUVk9NkvJ+LMzO36MfrnAAAhil5NraE4mMAGHCMWj/MVIXy6EGrSGHHo39OpHNZaVMPfVguQWr02thVlqrxUNkgYBh/pG6HMycrQ51f9JKgUlAzi14uH+hpwKnMI5xdI5kYgeVQQXC/cSSN/9wwl6JdEHbRm0g4xcXVbmTov4SOH+xIIR8ehGJ2GRujQ4PRpSgy9lZr2HhkkEprjHvUQ1l91BZB3fN8fiE9EfETQwlNeD7cu62gFFQgBCjhrWRgG34w3Kn0D
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 07:48:52.3930
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bcfb5e3-d48a-4f1e-3a4f-08df30da1512
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F1.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR02MB7087

Prepare opt4001 driver to be able to support OPT4041. Extend struct
opt4001_chip_info with fields channels and device_id because OPT4041 has
two channels and another device id.

Datasheet: https://www.ti.com/lit/gpn/opt4041
Assisted-by: LLM
Signed-off-by: Jesper X Nilsson <jesper.x.nilsson@axis.com>
---
 drivers/iio/light/opt4001.c | 77 +++++++++++++++++++++++++++++----------------
 1 file changed, 50 insertions(+), 27 deletions(-)

diff --git a/drivers/iio/light/opt4001.c b/drivers/iio/light/opt4001.c
index aa3d87995b7c..bf5dc1c8514c 100644
--- a/drivers/iio/light/opt4001.c
+++ b/drivers/iio/light/opt4001.c
@@ -78,6 +78,9 @@ struct opt4001_chip_info {
 	int mul;
 	int div;
 	const char *name;
+	const struct iio_chan_spec *channels;
+	int num_channels;
+	u16 device_id;
 };
 
 struct opt4001_chip {
@@ -87,16 +90,32 @@ struct opt4001_chip {
 	const struct opt4001_chip_info *chip_info;
 };
 
+static const struct iio_chan_spec opt4001_channels[] = {
+	{
+		.type = IIO_LIGHT,
+		.address = OPT4001_LIGHT1_MSB,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME)
+	},
+};
+
 static const struct opt4001_chip_info opt4001_sot_5x3_info = {
 	.mul = 4375,
 	.div = 10000000,
-	.name = "opt4001-sot-5x3"
+	.name = "opt4001-sot-5x3",
+	.channels = opt4001_channels,
+	.num_channels = ARRAY_SIZE(opt4001_channels),
+	.device_id = OPT4001_DEVICE_ID_VAL,
 };
 
 static const struct opt4001_chip_info opt4001_picostar_info = {
 	.mul = 3125,
 	.div = 10000000,
-	.name = "opt4001-picostar"
+	.name = "opt4001-picostar",
+	.channels = opt4001_channels,
+	.num_channels = ARRAY_SIZE(opt4001_channels),
+	.device_id = OPT4001_DEVICE_ID_VAL,
 };
 
 static const int opt4001_int_time_available[][2] = {
@@ -159,10 +178,9 @@ static u8 opt4001_calculate_crc(u8 exp, u32 mantissa, u8 count)
 	return crc;
 }
 
-static int opt4001_read_lux_value(struct iio_dev *indio_dev,
-				  int *val, int *val2)
+static int opt4001_read_raw_value(struct opt4001_chip *chip, unsigned int reg,
+				  u64 *raw_value)
 {
-	struct opt4001_chip *chip = iio_priv(indio_dev);
 	struct device *dev = &chip->client->dev;
 	unsigned int light1;
 	unsigned int light2;
@@ -172,17 +190,16 @@ static int opt4001_read_lux_value(struct iio_dev *indio_dev,
 	u8 count;
 	u8 crc;
 	u8 calc_crc;
-	u64 lux_raw;
-	u32 rem;
+	u32 mantissa;
 	int ret;
 
-	ret = regmap_read(chip->regmap, OPT4001_LIGHT1_MSB, &light1);
+	ret = regmap_read(chip->regmap, reg, &light1);
 	if (ret < 0) {
 		dev_err(dev, "Failed to read data bytes");
 		return ret;
 	}
 
-	ret = regmap_read(chip->regmap, OPT4001_LIGHT1_LSB, &light2);
+	ret = regmap_read(chip->regmap, reg + 1, &light2);
 	if (ret < 0) {
 		dev_err(dev, "Failed to read data bytes");
 		return ret;
@@ -193,12 +210,27 @@ static int opt4001_read_lux_value(struct iio_dev *indio_dev,
 	crc = FIELD_GET(OPT4001_CRC_MASK, light2);
 	msb = FIELD_GET(OPT4001_MSB_MASK, light1);
 	lsb = FIELD_GET(OPT4001_LSB_MASK, light2);
-	lux_raw = (msb << 8) + lsb;
-	calc_crc = opt4001_calculate_crc(exp, lux_raw, count);
+	mantissa = (msb << 8) + lsb;
+	calc_crc = opt4001_calculate_crc(exp, mantissa, count);
 	if (calc_crc != crc)
 		return -EIO;
 
-	lux_raw = lux_raw << exp;
+	*raw_value = (u64)mantissa << exp;
+
+	return 0;
+}
+
+static int opt4001_read_lux_value(struct opt4001_chip *chip, unsigned int reg,
+				  int *val, int *val2)
+{
+	u64 lux_raw;
+	u32 rem;
+	int ret;
+
+	ret = opt4001_read_raw_value(chip, reg, &lux_raw);
+	if (ret)
+		return ret;
+
 	lux_raw = lux_raw * chip->chip_info->mul;
 	*val = div_u64_rem(lux_raw, chip->chip_info->div, &rem);
 	*val2 = rem * 100;
@@ -233,15 +265,6 @@ static void opt4001_chip_off_action(void *data)
 		dev_err(&chip->client->dev, "Failed to power down\n");
 }
 
-static const struct iio_chan_spec opt4001_channels[] = {
-	{
-		.type = IIO_LIGHT,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
-		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME),
-		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME)
-	},
-};
-
 static int opt4001_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int *val, int *val2, long mask)
@@ -250,7 +273,7 @@ static int opt4001_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_PROCESSED:
-		return opt4001_read_lux_value(indio_dev, val, val2);
+		return opt4001_read_lux_value(chip, chan->address, val, val2);
 	case IIO_CHAN_INFO_INT_TIME:
 		*val = 0;
 		*val2 = opt4001_int_time_reg[chip->int_time][0];
@@ -388,19 +411,19 @@ static int opt4001_probe(struct i2c_client *client)
 		return dev_err_probe(&client->dev, ret,
 				     "failed to reinit regmap cache\n");
 
+	chip->chip_info = i2c_get_match_data(client);
+
 	ret = regmap_read(chip->regmap, OPT4001_DEVICE_ID, &dev_id);
 	if (ret < 0)
 		return dev_err_probe(&client->dev, ret,
 			"Failed to read the device ID register\n");
 
 	dev_id = FIELD_GET(OPT4001_DEVICE_ID_MASK, dev_id);
-	if (dev_id != OPT4001_DEVICE_ID_VAL)
+	if (dev_id != chip->chip_info->device_id)
 		dev_warn(&client->dev, "Device ID: %#04x unknown\n", dev_id);
 
-	chip->chip_info = i2c_get_match_data(client);
-
-	indio_dev->channels = opt4001_channels;
-	indio_dev->num_channels = ARRAY_SIZE(opt4001_channels);
+	indio_dev->channels = chip->chip_info->channels;
+	indio_dev->num_channels = chip->chip_info->num_channels;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->name = chip->chip_info->name;
 

-- 
2.43.0

