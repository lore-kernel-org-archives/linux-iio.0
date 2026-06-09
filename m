Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E2538D6A2;
	Tue,  9 Jun 2026 15:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781017287; cv=none; b=FUs0npbS4+JGujUHr9Wz5o4TqmduBwQ2WgdwgVgolTuq1APsrg8q4vWrAb07MInsRLFVORYiVWiO6GTPsJU6rb23hMsIkQ0PEecHKvmW5DSrMXWzWZBPIEPejghhbBea8RqaCt15Ij6NypYxlkz/iLAQ3PhqHTEUyU6IAqwehD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781017287; c=relaxed/simple;
	bh=hj4D4KwsVoWHV3r6xQx6gVxWZnO67kArUptLVzPs90s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=DlB2wHAuWGC2W5tywBz1wBnlOCIfhQ+qzeqRHb/vyDub6hlHenBcKlwf+pJlrp5rDk8VFutvykdMRq7HQeISZyZrCqTPBOybgHgGTHDuBseRtIOUQDY9jp3MiaG1jO/TR1B70ar8UQDgjxRoXW0mbwXYVWXeG2U/BBoiX7vFd+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=aVbj5/5O; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="aVbj5/5O"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659CpOkp1070626;
	Tue, 9 Jun 2026 11:00:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=FjdbA
	VnUKexKVsSZj+2NE2TnvMPprwYM1Gv3G7pjlhU=; b=aVbj5/5Okb8seYpxim3kc
	iP4YU4PUhcBtfu7dtd5ndbbZ85ZaW2U6WXPP+7gIYz1FUHRX+Lke5Cf5Iho1EojM
	EOZJQfkBOHAgRAXwr0zjA+bA5HZleOF9Opx3+SW5dqscNCqLE318ykRy2mLMaxnS
	7HbmDXOwyHMXgURlMD9P9VmODqw6cCloPKym5IXqEofqmwhaVO+WBx5KDt2D55yM
	xnViOSzIqBCNHzLFYz3V6oAzBdlzEvHexZoluQzuYZz+lKSwxfykmX5nAzbldpah
	FcoTowO9AZOO2tctw9sDKTlqiI5hw0bVl1WNgdxiFjrK0ca1KIjsU9YAojH+MGi3
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4epaa2jd5e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 11:00:55 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 659F0sFY007404
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 9 Jun 2026 11:00:54 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 9 Jun 2026 11:00:54 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 9 Jun 2026 11:00:54 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 9 Jun 2026 11:00:54 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.3.60] (may be forged))
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 659F0au3031316;
	Tue, 9 Jun 2026 11:00:51 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Tue, 9 Jun 2026 17:00:21 +0200
Subject: [PATCH v4 2/2] iio: dac: Add AD5529R DAC driver support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260609-ad5529r-driver-v4-2-2e4c02234a1a@analog.com>
References: <20260609-ad5529r-driver-v4-0-2e4c02234a1a@analog.com>
In-Reply-To: <20260609-ad5529r-driver-v4-0-2e4c02234a1a@analog.com>
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
        Shuah Khan <skhan@linuxfoundation.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        Janani Sunil
	<jan.sun97@gmail.com>,
        Janani Sunil <janani.sunil@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781017235; l=18627;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=hj4D4KwsVoWHV3r6xQx6gVxWZnO67kArUptLVzPs90s=;
 b=aww0TiWAA41x8a4oKrDpZjUUtbsOVTGGQBbxqKRbltdKthtq3F98MIFw1fQmbaZbE5PKIT9wz
 C5nKRfxtllqDiDZCeiUVbjrfaYMFmSaKHxgP//3p5RtIlw03ROVkW4+
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=O6gJeh9W c=1 sm=1 tr=0 ts=6a282aa8 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8
 a=VwQbUJbxAAAA:8 a=RYKflIcWaOGVf2NWG3oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDE0MiBTYWx0ZWRfX33+OztE6WAVP
 SP0QXzECm4K5uocKG4jj1mLAUPSgJJyotdo4kIl7mlFBk28Fd+zcAf1A2bN2cCxOYvpr4FadfWn
 NNzrGQomR3qJf4qofHm8bPUbaXI8jdvTwgGOzI0DdusUL9r/wOV3EcvkevoxCLndKJ7bWP54G1/
 Tg1AH/sL+1EwG3Bh9urFE/uDyCBYuIjW9gOegW5DUGTP9HfhdpMYTOZwa4ku5iXr5UPcKx4IXuE
 8iwdunKxtU/Hmr1lwFD3626PSpRI5+D7KbLMnlHtp+biycdNFqzoB7kBOvGSBKCyfk10LgH901K
 zq5+5Qmb+7DujUfyCFPD4ozwT6sgESiY9tk1eEwynQG8Y1RKrGKSvlEs/oaRQOQXqTewcgCQveb
 g72O7rvHMScpTpYw0aoKC6HQnWppixwfgdOUnNwUxopSnyx5WLFCW3PhaUtcjhK82JThyMnfc3T
 pwUA/jKyB7oAQcbNyUw==
X-Proofpoint-ORIG-GUID: FH1Uty4PWAQgze9aj3D9iy2HkPrQXHxf
X-Proofpoint-GUID: FH1Uty4PWAQgze9aj3D9iy2HkPrQXHxf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 spamscore=0 priorityscore=1501 phishscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090142

Add support for AD5529R 16-channel, 12/16 bit Digital to Analog Converter

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 MAINTAINERS               |   1 +
 drivers/iio/dac/Kconfig   |  17 ++
 drivers/iio/dac/Makefile  |   1 +
 drivers/iio/dac/ad5529r.c | 517 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 536 insertions(+)

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
index 657c68e75542..bb1d59889a2a 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -134,6 +134,23 @@ config AD5449
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad5449.
 
+config AD5529R
+	tristate "Analog Devices AD5529R High Voltage DAC driver"
+	depends on SPI_MASTER
+	select REGMAP_SPI
+	help
+	  Say yes here to build support for Analog Devices AD5529R
+	  16-Channel, 12-Bit/16-Bit, 40V High Voltage Precision Digital to Analog
+	  Converter.
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
index 000000000000..d2d0287d0f95
--- /dev/null
+++ b/drivers/iio/dac/ad5529r.c
@@ -0,0 +1,517 @@
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
+#include <linux/bits.h>
+#include <linux/delay.h>
+#include <linux/dev_printk.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/iio/iio.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/reset.h>
+#include <linux/spi/spi.h>
+
+#define AD5529R_REG_INTERFACE_CONFIG_A		0x00
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
+#define AD5529R_REG_INIT_CRC_ERR_STAT		0x1A4
+#define AD5529R_REG_MULTI_DAC_HOTPATH_SW_LDAC	0x1A8
+
+#define   AD5529R_INTERFACE_CONFIG_A_SW_RESET	(BIT(7) | BIT(0))
+#define   AD5529R_INTERFACE_CONFIG_A_ADDR_ASCENSION	BIT(5)
+#define   AD5529R_INTERFACE_CONFIG_A_SDO_ENABLE	BIT(4)
+#define   AD5529R_REF_SEL_INTERNAL_REF		BIT(0)
+#define   AD5529R_MAX_REGISTER			0x232
+#define   AD5529R_8BIT_REG_MAX			0x13
+#define   AD5529R_SPI_READ_FLAG			0x80
+
+struct ad5529r_model_data {
+	const char *model_name;
+	unsigned int resolution;
+	const struct iio_chan_spec *channels;
+	unsigned int num_channels;
+};
+
+#define AD5529R_DAC_CHANNEL(chan, bits) {			\
+	.type = IIO_VOLTAGE,					\
+	.indexed = 1,						\
+	.output = 1,						\
+	.channel = (chan),					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
+			      BIT(IIO_CHAN_INFO_SCALE) |	\
+			      BIT(IIO_CHAN_INFO_OFFSET),	\
+	.scan_type = {						\
+		.format = 'u',					\
+		.realbits = (bits),				\
+		.storagebits = 16,				\
+	},							\
+}
+
+static const char * const ad5529r_supply_names[] = {
+	"vdd",
+	"avdd",
+	"hvdd",
+};
+
+static const struct iio_chan_spec ad5529r_channels_16bit[] = {
+	AD5529R_DAC_CHANNEL(0, 16),
+	AD5529R_DAC_CHANNEL(1, 16),
+	AD5529R_DAC_CHANNEL(2, 16),
+	AD5529R_DAC_CHANNEL(3, 16),
+	AD5529R_DAC_CHANNEL(4, 16),
+	AD5529R_DAC_CHANNEL(5, 16),
+	AD5529R_DAC_CHANNEL(6, 16),
+	AD5529R_DAC_CHANNEL(7, 16),
+	AD5529R_DAC_CHANNEL(8, 16),
+	AD5529R_DAC_CHANNEL(9, 16),
+	AD5529R_DAC_CHANNEL(10, 16),
+	AD5529R_DAC_CHANNEL(11, 16),
+	AD5529R_DAC_CHANNEL(12, 16),
+	AD5529R_DAC_CHANNEL(13, 16),
+	AD5529R_DAC_CHANNEL(14, 16),
+	AD5529R_DAC_CHANNEL(15, 16),
+};
+
+static const struct iio_chan_spec ad5529r_channels_12bit[] = {
+	AD5529R_DAC_CHANNEL(0, 12),
+	AD5529R_DAC_CHANNEL(1, 12),
+	AD5529R_DAC_CHANNEL(2, 12),
+	AD5529R_DAC_CHANNEL(3, 12),
+	AD5529R_DAC_CHANNEL(4, 12),
+	AD5529R_DAC_CHANNEL(5, 12),
+	AD5529R_DAC_CHANNEL(6, 12),
+	AD5529R_DAC_CHANNEL(7, 12),
+	AD5529R_DAC_CHANNEL(8, 12),
+	AD5529R_DAC_CHANNEL(9, 12),
+	AD5529R_DAC_CHANNEL(10, 12),
+	AD5529R_DAC_CHANNEL(11, 12),
+	AD5529R_DAC_CHANNEL(12, 12),
+	AD5529R_DAC_CHANNEL(13, 12),
+	AD5529R_DAC_CHANNEL(14, 12),
+	AD5529R_DAC_CHANNEL(15, 12),
+};
+
+static const struct ad5529r_model_data ad5529r_16bit_model_data = {
+	.model_name = "ad5529r-16",
+	.resolution = 16,
+	.channels = ad5529r_channels_16bit,
+	.num_channels = ARRAY_SIZE(ad5529r_channels_16bit),
+};
+
+static const struct ad5529r_model_data ad5529r_12bit_model_data = {
+	.model_name = "ad5529r-12",
+	.resolution = 12,
+	.channels = ad5529r_channels_12bit,
+	.num_channels = ARRAY_SIZE(ad5529r_channels_12bit),
+};
+
+enum ad5529r_output_range {
+	AD5529R_RANGE_0V_5V,
+	AD5529R_RANGE_0V_10V,
+	AD5529R_RANGE_0V_20V,
+	AD5529R_RANGE_0V_40V,
+	AD5529R_RANGE_NEG5V_5V,
+	AD5529R_RANGE_NEG10V_10V,
+	AD5529R_RANGE_NEG15V_15V,
+	AD5529R_RANGE_NEG20V_20V,
+};
+
+static const s32 ad5529r_output_ranges_mv[8][2] = {
+	[AD5529R_RANGE_0V_5V] = { 0, 5000 },
+	[AD5529R_RANGE_0V_10V] = { 0, 10000 },
+	[AD5529R_RANGE_0V_20V] = { 0, 20000 },
+	[AD5529R_RANGE_0V_40V] = { 0, 40000 },
+	[AD5529R_RANGE_NEG5V_5V] = { -5000, 5000 },
+	[AD5529R_RANGE_NEG10V_10V] = { -10000, 10000 },
+	[AD5529R_RANGE_NEG15V_15V] = { -15000, 15000 },
+	[AD5529R_RANGE_NEG20V_20V] = { -20000, 20000 },
+};
+
+struct ad5529r_state {
+	struct spi_device *spi;
+	const struct ad5529r_model_data *model_data;
+	struct regmap *regmap_8bit;
+	struct regmap *regmap_16bit;
+	enum ad5529r_output_range output_range_idx[16];
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
+			 (AD5529R_REG_DAC_DATA_READBACK_BASE + 15 * 2)),
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
+static const struct regmap_config ad5529r_regmap_8bit_config = {
+	.name = "ad5529r-8bit",
+	.reg_bits = 16,
+	.val_bits = 8,
+	.max_register = AD5529R_8BIT_REG_MAX,
+	.read_flag_mask = AD5529R_SPI_READ_FLAG,
+	.rd_table = &ad5529r_8bit_readable_table,
+	.wr_table = &ad5529r_8bit_writeable_table,
+};
+
+static const struct regmap_config ad5529r_regmap_16bit_config = {
+	.name = "ad5529r-16bit",
+	.reg_bits = 16,
+	.val_bits = 16,
+	.max_register = AD5529R_MAX_REGISTER,
+	.read_flag_mask = AD5529R_SPI_READ_FLAG,
+	.val_format_endian = REGMAP_ENDIAN_LITTLE,
+	.rd_table = &ad5529r_16bit_readable_table,
+	.wr_table = &ad5529r_16bit_writeable_table,
+	.reg_stride = 2,
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
+	struct reset_control *rst;
+	int ret;
+
+	rst = devm_reset_control_get_optional_exclusive(&st->spi->dev, NULL);
+	if (IS_ERR(rst))
+		return PTR_ERR(rst);
+
+	if (rst) {
+		ret = reset_control_deassert(rst);
+		if (ret)
+			return ret;
+	} else {
+		ret = regmap_write(st->regmap_8bit, AD5529R_REG_INTERFACE_CONFIG_A,
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
+	fsleep(10000);
+
+	return regmap_write(st->regmap_8bit, AD5529R_REG_INTERFACE_CONFIG_A,
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
+	int ret, range_idx, span_mv;
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
+		span_mv = ad5529r_output_ranges_mv[range_idx][1] -
+			  ad5529r_output_ranges_mv[range_idx][0];
+		*val = span_mv;
+		*val2 = st->model_data->resolution;
+
+		return IIO_VAL_FRACTIONAL_LOG2;
+	case IIO_CHAN_INFO_OFFSET:
+		range_idx = st->output_range_idx[chan->channel];
+
+		if (ad5529r_output_ranges_mv[range_idx][0] < 0)
+			*val = -(1 << (st->model_data->resolution - 1));
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
+		if (val < 0 || val > GENMASK(st->model_data->resolution - 1, 0))
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
+	for (unsigned int i = 0; i < ARRAY_SIZE(ad5529r_output_ranges_mv); i++) {
+		if (vals[0] == ad5529r_output_ranges_mv[i][0] * 1000 &&
+		    vals[1] == ad5529r_output_ranges_mv[i][1] * 1000)
+			return i;
+	}
+
+	return -EINVAL;
+}
+
+static int ad5529r_parse_channel_ranges(struct device *dev,
+					struct ad5529r_state *st)
+{
+	int ret, range_idx;
+	u32 ch;
+	s32 vals[2];
+
+	device_for_each_child_node_scoped(dev, child) {
+		range_idx = AD5529R_RANGE_0V_5V;
+
+		ret = fwnode_property_read_u32(child, "reg", &ch);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Missing reg property in channel node\n");
+
+		if (ch >= 16)
+			return dev_err_probe(dev, -EINVAL,
+					     "Invalid channel number: %u\n", ch);
+
+		/* Read u32 property into s32 to handle negative voltage ranges */
+		if (!fwnode_property_read_u32_array(child,
+						    "adi,output-range-microvolt",
+						    (u32 *)vals, ARRAY_SIZE(vals))) {
+			range_idx = ad5529r_find_output_range(vals);
+			if (range_idx < 0)
+				return dev_err_probe(dev, range_idx,
+						     "Invalid range [%d %d] for ch %u\n",
+						     vals[0], vals[1], ch);
+		}
+
+		st->output_range_idx[ch] = range_idx;
+		ret = regmap_write(st->regmap_16bit,
+				   AD5529R_REG_OUT_RANGE(ch), range_idx);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to configure range for ch %u\n",
+					     ch);
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
+	struct device *dev = &spi->dev;
+	struct iio_dev *indio_dev;
+	struct ad5529r_state *st;
+	bool external_vref;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+
+	st->spi = spi;
+
+	st->model_data = spi_get_device_match_data(spi);
+	if (!st->model_data)
+		return dev_err_probe(dev, -EINVAL, "Failed to identify device variant\n");
+
+	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(ad5529r_supply_names),
+					     ad5529r_supply_names);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to get and enable regulators\n");
+
+	ret = devm_regulator_get_enable_optional(dev, "hvss");
+	if (ret && ret != -ENODEV)
+		return dev_err_probe(dev, ret,
+				     "Failed to get and enable hvss regulator\n");
+
+	/*
+	 * The datasheet mentions a 4.096V external reference for correct
+	 * operation.
+	 */
+	ret = devm_regulator_get_enable_optional(dev, "vref");
+	if (ret && ret != -ENODEV)
+		return dev_err_probe(dev, ret,
+				     "Failed to get and enable vref regulator\n");
+
+	external_vref = ret != -ENODEV;
+
+	st->regmap_8bit = devm_regmap_init_spi(spi, &ad5529r_regmap_8bit_config);
+	if (IS_ERR(st->regmap_8bit))
+		return dev_err_probe(dev, PTR_ERR(st->regmap_8bit),
+				     "Failed to initialize 8-bit regmap\n");
+
+	st->regmap_16bit = devm_regmap_init_spi(spi, &ad5529r_regmap_16bit_config);
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
+				 external_vref ? 0 : AD5529R_REF_SEL_INTERNAL_REF);
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
+	indio_dev->channels = st->model_data->channels;
+	indio_dev->num_channels = st->model_data->num_channels;
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

