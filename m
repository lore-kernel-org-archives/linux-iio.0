Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2345C3F9F45;
	Mon, 29 Jun 2026 09:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782724946; cv=none; b=hXzv0JfQ6F21QzqB7frVZj1cTPcG8DtqXyyGioKPI7m7Te+HPOwymrzwt2AITEdtbgRe6R+coE+HVbcJ8GkUL9GOJijcvBpsDkVfG72zRNLRKGwcZan0vUXgzCS3d3hAmhvV+fGgNp2YeXmyxkt4YX56bi2ch84MyAvNcmb+2Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782724946; c=relaxed/simple;
	bh=bntcjrAzxByk55yr1oqaWU94IgLBBZWiNnJSUSoa3Ws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=hCCa+TTvgPMgJaysO3//UmkdtXd62yrLQOURjkohKUAqDwMlnbtEQs8GvdQfQDBhFIzYaSONIrRSA7WBonYGoltz80GwvV+eHq9/4H4HLt5UjBGiVknysboKD5/d+hJ6xuxL0HwNsEivHSnD3XNKkHBPFBoURItyN5vMX1XqFfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=nXa+M7Rj; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="nXa+M7Rj"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T6jw001430210;
	Mon, 29 Jun 2026 04:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=IoME8
	4TZtjUwHK5/b2EwTrGDaZhC8ScHNV+1GEk7JkQ=; b=nXa+M7RjvddEDyQI8fRij
	3F8DN01zJjCXZjDMmE9w+rbn5Y87Oa+oBi6yy0vdFkDE0kavMu/eHDFBF66kkTIr
	bb/7JVuhj5d4cU5HNMX9tOZVFXm0Hti9dsEZxT87fdLYte3eHcIUZpj4pBwLTR0v
	1agnAkZUmVFXDMIW9XV6i547QScSO6Hv4X2V6dtatnktBs1qXL2jFrNfC2xjmSWV
	0abEb1DXZQcJs0pvsNoFOxGITVWFNCi5rUuYcqZTRMrcQY7qHPFd+7CJa0ZLwaBF
	bBO0gQsM49mnzVf0mHlhm5r09yn3EmYUHwtCA68NyKCuB+LD7ejyekmcqXvm2ScA
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4f3k4egqdh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 04:31:39 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 65T8Vces022777
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Jun 2026 04:31:38 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 29 Jun
 2026 04:31:38 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 29 Jun 2026 04:31:38 -0400
Received: from 10.32.22.147 ([10.66.6.190])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 65T8VJkf012929;
	Mon, 29 Jun 2026 04:31:30 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Date: Mon, 29 Jun 2026 16:31:04 +0800
Subject: [PATCH v3 1/4] iio: dac: ad3530r: Refactor setup to table-driven
 register bank approach
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260629-iio-ad3532r-support-v3-1-f6e4f4abebbe@analog.com>
References: <20260629-iio-ad3532r-support-v3-0-f6e4f4abebbe@analog.com>
In-Reply-To: <20260629-iio-ad3532r-support-v3-0-f6e4f4abebbe@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy
 Shevchenko <andy@kernel.org>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux@analog.com>, <devicetree@vger.kernel.org>,
        Kim Seer Paller
	<kimseer.paller@analog.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782721879; l=8468;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=bntcjrAzxByk55yr1oqaWU94IgLBBZWiNnJSUSoa3Ws=;
 b=z1BjBXhXu8beYOmTr33dFjkF28RintfdGQFeoFfPbxRwvENrAg9TFtnxLUVT+/dQPUBbSYHUj
 EwhfubKzZXqDLUZnTwRs/5q0QAs4EJ44LXRTLegmjiVrnCQG8Gh3gy4
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=bIgm5v+Z c=1 sm=1 tr=0 ts=6a422d6c cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8
 a=NlKgOxvxEZLQOO4oMgkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: JUSi2brOWOr1QQNfU7kp-Y7sjsqQZHi_
X-Proofpoint-ORIG-GUID: JUSi2brOWOr1QQNfU7kp-Y7sjsqQZHi_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA2NyBTYWx0ZWRfX4v2AczajOuDn
 wrM1jB6uXY7hVe2/0ZJu8Q50j+YBYvz4gqTisrPpQ2arQYlnGk5dUi3Mn63QoKZwvlgDkl3wkcV
 4g6L98UJQhYOYKDbeWfQmq5EQrviualF0jJCV5vnngSHf6c+p4eO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA2NyBTYWx0ZWRfXzOC8EDboUean
 T8PEoSfW6QaI6iUk8ngyp82SuKZUXaiL2BW8vTbc7Gg2SNgy5ee+q+Omu12NEwUrdGXialc4+/2
 qJ1O3WcBCWvYnG5/1R9pzfLOvaHO347ogoTMHGcW2GGqFy8xqdNOoDcEE0IJ6M0zG5wiZxxASAJ
 tJKf6+dwh63xNPbdgB2qn3ZEUxUnPG3RfoT7cqxnw2mcmr+nds6UrgajL9lKWeaNYbFfA13u1Ar
 vpzX6PQrwgAxkcNgdYnnMZaB1BSUmYM1QJohnWvjWjNqLETbFQhzEScB3zoElBZ6qlFJ7LBpbCk
 /0IXICLMZypi69SKwErPxYTtlQamRXvy9GYEyzW1CYnWR0+bt47D/C7OIxRtely9rVymfZAwKpg
 bmojuObQgWWTmkjRPE5EaDq8xBH7D7dh0r1+MAovkOl/Q4EsQmVCAzFfpnlKmbs/cJeTHeKKmLJ
 ZcSniypGGIDfyZ9iiVA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 bulkscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290067

Replace direct register calls in ad3530r_setup() with per-chip register
address arrays and bank helpers (ad3530r_set_reg_bank_bits,
ad3530r_write_reg_banks). Convert sw_ldac_trig_reg from a static
register address to a function pointer for per-bank LDAC trigger
register selection. Switch spi_device_id to named initializers.

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 drivers/iio/dac/ad3530r.c | 135 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 113 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/dac/ad3530r.c b/drivers/iio/dac/ad3530r.c
index d9db3226ecd6..3f7c983739fc 100644
--- a/drivers/iio/dac/ad3530r.c
+++ b/drivers/iio/dac/ad3530r.c
@@ -69,8 +69,14 @@ struct ad3530r_chip_info {
 	const char *name;
 	const struct iio_chan_spec *channels;
 	int (*input_ch_reg)(unsigned int channel);
+	int (*sw_ldac_trig_reg)(unsigned int channel);
+	const unsigned int *interface_config_a;
+	const unsigned int *output_control;
+	const unsigned int *reference_control;
+	const unsigned int *op_mode;
 	unsigned int num_channels;
-	unsigned int sw_ldac_trig_reg;
+	unsigned int num_banks;
+	unsigned int num_op_mode_regs;
 	bool internal_ref_support;
 };
 
@@ -190,6 +196,16 @@ static ssize_t ad3530r_set_dac_powerdown(struct iio_dev *indio_dev,
 	return len;
 }
 
+static int ad3530r_trigger_sw_ldac_reg(unsigned int channel)
+{
+	return AD3530R_SW_LDAC_TRIG_A;
+}
+
+static int ad3531r_trigger_sw_ldac_reg(unsigned int channel)
+{
+	return AD3531R_SW_LDAC_TRIG_A;
+}
+
 static int ad3530r_trigger_hw_ldac(struct gpio_desc *ldac_gpio)
 {
 	gpiod_set_value_cansleep(ldac_gpio, 1);
@@ -215,7 +231,7 @@ static int ad3530r_dac_write(struct ad3530r_state *st, unsigned int chan,
 	if (st->ldac_gpio)
 		return ad3530r_trigger_hw_ldac(st->ldac_gpio);
 
-	return regmap_set_bits(st->regmap, st->chip_info->sw_ldac_trig_reg,
+	return regmap_set_bits(st->regmap, st->chip_info->sw_ldac_trig_reg(chan),
 			       AD3530R_SLD_TRIG_A);
 }
 
@@ -331,12 +347,39 @@ static const struct iio_chan_spec ad3531r_channels[] = {
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
-	.sw_ldac_trig_reg = AD3530R_SW_LDAC_TRIG_A,
+	.sw_ldac_trig_reg = ad3530r_trigger_sw_ldac_reg,
 	.input_ch_reg = ad3530r_input_ch_reg,
+	.interface_config_a = ad3530r_if_config,
+	.output_control = ad3530r_out_ctrl,
+	.reference_control = ad3530r_ref_ctrl,
+	.op_mode = ad3530r_op_mode,
+	.num_banks = ARRAY_SIZE(ad3530r_if_config),
+	.num_op_mode_regs = ARRAY_SIZE(ad3530r_op_mode),
 	.internal_ref_support = false,
 };
 
@@ -344,8 +387,14 @@ static const struct ad3530r_chip_info ad3530r_chip = {
 	.name = "ad3530r",
 	.channels = ad3530r_channels,
 	.num_channels = ARRAY_SIZE(ad3530r_channels),
-	.sw_ldac_trig_reg = AD3530R_SW_LDAC_TRIG_A,
+	.sw_ldac_trig_reg = ad3530r_trigger_sw_ldac_reg,
 	.input_ch_reg = ad3530r_input_ch_reg,
+	.interface_config_a = ad3530r_if_config,
+	.output_control = ad3530r_out_ctrl,
+	.reference_control = ad3530r_ref_ctrl,
+	.op_mode = ad3530r_op_mode,
+	.num_banks = ARRAY_SIZE(ad3530r_if_config),
+	.num_op_mode_regs = ARRAY_SIZE(ad3530r_op_mode),
 	.internal_ref_support = true,
 };
 
@@ -353,8 +402,14 @@ static const struct ad3530r_chip_info ad3531_chip = {
 	.name = "ad3531",
 	.channels = ad3531r_channels,
 	.num_channels = ARRAY_SIZE(ad3531r_channels),
-	.sw_ldac_trig_reg = AD3531R_SW_LDAC_TRIG_A,
+	.sw_ldac_trig_reg = ad3531r_trigger_sw_ldac_reg,
 	.input_ch_reg = ad3531r_input_ch_reg,
+	.interface_config_a = ad3530r_if_config,
+	.output_control = ad3530r_out_ctrl,
+	.reference_control = ad3530r_ref_ctrl,
+	.op_mode = ad3531r_op_mode,
+	.num_banks = ARRAY_SIZE(ad3530r_if_config),
+	.num_op_mode_regs = ARRAY_SIZE(ad3531r_op_mode),
 	.internal_ref_support = false,
 };
 
@@ -362,17 +417,56 @@ static const struct ad3530r_chip_info ad3531r_chip = {
 	.name = "ad3531r",
 	.channels = ad3531r_channels,
 	.num_channels = ARRAY_SIZE(ad3531r_channels),
-	.sw_ldac_trig_reg = AD3531R_SW_LDAC_TRIG_A,
+	.sw_ldac_trig_reg = ad3531r_trigger_sw_ldac_reg,
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
+		ret = regmap_update_bits(st->regmap, regs[i], mask, mask);
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
@@ -385,8 +479,9 @@ static int ad3530r_setup(struct ad3530r_state *st, int external_vref_uV)
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
@@ -395,8 +490,9 @@ static int ad3530r_setup(struct ad3530r_state *st, int external_vref_uV)
 
 	range_multiplier = 1;
 	if (device_property_read_bool(dev, "adi,range-double")) {
-		ret = regmap_set_bits(st->regmap, AD3530R_OUTPUT_CONTROL_0,
-				      AD3530R_OUTPUT_CONTROL_RANGE);
+		ret = ad3530r_set_reg_bank_bits(st, chip_info->output_control,
+						chip_info->num_banks,
+						AD3530R_OUTPUT_CONTROL_RANGE);
 		if (ret)
 			return ret;
 
@@ -406,8 +502,9 @@ static int ad3530r_setup(struct ad3530r_state *st, int external_vref_uV)
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
 
@@ -420,18 +517,12 @@ static int ad3530r_setup(struct ad3530r_state *st, int external_vref_uV)
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

