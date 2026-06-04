Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E2C3DE42D;
	Thu,  4 Jun 2026 07:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780557277; cv=none; b=nwQt9duUfNb03WmckWJfpj0tUEvxs6L57AiRhne6F44iUGwGUYlyljj8CuVqKPPMq6uI5g4eJJ2j+0X3BPVCy0BQ5dNGo1Nzz0Lz7e4pM7kzGPssWsdTYCZm1WqftjeSdbVbpCO19+iYXUseWOznPn+wIOCtsyQi2LZ5CGbcJZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780557277; c=relaxed/simple;
	bh=tNdIOEoFcfUtriF7mN9Qi1kbbF+50Ylhfe03vJxSMo0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=bE2zgTTwFFCYvT8FByhklVd48ir6aTAN65F6xgnZ3NmXgWOAF496yk67HzRYKFkLmoZMXZxbOEneiYgyt0AllVQfZcJIAoEd44u8BE3piasPw34tvaJrBGAsLehr7PvJ0Buu6KxwvIIK6HMylLzrUkXlNPTjpcVS5PNuT8i/3hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Jg6s80L/; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Jg6s80L/"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6542jl4M1176231;
	Thu, 4 Jun 2026 03:14:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=7zT81
	z3vnPHnpZVR4SKlMAjh68olVCYQ/fgH5qk6tEs=; b=Jg6s80L/RPKeuYmPlo7Vr
	THfSAHXaMZ9a2XURxAkukwAu9iTjiQ2j00YCyhJCEJ0R8f3dZ77a0QXMlEBq5NTi
	jvgeNo5l6cnz1JxMaZHwSc57gzHr4JtrOifdgb0PSz77an303RtvSWniX7NGwaWS
	to2vEgTBsjxuqT1LaWA2iePHvAOpNoZMnRQ6RvA9CzzYGf3OvBUDyrngTJcuaguf
	a8eCpm/kOhBl+jA0pGfytT/9cZbG1nC1dzzF0wDRtT/gyxnF07IV6D1wG5S998XP
	42VwbnBHZ+dj66ri4nDVKJKKhhMc7nsfBRuWokLyDYeM5SKBCvokDOQTzimqnIQJ
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4ej7emxmw6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 03:14:32 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6547EVZ5042120
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Jun 2026 03:14:31 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 4 Jun 2026 03:14:31 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 4 Jun 2026 03:14:31 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 4 Jun 2026 03:14:31 -0400
Received: from analog.ad.analog.com ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6547Dv9O020350;
	Thu, 4 Jun 2026 03:14:20 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Date: Thu, 4 Jun 2026 15:13:45 +0800
Subject: [PATCH 3/3] iio: dac: ad3530r: Add support for AD3532R/AD3532
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260604-iio-ad3532r-support-v1-3-c3552f9031de@analog.com>
References: <20260604-iio-ad3532r-support-v1-0-c3552f9031de@analog.com>
In-Reply-To: <20260604-iio-ad3532r-support-v1-0-c3552f9031de@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780557237; l=18591;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=tNdIOEoFcfUtriF7mN9Qi1kbbF+50Ylhfe03vJxSMo0=;
 b=DbD4sPdo0cvbEPeXxrneogFDNabDYB2gJl2z/IfXucoqxAQW4Tqob20lFn9pH0hMfJHRff6u+
 6LxGHPNzOhOCcyXgmK+O5qDOYBYSJdbIVWgFU05Er2inu4wbKjtfba/
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: C5I2OM4NRsQo3HFFcKuOvtQ874nY6NR2
X-Authority-Analysis: v=2.4 cv=LsaiDHdc c=1 sm=1 tr=0 ts=6a2125d8 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8
 a=VXNwg5pRqP6ALeOW4zwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: C5I2OM4NRsQo3HFFcKuOvtQ874nY6NR2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDA2OSBTYWx0ZWRfX+3sbaGhssXF2
 NDbWF2MjTAgFvmSLLh/GSfpOxYeBX/uNXZwlytYfxxnAZClEmOSUtO316Ydi+5BMmfhXYl9Lps+
 R8DAsWnhzg65xj0Z+bKtBPEZh78lBFsUmKdfR0Bxrf5CNUCSW+s3xnBFVSXpyIgL7nzaSZIxYCe
 ezmfPB+Q3rAU6aXZoWdfXdw06+BMQ8ybk8eA/AYWAzKdV70eBORvhwhSrLPa40gNhWytzz5PvKl
 y5urPCz2c5j0y8/uBQKb7Xs/DYm9DL025phhK5xLlloHDq41uj5rRUgUwCBwvehmN6/wuroc+ud
 BaFhxsnZQZam9FbSrpiStARDccwBeSqwA5s8TjM7tnO/pgXGFfsR8UlgKEU3gTOXCbToPwIsdRm
 /tLQZxnYyodS6hAz61kYBazrWjPr0oNKvSSwnWa0zY1cXQRTjCVxEROD0sRrAGwrR+rfUqp49UK
 8K8nxTxPbySpiM2Kk8g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040069

The AD3532R/AD3532 is a 16-channel, 16-bit voltage output DAC with a
dual-bank register architecture (bank 0 at 0x1000 for channels 0-7,
bank 1 at 0x3000 for channels 8-15).

Introduce a table-driven register bank approach: per-chip register
address arrays in chip_info are iterated by ad3530r_update_reg_banks()
and ad3530r_write_reg_banks() helpers. This replaces the single-register
setup calls for existing variants (AD3530R, AD3531R) and scales
naturally to the AD3532R's dual-bank layout without per-variant
conditionals in the setup path.

Convert sw_ldac_trig_reg from a static register address to a function
pointer to handle the AD3532R's per-bank LDAC trigger registers.

Add AD3532R-specific powerdown modes (1kohm_to_gnd, 10kohm_to_gnd,
three_state) matching the OUTPUT_OPERATING_MODE register encoding, and
a dedicated ad3532r_set_dac_powerdown() using arithmetic channel-to-
register mapping for the 16-channel address space.

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 drivers/iio/dac/Kconfig   |   4 +-
 drivers/iio/dac/ad3530r.c | 315 ++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 291 insertions(+), 28 deletions(-)

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
index d9db3226ecd6..2bdff438b2a0 100644
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
@@ -34,11 +35,26 @@
 #define AD3530R_REFERENCE_CONTROL_0		0x3C
 #define AD3530R_SW_LDAC_TRIG_A			0xE5
 #define AD3530R_INPUT_CH			0xEB
-#define AD3530R_MAX_REG_ADDR			0xF9
 
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
+#define AD3532R_MAX_REG_ADDR			0x30FA
+
 #define AD3530R_SLD_TRIG_A			BIT(7)
 #define AD3530R_OUTPUT_CONTROL_RANGE		BIT(2)
 #define AD3530R_REFERENCE_CONTROL_SEL		BIT(0)
@@ -50,8 +66,11 @@
 #define AD3530R_LDAC_PULSE_US			100
 
 #define AD3530R_DAC_MAX_VAL			GENMASK(15, 0)
+#define AD3530R_CH_PER_REG			4
+#define AD3530R_CH_PER_BANK			8
 #define AD3530R_MAX_CHANNELS			8
 #define AD3531R_MAX_CHANNELS			4
+#define AD3532R_MAX_CHANNELS			16
 
 enum ad3530r_mode {
 	AD3530R_NORMAL_OP,
@@ -69,8 +88,14 @@ struct ad3530r_chip_info {
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
 
@@ -78,7 +103,7 @@ struct ad3530r_state {
 	struct regmap *regmap;
 	/* lock to protect against multiple access to the device and shared data */
 	struct mutex lock;
-	struct ad3530r_chan chan[AD3530R_MAX_CHANNELS];
+	struct ad3530r_chan chan[AD3532R_MAX_CHANNELS];
 	const struct ad3530r_chip_info *chip_info;
 	struct gpio_desc *ldac_gpio;
 	int vref_mV;
@@ -99,6 +124,14 @@ static int ad3531r_input_ch_reg(unsigned int channel)
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
@@ -111,6 +144,12 @@ static const char * const ad3531r_powerdown_modes[] = {
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
@@ -146,6 +185,13 @@ static const struct iio_enum ad3531r_powerdown_mode_enum = {
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
@@ -163,9 +209,9 @@ static ssize_t ad3530r_set_dac_powerdown(struct iio_dev *indio_dev,
 					 const char *buf, size_t len)
 {
 	struct ad3530r_state *st = iio_priv(indio_dev);
-	int ret;
 	unsigned int reg, pdmode, mask, val;
 	bool powerdown;
+	int ret;
 
 	ret = kstrtobool(buf, &powerdown);
 	if (ret)
@@ -190,6 +236,56 @@ static ssize_t ad3530r_set_dac_powerdown(struct iio_dev *indio_dev,
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
+	       AD3532R_OUTPUT_OPERATING_MODE_2) + local_ch / AD3530R_CH_PER_REG;
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
@@ -215,7 +311,7 @@ static int ad3530r_dac_write(struct ad3530r_state *st, unsigned int chan,
 	if (st->ldac_gpio)
 		return ad3530r_trigger_hw_ldac(st->ldac_gpio);
 
-	return regmap_set_bits(st->regmap, st->chip_info->sw_ldac_trig_reg,
+	return regmap_set_bits(st->regmap, st->chip_info->sw_ldac_trig_reg(chan),
 			       AD3530R_SLD_TRIG_A);
 }
 
@@ -302,6 +398,19 @@ static const struct iio_chan_spec_ext_info ad3531r_ext_info[] = {
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
@@ -331,12 +440,80 @@ static const struct iio_chan_spec ad3531r_channels[] = {
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
 
@@ -344,8 +521,14 @@ static const struct ad3530r_chip_info ad3530r_chip = {
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
 
@@ -353,8 +536,14 @@ static const struct ad3530r_chip_info ad3531_chip = {
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
 
@@ -362,17 +551,88 @@ static const struct ad3530r_chip_info ad3531r_chip = {
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
 
+static const struct ad3530r_chip_info ad3532_chip = {
+	.name = "ad3532",
+	.channels = ad3532r_channels,
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
+static int ad3530r_update_reg_banks(const struct ad3530r_state *st,
+				    const unsigned int *regs,
+				    unsigned int num_regs,
+				    unsigned int mask, unsigned int val)
+{
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < num_regs; i++) {
+		ret = regmap_update_bits(st->regmap, regs[i], mask, val);
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
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < num_regs; i++) {
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
+	int i, ret;
 
 	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(reset_gpio))
@@ -384,9 +644,10 @@ static int ad3530r_setup(struct ad3530r_state *st, int external_vref_uV)
 		fsleep(1 * USEC_PER_MSEC);
 		gpiod_set_value_cansleep(reset_gpio, 0);
 	} else {
-		/* Perform software reset */
-		ret = regmap_update_bits(st->regmap, AD3530R_INTERFACE_CONFIG_A,
-					 AD3530R_SW_RESET, AD3530R_SW_RESET);
+		ret = ad3530r_update_reg_banks(st, chip_info->interface_config_a,
+					       chip_info->num_banks,
+					       AD3530R_SW_RESET,
+					       AD3530R_SW_RESET);
 		if (ret)
 			return ret;
 	}
@@ -395,8 +656,10 @@ static int ad3530r_setup(struct ad3530r_state *st, int external_vref_uV)
 
 	range_multiplier = 1;
 	if (device_property_read_bool(dev, "adi,range-double")) {
-		ret = regmap_set_bits(st->regmap, AD3530R_OUTPUT_CONTROL_0,
-				      AD3530R_OUTPUT_CONTROL_RANGE);
+		ret = ad3530r_update_reg_banks(st, chip_info->output_control,
+					       chip_info->num_banks,
+					       AD3530R_OUTPUT_CONTROL_RANGE,
+					       AD3530R_OUTPUT_CONTROL_RANGE);
 		if (ret)
 			return ret;
 
@@ -406,8 +669,10 @@ static int ad3530r_setup(struct ad3530r_state *st, int external_vref_uV)
 	if (external_vref_uV) {
 		st->vref_mV = range_multiplier * external_vref_uV / MILLI;
 	} else {
-		ret = regmap_set_bits(st->regmap, AD3530R_REFERENCE_CONTROL_0,
-				      AD3530R_REFERENCE_CONTROL_SEL);
+		ret = ad3530r_update_reg_banks(st, chip_info->reference_control,
+					       chip_info->num_banks,
+					       AD3530R_REFERENCE_CONTROL_SEL,
+					       AD3530R_REFERENCE_CONTROL_SEL);
 		if (ret)
 			return ret;
 
@@ -420,17 +685,11 @@ static int ad3530r_setup(struct ad3530r_state *st, int external_vref_uV)
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
 	for (i = 0; i < st->chip_info->num_channels; i++)
 		st->chan[i].powerdown_mode = AD3530R_POWERDOWN_32K;
 
@@ -445,7 +704,7 @@ static int ad3530r_setup(struct ad3530r_state *st, int external_vref_uV)
 static const struct regmap_config ad3530r_regmap_config = {
 	.reg_bits = 16,
 	.val_bits = 8,
-	.max_register = AD3530R_MAX_REG_ADDR,
+	.max_register = AD3532R_MAX_REG_ADDR,
 };
 
 static const struct iio_info ad3530r_info = {
@@ -514,6 +773,8 @@ static const struct spi_device_id ad3530r_id[] = {
 	{ "ad3530r", (kernel_ulong_t)&ad3530r_chip },
 	{ "ad3531", (kernel_ulong_t)&ad3531_chip },
 	{ "ad3531r", (kernel_ulong_t)&ad3531r_chip },
+	{ "ad3532", (kernel_ulong_t)&ad3532_chip },
+	{ "ad3532r", (kernel_ulong_t)&ad3532r_chip },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad3530r_id);
@@ -523,6 +784,8 @@ static const struct of_device_id ad3530r_of_match[] = {
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

