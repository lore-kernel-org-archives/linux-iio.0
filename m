Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BEC37A4AE
	for <linux-iio@vger.kernel.org>; Mon,  9 Feb 2026 14:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647041; cv=none; b=p4yDg8QSK8Paf+Wxt15o33XjDurbM16df90VS1s/n6/r5NyWUVkv2JGTwHGZZRcEC/0YJ01VLNebe9ALzFSbvI3Dj3KliLa3VU5hGT3LX3k7uhu0wghZPHyI1fJl743wX6bT8oEi4h1rDuwZUggW83fnDgRiqDdhCz7bRUdoZaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647041; c=relaxed/simple;
	bh=OsyREM0IV+qSYUyN1YqdjI5DwBELKrM+6tIWZ17m6xU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A3zH0LVh8SIZRGbXAS/C9GgrB/+FSBFcPks/oGvGeijDFW6eyBnOOFODqJPuEEYKZXz/KwVSLai3RL+Ru0JFXUI8aTFRbj4Zx4SvPTXcaBROpmLnpahd0LNNOAdBBS7svidXsCSKuuYzWVNbs+5gSsV6y+9YaGjfoZ1DR//V15U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ji/ruMaM; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ji/ruMaM"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-790884840baso41612647b3.0
        for <linux-iio@vger.kernel.org>; Mon, 09 Feb 2026 06:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770647040; x=1771251840; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5wBgvUlwBUB6vkvtfXcKzCy8Dov2bTNiJHxepGKqHWc=;
        b=Ji/ruMaMHDTb4gdPuvt94nMhNYEgU3SgIh+EKaubQBMtHVRN0aC3Ca8uw0QslSI/WN
         wupUWl/xrGJ00pxCdJYb/PMlgsn1izIA8eJalSq0/aEtA+5cfpEx8rs5lZP6napVcXTB
         CwmsTYs/8VfjbQVmexV9JhFDZf+1uj8IB4sWurR+C1PdGv6MYXiAqeZificWnw4U9kw8
         bHAPzhzzj8DMCyGPpC3NjYbNgBUA/hHpGrH+vzFQLSHbcDZQBEc2Q/O+8o8rf4BC4KHE
         8ZTX/gpk1sRXZ3lyADqvD4tUCttSRzChWsQCIdQ31rRfWq0FrpxJZYYhZVtFiMC9e/s3
         JgVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770647040; x=1771251840;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5wBgvUlwBUB6vkvtfXcKzCy8Dov2bTNiJHxepGKqHWc=;
        b=PDtPLqkkfQtZn8RPMWNMWmvYLAi40IdmekaGe2mztnvHTkrk2KgdI1Lh6ASmYBGu4Q
         EQGpPlFb9ER+H5cs/8Y5Vc4V1WeE5xC6DzEJvUssutMJX9Y3fx5ufhapoAwhc+qzknxC
         Cb8GXrrOh5uOozbtk+WrAYeFitZBVxrJWdxL7n4a3SM0XqxuWi+yceBuNXoC6BNLzd4N
         L9vdvI0Hf8MEWdLWxnKzWGraVQ4MTufdNZR+VZOgsSbL/pu6APazrAOxTnT5aMcU4i5J
         DZD+LLCdZ2rOAM2rE+6MwwmjraHLqrgFzQ9oPuUdwMKAnR7qBLWSWrot6LFONLrZD9Ih
         R3PA==
X-Gm-Message-State: AOJu0Yx/2BSZeqIPqZ0MwbDv9gH6jbryD9ktfvr+zgXMQGASsLoa3NbZ
	XkwxqYmx7zIXy/NJU6br4/YAgpCZ2XfFeq8Ke+PW8JxCw6PihgvEH27q
X-Gm-Gg: AZuq6aKiHuyHQXluMhfVUapJQNMTMaV6IDcjR6ht3m+4tlpijYWSKWfJXegrrVHbaCZ
	YMb++8c9oVNAnQ9H4FmEFRcLdwPpzQ636dc2bjihymCgLX5uoQ5Dj40NaTOcjJbdC7UY48fUgIk
	aBMvfGbcWxGJNaIm8bIRGT9clkhY12Akt+Kh4Uh7JuMBAZpGsgY4LNVPZkxZ4YyHf2NzukeaDZL
	63n5RPCrTi9MjnlWf6yZ19Nw1wcM1GHnxqbgBaIbgVGJM8b+gfyZn+JcFbNO4uVJuiFkTIy/xSo
	u0HFLwd0Wt9nBee0SUAeZ1IMfUpi/wZtD8pI/gqQsDqZJa5A6+tRU2tejwZ+MYS2Fe8uA7dXSyu
	gmcWde5Hyq4CVYDioPRMOO+3oCoaRGGtlw3qJK/YYn3fMsu6QcU9tG8MjKVSM7WE1ormhSli/Mi
	2pOZYdUwuL4Jg/TA==
X-Received: by 2002:a05:690c:c85:b0:794:ef94:122e with SMTP id 00721157ae682-7952aa92b37mr125181757b3.25.1770647039900;
        Mon, 09 Feb 2026 06:23:59 -0800 (PST)
Received: from [192.168.0.40] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7952a0467easm92497947b3.13.2026.02.09.06.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 06:23:59 -0800 (PST)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Date: Mon, 09 Feb 2026 16:23:42 +0200
Subject: [PATCH v2 2/2] iio: light: Add support for Capella cm36686 and
 cm36672p sensors
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-cm36686-v2-2-a48126d2b124@gmail.com>
References: <20260209-cm36686-v2-0-a48126d2b124@gmail.com>
In-Reply-To: <20260209-cm36686-v2-0-a48126d2b124@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kevin Tsai <ktsai@capellamicro.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 phone-devel@vger.kernel.org, Erikas Bitovtas <xerikasxx@gmail.com>
X-Mailer: b4 0.14.3

This driver adds the initial support for the Capella cm36686
ambient light and proximity sensor and cm36672p proximity sensor.

Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
 drivers/iio/light/Kconfig   |  11 +
 drivers/iio/light/Makefile  |   1 +
 drivers/iio/light/cm36686.c | 940 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 952 insertions(+)

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index ac1408d374c9..b1d1943dec33 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -220,6 +220,17 @@ config CM36651
 	  To compile this driver as a module, choose M here:
 	  the module will be called cm36651.
 
+config CM36686
+	depends on I2C
+	tristate "CM36686 driver"
+	help
+	  Say Y here if you use cm36686.
+	  This option enables ambient light & proximity sensor using
+	  Capella cm36686 device driver.
+
+	  To compile this driver as a module, choose M here:
+	  the module will be called cm36686.
+
 config IIO_CROS_EC_LIGHT_PROX
 	tristate "ChromeOS EC Light and Proximity Sensors"
 	depends on IIO_CROS_EC_SENSORS_CORE
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index c0048e0d5ca8..806df80f6454 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_CM3232)		+= cm3232.o
 obj-$(CONFIG_CM3323)		+= cm3323.o
 obj-$(CONFIG_CM3605)		+= cm3605.o
 obj-$(CONFIG_CM36651)		+= cm36651.o
+obj-$(CONFIG_CM36686)		+= cm36686.o
 obj-$(CONFIG_IIO_CROS_EC_LIGHT_PROX) += cros_ec_light_prox.o
 obj-$(CONFIG_GP2AP002)		+= gp2ap002.o
 obj-$(CONFIG_GP2AP020A00F)	+= gp2ap020a00f.o
diff --git a/drivers/iio/light/cm36686.c b/drivers/iio/light/cm36686.c
new file mode 100644
index 000000000000..aa1958cb0d7d
--- /dev/null
+++ b/drivers/iio/light/cm36686.c
@@ -0,0 +1,940 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/**
+ * Copyright (C) 2026 Erikas Bitovtas <xerikasxx@gmail.com>
+ *
+ * Based on downstream driver created by Capella Microsystems and modified
+ * by ASUS in drivers/misc/input/cm36283.c found in android_kernel_asus_msm8916
+ * Based on downstream IIO driver created by Qian Wenfa of Xiaomi
+ * in android_kernel_xiaomi_msm8992 in drivers/iio/light/cm36686.c
+ * Based on previous mailing list submission for cm36672p by Kevin Tsai:
+ * https://lore.kernel.org/linux-iio/1465462845-1571-1-git-send-email-capellamicro@gmail.com/
+ */
+
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/cleanup.h>
+#include <linux/dev_printk.h>
+#include <linux/device/devres.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/sysfs.h>
+
+#include <linux/iio/events.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/types.h>
+
+/* Device registers */
+#define CM36686_REG_ALS_CONF		0x00
+#define CM36686_REG_PS_CONF1		0x03
+#define CM36686_REG_PS_CONF3		0x04
+#define CM36686_REG_PS_THDL		0x06
+#define CM36686_REG_PS_THDH		0x07
+#define CM36686_REG_PS_DATA		0x08
+#define CM36686_REG_ALS_DATA		0x09
+#define CM36686_REG_INT_FLAG		0x0B
+#define CM36686_REG_ID_FLAG		0x0C
+#define CM36686_MAX_REG		0x0D
+
+/* ALS_CONF */
+#define CM36686_ALS_IT			GENMASK(7, 6)
+#define CM36686_ALS_GAIN		GENMASK(3, 2)
+#define CM36686_ALS_INT_EN		BIT(1)
+#define CM36686_ALS_SD			BIT(0)
+
+/* PS_CONF1 */
+#define CM36686_PS_DR			GENMASK(7, 6)
+#define CM36686_PS_PERS		GENMASK(5, 4)
+#define CM36686_PS_IT			GENMASK(3, 1)
+#define CM36686_PS_SD			BIT(0)
+
+#define CM36686_PS_INT_OUT		BIT(9)
+#define CM36686_PS_INT_IN		BIT(8)
+
+/* PS_CONF3 */
+#define CM36686_PS_SMART_PERS_ENABLE	BIT(4)
+
+#define CM36686_LED_I			GENMASK(10, 8)
+
+/* INT_FLAG */
+#define CM36686_INT_FLAG_PS_IF_MASK	GENMASK(9, 8)
+
+/* Default values */
+#define CM36686_ALS_ENABLE		0x00
+#define CM36686_PS_PERS_2		1
+#define CM36686_LED_I_50		0
+
+/* Max proximity thresholds */
+#define CM36686_MAX_PS_VALUE		(BIT(12) - 1)
+
+#define CM36686_DEVICE_ID		0x86
+
+static const struct reg_field reg_field_als_it =
+				REG_FIELD(CM36686_REG_ALS_CONF, 6, 7);
+static const struct reg_field reg_field_ps_it =
+				REG_FIELD(CM36686_REG_PS_CONF1, 1, 3);
+static const struct reg_field reg_field_ps_int_in =
+				REG_FIELD(CM36686_REG_PS_CONF1, 8, 8);
+static const struct reg_field reg_field_ps_int_out =
+				REG_FIELD(CM36686_REG_PS_CONF1, 9, 9);
+
+enum cm36686_distance {
+	CM36686_AWAY = 1,
+	CM36686_CLOSE,
+	CM36686_BOTH,
+};
+
+static const int cm36686_als_it_times[][2] = {
+	{ 0, 80000 },
+	{ 0, 160000 },
+	{ 0, 320000 },
+	{ 0, 640000 },
+};
+
+static const int cm36686_ps_it_times[][2] = {
+	{ 0, 80 },
+	{ 0, 120 },
+	{ 0, 160 },
+	{ 0, 200 },
+	{ 0, 240 },
+	{ 0, 280 },
+	{ 0, 320 },
+	{ 0, 640 },
+};
+
+static const int cm36686_ps_led_current_uA[] = {
+	50000,
+	75000,
+	100000,
+	120000,
+	140000,
+	160000,
+	180000,
+	200000
+};
+
+struct cm36686_data {
+	/* Mutex lock to prevent simultaneous reads/writes into registers */
+	struct mutex lock;
+	struct i2c_client *client;
+	struct regmap *regmap;
+	struct regmap_field *reg_als_it;
+	struct regmap_field *reg_ps_it;
+	struct regmap_field *reg_ps_int_in;
+	struct regmap_field *reg_ps_int_out;
+	int glass_factor;
+};
+
+struct cm366xx_chip_info {
+	const char *name;
+	const struct iio_info *indio_info;
+	const struct iio_info *indio_info_no_irq;
+	const struct iio_chan_spec *channels;
+	const int num_channels;
+	const struct iio_chan_spec *channels_no_events;
+	const int num_channels_no_events;
+};
+
+static int cm36686_current_to_index(int led_current)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(cm36686_ps_led_current_uA); i++)
+		if (led_current <= cm36686_ps_led_current_uA[i])
+			return i;
+
+	return -EINVAL;
+}
+
+static ssize_t cm36686_read_near_level(struct iio_dev *indio_dev,
+				       uintptr_t priv,
+				       const struct iio_chan_spec *chan,
+				       char *buf)
+{
+	struct cm36686_data *chip = iio_priv(indio_dev);
+	struct regmap *regmap = chip->regmap;
+	struct device *dev = &chip->client->dev;
+
+	int ps_close;
+	int ret = regmap_read(regmap, CM36686_REG_PS_THDH, &ps_close);
+
+	if (ret < 0) {
+		dev_err(dev, "Failed to read proximity near level");
+		return ret;
+	}
+
+	return sysfs_emit(buf, "%u\n", ps_close);
+}
+
+static const struct iio_chan_spec_ext_info cm36686_ext_info[] = {
+	{
+		.name = "nearlevel",
+		.shared = IIO_SEPARATE,
+		.read = cm36686_read_near_level,
+	},
+	{ }
+};
+
+static const struct iio_event_spec cm36686_proximity_event_spec[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+				 BIT(IIO_EV_INFO_ENABLE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+				 BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
+static const struct iio_chan_spec cm36686_channels[] = {
+	{
+		.type = IIO_LIGHT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_INT_TIME) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_INT_TIME),
+		.address = CM36686_REG_ALS_DATA,
+	},
+	{
+		.type = IIO_PROXIMITY,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_INT_TIME),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_INT_TIME),
+		.address = CM36686_REG_PS_DATA,
+		.event_spec = cm36686_proximity_event_spec,
+		.num_event_specs = ARRAY_SIZE(cm36686_proximity_event_spec),
+		.ext_info = cm36686_ext_info,
+	},
+};
+
+static const struct iio_chan_spec cm36686_channels_no_events[] = {
+	{
+		.type = IIO_LIGHT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_INT_TIME) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_INT_TIME),
+		.address = CM36686_REG_ALS_DATA,
+	},
+	{
+		.type = IIO_PROXIMITY,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_INT_TIME),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_INT_TIME),
+		.address = CM36686_REG_PS_DATA,
+		.ext_info = cm36686_ext_info,
+	},
+};
+
+static const struct iio_chan_spec cm36672p_channels[] = {
+	{
+		.type = IIO_PROXIMITY,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_INT_TIME),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_INT_TIME),
+		.address = CM36686_REG_PS_DATA,
+		.event_spec = cm36686_proximity_event_spec,
+		.num_event_specs = ARRAY_SIZE(cm36686_proximity_event_spec),
+		.ext_info = cm36686_ext_info,
+	},
+};
+
+static const struct iio_chan_spec cm36672p_channels_no_events[] = {
+	{
+		.type = IIO_PROXIMITY,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_INT_TIME),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_INT_TIME),
+		.address = CM36686_REG_PS_DATA,
+		.ext_info = cm36686_ext_info,
+	},
+};
+
+static int cm36686_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      const int **vals, int *type, int *length,
+			      long mask)
+{
+	if (mask != IIO_CHAN_INFO_INT_TIME)
+		return -EINVAL;
+
+	switch (chan->type) {
+	case IIO_LIGHT:
+		*vals = (int *)(cm36686_als_it_times);
+		*length = 2 * ARRAY_SIZE(cm36686_als_it_times);
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		return IIO_AVAIL_LIST;
+	case IIO_PROXIMITY:
+		*vals = (int *)(cm36686_ps_it_times);
+		*length = 2 * ARRAY_SIZE(cm36686_ps_it_times);
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int cm36686_read_channel(struct cm36686_data *chip,
+				struct iio_chan_spec const *chan, int *val)
+{
+	struct regmap *regmap = chip->regmap;
+	int ret = regmap_read(regmap, chan->address, val);
+
+	if (ret < 0)
+		return -EIO;
+
+	return IIO_VAL_INT;
+}
+
+/**
+ * This is taken from Xiaomi's driver for cm36686. The device tree for cm36686
+ * in android_kernel_xiaomi_msm8992 includes a property called
+ * "als_trans_ratio". This property seems to be a number by which the actual
+ * device lux scale is multiplied. What we know for sure is that it is
+ * set to 16, and integration time in downstream is set to 160ms. Using this
+ * "als_trans_ratio" property, Xiaomi calculates scale like this:
+ * scale = als_trans_ratio * 40,000
+ * val = scale / 1,000,000
+ * val2 = scale % 1,000,000
+ * In our driver, however, integration time can be adjusted, so if it changes
+ * during runtime, the scale will be incorrect and lux value will be reported
+ * double or half what it actually is, depending on whether we increase or
+ * decrease integration time. In order to preserve the proportion by which the
+ * scale is calculated, we multiply "als_trans_ratio" (16) by 160ms and then
+ * divide it by our current integration time. This gives us new
+ * "als_trans_ratio" by which the scale will be calculated.
+ * Unfortunately, since the datasheet for this sensor is unavailable, this
+ * guess is the best we have at the moment.
+ */
+static int cm36686_read_scale(struct cm36686_data *chip,
+			      struct iio_chan_spec const *chan, int *val,
+			      int *val2)
+{
+	int als_index;
+	int ret;
+
+	if (chan->type != IIO_LIGHT)
+		return -EINVAL;
+
+	ret = regmap_field_read(chip->reg_als_it, &als_index);
+	if (ret < 0)
+		return ret;
+
+	int als_it = cm36686_als_it_times[als_index][1];
+	int scale = (chip->glass_factor * 160000 / als_it) * 40000;
+
+	*val = scale / 1000000;
+	*val2 = scale % 1000000;
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int cm36686_read_int_time(struct cm36686_data *chip,
+				 struct iio_chan_spec const *chan, int *val,
+				 int *val2)
+{
+	int als_it_index, ps_it_index;
+	int ret;
+
+	switch (chan->type) {
+	case IIO_LIGHT:
+		ret = regmap_field_read(chip->reg_als_it, &als_it_index);
+		if (ret < 0)
+			return ret;
+		*val = cm36686_als_it_times[als_it_index][0];
+		*val2 = cm36686_als_it_times[als_it_index][1];
+		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_PROXIMITY:
+		ret = regmap_field_read(chip->reg_ps_it, &ps_it_index);
+		if (ret < 0)
+			return ret;
+		*val = cm36686_ps_it_times[ps_it_index][0];
+		*val2 = cm36686_ps_it_times[ps_it_index][1];
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int cm36686_write_light_int_time(struct cm36686_data *chip, int val2)
+{
+	int index = -1, ret;
+
+	for (int i = 0; i < ARRAY_SIZE(cm36686_als_it_times); i++) {
+		if (cm36686_als_it_times[i][1] == val2) {
+			index = i;
+			break;
+		}
+	}
+
+	if (index == -1)
+		return -EINVAL;
+
+	ret = regmap_field_write(chip->reg_als_it, index);
+	return ret;
+}
+
+static int cm36686_write_prox_int_time(struct cm36686_data *chip, int val2)
+{
+	int index = -1, ret;
+
+	for (int i = 0; i < ARRAY_SIZE(cm36686_ps_it_times); i++) {
+		if (cm36686_ps_it_times[i][1] == val2) {
+			index = i;
+			break;
+		}
+	}
+
+	if (index == -1)
+		return -EINVAL;
+
+	ret = regmap_field_write(chip->reg_ps_it, index);
+	return ret;
+}
+
+static int cm36686_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int *val,
+			    int *val2, long mask)
+{
+	struct cm36686_data *chip = iio_priv(indio_dev);
+
+	guard(mutex)(&chip->lock);
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		return cm36686_read_channel(chip, chan, val);
+	case IIO_CHAN_INFO_SCALE:
+		return cm36686_read_scale(chip, chan, val, val2);
+	case IIO_CHAN_INFO_INT_TIME:
+		return cm36686_read_int_time(chip, chan, val, val2);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int cm36686_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, int val,
+			     int val2, long mask)
+{
+	struct cm36686_data *chip = iio_priv(indio_dev);
+
+	if (val) /* Integration time more than 1s is not supported */
+		return -EINVAL;
+
+	if (mask != IIO_CHAN_INFO_INT_TIME)
+		return -EINVAL;
+
+	guard(mutex)(&chip->lock);
+	switch (chan->type) {
+	case IIO_LIGHT:
+		return cm36686_write_light_int_time(chip, val2);
+	case IIO_PROXIMITY:
+		return cm36686_write_prox_int_time(chip, val2);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int cm36686_read_prox_thresh(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir,
+				    enum iio_event_info info, int *val,
+				    int *val2)
+{
+	struct cm36686_data *chip = iio_priv(indio_dev);
+	struct regmap *regmap = chip->regmap;
+	int ret;
+
+	if (chan->type != IIO_PROXIMITY)
+		return -EINVAL;
+
+	guard(mutex)(&chip->lock);
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		ret = regmap_read(regmap, CM36686_REG_PS_THDH, val);
+		break;
+	case IIO_EV_DIR_FALLING:
+		ret = regmap_read(regmap, CM36686_REG_PS_THDL, val);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (ret < 0)
+		return ret;
+
+	return IIO_VAL_INT;
+}
+
+static int cm36686_write_prox_thresh(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir,
+				     enum iio_event_info info, int val,
+				     int val2)
+{
+	struct cm36686_data *chip = iio_priv(indio_dev);
+	struct regmap *regmap = chip->regmap;
+	int ps_close, ps_away, address;
+	int ret;
+
+	if (chan->type != IIO_PROXIMITY)
+		return -EINVAL;
+
+	ret = regmap_read(regmap, CM36686_REG_PS_THDH, &ps_close);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_read(regmap, CM36686_REG_PS_THDL, &ps_away);
+	if (ret < 0)
+		return ret;
+
+	switch (dir) {
+	case IIO_EV_DIR_FALLING:
+		if (val > ps_close || val < 0)
+			return -EINVAL;
+
+		address = CM36686_REG_PS_THDL;
+		break;
+	case IIO_EV_DIR_RISING:
+		if (val < ps_away || val > CM36686_MAX_PS_VALUE)
+			return -EINVAL;
+
+		address = CM36686_REG_PS_THDH;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	guard(mutex)(&chip->lock);
+	ret = regmap_write(regmap, address, val);
+
+	return ret;
+}
+
+static int cm36686_read_prox_event_config(struct iio_dev *indio_dev,
+					  const struct iio_chan_spec *chan,
+					  enum iio_event_type type,
+					  enum iio_event_direction dir)
+{
+	struct cm36686_data *chip = iio_priv(indio_dev);
+	struct regmap_field *reg_field;
+	int state;
+	int ret;
+
+	if (chan->type != IIO_PROXIMITY)
+		return -EINVAL;
+
+	switch (dir) {
+	case IIO_EV_DIR_FALLING:
+		reg_field = chip->reg_ps_int_out;
+		break;
+	case IIO_EV_DIR_RISING:
+		reg_field = chip->reg_ps_int_in;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	guard(mutex)(&chip->lock);
+	ret = regmap_field_read(reg_field, &state);
+	if (ret < 0)
+		return ret;
+
+	return state;
+}
+
+static int cm36686_write_prox_event_config(struct iio_dev *indio_dev,
+					   const struct iio_chan_spec *chan,
+					   enum iio_event_type type,
+					   enum iio_event_direction dir,
+					   bool state)
+{
+	struct cm36686_data *chip = iio_priv(indio_dev);
+	struct regmap_field *reg_field;
+	int ret;
+
+	if (chan->type != IIO_PROXIMITY)
+		return -EINVAL;
+
+	switch (dir) {
+	case IIO_EV_DIR_FALLING:
+		reg_field = chip->reg_ps_int_out;
+		break;
+	case IIO_EV_DIR_RISING:
+		reg_field = chip->reg_ps_int_in;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	guard(mutex)(&chip->lock);
+	ret = regmap_field_write(reg_field, state);
+
+	return ret;
+}
+
+static int cm36686_fallback_read_ps(struct iio_dev *indio_dev)
+{
+	struct cm36686_data *chip = iio_priv(indio_dev);
+	struct regmap *regmap = chip->regmap;
+	int ps_close, ps_away, data;
+	int ret;
+
+	ret = regmap_read(regmap, CM36686_REG_PS_THDH, &ps_close);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_read(regmap, CM36686_REG_PS_THDL, &ps_away);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_read(regmap, CM36686_REG_PS_DATA, &data);
+	if (ret < 0)
+		return ret;
+
+	if (data < ps_away)
+		return IIO_EV_DIR_FALLING;
+	else if (data > ps_close)
+		return IIO_EV_DIR_RISING;
+	return IIO_EV_DIR_EITHER;
+}
+
+static irqreturn_t cm36686_irq_handler(int irq, void *data)
+{
+	struct iio_dev *indio_dev = data;
+	struct cm36686_data *chip = iio_priv(indio_dev);
+	struct i2c_client *client = chip->client;
+	struct regmap *regmap = chip->regmap;
+	int ev_dir, ret, status;
+	u64 ev_code;
+
+	/* Reading the interrupt flag acknowledges the interrupt */
+	ret = regmap_read(regmap, CM36686_REG_INT_FLAG, &status);
+	if (ret < 0) {
+		dev_err_ratelimited(&client->dev,
+			"Interrupt flag register read failed: %pe",
+			ERR_PTR(ret));
+		return IRQ_HANDLED;
+	}
+
+	status = FIELD_GET(CM36686_INT_FLAG_PS_IF_MASK, status);
+	switch (status) {
+	case CM36686_CLOSE:
+		ev_dir = IIO_EV_DIR_RISING;
+		break;
+	case CM36686_AWAY:
+		ev_dir = IIO_EV_DIR_FALLING;
+		break;
+	case CM36686_BOTH:
+		ev_dir = cm36686_fallback_read_ps(indio_dev);
+		if (ev_dir < 0) {
+			dev_err_ratelimited(&client->dev,
+				"Failed to settle interrupt state: %pe",
+				ERR_PTR(ret));
+			return IRQ_HANDLED;
+		}
+		break;
+	default:
+		dev_err_ratelimited(&client->dev,
+		      "Unknown interrupt state: %x", status);
+		return IRQ_HANDLED;
+	}
+	ev_code = IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, IIO_EV_INFO_VALUE,
+				       IIO_EV_TYPE_THRESH, ev_dir);
+
+	iio_push_event(indio_dev, ev_code, iio_get_time_ns(indio_dev));
+	return IRQ_HANDLED;
+}
+
+static const struct iio_info cm36686_info = {
+	.read_avail =		cm36686_read_avail,
+	.read_raw =		cm36686_read_raw,
+	.write_raw =		cm36686_write_raw,
+	.read_event_value =	cm36686_read_prox_thresh,
+	.write_event_value =	cm36686_write_prox_thresh,
+	.read_event_config =	cm36686_read_prox_event_config,
+	.write_event_config =	cm36686_write_prox_event_config,
+};
+
+static const struct iio_info cm36686_info_no_irq = {
+	.read_avail =		cm36686_read_avail,
+	.read_raw =		cm36686_read_raw,
+	.write_raw =		cm36686_write_raw,
+};
+
+static const struct cm366xx_chip_info cm36686_chip_info = {
+	.name = "cm36686",
+	.indio_info = &cm36686_info,
+	.indio_info_no_irq = &cm36686_info_no_irq,
+	.channels = cm36686_channels,
+	.num_channels = ARRAY_SIZE(cm36686_channels),
+	.channels_no_events = cm36686_channels_no_events,
+	.num_channels_no_events = ARRAY_SIZE(cm36686_channels_no_events),
+};
+
+static const struct cm366xx_chip_info cm36672p_chip_info = {
+	.name = "cm36672p",
+	.indio_info = &cm36686_info,
+	.indio_info_no_irq = &cm36686_info_no_irq,
+	.channels = cm36672p_channels,
+	.num_channels = ARRAY_SIZE(cm36672p_channels),
+	.channels_no_events = cm36672p_channels_no_events,
+	.num_channels_no_events = ARRAY_SIZE(cm36672p_channels_no_events),
+};
+
+static bool cm36686_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	if (reg >= CM36686_REG_PS_DATA)
+		return true;
+	return false;
+}
+
+static bool cm36686_is_precious_reg(struct device *dev, unsigned int reg)
+{
+	if (reg == CM36686_REG_INT_FLAG)
+		return true;
+	return false;
+}
+
+static const struct regmap_config cm36686_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 16,
+	.cache_type = REGCACHE_MAPLE,
+	.max_register = CM36686_MAX_REG,
+	.volatile_reg = cm36686_is_volatile_reg,
+	.precious_reg = cm36686_is_precious_reg,
+	.val_format_endian = REGMAP_ENDIAN_LITTLE,
+};
+
+static int cm36686_setup(struct cm36686_data *chip, struct iio_dev *indio_dev)
+{
+	struct i2c_client *client = chip->client;
+	struct regmap *regmap = chip->regmap;
+	struct device *dev = &client->dev;
+	const struct cm366xx_chip_info *info = i2c_get_match_data(client);
+	int led_current, led_index;
+	int als_conf;
+	int ps_conf1, ps_conf3;
+	int ps_close, ps_away;
+	int ret;
+
+	als_conf = CM36686_ALS_ENABLE;
+
+	ret = regmap_write(regmap, CM36686_REG_ALS_CONF, als_conf);
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+			"Failed to enable ambient light sensor");
+
+	/* Set proximity sensor persistence to two to prevent
+	 * false triggering of the interrupt when probing the
+	 * driver.
+	 */
+	ps_conf1 = FIELD_PREP(CM36686_PS_PERS, CM36686_PS_PERS_2);
+	if (client->irq)
+		ps_conf1 |= CM36686_PS_INT_IN | CM36686_PS_INT_OUT;
+
+	ret = regmap_write(regmap, CM36686_REG_PS_CONF1, ps_conf1);
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+		       "Failed to enable proximity sensor");
+
+	ps_conf3 = CM36686_PS_SMART_PERS_ENABLE;
+
+	led_index = CM36686_LED_I_50;
+	ret = device_property_read_u32(dev,
+		"capella,proximity-led-current-milliamp", &led_current);
+	if (!ret) {
+		led_index = cm36686_current_to_index(led_current);
+		if (led_index < 0)
+			return dev_err_probe(dev, led_index,
+				"Failed to find appropriate IR LED current.");
+	} else if (ret != -EINVAL) {
+		return dev_err_probe(dev, ret,
+		       "Failed to read IR LED current.");
+	}
+
+	FIELD_MODIFY(CM36686_LED_I, &ps_conf3, led_index);
+
+	ret = regmap_write(regmap, CM36686_REG_PS_CONF3, ps_conf3);
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+			"Failed to enable proximity sensor");
+
+	if (device_property_read_u32(dev, "capella,glass-factor",
+			      &chip->glass_factor))
+		chip->glass_factor = 1;
+
+	if (device_property_read_u32(dev, "proximity-near-level", &ps_close))
+		ps_close = 0;
+	ps_away = ps_close;
+
+	ret = regmap_write(regmap, CM36686_REG_PS_THDH, ps_close);
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+			"Failed to set close proximity threshold");
+
+	ret = regmap_write(regmap, CM36686_REG_PS_THDL, ps_away);
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+			"Failed to set away proximity threshold");
+
+	indio_dev->name = info->name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	if (client->irq) {
+		indio_dev->info = info->indio_info;
+		indio_dev->channels = info->channels;
+		indio_dev->num_channels = info->num_channels;
+
+		ret = devm_request_threaded_irq(dev, client->irq,
+						NULL, cm36686_irq_handler,
+						IRQF_TRIGGER_FALLING |
+						IRQF_ONESHOT,
+						indio_dev->name, indio_dev);
+		if (ret < 0)
+			return dev_err_probe(dev, ret,
+			       "Failed to request irq");
+	} else {
+		indio_dev->info = info->indio_info_no_irq;
+		indio_dev->channels = info->channels_no_events;
+		indio_dev->num_channels = info->num_channels_no_events;
+	}
+
+	return 0;
+}
+
+static void cm36686_shutdown(void *data)
+{
+	struct cm36686_data *chip = data;
+	struct i2c_client *client = chip->client;
+	int ret;
+
+	ret = regmap_set_bits(chip->regmap, CM36686_REG_ALS_CONF,
+			      CM36686_ALS_SD);
+	if (ret < 0)
+		dev_err(&client->dev, "Failed to shutdown ALS");
+
+	ret = regmap_set_bits(chip->regmap, CM36686_REG_PS_CONF1,
+			      CM36686_PS_SD);
+	if (ret < 0)
+		dev_err(&client->dev, "Failed to shutdown PS");
+}
+
+static int cm36686_probe(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev;
+	struct cm36686_data *chip;
+	struct device *dev = &client->dev;
+	struct regmap *regmap;
+	int ret, partid;
+	static const char * const regulator_names[] = { "vdd", "vddio",
+		"vled" };
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*chip));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	chip = iio_priv(indio_dev);
+
+	regmap = devm_regmap_init_i2c(client, &cm36686_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap),
+				     "Failed to initialize regmap");
+
+	chip->client = client;
+	chip->regmap = regmap;
+
+	ret = devm_mutex_init(dev, &chip->lock);
+	if (ret < 0)
+		return ret;
+
+	ret = devm_regulator_bulk_get_enable(dev,
+					     ARRAY_SIZE(regulator_names),
+					     regulator_names);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to enable regulators");
+
+	chip->reg_als_it = devm_regmap_field_alloc(dev, regmap,
+		reg_field_als_it);
+	if (IS_ERR(chip->reg_als_it))
+		return dev_err_probe(dev, PTR_ERR(chip->reg_als_it),
+			"Failed to initialize ALS it reg field");
+
+	chip->reg_ps_it = devm_regmap_field_alloc(dev, regmap,
+		reg_field_ps_it);
+	if (IS_ERR(chip->reg_ps_it))
+		return dev_err_probe(dev, PTR_ERR(chip->reg_ps_it),
+			"Failed to initialize PS it reg field");
+
+	chip->reg_ps_int_in = devm_regmap_field_alloc(dev, regmap,
+		reg_field_ps_int_in);
+	if (IS_ERR(chip->reg_ps_int_in))
+		return dev_err_probe(dev, PTR_ERR(chip->reg_ps_int_in),
+			"Failed to initialize PS int in field");
+
+	chip->reg_ps_int_out = devm_regmap_field_alloc(dev, regmap,
+		reg_field_ps_int_out);
+	if (IS_ERR(chip->reg_ps_int_out))
+		return dev_err_probe(dev, PTR_ERR(chip->reg_ps_int_out),
+			"Failed to initialize PS int out field");
+
+	ret = regmap_read(chip->regmap, CM36686_REG_ID_FLAG, &partid);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to read device ID");
+
+	partid &= 0xff;
+	if (partid != CM36686_DEVICE_ID)
+		dev_warn(dev, "Device ID: %02x, expected: %02x", partid,
+			CM36686_DEVICE_ID);
+
+
+	ret = cm36686_setup(chip, indio_dev);
+	if (ret < 0)
+		return ret;
+
+	ret = devm_add_action_or_reset(dev, cm36686_shutdown, chip);
+	if (ret)
+		return dev_err_probe(dev, ret,
+			"Failed to set shutdown action");
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct i2c_device_id cm36686_id[] = {
+	{ "cm36686", (kernel_ulong_t)&cm36686_chip_info },
+	{ "cm36672p", (kernel_ulong_t)&cm36672p_chip_info },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(i2c, cm36686_id);
+
+static const struct of_device_id cm36686_of_match[] = {
+	{ .compatible = "capella,cm36686", .data = &cm36686_chip_info, },
+	{ .compatible = "capella,cm36672p", .data = &cm36672p_chip_info, },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, cm36686_of_match);
+
+static struct i2c_driver cm36686_driver = {
+	.driver = {
+		.name = "cm36686",
+		.of_match_table = cm36686_of_match,
+	},
+	.probe = cm36686_probe,
+	.id_table = cm36686_id,
+};
+module_i2c_driver(cm36686_driver);
+
+MODULE_AUTHOR("Erikas Bitovtas <xerikasxx@gmail.com>");
+MODULE_DESCRIPTION("CM36686 ambient light and proximity sensor driver");
+MODULE_LICENSE("GPL");

-- 
2.53.0

