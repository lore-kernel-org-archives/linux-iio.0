Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72693CBE6F;
	Thu, 16 Jul 2026 08:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784188907; cv=none; b=fiUzb32ZMoM0ndE39NYVyoNfXKMgWwrKxw+LbnEcKBKFSBuu/U2rIRbuq0oApYLDwYPEbsNJ0xo/5aaKKvCIUmaCKZ2Szzr62XBHV9A9YDp8vpd5528A7Irw/zUuXow3wfTFQiLqhs6o40mezwXjEfX9gvqnibd3FaEckbHOD94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784188907; c=relaxed/simple;
	bh=NkutCoK3Yt/3O42eXbtcO5+LvP7h8m8D1sLRmkqi3uk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=rj9zvpyx1qybMD6BGKLfvHRr9L6QhF+XplDSrRN2jsaxgDRgln4kYH9wUng3IqpI0ScTB2sVQS44pShWjnesYkLyXAt5PlcpqfQmIOobbCkIAF7Pcy4aK61cxiTJZdCnC2D7myOf0k6pqHeBus/5az6tcoD/ch2a+bZza1KDuHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=cMW1OMEs; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="cMW1OMEs"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G7IOKA3064273;
	Thu, 16 Jul 2026 04:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=+wKYI
	mQJD9Bv4MJuxDUYjLbA+47pGjvK0itc6E1KSkA=; b=cMW1OMEs0CDP0vrYGZsSW
	T44JgUH5Q13dR/Dvyg4UngmX7n7B1r+L1uPuOgQk8L5uQ40HrJWgmQ0f3jYKnjrX
	squkHOZRYh7WVqU24kpUvzEIXD6ArWJgROQnNxkrYi/WIlmVuxCjRISx5ovrPhZU
	zZp4OY+Y3hvcx3l/d/8fweiGSFftTD9ZMr7I3ZTwBvA5qhmL5auuJFr/+3XuTUz2
	X0jt+XDVnU23PZrhSoMOuUw63Yt6o8M+IgS4jr1Fvc/kOPYGhfP0weBiRzQJgnry
	r5biNk3MV9fOA7YSKMWdkIz8SA4nvGD7lEo3QAejLGQHBS8mfUz434W/X4MNDsJ3
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fe85wv7bs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 04:01:35 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66G81Ygv058754
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 16 Jul 2026 04:01:34 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 16 Jul
 2026 04:01:34 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 16 Jul 2026 04:01:34 -0400
Received: from analog.ad.analog.com ([10.66.6.190])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66G7xo79012697;
	Thu, 16 Jul 2026 04:00:21 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Date: Thu, 16 Jul 2026 15:59:27 +0800
Subject: [PATCH 3/3] iio: dac: ad5710r: Add driver for AD5710R and AD5711R
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260716-iio-ad5710r-upstream-v1-3-e848a4bb701f@analog.com>
References: <20260716-iio-ad5710r-upstream-v1-0-e848a4bb701f@analog.com>
In-Reply-To: <20260716-iio-ad5710r-upstream-v1-0-e848a4bb701f@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy
 Shevchenko <andy@kernel.org>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp
 Zabel <p.zabel@pengutronix.de>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux@analog.com>, <devicetree@vger.kernel.org>,
        Kim Seer Paller
	<kimseer.paller@analog.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784188790; l=16197;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=NkutCoK3Yt/3O42eXbtcO5+LvP7h8m8D1sLRmkqi3uk=;
 b=LSYuxyQHgV0iorUDvUFcdTgwLBJaqXZyakRdfYVQFpWL36yeBdsKEc7iXVe97/meYvQVBqigu
 YjQi+NGNxyTD9a0y4b+nb8gegwrBzXRsM4mP2MspC0l6z3+LcuiFzyC
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=aLnAb79m c=1 sm=1 tr=0 ts=6a588fdf cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8
 a=VwQbUJbxAAAA:8 a=AryExQ6RRCVSKdQtyjYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA4MSBTYWx0ZWRfX2EtqhOmvdAp4
 6Tu0po87oIII/IMgIYDL4PiyJkfA+42k4cRwZSF3YBumxRg4SyaqmW/+8Iw1+Jjr/PDkKrizkLW
 c+oIz+nFJGhCLTm8s2areakhQiklDVQjK9go1d6npi0oasi+CNQabdE1r0z6Ewn2oc2KQ6t1u5z
 rmIuX9pRLtQfFCMAP949hLYhapy5v7wPLAromjsjQoS/wQlRHCzqx15XQU6tcaFaOYDUbKI58gZ
 vVatKPakDrc7abfejsaheLJPF1IvRcQUvhlzlSm6Bf5wejFnuaNXIUPlBPxUxc0qRc9tbQPzdjf
 zHUmvRw2WNLKX2D7lUBWlXefbxy2uTO9T7ZC/Ivcd09W+hb7bfhIvKeR8V+j++W83DgifcbXqIf
 ZxtXoKOLo6x7P1ftGKrUZ57LEVsgTssRfDTED4OrSKJ9Ebt6Pnd/x8u884gYw//1PcY1FXt7qsE
 CmAI5s/50Xelxn/LJaw==
X-Proofpoint-GUID: txCsE0c_UFsb2Xpc3_ii7ndUzqSWkd4m
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA4MSBTYWx0ZWRfX/mJ4CrvGAepf
 IP2UnsIqXqUWdnNhHe3byUJE+U9VADEx28QbbauCM8RT40Q3MQ97H1C5DYZo8PhuDiQqA/Ls6Ar
 teeGL2bOZo+W7xUywTsnrnm9Sm4NfawAGReFo5yq6m7n3k7YD948
X-Proofpoint-ORIG-GUID: txCsE0c_UFsb2Xpc3_ii7ndUzqSWkd4m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 lowpriorityscore=0 suspectscore=0 spamscore=0 impostorscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160081

The AD5710R (16-bit) and AD5711R (12-bit) are 8-channel, low-power,
configurable current/voltage output DACs with an on-chip 2.5V reference.
Each channel can be independently configured as a voltage output
(0V to VREF or 0V to 2xVREF) or a current output (0mA to 50mA).

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 MAINTAINERS               |   1 +
 drivers/iio/dac/Kconfig   |  11 ++
 drivers/iio/dac/Makefile  |   1 +
 drivers/iio/dac/ad5710r.c | 484 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 497 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bc4ae061909e..1a7bfab695ea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1561,6 +1561,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/dac/adi,ad5710r.yaml
+F:	drivers/iio/dac/ad5710r.c
 
 ANALOG DEVICES INC AD7091R DRIVER
 M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 17529509da9d..9cafbc20dfa6 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -192,6 +192,17 @@ config AD5706R
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad5706r.
 
+config AD5710R
+	tristate "Analog Devices AD5710R/AD5711R DAC driver"
+	depends on SPI
+	select REGMAP_SPI
+	help
+	  Say yes here to build support for Analog Devices AD5710R/AD5711R
+	  8-channel, 16-/12-bit Current/Voltage Digital to Analog Converter.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ad5710r.
+
 config AD9739A
 	tristate "Analog Devices AD9739A RF DAC spi driver"
 	depends on SPI
diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index 5d20d37e44ce..9611c6a96c52 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_AD5592R_BASE) += ad5592r-base.o
 obj-$(CONFIG_AD5592R) += ad5592r.o
 obj-$(CONFIG_AD5593R) += ad5593r.o
 obj-$(CONFIG_AD5706R) += ad5706r.o
+obj-$(CONFIG_AD5710R) += ad5710r.o
 obj-$(CONFIG_AD5755) += ad5755.o
 obj-$(CONFIG_AD5758) += ad5758.o
 obj-$(CONFIG_AD5761) += ad5761.o
diff --git a/drivers/iio/dac/ad5710r.c b/drivers/iio/dac/ad5710r.c
new file mode 100644
index 000000000000..05bdada0bb6e
--- /dev/null
+++ b/drivers/iio/dac/ad5710r.c
@@ -0,0 +1,484 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AD5710R/AD5711R 8-channel 16-/12-bit Configurable IDAC/VDAC
+ *
+ * Copyright 2026 Analog Devices Inc.
+ */
+
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/delay.h>
+#include <linux/dev_printk.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/iio/iio.h>
+#include <linux/kstrtox.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/reset.h>
+#include <linux/spi/spi.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
+#include <linux/units.h>
+
+#include <dt-bindings/iio/addac/adi,ad74413r.h>
+
+#define AD5710R_INTERFACE_CONFIG_A		0x00
+#define AD5710R_OUTPUT_OPERATING_MODE_0		0x20
+#define AD5710R_OUTPUT_OPERATING_MODE_1		0x21
+#define AD5710R_OUTPUT_CONTROL_0		0x2A
+#define AD5710R_REFERENCE_CONTROL_0		0x3C
+#define AD5710R_SW_LDAC_TRIG_A			0xE5
+#define AD5710R_INPUT_CH(chan)			(2 * (chan) + 0xEB)
+#define AD5710R_CHN_VMODE_EN			0xFF
+
+#define AD5710R_SLD_TRIG_A			BIT(7)
+#define AD5710R_OUTPUT_CONTROL_RANGE		BIT(2)
+#define AD5710R_REFERENCE_CONTROL_SEL		BIT(0)
+#define AD5710R_OP_MODE_CHAN_MSK(chan)		(GENMASK(1, 0) << (2 * (chan)))
+#define AD5710R_CHN_VMODE_EN_BIT(chan)		BIT(chan)
+
+#define AD5710R_SW_RESET			(BIT(7) | BIT(0))
+#define AD5710R_NORMAL_OP			0
+#define AD5710R_INTERNAL_VREF_mV		2500
+#define AD5710R_INTERNAL_IREF_mA		50
+#define AD5710R_LDAC_PULSE_US			100
+#define AD5710R_NUM_CHANNELS			8
+#define AD5710R_CH_PER_REG			4
+
+struct ad5710r_chip_info {
+	const char *name;
+	unsigned int resolution;
+};
+
+struct ad5710r_state {
+	struct regmap *regmap;
+	/* Protect against concurrent access to the shared transfer buffer */
+	struct mutex lock;
+	const struct ad5710r_chip_info *chip_info;
+	struct iio_chan_spec *iio_channels;
+	struct gpio_desc *ldac_gpio;
+	int vref_mV;
+	/*
+	 * DMA (thus cache coherency maintenance) may require the transfer
+	 * buffers to live in their own cache lines.
+	 */
+	__be16 buf __aligned(IIO_DMA_MINALIGN);
+};
+
+static ssize_t ad5710r_get_powerdown_mode(struct iio_dev *indio_dev,
+					  uintptr_t private,
+					  const struct iio_chan_spec *chan,
+					  char *buf)
+{
+	if (chan->type == IIO_VOLTAGE)
+		return sysfs_emit(buf, "15kohm_to_gnd\n");
+
+	return sysfs_emit(buf, "high_z\n");
+}
+
+static ssize_t ad5710r_get_dac_powerdown(struct iio_dev *indio_dev,
+					 uintptr_t private,
+					 const struct iio_chan_spec *chan,
+					 char *buf)
+{
+	struct ad5710r_state *st = iio_priv(indio_dev);
+	unsigned int reg_offset, ch_in_reg, reg, mode;
+	bool en = false;
+	int ret;
+
+	reg_offset = chan->channel / AD5710R_CH_PER_REG;
+	ch_in_reg = chan->channel % AD5710R_CH_PER_REG;
+	reg = AD5710R_OUTPUT_OPERATING_MODE_0 + reg_offset;
+
+	ret = regmap_read(st->regmap, reg, &mode);
+	if (ret)
+		return ret;
+
+	if (mode & AD5710R_OP_MODE_CHAN_MSK(ch_in_reg))
+		en = true;
+
+	return sysfs_emit(buf, "%d\n", en);
+}
+
+static ssize_t ad5710r_set_dac_powerdown(struct iio_dev *indio_dev,
+					 uintptr_t private,
+					 const struct iio_chan_spec *chan,
+					 const char *buf, size_t len)
+{
+	struct ad5710r_state *st = iio_priv(indio_dev);
+	unsigned int reg_offset, ch_in_reg, reg, mask, val;
+	bool powerdown;
+	int ret;
+
+	ret = kstrtobool(buf, &powerdown);
+	if (ret)
+		return ret;
+
+	reg_offset = chan->channel / AD5710R_CH_PER_REG;
+	ch_in_reg = chan->channel % AD5710R_CH_PER_REG;
+	reg = AD5710R_OUTPUT_OPERATING_MODE_0 + reg_offset;
+	mask = AD5710R_OP_MODE_CHAN_MSK(ch_in_reg);
+	val = field_prep(mask, powerdown);
+
+	ret = regmap_update_bits(st->regmap, reg, mask, val);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static int ad5710r_trigger_hw_ldac(struct gpio_desc *ldac_gpio)
+{
+	gpiod_set_value_cansleep(ldac_gpio, 1);
+	fsleep(AD5710R_LDAC_PULSE_US);
+	gpiod_set_value_cansleep(ldac_gpio, 0);
+
+	return 0;
+}
+
+static int ad5710r_dac_write(struct ad5710r_state *st, unsigned int chan,
+			     unsigned int val)
+{
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	st->buf = cpu_to_be16(val << (16 - st->chip_info->resolution));
+
+	ret = regmap_bulk_write(st->regmap, AD5710R_INPUT_CH(chan),
+				&st->buf, sizeof(st->buf));
+	if (ret)
+		return ret;
+
+	if (st->ldac_gpio)
+		return ad5710r_trigger_hw_ldac(st->ldac_gpio);
+
+	return regmap_set_bits(st->regmap, AD5710R_SW_LDAC_TRIG_A,
+			       AD5710R_SLD_TRIG_A);
+}
+
+static int ad5710r_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long info)
+{
+	struct ad5710r_state *st = iio_priv(indio_dev);
+	int ret;
+
+	guard(mutex)(&st->lock);
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		ret = regmap_bulk_read(st->regmap,
+				       AD5710R_INPUT_CH(chan->channel),
+				       &st->buf, sizeof(st->buf));
+		if (ret)
+			return ret;
+
+		*val = be16_to_cpu(st->buf) >> (16 - st->chip_info->resolution);
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		if (chan->type == IIO_VOLTAGE)
+			*val = st->vref_mV;
+		else
+			*val = AD5710R_INTERNAL_IREF_mA;
+
+		*val2 = st->chip_info->resolution;
+
+		return IIO_VAL_FRACTIONAL_LOG2;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad5710r_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long info)
+{
+	struct ad5710r_state *st = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		if (val < 0 || val > ((1 << st->chip_info->resolution) - 1))
+			return -EINVAL;
+
+		return ad5710r_dac_write(st, chan->channel, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad5710r_reg_access(struct iio_dev *indio_dev, unsigned int reg,
+			      unsigned int writeval, unsigned int *readval)
+{
+	struct ad5710r_state *st = iio_priv(indio_dev);
+
+	if (readval)
+		return regmap_read(st->regmap, reg, readval);
+
+	return regmap_write(st->regmap, reg, writeval);
+}
+
+static const struct iio_chan_spec_ext_info ad5710r_ext_info[] = {
+	{
+		.name = "powerdown",
+		.shared = IIO_SEPARATE,
+		.read = ad5710r_get_dac_powerdown,
+		.write = ad5710r_set_dac_powerdown,
+	},
+	{
+		.name = "powerdown_mode",
+		.shared = IIO_SEPARATE,
+		.read = ad5710r_get_powerdown_mode,
+	},
+	{ }
+};
+
+static const struct ad5710r_chip_info ad5710r_chip = {
+	.name = "ad5710r",
+	.resolution = 16,
+};
+
+static const struct ad5710r_chip_info ad5711r_chip = {
+	.name = "ad5711r",
+	.resolution = 12,
+};
+
+static int ad5710r_parse_channel_cfg(struct ad5710r_state *st, u8 *num_channels)
+{
+	struct device *dev = regmap_get_device(st->regmap);
+	int ret, num_chan;
+	int i = 0;
+	u32 reg;
+
+	num_chan = device_get_child_node_count(dev);
+	if (!num_chan)
+		return dev_err_probe(dev, -ENODEV, "No channels configured\n");
+
+	st->iio_channels = devm_kcalloc(dev, num_chan,
+					sizeof(*st->iio_channels),
+					GFP_KERNEL);
+	if (!st->iio_channels)
+		return -ENOMEM;
+
+	device_for_each_child_node_scoped(dev, child) {
+		unsigned int reg_offset, ch_in_reg, mode_reg, mode_mask, ch_func;
+		enum iio_chan_type chan_type;
+
+		ret = fwnode_property_read_u32(child, "reg", &reg);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to read reg property of %pfwP\n", child);
+
+		if (reg >= AD5710R_NUM_CHANNELS)
+			return dev_err_probe(dev, -EINVAL,
+					     "reg out of range in %pfwP\n", child);
+
+		ret = fwnode_property_read_u32(child, "adi,ch-func", &ch_func);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Missing adi,ch-func property for %pfwP\n", child);
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
+		st->iio_channels[i++] = (struct iio_chan_spec) {
+			.type = chan_type,
+			.channel = reg,
+			.indexed = 1,
+			.output = 1,
+			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+					      BIT(IIO_CHAN_INFO_SCALE),
+			.ext_info = ad5710r_ext_info,
+		};
+
+		reg_offset = reg / AD5710R_CH_PER_REG;
+		ch_in_reg = reg % AD5710R_CH_PER_REG;
+		mode_reg = AD5710R_OUTPUT_OPERATING_MODE_0 + reg_offset;
+		mode_mask = AD5710R_OP_MODE_CHAN_MSK(ch_in_reg);
+
+		/* Enable the channel in normal operation mode */
+		ret = regmap_update_bits(st->regmap, mode_reg, mode_mask,
+					 field_prep(mode_mask, AD5710R_NORMAL_OP));
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to set normal operating mode for %pfwP\n",
+					     child);
+	}
+
+	*num_channels = num_chan;
+
+	return 0;
+}
+
+static int ad5710r_setup(struct ad5710r_state *st, int external_vref_uV, u8 *num_channels)
+{
+	struct device *dev = regmap_get_device(st->regmap);
+	struct reset_control *reset;
+	u8 range_multiplier;
+	int ret;
+
+	reset = devm_reset_control_get_optional_exclusive(dev, NULL);
+	if (IS_ERR(reset))
+		return dev_err_probe(dev, PTR_ERR(reset), "Failed to get reset\n");
+
+	if (reset) {
+		/* Hold RESET low; tRESET pulse width is 160 ns min (Table 4) */
+		reset_control_assert(reset);
+		fsleep(1);
+		ret = reset_control_deassert(reset);
+		if (ret)
+			return ret;
+	} else {
+		/* No hardware reset available, fall back to software reset. */
+		ret = regmap_update_bits(st->regmap, AD5710R_INTERFACE_CONFIG_A,
+					 AD5710R_SW_RESET, AD5710R_SW_RESET);
+		if (ret)
+			return ret;
+	}
+
+	/* Device needs 167 µs after a reset before SPI access (Table 4) */
+	fsleep(167);
+
+	range_multiplier = 1;
+	if (device_property_read_bool(dev, "adi,range-double")) {
+		ret = regmap_set_bits(st->regmap, AD5710R_OUTPUT_CONTROL_0,
+				      AD5710R_OUTPUT_CONTROL_RANGE);
+		if (ret)
+			return ret;
+
+		range_multiplier = 2;
+	}
+
+	if (external_vref_uV) {
+		st->vref_mV = range_multiplier * external_vref_uV / MILLI;
+	} else {
+		ret = regmap_set_bits(st->regmap, AD5710R_REFERENCE_CONTROL_0,
+				      AD5710R_REFERENCE_CONTROL_SEL);
+		if (ret)
+			return ret;
+
+		st->vref_mV = range_multiplier * AD5710R_INTERNAL_VREF_mV;
+	}
+
+	st->ldac_gpio = devm_gpiod_get_optional(dev, "ldac", GPIOD_OUT_LOW);
+	if (IS_ERR(st->ldac_gpio))
+		return dev_err_probe(dev, PTR_ERR(st->ldac_gpio),
+				     "Failed to get ldac GPIO\n");
+
+	return ad5710r_parse_channel_cfg(st, num_channels);
+}
+
+static const struct regmap_config ad5710r_regmap_config = {
+	.reg_bits = 16,
+	.val_bits = 8,
+	.max_register = AD5710R_CHN_VMODE_EN,
+};
+
+static const struct iio_info ad5710r_info = {
+	.read_raw = ad5710r_read_raw,
+	.write_raw = ad5710r_write_raw,
+	.debugfs_reg_access = ad5710r_reg_access,
+};
+
+static int ad5710r_probe(struct spi_device *spi)
+{
+	static const char * const regulators[] = { "vdd", "iovdd" };
+	struct device *dev = &spi->dev;
+	struct iio_dev *indio_dev;
+	struct ad5710r_state *st;
+	int ret, external_vref_uV;
+	u8 num_channels;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+
+	st->regmap = devm_regmap_init_spi(spi, &ad5710r_regmap_config);
+	if (IS_ERR(st->regmap))
+		return dev_err_probe(dev, PTR_ERR(st->regmap),
+				     "Failed to init regmap\n");
+
+	st->chip_info = spi_get_device_match_data(spi);
+
+	ret = devm_mutex_init(dev, &st->lock);
+	if (ret)
+		return ret;
+
+	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulators),
+					     regulators);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable regulators\n");
+
+	external_vref_uV = devm_regulator_get_enable_read_voltage(dev, "ref");
+	if (external_vref_uV < 0 && external_vref_uV != -ENODEV)
+		return external_vref_uV;
+
+	if (external_vref_uV == -ENODEV)
+		external_vref_uV = 0;
+
+	ret = ad5710r_setup(st, external_vref_uV, &num_channels);
+	if (ret)
+		return ret;
+
+	indio_dev->name = st->chip_info->name;
+	indio_dev->info = &ad5710r_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = st->iio_channels;
+	indio_dev->num_channels = num_channels;
+
+	return devm_iio_device_register(&spi->dev, indio_dev);
+}
+
+static const struct spi_device_id ad5710r_id[] = {
+	{ .name = "ad5710r", .driver_data = (kernel_ulong_t)&ad5710r_chip },
+	{ .name = "ad5711r", .driver_data = (kernel_ulong_t)&ad5711r_chip },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, ad5710r_id);
+
+static const struct of_device_id ad5710r_of_match[] = {
+	{ .compatible = "adi,ad5710r", .data = &ad5710r_chip },
+	{ .compatible = "adi,ad5711r", .data = &ad5711r_chip },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad5710r_of_match);
+
+static struct spi_driver ad5710r_driver = {
+	.driver = {
+		.name = "ad5710r",
+		.of_match_table = ad5710r_of_match,
+	},
+	.probe = ad5710r_probe,
+	.id_table = ad5710r_id,
+};
+module_spi_driver(ad5710r_driver);
+
+MODULE_AUTHOR("Kim Seer Paller <kimseer.paller@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD5710R/AD5711R DAC Driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1

