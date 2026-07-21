Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1693BB669;
	Tue, 21 Jul 2026 08:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784623687; cv=none; b=peGvM2IBFcgAfi8RUGXu5lg2wF0dZpPSyxB2SckxrJun/H45r3dNSQMi/NMW0OSBB9YEzwNJ5V6Vd0K0nrS1JXw8ALYjcGKSjrvVqh7kJYTxPQMMp9MsHc15wRryyHSjSE9U/2AXbSkCyq8M2rwN9D0ei/l25Cn9kGPRVaDhhTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784623687; c=relaxed/simple;
	bh=dkUmuD6DbTKwav/4H/vLU8vWh2iC69Zjl+FgVj88Quk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=WooHavqvAKLkTwKhzpwE5QuF/oJoh25D+3sDcg6L6cQ21rb0o40PxeaPYjiQD35YxK/XtKPEdB7x+Za/W+A2p+pmn+oZKV8eUI/9T5gj11dPiQeeKhTneUHDUzlLACvLZtQC1YlkfvrPEMa3PA+EezDNdbZS7SuHh4jjgBROZMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=W1sAntlF; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="W1sAntlF"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66L8PGPT2893101;
	Tue, 21 Jul 2026 04:48:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=MCcvm
	93HLPGm1Yz28Gg2AUv33X1VNfHsvHquTL+MVAQ=; b=W1sAntlFYIIrijONgP4lL
	aWwrpXp0gnK+tVCnqVt3EMa84SYm1D5m4fjjA3KJGq4LKGSPN7ahmO7Y0wvzQXmn
	fli/QYK89/BtLvUa5Hxr/JyA9x0KfW1vAIIuBk4Xoh3wL/+Rzr5eODBlHEV79f7Z
	ngUtQn2bbTqBot2yey94IJOO0hcJgRS+qKj8JJ3bEo8OdtZV8bapt5sq+6YurPY/
	Ie3AJxf3hLb/s5BWswXAykQTw/an9U6B5/pKdUS74LM8C2X5s076t61Diwb6R0q9
	nh+qO9X1u4+3Azi3qjYU8zJgw8aKzOvvlT+RVGb+lyIcVXkjKn6NrsviHLSOcskP
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4fgqte8eyp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 04:47:59 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66L8lu00000844
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 21 Jul 2026 04:47:56 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 21 Jul 2026 04:47:56 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 21 Jul 2026 04:47:56 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 21 Jul 2026 04:47:56 -0400
Received: from 10.33.20.150 ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66L8lNHY015326;
	Tue, 21 Jul 2026 04:47:49 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Date: Tue, 21 Jul 2026 16:47:13 +0800
Subject: [PATCH v2 4/4] iio: dac: ad3530r: add support for AD5710R/AD5711R
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260721-iio-ad5710r-upstream-v2-4-324949dc72da@analog.com>
References: <20260721-iio-ad5710r-upstream-v2-0-324949dc72da@analog.com>
In-Reply-To: <20260721-iio-ad5710r-upstream-v2-0-324949dc72da@analog.com>
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
        Conor Dooley <conor+dt@kernel.org>,
        "Philipp
 Zabel" <p.zabel@pengutronix.de>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux@analog.com>, <devicetree@vger.kernel.org>,
        Kim Seer Paller
	<kimseer.paller@analog.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784623644; l=16613;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=dkUmuD6DbTKwav/4H/vLU8vWh2iC69Zjl+FgVj88Quk=;
 b=gv2rZi+FZtkQhKxxmHaquWMHped9mhEeij2S0Xq8/99NJ6QY0pXJle6nbXUyxTVgl1mQ6StaH
 zlO8psNolWDDlVaRFomMEfdhk8ECkL4eZDJffBomTYktksvHFjNqLHD
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA5MiBTYWx0ZWRfX03RhvD+6hWIV
 dGN/mRhO0zCWe6SrYaigBNswFCFuKPZrOCHncJvRG65m5BIhQ/BbBdvaLFuBY8sIk98r5+1eVqZ
 NrezpHwzaVlJHbHadRE7uwAUNfcc/5AieAf3rSAj+CWOqcG5+IFpGYAb1J45cXOE13RWN69fo/l
 HYSzQEYVYn3zTluVjY70ZiB6kNzJWM3wvpH0j7/YU/b4Bxv1VIglyB9ZhCBm2bwfYdbicc4VcUY
 eVlIdLUiO9U2PpiY5BMDHX3Yppqz0oWoSUsvLuTM1UT1Cwd2e9bAZPP4xhskqvltZg/t8tmVN61
 S8ddqer0EV+vpCB6Uy8S4Ypdlp7IJoXhwD700xSU+iYJ9IXLcAvuEbPOUj3drz1bw7NnSm/cJby
 Hm/6BISx1WKe3aqOmNX86LfyJLhYlCnmoM7MXNBjLhYLe0QfAcGly79tokgItlztRt9+67Bn8+W
 uuCFCSawoboI+pZXTHA==
X-Proofpoint-GUID: mDOj447Cu8N-I3VktG8wXdVdJJ4oCWv3
X-Authority-Analysis: v=2.4 cv=Ed/4hvmC c=1 sm=1 tr=0 ts=6a5f323f cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8
 a=Eck9mY1fl7aFfPOCSlIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: mDOj447Cu8N-I3VktG8wXdVdJJ4oCWv3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA5MiBTYWx0ZWRfX+grRYaocets7
 pFWukktMhnNEK10ZPfx3qLzHGLlCe1ubbR24xDne4CU6qEnAXKPB0NMe9bVsMbZJcI0hEAyiqwW
 +5TDu20Z6TdlXY6zwMcOMgOQWur6lZv3k4vpdn/ScZTRxfu52qUh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210092

Add support for the AD5710R/AD5711R, 8-channel 16-/12-bit configurable
IDAC/VDAC parts. They share the AD3530R register map and access model,
so fold them into this driver.

Each channel is configured as voltage or current output from its DT
channel@N node via adi,ch-func, building the iio_chan_spec dynamically.
Voltage channels enable VMODE_EN and report the reference-derived scale,
current channels report the 50 mA internal Iref scale. The powerdown
mode is read-only and derived from the channel's configured type.

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 drivers/iio/dac/Kconfig   |   1 +
 drivers/iio/dac/ad3530r.c | 278 +++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 265 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index d6d560c09e25..e9f388f8fac3 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -16,6 +16,7 @@ config AD3530R
 	  - AD3530/AD3530R (8-channel)
 	  - AD3531/AD3531R (4-channel)
 	  - AD3532/AD3532R (16-channel)
+	  - AD5710R/AD5711R (8-channel configurable IDAC/VDAC)
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad3530r.
diff --git a/drivers/iio/dac/ad3530r.c b/drivers/iio/dac/ad3530r.c
index 97483534f8c3..935b3a832d8e 100644
--- a/drivers/iio/dac/ad3530r.c
+++ b/drivers/iio/dac/ad3530r.c
@@ -3,6 +3,7 @@
  * AD3530R/AD3530 8-channel, 16-bit Voltage Output DAC Driver
  * AD3531R/AD3531 4-channel, 16-bit Voltage Output DAC Driver
  * AD3532R/AD3532 16-channel, 16-bit Voltage Output DAC Driver
+ * AD5710R/AD5711R 8-channel, 16-/12-bit Configurable IDAC/VDAC Driver
  *
  * Copyright 2025 Analog Devices Inc.
  */
@@ -27,6 +28,8 @@
 #include <linux/types.h>
 #include <linux/units.h>
 
+#include <dt-bindings/iio/addac/adi,ad74413r.h>
+
 #define AD3530R_INTERFACE_CONFIG_A		0x00
 #define AD3530R_OUTPUT_OPERATING_MODE_0		0x20
 #define AD3530R_OUTPUT_OPERATING_MODE_1		0x21
@@ -39,6 +42,8 @@
 #define AD3531R_SW_LDAC_TRIG_A			0xDD
 #define AD3531R_INPUT_CH			0xE3
 
+#define AD5710R_CHN_VMODE_EN			0xFF
+
 /* AD3532R/AD3532 bank 0 registers (channels 0-7) */
 #define AD3532R_INTERFACE_CONFIG_A_0		0x1000
 #define AD3532R_OUTPUT_OPERATING_MODE_0		0x1020
@@ -62,15 +67,18 @@
 #define AD3530R_OUTPUT_CONTROL_RANGE		BIT(2)
 #define AD3530R_REFERENCE_CONTROL_SEL		BIT(0)
 #define AD3530R_OP_MODE_CHAN_MSK(chan)		(GENMASK(1, 0) << 2 * (chan))
+#define AD5710R_CHN_VMODE_EN_BIT(chan)		BIT(chan)
 
 #define AD3530R_SW_RESET			(BIT(7) | BIT(0))
 #define AD3530R_INTERNAL_VREF_mV		2500
+#define AD5710R_INTERNAL_IREF_mA		50
 #define AD3530R_LDAC_PULSE_US			100
 
 #define AD3530R_CH_PER_REG			4
 #define AD3530R_CH_PER_BANK			8
 #define AD3531R_MAX_CHANNELS			4
 #define AD3532R_MAX_CHANNELS			16
+#define AD5710R_NUM_CHANNELS			8
 
 enum ad3530r_mode {
 	AD3530R_NORMAL_OP,
@@ -99,6 +107,7 @@ struct ad3530r_chip_info {
 	unsigned int num_op_mode_regs;
 	unsigned int resolution;
 	bool internal_ref_support;
+	bool channel_configurable;
 };
 
 struct ad3530r_state {
@@ -107,6 +116,8 @@ struct ad3530r_state {
 	struct mutex lock;
 	struct ad3530r_chan chan[AD3532R_MAX_CHANNELS];
 	const struct ad3530r_chip_info *chip_info;
+	const struct iio_chan_spec *channels;
+	unsigned int num_channels;
 	struct gpio_desc *ldac_gpio;
 	int vref_mV;
 	/*
@@ -152,6 +163,11 @@ static const char * const ad3532r_powerdown_modes[] = {
 	"three_state",
 };
 
+static const char * const ad5710r_powerdown_modes[] = {
+	"15kohm_to_gnd",
+	"three_state",
+};
+
 static int ad3530r_get_powerdown_mode(struct iio_dev *indio_dev,
 				      const struct iio_chan_spec *chan)
 {
@@ -194,6 +210,26 @@ static const struct iio_enum ad3532r_powerdown_mode_enum = {
 	.set = ad3530r_set_powerdown_mode,
 };
 
+static int ad5710r_get_powerdown_mode(struct iio_dev *indio_dev,
+				      const struct iio_chan_spec *chan)
+{
+	struct ad3530r_state *st = iio_priv(indio_dev);
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(st->regmap, AD5710R_CHN_VMODE_EN, &val);
+	if (ret)
+		return ret;
+
+	return !(val & AD5710R_CHN_VMODE_EN_BIT(chan->channel));
+}
+
+static const struct iio_enum ad5710r_powerdown_mode_enum = {
+	.items = ad5710r_powerdown_modes,
+	.num_items = ARRAY_SIZE(ad5710r_powerdown_modes),
+	.get = ad5710r_get_powerdown_mode,
+};
+
 static ssize_t ad3530r_get_dac_powerdown(struct iio_dev *indio_dev,
 					 uintptr_t private,
 					 const struct iio_chan_spec *chan,
@@ -277,6 +313,54 @@ static ssize_t ad3532r_set_dac_powerdown(struct iio_dev *indio_dev,
 	return len;
 }
 
+static ssize_t ad5710r_get_dac_powerdown(struct iio_dev *indio_dev,
+					 uintptr_t private,
+					 const struct iio_chan_spec *chan,
+					 char *buf)
+{
+	struct ad3530r_state *st = iio_priv(indio_dev);
+	unsigned int reg_offset, ch_in_reg, reg, mode, mask;
+	int ret;
+
+	reg_offset = chan->channel / AD3530R_CH_PER_REG;
+	ch_in_reg = chan->channel % AD3530R_CH_PER_REG;
+	reg = AD3530R_OUTPUT_OPERATING_MODE_0 + reg_offset;
+	mask = AD3530R_OP_MODE_CHAN_MSK(ch_in_reg);
+
+	ret = regmap_read(st->regmap, reg, &mode);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%d\n", !!(mode & mask));
+}
+
+static ssize_t ad5710r_set_dac_powerdown(struct iio_dev *indio_dev,
+					 uintptr_t private,
+					 const struct iio_chan_spec *chan,
+					 const char *buf, size_t len)
+{
+	struct ad3530r_state *st = iio_priv(indio_dev);
+	unsigned int reg_offset, ch_in_reg, reg, mask, val;
+	bool powerdown;
+	int ret;
+
+	ret = kstrtobool(buf, &powerdown);
+	if (ret)
+		return ret;
+
+	reg_offset = chan->channel / AD3530R_CH_PER_REG;
+	ch_in_reg = chan->channel % AD3530R_CH_PER_REG;
+	reg = AD3530R_OUTPUT_OPERATING_MODE_0 + reg_offset;
+	mask = AD3530R_OP_MODE_CHAN_MSK(ch_in_reg);
+	val = field_prep(mask, powerdown);
+
+	ret = regmap_update_bits(st->regmap, reg, mask, val);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
 static int ad3530r_trigger_sw_ldac_reg(unsigned int channel)
 {
 	return AD3530R_SW_LDAC_TRIG_A;
@@ -343,7 +427,10 @@ static int ad3530r_read_raw(struct iio_dev *indio_dev,
 
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		*val = st->vref_mV;
+		if (chan->type == IIO_CURRENT)
+			*val = AD5710R_INTERNAL_IREF_mA;
+		else
+			*val = st->vref_mV;
 		*val2 = st->chip_info->resolution;
 
 		return IIO_VAL_FRACTIONAL_LOG2;
@@ -419,6 +506,17 @@ static const struct iio_chan_spec_ext_info ad3532r_ext_info[] = {
 	{ }
 };
 
+static const struct iio_chan_spec_ext_info ad5710r_ext_info[] = {
+	{
+		.name = "powerdown",
+		.shared = IIO_SEPARATE,
+		.read = ad5710r_get_dac_powerdown,
+		.write = ad5710r_set_dac_powerdown,
+	},
+	IIO_ENUM("powerdown_mode", IIO_SEPARATE, &ad5710r_powerdown_mode_enum),
+	{ }
+};
+
 #define AD3530R_CHAN(_chan, _ext_info)				\
 {								\
 	.type = IIO_VOLTAGE,					\
@@ -467,6 +565,17 @@ static const struct iio_chan_spec ad3532r_channels[] = {
 	AD3530R_CHAN(15, ad3532r_ext_info),
 };
 
+static const struct iio_chan_spec ad5710r_channels[] = {
+	AD3530R_CHAN(0, ad5710r_ext_info),
+	AD3530R_CHAN(1, ad5710r_ext_info),
+	AD3530R_CHAN(2, ad5710r_ext_info),
+	AD3530R_CHAN(3, ad5710r_ext_info),
+	AD3530R_CHAN(4, ad5710r_ext_info),
+	AD3530R_CHAN(5, ad5710r_ext_info),
+	AD3530R_CHAN(6, ad5710r_ext_info),
+	AD3530R_CHAN(7, ad5710r_ext_info),
+};
+
 static const unsigned int ad3530r_if_config[] = {
 	AD3530R_INTERFACE_CONFIG_A,
 };
@@ -522,6 +631,12 @@ static const struct regmap_config ad3532r_regmap_config = {
 	.max_register = AD3532R_MAX_REG_ADDR,
 };
 
+static const struct regmap_config ad5710r_regmap_config = {
+	.reg_bits = 16,
+	.val_bits = 8,
+	.max_register = AD5710R_CHN_VMODE_EN,
+};
+
 static const struct ad3530r_chip_info ad3530_chip = {
 	.name = "ad3530",
 	.resolution = 16,
@@ -537,6 +652,7 @@ static const struct ad3530r_chip_info ad3530_chip = {
 	.num_banks = ARRAY_SIZE(ad3530r_if_config),
 	.num_op_mode_regs = ARRAY_SIZE(ad3530r_op_mode),
 	.internal_ref_support = false,
+	.channel_configurable = false,
 };
 
 static const struct ad3530r_chip_info ad3530r_chip = {
@@ -554,6 +670,7 @@ static const struct ad3530r_chip_info ad3530r_chip = {
 	.num_banks = ARRAY_SIZE(ad3530r_if_config),
 	.num_op_mode_regs = ARRAY_SIZE(ad3530r_op_mode),
 	.internal_ref_support = true,
+	.channel_configurable = false,
 };
 
 static const struct ad3530r_chip_info ad3531_chip = {
@@ -571,6 +688,7 @@ static const struct ad3530r_chip_info ad3531_chip = {
 	.num_banks = ARRAY_SIZE(ad3530r_if_config),
 	.num_op_mode_regs = ARRAY_SIZE(ad3531r_op_mode),
 	.internal_ref_support = false,
+	.channel_configurable = false,
 };
 
 static const struct ad3530r_chip_info ad3531r_chip = {
@@ -588,6 +706,7 @@ static const struct ad3530r_chip_info ad3531r_chip = {
 	.num_banks = ARRAY_SIZE(ad3530r_if_config),
 	.num_op_mode_regs = ARRAY_SIZE(ad3531r_op_mode),
 	.internal_ref_support = true,
+	.channel_configurable = false,
 };
 
 static const struct ad3530r_chip_info ad3532_chip = {
@@ -605,6 +724,7 @@ static const struct ad3530r_chip_info ad3532_chip = {
 	.num_banks = ARRAY_SIZE(ad3532r_if_config),
 	.num_op_mode_regs = ARRAY_SIZE(ad3532r_op_mode),
 	.internal_ref_support = false,
+	.channel_configurable = false,
 };
 
 static const struct ad3530r_chip_info ad3532r_chip = {
@@ -622,8 +742,124 @@ static const struct ad3530r_chip_info ad3532r_chip = {
 	.num_banks = ARRAY_SIZE(ad3532r_if_config),
 	.num_op_mode_regs = ARRAY_SIZE(ad3532r_op_mode),
 	.internal_ref_support = true,
+	.channel_configurable = false,
+};
+
+static const struct ad3530r_chip_info ad5710r_chip = {
+	.name = "ad5710r",
+	.resolution = 16,
+	.regmap_config = &ad5710r_regmap_config,
+	.num_channels = ARRAY_SIZE(ad5710r_channels),
+	.sw_ldac_trig_reg = ad3530r_trigger_sw_ldac_reg,
+	.input_ch_reg = ad3530r_input_ch_reg,
+	.interface_config_a = ad3530r_if_config,
+	.output_control = ad3530r_out_ctrl,
+	.reference_control = ad3530r_ref_ctrl,
+	.op_mode = ad3530r_op_mode,
+	.num_banks = ARRAY_SIZE(ad3530r_if_config),
+	.num_op_mode_regs = ARRAY_SIZE(ad3530r_op_mode),
+	.internal_ref_support = true,
+	.channel_configurable = true,
+};
+
+static const struct ad3530r_chip_info ad5711r_chip = {
+	.name = "ad5711r",
+	.resolution = 12,
+	.regmap_config = &ad5710r_regmap_config,
+	.num_channels = ARRAY_SIZE(ad5710r_channels),
+	.sw_ldac_trig_reg = ad3530r_trigger_sw_ldac_reg,
+	.input_ch_reg = ad3530r_input_ch_reg,
+	.interface_config_a = ad3530r_if_config,
+	.output_control = ad3530r_out_ctrl,
+	.reference_control = ad3530r_ref_ctrl,
+	.op_mode = ad3530r_op_mode,
+	.num_banks = ARRAY_SIZE(ad3530r_if_config),
+	.num_op_mode_regs = ARRAY_SIZE(ad3530r_op_mode),
+	.internal_ref_support = true,
+	.channel_configurable = true,
 };
 
+static int ad3530r_parse_channel_cfg(struct ad3530r_state *st)
+{
+	struct device *dev = regmap_get_device(st->regmap);
+	struct iio_chan_spec *channels;
+	int ret, num_chan;
+	int i = 0;
+	u32 reg;
+
+	num_chan = device_get_child_node_count(dev);
+	if (!num_chan)
+		return dev_err_probe(dev, -ENODEV, "No channels configured\n");
+
+	channels = devm_kcalloc(dev, num_chan, sizeof(*channels), GFP_KERNEL);
+	if (!channels)
+		return -ENOMEM;
+
+	device_for_each_child_node_scoped(dev, child) {
+		unsigned int reg_offset, ch_in_reg, mode_reg, mode_mask, ch_func;
+		enum iio_chan_type chan_type;
+
+		ret = fwnode_property_read_u32(child, "reg", &reg);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to read reg property of %pfwP\n",
+					     child);
+
+		if (reg >= AD5710R_NUM_CHANNELS)
+			return dev_err_probe(dev, -EINVAL,
+					     "reg out of range in %pfwP\n",
+					     child);
+
+		ret = fwnode_property_read_u32(child, "adi,ch-func", &ch_func);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Missing adi,ch-func property for %pfwP\n",
+					     child);
+
+		switch (ch_func) {
+		case CH_FUNC_VOLTAGE_OUTPUT:
+			ret = regmap_set_bits(st->regmap, AD5710R_CHN_VMODE_EN,
+					      AD5710R_CHN_VMODE_EN_BIT(reg));
+			if (ret)
+				return dev_err_probe(dev, ret,
+						     "Failed to set voltage output for %pfwP\n",
+						     child);
+
+			chan_type = IIO_VOLTAGE;
+			break;
+		case CH_FUNC_CURRENT_OUTPUT:
+			chan_type = IIO_CURRENT;
+			break;
+		default:
+			return dev_err_probe(dev, -EINVAL,
+					     "Invalid adi,ch-func %u for %pfwP\n",
+					     ch_func, child);
+		}
+
+		channels[i] = ad5710r_channels[reg];
+		channels[i].type = chan_type;
+		i++;
+
+		reg_offset = reg / AD3530R_CH_PER_REG;
+		ch_in_reg = reg % AD3530R_CH_PER_REG;
+		mode_reg = AD3530R_OUTPUT_OPERATING_MODE_0 + reg_offset;
+		mode_mask = AD3530R_OP_MODE_CHAN_MSK(ch_in_reg);
+
+		/* Enable the channel in normal operation mode */
+		ret = regmap_update_bits(st->regmap, mode_reg, mode_mask,
+					 field_prep(mode_mask, AD3530R_NORMAL_OP));
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to set normal operating mode for %pfwP\n",
+					     child);
+	}
+
+	st->channels = channels;
+	st->num_channels = num_chan;
+
+	return 0;
+}
+
 static int ad3530r_set_reg_bank_bits(const struct ad3530r_state *st,
 				     const unsigned int *regs,
 				     unsigned int num_regs,
@@ -707,19 +943,29 @@ static int ad3530r_setup(struct ad3530r_state *st, int external_vref_uV)
 		st->vref_mV = range_multiplier * AD3530R_INTERNAL_VREF_mV;
 	}
 
-	/* Set normal operating mode for all channels */
-	val = FIELD_PREP(AD3530R_OP_MODE_CHAN_MSK(0), AD3530R_NORMAL_OP) |
-	      FIELD_PREP(AD3530R_OP_MODE_CHAN_MSK(1), AD3530R_NORMAL_OP) |
-	      FIELD_PREP(AD3530R_OP_MODE_CHAN_MSK(2), AD3530R_NORMAL_OP) |
-	      FIELD_PREP(AD3530R_OP_MODE_CHAN_MSK(3), AD3530R_NORMAL_OP);
+	if (chip_info->channel_configurable) {
+		/* Channels and their operating mode are configured from DT */
+		ret = ad3530r_parse_channel_cfg(st);
+		if (ret)
+			return ret;
+	} else {
+		/* Set normal operating mode for all channels */
+		val = FIELD_PREP(AD3530R_OP_MODE_CHAN_MSK(0), AD3530R_NORMAL_OP) |
+		      FIELD_PREP(AD3530R_OP_MODE_CHAN_MSK(1), AD3530R_NORMAL_OP) |
+		      FIELD_PREP(AD3530R_OP_MODE_CHAN_MSK(2), AD3530R_NORMAL_OP) |
+		      FIELD_PREP(AD3530R_OP_MODE_CHAN_MSK(3), AD3530R_NORMAL_OP);
+
+		ret = ad3530r_write_reg_banks(st, chip_info->op_mode,
+					      chip_info->num_op_mode_regs, val);
+		if (ret)
+			return ret;
 
-	ret = ad3530r_write_reg_banks(st, st->chip_info->op_mode,
-				      st->chip_info->num_op_mode_regs, val);
-	if (ret)
-		return ret;
+		for (unsigned int i = 0; i < chip_info->num_channels; i++)
+			st->chan[i].powerdown_mode = AD3530R_POWERDOWN_32K;
 
-	for (unsigned int i = 0; i < st->chip_info->num_channels; i++)
-		st->chan[i].powerdown_mode = AD3530R_POWERDOWN_32K;
+		st->channels = chip_info->channels;
+		st->num_channels = chip_info->num_channels;
+	}
 
 	st->ldac_gpio = devm_gpiod_get_optional(dev, "ldac", GPIOD_OUT_LOW);
 	if (IS_ERR(st->ldac_gpio))
@@ -784,8 +1030,8 @@ static int ad3530r_probe(struct spi_device *spi)
 	indio_dev->name = st->chip_info->name;
 	indio_dev->info = &ad3530r_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = st->chip_info->channels;
-	indio_dev->num_channels = st->chip_info->num_channels;
+	indio_dev->channels = st->channels;
+	indio_dev->num_channels = st->num_channels;
 
 	return devm_iio_device_register(&spi->dev, indio_dev);
 }
@@ -797,6 +1043,8 @@ static const struct spi_device_id ad3530r_id[] = {
 	{ .name = "ad3531r", .driver_data = (kernel_ulong_t)&ad3531r_chip },
 	{ .name = "ad3532", .driver_data = (kernel_ulong_t)&ad3532_chip },
 	{ .name = "ad3532r", .driver_data = (kernel_ulong_t)&ad3532r_chip },
+	{ .name = "ad5710r", .driver_data = (kernel_ulong_t)&ad5710r_chip },
+	{ .name = "ad5711r", .driver_data = (kernel_ulong_t)&ad5711r_chip },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad3530r_id);
@@ -808,6 +1056,8 @@ static const struct of_device_id ad3530r_of_match[] = {
 	{ .compatible = "adi,ad3531r", .data = &ad3531r_chip },
 	{ .compatible = "adi,ad3532", .data = &ad3532_chip },
 	{ .compatible = "adi,ad3532r", .data = &ad3532r_chip },
+	{ .compatible = "adi,ad5710r", .data = &ad5710r_chip },
+	{ .compatible = "adi,ad5711r", .data = &ad5711r_chip },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ad3530r_of_match);

-- 
2.34.1

