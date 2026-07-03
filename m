Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF00C3B8105;
	Fri,  3 Jul 2026 10:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783073461; cv=none; b=FM+bPFT3isQ2hifoHn83xzxxdTYDNROy9aDEhBD8p2LcbCF9CNXPIrKczMJRRH8afLYHpjoNggQ211zLJDUiT9yFZHp4Kdqc7NxRAPvTXA0foElLFFhQkGgJNKKKPA2rOmx/MnjotcgbqM1TLT/Jdb7AWgscJdFtrYtFrfifLqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783073461; c=relaxed/simple;
	bh=8PNToYG1ADn8PmGsS18wzloDlmZ9culDK2SSjrP8zqY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ZaVokiAz5TGDY2XO+C8lWyWlh789ZgQO8G+Oi8qn6+Nyv2gtYX8s2rPCEazNBlKXkuMImsbXucnFHa/XGWH0WLQnWkm6auoA1HT00A/YGLxOD2nak1PawM6v1GNWToGc9zrz0IoeLdAEEHRIkna2qzt+qZXb5e/E7TKyniOqRLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=IejTSy37; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="IejTSy37"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6635vsKD310210;
	Fri, 3 Jul 2026 06:10:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=UvQnw
	QXWvCcyPBpdl2AOvNE1e5eY1yMSBLGxvcnlJZY=; b=IejTSy37EDpgy6q1iYu0S
	/Ld2gg65SMX6puIGUy8RiDuZEbbB6oBWifasR8SL+hcdA6/NcXQYvUJW+kby+wUZ
	W8ku3fCOhx24ICtjkyZb+uKPxwXFUcJK280/e9OLqSFP1/34TbpC+NAlSoQfl6yC
	XJ70ZvXRa2NqKU4cjNEkUUX+6+9W2soFdMmDsw649hhkuvGmaEtNIDU5CrOaj6cs
	bHgHdCTh3MeEny6m0t2255pg3vWJFM4boT7OMUCRINwkJF5m/BjQUgDNp3U8q4Vp
	xhz4kPoG1Xngpg9m6W9rrxPNqW6H10D4klMZs+jGjIDhX1UngJ9h61ps168B3Y8x
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4f658j1ebf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 06:10:55 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 663AAsNZ011024
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 3 Jul 2026 06:10:54 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 3 Jul 2026 06:10:54 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 3 Jul 2026 06:10:54 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 3 Jul 2026 06:10:54 -0400
Received: from analog.ad.analog.com ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 663AAOlI024695;
	Fri, 3 Jul 2026 06:10:46 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Date: Fri, 3 Jul 2026 18:10:09 +0800
Subject: [PATCH v4 4/6] iio: dac: ad3530r: Refactor setup to table-driven
 register banks
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260703-iio-ad3532r-support-v4-4-69d9a336f4e8@analog.com>
References: <20260703-iio-ad3532r-support-v4-0-69d9a336f4e8@analog.com>
In-Reply-To: <20260703-iio-ad3532r-support-v4-0-69d9a336f4e8@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        "Andy
 Shevchenko" <andy@kernel.org>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux@analog.com>, <devicetree@vger.kernel.org>,
        Kim Seer Paller
	<kimseer.paller@analog.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783073424; l=7298;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=8PNToYG1ADn8PmGsS18wzloDlmZ9culDK2SSjrP8zqY=;
 b=ikssSYGWBzY32Gs0DToVWEqzb7DYNDQQ7QQZgSbRzndW5PuLLOWDrPjPbWRyWyhtxVBeACGTx
 BiVVL5kaHjWB5HID30Hc4kZjq6jatZEwRxjJo88mTq8+JkZXOgSE1lg
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=eMsjSnp1 c=1 sm=1 tr=0 ts=6a478aaf cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8
 a=TcFXJb9OEyUhNPaJW6YA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: YziUr9NTvIOUnnA-OnxsqY21u8soTn3x
X-Proofpoint-ORIG-GUID: YziUr9NTvIOUnnA-OnxsqY21u8soTn3x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA5OCBTYWx0ZWRfX9WSj5I1iqcrQ
 P7sgRNPFJFvo+0lIYQ/skRj9wcaBPsXggv1hPpz3B6Axu6KErFdWoA12VwhneSVC0wvvHRmMrSM
 OQtSUjAHcxEgmWmXKaAgQ22DdSu6sP7piffGw/uYuLDXX15Xh+EisRVMqJctIBqJNfQIlTCDeF5
 Q/4j4b/lBk5UM0nlPUNA1h9jAXrXFf1nffvykQtM01QmPtRAnyQVRwWRa/JeE2MWmGefl94tTpn
 mXPZWm7GB+T9vLaugTqqFUFWAjY4xZxZKE+GQZZwWgRVWtCD6N5x0vXqPRwhL99Wh+6fvXHWy6a
 AsT+5Ersyi/7SM7RXJzOuKlPjvl9AgjzZ2s4Uf1qFizGLUTLRFchyNwsuO0NpknH5YH2fBmxt3l
 8lZSLD7l1vd/D14QQiWk+273qBXyy1879JFYaJwhHdHUWddP1cLqfqYdEGF1SuGfGM2A7ZZ0Lw4
 dM1avO3/BfvFZXomKGg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA5OCBTYWx0ZWRfX/IIlYPK/Dfi6
 k0OLg6+NPHCGIK3AQSbYrkXZIEMDjjxK5guOI2NaFLOlhm1NfQxyBj/BAcKt4CdJ2cHKBKAwMAt
 ZOUxAb7yNNlQ1xY7JFeHv+gLrihQaJPu1+jo/Wmft1i7o0nxrH2S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030098

Devices with a multi-bank register map repeat the same configuration
across several banks, which the hardcoded register addresses in
ad3530r_setup() cannot cover.

Move the addresses into per-chip arrays and add ad3530r_set_reg_bank_bits()
and ad3530r_write_reg_banks() to apply an operation to every bank. Each
current device has a single bank, so no functional change.

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 drivers/iio/dac/ad3530r.c | 113 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 97 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/dac/ad3530r.c b/drivers/iio/dac/ad3530r.c
index 7841546f0c07..42e77b150760 100644
--- a/drivers/iio/dac/ad3530r.c
+++ b/drivers/iio/dac/ad3530r.c
@@ -70,7 +70,13 @@ struct ad3530r_chip_info {
 	const struct iio_chan_spec *channels;
 	int (*input_ch_reg)(unsigned int channel);
 	int (*sw_ldac_trig_reg)(unsigned int channel);
+	const unsigned int *interface_config_a;
+	const unsigned int *output_control;
+	const unsigned int *reference_control;
+	const unsigned int *op_mode;
 	unsigned int num_channels;
+	unsigned int num_banks;
+	unsigned int num_op_mode_regs;
 	bool internal_ref_support;
 };
 
@@ -341,12 +347,39 @@ static const struct iio_chan_spec ad3531r_channels[] = {
 	AD3530R_CHAN(3, ad3531r_ext_info),
 };
 
+static const unsigned int ad3530r_if_config[] = {
+	AD3530R_INTERFACE_CONFIG_A,
+};
+
+static const unsigned int ad3530r_out_ctrl[] = {
+	AD3530R_OUTPUT_CONTROL_0,
+};
+
+static const unsigned int ad3530r_ref_ctrl[] = {
+	AD3530R_REFERENCE_CONTROL_0,
+};
+
+static const unsigned int ad3530r_op_mode[] = {
+	AD3530R_OUTPUT_OPERATING_MODE_0,
+	AD3530R_OUTPUT_OPERATING_MODE_1,
+};
+
+static const unsigned int ad3531r_op_mode[] = {
+	AD3530R_OUTPUT_OPERATING_MODE_0,
+};
+
 static const struct ad3530r_chip_info ad3530_chip = {
 	.name = "ad3530",
 	.channels = ad3530r_channels,
 	.num_channels = ARRAY_SIZE(ad3530r_channels),
 	.sw_ldac_trig_reg = ad3530r_trigger_sw_ldac_reg,
 	.input_ch_reg = ad3530r_input_ch_reg,
+	.interface_config_a = ad3530r_if_config,
+	.output_control = ad3530r_out_ctrl,
+	.reference_control = ad3530r_ref_ctrl,
+	.op_mode = ad3530r_op_mode,
+	.num_banks = ARRAY_SIZE(ad3530r_if_config),
+	.num_op_mode_regs = ARRAY_SIZE(ad3530r_op_mode),
 	.internal_ref_support = false,
 };
 
@@ -356,6 +389,12 @@ static const struct ad3530r_chip_info ad3530r_chip = {
 	.num_channels = ARRAY_SIZE(ad3530r_channels),
 	.sw_ldac_trig_reg = ad3530r_trigger_sw_ldac_reg,
 	.input_ch_reg = ad3530r_input_ch_reg,
+	.interface_config_a = ad3530r_if_config,
+	.output_control = ad3530r_out_ctrl,
+	.reference_control = ad3530r_ref_ctrl,
+	.op_mode = ad3530r_op_mode,
+	.num_banks = ARRAY_SIZE(ad3530r_if_config),
+	.num_op_mode_regs = ARRAY_SIZE(ad3530r_op_mode),
 	.internal_ref_support = true,
 };
 
@@ -365,6 +404,12 @@ static const struct ad3530r_chip_info ad3531_chip = {
 	.num_channels = ARRAY_SIZE(ad3531r_channels),
 	.sw_ldac_trig_reg = ad3531r_trigger_sw_ldac_reg,
 	.input_ch_reg = ad3531r_input_ch_reg,
+	.interface_config_a = ad3530r_if_config,
+	.output_control = ad3530r_out_ctrl,
+	.reference_control = ad3530r_ref_ctrl,
+	.op_mode = ad3531r_op_mode,
+	.num_banks = ARRAY_SIZE(ad3530r_if_config),
+	.num_op_mode_regs = ARRAY_SIZE(ad3531r_op_mode),
 	.internal_ref_support = false,
 };
 
@@ -374,15 +419,54 @@ static const struct ad3530r_chip_info ad3531r_chip = {
 	.num_channels = ARRAY_SIZE(ad3531r_channels),
 	.sw_ldac_trig_reg = ad3531r_trigger_sw_ldac_reg,
 	.input_ch_reg = ad3531r_input_ch_reg,
+	.interface_config_a = ad3530r_if_config,
+	.output_control = ad3530r_out_ctrl,
+	.reference_control = ad3530r_ref_ctrl,
+	.op_mode = ad3531r_op_mode,
+	.num_banks = ARRAY_SIZE(ad3530r_if_config),
+	.num_op_mode_regs = ARRAY_SIZE(ad3531r_op_mode),
 	.internal_ref_support = true,
 };
 
+static int ad3530r_set_reg_bank_bits(const struct ad3530r_state *st,
+				     const unsigned int *regs,
+				     unsigned int num_regs,
+				     unsigned int mask)
+{
+	int ret;
+
+	for (unsigned int i = 0; i < num_regs; i++) {
+		ret = regmap_set_bits(st->regmap, regs[i], mask);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int ad3530r_write_reg_banks(const struct ad3530r_state *st,
+				   const unsigned int *regs,
+				   unsigned int num_regs,
+				   unsigned int val)
+{
+	int ret;
+
+	for (unsigned int i = 0; i < num_regs; i++) {
+		ret = regmap_write(st->regmap, regs[i], val);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int ad3530r_setup(struct ad3530r_state *st, int external_vref_uV)
 {
+	const struct ad3530r_chip_info *chip_info = st->chip_info;
 	struct device *dev = regmap_get_device(st->regmap);
 	struct gpio_desc *reset_gpio;
-	int i, ret;
 	u8 range_multiplier, val;
+	int ret;
 
 	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(reset_gpio))
@@ -395,8 +479,9 @@ static int ad3530r_setup(struct ad3530r_state *st, int external_vref_uV)
 		gpiod_set_value_cansleep(reset_gpio, 0);
 	} else {
 		/* Perform software reset */
-		ret = regmap_update_bits(st->regmap, AD3530R_INTERFACE_CONFIG_A,
-					 AD3530R_SW_RESET, AD3530R_SW_RESET);
+		ret = ad3530r_set_reg_bank_bits(st, chip_info->interface_config_a,
+						chip_info->num_banks,
+						AD3530R_SW_RESET);
 		if (ret)
 			return ret;
 	}
@@ -405,8 +490,9 @@ static int ad3530r_setup(struct ad3530r_state *st, int external_vref_uV)
 
 	range_multiplier = 1;
 	if (device_property_read_bool(dev, "adi,range-double")) {
-		ret = regmap_set_bits(st->regmap, AD3530R_OUTPUT_CONTROL_0,
-				      AD3530R_OUTPUT_CONTROL_RANGE);
+		ret = ad3530r_set_reg_bank_bits(st, chip_info->output_control,
+						chip_info->num_banks,
+						AD3530R_OUTPUT_CONTROL_RANGE);
 		if (ret)
 			return ret;
 
@@ -416,8 +502,9 @@ static int ad3530r_setup(struct ad3530r_state *st, int external_vref_uV)
 	if (external_vref_uV) {
 		st->vref_mV = range_multiplier * external_vref_uV / MILLI;
 	} else {
-		ret = regmap_set_bits(st->regmap, AD3530R_REFERENCE_CONTROL_0,
-				      AD3530R_REFERENCE_CONTROL_SEL);
+		ret = ad3530r_set_reg_bank_bits(st, chip_info->reference_control,
+						chip_info->num_banks,
+						AD3530R_REFERENCE_CONTROL_SEL);
 		if (ret)
 			return ret;
 
@@ -430,18 +517,12 @@ static int ad3530r_setup(struct ad3530r_state *st, int external_vref_uV)
 	      FIELD_PREP(AD3530R_OP_MODE_CHAN_MSK(2), AD3530R_NORMAL_OP) |
 	      FIELD_PREP(AD3530R_OP_MODE_CHAN_MSK(3), AD3530R_NORMAL_OP);
 
-	ret = regmap_write(st->regmap, AD3530R_OUTPUT_OPERATING_MODE_0, val);
+	ret = ad3530r_write_reg_banks(st, st->chip_info->op_mode,
+				      st->chip_info->num_op_mode_regs, val);
 	if (ret)
 		return ret;
 
-	if (st->chip_info->num_channels > 4) {
-		ret = regmap_write(st->regmap, AD3530R_OUTPUT_OPERATING_MODE_1,
-				   val);
-		if (ret)
-			return ret;
-	}
-
-	for (i = 0; i < st->chip_info->num_channels; i++)
+	for (unsigned int i = 0; i < st->chip_info->num_channels; i++)
 		st->chan[i].powerdown_mode = AD3530R_POWERDOWN_32K;
 
 	st->ldac_gpio = devm_gpiod_get_optional(dev, "ldac", GPIOD_OUT_LOW);

-- 
2.34.1

