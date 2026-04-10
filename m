Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3122738C423;
	Fri, 10 Apr 2026 06:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775803749; cv=none; b=HW3PZ3C29lMuTSRXKX7TTzFg8rny8ZyOJV8HCePsgcIkdU/NJ3rPytxU49ZqzYHl2at85//xgeqV+2M9KOe8eV0mTr8DTEA8OAYQho0/R80eux7WkNjCuEjkAFSCtPFmNkuYR2GIjX1QRa26cA3zGE7B/Wy9jMjJYDBbFrhKJ9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775803749; c=relaxed/simple;
	bh=ZaAPci24tkdhOHXF2UO9K+wcl7441HxecoTnf/hjSOU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=qeDl5RAY6l/nBFCXjuE4qRI/o81wUc/b4raLAI874r4hylf744NFnLi7ctjuAetyKfOguTUwCOkxIc8M29gDv7HBHhNe15jaUY8RrFGzM/kjhyceLxr0yt5W4nPxnEKsOHyFRgMqS5IK08a9OJP+XV5LbcRzE/c5CP9bLcF+zYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=uOM0blm4; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="uOM0blm4"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63A6IUYK167284;
	Fri, 10 Apr 2026 02:48:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=+bQi+
	fUbok7Dt8a9+itjvCqv7plliW/J97t4vvUBa6Q=; b=uOM0blm4MrLjB+KhprJc6
	OaxNjLPxMFnBE9UGiCLvPTk/UaudstgLFQYzwoJOEJ6Kq55WY+kaY2PHRWI6grBo
	mC2vKBL4UsVfhEFzwpA8xdDcJNulMaembsY9carlBPWwVq2oF8bbvuRHFiG8iNnG
	58xXGnAwiYxveUpV24PXBW38ZYuS1yztalLvAhLPblAn8ynaqaQ4Lmg8QENP7h9Q
	+QPDzXBPcGxQ/jQcKEOYmkYT26y/jyWFePfo7ZmHANdR0P4LDP2LlEW7OJO7qZea
	dP95wqreWMb+BU+qmDl6wSIFvUd7QwzWQgGp4VBVK6gZdRsq9nvqe7WHGTdZrJNS
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4de9a6kya3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Apr 2026 02:48:53 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 63A6mqKC034834
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 10 Apr 2026 02:48:52 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 10 Apr 2026 02:48:51 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 10 Apr 2026 02:48:51 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 10 Apr 2026 02:48:51 -0400
Received: from ATORRENO-L02.ad.analog.com ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 63A6mMJ8020190;
	Fri, 10 Apr 2026 02:48:43 -0400
From: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
Date: Fri, 10 Apr 2026 14:48:17 +0800
Subject: [PATCH v7 2/2] iio: dac: ad5706r: Add support for AD5706R DAC
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260410-dev_ad5706r-v7-2-af93a4caa186@analog.com>
References: <20260410-dev_ad5706r-v7-0-af93a4caa186@analog.com>
In-Reply-To: <20260410-dev_ad5706r-v7-0-af93a4caa186@analog.com>
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
	<conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Alexis Czezar Torreno
	<alexisczezar.torreno@analog.com>,
        Andy Shevchenko
	<andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775803702; l=10805;
 i=alexisczezar.torreno@analog.com; s=20250213; h=from:subject:message-id;
 bh=ZaAPci24tkdhOHXF2UO9K+wcl7441HxecoTnf/hjSOU=;
 b=R4zZv96tlF5YJy963RNokrNufqU1q/42d1yMquY5Jkc75iJWkgiI5URI8jADM34NsEF1L3Vmg
 FyIR8MqRMB1BxobIn74q4772xyOnR5/UAfQwS0ouEyYFRZiUV7LHGKq
X-Developer-Key: i=alexisczezar.torreno@analog.com; a=ed25519;
 pk=XpXmJnRjnsKdDil6YpOlj9+44S+XYXVFnxvkbmaZ+10=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA2MSBTYWx0ZWRfXzZ1nO8MSe2j0
 loaCxUm7REbQDL8QMiczjxsi2oJ24xtYgQ5fQ1P9tXyC76m6R34V8ELl+Aace7vi+iyUrr8QSAP
 rctAj1zgdCGGZHTKb5o3QnAkaX7zuwAfCgJm4Thi9gIp5J+Zw/gRQIyFuGyFb3MRDkmFmltoWPl
 DY71dz2CiVLY36OaSLSfVumaIYXTSUwfXwcHk0UGLPz7q5PACTdY0E7DQaYZxtd/z6rZoKLH8DY
 wzeG2/jZkiqdR4y1raaRLLXDfXGMpvbqinimuodGwcOwleFsDntgoyO+Elwp3ntOdVyMSE4IPyH
 OZBirUJFpTyLCcUH++zDCDdxDNzT+ktuwTLT+EfCnZ/y+xk2dbGmb3JQ8v6yIa2TAjF1nY0cCHH
 Y9fZOXQHEs66mHk2dXOA6SA2372zcwzVLog/zbZhRstLNVs9g4CFjv2vaa6k4KNTVbV1bcdRUpA
 zY6ihmxLCrGkteWfGhg==
X-Proofpoint-GUID: VgC9Fihl5m98FvlqO7CXMD8xKMMczvfI
X-Authority-Analysis: v=2.4 cv=M9F97Sws c=1 sm=1 tr=0 ts=69d89d55 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8
 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=BUK1tddBQIXFRbfSOj8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: VgC9Fihl5m98FvlqO7CXMD8xKMMczvfI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 clxscore=1015 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100061

Add support for the Analog Devices AD5706R, a 4-channel 16-bit
current output digital-to-analog converter with SPI interface.

Features:
  - 4 independent DAC channels
  - Hardware and software LDAC trigger
  - Configurable output range
  - PWM-based LDAC control
  - Dither and toggle modes
  - Dynamically configurable SPI speed

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>

---
Changes in v7:
  - Moved/added size validation before data access in write()/read()

Changes in v6:
  - Added size validation in regmap_write()
  - Used &st->tx_buf[0] consistently _be32/be16 calls
  - Added missing indent in AD5706R_CHAN

Changes in v5:
  - Kconfig: Added select REGMAP_SPI dependency
  - Headers: Removed device.h, errno.h, string.h; added dev_printk.h
  - Use IIO_DMA_MINALIGN instead of ARCH_DMA_MINALIGN
  - Replaced memcpy/memset with put_unaligned_be* for consistency
  - Added struct device *dev shorthand in probe()
  - Added newline to error message
  - Other minor style edits

Changes in v4:
  - Added missing includes
  - Converted to use regmap with custom SPI bus implementation
  - Removed driver-specific mutex/guards in favor of regmap locking
  - Minor style cleanups

Changes in v3:
  - Removed redundant includes, added respective includes of APIs used
  - Simplified bit manipulation in SPI read/write
  - Fixed inconsistent trailing commas in device ID tables
  - Removed zero initialization in spi_device_id

Changes in v2:
  - Removed PWM, GPIO, clock generator, debugfs, regmap, IIO_BUFFER
  - Removed all custom ext_info sysfs attributes
  - Simplified to basic raw read/write and read-only scale
  - SPI read/write can handle multibyte registers
---
---
 MAINTAINERS               |   1 +
 drivers/iio/dac/Kconfig   |  11 ++
 drivers/iio/dac/Makefile  |   1 +
 drivers/iio/dac/ad5706r.c | 253 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 266 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 17a3d2d45fccb9cd3c93fd35666fb85d17d53cde..3d7bd98b4d1b55836e40687a9a3ac9f4935a8acb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1502,6 +1502,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/dac/adi,ad5706r.yaml
+F:	drivers/iio/dac/ad5706r.c
 
 ANALOG DEVICES INC AD7091R DRIVER
 M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index db9f5c711b3df90641f017652fbbef594cc1627d..a5a328818233e3d019cddaee369dd5b7b1529031 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -178,6 +178,17 @@ config AD5624R_SPI
 	  Say yes here to build support for Analog Devices AD5624R, AD5644R and
 	  AD5664R converters (DAC). This driver uses the common SPI interface.
 
+config AD5706R
+	tristate "Analog Devices AD5706R DAC driver"
+	depends on SPI
+	select REGMAP_SPI
+	help
+	  Say yes here to build support for Analog Devices AD5706R 4-channel,
+	  16-bit current output DAC.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ad5706r.
+
 config AD9739A
 	tristate "Analog Devices AD9739A RF DAC spi driver"
 	depends on SPI
diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index 2a80bbf4e80ad557da79ed916027cedff286984b..0034317984985035f7987a744899924bfd4612e3 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_AD5449) += ad5449.o
 obj-$(CONFIG_AD5592R_BASE) += ad5592r-base.o
 obj-$(CONFIG_AD5592R) += ad5592r.o
 obj-$(CONFIG_AD5593R) += ad5593r.o
+obj-$(CONFIG_AD5706R) += ad5706r.o
 obj-$(CONFIG_AD5755) += ad5755.o
 obj-$(CONFIG_AD5758) += ad5758.o
 obj-$(CONFIG_AD5761) += ad5761.o
diff --git a/drivers/iio/dac/ad5706r.c b/drivers/iio/dac/ad5706r.c
new file mode 100644
index 0000000000000000000000000000000000000000..026f871ce121cd63331b2a34da8879491b2d0f3c
--- /dev/null
+++ b/drivers/iio/dac/ad5706r.c
@@ -0,0 +1,253 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * AD5706R 16-bit Current Output Digital to Analog Converter
+ *
+ * Copyright 2026 Analog Devices Inc.
+ */
+
+#include <linux/array_size.h>
+#include <linux/bits.h>
+#include <linux/dev_printk.h>
+#include <linux/err.h>
+#include <linux/iio/iio.h>
+#include <linux/minmax.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+#include <linux/types.h>
+#include <linux/unaligned.h>
+
+/* SPI frame layout */
+#define AD5706R_RD_MASK			BIT(15)
+#define AD5706R_ADDR_MASK		GENMASK(11, 0)
+
+/* Registers */
+#define AD5706R_REG_DAC_INPUT_A_CH(x)		(0x60 + ((x) * 2))
+#define AD5706R_REG_DAC_DATA_READBACK_CH(x)	(0x68 + ((x) * 2))
+
+#define AD5706R_DAC_RESOLUTION		16
+#define AD5706R_DAC_MAX_CODE		BIT(16)
+#define AD5706R_MULTIBYTE_REG_START	0x14
+#define AD5706R_MULTIBYTE_REG_END	0x71
+#define AD5706R_MAX_REG			0x77
+#define AD5706R_SINGLE_BYTE_LEN		1
+#define AD5706R_DOUBLE_BYTE_LEN		2
+
+struct ad5706r_state {
+	struct spi_device *spi;
+	struct regmap *regmap;
+
+	u8 tx_buf[4] __aligned(IIO_DMA_MINALIGN);
+	u8 rx_buf[4];
+};
+
+static int ad5706r_reg_len(unsigned int reg)
+{
+	if (reg >= AD5706R_MULTIBYTE_REG_START && reg <= AD5706R_MULTIBYTE_REG_END)
+		return AD5706R_DOUBLE_BYTE_LEN;
+
+	return AD5706R_SINGLE_BYTE_LEN;
+}
+
+static int ad5706r_regmap_write(void *context, const void *data, size_t count)
+{
+	struct ad5706r_state *st = context;
+	unsigned int num_bytes, val;
+	u16 reg;
+
+	if (count != 4)
+		return -EINVAL;
+
+	reg = get_unaligned_be16(data);
+	num_bytes = ad5706r_reg_len(reg);
+
+	struct spi_transfer xfer = {
+		.tx_buf = st->tx_buf,
+		.len = num_bytes + 2,
+	};
+
+	val = get_unaligned_be32(data);
+	put_unaligned_be32(val, &st->tx_buf[0]);
+
+	/* For single byte, copy the data to the correct position */
+	if (num_bytes == AD5706R_SINGLE_BYTE_LEN)
+		st->tx_buf[2] = st->tx_buf[3];
+
+	return spi_sync_transfer(st->spi, &xfer, 1);
+}
+
+static int ad5706r_regmap_read(void *context, const void *reg_buf,
+			       size_t reg_size, void *val_buf, size_t val_size)
+{
+	struct ad5706r_state *st = context;
+	unsigned int num_bytes;
+	u16 reg, cmd, val;
+	int ret;
+
+	if (reg_size != 2 || val_size != 2)
+		return -EINVAL;
+
+	reg = get_unaligned_be16(reg_buf);
+	num_bytes = ad5706r_reg_len(reg);
+
+	/* Full duplex, device responds immediately after command */
+	struct spi_transfer xfer = {
+		.tx_buf = st->tx_buf,
+		.rx_buf = st->rx_buf,
+		.len = 2 + num_bytes,
+	};
+
+	cmd = AD5706R_RD_MASK | (reg & AD5706R_ADDR_MASK);
+	put_unaligned_be16(cmd, &st->tx_buf[0]);
+	put_unaligned_be16(0, &st->tx_buf[2]);
+
+	ret = spi_sync_transfer(st->spi, &xfer, 1);
+	if (ret)
+		return ret;
+
+	/* Extract value from response (skip 2-byte command echo) */
+	if (num_bytes == AD5706R_SINGLE_BYTE_LEN)
+		val = st->rx_buf[2];
+	else if (num_bytes == AD5706R_DOUBLE_BYTE_LEN)
+		val = get_unaligned_be16(&st->rx_buf[2]);
+	else
+		return -EINVAL;
+
+	put_unaligned_be16(val, val_buf);
+
+	return 0;
+}
+
+static int ad5706r_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)
+{
+	struct ad5706r_state *st = iio_priv(indio_dev);
+	unsigned int reg, reg_val;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		reg = AD5706R_REG_DAC_DATA_READBACK_CH(chan->channel);
+		ret = regmap_read(st->regmap, reg, &reg_val);
+		if (ret)
+			return ret;
+
+		*val = reg_val;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = 50;
+		*val2 = AD5706R_DAC_RESOLUTION;
+		return IIO_VAL_FRACTIONAL_LOG2;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad5706r_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
+{
+	struct ad5706r_state *st = iio_priv(indio_dev);
+	unsigned int reg;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (!in_range(val, 0, AD5706R_DAC_MAX_CODE))
+			return -EINVAL;
+
+		reg = AD5706R_REG_DAC_INPUT_A_CH(chan->channel);
+		return regmap_write(st->regmap, reg, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct regmap_bus ad5706r_regmap_bus = {
+	.write = ad5706r_regmap_write,
+	.read = ad5706r_regmap_read,
+	.reg_format_endian_default = REGMAP_ENDIAN_BIG,
+	.val_format_endian_default = REGMAP_ENDIAN_BIG,
+};
+
+static const struct regmap_config ad5706r_regmap_config = {
+	.reg_bits = 16,
+	.val_bits = 16,
+	.max_register = AD5706R_MAX_REG,
+};
+
+static const struct iio_info ad5706r_info = {
+	.read_raw = ad5706r_read_raw,
+	.write_raw = ad5706r_write_raw,
+};
+
+#define AD5706R_CHAN(_channel) {				\
+	.type = IIO_CURRENT,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
+			      BIT(IIO_CHAN_INFO_SCALE),		\
+	.output = 1,						\
+	.indexed = 1,						\
+	.channel = _channel,					\
+}
+
+static const struct iio_chan_spec ad5706r_channels[] = {
+	AD5706R_CHAN(0),
+	AD5706R_CHAN(1),
+	AD5706R_CHAN(2),
+	AD5706R_CHAN(3),
+};
+
+static int ad5706r_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	struct iio_dev *indio_dev;
+	struct ad5706r_state *st;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	st->spi = spi;
+
+	st->regmap = devm_regmap_init(dev, &ad5706r_regmap_bus,
+				      st, &ad5706r_regmap_config);
+	if (IS_ERR(st->regmap))
+		return dev_err_probe(dev, PTR_ERR(st->regmap),
+				     "Failed to init regmap\n");
+
+	indio_dev->name = "ad5706r";
+	indio_dev->info = &ad5706r_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = ad5706r_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ad5706r_channels);
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct of_device_id ad5706r_of_match[] = {
+	{ .compatible = "adi,ad5706r" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad5706r_of_match);
+
+static const struct spi_device_id ad5706r_id[] = {
+	{ "ad5706r" },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, ad5706r_id);
+
+static struct spi_driver ad5706r_driver = {
+	.driver = {
+		.name = "ad5706r",
+		.of_match_table = ad5706r_of_match,
+	},
+	.probe = ad5706r_probe,
+	.id_table = ad5706r_id,
+};
+module_spi_driver(ad5706r_driver);
+
+MODULE_AUTHOR("Alexis Czezar Torreno <alexisczezar.torreno@analog.com>");
+MODULE_DESCRIPTION("AD5706R 16-bit Current Output DAC driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1

