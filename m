Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FBA318EE2;
	Thu, 30 Jul 2026 20:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785442051; cv=none; b=avUmx+/dDhANCM7CTpXfcnYBLfzdP8jodJxfUUCSNJBvp+Zy4mR4U6x1XiGi0TFSSlTcvkWrZREeSDVHt8nx1yq0DZhvvZ9bIlN2g7uwoBeISKlFUFPzBPb3za6WKnBEl6t5bsFV0oWSdrs3lESe6JTNodjY7+Zx5YkvDIp8fZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785442051; c=relaxed/simple;
	bh=F/ng72S3QHmNwZ48iKMdPg1nHf0RnJix1Zd0nZSUhq8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UKl/KfsLhQsym4GmNZ5KcJZ+tuFBDLXYpJlQKKnAHYD9wo4OuvomaIjuNjFz80QuYqRt8MzitqzUK8Ld0JydQXkGoV9TPZyTxQchJ+unOZcZShUMFw/P+9pZPGWWvpA7LnjudJ8ZzIipp1bZAHiw78zy0mNKessm287weKfFfgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=OjQI7Bic; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="OjQI7Bic"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 4255F41B2B;
	Thu, 30 Jul 2026 22:07:28 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NkL5V4omso0V; Thu, 30 Jul 2026 22:07:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1785442046; bh=F/ng72S3QHmNwZ48iKMdPg1nHf0RnJix1Zd0nZSUhq8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OjQI7BicIULOR8NHKoOCHbgwfmPidyeAnsW3TdHvTR+KcV6nEjR0obZGvXD+QZAlv
	 lwpCYjcJ2HnRvgOAj0SQk06BKBlwYw1np4IE/efMjizpumizpZ8hApsdwa67z4esUh
	 qch++SJl2h7YrVKzZOppaLRQMlz2otHIGizLPX7uSptEbX2sbmB6vqVYDfFicBMSfe
	 yVI2N7+LAo2a7e1kCxZtjUuCCiJ7M5VB3jAfC4aBKUIDaE5KfhtP2RvoETg8dy/xTJ
	 KbtcSzmU9GQqIcn/O+5u/JVk516tAyLlVS2B/ByQmcyJxbPeGHdaRbyvsWSWEoFSws
	 Pn6fuA+zdpT9w==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 31 Jul 2026 01:37:01 +0530
Subject: [PATCH v3 2/3] iio: proximity: add driver for Sharp GP2AP070S
 proximity sensor
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-gp2ap070s-v3-2-d1f5cecf9fe7@disroot.org>
References: <20260731-gp2ap070s-v3-0-d1f5cecf9fe7@disroot.org>
In-Reply-To: <20260731-gp2ap070s-v3-0-d1f5cecf9fe7@disroot.org>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org

The GP2AP070S is a proximity sensor designed and manufactured by Sharp
Corporation. This sensor is used in mobile devices, including, but not
limited to - the Samsung Galaxy J6.

The driver has been adopted from Samsung's downstream kernel
implementation [1]. Due to the lack of public documentation about the
schematics of this device. The downstream driver acts as the secondary
source of information. Driver clarity has also been improved with the
help of the GP2AP* drivers in iio/light.

Link: https://github.com/Exynos7870/android_kernel_samsung_universal7870/blob/lineage-16.0/drivers/sensors/gp2ap070s.c [1]
Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/iio/proximity/Kconfig     |  11 +
 drivers/iio/proximity/Makefile    |   1 +
 drivers/iio/proximity/gp2ap070s.c | 505 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 517 insertions(+)

diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
index bb77fad2a1b3..39db19e59650 100644
--- a/drivers/iio/proximity/Kconfig
+++ b/drivers/iio/proximity/Kconfig
@@ -41,6 +41,17 @@ config D3323AA
 	  To compile this driver as a module, choose M here: the module will be
 	  called d3323aa.
 
+config GP2AP070S
+	tristate "Sharp GP2AP070S proximity sensor"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Say Y here to build a driver for the Sharp GP2AP070S proximity
+	  sensor.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called gp2ap070s.
+
 config HX9023S
 	tristate "TYHX HX9023S SAR sensor"
 	select IIO_BUFFER
diff --git a/drivers/iio/proximity/Makefile b/drivers/iio/proximity/Makefile
index 4352833dd8a4..627ffb04acb2 100644
--- a/drivers/iio/proximity/Makefile
+++ b/drivers/iio/proximity/Makefile
@@ -7,6 +7,7 @@
 obj-$(CONFIG_AS3935)		+= as3935.o
 obj-$(CONFIG_CROS_EC_MKBP_PROXIMITY) += cros_ec_mkbp_proximity.o
 obj-$(CONFIG_D3323AA)		+= d3323aa.o
+obj-$(CONFIG_GP2AP070S)		+= gp2ap070s.o
 obj-$(CONFIG_HX9023S)		+= hx9023s.o
 obj-$(CONFIG_IRSD200)		+= irsd200.o
 obj-$(CONFIG_ISL29501)		+= isl29501.o
diff --git a/drivers/iio/proximity/gp2ap070s.c b/drivers/iio/proximity/gp2ap070s.c
new file mode 100644
index 000000000000..98fc12e5ccd5
--- /dev/null
+++ b/drivers/iio/proximity/gp2ap070s.c
@@ -0,0 +1,505 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * IIO driver for Sharp GP2AP070S proximity sensor.
+ *
+ * Based on Samsung G610FXXU1CRI4 kernel driver - drivers/sensors/gp2ap070s.c
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ * Copyright (c) 2026 Kaustabh Chakraborty <kauschluss@disroot.org>
+ */
+
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/types.h>
+
+#include <linux/iio/events.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/types.h>
+
+#define GP2AP070S_REG_COM1		0x80
+#define   GP2AP070S_COM1_WKUP		BIT(7)
+#define   GP2AP070S_COM1_EN		BIT(5)
+
+#define GP2AP070S_REG_COM2		0x81
+
+#define GP2AP070S_REG_COM3		0x82
+#define   GP2AP070S_COM3_INT_PULSE	BIT(1)
+
+#define GP2AP070S_REG_COM4		0x83
+#define   GP2AP070S_COM4_BLINK		GENMASK(2, 0)	/* LED Blink Interval */
+#define     GP2AP070S_COM4_BLINK_0ms	0
+#define     GP2AP070S_COM4_BLINK_2ms	1
+#define     GP2AP070S_COM4_BLINK_8ms	2
+#define     GP2AP070S_COM4_BLINK_33ms	3
+#define     GP2AP070S_COM4_BLINK_66ms	4
+#define     GP2AP070S_COM4_BLINK_131ms	5
+#define     GP2AP070S_COM4_BLINK_262ms	6
+#define     GP2AP070S_COM4_BLINK_524ms	7
+
+#define GP2AP070S_REG_PS1		0x85
+#define   GP2AP070S_PS1_RESOL		GENMASK(5, 4)	/* Resolution */
+#define     GP2AP070S_PS1_RESOL_14ms	0
+#define     GP2AP070S_PS1_RESOL_12ms	1
+#define     GP2AP070S_PS1_RESOL_10ms	2
+#define     GP2AP070S_PS1_RESOL_8ms	3
+
+#define GP2AP070S_REG_PS2		0x86
+#define   GP2AP070S_PS2_IOUT		GENMASK(6, 4)	/* Current Output */
+#define     GP2AP070S_PS2_IOUT_0mA	0
+#define     GP2AP070S_PS2_IOUT_24mA	1
+#define     GP2AP070S_PS2_IOUT_89mA	2
+#define     GP2AP070S_PS2_IOUT_130mA	3
+#define     GP2AP070S_PS2_IOUT_190mA	4
+#define   GP2AP070S_PS2_SUM32		BIT(2)
+
+#define GP2AP070S_REG_PS3		0x87
+#define   GP2AP070S_PS3_PRST		GENMASK(6, 4)	/* Repeating Measurements */
+
+#define GP2AP070S_REG_PS_THD_LO_LE16	0x88
+#define GP2AP070S_REG_PS_THD_HI_LE16	0x8a
+#define GP2AP070S_REG_D0_LE16		0x90
+
+struct gp2ap070s_drvdata {
+	struct regmap *regmap;
+	struct mutex mutex;
+	u32 near_level;
+};
+
+static bool gp2ap070s_regmap_volatile(struct device *dev, unsigned int reg)
+{
+	return reg == GP2AP070S_REG_D0_LE16;
+}
+
+static const struct regmap_config gp2ap070s_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.volatile_reg = gp2ap070s_regmap_volatile,
+};
+
+static const char *const gp2ap070s_regulator_names[] = {
+	"vdd",
+	"vled",
+};
+
+static ssize_t gp2ap070s_iio_read_near_level(struct iio_dev *indio_dev,
+					     uintptr_t priv,
+					     const struct iio_chan_spec *chan,
+					     char *buf)
+{
+	struct gp2ap070s_drvdata *drvdata = iio_priv(indio_dev);
+
+	return sysfs_emit(buf, "%u\n", drvdata->near_level);
+}
+
+static const struct iio_chan_spec_ext_info gp2ap070s_iio_chan_spec_ext_info[] = {
+	{
+		.name = "nearlevel",
+		.shared = IIO_SEPARATE,
+		.read = gp2ap070s_iio_read_near_level,
+	},
+	{ }
+};
+
+static const struct iio_event_spec gp2ap070s_iio_event_spec[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
+static const struct iio_chan_spec gp2ap070s_iio_chan_spec[] = {
+	{
+		.type = IIO_PROXIMITY,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.ext_info = gp2ap070s_iio_chan_spec_ext_info,
+		.event_spec = gp2ap070s_iio_event_spec,
+		.num_event_specs = ARRAY_SIZE(gp2ap070s_iio_event_spec),
+	},
+};
+
+static int gp2ap070s_iio_read_raw(struct iio_dev *indio_dev,
+				  struct iio_chan_spec const *chan, int *val,
+				  int *val2, long mask)
+{
+	struct gp2ap070s_drvdata *drvdata = iio_priv(indio_dev);
+	__le16 value;
+	int ret;
+
+	ret = regmap_bulk_read(drvdata->regmap, GP2AP070S_REG_D0_LE16, &value,
+			       sizeof(value));
+	if (ret)
+		return ret;
+
+	*val = le16_to_cpu(value);
+	return IIO_VAL_INT;
+}
+
+static int gp2ap070s_iio_read_event_value(struct iio_dev *indio_dev,
+					  const struct iio_chan_spec *chan,
+					  enum iio_event_type type,
+					  enum iio_event_direction dir,
+					  enum iio_event_info info, int *val,
+					  int *val2)
+{
+	struct gp2ap070s_drvdata *drvdata = iio_priv(indio_dev);
+	__le16 value;
+	int ret;
+
+	if (type != IIO_EV_TYPE_THRESH || info != IIO_EV_INFO_VALUE)
+		return -EINVAL;
+
+	guard(mutex)(&drvdata->mutex);
+
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		ret = regmap_bulk_read(drvdata->regmap,
+				       GP2AP070S_REG_PS_THD_HI_LE16, &value,
+				       sizeof(value));
+		if (ret)
+			return ret;
+
+		*val = le16_to_cpu(value);
+		return IIO_VAL_INT;
+	case IIO_EV_DIR_FALLING:
+		ret = regmap_bulk_read(drvdata->regmap,
+				       GP2AP070S_REG_PS_THD_LO_LE16, &value,
+				       sizeof(value));
+		if (ret)
+			return ret;
+
+		*val = le16_to_cpu(value);
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int gp2ap070s_iio_write_event_value(struct iio_dev *indio_dev,
+					   const struct iio_chan_spec *chan,
+					   enum iio_event_type type,
+					   enum iio_event_direction dir,
+					   enum iio_event_info info, int val,
+					   int val2)
+{
+	struct gp2ap070s_drvdata *drvdata = iio_priv(indio_dev);
+	__le16 value;
+	u16 threshold_other;
+	int ret;
+
+	if (type != IIO_EV_TYPE_THRESH || info != IIO_EV_INFO_VALUE)
+		return -EINVAL;
+
+	/* Ensure val is a 16-bit value */
+	if (val < 0 || val >= (1 << 16))
+		return -EINVAL;
+
+	guard(mutex)(&drvdata->mutex);
+
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		ret = regmap_bulk_read(drvdata->regmap,
+				       GP2AP070S_REG_PS_THD_LO_LE16, &value,
+				       sizeof(value));
+		if (ret)
+			return ret;
+
+		/* Ensure lo_threshold < hi_threshold */
+		threshold_other = le16_to_cpu(value);
+		if (threshold_other >= val)
+			return -EINVAL;
+
+		value = cpu_to_le16((u16)val);
+		ret = regmap_bulk_write(drvdata->regmap,
+					GP2AP070S_REG_PS_THD_HI_LE16, &value,
+					sizeof(value));
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT;
+	case IIO_EV_DIR_FALLING:
+		ret = regmap_bulk_read(drvdata->regmap,
+				       GP2AP070S_REG_PS_THD_HI_LE16, &value,
+				       sizeof(value));
+		if (ret)
+			return ret;
+
+		/* Ensure hi_threshold > lo_threshold */
+		threshold_other = le16_to_cpu(value);
+		if (threshold_other <= val)
+			return -EINVAL;
+
+		value = cpu_to_le16((u16)val);
+		ret = regmap_bulk_write(drvdata->regmap,
+					GP2AP070S_REG_PS_THD_LO_LE16, &value,
+					sizeof(value));
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int gp2ap070s_read_event_config(struct iio_dev *indio_dev,
+				       const struct iio_chan_spec *chan,
+				       enum iio_event_type type,
+				       enum iio_event_direction dir)
+{
+	struct gp2ap070s_drvdata *drvdata = iio_priv(indio_dev);
+	unsigned int value;
+	int ret;
+
+	if (type != IIO_EV_TYPE_THRESH)
+		return -EINVAL;
+
+	guard(mutex)(&drvdata->mutex);
+
+	switch (dir) {
+	case IIO_EV_DIR_EITHER:
+		ret = regmap_read(drvdata->regmap, GP2AP070S_REG_COM3, &value);
+		if (ret)
+			return ret;
+
+		return FIELD_GET(GP2AP070S_COM3_INT_PULSE, value);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int gp2ap070s_write_event_config(struct iio_dev *indio_dev,
+					const struct iio_chan_spec *chan,
+					enum iio_event_type type,
+					enum iio_event_direction dir,
+					bool state)
+{
+	struct gp2ap070s_drvdata *drvdata = iio_priv(indio_dev);
+
+	if (type != IIO_EV_TYPE_THRESH)
+		return -EINVAL;
+
+	guard(mutex)(&drvdata->mutex);
+
+	switch (dir) {
+	case IIO_EV_DIR_EITHER:
+		if (state)
+			return regmap_set_bits(drvdata->regmap,
+					       GP2AP070S_REG_COM3,
+					       GP2AP070S_COM3_INT_PULSE);
+		else
+			return regmap_clear_bits(drvdata->regmap,
+						 GP2AP070S_REG_COM3,
+						 GP2AP070S_COM3_INT_PULSE);
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info gp2ap070s_iio_info = {
+	.read_raw = gp2ap070s_iio_read_raw,
+	.read_event_value = gp2ap070s_iio_read_event_value,
+	.write_event_value = gp2ap070s_iio_write_event_value,
+	.read_event_config = gp2ap070s_read_event_config,
+	.write_event_config = gp2ap070s_write_event_config,
+};
+
+static irqreturn_t gp2ap070s_irq_handler(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	s64 timestamp = iio_get_time_ns(indio_dev);
+
+	iio_push_event(indio_dev,
+		       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, 0, IIO_EV_TYPE_THRESH,
+					    IIO_EV_DIR_EITHER),
+		       timestamp);
+
+	return IRQ_HANDLED;
+}
+
+static int gp2ap070s_reset(struct gp2ap070s_drvdata *drvdata)
+{
+	int ret;
+
+	ret = regmap_write(drvdata->regmap, GP2AP070S_REG_COM1, 0);
+	if (ret)
+		return ret;
+
+	regcache_mark_dirty(drvdata->regmap);
+
+	return 0;
+}
+
+static void gp2ap070s_reset_action(void *private)
+{
+	struct gp2ap070s_drvdata *drvdata = private;
+
+	gp2ap070s_reset(drvdata);
+}
+
+static int gp2ap070s_probe_hw_register(struct gp2ap070s_drvdata *drvdata)
+{
+	struct device *dev = regmap_get_device(drvdata->regmap);
+	int ret;
+
+	ret = gp2ap070s_reset(drvdata);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to reset sensor\n");
+
+	ret = regmap_write(drvdata->regmap, GP2AP070S_REG_COM2, 0);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable interrupts\n");
+
+	ret = regmap_set_bits(drvdata->regmap, GP2AP070S_REG_COM3,
+			      GP2AP070S_COM3_INT_PULSE);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to unmask interrupts\n");
+
+	ret = regmap_write_bits(drvdata->regmap, GP2AP070S_REG_COM4,
+				GP2AP070S_COM4_BLINK,
+				FIELD_PREP_CONST(GP2AP070S_COM4_BLINK,
+						 GP2AP070S_COM4_BLINK_33ms));
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to set LED blink timing\n");
+
+	ret = regmap_write_bits(drvdata->regmap, GP2AP070S_REG_PS1,
+				GP2AP070S_PS1_RESOL,
+				FIELD_PREP_CONST(GP2AP070S_PS1_RESOL,
+						 GP2AP070S_PS1_RESOL_10ms));
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to set resolution\n");
+
+	ret = regmap_write_bits(drvdata->regmap, GP2AP070S_REG_PS2,
+				GP2AP070S_PS2_IOUT | GP2AP070S_PS2_SUM32,
+				FIELD_PREP_CONST(GP2AP070S_PS2_IOUT,
+						 GP2AP070S_PS2_IOUT_89mA) |
+				GP2AP070S_PS2_SUM32);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to set current output\n");
+
+	ret = regmap_write_bits(drvdata->regmap, GP2AP070S_REG_PS3,
+				GP2AP070S_PS3_PRST,
+				FIELD_PREP_CONST(GP2AP070S_PS3_PRST, 3));
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to set measurement repetitions\n");
+
+	ret = regmap_set_bits(drvdata->regmap, GP2AP070S_REG_COM1,
+			      GP2AP070S_COM1_WKUP | GP2AP070S_COM1_EN);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable sensor\n");
+
+	return 0;
+}
+
+static int gp2ap070s_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct iio_dev *indio_dev;
+	struct gp2ap070s_drvdata *drvdata;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*drvdata));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	drvdata = iio_priv(indio_dev);
+	drvdata->regmap = devm_regmap_init_i2c(client, &gp2ap070s_regmap_config);
+	if (IS_ERR(drvdata->regmap))
+		return dev_err_probe(dev, PTR_ERR(drvdata->regmap), "Failed to create regmap\n");
+
+	ret = devm_mutex_init(dev, &drvdata->mutex);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to initialize mutex\n");
+
+	ret = devm_regulator_bulk_get_enable(dev,
+					     ARRAY_SIZE(gp2ap070s_regulator_names),
+					     gp2ap070s_regulator_names);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get and enable regulators\n");
+
+	fsleep(10000);
+
+	indio_dev->name = "gp2ap070s";
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = gp2ap070s_iio_chan_spec;
+	indio_dev->num_channels = ARRAY_SIZE(gp2ap070s_iio_chan_spec);
+	indio_dev->info = &gp2ap070s_iio_info;
+
+	if (device_property_present(dev, "proximity-near-level")) {
+		ret = device_property_read_u32(dev, "proximity-near-level",
+					       &drvdata->near_level);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to get value for proximity-near-level\n");
+	}
+
+	ret = gp2ap070s_probe_hw_register(drvdata);
+	if (ret)
+		goto hw_reset;
+
+	ret = devm_add_action_or_reset(dev, gp2ap070s_reset_action, drvdata);
+	if (ret) {
+		ret = dev_err_probe(dev, ret, "Failed to schedule reset on driver removal\n");
+		goto hw_reset;
+	}
+
+	ret = devm_request_threaded_irq(dev, client->irq, NULL,
+					gp2ap070s_irq_handler, IRQF_ONESHOT,
+					"gp2ap070s-irq", indio_dev);
+	if (ret)
+		goto hw_reset;
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		goto hw_reset;
+
+	return 0;
+
+hw_reset:
+	gp2ap070s_reset(drvdata);
+
+	return ret;
+}
+
+static const struct of_device_id gp2ap070s_of_device_id[] = {
+	{ .compatible = "sharp,gp2ap070s" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, gp2ap070s_of_device_id);
+
+static const struct i2c_device_id gp2ap070s_i2c_device_id[] = {
+	{ .name = "gp2ap070s" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, gp2ap070s_i2c_device_id);
+
+static struct i2c_driver gp2ap070s_i2c_driver = {
+	.driver = {
+		.name = "gp2ap070s",
+		.of_match_table = gp2ap070s_of_device_id,
+	},
+	.probe = gp2ap070s_probe,
+	.id_table = gp2ap070s_i2c_device_id,
+};
+module_i2c_driver(gp2ap070s_i2c_driver);
+
+MODULE_AUTHOR("Kaustabh Chakraborty <kauschluss@disroot.org>");
+MODULE_DESCRIPTION("Sharp GP2AP070S Proximity Sensor");
+MODULE_LICENSE("GPL");

-- 
2.54.0

