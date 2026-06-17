Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094EC2652A2;
	Wed, 17 Jun 2026 02:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781661836; cv=none; b=iuGtdGP6LmkYXUCMs9F4CQ79MfenFXU7egWay6TbvCZQm1zSfTLShlLWkDHLUYk+oGXs484RCuDBNyEVR7fYzHCCPds6OFTP1M6+8PUDuYcCfDxscXWnMK+u7IZJGWtMhN3OOOFsvkx/x6CczpGZRjdoHs7updowHOiYRrFCWeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781661836; c=relaxed/simple;
	bh=D4gVNwovZaPYXAwkN1O0a7WBiqHCZUCXeXQQ0KtVdWo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a2x4cX9yNqLMigyaB1PO7ROLTASrZYe3VsDiwGV1W1KcVfNI6/y3QbyR0qBck9QsgYPp9jYMr8S2ldiNjtY6LSu2UpN9u+Bra/tmfMaEdapmCeCDXnqcYyRMNGXeboWmvdYgVAPjfm5JK+y2OqH6Ux117kq0crDEQBPdMlKiP7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=tHi3NNAp; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="tHi3NNAp"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GLXMj21546962;
	Tue, 16 Jun 2026 22:03:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=eR9GH
	NhJEDBF2hA6hp/8upw1b6WjU1oXkwGAVZpBX2M=; b=tHi3NNAprQ1Bd7n7XhPjE
	d6h5rOoAo2ke9Cc39t6kzmwGJsjZjnyVzIDFtLeF0cbYVBa5ykM0AQJZyGXleynq
	UrTSOghavs5I+liRHsQMncEKG6+9mNjQO7/smyCeGoayYkjq7em5bysQ+xz5ZwdW
	3NW+XFHEL9Sm1G9wITcxblIH23d6btrSJMNm5gAWXThqmHy9jSpXMMN66XvWcPnm
	IOEeWrNwb4atKZidxDBqdtA3SWZgSoY/CYzqKm/bPsHfcb/Wq/5+OU0iuxbUyBgL
	XYs5u4K6ZSKFSUCDuKTi+k1piOxrE8bGd3+GsCMTSlfE8VgU3whIBbTVKrvldI1y
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4euegr0rjr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 22:03:50 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 65H23nkf014024
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 16 Jun 2026 22:03:49 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 16 Jun 2026 22:03:49 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 16 Jun 2026 22:03:49 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 16 Jun 2026 22:03:49 -0400
Received: from work.maxim-ic.internal ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 65H23c0L006720;
	Tue, 16 Jun 2026 22:03:40 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <andy@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <pop.ioan-daniel@analog.com>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v3 2/5] iio: adc: ltc2378: Add support for LTC2378-20 and similar ADCs
Date: Tue, 16 Jun 2026 23:03:31 -0300
Message-ID: <5c18e7a370119ddfd5faefe147b294b39f78894a.1781661028.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1781661028.git.marcelo.schmitt@analog.com>
References: <cover.1781661028.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: rVIUQdk0W5YY2JLjMTvVEB3qBQwGrZuz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDAxNyBTYWx0ZWRfX7SYT7TQDhElV
 pqdEnaxRnMVzjvrYHxfDf+Hul+GpGZipJXdc7bXuozdhmwPmdozH7FuOQfRIIYndBqYybQuPVMW
 ZGLdOBSXEx3rZopL4xJbCAJD6vpDuPPBTS+6n+ryG/RrVaMICP5d11KQIZKR7T0Kpoh0aqoCNTo
 59TpfupG4Bywtawy2WjxCIkBFgKBvMEYPnPgTaL4U6axZ3KekE4VkFVyo7OchobZBeyL6dVOCEA
 L0IZCiETP6LditUJ6dvXL2BZj37e1p4MbJySXoXHwyJ7YuDcvqazBfPsu/zQgcI2ucKtT2n/gqY
 ZtIkELV7hf2mOrhSC4u0e25cxhz5CUwRl3Ho4NEmGjhFhGfW3A+7THIhe2bycT29mX495wYfCYx
 MnUtPIHlFBcAM/inUMCtg+wSLCc+7ZJTiCrT4bQchsNXAZpVeBep551e3UeU7JrXVUc9l46T9NK
 6KnAcVdfWR+BnIuI21w==
X-Proofpoint-GUID: rVIUQdk0W5YY2JLjMTvVEB3qBQwGrZuz
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDAxNyBTYWx0ZWRfX20AbJHxbB0hl
 KtWBeeKfsJxH+qCgzZ5DgSANh3jPb+sHlnbkdShpZYcEybgitVJBUN9AdtVYXDYpnjEzTHzodf8
 xSWD/K13rjIBX5A4CgG8GvURHEjGfG4I+UzD240I6snizBnxTgzr
X-Authority-Analysis: v=2.4 cv=B+6JFutM c=1 sm=1 tr=0 ts=6a320087 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=ir6pry_9mBCdi5gbn5AA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1015
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170017

Support for LTC2378-20 and similar analog-to-digital converters.

Co-developed-by: Ioan-Daniel Pop <pop.ioan-daniel@analog.com>
Signed-off-by: Ioan-Daniel Pop <pop.ioan-daniel@analog.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v2 -> v3:
- Restricted LTC2378 dependency list to require GPIO
- Use datasheet terminology to indicate polarity/output code.
- Added missing block scope to IIO_DEV_ACQUIRE_DIRECT_MODE.

 MAINTAINERS               |   1 +
 drivers/iio/adc/Kconfig   |  11 ++
 drivers/iio/adc/Makefile  |   1 +
 drivers/iio/adc/ltc2378.c | 338 ++++++++++++++++++++++++++++++++++++++
 drivers/iio/adc/ltc2378.h |  63 +++++++
 5 files changed, 414 insertions(+)
 create mode 100644 drivers/iio/adc/ltc2378.c
 create mode 100644 drivers/iio/adc/ltc2378.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 205acb4b0789..a11c00a78c13 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15226,6 +15226,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ltc2378.yaml
+F:	drivers/iio/adc/ltc2378*
 
 LTC2664 IIO DAC DRIVER
 M:	Michael Hennerich <michael.hennerich@analog.com>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index a3a93a47b43d..2b8203451367 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -940,6 +940,17 @@ config LTC2309
 	  This driver can also be built as a module. If so, the module will
 	  be called ltc2309.
 
+config LTC2378
+	tristate "Analog Devices LTC2378 ADC driver"
+	depends on SPI
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
index 707dd708912f..1814fb78dde3 100644
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
index 000000000000..88582bdcd6a6
--- /dev/null
+++ b/drivers/iio/adc/ltc2378.c
@@ -0,0 +1,338 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Analog Devices LTC2378 ADC series driver
+ *
+ * Copyright (C) 2026 Analog Devices Inc.
+ * Author: Ioan-Daniel Pop <pop.ioan-daniel@analog.com>
+ * Author: Marcelo Schmitt <marcelo.schmitt@analog.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+#include <linux/types.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/types.h>
+
+#include "ltc2378.h"
+
+static const struct ltc2378_chip_info ltc2338_18_chip_info = {
+	.name = "ltc2338-18",
+	.resolution = 18,
+	.bipolar = true,
+};
+
+static const struct ltc2378_chip_info ltc2364_16_chip_info = {
+	.name = "ltc2364-16",
+	.resolution = 16,
+	.bipolar = false,
+};
+
+static const struct ltc2378_chip_info ltc2364_18_chip_info = {
+	.name = "ltc2364-18",
+	.resolution = 18,
+	.bipolar = false,
+};
+
+static const struct ltc2378_chip_info ltc2367_16_chip_info = {
+	.name = "ltc2367-16",
+	.resolution = 16,
+	.bipolar = false,
+};
+
+static const struct ltc2378_chip_info ltc2367_18_chip_info = {
+	.name = "ltc2367-18",
+	.resolution = 18,
+	.bipolar = false,
+};
+
+static const struct ltc2378_chip_info ltc2368_16_chip_info = {
+	.name = "ltc2368-16",
+	.resolution = 16,
+	.bipolar = false,
+};
+
+static const struct ltc2378_chip_info ltc2368_18_chip_info = {
+	.name = "ltc2368-18",
+	.resolution = 18,
+	.bipolar = false,
+};
+
+static const struct ltc2378_chip_info ltc2369_18_chip_info = {
+	.name = "ltc2369-18",
+	.resolution = 18,
+	.bipolar = false,
+};
+
+static const struct ltc2378_chip_info ltc2370_16_chip_info = {
+	.name = "ltc2370-16",
+	.resolution = 16,
+	.bipolar = false,
+};
+
+static const struct ltc2378_chip_info ltc2376_16_chip_info = {
+	.name = "ltc2376-16",
+	.resolution = 16,
+	.bipolar = true,
+};
+
+static const struct ltc2378_chip_info ltc2376_18_chip_info = {
+	.name = "ltc2376-18",
+	.resolution = 18,
+	.bipolar = true,
+};
+
+static const struct ltc2378_chip_info ltc2376_20_chip_info = {
+	.name = "ltc2376-20",
+	.resolution = 20,
+	.bipolar = true,
+};
+
+static const struct ltc2378_chip_info ltc2377_16_chip_info = {
+	.name = "ltc2377-16",
+	.resolution = 16,
+	.bipolar = true,
+};
+
+static const struct ltc2378_chip_info ltc2377_18_chip_info = {
+	.name = "ltc2377-18",
+	.resolution = 18,
+	.bipolar = true,
+};
+
+static const struct ltc2378_chip_info ltc2377_20_chip_info = {
+	.name = "ltc2377-20",
+	.resolution = 20,
+	.bipolar = true,
+};
+
+static const struct ltc2378_chip_info ltc2378_16_chip_info = {
+	.name = "ltc2378-16",
+	.resolution = 16,
+	.bipolar = true,
+};
+
+static const struct ltc2378_chip_info ltc2378_18_chip_info = {
+	.name = "ltc2378-18",
+	.resolution = 18,
+	.bipolar = true,
+};
+
+static const struct ltc2378_chip_info ltc2378_20_chip_info = {
+	.name = "ltc2378-20",
+	.resolution = 20,
+	.bipolar = true,
+};
+
+static const struct ltc2378_chip_info ltc2379_18_chip_info = {
+	.name = "ltc2379-18",
+	.resolution = 18,
+	.bipolar = true,
+};
+
+static const struct ltc2378_chip_info ltc2380_16_chip_info = {
+	.name = "ltc2380-16",
+	.resolution = 16,
+	.bipolar = true,
+};
+
+static int ltc2378_channel_single_read(const struct iio_chan_spec *chan,
+				       struct ltc2378_state *st, int *val)
+{
+	const struct iio_scan_type *scan_type = &chan->scan_type;
+	u32 sample;
+	int ret;
+
+	ret = ltc2378_convert_and_acquire(st);
+	if (ret)
+		return ret;
+
+	if (scan_type->realbits > 16)
+		sample = st->scan.data.sample_buf32;
+	else
+		sample = st->scan.data.sample_buf16;
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
+			int *val, int *val2, long info)
+{
+	struct ltc2378_state *st = iio_priv(indio_dev);
+	int ret;
+
+	switch (info) {
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
+		if (st->info->bipolar)
+			*val2 = st->info->resolution - 1;
+		else
+			*val2 = st->info->resolution;
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
+	ret = devm_regulator_get_enable_read_voltage(dev, "ref");
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to read ref regulator\n");
+
+	st->ref_uV = ret;
+	st->info = spi_get_device_match_data(spi);
+	if (!st->info)
+		return -EINVAL;
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
+	st->num_iio_chans = 0;
+	st->chans[st->num_iio_chans++] = (struct iio_chan_spec) {
+		.type = IIO_VOLTAGE,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index = 0,
+		.scan_type = {
+			.format = st->info->bipolar ? IIO_SCAN_FORMAT_SIGNED_INT :
+						      IIO_SCAN_FORMAT_UNSIGNED_INT,
+			.realbits = st->info->resolution,
+			/*
+			 * Buffer elements could be 16-bit for low precision
+			 * parts. Though, using more storage bits allows keeping
+			 * the same scan_type configuration for both types of
+			 * buffer support.
+			 */
+			.storagebits = 32,
+		},
+	};
+
+	st->xfer.rx_buf = &st->scan.data;
+	st->xfer.len = st->info->resolution > 16 ? 4 : 2;
+	st->xfer.bits_per_word = st->info->resolution;
+
+	indio_dev->channels = st->chans;
+	indio_dev->num_channels = st->num_iio_chans;
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
+MODULE_AUTHOR("Ioan-Daniel Pop <pop.ioan-daniel@analog.com>");
+MODULE_AUTHOR("Marcelo Schmitt <marcelo.schmitt@analog.com>");
+MODULE_DESCRIPTION("Analog Devices LTC2378 ADC series driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/iio/adc/ltc2378.h b/drivers/iio/adc/ltc2378.h
new file mode 100644
index 000000000000..a3a69351de6c
--- /dev/null
+++ b/drivers/iio/adc/ltc2378.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Analog Devices LTC2378 and similar ADCs common definitions and properties
+ * Copyright (C) 2026 Analog Devices, Inc.
+ * Author: Marcelo Schmitt <marcelo.schmitt@analog.com>
+ */
+
+#ifndef __DRIVERS_IIO_ADC_LTC2378_H__
+#define __DRIVERS_IIO_ADC_LTC2378_H__
+
+#include <linux/iio/iio.h>
+#include <linux/gpio/consumer.h>
+#include <linux/delay.h>
+#include <linux/spi/spi.h>
+#include <linux/types.h>
+#include <linux/units.h>
+
+#define LTC2378_TDSDOBUSYL_NS		5
+#define LTC2378_TBUSYLH_NS		13
+#define LTC2378_TCNV_HIGH_NS		20
+
+struct ltc2378_chip_info {
+	const char *name;
+	int resolution;
+	bool bipolar;
+};
+
+struct ltc2378_state {
+	const struct ltc2378_chip_info *info;
+	struct gpio_desc *cnv_gpio;
+	struct spi_device *spi;
+	struct spi_transfer xfer;
+	unsigned int num_iio_chans;
+	struct iio_chan_spec chans[2]; /* 1 physical chan + 1 timestamp chan */
+	int ref_uV;
+
+	/*
+	 * DMA (thus cache coherency maintenance) requires the
+	 * transfer buffers to live in their own cache lines.
+	 */
+	struct {
+		union {
+			u16 sample_buf16;
+			u32 sample_buf32;
+		} data;
+		aligned_s64 timestamp;
+	} scan __aligned(IIO_DMA_MINALIGN);
+};
+
+static inline int ltc2378_convert_and_acquire(struct ltc2378_state *st)
+{
+	int ret;
+
+	/* Cause a rising edge of CNV to initiate a new ADC conversion */
+	gpiod_set_value_cansleep(st->cnv_gpio, 1);
+	fsleep(4);
+	ret = spi_sync_transfer(st->spi, &st->xfer, 1);
+	gpiod_set_value_cansleep(st->cnv_gpio, 0);
+
+	return ret;
+}
+
+#endif /* __DRIVERS_IIO_ADC_LTC2378_H__ */
-- 
2.53.0

