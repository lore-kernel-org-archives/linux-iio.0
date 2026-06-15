Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39863AFAEB;
	Mon, 15 Jun 2026 06:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781504470; cv=none; b=lIHysDGDpwha+P+egQnaXZLZ+zIx2VSgNZkd50hnQLsS/0p2JrmZEU31CB0LL8kukCFSjShXz+lZrPY23eFDFUmvVX5ZDxXIHoDMzWOuXTd3blzmm+PB9z0JQiH6toRIBYN+LwmFuV3P7TTpWZ1NJ5NiYKoHgRE55E3Qu2nDnxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781504470; c=relaxed/simple;
	bh=lDlqIFYKCEOzca0av8oDDpCCJhSafXV973HdQ01mlY4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=bQ5E3k+IiD1hcTqj2aPScSyLFM7dVt5a0Xlyswdz0ef23HzVjrxHSQ0TkUiB+hb5qaf5Df26VyYkpE5/Ktr94UltxcdfBJTjw8Fko+ayMIfq8RRobPVwvG11CtCxFPWYDW0XPaafdEbURKNglQ+Ndl1putWvIUoNeOpwP3BT4JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=eP6SVWjh; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="eP6SVWjh"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65F6K1BK380095;
	Mon, 15 Jun 2026 02:21:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Ey7IZ
	X9H9Zc7CB2GliGOUHUmtWpgjJgv4huhRJw/lyc=; b=eP6SVWjhoEzsvheL4hzIU
	/KRph9qufVJLeNjJoav7gfGJ2sgcDoIa/T4MWr6TvfT4jc4Od+W0CvP5IJTcyb5q
	T3jjhEQzO4LCzaHa5VdSx3q8FihO5w/eD/wPMjfj/3O69fBvmtjz1glNNP2Cex4b
	BnOPvnqC6hBLUGZ2alg5HnAWPcb2GFNnYAzMa0mJBWMKrBzXzzM/CpcyH7FuePom
	87t6kngxZ4oSXDQlCncNY8DOiHOwpFx3yWAytGg8BjeqFtKqOFXCkyJWSRq5fqZ1
	qm+mekq7YZyIVHGprMCYY7Ft+6LyxI8iGUKBVeBlO7ACxgtG2RrQcIYil7P1ULID
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4esvwwa4j3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 02:21:06 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 65F6L5NQ020916
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 15 Jun 2026 02:21:05 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 15 Jun 2026 02:21:04 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 15 Jun 2026 02:21:04 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 15 Jun 2026 02:21:04 -0400
Received: from 10.32.22.147 ([10.66.6.190])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 65F6Kk5R014857;
	Mon, 15 Jun 2026 02:20:58 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Date: Mon, 15 Jun 2026 14:20:15 +0800
Subject: [PATCH v2 1/4] iio: dac: ad3530r: Refactor setup to table-driven
 register bank approach
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260615-iio-ad3532r-support-v2-1-84a0af8b83fa@analog.com>
References: <20260615-iio-ad3532r-support-v2-0-84a0af8b83fa@analog.com>
In-Reply-To: <20260615-iio-ad3532r-support-v2-0-84a0af8b83fa@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781504447; l=9166;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=lDlqIFYKCEOzca0av8oDDpCCJhSafXV973HdQ01mlY4=;
 b=wEe1cvlx+d9SgUJYMjHkCgU9ni0yNYNJ/j+ox7tebId6BbT69KHweqqCYQNPQ77vXcSgYpUFq
 /gXyeVL9CDZBrzpmOBaWciN+ZKaxD4hE5RcTFV/diypVHFtUhnYmMu/
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: NNy_NQO5Pwa5ZBZIZ81A9HokccjOuGbW
X-Proofpoint-ORIG-GUID: NNy_NQO5Pwa5ZBZIZ81A9HokccjOuGbW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA2NCBTYWx0ZWRfX0dL4Hck4i1Pd
 sY7IEebFkkNX6ZVBmQRCKYiiPUwXJ9VKm+jYKsFwOSGQgO57waE/6GxesiR9q1jyVXixPY1+eQd
 3D30vTiy/9WlAVNGkE2pvNrKC4OLjjlnLOT6W972iFDU7cJ6bKGQvrM5aw4uuJsa1aCvHaANjaR
 btdutd4VrgMXKMu0InLbuetuskD6IUoY0jcfdeutkj9LyKZEJnXhK+j6RPpgbd36NAThwu26n5Z
 blIWDRgBgQW9L001gthlX/NXuv9Sucm7Q/TYjW3guHgPcwKI8dFy4Y1Op9AQr6/xVm28GisGKC7
 ChtNQvd9NwIF+9kGcxnl6NGDvCk2obK9nwZwFL1RechNRho0j6hLWvKzPWBhReD5xI7+UuBR3CV
 sXaIHH88xlGB22nUbz1ZJCQk69C4LcA+RVnC8DcdbwuMMGfXNc+zkumJV1OVMHAv1812HVRHAfW
 CI6soqisILdo/8SJSLg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA2NCBTYWx0ZWRfXx73INwOLwKwv
 oPIG39uv5VJ4wnA581bqrajJYWxcYq6iyQZ/Xg9/gUqUBZCMm34gBo9xuWs94eD66M+D1Q6LgcF
 Ed+GRYPOFgCMZ8ueR7GHDIixexyxf/u30bUV78mDOW0+MWYXyy7p
X-Authority-Analysis: v=2.4 cv=OM0XGyaB c=1 sm=1 tr=0 ts=6a2f99d2 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8
 a=NlKgOxvxEZLQOO4oMgkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150064

Replace direct register calls in ad3530r_setup() with per-chip register
address arrays and bank helpers (ad3530r_set_reg_bank_bits,
ad3530r_write_reg_banks). Convert sw_ldac_trig_reg from a static
register address to a function pointer for per-bank LDAC trigger
register selection. Switch spi_device_id to named initializers.

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 drivers/iio/dac/ad3530r.c | 144 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 118 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/dac/ad3530r.c b/drivers/iio/dac/ad3530r.c
index d9db3226ecd6..e4346bc729ba 100644
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
 
@@ -344,7 +387,14 @@ static const struct ad3530r_chip_info ad3530r_chip = {
 	.name = "ad3530r",
 	.channels = ad3530r_channels,
 	.num_channels = ARRAY_SIZE(ad3530r_channels),
-	.sw_ldac_trig_reg = AD3530R_SW_LDAC_TRIG_A,
+	.sw_ldac_trig_reg = ad3530r_trigger_sw_ldac_reg,
+	.input_ch_reg = ad3530r_input_ch_reg,
+	.interface_config_a = ad3530r_if_config,
+	.output_control = ad3530r_out_ctrl,
+	.reference_control = ad3530r_ref_ctrl,
+	.op_mode = ad3530r_op_mode,
+	.num_banks = ARRAY_SIZE(ad3530r_if_config),
+	.num_op_mode_regs = ARRAY_SIZE(ad3530r_op_mode),
 	.input_ch_reg = ad3530r_input_ch_reg,
 	.internal_ref_support = true,
 };
@@ -353,8 +403,14 @@ static const struct ad3530r_chip_info ad3531_chip = {
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
 
@@ -362,17 +418,56 @@ static const struct ad3530r_chip_info ad3531r_chip = {
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
@@ -385,8 +480,9 @@ static int ad3530r_setup(struct ad3530r_state *st, int external_vref_uV)
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
@@ -395,8 +491,9 @@ static int ad3530r_setup(struct ad3530r_state *st, int external_vref_uV)
 
 	range_multiplier = 1;
 	if (device_property_read_bool(dev, "adi,range-double")) {
-		ret = regmap_set_bits(st->regmap, AD3530R_OUTPUT_CONTROL_0,
-				      AD3530R_OUTPUT_CONTROL_RANGE);
+		ret = ad3530r_set_reg_bank_bits(st, chip_info->output_control,
+						chip_info->num_banks,
+						AD3530R_OUTPUT_CONTROL_RANGE);
 		if (ret)
 			return ret;
 
@@ -406,8 +503,9 @@ static int ad3530r_setup(struct ad3530r_state *st, int external_vref_uV)
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
 
@@ -420,18 +518,12 @@ static int ad3530r_setup(struct ad3530r_state *st, int external_vref_uV)
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
@@ -510,10 +602,10 @@ static int ad3530r_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id ad3530r_id[] = {
-	{ "ad3530", (kernel_ulong_t)&ad3530_chip },
-	{ "ad3530r", (kernel_ulong_t)&ad3530r_chip },
-	{ "ad3531", (kernel_ulong_t)&ad3531_chip },
-	{ "ad3531r", (kernel_ulong_t)&ad3531r_chip },
+	{ .name = "ad3530", .driver_data = (kernel_ulong_t)&ad3530_chip },
+	{ .name = "ad3530r", .driver_data = (kernel_ulong_t)&ad3530r_chip },
+	{ .name = "ad3531", .driver_data = (kernel_ulong_t)&ad3531_chip },
+	{ .name = "ad3531r", .driver_data = (kernel_ulong_t)&ad3531r_chip },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad3530r_id);

-- 
2.34.1

