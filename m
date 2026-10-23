Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.58
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792758646;
	b=PLk3rvuMzgCjF8iTBfPIxlOj/gl4e3LK7JWMu3PNEW3kHpgbEsLtxo+0F5Pr4T1ZjKxA
	 lJKFRhy+PuBURi3PS30+XHiakFmjW7BspDr6hE/gVgbUCb+a9nnPwkd0ad3G3wEKyGR/Y
	 4HCflHN35Q9AhtL4WcV/zcSfBRUKX05qUaEyIvslfhVdOjALCnOaK0kr18VGY/sOPiETh
	 70mZtsquZnF2FtsAIXvwyKIj2pvHXACB1UPyEr+Cwe39645i96hX9oe8Bv7FjJqmN9qpO
	 //fgyJPIvQx26ykUY5A70x1m9eM9DF3vbgImsRIikZesn7Su3qmYlyiAfnU6tEhlcKQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792758646;
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
	bh=Zo25eStzs74J9ckGz7hiZGLnSFfALpbfSYh+Gzne1F8=;
	b=lJwRVc7yp+wUot07kEnlIZZ6MkwC6BUuDGMJmaIuRqQirUiFUIEI1CxcasHvjREWOO6U
	 m08pGbNKA4umW72c+ff07++9Ndchz24ZdpkJkzpdMrFZmD5CwYnpU0r9CCHHbr/dAEqKD
	 4CGUIlIEyJY4FZ7fx38LHWIziNgo6fgPeZcPuUvwgps6x1GG8UMxVIui+6PVWEpqWUSPg
	 R0g4yhGFBCZZgdSCc+5fGuGDL9PLnaBgZvX0w8X61sNfd9AvmS4EncNw1DXQUw2Z8I902
	 Q4OrVfKUCcRwPIgmAZ/oRW3OEQQb5MBNbL2YpcEWtEha2YQ3gufGo9lddoAUN5bbSkw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=nJJk6dNN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.58
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013058.outbound.protection.outlook.com [40.107.162.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A919D606A32D;
	Fri, 23 Oct 2026 12:30:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A919D606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=nJJk6dNN
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bGMmYiqfvqAjJlxSJKG/0ZXLd5QEE/BcsFqWOQZcrrX3QIDVvO1FF4DC9YsAozJVrteWbG8FoR1dtVQL6GLBvVbLWtFuU9TYeabjeGwHEISP0c7PRm2vRYLDRtFK5L0b1wf+mRbv3d7B7BEHuCaI89zcM5TPcIo4acmU31K7a65yBzJ24i96glzj34mJPQI4eCTZncgf/9oSobuDxSyQMN7L4tCDq4MPuz0MtMFnUGqG+kJJppx9gIZKKc2GwMBjrxIrjoCimuX2m2Lmb6jfWhMrc97W7LAEfVTu466tCxVL4g6QkiGvz+PE+e5/zlRCUKwxXgnjgXPmnNyn14YQUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zo25eStzs74J9ckGz7hiZGLnSFfALpbfSYh+Gzne1F8=;
 b=JQgYwiNf1RAfLAIrJmQhpEgqIUUvjWeASgHc9zNxJg2mZeS7UV/XT0kObZhLGqm09Cd63KCrF7MuvOMYPAA5b1DgttPsBBB4XcKdQ8VA5cIFSyWVw4KqRTcZWbB4/EGs4ePCDF9U6u/R4hszqQZVaOGtd15DzCpc+Dp+vmIt5qh62Ninq3DucjjV24Elgt+THiguZtF+2EFAilov10WN1AtfLI+icedsFIkV1eQp76HN3qMgUCwYzWec1PFlChT77O2FEI2Wnni3yuuwAxNv9gxvr2MQD2IqFE3/6FLUOhZapBOU88pZHG8fKPc31gHm4gUDDaXVki4AdAmmlUQOWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=analog.com smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zo25eStzs74J9ckGz7hiZGLnSFfALpbfSYh+Gzne1F8=;
 b=nJJk6dNN+0ETyie0GsbF0iEyKB7arqP3Vi6Ur4Y378SYkN8gi7aaHDwnoBpbl40PvGU84B0Q0UFo/nEn0WCGRdFWIL32jVwQy4S1aYFTkj+H1USWsbF/odsbJHSwbQWY3zZ8qpw8HsMyd1uX8c4vRr+gloMFQgRC3KrlAOWwMWE=
Received: from PA7P264CA0251.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:371::19)
 by AM9PR02MB7282.eurprd02.prod.outlook.com (2603:10a6:20b:3ee::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 12:30:42 +0000
Received: from MI3PEPF00008555.eurprd05.prod.outlook.com
 (2603:10a6:102:371:cafe::ac) by PA7P264CA0251.outlook.office365.com
 (2603:10a6:102:371::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.19 via Frontend Transport; Fri,
 23 Oct 2026 12:30:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 MI3PEPF00008555.mail.protection.outlook.com (10.167.240.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Fri, 23 Oct 2026 12:30:40 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Fri, 23 Oct
 2026 14:30:37 +0200
Received: from se-mail10w.axis.com (10.20.40.10) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Fri, 23 Oct
 2026 14:30:37 +0200
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Fri, 23 Oct 2026 14:30:37 +0200
Received: from pc46036-2141.se.axis.com (pc46036-2141.se.axis.com [10.94.180.139])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id B07373BB6;
	Fri, 23 Oct 2026 14:30:37 +0200 (CEST)
Received: by pc46036-2141.se.axis.com (Postfix, from userid 16197)
	id AB235584AB8B; Fri, 23 Oct 2026 14:30:37 +0200 (CEST)
From: Jesper X Nilsson <jesper.x.nilsson@axis.com>
Date: Fri, 23 Oct 2026 14:30:30 +0200
Subject: [PATCH v2 3/4] iio: light: opt4001: refactor driver to prepare to
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
Message-ID: <20261023-opt4041-v2-3-ee320812804c@axis.com>
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
X-MS-TrafficTypeDiagnostic: MI3PEPF00008555:EE_|AM9PR02MB7282:EE_
X-MS-Office365-Filtering-Correlation-Id: 4df2c2c5-e045-41e4-0834-08df3101734d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|7416014|376014|1800799024|10067099003|18002099003|22082099003|13003099007|11063799006|56012099006|261022105027099003|261009223027099003|261021123027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	sF2tbSiSs9eqU12SVQP+N5fKcA8lIuqgNF2TAr80krfKyMxRTPIlmom8F0C1Ifm7eIu8+rC/HrKXefrgAv8e2gyYdFNc1KxOKRjqu7VsW9rNuPRfqYPpdMx6n1XJDyOMnxKsqS/PjEXaIDOFVrNX6a6Nate00/uXmiJpeKjfEK+XEX8c7Xt6UJQQZUMz9Z2kXHsyJzGsolXw8O8MsZoukYe+UQLWAgYUe7qXZbiJzcCbm64YeWvRSlsCjCa4oK8Zq0lnlnpmd08z5h7oRzw1AyoEFxnt+/7gKgzpuJAjvU6g1qt16cRGvvgZXcZmnxI6XtwTXpB/e3xC7ZY7YTf3XVayjAP0PN26WkXmldnO99hn9C6hOldbC53PFXT1jXopjwjQrCGvEWHsIbLNqYgpGH1jhWuSIw0sTpG8eF7BOl+wFDLkrz7ITwmhb4NigJj3Em6At+DTkY5rdyUH7FsY+V+Z21TbX9XOJZ90uSP+TasQeN5+YADHLlgmshyxGYOswdBwmCNRNhA8ehQnIxAEiD50K1LIIjNmtRmKdIXauXPdDq3KPJ8N3WFp+EtEoBoMJKgv2RmKTH0sfs/fG35Onu+yjQJTmAt9WGF/dwf70W6ZIazTZDXi4c0z6eOF/V7AzH649P3+V222aFWFArn8odRQCcoSt+0hzZT0MivT4PJWDFu9VaJzjPohfPKA5XhpB+WEsm9xoSh2FZiZoMVNoA==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(7416014)(376014)(1800799024)(10067099003)(18002099003)(22082099003)(13003099007)(11063799006)(56012099006)(261022105027099003)(261009223027099003)(261021123027099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	i+235GLwN05KyIAUpNdUSqQUEAEFHBOb1/ry613B1dXMIZl64YNUqdF/ASU28NBVZOQpTNxuYwDErJReGkz5EqGZeFnvIGSjeXrXifn7eCawV3dDCVQ6t8DBSX6nj1Wr3+dTasdhrB31LUfv5VN/tX6JMdcw1vn7xXjISXBslqL5gSPQcEQoIhcfRMbavh0JxVtehBJGAH8uwWCXT+f1As0u8Gz0QWrdtVRpryA8KxPPzb1NP3z9UEzyULB+HkRIkXe9ULx6KxJJyEHc2aUTxkP5p/hGx8HKNyP0FNUFZzFGqLU0MKfTUPcXZ506eqLegb84WBDIlkHiC1sk4Ic7a1ADE59TG92vobwQDNB+JjBATL4FJwN6AxXZZUDcTpDtDKdnZNy6Tdi9govnPt9GQw6sFBZ21P/ur6smckXOihMJzK4kVnoearBjlmiuAZ2h
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 12:30:40.8361
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df2c2c5-e045-41e4-0834-08df3101734d
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF00008555.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB7282

Prepare opt4001 driver to be able to support OPT4041. Extend struct
opt4001_chip_info with fields channels and device_id because OPT4041 has
two channels and another device id.

Datasheet: https://www.ti.com/lit/gpn/opt4041
Signed-off-by: Jesper X Nilsson <jesper.x.nilsson@axis.com>
---
 drivers/iio/light/opt4001.c | 85 +++++++++++++++++++++++++++++----------------
 1 file changed, 55 insertions(+), 30 deletions(-)

diff --git a/drivers/iio/light/opt4001.c b/drivers/iio/light/opt4001.c
index dcde10914a1e..dc2eac8ad4af 100644
--- a/drivers/iio/light/opt4001.c
+++ b/drivers/iio/light/opt4001.c
@@ -77,6 +77,9 @@
 struct opt4001_chip_info {
 	struct s32_fract ratio;
 	const char *name;
+	const struct iio_chan_spec *channels;
+	int num_channels;
+	u16 device_id;
 };
 
 struct opt4001_chip {
@@ -86,14 +89,30 @@ struct opt4001_chip {
 	const struct opt4001_chip_info *chip_info;
 };
 
+static const struct iio_chan_spec opt4001_channels[] = {
+	{
+		.type = IIO_LIGHT,
+		.address = OPT4001_LIGHT1_MSB,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
+	},
+};
+
 static const struct opt4001_chip_info opt4001_sot_5x3_info = {
 	.ratio = { .numerator = 4375, .denominator = 10000000 },
-	.name = "opt4001-sot-5x3"
+	.name = "opt4001-sot-5x3",
+	.channels = opt4001_channels,
+	.num_channels = ARRAY_SIZE(opt4001_channels),
+	.device_id = OPT4001_DEVICE_ID_VAL,
 };
 
 static const struct opt4001_chip_info opt4001_picostar_info = {
 	.ratio = { .numerator = 3125, .denominator = 10000000 },
-	.name = "opt4001-picostar"
+	.name = "opt4001-picostar",
+	.channels = opt4001_channels,
+	.num_channels = ARRAY_SIZE(opt4001_channels),
+	.device_id = OPT4001_DEVICE_ID_VAL,
 };
 
 static const int opt4001_int_time_available[][2] = {
@@ -156,30 +175,28 @@ static u8 opt4001_calculate_crc(u8 exp, u32 mantissa, u8 count)
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
+	u32 mantissa;
+	u8 calc_crc;
+	u8 count;
 	u16 msb;
 	u16 lsb;
+	int ret;
 	u8 exp;
-	u8 count;
 	u8 crc;
-	u8 calc_crc;
-	u64 lux_raw;
-	u32 rem;
-	int ret;
 
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
@@ -190,12 +207,27 @@ static int opt4001_read_lux_value(struct iio_dev *indio_dev,
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
 	lux_raw = lux_raw * chip->chip_info->ratio.numerator;
 	*val = div_u64_rem(lux_raw, chip->chip_info->ratio.denominator, &rem);
 	*val2 = rem * 100;
@@ -230,15 +262,6 @@ static void opt4001_chip_off_action(void *data)
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
@@ -247,7 +270,7 @@ static int opt4001_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_PROCESSED:
-		return opt4001_read_lux_value(indio_dev, val, val2);
+		return opt4001_read_lux_value(chip, chan->address, val, val2);
 	case IIO_CHAN_INFO_INT_TIME:
 		*val = 0;
 		*val2 = opt4001_int_time_reg[chip->int_time][0];
@@ -385,19 +408,21 @@ static int opt4001_probe(struct i2c_client *client)
 		return dev_err_probe(&client->dev, ret,
 				     "failed to reinit regmap cache\n");
 
+	chip->chip_info = i2c_get_match_data(client);
+	if (!chip->chip_info)
+		return -ENODATA;
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

