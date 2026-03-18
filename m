Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC54330328;
	Wed, 18 Mar 2026 05:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773811412; cv=none; b=bLfZ3ax9GdrPPXjSUdKfze57UDe7SQTsn9SE0j0Wk+p52xJ15kjN1SR4NXoTN1+IPNrWdVdjkcT+22K+RVVd4EX69RANaWsQaF1HWlbHdE4+4c2lVNMW7hbjudkAsqNG2EUlQ1PNKN1yquYde0jD6vQjB1B6oGPiM/B1WyGM4dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773811412; c=relaxed/simple;
	bh=uZbgwqq5HelbbEUfAxe/zYIfqR46rGBfmdkZd0lo5UE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ugdmKvY20XspLjHQfy0UB31rz85DfBrzAuQI932zgDvt6sY2nxpZlyJt8NtyQo0WgLTy+u0uYGDqjeOycMW1QrcRmmLYigneGT63HimDnsalHRnt5q1ahBBkUfBft8KKubea+ku6vHxFjuEJkY1kAsTdyDCoG9s+1eVuqUsHYSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=nNilyFKw; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="nNilyFKw"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62I1VGOn1782538;
	Wed, 18 Mar 2026 01:23:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=p8DKZ
	7IsXdtYeq1ssMjT9mej5XHR2evTbsH0yGEQ6n0=; b=nNilyFKwhx3vMaXCUOrzC
	gCJ/AWyv0NsEeLJw6olvuwKisqHCQ8f7goz2VeuRQgH6ZSO8SDKxDeEYpiiLs5uH
	zzQDBHOdGvptBI/cfjzeZLND1b86g+9dv23D71Vg/AS+mDB260d03sAt3EwPlVUO
	NajF/tezvypUjZxEBo66XZWVWFp6on+SQY2WIoenCFGv+uY0hBFpdSdRGPFAeMYY
	WPWCzKUuabzTlTsKYDLSos38Pp3OFXz18IjtpHJEoIH5ncnDXqwY8iSxxs45bXmG
	+1soMuR4aVGGY/WGk8JZ1IAVI8oL7YQRPHnMA0EQAjbbu/cksxPT5XppsA6KT/bu
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cyjf80x6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 01:23:13 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62I5NCU9064830
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 18 Mar 2026 01:23:12 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 18 Mar 2026 01:23:12 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 18 Mar 2026 01:23:12 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 18 Mar 2026 01:23:12 -0400
Received: from ATORRENO-L02.ad.analog.com (ATORRENO-L02.ad.analog.com [10.118.4.23])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62I5Mpcg023858;
	Wed, 18 Mar 2026 01:23:05 -0400
From: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
Date: Wed, 18 Mar 2026 13:13:36 +0800
Subject: [PATCH v3 2/2] iio: dac: ad5706r: Add support for AD5706R DAC
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260318-dev_ad5706r-v3-2-5d078f41e988@analog.com>
References: <20260318-dev_ad5706r-v3-0-5d078f41e988@analog.com>
In-Reply-To: <20260318-dev_ad5706r-v3-0-5d078f41e988@analog.com>
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
	<alexisczezar.torreno@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773811371; l=8407;
 i=alexisczezar.torreno@analog.com; s=20250213; h=from:subject:message-id;
 bh=uZbgwqq5HelbbEUfAxe/zYIfqR46rGBfmdkZd0lo5UE=;
 b=zp6qNOZgWHstE5+dvT8AmvFTemdyFgD7mmnXj95wgjXkqfdwM9rXpkms2gGT5PTxDUhwifTOb
 A4xXein9VQ/B+S2LMoWuc0bO6uKZnoZe1ftcJiNFhKI/UtddlgCqcUH
X-Developer-Key: i=alexisczezar.torreno@analog.com; a=ed25519;
 pk=XpXmJnRjnsKdDil6YpOlj9+44S+XYXVFnxvkbmaZ+10=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=Rcidyltv c=1 sm=1 tr=0 ts=69ba36c1 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8
 a=VwQbUJbxAAAA:8 a=K5jOpT_a_M5dHkYSQTUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: LqZpv0a8payhhv7RYWhJJG3qcFoWVqcX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDA0MyBTYWx0ZWRfX5flpDnxywTbX
 1WRhIc/Juq93sKDNHGFcp7N7VUQXE4xlYQy5KBwDxr4nYO/FpNk77kunn497nHm/F1+MRhFgIT2
 g2hjIdj3h28wruxmatMmvdqYKP+XjUz0CNkQSrmC5wOC5yKSLkNcbchuIPvmP0hSj+NNUIG/P/A
 8ga+XYTQpldOB1JOGmZ/v6I5a4RzU22CCKBVD671qx+dQx1ugmoMyEtZaVXXt6Kd4JiXnYRoeVd
 ZNqTiBGG95pb7WOfhvusDDcH3zMwce1pQZqB/RJ86C6KFnp/QT+Vre0eSAjzhpKlbVSWG6L/oxQ
 lH6WefD2NMbCR8w0MB77vJ/7mrBtozg+RAMVb0b3TR30t9vXM2pb5Gfjs9/WYtkMOvdQ3FB5L3R
 dg9i+0O9EI1dTfilTX9b4kVvn4kgTCHSQnWHX6My5AxTTOrLxbViPx71rcK2Vv2IKQ3a95fUr+X
 Lh7hgrJsOAoDhnYqH8g==
X-Proofpoint-GUID: LqZpv0a8payhhv7RYWhJJG3qcFoWVqcX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_05,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603180043

Add support for the Analog Devices AD5706R, a 4-channel 16-bit
current output digital-to-analog converter with SPI interface.

Features:
  - 4 independent DAC channels
  - Hardware and software LDAC trigger
  - Configurable output range
  - PWM-based LDAC control
  - Dither and toggle modes
  - Dynamically configurable SPI speed

Signed-off-by: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>

---
Changes since v1:
  - Removed PWM, GPIO, clock generator, debugfs, regmap, IIO_BUFFER
  - Removed all custom ext_info sysfs attributes
  - Simplified to basic raw read/write and read-only scale
  - SPI read/write can handle multibyte registers
---
---
 MAINTAINERS               |   1 +
 drivers/iio/dac/Kconfig   |  10 +++
 drivers/iio/dac/Makefile  |   1 +
 drivers/iio/dac/ad5706r.c | 222 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 234 insertions(+)

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
index db9f5c711b3df90641f017652fbbef594cc1627d..8ccbdf6dfbca8640a47bf05b4afc6b4bf90a7e26 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -178,6 +178,16 @@ config AD5624R_SPI
 	  Say yes here to build support for Analog Devices AD5624R, AD5644R and
 	  AD5664R converters (DAC). This driver uses the common SPI interface.
 
+config AD5706R
+	tristate "Analog Devices AD5706R DAC driver"
+	depends on SPI
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
index 0000000000000000000000000000000000000000..840ee7b6db2e05ea35b27ff776f0c5c8a961d9c1
--- /dev/null
+++ b/drivers/iio/dac/ad5706r.c
@@ -0,0 +1,222 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * AD5706R 16-bit Current Output Digital to Analog Converter
+ *
+ * Copyright 2026 Analog Devices Inc.
+ */
+
+#include <linux/array_size.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/iio/iio.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/spi/spi.h>
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
+#define AD5706R_SINGLE_BYTE_LEN		1
+#define AD5706R_DOUBLE_BYTE_LEN		2
+
+struct ad5706r_state {
+	struct spi_device *spi;
+	struct mutex lock; /* Protects SPI transfers */
+
+	u8 tx_buf[4] __aligned(ARCH_DMA_MINALIGN);
+	u8 rx_buf[2];
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
+static int ad5706r_spi_write(struct ad5706r_state *st, u16 reg, u16 val)
+{
+	unsigned int num_bytes = ad5706r_reg_len(reg);
+	struct spi_transfer xfer = {
+		.tx_buf = st->tx_buf,
+		.len = num_bytes + 2,
+	};
+
+	put_unaligned_be16(reg, &st->tx_buf[0]);
+
+	if (num_bytes == 1)
+		st->tx_buf[2] = val;
+	else if (num_bytes == 2)
+		put_unaligned_be16(val, &st->tx_buf[2]);
+	else
+		return -EINVAL;
+
+	return spi_sync_transfer(st->spi, &xfer, 1);
+}
+
+static int ad5706r_spi_read(struct ad5706r_state *st, u16 reg, u16 *val)
+{
+	unsigned int num_bytes = ad5706r_reg_len(reg);
+	u16 cmd;
+	int ret;
+
+	struct spi_transfer xfer[] = {
+		{
+			.tx_buf = st->tx_buf,
+			.len = 2,
+		},
+		{
+			.rx_buf = st->rx_buf,
+			.len = num_bytes,
+		},
+	};
+
+	cmd = AD5706R_RD_MASK | (reg & AD5706R_ADDR_MASK);
+	put_unaligned_be16(cmd, &st->tx_buf[0]);
+
+	ret = spi_sync_transfer(st->spi, xfer, ARRAY_SIZE(xfer));
+	if (ret)
+		return ret;
+
+	if (num_bytes == 1)
+		*val = st->rx_buf[0];
+	else if (num_bytes == 2)
+		*val = get_unaligned_be16(st->rx_buf);
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+static int ad5706r_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int *val,
+			    int *val2, long mask)
+{
+	struct ad5706r_state *st = iio_priv(indio_dev);
+	u16 reg_val;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		scoped_guard(mutex, &st->lock) {
+			ret = ad5706r_spi_read(st, AD5706R_REG_DAC_DATA_READBACK_CH(chan->channel),
+					       &reg_val);
+
+			if (ret)
+				return ret;
+
+			*val = reg_val;
+		}
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = 50;
+		*val2 = AD5706R_DAC_RESOLUTION;
+		return IIO_VAL_FRACTIONAL_LOG2;
+	}
+
+	return -EINVAL;
+}
+
+static int ad5706r_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, int val,
+			     int val2, long mask)
+{
+	struct ad5706r_state *st = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (val < 0 || val >= AD5706R_DAC_MAX_CODE)
+			return -EINVAL;
+
+		guard(mutex)(&st->lock);
+		return ad5706r_spi_write(st,
+					 AD5706R_REG_DAC_INPUT_A_CH(chan->channel),
+					 val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info ad5706r_info = {
+	.read_raw = ad5706r_read_raw,
+	.write_raw = ad5706r_write_raw,
+};
+
+#define AD5706R_CHAN(_channel) {				\
+	.type = IIO_CURRENT,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
+			      BIT(IIO_CHAN_INFO_SCALE),	\
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
+	struct iio_dev *indio_dev;
+	struct ad5706r_state *st;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	st->spi = spi;
+
+	ret = devm_mutex_init(&spi->dev, &st->lock);
+	if (ret)
+		return ret;
+
+	indio_dev->name = "ad5706r";
+	indio_dev->info = &ad5706r_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = ad5706r_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ad5706r_channels);
+
+	return devm_iio_device_register(&spi->dev, indio_dev);
+}
+
+static const struct of_device_id ad5706r_of_match[] = {
+	{ .compatible = "adi,ad5706r" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, ad5706r_of_match);
+
+static const struct spi_device_id ad5706r_id[] = {
+	{ "ad5706r" },
+	{}
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

