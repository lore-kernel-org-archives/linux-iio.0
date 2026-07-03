Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C393B961E;
	Fri,  3 Jul 2026 10:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783073466; cv=none; b=KLpXsswqn6mWfHLNkzQxeJzmvSdcNpHOqVI2NpXq3OtK3EM+EMExw+Gbblq1/fUU6y/Yeyxq/vnrLYTILX/dfJZ0Fhbg+DB9NkZt0tpysJim+ZpHiIzeIKwPefPVKYlREukMR1AmRHkY6jXcaCIyLiXuSEZthUO40GMdKFSfNWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783073466; c=relaxed/simple;
	bh=GWsO/v9JskIXlk+AFoF3cyKj4qEJn+JxEWkRJOREjXI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=I0V8iRRlaP0xykVdCVmGPaOy/cnhKoJ9xiSX75oFche+EF2HLWr63kVaipepQQMDdhIfqA752aZ/o6oUUqr2SI6sE0+0G6ta5nl9eK6JmmUsNsp7gzLua1kbgWowf9jc3GQv8Cs2SxzqGcroqdWnAMnrjz0kn8/oFDlHTZf5qeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=0y1ldSgx; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="0y1ldSgx"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6635w1sP310348;
	Fri, 3 Jul 2026 06:11:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=8OUsb
	ophrxl0yzeA3OFmaK5JZMaIfP5S+I7tfA5Gn7o=; b=0y1ldSgxvf6ejvXwi39SL
	yRa95kpVfTMBqDy//CYH016JkRruL1UevvaRC3HTJo2mPB+45/Fussw1x3mUuHu5
	TukAt0LzR1IbU6tbCEBsolPV3zA3GYZDnItQL4BwGP5uE96qwUWzQnfNdhejXjpB
	/9Zy8CJ3Hp4kxXSvSE03FtUOgKUHUQzuzjQqICUgdsdccleiTVhGsfQ0LiTEIXat
	9smuV7giSdDslV9Ycqq6/bGvnNB/XRdyq8NhclCO6OrzZjARfZ3zODXDYaTywwm/
	L0+1bg1+I+CwS9brSyL4+MI+6DEw1ngRkQhmBS1nPEy30B1x2hF/dkht0i5FI04W
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4f658j1ebn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 06:11:01 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 663AB0GC011033
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 3 Jul 2026 06:11:00 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 3 Jul 2026 06:10:59 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 3 Jul 2026 06:10:59 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 3 Jul 2026 06:10:59 -0400
Received: from analog.ad.analog.com ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 663AAOlK024695;
	Fri, 3 Jul 2026 06:10:54 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Date: Fri, 3 Jul 2026 18:10:11 +0800
Subject: [PATCH v4 6/6] iio: dac: ad3530r: Add support for AD3532R/AD3532
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260703-iio-ad3532r-support-v4-6-69d9a336f4e8@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783073424; l=11614;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=GWsO/v9JskIXlk+AFoF3cyKj4qEJn+JxEWkRJOREjXI=;
 b=sskJO+Lxu1LNWt7DI7A6xPktvXAZh7S87aJjpmrU/BMakkPMqNR9AM54OSuj6MfnyLYMXPNH8
 8sdGUvePXf8DoDbFI8wATvLIAvfHq/QOJq3ydYZvASfIPPMfzlzSMkv
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=eMsjSnp1 c=1 sm=1 tr=0 ts=6a478ab5 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8
 a=rXpk_OhqMBYg6QXpCkAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: vc7KyTnyJS9-5pLITwxThZX1qsKbcjuz
X-Proofpoint-ORIG-GUID: vc7KyTnyJS9-5pLITwxThZX1qsKbcjuz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA5OCBTYWx0ZWRfX7bA0Lz92CoD+
 sO8rjtGnYsA28mUCUIkBHCAZNTvIrO+X48gJthb9D55ZVkoFTYPsAEfj8YjW90WaY0KN5SdTJzW
 jsJdUbL7EhSCH1v/yk2PqrOYFMsJu5EGAQfAcnHikk0ZI8V4QkMhH9cUDutSp9DL3cgfgFKL2A2
 /IghVH9MrPmycs6E3mtr9GARRl1bgFQWLl05NpsoWV++gsZxCns3XW3uGgWCDSkJbrIKid/cUvV
 NW3X+nlgUgxpNqgDxgCDWIglI+ZDbAIhw+DElqwVSEGF/cBDAUaewiv9KRNQJJqspo3I2ViDNhQ
 jfAeh0LOQbQ1vToD4m0hWY162jfMkGYo7RVwfjDKltq+qY/ng7rjWE1oFPELUot2eqaBB4wjky6
 OmRPPNAovevflmAqMeQh2ZkVKZ+MXVydlOqm6QeIG4a8KgeXoNgvIeMKwFZ43XfBe4PEGG2bm7K
 2zeBNcsEGIEjUeiWtrQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA5OCBTYWx0ZWRfX5f9L2O7Zo+y3
 APIWnn//TQlLoZzkrXOvwoz5DKkiCU40xAJ3l/vfDmmN7ShXvfIHJHHP5MfbAdSU2chVWsxVcL9
 8ljewSfkEd9giVkqI0n8S2RNVzQVITzhT7eS/9UU+a6VEmQEI3z+
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030098

The AD3532R/AD3532 is a 16-channel, 16-bit voltage output DAC. It shares
similar functionality with AD3530R but splits its registers into two
banks: bank 0 at 0x10xx for channels 0-7 and bank 1 at 0x30xx for
channels 8-15. The input, LDAC trigger and operating-mode registers are
therefore selected per bank.

Add the AD3532R register map, channel specs, per-bank register arrays, a
dedicated powerdown handler and its own regmap_config, reusing the
table-driven helpers for the shared configuration steps.

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 drivers/iio/dac/Kconfig   |   7 +-
 drivers/iio/dac/ad3530r.c | 189 +++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 192 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index ebf7144f922a..17529509da9d 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -11,8 +11,11 @@ config AD3530R
 	depends on SPI
 	select REGMAP_SPI
 	help
-	  Say yes here to build support for Analog Devices AD3530R, AD3531R
-	  Digital to Analog Converter.
+	  Say yes here to build support for the following Analog Devices
+	  Digital to Analog Converters:
+	  - AD3530/AD3530R (8-channel)
+	  - AD3531/AD3531R (4-channel)
+	  - AD3532/AD3532R (16-channel)
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad3530r.
diff --git a/drivers/iio/dac/ad3530r.c b/drivers/iio/dac/ad3530r.c
index be63eb819c93..23426b20f9aa 100644
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
@@ -39,6 +40,25 @@
 #define AD3531R_SW_LDAC_TRIG_A			0xDD
 #define AD3531R_INPUT_CH			0xE3
 
+/* AD3532R/AD3532 bank 0 registers (channels 0-7) */
+#define AD3532R_INTERFACE_CONFIG_A_0		0x1000
+#define AD3532R_OUTPUT_OPERATING_MODE_0		0x1020
+#define AD3532R_OUTPUT_OPERATING_MODE_1		0x1021
+#define AD3532R_OUTPUT_CONTROL_0		0x102A
+#define AD3532R_REFERENCE_CONTROL_0		0x103C
+#define AD3532R_SW_LDAC_TRIG_0			0x10E5
+#define AD3532R_INPUT_CH_0			0x10EB
+
+/* AD3532R/AD3532 bank 1 registers (channels 8-15) */
+#define AD3532R_INTERFACE_CONFIG_A_1		0x3000
+#define AD3532R_OUTPUT_OPERATING_MODE_2		0x3020
+#define AD3532R_OUTPUT_OPERATING_MODE_3		0x3021
+#define AD3532R_OUTPUT_CONTROL_1		0x302A
+#define AD3532R_REFERENCE_CONTROL_1		0x303C
+#define AD3532R_SW_LDAC_TRIG_1			0x30E5
+#define AD3532R_INPUT_CH_1			0x30EB
+#define AD3532R_MAX_REG_ADDR			0x30F9
+
 #define AD3530R_SLD_TRIG_A			BIT(7)
 #define AD3530R_OUTPUT_CONTROL_RANGE		BIT(2)
 #define AD3530R_REFERENCE_CONTROL_SEL		BIT(0)
@@ -50,8 +70,10 @@
 #define AD3530R_LDAC_PULSE_US			100
 
 #define AD3530R_DAC_MAX_VAL			GENMASK(15, 0)
-#define AD3530R_MAX_CHANNELS			8
+#define AD3530R_CH_PER_REG			4
+#define AD3530R_CH_PER_BANK			8
 #define AD3531R_MAX_CHANNELS			4
+#define AD3532R_MAX_CHANNELS			16
 
 enum ad3530r_mode {
 	AD3530R_NORMAL_OP,
@@ -85,7 +107,7 @@ struct ad3530r_state {
 	struct regmap *regmap;
 	/* lock to protect against multiple access to the device and shared data */
 	struct mutex lock;
-	struct ad3530r_chan chan[AD3530R_MAX_CHANNELS];
+	struct ad3530r_chan chan[AD3532R_MAX_CHANNELS];
 	const struct ad3530r_chip_info *chip_info;
 	struct gpio_desc *ldac_gpio;
 	int vref_mV;
@@ -106,6 +128,14 @@ static int ad3531r_input_ch_reg(unsigned int channel)
 	return 2 * channel + AD3531R_INPUT_CH;
 }
 
+static int ad3532r_input_ch_reg(unsigned int channel)
+{
+	unsigned int bank = channel / AD3530R_CH_PER_BANK;
+	unsigned int local_ch = channel % AD3530R_CH_PER_BANK;
+
+	return 2 * local_ch + (bank ? AD3532R_INPUT_CH_1 : AD3532R_INPUT_CH_0);
+}
+
 static const char * const ad3530r_powerdown_modes[] = {
 	"1kohm_to_gnd",
 	"7.7kohm_to_gnd",
@@ -118,6 +148,12 @@ static const char * const ad3531r_powerdown_modes[] = {
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
@@ -153,6 +189,13 @@ static const struct iio_enum ad3531r_powerdown_mode_enum = {
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
@@ -197,6 +240,45 @@ static ssize_t ad3530r_set_dac_powerdown(struct iio_dev *indio_dev,
 	return len;
 }
 
+static ssize_t ad3532r_set_dac_powerdown(struct iio_dev *indio_dev,
+					 uintptr_t private,
+					 const struct iio_chan_spec *chan,
+					 const char *buf, size_t len)
+{
+	struct ad3530r_state *st = iio_priv(indio_dev);
+	unsigned int bank, local_ch, reg_in_bank, ch_in_reg;
+	unsigned int reg, mask, val;
+	bool powerdown;
+	int ret;
+
+	ret = kstrtobool(buf, &powerdown);
+	if (ret)
+		return ret;
+
+	bank = chan->channel / AD3530R_CH_PER_BANK;
+	local_ch = chan->channel % AD3530R_CH_PER_BANK;
+	reg_in_bank = local_ch / AD3530R_CH_PER_REG;
+	ch_in_reg = local_ch % AD3530R_CH_PER_REG;
+
+	reg = reg_in_bank + (bank ? AD3532R_OUTPUT_OPERATING_MODE_2 :
+				    AD3532R_OUTPUT_OPERATING_MODE_0);
+	mask = AD3530R_OP_MODE_CHAN_MSK(ch_in_reg);
+
+	guard(mutex)(&st->lock);
+	if (powerdown) {
+		val = field_prep(mask, st->chan[chan->channel].powerdown_mode);
+		ret = regmap_update_bits(st->regmap, reg, mask, val);
+	} else {
+		ret = regmap_clear_bits(st->regmap, reg, mask);
+	}
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
@@ -207,6 +289,13 @@ static int ad3531r_trigger_sw_ldac_reg(unsigned int channel)
 	return AD3531R_SW_LDAC_TRIG_A;
 }
 
+static int ad3532r_trigger_sw_ldac_reg(unsigned int channel)
+{
+	unsigned int bank = channel / AD3530R_CH_PER_BANK;
+
+	return bank ? AD3532R_SW_LDAC_TRIG_1 : AD3532R_SW_LDAC_TRIG_0;
+}
+
 static int ad3530r_trigger_hw_ldac(struct gpio_desc *ldac_gpio)
 {
 	gpiod_set_value_cansleep(ldac_gpio, 1);
@@ -319,6 +408,19 @@ static const struct iio_chan_spec_ext_info ad3531r_ext_info[] = {
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
@@ -348,6 +450,25 @@ static const struct iio_chan_spec ad3531r_channels[] = {
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
@@ -369,12 +490,40 @@ static const unsigned int ad3531r_op_mode[] = {
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
 static const struct regmap_config ad3530r_regmap_config = {
 	.reg_bits = 16,
 	.val_bits = 8,
 	.max_register = AD3530R_MAX_REG_ADDR,
 };
 
+static const struct regmap_config ad3532r_regmap_config = {
+	.reg_bits = 16,
+	.val_bits = 8,
+	.max_register = AD3532R_MAX_REG_ADDR,
+};
+
 static const struct ad3530r_chip_info ad3530_chip = {
 	.name = "ad3530",
 	.channels = ad3530r_channels,
@@ -439,6 +588,38 @@ static const struct ad3530r_chip_info ad3531r_chip = {
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
@@ -610,6 +791,8 @@ static const struct spi_device_id ad3530r_id[] = {
 	{ .name = "ad3530r", .driver_data = (kernel_ulong_t)&ad3530r_chip },
 	{ .name = "ad3531", .driver_data = (kernel_ulong_t)&ad3531_chip },
 	{ .name = "ad3531r", .driver_data = (kernel_ulong_t)&ad3531r_chip },
+	{ .name = "ad3532", .driver_data = (kernel_ulong_t)&ad3532_chip },
+	{ .name = "ad3532r", .driver_data = (kernel_ulong_t)&ad3532r_chip },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad3530r_id);
@@ -619,6 +802,8 @@ static const struct of_device_id ad3530r_of_match[] = {
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

