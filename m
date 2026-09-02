Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A0842047A;
	Wed,  2 Sep 2026 09:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788341284; cv=none; b=atzoFVyCsP0CSynqCFxgEj3cA7g7f18pbgcE2NL/sQjVrTJ1UTv77GV7fM2WbmTQcfGp0TTg26utNVlzS61JrEBdq2EBq6gG4CF2CP3RbP/gsOXKSkuV8ouQCySejAhYIPVqa9NEUFxPIqrW8q4e5HUW/A2MUuPOrLi2fZAUZnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788341284; c=relaxed/simple;
	bh=Y6qrPseco55UhTcgeBVmAu/BFglER+QIArtbgj4vV54=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=eLanlwrosAeRMEGMSeH0+h6ZUVAOQKlzML3uPXNUDCtnguaY8FshSn1IutW2sRENkhX5CbxfPuib05ADIIc3YL/EXYaTOhn6y3SsJWenMw4S6+jsHdFz/37u3mfDLeLfAyD55MRkrQuorC4ub/RTGcc0fR5JO23SDmTrZuWJ9Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=aeNk1o9t; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="aeNk1o9t"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6829RNob1668848;
	Wed, 2 Sep 2026 05:27:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Lw2Sr
	cmgXFuTflUk5XkSEwzYDkAVu7y+KCcxJscW8dE=; b=aeNk1o9tefooeaKR3mT2R
	N6orADNY//c5+BkkC2EATJGC07Rcny/K9bxs+0calKX9NZGm4yegm+/ASGMUZvsw
	GELlP5wcRCD/aGZ0HWBzxxkicDnzYNkP2Di0/FPj/wk450f1YzGJXI32xdYgDAyB
	bFS4V5vv1MCEilzzogUpBJ7537nBqJKya9+J7In4Sk2q7hi7eSzsugcUzRyRHM0c
	3Kev4YyUN+FLx3H7Pgh5+PASeYecjJIyElc//oo+/lXH61PXsxmpb+6VR3sHWNnW
	BnM8RfgFRVCv0TTTeiH67rxCAwwxDDPW0WxADMd6zfzzwU5gI76LishiW5nN8vVL
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4ge3v1kcnv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 05:27:31 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6829RUQ0029654
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 2 Sep 2026 05:27:30 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 2 Sep 2026 05:27:29 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 2 Sep 2026 05:27:29 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 2 Sep 2026 05:27:29 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.223.174])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6829QU5S032677;
	Wed, 2 Sep 2026 05:27:15 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Wed, 2 Sep 2026 11:26:17 +0200
Subject: [PATCH v11 3/3] iio: dac: Add AD5529R DAC driver support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260902-ad5529r-driver-v11-3-301c491a0719@analog.com>
References: <20260902-ad5529r-driver-v11-0-301c491a0719@analog.com>
In-Reply-To: <20260902-ad5529r-driver-v11-0-301c491a0719@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Jonathan
 Corbet" <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Mark Brown
	<broonie@kernel.org>,
        Marius Cristea <marius.cristea@microchip.com>,
        "Marcus
 Folkesson" <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara
	<daire.mcnamara@microchip.com>,
        Paul Walmsley <pjw@kernel.org>, "Palmer
 Dabbelt" <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, "Alexandre
 Ghiti" <alex@ghiti.fr>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        Janani Sunil
	<jan.sun97@gmail.com>, <linux-spi@vger.kernel.org>,
        Kent Gustavsson
	<nedo80@gmail.com>, <linux-riscv@lists.infradead.org>,
        Janani Sunil
	<janani.sunil@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788341190; l=19573;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=Y6qrPseco55UhTcgeBVmAu/BFglER+QIArtbgj4vV54=;
 b=O09UV+rkH4b1mxOiccsj6Tg3zFXk+XsjZ7pB7CrRHE5z6I7Uc+OsPHSDOwun19WyEgRseTug9
 GNU4F1Au2+2AA99aSMAr1ktFvG2KazmCwxn4Lf7dG789K5D33UK0BER
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=bql8wkai c=1 sm=1 tr=0 ts=6a97ec03 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8
 a=VwQbUJbxAAAA:8 a=RYKflIcWaOGVf2NWG3oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 9Qjs7SXiLPwsUmr4vkRE8qnzvZ2WWFHE
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA4MyBTYWx0ZWRfX/mGFXgXYgP/q
 08KdBx9KlJQOkrkvwHwNR1WhQ8gO31RYZwnSEqgEwJoVNRpWtIcYZEeCza4YgGg4JYoRAXx3GMW
 NO6dPOeYiNk/V4upHf+sYWXHzb8fI2l5e6/wZsy3f8HVfP3wuag4
X-Proofpoint-ORIG-GUID: 9Qjs7SXiLPwsUmr4vkRE8qnzvZ2WWFHE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA4MyBTYWx0ZWRfX8J7s8NrcGKIe
 MEtkIEjhLyR83sBAJmB0mzndVOb+b9dAor0w/AHeQ/A7Ou72CwB88INyuboiYUcukakJImBZ0PM
 QpafEIrMCkhl04DcwLt1iOV9TG2pE6NrkGg7R/4GPq2EfETUmVdAdTjthVq1TFX1mNjPu+2AjR/
 auYIyd58fFfipN3hKc1Gn4IgknSTM0WlsoZ/6PXG09DUlqqbOmpYBD18O+6tZVabm8CMZdQrN6S
 4GkcyN/4u4lqF7bZfftLUsn5o1Xxc43OU3hByL2INv97H2cvT/FpSR87861hFTSIPWy3MHnWEJo
 sL6Xl/Eyu8GOPraUf2dLw8iqRNk7IwakgBA4PvUa898ruFCnOCXJNUvnbqKhIwIwpAUAxUfu3i7
 xYZj3++W9cfFM1Ji03VJT0AaYEHj7O4LS7BFj1aNhbJbe9F3Q8jxXorXpcXkxaPvoxes1ETWmd+
 kF/F1V00FrJlLwrRexw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_02,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 adultscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020083

Add support for AD5529R 16-channel, 12/16 bit Digital to Analog Converter
from Analog Devices.

The device communicates over SPI and supports per-channel output range
configuration. An optional external 4.096V reference can be used in
place of the internal reference.

Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad5529r.pdf

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 MAINTAINERS               |   1 +
 drivers/iio/dac/Kconfig   |  16 ++
 drivers/iio/dac/Makefile  |   1 +
 drivers/iio/dac/ad5529r.c | 545 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 563 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 320e84765ce6..143714e27d51 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1513,6 +1513,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/dac/adi,ad5529r.yaml
+F:	drivers/iio/dac/ad5529r.c
 
 ANALOG DEVICES INC AD5706R DRIVER
 M:	Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 657c68e75542..6a7109f42f2a 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -134,6 +134,22 @@ config AD5449
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad5449.
 
+config AD5529R
+	tristate "Analog Devices AD5529R High Voltage DAC driver"
+	depends on SPI_MASTER
+	select REGMAP_SPI
+	help
+	  Say yes here to build support for Analog Devices AD5529R 16-Channel,
+	  12-Bit/16-Bit, 40V High Voltage Precision Digital to Analog Converter.
+
+	  The device features multiple output voltage ranges from -20V to +20V,
+	  built-in 4.096V voltage reference, and digital functions including
+	  toggle, dither, and ramp modes. Supports both 12-bit and 16-bit
+	  resolution variants.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ad5529r.
+
 config AD5592R_BASE
 	tristate
 
diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index 003431798498..f35e060b3643 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_AD5446) += ad5446.o
 obj-$(CONFIG_AD5446_SPI) += ad5446-spi.o
 obj-$(CONFIG_AD5446_I2C) += ad5446-i2c.o
 obj-$(CONFIG_AD5449) += ad5449.o
+obj-$(CONFIG_AD5529R) += ad5529r.o
 obj-$(CONFIG_AD5592R_BASE) += ad5592r-base.o
 obj-$(CONFIG_AD5592R) += ad5592r.o
 obj-$(CONFIG_AD5593R) += ad5593r.o
diff --git a/drivers/iio/dac/ad5529r.c b/drivers/iio/dac/ad5529r.c
new file mode 100644
index 000000000000..bc11d7671a76
--- /dev/null
+++ b/drivers/iio/dac/ad5529r.c
@@ -0,0 +1,545 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * AD5529R Digital-to-Analog Converter Driver
+ * 16-Channel, 12/16-Bit, 40V High Voltage Precision DAC
+ *
+ * Copyright 2026 Analog Devices Inc.
+ * Author: Janani Sunil <janani.sunil@analog.com>
+ */
+
+#include <linux/array_size.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/dev_printk.h>
+#include <linux/err.h>
+#include <linux/minmax.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/reset.h>
+#include <linux/spi/spi.h>
+#include <linux/types.h>
+#include <linux/units.h>
+
+#include <linux/iio/iio.h>
+
+#define AD5529R_REG_INTERFACE_CONFIG_A		0x00
+#define   AD5529R_INTERFACE_CONFIG_A_SW_RESET	(BIT(7) | BIT(0))
+#define   AD5529R_INTERFACE_CONFIG_A_ADDR_ASCENSION	BIT(5)
+#define   AD5529R_INTERFACE_CONFIG_A_SDO_ENABLE	BIT(4)
+#define AD5529R_REG_DEVICE_CONFIG		0x02
+#define AD5529R_REG_CHIP_GRADE			0x06
+#define AD5529R_REG_SCRATCH_PAD			0x0A
+#define AD5529R_REG_SPI_REVISION		0x0B
+#define AD5529R_REG_VENDOR_H			0x0D
+#define AD5529R_REG_STREAM_MODE			0x0E
+#define AD5529R_REG_INTERFACE_STATUS_A		0x11
+#define AD5529R_REG_MULTI_DAC_CH_SEL		0x14
+#define AD5529R_REG_OUT_RANGE_BASE		0x3C
+#define AD5529R_REG_OUT_RANGE(ch)		(AD5529R_REG_OUT_RANGE_BASE + (ch) * 2)
+#define AD5529R_REG_DAC_INPUT_A_BASE		0x148
+#define AD5529R_REG_DAC_INPUT_A(ch)		(AD5529R_REG_DAC_INPUT_A_BASE + (ch) * 2)
+#define AD5529R_REG_DAC_DATA_READBACK_BASE	0x16A
+#define AD5529R_REG_TSENS_ALERT_FLAG		0x18C
+#define AD5529R_REG_TSENS_SHTD_FLAG		0x18E
+#define AD5529R_REG_FUNC_BUSY			0x1A0
+#define AD5529R_REG_REF_SEL			0x1A2
+#define   AD5529R_REF_SEL_INTERNAL_REF		BIT(0)
+#define AD5529R_REG_INIT_CRC_ERR_STAT		0x1A4
+#define AD5529R_REG_MULTI_DAC_HOTPATH_SW_LDAC	0x1A8
+
+#define AD5529R_MAX_REGISTER			0x232
+#define AD5529R_8BIT_REG_MAX			0x13
+#define AD5529R_MAX_CHANNELS			16
+#define AD5529R_SPI_READ_FLAG			0x80
+#define AD5529R_ADDR_SHIFT			12
+
+struct ad5529r_model_data {
+	const char *model_name;
+	unsigned int resolution;
+};
+
+#define AD5529R_DAC_CHANNEL(chan) ((struct iio_chan_spec) {		\
+	.type = IIO_VOLTAGE,						\
+	.indexed = 1,							\
+	.output = 1,							\
+	.channel = (chan),						\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
+			      BIT(IIO_CHAN_INFO_SCALE) |		\
+			      BIT(IIO_CHAN_INFO_OFFSET),		\
+})
+
+static const char * const ad5529r_supply_names[] = {
+	"vdd-io",
+	"vdd-5v",
+	"vdd-hv0",
+	"vdd-hv1",
+	"vdd-hv2",
+	"vdd-hv3",
+};
+
+static const char * const ad5529r_vss_supply_names[] = {
+	"vss-hv0",
+	"vss-hv1",
+	"vss-hv2",
+	"vss-hv3",
+};
+
+static const struct ad5529r_model_data ad5529r_16bit_model_data = {
+	.model_name = "ad5529r-16",
+	.resolution = 16,
+};
+
+static const struct ad5529r_model_data ad5529r_12bit_model_data = {
+	.model_name = "ad5529r-12",
+	.resolution = 12,
+};
+
+enum ad5529r_output_range {
+	AD5529R_RANGE_0V_5V,
+	AD5529R_RANGE_0V_10V,
+	AD5529R_RANGE_0V_20V,
+	AD5529R_RANGE_0V_40V,
+	AD5529R_RANGE_M5V_5V,
+	AD5529R_RANGE_M10V_10V,
+	AD5529R_RANGE_M15V_15V,
+	AD5529R_RANGE_M20V_20V,
+};
+
+static const s32 ad5529r_output_ranges_mV[8][2] = {
+	[AD5529R_RANGE_0V_5V] = { 0, 5000 },
+	[AD5529R_RANGE_0V_10V] = { 0, 10000 },
+	[AD5529R_RANGE_0V_20V] = { 0, 20000 },
+	[AD5529R_RANGE_0V_40V] = { 0, 40000 },
+	[AD5529R_RANGE_M5V_5V] = { -5000, 5000 },
+	[AD5529R_RANGE_M10V_10V] = { -10000, 10000 },
+	[AD5529R_RANGE_M15V_15V] = { -15000, 15000 },
+	[AD5529R_RANGE_M20V_20V] = { -20000, 20000 },
+};
+
+struct ad5529r_state {
+	const struct ad5529r_model_data *model_data;
+	struct regmap *regmap_8bit;
+	struct regmap *regmap_16bit;
+	struct iio_chan_spec channels[AD5529R_MAX_CHANNELS];
+	unsigned int num_channels;
+	enum ad5529r_output_range output_range_idx[AD5529R_MAX_CHANNELS];
+};
+
+static const struct regmap_range ad5529r_8bit_readable_ranges[] = {
+	regmap_reg_range(AD5529R_REG_INTERFACE_CONFIG_A, AD5529R_REG_CHIP_GRADE),
+	regmap_reg_range(AD5529R_REG_SCRATCH_PAD, AD5529R_REG_VENDOR_H),
+	regmap_reg_range(AD5529R_REG_STREAM_MODE, AD5529R_REG_INTERFACE_STATUS_A),
+};
+
+static const struct regmap_range ad5529r_16bit_readable_ranges[] = {
+	regmap_reg_range(AD5529R_REG_MULTI_DAC_CH_SEL, AD5529R_REG_INIT_CRC_ERR_STAT),
+	regmap_reg_range(AD5529R_REG_MULTI_DAC_HOTPATH_SW_LDAC, AD5529R_MAX_REGISTER),
+};
+
+static const struct regmap_access_table ad5529r_8bit_readable_table = {
+	.yes_ranges = ad5529r_8bit_readable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(ad5529r_8bit_readable_ranges),
+};
+
+static const struct regmap_access_table ad5529r_16bit_readable_table = {
+	.yes_ranges = ad5529r_16bit_readable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(ad5529r_16bit_readable_ranges),
+};
+
+static const struct regmap_range ad5529r_8bit_read_only_ranges[] = {
+	regmap_reg_range(AD5529R_REG_DEVICE_CONFIG, AD5529R_REG_CHIP_GRADE),
+	regmap_reg_range(AD5529R_REG_SPI_REVISION, AD5529R_REG_VENDOR_H),
+};
+
+static const struct regmap_range ad5529r_16bit_read_only_ranges[] = {
+	regmap_reg_range(AD5529R_REG_DAC_DATA_READBACK_BASE,
+			 AD5529R_REG_DAC_DATA_READBACK_BASE +
+			 (AD5529R_MAX_CHANNELS - 1) * 2),
+	regmap_reg_range(AD5529R_REG_TSENS_ALERT_FLAG, AD5529R_REG_TSENS_SHTD_FLAG),
+	regmap_reg_range(AD5529R_REG_FUNC_BUSY, AD5529R_REG_FUNC_BUSY),
+	regmap_reg_range(AD5529R_REG_INIT_CRC_ERR_STAT, AD5529R_REG_INIT_CRC_ERR_STAT),
+};
+
+static const struct regmap_access_table ad5529r_8bit_writeable_table = {
+	.no_ranges = ad5529r_8bit_read_only_ranges,
+	.n_no_ranges = ARRAY_SIZE(ad5529r_8bit_read_only_ranges),
+};
+
+static const struct regmap_access_table ad5529r_16bit_writeable_table = {
+	.no_ranges = ad5529r_16bit_read_only_ranges,
+	.n_no_ranges = ARRAY_SIZE(ad5529r_16bit_read_only_ranges),
+};
+
+static struct regmap *ad5529r_get_regmap(struct ad5529r_state *st,
+					 unsigned int reg)
+{
+	if (reg <= AD5529R_8BIT_REG_MAX)
+		return st->regmap_8bit;
+
+	return st->regmap_16bit;
+}
+
+static int ad5529r_reset(struct ad5529r_state *st)
+{
+	struct regmap *map = st->regmap_8bit;
+	struct device *dev = regmap_get_device(map);
+	struct reset_control *rst;
+	int ret;
+
+	rst = devm_reset_control_get_optional_exclusive(dev, NULL);
+	if (IS_ERR(rst))
+		return PTR_ERR(rst);
+
+	if (rst) {
+		ret = reset_control_assert(rst);
+		if (ret)
+			return ret;
+
+		/* Minimum reset low width (t_reset) is 20 ns per datasheet. */
+		ndelay(20);
+
+		ret = reset_control_deassert(rst);
+		if (ret)
+			return ret;
+	} else {
+		ret = regmap_write(map, AD5529R_REG_INTERFACE_CONFIG_A,
+				   AD5529R_INTERFACE_CONFIG_A_SW_RESET);
+		if (ret)
+			return ret;
+	}
+
+	/*
+	 * Wait 10 ms for digital initialization to complete.
+	 * Per datasheet, Interface Status A register NOT_READY_ERR bit is
+	 * set if SPI transactions are attempted before digital initialization
+	 * completes.
+	 */
+	fsleep(10 * USEC_PER_MSEC);
+
+	return regmap_write(map, AD5529R_REG_INTERFACE_CONFIG_A,
+			    AD5529R_INTERFACE_CONFIG_A_SDO_ENABLE |
+			    AD5529R_INTERFACE_CONFIG_A_ADDR_ASCENSION);
+}
+
+static int ad5529r_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)
+{
+	struct ad5529r_state *st = iio_priv(indio_dev);
+	unsigned int reg_addr, reg_val_h;
+	int ret, range_idx, span_mV;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		/*
+		 * Read from DAC_INPUT_A register rather than DAC_DATA_READBACK.
+		 * The DAC operates in transparent mode and directly reflects
+		 * whatever value is written to the INPUT_A register.
+		 */
+		reg_addr = AD5529R_REG_DAC_INPUT_A(chan->channel);
+		ret = regmap_read(st->regmap_16bit, reg_addr, &reg_val_h);
+		if (ret)
+			return ret;
+
+		*val = reg_val_h;
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		range_idx = st->output_range_idx[chan->channel];
+
+		/*
+		 * The datasheet specifies a 4.096 V external reference,
+		 * matching the nominal output voltage of the internal
+		 * reference.
+		 */
+		span_mV = ad5529r_output_ranges_mV[range_idx][1] -
+			  ad5529r_output_ranges_mV[range_idx][0];
+		*val = span_mV;
+		*val2 = st->model_data->resolution;
+
+		return IIO_VAL_FRACTIONAL_LOG2;
+	case IIO_CHAN_INFO_OFFSET:
+		range_idx = st->output_range_idx[chan->channel];
+
+		if (ad5529r_output_ranges_mV[range_idx][0] < 0)
+			*val = -BIT(st->model_data->resolution - 1);
+		else
+			*val = 0;
+
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad5529r_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
+{
+	struct ad5529r_state *st = iio_priv(indio_dev);
+	unsigned int reg_addr;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (!in_range(val, 0, BIT(st->model_data->resolution)))
+			return -EINVAL;
+
+		reg_addr = AD5529R_REG_DAC_INPUT_A(chan->channel);
+
+		return regmap_write(st->regmap_16bit, reg_addr, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad5529r_find_output_range(const s32 *vals)
+{
+	for (unsigned int i = 0; i < ARRAY_SIZE(ad5529r_output_ranges_mV); i++) {
+		const s32 *range = ad5529r_output_ranges_mV[i];
+
+		if (vals[0] == range[0] * (MICRO / MILLI) &&
+		    vals[1] == range[1] * (MICRO / MILLI))
+			return i;
+	}
+
+	return -EINVAL;
+}
+
+static int ad5529r_parse_channel_ranges(struct device *dev,
+					struct ad5529r_state *st)
+{
+	unsigned long channel_mask = 0;
+
+	device_for_each_child_node_scoped(dev, child) {
+		int ret, range_idx;
+		u32 ch;
+
+		if (st->num_channels == ARRAY_SIZE(st->channels))
+			return dev_err_probe(dev, -ENOSPC, "Too many channels\n");
+
+		ret = fwnode_property_read_u32(child, "reg", &ch);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Missing reg property in channel node\n");
+
+		if (ch >= AD5529R_MAX_CHANNELS)
+			return dev_err_probe(dev, -ECHRNG,
+					     "Channel %u exceeds maximum %u\n",
+					     ch, AD5529R_MAX_CHANNELS - 1);
+
+		if (__test_and_set_bit(ch, &channel_mask))
+			return dev_err_probe(dev, -EEXIST,
+					     "Duplicate channel %u\n", ch);
+
+		if (fwnode_property_present(child, "output-range-microvolt")) {
+			s32 vals[2];
+
+			/*
+			 * DT stores cells as raw 32-bit values; signed endpoints are
+			 * encoded by dtc in two's-complement and then interpreted
+			 * here as s32.
+			 */
+			ret = fwnode_property_read_u32_array(child,
+							     "output-range-microvolt",
+							     (u32 *)vals, ARRAY_SIZE(vals));
+			if (ret < 0)
+				return dev_err_probe(dev, ret,
+						     "Failed to read range for ch %u\n",
+						     ch);
+
+			range_idx = ad5529r_find_output_range(vals);
+			if (range_idx < 0)
+				return dev_err_probe(dev, range_idx,
+						     "Invalid range [%d %d] for ch %u\n",
+						     vals[0], vals[1], ch);
+		} else {
+			range_idx = AD5529R_RANGE_0V_5V;
+		}
+
+		st->output_range_idx[ch] = range_idx;
+		ret = regmap_write(st->regmap_16bit,
+				   AD5529R_REG_OUT_RANGE(ch), range_idx);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to configure range for ch %u\n",
+					     ch);
+
+		st->channels[st->num_channels++] = AD5529R_DAC_CHANNEL(ch);
+	}
+
+	return 0;
+}
+
+static int ad5529r_reg_access(struct iio_dev *indio_dev,
+			      unsigned int reg,
+			      unsigned int writeval,
+			      unsigned int *readval)
+{
+	struct ad5529r_state *st = iio_priv(indio_dev);
+
+	if (readval)
+		return regmap_read(ad5529r_get_regmap(st, reg), reg, readval);
+
+	return regmap_write(ad5529r_get_regmap(st, reg), reg, writeval);
+}
+
+static const struct iio_info ad5529r_info = {
+	.read_raw = ad5529r_read_raw,
+	.write_raw = ad5529r_write_raw,
+	.debugfs_reg_access = ad5529r_reg_access,
+};
+
+static int ad5529r_probe(struct spi_device *spi)
+{
+	struct regmap_config regmap_16bit_cfg;
+	struct regmap_config regmap_8bit_cfg;
+	struct device *dev = &spi->dev;
+	struct iio_dev *indio_dev;
+	struct ad5529r_state *st;
+	bool external_vref;
+	u32 dev_addr;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+
+	st->model_data = spi_get_device_match_data(spi);
+	if (!st->model_data)
+		return dev_err_probe(dev, -ENODATA,
+				     "Failed to identify device variant\n");
+
+	if (device_property_present(dev, "spi-device-addr")) {
+		ret = device_property_read_u32(dev, "spi-device-addr", &dev_addr);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to read spi-device-addr\n");
+
+		if (dev_addr > 3)
+			return dev_err_probe(dev, -EADDRNOTAVAIL,
+					     "spi-device-addr %u out of range [0, 3]\n",
+					     dev_addr);
+	} else {
+		dev_addr = 0;
+	}
+
+	regmap_8bit_cfg = (struct regmap_config) {
+		.name = "ad5529r-8bit",
+		.reg_bits = 16,
+		.val_bits = 8,
+		.max_register = AD5529R_8BIT_REG_MAX,
+		.read_flag_mask = AD5529R_SPI_READ_FLAG,
+		.rd_table = &ad5529r_8bit_readable_table,
+		.wr_table = &ad5529r_8bit_writeable_table,
+		.reg_base = dev_addr << AD5529R_ADDR_SHIFT,
+	};
+	regmap_16bit_cfg = (struct regmap_config) {
+		.name = "ad5529r-16bit",
+		.reg_bits = 16,
+		.val_bits = 16,
+		.max_register = AD5529R_MAX_REGISTER,
+		.read_flag_mask = AD5529R_SPI_READ_FLAG,
+		.val_format_endian = REGMAP_ENDIAN_LITTLE,
+		.rd_table = &ad5529r_16bit_readable_table,
+		.wr_table = &ad5529r_16bit_writeable_table,
+		.reg_stride = 2,
+		.reg_base = dev_addr << AD5529R_ADDR_SHIFT,
+	};
+
+	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(ad5529r_supply_names),
+					     ad5529r_supply_names);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to get and enable regulators\n");
+
+	for (unsigned int i = 0; i < ARRAY_SIZE(ad5529r_vss_supply_names); i++) {
+		ret = devm_regulator_get_enable_optional(dev,
+							 ad5529r_vss_supply_names[i]);
+		if (ret && ret != -ENODEV)
+			return dev_err_probe(dev, ret,
+					     "Failed to get and enable %s regulator\n",
+					     ad5529r_vss_supply_names[i]);
+	}
+
+	ret = devm_regulator_get_enable_optional(dev, "vref");
+	if (ret == -ENODEV)
+		external_vref = false;
+	else if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to get and enable vref regulator\n");
+	else
+		external_vref = true;
+
+	/* Wait 10 ms after power-up before the first SPI transaction. */
+	fsleep(10 * USEC_PER_MSEC);
+
+	st->regmap_8bit = devm_regmap_init_spi(spi, &regmap_8bit_cfg);
+	if (IS_ERR(st->regmap_8bit))
+		return dev_err_probe(dev, PTR_ERR(st->regmap_8bit),
+				     "Failed to initialize 8-bit regmap\n");
+
+	st->regmap_16bit = devm_regmap_init_spi(spi, &regmap_16bit_cfg);
+	if (IS_ERR(st->regmap_16bit))
+		return dev_err_probe(dev, PTR_ERR(st->regmap_16bit),
+				     "Failed to initialize 16-bit regmap\n");
+
+	ret = ad5529r_reset(st);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to reset device\n");
+
+	ret = regmap_assign_bits(st->regmap_16bit, AD5529R_REG_REF_SEL,
+				 AD5529R_REF_SEL_INTERNAL_REF,
+				 !external_vref);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to configure reference\n");
+
+	ret = ad5529r_parse_channel_ranges(dev, st);
+	if (ret)
+		return ret;
+
+	indio_dev->name = st->model_data->model_name;
+	indio_dev->info = &ad5529r_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = st->channels;
+	indio_dev->num_channels = st->num_channels;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct of_device_id ad5529r_of_match[] = {
+	{ .compatible = "adi,ad5529r-16", .data = &ad5529r_16bit_model_data },
+	{ .compatible = "adi,ad5529r-12", .data = &ad5529r_12bit_model_data },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad5529r_of_match);
+
+static const struct spi_device_id ad5529r_id[] = {
+	{
+		.name = "ad5529r-16",
+		.driver_data = (kernel_ulong_t)&ad5529r_16bit_model_data,
+	},
+	{
+		.name = "ad5529r-12",
+		.driver_data = (kernel_ulong_t)&ad5529r_12bit_model_data,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, ad5529r_id);
+
+static struct spi_driver ad5529r_driver = {
+	.driver = {
+		.name = "ad5529r",
+		.of_match_table = ad5529r_of_match,
+	},
+	.probe = ad5529r_probe,
+	.id_table = ad5529r_id,
+};
+module_spi_driver(ad5529r_driver);
+
+MODULE_AUTHOR("Janani Sunil <janani.sunil@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD5529R 12/16-bit DAC driver");
+MODULE_LICENSE("GPL");

-- 
2.43.0

