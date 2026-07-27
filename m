Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A69742D775;
	Mon, 27 Jul 2026 21:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785187883; cv=none; b=Vs5AzkLhagmQEMM5EYFbnLnLkp2hB0RTjHWjcbrC03H5nGCYkjniAgctLnooT5q5NnyD42eGlvB8Tk02FwQfvyygFUAapnZ5+NJ3JdBFFhxy/7Bn8uTBADqerewAv+9axv2L2fwrYk9rh6BkHWpyJq1MuMAIShha6jqDZo4XBcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785187883; c=relaxed/simple;
	bh=k7uKxBjPlPp8BqwJ4hm6ARu9uYXeUMU1yoOH1LJ6PR0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W1P2tZi0UdFTYpV6WjtJ+PYQKHWY2APz92rCTvY7v1sTTgbkQn+RCilrdKjOM+0Qt0bUkfhFznBaL+KvqFGLn2abMGGTBiAysbdSK8NSZpBrBymm44wOSvoCA3tC8UU8Pj/2fstrKfy9E4clE5/zsXEhXcxoQUi1BX1Cr1ui3/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=v7lKigWH; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="v7lKigWH"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RIHHmX1004674;
	Mon, 27 Jul 2026 17:31:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=PQFhx
	zX1zY18ETSBNISzTHBWuK0e77FY2mWx9Qo5tCg=; b=v7lKigWH7F/eFWtzg9xgf
	Lkf56660+URut5gUm9EcEtV1yWQlgZ3x099TqvN+4qMXP1SdgQK2iwWkHrEx5QQO
	Z9sJYeGcPesBmHQsLgnG9YFHgWx330rJyVyYdamHnxfFoJAsPO1JhjyT5zPjxrCD
	ss+erSY5sXUz2mvXM0Gm6Ug7tFJYOMohfV1bmdjU9ieS1cS7AVdNj6QSYzg5oLPz
	Qq5ZGn/iuF386ihljFLy+Qz9OAnClA92Y2aJgxnWsCrvhkRnGtAi2Z9CL28EQWJ/
	oWw6yyGaFLSKom9YDWAlOHLD5Ly4BIWd5/Ll88kf90N+jhiDkGgRREVh2EUSUyZI
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fmt21sdnf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 17:31:14 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66RLVD4D003959
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 Jul 2026 17:31:13 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 27 Jul 2026 17:31:13 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 27 Jul 2026 17:31:13 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 27 Jul 2026 17:31:13 -0400
Received: from work.maxim-ic.internal ([10.66.6.190])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66RLUxr5017460;
	Mon, 27 Jul 2026 17:31:02 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <andy@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <julianbraha@gmail.com>,
        <marcelo.schmitt1@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v9 2/6] iio: adc: ltc2378: Add support for LTC2378-20 and similar ADCs
Date: Mon, 27 Jul 2026 18:30:54 -0300
Message-ID: <6cf0b5541cce4816877ebe754ef7fc2f0e30039c.1785186980.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1785186980.git.marcelo.schmitt@analog.com>
References: <cover.1785186980.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=TLh1jVla c=1 sm=1 tr=0 ts=6a67ce22 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=QyXUC8HyAAAA:8 a=IpJZQVW2AAAA:8
 a=VwQbUJbxAAAA:8 a=ir6pry_9mBCdi5gbn5AA:9 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: EJ8EdxKbk1EP6LqjCGMdFBqnWR0jjRAS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE5MyBTYWx0ZWRfX4bYVPhPw0/OC
 vFiVnjpDQvYgKkZz++tpMvT9myyAoKXJ/CoYd2eDQPoiABIyDqDiyNT9uxZsYmy+fhTGKpb2zBG
 dV9PWv4/iHYd6ov5/R+wCXTvyorMy9O35UiNlt4/6mHf68v+oHK8
X-Proofpoint-ORIG-GUID: EJ8EdxKbk1EP6LqjCGMdFBqnWR0jjRAS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE5MyBTYWx0ZWRfXz0/AqsEo+kLF
 v6J5OoZkRmN915BI4GIVE+TpYeTcIn3p1+WUeF7BiaGNHIlVQCplQel9KE9DNB2p5F3C+zlCVPg
 kogsZnrqb0mDvsh+rc1ELlAhezlM52Gg/2HY+lFoFDA6lgKaHHu9Gihjf1Ds6520StwuxQ73ThI
 YbIZLOV8TWY19d4nf7hd9nTiHNeHfm7wbWWyyrR1qj1VLbuNd36/dWHX+SGb6RKPujRGUiHY2FP
 ME/UfsY/CyZiPA8ocUz7KY40/uIBJxBGyQMEISPq6QJAHkyumbfO77cRZb4/NV0TC5y5ilHgzFM
 5Rdu3Z5MqURum0lPzWUnzi/j/0SmkE8midYCZjSUcxxG7NfjYyqYWvPy5RZED9wibeEoOqwGAkC
 5W5RObtyBDASmDVeDRcHbFLcugvii/fdvjHsSKcIoaM5+XE0FNI0p/r5DfXk8d7dDACqyKZg6kA
 9S7ZkV1TOx83q3mRPOQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_05,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0 suspectscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270193

Support for LTC2378-20 and similar analog-to-digital converters.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v8 -> v9:
- Extracted LTC2338-18 support to a separate follow up patch.

 MAINTAINERS               |   1 +
 drivers/iio/adc/Kconfig   |  12 ++
 drivers/iio/adc/Makefile  |   1 +
 drivers/iio/adc/ltc2378.c | 387 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 401 insertions(+)
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
index 000000000000..d161435fc3a3
--- /dev/null
+++ b/drivers/iio/adc/ltc2378.c
@@ -0,0 +1,387 @@
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
+#define LTC2378_CHANNEL(_sign, _real_bits, _storage_bits)			\
+{										\
+	.type = IIO_VOLTAGE,							\
+	.indexed = 1,								\
+	.differential = _sign,							\
+	.channel = 0,								\
+	.channel2 = _sign ? 1 : 0,						\
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
+#define LTC2378_DIFF_CHANNEL(_real_bits)					\
+	LTC2378_CHANNEL(1, _real_bits, (((_real_bits) > 16) ? 32 : 16))
+
+#define LTC2378_PSEUDO_DIFF_CHANNEL(_real_bits)					\
+	LTC2378_CHANNEL(0, _real_bits, (((_real_bits) > 16) ? 32 : 16))
+
+struct ltc2378_chip_info {
+	const char *name;
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
+static const struct ltc2378_chip_info ltc2364_16_chip_info = {
+	.name = "ltc2364-16",
+	.chan = LTC2378_PSEUDO_DIFF_CHANNEL(16),
+};
+
+static const struct ltc2378_chip_info ltc2364_18_chip_info = {
+	.name = "ltc2364-18",
+	.chan = LTC2378_PSEUDO_DIFF_CHANNEL(18),
+};
+
+static const struct ltc2378_chip_info ltc2367_16_chip_info = {
+	.name = "ltc2367-16",
+	.chan = LTC2378_PSEUDO_DIFF_CHANNEL(16),
+};
+
+static const struct ltc2378_chip_info ltc2367_18_chip_info = {
+	.name = "ltc2367-18",
+	.chan = LTC2378_PSEUDO_DIFF_CHANNEL(18),
+};
+
+static const struct ltc2378_chip_info ltc2368_16_chip_info = {
+	.name = "ltc2368-16",
+	.chan = LTC2378_PSEUDO_DIFF_CHANNEL(16),
+};
+
+static const struct ltc2378_chip_info ltc2368_18_chip_info = {
+	.name = "ltc2368-18",
+	.chan = LTC2378_PSEUDO_DIFF_CHANNEL(18),
+};
+
+static const struct ltc2378_chip_info ltc2369_18_chip_info = {
+	.name = "ltc2369-18",
+	.chan = LTC2378_PSEUDO_DIFF_CHANNEL(18),
+};
+
+static const struct ltc2378_chip_info ltc2370_16_chip_info = {
+	.name = "ltc2370-16",
+	.chan = LTC2378_PSEUDO_DIFF_CHANNEL(16),
+};
+
+static const struct ltc2378_chip_info ltc2376_16_chip_info = {
+	.name = "ltc2376-16",
+	.chan = LTC2378_DIFF_CHANNEL(16),
+};
+
+static const struct ltc2378_chip_info ltc2376_18_chip_info = {
+	.name = "ltc2376-18",
+	.chan = LTC2378_DIFF_CHANNEL(18),
+};
+
+static const struct ltc2378_chip_info ltc2376_20_chip_info = {
+	.name = "ltc2376-20",
+	.chan = LTC2378_DIFF_CHANNEL(20),
+};
+
+static const struct ltc2378_chip_info ltc2377_16_chip_info = {
+	.name = "ltc2377-16",
+	.chan = LTC2378_DIFF_CHANNEL(16),
+};
+
+static const struct ltc2378_chip_info ltc2377_18_chip_info = {
+	.name = "ltc2377-18",
+	.chan = LTC2378_DIFF_CHANNEL(18),
+};
+
+static const struct ltc2378_chip_info ltc2377_20_chip_info = {
+	.name = "ltc2377-20",
+	.chan = LTC2378_DIFF_CHANNEL(20),
+};
+
+static const struct ltc2378_chip_info ltc2378_16_chip_info = {
+	.name = "ltc2378-16",
+	.chan = LTC2378_DIFF_CHANNEL(16),
+};
+
+static const struct ltc2378_chip_info ltc2378_18_chip_info = {
+	.name = "ltc2378-18",
+	.chan = LTC2378_DIFF_CHANNEL(18),
+};
+
+static const struct ltc2378_chip_info ltc2378_20_chip_info = {
+	.name = "ltc2378-20",
+	.chan = LTC2378_DIFF_CHANNEL(20),
+};
+
+static const struct ltc2378_chip_info ltc2379_18_chip_info = {
+	.name = "ltc2379-18",
+	.chan = LTC2378_DIFF_CHANNEL(18),
+};
+
+static const struct ltc2378_chip_info ltc2380_16_chip_info = {
+	.name = "ltc2380-16",
+	.chan = LTC2378_DIFF_CHANNEL(16),
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
+	ret = ltc2378_ref_setup(dev, st);
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

