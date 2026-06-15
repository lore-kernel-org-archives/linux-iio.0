Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25EA3B0AD1;
	Mon, 15 Jun 2026 06:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781504486; cv=none; b=nubYTNfNjFGZVI/ujtBSCBXrd0d8dYBI505g+p9sUC6psXw0gsSHHwG68HhlvPeBJBkGwvgsTwD5Fn3LIHlq0jYYT6EkIDTs1YYdjJuWa8UPq2fEa09qVzbX5PPd8O/PhisA0+HkZ75GMj1bw844+TIKLgwOFNJYFFF4shut0zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781504486; c=relaxed/simple;
	bh=GeiwZ2oDE6T+migfE2+M445+fTLhtnA2QtfS4NX1skA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=IBzh/EcEVSb+RjWPpcmJlVJIjXSAOuhekqZ/rzYeyl9ENXypp6/iFi0W+F1/cx59MeUoR8puc9PTERNJebxYesqJnVnixRAYbZByk7AP9KnXlcdUSO3r7c27WC/pgOMUY+fr8xSDBuW+ouPaqUpA8igkI3DgoI7TTPJThFikJYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=r7jOWwpV; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="r7jOWwpV"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65F6J8X0498546;
	Mon, 15 Jun 2026 02:21:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=LdM6z
	IR4VX0U9DqWIizIF/sKaNPB6wErViuiR35EFqY=; b=r7jOWwpVGxel2VjM4LEPF
	i1om0hqO1N3tL/bosQ1ti7xvZ2xTVjG75JquMc9+vzq3zGVcDv5SS1R10xAMPHMk
	PDms1FoGmPzxTSDqLjLnLmKsnd8RKg0YAF1YfRR9oSsMKHCaI6016MRgV0OwuJv/
	SmnL54DX5lHsOEIdsZC388+dggIBHtRpzF1Z5NiS2QaFP0dAiZHPz5pcw50EBfLe
	GEZ/Y7dhwNeSgVVYOQ9C2ux3fti3YriQ/wpNxghG85WMkKnxC5ojHkaEWz8MqYxt
	QkgWs9vHiwkKj8bzbzI5R1GROze/a4LILCzo1CQhqBMWi5UPLnR+mOaaZhuuxRCP
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4es11xwm1t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 02:21:21 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 65F6LKJF020937
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 15 Jun 2026 02:21:20 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 15 Jun
 2026 02:21:20 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 15 Jun 2026 02:21:20 -0400
Received: from 10.32.22.147 ([10.66.6.190])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 65F6Kk5U014857;
	Mon, 15 Jun 2026 02:21:12 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Date: Mon, 15 Jun 2026 14:20:18 +0800
Subject: [PATCH v2 4/4] iio: dac: ad3530r: Add support for AD3532R/AD3532
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260615-iio-ad3532r-support-v2-4-84a0af8b83fa@analog.com>
References: <20260615-iio-ad3532r-support-v2-0-84a0af8b83fa@analog.com>
In-Reply-To: <20260615-iio-ad3532r-support-v2-0-84a0af8b83fa@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781504447; l=14065;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=GeiwZ2oDE6T+migfE2+M445+fTLhtnA2QtfS4NX1skA=;
 b=wiOp7p65LYtUcDs+RgHJ2jg4VgsRw4NGSSNyzULLv+YjsGvp7P51rp8l3FnTCT+wPp7ZHyhkI
 JkmDWV3U+7yAkshSkoLmaXm7VUl5ZugGBbKMuh03WhEPZDox+CgNAhB
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: -Y5ZBTxjc5a_8SvEIn_0EpMy0Xs2C3zC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA2NCBTYWx0ZWRfX7EAWKdtCxm1T
 VLDG8Ci1ucahKSPosZsCpea+wteOSUmwRQmveKpn5+XzF06IwpmAcxgXrXYm1j8Mo9+F8xLA+Qu
 yNOAtgQFWLoMUfPt4wgKeUbftS7WLQd/HvuAB8cXR6/ByyL79r1oWmCv5w2LMrx6pkNE8kL/INS
 zqMzWYFjEgCkUOWn8clXMofq/+bWB0jK8V9/t8e/Lu92smU8Ow1EAJZhnRDaJNKh0y2nNeUpNn4
 a7AEY89/dJbyU7P4mZJ1AoWPej86/lQQMl0LECTgufG0oJBvAhyxn1hPVzDYgxsolUc/+EtT4C7
 dw1XwAuSh0lu1OWRxg5k82+O5huuB1ef/y+ultArzNKHxtjL/y8H8a+WHu607zwDlZobrDNfxxX
 dlmZH4m9cdZpBcx7uz8l2nnEOxy+pgEBtAfE4Axdva9AXMIp/VYyIa1vhX49IJ9SPxvtsy7a8ZP
 +F45glUIXuvGWNw+H/g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA2NCBTYWx0ZWRfX5SJq5r+gwRoU
 SsM2ob845iM9bnq+CTKrXZ9FbWKj71NG+qRNQTEzrB6m0Y1VFr7DvcNDcnUiSkOsNrC7dggftGU
 NMNbA28s+BRnX8qyc0e1441XgDmVCADkdIqXlJsONdRJnSTh04z3
X-Proofpoint-GUID: -Y5ZBTxjc5a_8SvEIn_0EpMy0Xs2C3zC
X-Authority-Analysis: v=2.4 cv=WuAb99fv c=1 sm=1 tr=0 ts=6a2f99e1 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8
 a=cz2-yH3D_utBwWmHlxEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150064

The AD3532R/AD3532 is a 16-channel, 16-bit voltage output DAC with a
dual-bank register architecture (bank 0 at 0x1000 for channels 0-7,
bank 1 at 0x3000 for channels 8-15). It shares similar functionality
with AD3530R (channel configuration, LDAC triggering, powerdown control),
the main difference being the register address map due to the dual-bank
architecture, handled by table-driven helpers.

Add AD3532R-specific register definitions, channel specs, per-bank
register arrays, a dedicated ad3532r_set_dac_powerdown(), and per-chip
regmap_config to limit debugfs-exposed register space to each variant's
actual address range.

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 drivers/iio/dac/Kconfig   |   4 +-
 drivers/iio/dac/ad3530r.c | 208 +++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 197 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 657c68e75542..f034f7dda703 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -11,8 +11,8 @@ config AD3530R
 	depends on SPI
 	select REGMAP_SPI
 	help
-	  Say yes here to build support for Analog Devices AD3530R, AD3531R
-	  Digital to Analog Converter.
+	  Say yes here to build support for Analog Devices AD3530/AD3530R,
+	  AD3531/AD3531R, and AD3532/AD3532R Digital to Analog Converters.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad3530r.
diff --git a/drivers/iio/dac/ad3530r.c b/drivers/iio/dac/ad3530r.c
index e4346bc729ba..435d98ce29cb 100644
--- a/drivers/iio/dac/ad3530r.c
+++ b/drivers/iio/dac/ad3530r.c
@@ -2,6 +2,7 @@
 /*
  * AD3530R/AD3530 8-channel, 16-bit Voltage Output DAC Driver
  * AD3531R/AD3531 4-channel, 16-bit Voltage Output DAC Driver
+ * AD3532R/AD3532 16-channel, 16-bit Voltage Output DAC Driver
  *
  * Copyright 2025 Analog Devices Inc.
  */
@@ -39,6 +40,22 @@
 #define AD3531R_SW_LDAC_TRIG_A			0xDD
 #define AD3531R_INPUT_CH			0xE3
 
+#define AD3532R_INTERFACE_CONFIG_A_0		0x1000
+#define AD3532R_INTERFACE_CONFIG_A_1		0x3000
+#define AD3532R_OUTPUT_OPERATING_MODE_0		0x1020
+#define AD3532R_OUTPUT_OPERATING_MODE_1		0x1021
+#define AD3532R_OUTPUT_OPERATING_MODE_2		0x3020
+#define AD3532R_OUTPUT_OPERATING_MODE_3		0x3021
+#define AD3532R_OUTPUT_CONTROL_0		0x102A
+#define AD3532R_OUTPUT_CONTROL_1		0x302A
+#define AD3532R_REFERENCE_CONTROL_0		0x103C
+#define AD3532R_REFERENCE_CONTROL_1		0x303C
+#define AD3532R_SW_LDAC_TRIG_0			0x10E5
+#define AD3532R_SW_LDAC_TRIG_1			0x30E5
+#define AD3532R_INPUT_CH_0			0x10EB
+#define AD3532R_INPUT_CH_1			0x30EB
+#define AD3532R_MAX_REG_ADDR			0x30F9
+
 #define AD3530R_SLD_TRIG_A			BIT(7)
 #define AD3530R_OUTPUT_CONTROL_RANGE		BIT(2)
 #define AD3530R_REFERENCE_CONTROL_SEL		BIT(0)
@@ -50,8 +67,10 @@
 #define AD3530R_LDAC_PULSE_US			100
 
 #define AD3530R_DAC_MAX_VAL			GENMASK(15, 0)
-#define AD3530R_MAX_CHANNELS			8
+#define AD3530R_CH_PER_REG			4
+#define AD3530R_CH_PER_BANK			8
 #define AD3531R_MAX_CHANNELS			4
+#define AD3532R_MAX_CHANNELS			16
 
 enum ad3530r_mode {
 	AD3530R_NORMAL_OP,
@@ -68,6 +87,7 @@ struct ad3530r_chan {
 struct ad3530r_chip_info {
 	const char *name;
 	const struct iio_chan_spec *channels;
+	const struct regmap_config *regmap_config;
 	int (*input_ch_reg)(unsigned int channel);
 	int (*sw_ldac_trig_reg)(unsigned int channel);
 	const unsigned int *interface_config_a;
@@ -84,7 +104,7 @@ struct ad3530r_state {
 	struct regmap *regmap;
 	/* lock to protect against multiple access to the device and shared data */
 	struct mutex lock;
-	struct ad3530r_chan chan[AD3530R_MAX_CHANNELS];
+	struct ad3530r_chan chan[AD3532R_MAX_CHANNELS];
 	const struct ad3530r_chip_info *chip_info;
 	struct gpio_desc *ldac_gpio;
 	int vref_mV;
@@ -105,6 +125,14 @@ static int ad3531r_input_ch_reg(unsigned int channel)
 	return 2 * channel + AD3531R_INPUT_CH;
 }
 
+static int ad3532r_input_ch_reg(unsigned int channel)
+{
+	if (channel < 8)
+		return 2 * channel + AD3532R_INPUT_CH_0;
+
+	return 2 * (channel - 8) + AD3532R_INPUT_CH_1;
+}
+
 static const char * const ad3530r_powerdown_modes[] = {
 	"1kohm_to_gnd",
 	"7.7kohm_to_gnd",
@@ -117,6 +145,12 @@ static const char * const ad3531r_powerdown_modes[] = {
 	"16kohm_to_gnd",
 };
 
+static const char * const ad3532r_powerdown_modes[] = {
+	"1kohm_to_gnd",
+	"10kohm_to_gnd",
+	"three_state",
+};
+
 static int ad3530r_get_powerdown_mode(struct iio_dev *indio_dev,
 				      const struct iio_chan_spec *chan)
 {
@@ -152,6 +186,13 @@ static const struct iio_enum ad3531r_powerdown_mode_enum = {
 	.set = ad3530r_set_powerdown_mode,
 };
 
+static const struct iio_enum ad3532r_powerdown_mode_enum = {
+	.items = ad3532r_powerdown_modes,
+	.num_items = ARRAY_SIZE(ad3532r_powerdown_modes),
+	.get = ad3530r_get_powerdown_mode,
+	.set = ad3530r_set_powerdown_mode,
+};
+
 static ssize_t ad3530r_get_dac_powerdown(struct iio_dev *indio_dev,
 					 uintptr_t private,
 					 const struct iio_chan_spec *chan,
@@ -196,6 +237,39 @@ static ssize_t ad3530r_set_dac_powerdown(struct iio_dev *indio_dev,
 	return len;
 }
 
+static ssize_t ad3532r_set_dac_powerdown(struct iio_dev *indio_dev,
+					 uintptr_t private,
+					 const struct iio_chan_spec *chan,
+					 const char *buf, size_t len)
+{
+	struct ad3530r_state *st = iio_priv(indio_dev);
+	unsigned int reg, pdmode, mask, val, local_ch;
+	bool powerdown;
+	int ret;
+
+	ret = kstrtobool(buf, &powerdown);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&st->lock);
+	local_ch = chan->channel % AD3530R_CH_PER_BANK;
+	reg = (chan->channel < AD3530R_CH_PER_BANK ? AD3532R_OUTPUT_OPERATING_MODE_0 :
+	       AD3532R_OUTPUT_OPERATING_MODE_2) +
+	       local_ch / AD3530R_CH_PER_REG;
+	mask = AD3530R_OP_MODE_CHAN_MSK(local_ch % AD3530R_CH_PER_REG);
+
+	pdmode = powerdown ? st->chan[chan->channel].powerdown_mode : 0;
+	val = field_prep(mask, pdmode);
+
+	ret = regmap_update_bits(st->regmap, reg, mask, val);
+	if (ret)
+		return ret;
+
+	st->chan[chan->channel].powerdown = powerdown;
+
+	return len;
+}
+
 static int ad3530r_trigger_sw_ldac_reg(unsigned int channel)
 {
 	return AD3530R_SW_LDAC_TRIG_A;
@@ -206,6 +280,14 @@ static int ad3531r_trigger_sw_ldac_reg(unsigned int channel)
 	return AD3531R_SW_LDAC_TRIG_A;
 }
 
+static int ad3532r_trigger_sw_ldac_reg(unsigned int channel)
+{
+	if (channel < 8)
+		return AD3532R_SW_LDAC_TRIG_0;
+
+	return AD3532R_SW_LDAC_TRIG_1;
+}
+
 static int ad3530r_trigger_hw_ldac(struct gpio_desc *ldac_gpio)
 {
 	gpiod_set_value_cansleep(ldac_gpio, 1);
@@ -318,6 +400,19 @@ static const struct iio_chan_spec_ext_info ad3531r_ext_info[] = {
 	{ }
 };
 
+static const struct iio_chan_spec_ext_info ad3532r_ext_info[] = {
+	{
+		.name = "powerdown",
+		.shared = IIO_SEPARATE,
+		.read = ad3530r_get_dac_powerdown,
+		.write = ad3532r_set_dac_powerdown,
+	},
+	IIO_ENUM("powerdown_mode", IIO_SEPARATE, &ad3532r_powerdown_mode_enum),
+	IIO_ENUM_AVAILABLE("powerdown_mode", IIO_SHARED_BY_TYPE,
+			   &ad3532r_powerdown_mode_enum),
+	{ }
+};
+
 #define AD3530R_CHAN(_chan, _ext_info)				\
 {								\
 	.type = IIO_VOLTAGE,					\
@@ -347,6 +442,25 @@ static const struct iio_chan_spec ad3531r_channels[] = {
 	AD3530R_CHAN(3, ad3531r_ext_info),
 };
 
+static const struct iio_chan_spec ad3532r_channels[] = {
+	AD3530R_CHAN(0, ad3532r_ext_info),
+	AD3530R_CHAN(1, ad3532r_ext_info),
+	AD3530R_CHAN(2, ad3532r_ext_info),
+	AD3530R_CHAN(3, ad3532r_ext_info),
+	AD3530R_CHAN(4, ad3532r_ext_info),
+	AD3530R_CHAN(5, ad3532r_ext_info),
+	AD3530R_CHAN(6, ad3532r_ext_info),
+	AD3530R_CHAN(7, ad3532r_ext_info),
+	AD3530R_CHAN(8, ad3532r_ext_info),
+	AD3530R_CHAN(9, ad3532r_ext_info),
+	AD3530R_CHAN(10, ad3532r_ext_info),
+	AD3530R_CHAN(11, ad3532r_ext_info),
+	AD3530R_CHAN(12, ad3532r_ext_info),
+	AD3530R_CHAN(13, ad3532r_ext_info),
+	AD3530R_CHAN(14, ad3532r_ext_info),
+	AD3530R_CHAN(15, ad3532r_ext_info),
+};
+
 static const unsigned int ad3530r_if_config[] = {
 	AD3530R_INTERFACE_CONFIG_A,
 };
@@ -368,9 +482,44 @@ static const unsigned int ad3531r_op_mode[] = {
 	AD3530R_OUTPUT_OPERATING_MODE_0,
 };
 
+static const unsigned int ad3532r_if_config[] = {
+	AD3532R_INTERFACE_CONFIG_A_0,
+	AD3532R_INTERFACE_CONFIG_A_1,
+};
+
+static const unsigned int ad3532r_out_ctrl[] = {
+	AD3532R_OUTPUT_CONTROL_0,
+	AD3532R_OUTPUT_CONTROL_1,
+};
+
+static const unsigned int ad3532r_ref_ctrl[] = {
+	AD3532R_REFERENCE_CONTROL_0,
+	AD3532R_REFERENCE_CONTROL_1,
+};
+
+static const unsigned int ad3532r_op_mode[] = {
+	AD3532R_OUTPUT_OPERATING_MODE_0,
+	AD3532R_OUTPUT_OPERATING_MODE_1,
+	AD3532R_OUTPUT_OPERATING_MODE_2,
+	AD3532R_OUTPUT_OPERATING_MODE_3,
+};
+
+static const struct regmap_config ad3530r_regmap_config = {
+	.reg_bits = 16,
+	.val_bits = 8,
+	.max_register = AD3530R_MAX_REG_ADDR,
+};
+
+static const struct regmap_config ad3532r_regmap_config = {
+	.reg_bits = 16,
+	.val_bits = 8,
+	.max_register = AD3532R_MAX_REG_ADDR,
+};
+
 static const struct ad3530r_chip_info ad3530_chip = {
 	.name = "ad3530",
 	.channels = ad3530r_channels,
+	.regmap_config = &ad3530r_regmap_config,
 	.num_channels = ARRAY_SIZE(ad3530r_channels),
 	.sw_ldac_trig_reg = ad3530r_trigger_sw_ldac_reg,
 	.input_ch_reg = ad3530r_input_ch_reg,
@@ -386,6 +535,7 @@ static const struct ad3530r_chip_info ad3530_chip = {
 static const struct ad3530r_chip_info ad3530r_chip = {
 	.name = "ad3530r",
 	.channels = ad3530r_channels,
+	.regmap_config = &ad3530r_regmap_config,
 	.num_channels = ARRAY_SIZE(ad3530r_channels),
 	.sw_ldac_trig_reg = ad3530r_trigger_sw_ldac_reg,
 	.input_ch_reg = ad3530r_input_ch_reg,
@@ -402,6 +552,7 @@ static const struct ad3530r_chip_info ad3530r_chip = {
 static const struct ad3530r_chip_info ad3531_chip = {
 	.name = "ad3531",
 	.channels = ad3531r_channels,
+	.regmap_config = &ad3530r_regmap_config,
 	.num_channels = ARRAY_SIZE(ad3531r_channels),
 	.sw_ldac_trig_reg = ad3531r_trigger_sw_ldac_reg,
 	.input_ch_reg = ad3531r_input_ch_reg,
@@ -417,6 +568,7 @@ static const struct ad3530r_chip_info ad3531_chip = {
 static const struct ad3530r_chip_info ad3531r_chip = {
 	.name = "ad3531r",
 	.channels = ad3531r_channels,
+	.regmap_config = &ad3530r_regmap_config,
 	.num_channels = ARRAY_SIZE(ad3531r_channels),
 	.sw_ldac_trig_reg = ad3531r_trigger_sw_ldac_reg,
 	.input_ch_reg = ad3531r_input_ch_reg,
@@ -429,6 +581,38 @@ static const struct ad3530r_chip_info ad3531r_chip = {
 	.internal_ref_support = true,
 };
 
+static const struct ad3530r_chip_info ad3532_chip = {
+	.name = "ad3532",
+	.channels = ad3532r_channels,
+	.regmap_config = &ad3532r_regmap_config,
+	.num_channels = ARRAY_SIZE(ad3532r_channels),
+	.sw_ldac_trig_reg = ad3532r_trigger_sw_ldac_reg,
+	.input_ch_reg = ad3532r_input_ch_reg,
+	.interface_config_a = ad3532r_if_config,
+	.output_control = ad3532r_out_ctrl,
+	.reference_control = ad3532r_ref_ctrl,
+	.op_mode = ad3532r_op_mode,
+	.num_banks = ARRAY_SIZE(ad3532r_if_config),
+	.num_op_mode_regs = ARRAY_SIZE(ad3532r_op_mode),
+	.internal_ref_support = false,
+};
+
+static const struct ad3530r_chip_info ad3532r_chip = {
+	.name = "ad3532r",
+	.channels = ad3532r_channels,
+	.regmap_config = &ad3532r_regmap_config,
+	.num_channels = ARRAY_SIZE(ad3532r_channels),
+	.sw_ldac_trig_reg = ad3532r_trigger_sw_ldac_reg,
+	.input_ch_reg = ad3532r_input_ch_reg,
+	.interface_config_a = ad3532r_if_config,
+	.output_control = ad3532r_out_ctrl,
+	.reference_control = ad3532r_ref_ctrl,
+	.op_mode = ad3532r_op_mode,
+	.num_banks = ARRAY_SIZE(ad3532r_if_config),
+	.num_op_mode_regs = ARRAY_SIZE(ad3532r_op_mode),
+	.internal_ref_support = true,
+};
+
 static int ad3530r_set_reg_bank_bits(const struct ad3530r_state *st,
 				     const unsigned int *regs,
 				     unsigned int num_regs,
@@ -534,12 +718,6 @@ static int ad3530r_setup(struct ad3530r_state *st, int external_vref_uV)
 	return 0;
 }
 
-static const struct regmap_config ad3530r_regmap_config = {
-	.reg_bits = 16,
-	.val_bits = 8,
-	.max_register = AD3530R_MAX_REG_ADDR,
-};
-
 static const struct iio_info ad3530r_info = {
 	.read_raw = ad3530r_read_raw,
 	.write_raw = ad3530r_write_raw,
@@ -560,7 +738,11 @@ static int ad3530r_probe(struct spi_device *spi)
 
 	st = iio_priv(indio_dev);
 
-	st->regmap = devm_regmap_init_spi(spi, &ad3530r_regmap_config);
+	st->chip_info = spi_get_device_match_data(spi);
+	if (!st->chip_info)
+		return -ENODEV;
+
+	st->regmap = devm_regmap_init_spi(spi, st->chip_info->regmap_config);
 	if (IS_ERR(st->regmap))
 		return dev_err_probe(dev, PTR_ERR(st->regmap),
 				     "Failed to init regmap");
@@ -569,10 +751,6 @@ static int ad3530r_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	st->chip_info = spi_get_device_match_data(spi);
-	if (!st->chip_info)
-		return -ENODEV;
-
 	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulators),
 					     regulators);
 	if (ret)
@@ -606,6 +784,8 @@ static const struct spi_device_id ad3530r_id[] = {
 	{ .name = "ad3530r", .driver_data = (kernel_ulong_t)&ad3530r_chip },
 	{ .name = "ad3531", .driver_data = (kernel_ulong_t)&ad3531_chip },
 	{ .name = "ad3531r", .driver_data = (kernel_ulong_t)&ad3531r_chip },
+	{ .name = "ad3532", .driver_data = (kernel_ulong_t)&ad3532_chip },
+	{ .name = "ad3532r", .driver_data = (kernel_ulong_t)&ad3532r_chip },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad3530r_id);
@@ -615,6 +795,8 @@ static const struct of_device_id ad3530r_of_match[] = {
 	{ .compatible = "adi,ad3530r", .data = &ad3530r_chip },
 	{ .compatible = "adi,ad3531", .data = &ad3531_chip },
 	{ .compatible = "adi,ad3531r", .data = &ad3531r_chip },
+	{ .compatible = "adi,ad3532", .data = &ad3532_chip },
+	{ .compatible = "adi,ad3532r", .data = &ad3532r_chip },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ad3530r_of_match);

-- 
2.34.1

