Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D296D3B14A4;
	Thu, 16 Jul 2026 21:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784236202; cv=none; b=J1krO8deYq5NUAa+lnzmJyvVhw4qaEcGcAlGcSIdO2HC4gylgoO/ihs6zOjyYfjWYyd5WNDPc8oPEWnPfpz5Mn3mEV/gaFNPRwnlDMZ7UvSqyYh6WV/SN5iapGvGG6yIa77iE3ocvhzqBaTRgxTEUNIOymK2owhV3mDcYOebCMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784236202; c=relaxed/simple;
	bh=Z2ROn6OuTw6OP8hgYw0RHfsPXCalI3jCntLGaQKbuh0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c/UdbV5dQki2vW47gcrThhLgYw08ileo/iG7VYWTLOrU0hKiKk6kmVzl5KY5LGJy2GPiaZOE4xSBJDZqWSX9Ymb19JsLWdaK2uefNAGrdpp5W7LCXawp7MWlE6KwxCM/UkZFSiJ7DDqaBnHGALNXBLgf+PF+0joa2C0ixmeFm/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=dZ7zCBu3; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="dZ7zCBu3"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GJqmf7116554;
	Thu, 16 Jul 2026 17:09:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=cq7+Y
	4WeIDWOyRYgq8e2mYS4Sw6ZdvFq3NjEnG8XrJc=; b=dZ7zCBu3tMx1U7vaulJwB
	HQJbqNtu5vd+7C3C2a3SowXrv0k7ygPDSdu9gfIXg/jHJzlvP79KuraXjDS/mmKB
	cnebKRPGP88CsYsQnY0R8VcKajEWjvUii0Zb5WiC9HWwddGOAWOT/2WYG4WziaUp
	2XW2XQQrZhcyEatLRxHkCZ6jwcONXBzXd2JTE9Bzl/PxOqbXLr7qHS6voCUI3Ufz
	7qagdWnR/dIeDPh+zSWZCfgHFZSUElXh8AhdH8ZOUDUl5mW8WfSY8+ioeOV129Nh
	jCYQhnxoUmh1k8rOKVv161k4Yy4nqHZKTNkn7GH7DqAqjX2jyNxhDyvrAWtbEfqT
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4ff005snta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 17:09:54 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66GL9rHE004277
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 16 Jul 2026 17:09:53 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 16 Jul 2026 17:09:53 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 16 Jul 2026 17:09:53 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 16 Jul 2026 17:09:53 -0400
Received: from work.maxim-ic.internal ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66GL9fRr004876;
	Thu, 16 Jul 2026 17:09:44 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <andy@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <julianbraha@gmail.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v7 2/4] iio: adc: ltc2378: Add support for LTC2378-20 and similar ADCs
Date: Thu, 16 Jul 2026 18:09:36 -0300
Message-ID: <5108c89986ae8723139419058db1b2f2e74daff6.1784235595.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1784235595.git.marcelo.schmitt@analog.com>
References: <cover.1784235595.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: AJWrQxaanLZ_jgGt_IvLCL55EV4ic3fk
X-Proofpoint-GUID: AJWrQxaanLZ_jgGt_IvLCL55EV4ic3fk
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDIxNiBTYWx0ZWRfX1n6haCLsmQZs
 fN6WyLFmCt4qIcrjqR/EqO17CgXm5YCLA13B0IZA4n5nw3oYC9kQy4LhsGru+Hq61ALI0hBUcpw
 r2EPoQTMc6elSbRdIy/4EFmDR3q24IavmWH2SqRKxlPSHCI+DkyK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDIxNiBTYWx0ZWRfXyp6ffrShfVyJ
 bUeSezMHaQUAkcMHwb5zBZsT/eYgRRp2UwaBYReeQRvzc/gB1qad/nMPNMgd5+UsuIQgHSW/ppf
 71+KaopKaV0IVbujZ1dwwewscwsOZlw8sbFoA6Bm6mRtZEN6dgG2WYAf4r2WXSaPKj5rodrzBlW
 0IPjqjJOWDSzWKjKH9DP2tS+uROpmuwRJrhliEl6XJJ7A/kRxnIcgv6JJyJkhodNtzSGdXLFYcj
 NRtaXAHBYT1J2X2FGKgOO7Md+Qr2mzLgHLAAzEgx1gti7U74IyO9ZZljFuO/M+FxV14LAzWB2ez
 bBuVmxoYxl0e/brLIdeqFJGhwzFS4jQC3LmF7SCRZNQPZJdF+lkJsBVYLhP05qd2uCRdNbk+uMt
 XrelVHJFdw+3l3NHoIx/m/n6mg8Mq/0ydys5AOTWrF1bMaxiMGURQrXUzMIJlWIOq2SGgEAJVIx
 2pw8PE+Hgg6aYnltu7w==
X-Authority-Analysis: v=2.4 cv=ceziaHDM c=1 sm=1 tr=0 ts=6a5948a2 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8 a=VwQbUJbxAAAA:8
 a=ZZGAMBLAlkmGxc5ICUcA:9 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_07,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 adultscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160216

Support for LTC2378-20 and similar analog-to-digital converters.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v6 -> v7:
- Extended single-read critical section scope (holding mutex lock longer).
- Added comment about conversion wait time.
- When applicable, return early from regulator setup.
- Wrapped transfer buffer declaration comment closer to 80 characters.

Some bits related to the SPI transfer buffer are introduced early to minimize
the change diff of the followup offload enablement patch.

 MAINTAINERS               |   1 +
 drivers/iio/adc/Kconfig   |  12 ++
 drivers/iio/adc/Makefile  |   1 +
 drivers/iio/adc/ltc2378.c | 416 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 430 insertions(+)
 create mode 100644 drivers/iio/adc/ltc2378.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f0ae26699c99..25821b771692 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15349,6 +15349,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ltc2378.yaml
+F:	drivers/iio/adc/ltc2378.c
 
 LTC2664 IIO DAC DRIVER
 M:	Michael Hennerich <michael.hennerich@analog.com>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index d1b198cb8a80..220c6739a8f2 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -943,6 +943,18 @@ config LTC2309
 	  This driver can also be built as a module. If so, the module will
 	  be called ltc2309.
 
+config LTC2378
+	tristate "Analog Devices LTC2378 ADC driver"
+	depends on SPI
+	depends on REGULATOR || COMPILE_TEST
+	depends on GPIOLIB
+	help
+	  Say yes here to build support for Analog Devices LTC2378-20 and
+	  similar analog to digital converters.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called ltc2378.
+
 config LTC2471
 	tristate "Linear Technology LTC2471 and LTC2473 ADC driver"
 	depends on I2C
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 0f90b75577ff..6058a8be6ccd 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -81,6 +81,7 @@ obj-$(CONFIG_LP8788_ADC) += lp8788_adc.o
 obj-$(CONFIG_LPC18XX_ADC) += lpc18xx_adc.o
 obj-$(CONFIG_LPC32XX_ADC) += lpc32xx_adc.o
 obj-$(CONFIG_LTC2309) += ltc2309.o
+obj-$(CONFIG_LTC2378) += ltc2378.o
 obj-$(CONFIG_LTC2471) += ltc2471.o
 obj-$(CONFIG_LTC2485) += ltc2485.o
 obj-$(CONFIG_LTC2496) += ltc2496.o ltc2497-core.o
diff --git a/drivers/iio/adc/ltc2378.c b/drivers/iio/adc/ltc2378.c
new file mode 100644
index 000000000000..5600c820c7f4
--- /dev/null
+++ b/drivers/iio/adc/ltc2378.c
@@ -0,0 +1,416 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Analog Devices LTC2378 ADC series driver
+ *
+ * Copyright (C) 2026 Analog Devices Inc.
+ * Author: Marcelo Schmitt <marcelo.schmitt@analog.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/bits.h>
+#include <linux/byteorder/generic.h>
+#include <linux/cleanup.h>
+#include <linux/device.h>
+#include <linux/delay.h>
+#include <linux/device-id/spi.h>
+#include <linux/device-id/of.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+#include <linux/types.h>
+#include <linux/units.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/types.h>
+
+#define LTC2378_MAX_DATA_WAIT_US	4 /* max(TBUSYLH + TCONV + TDSDOBUSYL) */
+
+#define LTC2378_DIFF_CHANNEL(_sign, _real_bits, _storage_bits)			\
+{										\
+	.type = IIO_VOLTAGE,							\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |				\
+			      BIT(IIO_CHAN_INFO_SCALE),				\
+	.scan_index = 0,							\
+	.scan_type = {								\
+		.format = _sign ? IIO_SCAN_FORMAT_SIGNED_INT :			\
+				  IIO_SCAN_FORMAT_UNSIGNED_INT,			\
+		.realbits = _real_bits,						\
+		.storagebits = _storage_bits,					\
+		.shift = _storage_bits - _real_bits,				\
+		.endianness = IIO_BE,						\
+	},									\
+}
+
+#define LTC2378_BIPOLAR_DIFF_CHANNEL(_real_bits)				\
+	LTC2378_DIFF_CHANNEL(1, _real_bits, (((_real_bits) > 16) ? 32 : 16))
+
+#define LTC2378_UNIPOLAR_DIFF_CHANNEL(_real_bits)				\
+	LTC2378_DIFF_CHANNEL(0, _real_bits, (((_real_bits) > 16) ? 32 : 16))
+
+struct ltc2378_chip_info {
+	const char *name;
+	unsigned int internal_ref_uV;
+	struct iio_chan_spec chan;
+};
+
+struct ltc2378_state {
+	const struct ltc2378_chip_info *info;
+	struct gpio_desc *cnv_gpio;
+	struct spi_device *spi;
+	struct mutex lock; /* Protect data acquisition cycle */
+	int ref_uV;
+	struct spi_transfer xfer;
+
+	/*
+	 * DMA (thus cache coherency maintenance) requires the transfer buffers
+	 * to live in their own cache lines.
+	 */
+	struct {
+		union {
+			__be16 sample_buf16_be;
+			__be32 sample_buf32_be;
+			u16 sample_buf16;
+			u32 sample_buf32;
+		} data;
+		aligned_s64 timestamp;
+	} scan __aligned(IIO_DMA_MINALIGN);
+};
+
+static const struct ltc2378_chip_info ltc2338_18_chip_info = {
+	.name = "ltc2338-18",
+	.internal_ref_uV = 2048000,
+	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(18),
+};
+
+static const struct ltc2378_chip_info ltc2364_16_chip_info = {
+	.name = "ltc2364-16",
+	.chan = LTC2378_UNIPOLAR_DIFF_CHANNEL(16),
+};
+
+static const struct ltc2378_chip_info ltc2364_18_chip_info = {
+	.name = "ltc2364-18",
+	.chan = LTC2378_UNIPOLAR_DIFF_CHANNEL(18),
+};
+
+static const struct ltc2378_chip_info ltc2367_16_chip_info = {
+	.name = "ltc2367-16",
+	.chan = LTC2378_UNIPOLAR_DIFF_CHANNEL(16),
+};
+
+static const struct ltc2378_chip_info ltc2367_18_chip_info = {
+	.name = "ltc2367-18",
+	.chan = LTC2378_UNIPOLAR_DIFF_CHANNEL(18),
+};
+
+static const struct ltc2378_chip_info ltc2368_16_chip_info = {
+	.name = "ltc2368-16",
+	.chan = LTC2378_UNIPOLAR_DIFF_CHANNEL(16),
+};
+
+static const struct ltc2378_chip_info ltc2368_18_chip_info = {
+	.name = "ltc2368-18",
+	.chan = LTC2378_UNIPOLAR_DIFF_CHANNEL(18),
+};
+
+static const struct ltc2378_chip_info ltc2369_18_chip_info = {
+	.name = "ltc2369-18",
+	.chan = LTC2378_UNIPOLAR_DIFF_CHANNEL(18),
+};
+
+static const struct ltc2378_chip_info ltc2370_16_chip_info = {
+	.name = "ltc2370-16",
+	.chan = LTC2378_UNIPOLAR_DIFF_CHANNEL(16),
+};
+
+static const struct ltc2378_chip_info ltc2376_16_chip_info = {
+	.name = "ltc2376-16",
+	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(16),
+};
+
+static const struct ltc2378_chip_info ltc2376_18_chip_info = {
+	.name = "ltc2376-18",
+	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(18),
+};
+
+static const struct ltc2378_chip_info ltc2376_20_chip_info = {
+	.name = "ltc2376-20",
+	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(20),
+};
+
+static const struct ltc2378_chip_info ltc2377_16_chip_info = {
+	.name = "ltc2377-16",
+	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(16),
+};
+
+static const struct ltc2378_chip_info ltc2377_18_chip_info = {
+	.name = "ltc2377-18",
+	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(18),
+};
+
+static const struct ltc2378_chip_info ltc2377_20_chip_info = {
+	.name = "ltc2377-20",
+	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(20),
+};
+
+static const struct ltc2378_chip_info ltc2378_16_chip_info = {
+	.name = "ltc2378-16",
+	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(16),
+};
+
+static const struct ltc2378_chip_info ltc2378_18_chip_info = {
+	.name = "ltc2378-18",
+	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(18),
+};
+
+static const struct ltc2378_chip_info ltc2378_20_chip_info = {
+	.name = "ltc2378-20",
+	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(20),
+};
+
+static const struct ltc2378_chip_info ltc2379_18_chip_info = {
+	.name = "ltc2379-18",
+	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(18),
+};
+
+static const struct ltc2378_chip_info ltc2380_16_chip_info = {
+	.name = "ltc2380-16",
+	.chan = LTC2378_BIPOLAR_DIFF_CHANNEL(16),
+};
+
+static int ltc2378_convert_and_acquire(struct ltc2378_state *st)
+{
+	int ret;
+
+	/* Cause a rising edge of CNV to initiate a new ADC conversion */
+	gpiod_set_value_cansleep(st->cnv_gpio, 1);
+	fsleep(LTC2378_MAX_DATA_WAIT_US);
+	ret = spi_sync_transfer(st->spi, &st->xfer, 1);
+	gpiod_set_value_cansleep(st->cnv_gpio, 0);
+
+	return ret;
+}
+
+static int ltc2378_channel_single_read(const struct iio_chan_spec *chan,
+				       struct ltc2378_state *st, int *val)
+{
+	const struct iio_scan_type *scan_type = &chan->scan_type;
+	u32 sample;
+	int ret;
+
+	guard(mutex)(&st->lock);
+	ret = ltc2378_convert_and_acquire(st);
+	if (ret)
+		return ret;
+
+	if (chan->scan_type.endianness == IIO_BE) {
+		if (chan->scan_type.realbits > 16)
+			sample = be32_to_cpu(st->scan.data.sample_buf32_be);
+		else
+			sample = be16_to_cpu(st->scan.data.sample_buf16_be);
+	} else { /* IIO_CPU */
+		if (chan->scan_type.realbits > 16)
+			sample = st->scan.data.sample_buf32;
+		else
+			sample = st->scan.data.sample_buf16;
+	}
+
+	sample >>= chan->scan_type.shift;
+
+	if (scan_type->format == IIO_SCAN_FORMAT_SIGNED_INT)
+		*val = sign_extend32(sample, scan_type->realbits - 1);
+	else
+		*val = sample;
+
+	return 0;
+}
+
+static int ltc2378_read_raw(struct iio_dev *indio_dev,
+			    const struct iio_chan_spec *chan,
+			    int *val, int *val2, long mask)
+{
+	struct ltc2378_state *st = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW: {
+		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+		if (IIO_DEV_ACQUIRE_FAILED(claim))
+			return -EBUSY;
+
+		ret = ltc2378_channel_single_read(chan, st, val);
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT;
+	}
+	case IIO_CHAN_INFO_SCALE:
+		*val = st->ref_uV / MILLI;
+		/*
+		 * For all LTC2378-like devices, the amount of bits that express
+		 * voltage magnitude depend on the polarity / output code format:
+		 * - straight binary: All precision/resolution bits are used.
+		 * - 2's complement: One of the precision bits is used for sign.
+		 */
+		if (chan->scan_type.format == IIO_SCAN_FORMAT_SIGNED_INT)
+			*val2 = chan->scan_type.realbits - 1;
+		else
+			*val2 = chan->scan_type.realbits;
+
+		return IIO_VAL_FRACTIONAL_LOG2;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info ltc2378_iio_info = {
+	.read_raw = &ltc2378_read_raw,
+};
+
+static int ltc2378_refin_setup(struct device *dev, struct ltc2378_state *st)
+{
+	int ret;
+
+	/*
+	 * The internal reference buffer amplifies both the internal reference
+	 * and REFIN by a factor of 2.
+	 */
+	ret = devm_regulator_get_enable_read_voltage(dev, "refin");
+	if (ret == -ENODEV) { /* refin is optional */
+		st->ref_uV = st->info->internal_ref_uV * 2;
+		return 0;
+	} else if (ret < 0) {
+		return dev_err_probe(dev, ret, "failed to read refin regulator\n");
+	}
+
+	st->ref_uV = ret * 2;
+
+	return 0;
+}
+
+static int ltc2378_ref_setup(struct device *dev, struct ltc2378_state *st)
+{
+	int ret;
+
+	ret = devm_regulator_get_enable_read_voltage(dev, "ref");
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to read ref regulator\n");
+
+	st->ref_uV = ret;
+
+	return 0;
+}
+
+static int ltc2378_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	struct iio_dev *indio_dev;
+	struct ltc2378_state *st;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	st->spi = spi;
+
+	ret = devm_mutex_init(dev, &st->lock);
+	if (ret)
+		return ret;
+
+	st->info = spi_get_device_match_data(spi);
+	if (!st->info)
+		return -EINVAL;
+
+	if (st->info->internal_ref_uV)
+		ret = ltc2378_refin_setup(dev, st);
+	else
+		ret = ltc2378_ref_setup(dev, st);
+	if (ret)
+		return ret;
+
+	indio_dev->name = st->info->name;
+	indio_dev->info = &ltc2378_iio_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	st->cnv_gpio = devm_gpiod_get(dev, "cnv", GPIOD_OUT_LOW);
+	if (IS_ERR(st->cnv_gpio))
+		return dev_err_probe(dev, PTR_ERR(st->cnv_gpio),
+				     "failed to get CNV GPIO");
+
+	indio_dev->channels = &st->info->chan;
+	indio_dev->num_channels = 1;
+
+	st->xfer.rx_buf = &st->scan.data;
+	st->xfer.len = spi_bpw_to_bytes(indio_dev->channels[0].scan_type.realbits);
+
+	return devm_iio_device_register(&spi->dev, indio_dev);
+}
+
+static const struct of_device_id ltc2378_of_match[] = {
+	{ .compatible = "adi,ltc2338-18", .data = &ltc2338_18_chip_info },
+	{ .compatible = "adi,ltc2364-16", .data = &ltc2364_16_chip_info },
+	{ .compatible = "adi,ltc2364-18", .data = &ltc2364_18_chip_info },
+	{ .compatible = "adi,ltc2367-16", .data = &ltc2367_16_chip_info },
+	{ .compatible = "adi,ltc2367-18", .data = &ltc2367_18_chip_info },
+	{ .compatible = "adi,ltc2368-16", .data = &ltc2368_16_chip_info },
+	{ .compatible = "adi,ltc2368-18", .data = &ltc2368_18_chip_info },
+	{ .compatible = "adi,ltc2369-18", .data = &ltc2369_18_chip_info },
+	{ .compatible = "adi,ltc2370-16", .data = &ltc2370_16_chip_info },
+	{ .compatible = "adi,ltc2376-16", .data = &ltc2376_16_chip_info },
+	{ .compatible = "adi,ltc2376-18", .data = &ltc2376_18_chip_info },
+	{ .compatible = "adi,ltc2376-20", .data = &ltc2376_20_chip_info },
+	{ .compatible = "adi,ltc2377-16", .data = &ltc2377_16_chip_info },
+	{ .compatible = "adi,ltc2377-18", .data = &ltc2377_18_chip_info },
+	{ .compatible = "adi,ltc2377-20", .data = &ltc2377_20_chip_info },
+	{ .compatible = "adi,ltc2378-16", .data = &ltc2378_16_chip_info },
+	{ .compatible = "adi,ltc2378-18", .data = &ltc2378_18_chip_info },
+	{ .compatible = "adi,ltc2378-20", .data = &ltc2378_20_chip_info },
+	{ .compatible = "adi,ltc2379-18", .data = &ltc2379_18_chip_info },
+	{ .compatible = "adi,ltc2380-16", .data = &ltc2380_16_chip_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ltc2378_of_match);
+
+static const struct spi_device_id ltc2378_spi_id[] = {
+	{ .name = "ltc2338-18", .driver_data = (kernel_ulong_t)&ltc2338_18_chip_info },
+	{ .name = "ltc2364-16", .driver_data = (kernel_ulong_t)&ltc2364_16_chip_info },
+	{ .name = "ltc2364-18", .driver_data = (kernel_ulong_t)&ltc2364_18_chip_info },
+	{ .name = "ltc2367-16", .driver_data = (kernel_ulong_t)&ltc2367_16_chip_info },
+	{ .name = "ltc2367-18", .driver_data = (kernel_ulong_t)&ltc2367_18_chip_info },
+	{ .name = "ltc2368-16", .driver_data = (kernel_ulong_t)&ltc2368_16_chip_info },
+	{ .name = "ltc2368-18", .driver_data = (kernel_ulong_t)&ltc2368_18_chip_info },
+	{ .name = "ltc2369-18", .driver_data = (kernel_ulong_t)&ltc2369_18_chip_info },
+	{ .name = "ltc2370-16", .driver_data = (kernel_ulong_t)&ltc2370_16_chip_info },
+	{ .name = "ltc2376-16", .driver_data = (kernel_ulong_t)&ltc2376_16_chip_info },
+	{ .name = "ltc2376-18", .driver_data = (kernel_ulong_t)&ltc2376_18_chip_info },
+	{ .name = "ltc2376-20", .driver_data = (kernel_ulong_t)&ltc2376_20_chip_info },
+	{ .name = "ltc2377-16", .driver_data = (kernel_ulong_t)&ltc2377_16_chip_info },
+	{ .name = "ltc2377-18", .driver_data = (kernel_ulong_t)&ltc2377_18_chip_info },
+	{ .name = "ltc2377-20", .driver_data = (kernel_ulong_t)&ltc2377_20_chip_info },
+	{ .name = "ltc2378-16", .driver_data = (kernel_ulong_t)&ltc2378_16_chip_info },
+	{ .name = "ltc2378-18", .driver_data = (kernel_ulong_t)&ltc2378_18_chip_info },
+	{ .name = "ltc2378-20", .driver_data = (kernel_ulong_t)&ltc2378_20_chip_info },
+	{ .name = "ltc2379-18", .driver_data = (kernel_ulong_t)&ltc2379_18_chip_info },
+	{ .name = "ltc2380-16", .driver_data = (kernel_ulong_t)&ltc2380_16_chip_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, ltc2378_spi_id);
+
+static struct spi_driver ltc2378_driver = {
+	.driver = {
+		.name = "ltc2378",
+		.of_match_table = ltc2378_of_match
+	},
+	.probe = ltc2378_probe,
+	.id_table = ltc2378_spi_id,
+};
+module_spi_driver(ltc2378_driver);
+
+MODULE_AUTHOR("Marcelo Schmitt <marcelo.schmitt@analog.com>");
+MODULE_DESCRIPTION("Analog Devices LTC2378 ADC series driver");
+MODULE_LICENSE("GPL");
-- 
2.53.0

