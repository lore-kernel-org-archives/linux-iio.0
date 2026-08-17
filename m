Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9C83B0583;
	Mon, 17 Aug 2026 06:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786948691; cv=none; b=NPFQQdB+eFKBOaPZYjfSphmrfJKx/8rxpPrUE3ewHnE0w2nwNJZ29eOKtszusskXb/0njhUV8J3+ih74yot2Ntn8qVWOEqSqN87K8Y+23GZcI9ShoRCuFfqko9V/8xxPVRziibTWKNjUR4W4X+aOdZwpaCeMrdbcYSl55IbBR+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786948691; c=relaxed/simple;
	bh=ujzeLjb7IQDx2MZIk3+Iyf8soPG/xscQHa6VJj5xQbk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=jYH6l/3bUkP3raG54NqXwIXaghx2yhbMtqLvQX6f3iHniZVBNC3GUo4yng6OdognRfuaayxVLSwrSs61K8uNKb+ukdtR00jySQzqUDC6MB3/idnLWYdC7TZ6y/Xjpn9NWJ3+SHVwc21MOUviH9AXXXdee6f6bJCIx5RkuJQ86RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=xrjjo7H7; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="xrjjo7H7"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67H6S4G52108641;
	Mon, 17 Aug 2026 02:38:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=eeaaI
	m0tKG0LaXbtziu5t0FHkVOR+bYIHeecOgv8Gh0=; b=xrjjo7H7caqvwKtnGfj6Y
	MZRQ18CZYE5FoL3Xxe/KpZ+RbEdRG7vSwlhWUtN/dGwLDtp/PermrQSTL8eFsc/I
	FjCxk42EVDMwKHHREdfwqXiEicFgz/RLw7dV41zCoedYGLbFRoYFDbSDPdfUebIr
	pN5PUS1Fks+j6yh3+sCfxqRZtZp4S2/kUYzjTAVdfSq1snFMRNVnNYwlE99WGoPA
	pV4/PGy519e4RE5h8A/A48SRHK6MfsQNwugGVG+WctnXlr3w8bi6P4PfGZKaAf5I
	bzGIU1/iLkZ3OsP+aDP6GIohJAnq8DppFGDFY/2gvTHOwTxlD/FRy8sep5fLLWyq
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4g36edbssc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 02:38:03 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67H6c2pD012551
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 17 Aug 2026 02:38:02 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 17 Aug 2026 02:38:02 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 17 Aug 2026 02:38:02 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 17 Aug 2026 02:38:02 -0400
Received: from [10.0.2.15] ([10.66.6.193])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67H6bW5S022522;
	Mon, 17 Aug 2026 02:37:56 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Date: Mon, 17 Aug 2026 14:37:14 +0800
Subject: [PATCH v3 4/4] iio: dac: ad3530r: add support for AD5710R/AD5711R
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260817-iio-ad5710r-upstream-v3-4-3a4bf7b9c78b@analog.com>
References: <20260817-iio-ad5710r-upstream-v3-0-3a4bf7b9c78b@analog.com>
In-Reply-To: <20260817-iio-ad5710r-upstream-v3-0-3a4bf7b9c78b@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786948652; l=16793;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=ujzeLjb7IQDx2MZIk3+Iyf8soPG/xscQHa6VJj5xQbk=;
 b=Al4oVlzTta4JAmlXZx4NkzA/m6Qr8AYKQBMQfPHBl7BBVW6frTYbCFkB9f+6eIcS5PivzA9Ym
 JyMvy9kIaYaCL7JNvEQ5g2l1RyfgPhvvYTwEEkxu//9JhAXYI3VPS2m
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: r4HzugEU3FZeMUuaGJjpYjaC3QCe_wog
X-Proofpoint-ORIG-GUID: r4HzugEU3FZeMUuaGJjpYjaC3QCe_wog
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA0NyBTYWx0ZWRfX0B/K4yhtvkfP
 icecGzSQLvmU68H/jnfiDwpuqaW/FiXRHTR98k+xUETk4ILkqZ1Pw/cxyf3gdb5EAw9fTqW8xu5
 3S7wl5Qhh6FJAXyvUrEu1JuAggeOp11k3D9CR1Aoqj4roMiq2O9u
X-Authority-Analysis: v=2.4 cv=S8vpBosP c=1 sm=1 tr=0 ts=6a82ac4b cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8
 a=SeBP3F2555sMZNY9xWQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA0NyBTYWx0ZWRfXyo/FVqI6B/po
 93lhQ6LfIa84mU5eyrwVlXq2iGePOW8IRMDQJnVsIPQHQdUnAfypOa/VXUaiHoV3alU5Blfxd6c
 oTA/cp0w1zSJmOMgcaT9vVPPHgtBchSJBdxiXgArpQz2P1jMkOZispjYznY7yD7jZ5vzv3N9Daj
 P3lCh/t7SfUdRU5WapXjlEU2mj4PAbgkObJ3UkpN0vAEPKy2aC46V2eCeFlzL9bkwDuVLBD7wGz
 PRx3yIpv7mPbXAvWSJw845gPdZvpkWFOD3bHjJ747xVXFMkDWadrVdQFPuIBpmuJWty9cZLyMuk
 51/8DWsyZc/euhlYCsJaVu8vj4b/QOy1R2BehkFFA3Bk3hp/DON75ZpsB+grkSf+DQGi5L0qfCz
 gszYZdGMFkhYMZiM59Bn7zEueV3JWDpj+yRjiOaafaxQaLAIQhymaEkGsNRnnlC5X/iIhSBVJln
 3OEW36zrxgva5JOPk0g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170047

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
 drivers/iio/dac/ad3530r.c | 285 +++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 270 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 04c90d98f86f..83a35d35c199 100644
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
index 97483534f8c3..aebe4f11771b 100644
--- a/drivers/iio/dac/ad3530r.c
+++ b/drivers/iio/dac/ad3530r.c
@@ -3,6 +3,8 @@
  * AD3530R/AD3530 8-channel, 16-bit Voltage Output DAC Driver
  * AD3531R/AD3531 4-channel, 16-bit Voltage Output DAC Driver
  * AD3532R/AD3532 16-channel, 16-bit Voltage Output DAC Driver
+ * AD5710R 8-channel, 16-bit Configurable IDAC/VDAC Driver
+ * AD5711R 8-channel, 12-bit Configurable IDAC/VDAC Driver
  *
  * Copyright 2025 Analog Devices Inc.
  */
@@ -27,6 +29,8 @@
 #include <linux/types.h>
 #include <linux/units.h>
 
+#include <dt-bindings/iio/addac/adi,ad74413r.h>
+
 #define AD3530R_INTERFACE_CONFIG_A		0x00
 #define AD3530R_OUTPUT_OPERATING_MODE_0		0x20
 #define AD3530R_OUTPUT_OPERATING_MODE_1		0x21
@@ -39,6 +43,8 @@
 #define AD3531R_SW_LDAC_TRIG_A			0xDD
 #define AD3531R_INPUT_CH			0xE3
 
+#define AD5710R_CHN_VMODE_EN			0xFF
+
 /* AD3532R/AD3532 bank 0 registers (channels 0-7) */
 #define AD3532R_INTERFACE_CONFIG_A_0		0x1000
 #define AD3532R_OUTPUT_OPERATING_MODE_0		0x1020
@@ -62,9 +68,11 @@
 #define AD3530R_OUTPUT_CONTROL_RANGE		BIT(2)
 #define AD3530R_REFERENCE_CONTROL_SEL		BIT(0)
 #define AD3530R_OP_MODE_CHAN_MSK(chan)		(GENMASK(1, 0) << 2 * (chan))
+#define AD5710R_CHN_VMODE_EN_BIT(chan)		BIT(chan)
 
 #define AD3530R_SW_RESET			(BIT(7) | BIT(0))
 #define AD3530R_INTERNAL_VREF_mV		2500
+#define AD5710R_INTERNAL_IREF_mA		50
 #define AD3530R_LDAC_PULSE_US			100
 
 #define AD3530R_CH_PER_REG			4
@@ -99,6 +107,7 @@ struct ad3530r_chip_info {
 	unsigned int num_op_mode_regs;
 	unsigned int resolution;
 	bool internal_ref_support;
+	bool channel_configurable;
 };
 
 struct ad3530r_state {
@@ -152,6 +161,11 @@ static const char * const ad3532r_powerdown_modes[] = {
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
@@ -194,6 +208,26 @@ static const struct iio_enum ad3532r_powerdown_mode_enum = {
 	.set = ad3530r_set_powerdown_mode,
 };
 
+static int ad5710r_get_powerdown_mode(struct iio_dev *indio_dev,
+				      const struct iio_chan_spec *chan)
+{
+	struct ad3530r_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = regmap_test_bits(st->regmap, AD5710R_CHN_VMODE_EN,
+			       AD5710R_CHN_VMODE_EN_BIT(chan->channel));
+	if (ret < 0)
+		return ret;
+
+	return !ret;
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
@@ -277,6 +311,61 @@ static ssize_t ad3532r_set_dac_powerdown(struct iio_dev *indio_dev,
 	return len;
 }
 
+static void ad5710r_get_op_mode_reg(unsigned int channel, unsigned int *reg,
+				    unsigned int *mask)
+{
+	unsigned int local_ch, reg_in_bank, ch_in_reg;
+
+	local_ch = channel % AD3530R_CH_PER_BANK;
+	reg_in_bank = local_ch / AD3530R_CH_PER_REG;
+	ch_in_reg = local_ch % AD3530R_CH_PER_REG;
+
+	*reg = AD3530R_OUTPUT_OPERATING_MODE_0 + reg_in_bank;
+	*mask = AD3530R_OP_MODE_CHAN_MSK(ch_in_reg);
+}
+
+static ssize_t ad5710r_get_dac_powerdown(struct iio_dev *indio_dev,
+					 uintptr_t private,
+					 const struct iio_chan_spec *chan,
+					 char *buf)
+{
+	struct ad3530r_state *st = iio_priv(indio_dev);
+	unsigned int reg, mask;
+	int ret;
+
+	ad5710r_get_op_mode_reg(chan->channel, &reg, &mask);
+
+	ret = regmap_test_bits(st->regmap, reg, field_prep(mask, 1));
+	if (ret < 0)
+		return ret;
+
+	return sysfs_emit(buf, "%d\n", ret);
+}
+
+static ssize_t ad5710r_set_dac_powerdown(struct iio_dev *indio_dev,
+					 uintptr_t private,
+					 const struct iio_chan_spec *chan,
+					 const char *buf, size_t len)
+{
+	struct ad3530r_state *st = iio_priv(indio_dev);
+	unsigned int reg, mask;
+	bool powerdown;
+	int ret;
+
+	ret = kstrtobool(buf, &powerdown);
+	if (ret)
+		return ret;
+
+	ad5710r_get_op_mode_reg(chan->channel, &reg, &mask);
+
+	ret = regmap_update_bits(st->regmap, reg, mask,
+				 field_prep(mask, powerdown));
+	if (ret)
+		return ret;
+
+	return len;
+}
+
 static int ad3530r_trigger_sw_ldac_reg(unsigned int channel)
 {
 	return AD3530R_SW_LDAC_TRIG_A;
@@ -343,7 +432,10 @@ static int ad3530r_read_raw(struct iio_dev *indio_dev,
 
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		*val = st->vref_mV;
+		if (chan->type == IIO_CURRENT)
+			*val = AD5710R_INTERNAL_IREF_mA;
+		else
+			*val = st->vref_mV;
 		*val2 = st->chip_info->resolution;
 
 		return IIO_VAL_FRACTIONAL_LOG2;
@@ -419,6 +511,17 @@ static const struct iio_chan_spec_ext_info ad3532r_ext_info[] = {
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
@@ -467,6 +570,17 @@ static const struct iio_chan_spec ad3532r_channels[] = {
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
@@ -522,6 +636,12 @@ static const struct regmap_config ad3532r_regmap_config = {
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
@@ -537,6 +657,7 @@ static const struct ad3530r_chip_info ad3530_chip = {
 	.num_banks = ARRAY_SIZE(ad3530r_if_config),
 	.num_op_mode_regs = ARRAY_SIZE(ad3530r_op_mode),
 	.internal_ref_support = false,
+	.channel_configurable = false,
 };
 
 static const struct ad3530r_chip_info ad3530r_chip = {
@@ -554,6 +675,7 @@ static const struct ad3530r_chip_info ad3530r_chip = {
 	.num_banks = ARRAY_SIZE(ad3530r_if_config),
 	.num_op_mode_regs = ARRAY_SIZE(ad3530r_op_mode),
 	.internal_ref_support = true,
+	.channel_configurable = false,
 };
 
 static const struct ad3530r_chip_info ad3531_chip = {
@@ -571,6 +693,7 @@ static const struct ad3530r_chip_info ad3531_chip = {
 	.num_banks = ARRAY_SIZE(ad3530r_if_config),
 	.num_op_mode_regs = ARRAY_SIZE(ad3531r_op_mode),
 	.internal_ref_support = false,
+	.channel_configurable = false,
 };
 
 static const struct ad3530r_chip_info ad3531r_chip = {
@@ -588,6 +711,7 @@ static const struct ad3530r_chip_info ad3531r_chip = {
 	.num_banks = ARRAY_SIZE(ad3530r_if_config),
 	.num_op_mode_regs = ARRAY_SIZE(ad3531r_op_mode),
 	.internal_ref_support = true,
+	.channel_configurable = false,
 };
 
 static const struct ad3530r_chip_info ad3532_chip = {
@@ -605,6 +729,7 @@ static const struct ad3530r_chip_info ad3532_chip = {
 	.num_banks = ARRAY_SIZE(ad3532r_if_config),
 	.num_op_mode_regs = ARRAY_SIZE(ad3532r_op_mode),
 	.internal_ref_support = false,
+	.channel_configurable = false,
 };
 
 static const struct ad3530r_chip_info ad3532r_chip = {
@@ -622,8 +747,123 @@ static const struct ad3530r_chip_info ad3532r_chip = {
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
 
+static int ad3530r_parse_channel_cfg(struct iio_dev *indio_dev)
+{
+	struct ad3530r_state *st = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(st->regmap);
+	struct iio_chan_spec *channels;
+	unsigned int num_chan, i;
+	int ret;
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
+	i = 0;
+	device_for_each_child_node_scoped(dev, child) {
+		unsigned int mode_reg, mode_mask, ch_func;
+		enum iio_chan_type chan_type;
+
+		ret = fwnode_property_read_u32(child, "reg", &reg);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to read reg property of %pfwP\n",
+					     child);
+
+		if (reg >= st->chip_info->num_channels)
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
+		ad5710r_get_op_mode_reg(reg, &mode_reg, &mode_mask);
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
+	indio_dev->channels = channels;
+	indio_dev->num_channels = num_chan;
+
+	return 0;
+}
+
 static int ad3530r_set_reg_bank_bits(const struct ad3530r_state *st,
 				     const unsigned int *regs,
 				     unsigned int num_regs,
@@ -656,8 +896,9 @@ static int ad3530r_write_reg_banks(const struct ad3530r_state *st,
 	return 0;
 }
 
-static int ad3530r_setup(struct ad3530r_state *st, int external_vref_uV)
+static int ad3530r_setup(struct iio_dev *indio_dev, int external_vref_uV)
 {
+	struct ad3530r_state *st = iio_priv(indio_dev);
 	const struct ad3530r_chip_info *chip_info = st->chip_info;
 	struct device *dev = regmap_get_device(st->regmap);
 	struct gpio_desc *reset_gpio;
@@ -707,19 +948,29 @@ static int ad3530r_setup(struct ad3530r_state *st, int external_vref_uV)
 		st->vref_mV = range_multiplier * AD3530R_INTERNAL_VREF_mV;
 	}
 
-	/* Set normal operating mode for all channels */
-	val = FIELD_PREP(AD3530R_OP_MODE_CHAN_MSK(0), AD3530R_NORMAL_OP) |
-	      FIELD_PREP(AD3530R_OP_MODE_CHAN_MSK(1), AD3530R_NORMAL_OP) |
-	      FIELD_PREP(AD3530R_OP_MODE_CHAN_MSK(2), AD3530R_NORMAL_OP) |
-	      FIELD_PREP(AD3530R_OP_MODE_CHAN_MSK(3), AD3530R_NORMAL_OP);
+	if (chip_info->channel_configurable) {
+		/* Channels and their operating mode are configured from DT */
+		ret = ad3530r_parse_channel_cfg(indio_dev);
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
+		indio_dev->channels = chip_info->channels;
+		indio_dev->num_channels = chip_info->num_channels;
+	}
 
 	st->ldac_gpio = devm_gpiod_get_optional(dev, "ldac", GPIOD_OUT_LOW);
 	if (IS_ERR(st->ldac_gpio))
@@ -777,15 +1028,13 @@ static int ad3530r_probe(struct spi_device *spi)
 	if (!st->chip_info->internal_ref_support && external_vref_uV == 0)
 		return -ENODEV;
 
-	ret = ad3530r_setup(st, external_vref_uV);
+	ret = ad3530r_setup(indio_dev, external_vref_uV);
 	if (ret)
 		return ret;
 
 	indio_dev->name = st->chip_info->name;
 	indio_dev->info = &ad3530r_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = st->chip_info->channels;
-	indio_dev->num_channels = st->chip_info->num_channels;
 
 	return devm_iio_device_register(&spi->dev, indio_dev);
 }
@@ -797,6 +1046,8 @@ static const struct spi_device_id ad3530r_id[] = {
 	{ .name = "ad3531r", .driver_data = (kernel_ulong_t)&ad3531r_chip },
 	{ .name = "ad3532", .driver_data = (kernel_ulong_t)&ad3532_chip },
 	{ .name = "ad3532r", .driver_data = (kernel_ulong_t)&ad3532r_chip },
+	{ .name = "ad5710r", .driver_data = (kernel_ulong_t)&ad5710r_chip },
+	{ .name = "ad5711r", .driver_data = (kernel_ulong_t)&ad5711r_chip },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad3530r_id);
@@ -808,6 +1059,8 @@ static const struct of_device_id ad3530r_of_match[] = {
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

