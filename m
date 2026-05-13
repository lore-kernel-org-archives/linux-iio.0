Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B133377007
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 04:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778647844; cv=none; b=c1LGDmYt9PJdprBONZNKgx+lEpv7UhqP/Nc8OYGLho337dlBI4+K3TVOw39vHtW+F0mMiezIsIWG9bBSTxh8XwkwbrCRO8qJsu/61E9yBaunLQA8xOu76BGWDNDrjVtsM9VJGHJnczpA3H8GSPAzYeIFQ3GbVzc4zZhvLITF/1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778647844; c=relaxed/simple;
	bh=cvTs1n2sPa+E3ZhXZBr9BC7sH1tYAtYHPZZTk5ec8Ho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UTqYrpan2vsEXN0gL5oR90moelY0K5cpASKvV7l/jCXKbQC3NlGtBhftkIg6iqz6iim2CU8TZAhiPDh/P/AhLZDR1Kzf8KyjabUi3kW1SHoNsst7eRyDz8DVBiZhdHatpKuva1FO7eafQhp8h+AksCqsOl6Fvdj4YKTKiawwaNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYNKqrL7; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYNKqrL7"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-839dc688d6cso2548937b3a.2
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 21:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778647841; x=1779252641; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bKXwJb+LssX9P49yFim1pRUPEBYZl2twCLYbgVax7rY=;
        b=iYNKqrL7qjMH5xTC0H1Dq/rvVPCag7XA7WvScf3g315VZTQk1qcv6xJ388r2RE1MOE
         6nMvesst0jeMxK6rK4u8jH6NjBqzvza9BtZ/w7ZuAYIH1pyKbq3zeYIUmDfG8DIXZmca
         cXDOKU+mRwmxT6K2IWiDR7/kW+l6XhqIGiDH5cwNKcKJskXzF/YYSrZbfkqMGwT0Jc66
         dc7lWpJSSLxygiSqMKIgZmGRlAG7Q7jgG7gzmQYmPiMkegbHW4BmR5LZFogNuV24aOnU
         aon7cY0wb3is+mtv+GJPOwoCxkaHZr4ZDxi9YFHJ4cD1EZwK7/jORj4gQoPfD4/leiRN
         BdaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778647841; x=1779252641;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bKXwJb+LssX9P49yFim1pRUPEBYZl2twCLYbgVax7rY=;
        b=FOadEdBZ26iTUg5DJI0VB0Dz0P91Xvjk2QQv1xX4Rj/IByKppV2SLmkZugdo57uIav
         jC8rilHW9lsj1R9etPMFX/gQCzWLmxmnXbnt6tQnnTf3+zqGa5c+bglF9ygaMhb66IX6
         ZQXiIXWpG0vA2nbgG6cKwhEK/DrDnYLC0Z6ypZQ38SZKyw+86nYRBuKps3ziKCvjycuT
         eGAEIgTNxJFhp7UOR4Ny7UeTyNv2EqAK5JB9Erag6tPsPph2NVSuEq8bTb4uWX6Xp3QG
         FADJ/gQ5cMzwLnVfAVtmn0yZjpCOL9iCINEQHY4PuCS8jA19RcQaYfvH0O9on6m6+am4
         0QXg==
X-Gm-Message-State: AOJu0YzqBhr32o8D2wq2wPPqmflM01EZZDDEMs1E0yo9lZ5El3J+MWdY
	as5cwjNvLN0x+4R5J/q1WgC7K45UR1GfD+7Z0E1IipgVUlIGIHaPefLK
X-Gm-Gg: Acq92OH44KtGR0OwGf9AFzBtcxpdJzDUGvv2aiPhRH/9rVUSfQVsU/+FeM2aY/CYkpT
	Fweey9cr1nZQLTRkl8zrg4xDgVqSomaoB9bU6m0LAaRL21Hy/L8SbTf6AMhw3+l2Y4dcugyoJ8T
	0155Vm8dOuEpUCDu/qRsCxXE1igjw/D1ESMAKKpO0VG5v0KQNN3BJPfuBOJCtSIRt0JuXPq37rU
	siFCJ5IVYlDUtVITCeAeY/u/fDK4rZ+9MAg56F8lM281VoS2rhU/R5JIoGofMS0YdMuT2ibO1Uw
	tzq6ObMNdgKKSiEbPvzTGxjaYgbaRxx2zgfSw2jommSaELJPn4rEL86B+VaSilq6HWDxWiOEdfo
	k4IlxA03tH+vbTH3Qs1tARdlDwSbMH2M/IL47hxU24a+4tPIbR3U/vkpK7LPMOTYXLdeSEMYcDI
	46oa7MFPR3DaMsuWyYiSZE5/pWh3Zk1Wtxp7KPXX2A378gYQA=
X-Received: by 2002:a05:6a00:a203:b0:837:8c8f:8f51 with SMTP id d2e1a72fcca58-83f05d62ebcmr1289731b3a.47.1778647840539;
        Tue, 12 May 2026 21:50:40 -0700 (PDT)
Received: from [127.0.1.1] ([203.99.159.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965c30ddasm32311914b3a.21.2026.05.12.21.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 21:50:40 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 13 May 2026 17:49:44 +1300
Subject: [PATCH v2 4/4] iio: light: add support for veml6031x00 ALS series
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-veml6031x00-v2-4-4703ca661a1d@gmail.com>
References: <20260513-veml6031x00-v2-0-4703ca661a1d@gmail.com>
In-Reply-To: <20260513-veml6031x00-v2-0-4703ca661a1d@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Matti Vaittinen <mazziesaccount@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778647803; l=35871;
 i=javier.carrasco.cruz@gmail.com; s=20260111; h=from:subject:message-id;
 bh=cvTs1n2sPa+E3ZhXZBr9BC7sH1tYAtYHPZZTk5ec8Ho=;
 b=eftVHI3j/nSelvmsbBHEuJuXS/IJYomO/ETTCO5lVcIxd5WlDe2fluRHJw3cuHkpRCeIqK3ry
 p38IGayGQ5WAA1TvNt/dniG4aYJhtEqzyMA8dUn6Lh3k4GiIHpLYbi5
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=Lge8w8xidNSf/INy7JAIbAW+Hezkp3nsBh2OjKL7lLU=

These sensors provide two light channels (ALS and IR), I2C communication
and a multiplexed interrupt line to signal data ready and configurable
threshold alarms.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 MAINTAINERS                     |    6 +
 drivers/iio/light/Kconfig       |   14 +
 drivers/iio/light/Makefile      |    1 +
 drivers/iio/light/veml6031x00.c | 1193 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 1214 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2fb1c75afd16..47da46717c16 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -28381,6 +28381,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/light/vishay,veml6046x00.yaml
 F:	drivers/iio/light/veml6046x00.c
 
+VISHAY VEML6031X00 AMBIENT LIGHT SENSOR DRIVER
+M:	Javier Carrasco <javier.carrasco.cruz@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
+F:	drivers/iio/light/veml6031x00.c
+
 VISHAY VEML6075 UVA AND UVB LIGHT SENSOR DRIVER
 M:	Javier Carrasco <javier.carrasco.cruz@gmail.com>
 S:	Maintained
diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index eff33e456c70..b99f4e8d9a70 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -713,6 +713,20 @@ config VEML6030
 	  To compile this driver as a module, choose M here: the
 	  module will be called veml6030.
 
+config VEML6031X00
+	tristate "VEML6031X00 ambient light sensor series"
+	select REGMAP_I2C
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	select IIO_GTS_HELPER
+	depends on I2C
+	help
+	  Say Y here if you want to build a driver for the Vishay VEML6031X00
+	  ambient light sensor series.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called veml6031x00.
+
 config VEML6040
 	tristate "VEML6040 RGBW light sensor"
 	select REGMAP_I2C
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index c0048e0d5ca8..a8cc03cfb6c2 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -66,6 +66,7 @@ obj-$(CONFIG_VCNL4000)		+= vcnl4000.o
 obj-$(CONFIG_VCNL4035)		+= vcnl4035.o
 obj-$(CONFIG_VEML3235)		+= veml3235.o
 obj-$(CONFIG_VEML6030)		+= veml6030.o
+obj-$(CONFIG_VEML6031X00)	+= veml6031x00.o
 obj-$(CONFIG_VEML6040)		+= veml6040.o
 obj-$(CONFIG_VEML6046X00)	+= veml6046x00.o
 obj-$(CONFIG_VEML6070)		+= veml6070.o
diff --git a/drivers/iio/light/veml6031x00.c b/drivers/iio/light/veml6031x00.c
new file mode 100644
index 000000000000..c7808768f45a
--- /dev/null
+++ b/drivers/iio/light/veml6031x00.c
@@ -0,0 +1,1193 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * VEML6031X00 Ambient Light Sensor
+ *
+ * Copyright (c) 2026, Javier Carrasco <javier.carrasco.cruz@gmail.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/interrupt.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/units.h>
+#include <linux/pm_runtime.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/events.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/iio-gts-helper.h>
+
+/* Device registers */
+#define VEML6031X00_REG_CONF0       0x00
+#define VEML6031X00_REG_CONF1       0x01
+#define VEML6031X00_REG_WH_L        0x04
+#define VEML6031X00_REG_WH_H        0x05
+#define VEML6031X00_REG_WL_L        0x06
+#define VEML6031X00_REG_WL_H        0x07
+#define VEML6031X00_REG_ALS_L       0x10
+#define VEML6031X00_REG_ALS_H       0x11
+#define VEML6031X00_REG_IR_L        0x12
+#define VEML6031X00_REG_IR_H        0x13
+#define VEML6031X00_REG_ID_L        0x14
+#define VEML6031X00_REG_ID_H        0x15
+#define VEML6031X00_REG_INT         0x17
+
+/* Bit masks for specific functionality */
+#define VEML6031X00_ALL_CH_MASK     GENMASK(1, 0)
+#define VEML6031X00_CONF0_SD        BIT(0)
+#define VEML6031X00_CONF0_AF_TRIG   BIT(2)
+#define VEML6031X00_CONF0_AF        BIT(3)
+#define VEML6031X00_CONF1_IR_SD     BIT(7)
+#define VEML6031X00_INT_TH_H        BIT(1)
+#define VEML6031X00_INT_TH_L        BIT(2)
+#define VEML6031X00_INT_DRDY        BIT(3)
+#define VEML6031X00_INT_MASK        (VEML6031X00_INT_TH_L | \
+				     VEML6031X00_INT_TH_H | \
+				     VEML6031X00_INT_DRDY)
+
+/* Autosuspend delay */
+#define VEML6031X00_AUTOSUSPEND_MS  2000
+
+enum veml6031x00_scan {
+	VEML6031X00_SCAN_ALS,
+	VEML6031X00_SCAN_IR,
+	VEML6031X00_SCAN_TIMESTAMP,
+};
+
+struct veml6031x00_rf {
+	struct regmap_field *gain;
+	struct regmap_field *int_en;
+	struct regmap_field *it;
+	struct regmap_field *pd_div4;
+	struct regmap_field *pers;
+};
+
+struct veml6031x00_chip {
+	const char *name;
+	const int part_id;
+};
+
+struct veml6031x00_data {
+	struct device *dev;
+	struct iio_gts gts;
+	struct regmap *regmap;
+	struct iio_trigger *trig;
+	struct veml6031x00_rf rf;
+	const struct veml6031x00_chip *chip;
+	/* serialize access to irq enable/disable by events and trigger */
+	struct mutex lock;
+	atomic_t int_users;
+	bool ev_en;
+	bool trig_en;
+};
+
+static const struct iio_itime_sel_mul veml6031x00_it_sel[] = {
+	GAIN_SCALE_ITIME_US(3125, 0, 1),
+	GAIN_SCALE_ITIME_US(6250, 1, 2),
+	GAIN_SCALE_ITIME_US(12500, 2, 4),
+	GAIN_SCALE_ITIME_US(25000, 3, 8),
+	GAIN_SCALE_ITIME_US(50000, 4, 16),
+	GAIN_SCALE_ITIME_US(100000, 5, 32),
+	GAIN_SCALE_ITIME_US(200000, 6, 64),
+	GAIN_SCALE_ITIME_US(400000, 7, 128),
+};
+
+/*
+ * The gain selector encodes (PD_D4 << 2) | GAIN to identify each gain setting.
+ * Gains are multiplied by 8 to work with integers. The values in the iio-gts
+ * tables don't need corrections because the maximum value of the scale refers
+ * to GAIN = x1, and the rest of the values are obtained from the resulting
+ * linear function.
+ * TODO: add support for MILLI_GAIN_X165 and MILLI_GAIN_X660
+ */
+#define VEML6031X00_SEL_MILLI_GAIN_X125  0x07
+#define VEML6031X00_SEL_MILLI_GAIN_X250  0x04
+#define VEML6031X00_SEL_MILLI_GAIN_X500  0x03
+#define VEML6031X00_SEL_MILLI_GAIN_X1000 0x00
+#define VEML6031X00_SEL_MILLI_GAIN_X2000 0x01
+static const struct iio_gain_sel_pair veml6031x00_gain_sel[] = {
+	GAIN_SCALE_GAIN(1,  VEML6031X00_SEL_MILLI_GAIN_X125),
+	GAIN_SCALE_GAIN(2,  VEML6031X00_SEL_MILLI_GAIN_X250),
+	GAIN_SCALE_GAIN(4, VEML6031X00_SEL_MILLI_GAIN_X500),
+	GAIN_SCALE_GAIN(8, VEML6031X00_SEL_MILLI_GAIN_X1000),
+	GAIN_SCALE_GAIN(16, VEML6031X00_SEL_MILLI_GAIN_X2000),
+};
+
+static IIO_CONST_ATTR(in_illuminance_thresh_either_period_available, "1 2 4 8");
+
+static struct attribute *veml6031x00_event_attributes[] = {
+	&iio_const_attr_in_illuminance_thresh_either_period_available.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group veml6031x00_event_attr_group = {
+	.attrs = veml6031x00_event_attributes,
+};
+
+/*
+ * Two shutdown bits (SD and ALS_IR_SD) must be cleared to power on
+ * the device.
+ */
+static int veml6031x00_als_power_on(struct veml6031x00_data *data)
+{
+	int ret;
+
+	ret = regmap_clear_bits(data->regmap, VEML6031X00_REG_CONF0,
+				VEML6031X00_CONF0_SD);
+	if (ret)
+		return ret;
+
+	return regmap_clear_bits(data->regmap, VEML6031X00_REG_CONF1,
+				 VEML6031X00_CONF1_IR_SD);
+}
+
+/*
+ * Two shutdown bits (SD and ALS_IR_SD) must be set to power off
+ * the device.
+ */
+static int veml6031x00_als_shutdown(struct veml6031x00_data *data)
+{
+	int ret;
+
+	ret = regmap_set_bits(data->regmap, VEML6031X00_REG_CONF0,
+			      VEML6031X00_CONF0_SD);
+	if (ret)
+		return ret;
+
+	return regmap_set_bits(data->regmap, VEML6031X00_REG_CONF1,
+			       VEML6031X00_CONF1_IR_SD);
+}
+
+static void veml6031x00_als_shutdown_action(void *data)
+{
+	veml6031x00_als_shutdown(data);
+}
+
+static const struct iio_event_spec veml6031x00_event_spec[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	}, {
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	}, {
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_separate = BIT(IIO_EV_INFO_PERIOD) |
+				 BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
+static const struct iio_chan_spec veml6031x00_channels[] = {
+	{
+		.type = IIO_LIGHT,
+		.address = VEML6031X00_REG_ALS_L,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),
+		.event_spec = veml6031x00_event_spec,
+		.num_event_specs = ARRAY_SIZE(veml6031x00_event_spec),
+		.scan_index = VEML6031X00_SCAN_ALS,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_LE,
+		},
+	},
+	{
+		.type = IIO_INTENSITY,
+		.address = VEML6031X00_REG_IR_L,
+		.modified = 1,
+		.channel2 = IIO_MOD_LIGHT_IR,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME),
+		.scan_index = VEML6031X00_SCAN_IR,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_LE,
+		},
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(VEML6031X00_SCAN_TIMESTAMP),
+};
+
+static const struct regmap_range veml6031x00_readable_ranges[] = {
+	regmap_reg_range(VEML6031X00_REG_CONF0, VEML6031X00_REG_CONF1),
+	regmap_reg_range(VEML6031X00_REG_WH_L, VEML6031X00_REG_WL_H),
+	regmap_reg_range(VEML6031X00_REG_ALS_L, VEML6031X00_REG_ID_H),
+	regmap_reg_range(VEML6031X00_REG_INT, VEML6031X00_REG_INT),
+};
+
+static const struct regmap_access_table veml6031x00_readable_table = {
+	.yes_ranges = veml6031x00_readable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(veml6031x00_readable_ranges),
+};
+
+static const struct regmap_range veml6031x00_writable_ranges[] = {
+	regmap_reg_range(VEML6031X00_REG_CONF0, VEML6031X00_REG_WL_H),
+};
+
+static const struct regmap_access_table veml6031x00_writable_table = {
+	.yes_ranges = veml6031x00_writable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(veml6031x00_writable_ranges),
+};
+
+static const struct regmap_range veml6031x00_volatile_ranges[] = {
+	regmap_reg_range(VEML6031X00_REG_ALS_L, VEML6031X00_REG_IR_H),
+	regmap_reg_range(VEML6031X00_REG_INT, VEML6031X00_REG_INT),
+};
+
+static const struct regmap_access_table veml6031x00_volatile_table = {
+	.yes_ranges = veml6031x00_volatile_ranges,
+	.n_yes_ranges = ARRAY_SIZE(veml6031x00_volatile_ranges),
+};
+
+static const struct regmap_range veml6031x00_precious_ranges[] = {
+	regmap_reg_range(VEML6031X00_REG_INT, VEML6031X00_REG_INT),
+};
+
+static const struct regmap_access_table veml6031x00_precious_table = {
+	.yes_ranges = veml6031x00_precious_ranges,
+	.n_yes_ranges = ARRAY_SIZE(veml6031x00_precious_ranges),
+};
+
+static const struct regmap_config veml6031x00_regmap_config = {
+	.name = "veml6031x00_regmap",
+	.reg_bits = 8,
+	.val_bits = 8,
+	.rd_table = &veml6031x00_readable_table,
+	.wr_table = &veml6031x00_writable_table,
+	.volatile_table = &veml6031x00_volatile_table,
+	.precious_table = &veml6031x00_precious_table,
+	.max_register = VEML6031X00_REG_INT,
+	.cache_type = REGCACHE_MAPLE,
+};
+
+static const struct reg_field veml6031x00_rf_int_en =
+	REG_FIELD(VEML6031X00_REG_CONF0, 1, 1);
+
+static const struct reg_field veml6031x00_rf_it =
+	REG_FIELD(VEML6031X00_REG_CONF0, 4, 6);
+
+static const struct reg_field veml6031x00_rf_pers =
+	REG_FIELD(VEML6031X00_REG_CONF1, 1, 2);
+
+static const struct reg_field veml6031x00_rf_gain =
+	REG_FIELD(VEML6031X00_REG_CONF1, 3, 4);
+
+static const struct reg_field veml6031x00_rf_pd_div4 =
+	REG_FIELD(VEML6031X00_REG_CONF1, 6, 6);
+
+static int veml6031x00_regfield_init(struct veml6031x00_data *data)
+{
+	struct regmap *regmap = data->regmap;
+	struct device *dev = data->dev;
+	struct regmap_field *rm_field;
+	struct veml6031x00_rf *rf = &data->rf;
+
+	rm_field = devm_regmap_field_alloc(dev, regmap, veml6031x00_rf_gain);
+	if (IS_ERR(rm_field))
+		return PTR_ERR(rm_field);
+	rf->gain = rm_field;
+
+	rm_field = devm_regmap_field_alloc(dev, regmap, veml6031x00_rf_int_en);
+	if (IS_ERR(rm_field))
+		return PTR_ERR(rm_field);
+	rf->int_en = rm_field;
+
+	rm_field = devm_regmap_field_alloc(dev, regmap, veml6031x00_rf_it);
+	if (IS_ERR(rm_field))
+		return PTR_ERR(rm_field);
+	rf->it = rm_field;
+
+	rm_field = devm_regmap_field_alloc(dev, regmap, veml6031x00_rf_pd_div4);
+	if (IS_ERR(rm_field))
+		return PTR_ERR(rm_field);
+	rf->pd_div4 = rm_field;
+
+	rm_field = devm_regmap_field_alloc(dev, regmap, veml6031x00_rf_pers);
+	if (IS_ERR(rm_field))
+		return PTR_ERR(rm_field);
+	rf->pers = rm_field;
+
+	return 0;
+}
+
+static int veml6031x00_get_it(struct veml6031x00_data *data, int *val, int *val2)
+{
+	int ret, it_idx;
+
+	ret = regmap_field_read(data->rf.it, &it_idx);
+	if (ret)
+		return ret;
+
+	ret = iio_gts_find_int_time_by_sel(&data->gts, it_idx);
+	if (ret < 0)
+		return ret;
+
+	*val2 = ret;
+	*val = 0;
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int veml6031x00_set_it(struct iio_dev *iio, int val, int val2)
+{
+	struct veml6031x00_data *data = iio_priv(iio);
+	int ret, gain_sel, gain_reg, pd_div4, it_idx, new_gain, prev_gain, prev_it;
+	bool in_range;
+
+	if (val || !iio_gts_valid_time(&data->gts, val2))
+		return -EINVAL;
+
+	ret = regmap_field_read(data->rf.it, &it_idx);
+	if (ret)
+		return ret;
+
+	ret = regmap_field_read(data->rf.gain, &gain_reg);
+	if (ret)
+		return ret;
+
+	ret = regmap_field_read(data->rf.pd_div4, &pd_div4);
+	if (ret)
+		return ret;
+
+	prev_it = iio_gts_find_int_time_by_sel(&data->gts, it_idx);
+	if (prev_it < 0)
+		return prev_it;
+
+	if (prev_it == val2)
+		return 0;
+
+	prev_gain = iio_gts_find_gain_by_sel(&data->gts, (pd_div4 << 2) | gain_reg);
+	if (prev_gain < 0)
+		return prev_gain;
+
+	ret = iio_gts_find_new_gain_by_gain_time_min(&data->gts, prev_gain, prev_it,
+						     val2, &new_gain, &in_range);
+	if (ret)
+		return ret;
+
+	if (!in_range)
+		dev_dbg(data->dev, "Optimal gain out of range\n");
+
+	ret = iio_gts_find_sel_by_int_time(&data->gts, val2);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_field_write(data->rf.it, ret);
+	if (ret)
+		return ret;
+
+	gain_sel = iio_gts_find_sel_by_gain(&data->gts, new_gain);
+	if (gain_sel < 0)
+		return gain_sel;
+
+	ret = regmap_field_write(data->rf.pd_div4, gain_sel >> 2);
+	if (ret)
+		return ret;
+
+	return regmap_field_write(data->rf.gain, gain_sel & 0x03);
+}
+
+static int veml6031x00_read_period(struct iio_dev *iio, int *val)
+{
+	struct veml6031x00_data *data = iio_priv(iio);
+	int ret, reg;
+
+	ret = regmap_field_read(data->rf.pers, &reg);
+	if (ret)
+		return ret;
+
+	*val = 1 << reg;
+
+	return IIO_VAL_INT;
+}
+
+static int veml6031x00_write_period(struct iio_dev *iio, int val)
+{
+	struct veml6031x00_data *data = iio_priv(iio);
+
+	if (val > 8 || hweight8(val) != 1)
+		return -EINVAL;
+
+	return regmap_field_write(data->rf.pers, ffs(val) - 1);
+}
+
+static int veml6031x00_set_scale(struct iio_dev *iio, int val, int val2)
+{
+	int gain_sel, it_sel, ret;
+	struct veml6031x00_data *data = iio_priv(iio);
+
+	ret = iio_gts_find_gain_time_sel_for_scale(&data->gts, val, val2,
+						   &gain_sel, &it_sel);
+	if (ret)
+		return ret;
+
+	ret = regmap_field_write(data->rf.it, it_sel);
+	if (ret)
+		return ret;
+
+	ret = regmap_field_write(data->rf.pd_div4, gain_sel >> 2);
+	if (ret)
+		return ret;
+
+	return regmap_field_write(data->rf.gain, gain_sel & 0x03);
+}
+
+static int veml6031x00_get_scale(struct veml6031x00_data *data, int *val,
+				 int *val2)
+{
+	int gain, it, gain_reg, pd_div4, it_reg, ret, sel;
+
+	ret = regmap_field_read(data->rf.gain, &gain_reg);
+	if (ret)
+		return ret;
+
+	ret = regmap_field_read(data->rf.pd_div4, &pd_div4);
+	if (ret)
+		return ret;
+
+	sel = (pd_div4 << 2) | gain_reg;
+	gain = iio_gts_find_gain_by_sel(&data->gts, sel);
+	if (gain < 0)
+		return gain;
+
+	ret = regmap_field_read(data->rf.it, &it_reg);
+	if (ret)
+		return ret;
+
+	it = iio_gts_find_int_time_by_sel(&data->gts, it_reg);
+	if (it < 0)
+		return it;
+
+	ret = iio_gts_get_scale(&data->gts, gain, it, val, val2);
+	if (ret)
+		return ret;
+
+	return IIO_VAL_INT_PLUS_NANO;
+}
+
+static int veml6031x00_read_th(struct iio_dev *iio, int *val, int *val2, int dir)
+{
+	struct veml6031x00_data *data = iio_priv(iio);
+	__le16 reg;
+	int ret;
+
+	if (dir == IIO_EV_DIR_RISING)
+		ret = regmap_bulk_read(data->regmap, VEML6031X00_REG_WH_L,
+				       &reg, sizeof(reg));
+	else
+		ret = regmap_bulk_read(data->regmap, VEML6031X00_REG_WL_L,
+				       &reg, sizeof(reg));
+	if (ret)
+		return ret;
+
+	*val = le16_to_cpu(reg);
+
+	return IIO_VAL_INT;
+}
+
+static int veml6031x00_write_th(struct iio_dev *iio, int val, int val2, int dir)
+{
+	struct veml6031x00_data *data = iio_priv(iio);
+	struct device *dev = data->dev;
+	__le16 reg = cpu_to_le16(val);
+	int ret;
+
+	if (val < 0 || val > U16_MAX || val2)
+		return -EINVAL;
+
+	if (dir == IIO_EV_DIR_RISING) {
+		ret = regmap_bulk_write(data->regmap, VEML6031X00_REG_WH_L,
+					&reg, sizeof(reg));
+		if (ret)
+			dev_dbg(dev, "Failed to set high threshold %d\n", ret);
+	} else {
+		ret = regmap_bulk_write(data->regmap, VEML6031X00_REG_WL_L,
+					&reg, sizeof(reg));
+		if (ret)
+			dev_dbg(dev, "Failed to set low threshold %d\n", ret);
+	}
+
+	return ret;
+}
+
+static int veml6031x00_single_read(struct iio_dev *iio, enum iio_chan_type type,
+				   int *val)
+{
+	struct veml6031x00_data *data = iio_priv(iio);
+	int addr, it_sec, it_usec, ret;
+	__le16 reg;
+
+	switch (type) {
+	case IIO_LIGHT:
+		addr = VEML6031X00_REG_ALS_L;
+		break;
+	case IIO_INTENSITY:
+		addr = VEML6031X00_REG_IR_L;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = pm_runtime_resume_and_get(data->dev);
+	if (ret)
+		return ret;
+
+	ret = veml6031x00_get_it(data, &it_sec, &it_usec);
+	if (ret < 0)
+		goto put_autosuspend;
+
+	/* integration time + 10 % to ensure completion */
+	fsleep((it_sec * MICRO) + it_usec + (it_usec / 10));
+
+	if (!iio_device_claim_direct(iio)) {
+		ret = -EBUSY;
+		goto put_autosuspend;
+	}
+
+	ret = regmap_bulk_read(data->regmap, addr, &reg, sizeof(reg));
+	iio_device_release_direct(iio);
+	if (ret < 0)
+		goto put_autosuspend;
+
+	*val = le16_to_cpu(reg);
+	ret = IIO_VAL_INT;
+
+put_autosuspend:
+	pm_runtime_put_autosuspend(data->dev);
+	return ret;
+}
+
+static int veml6031x00_read_raw(struct iio_dev *iio,
+				struct iio_chan_spec const *chan, int *val,
+				int *val2, long mask)
+{
+	struct veml6031x00_data *data = iio_priv(iio);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		return veml6031x00_single_read(iio, chan->type, val);
+	case IIO_CHAN_INFO_INT_TIME:
+		*val = 0;
+		return veml6031x00_get_it(data, val, val2);
+	case IIO_CHAN_INFO_SCALE:
+		return veml6031x00_get_scale(data, val, val2);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int veml6031x00_read_avail(struct iio_dev *iio,
+				  struct iio_chan_spec const *chan,
+				  const int **vals, int *type, int *length,
+				  long mask)
+{
+	struct veml6031x00_data *data = iio_priv(iio);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_INT_TIME:
+		return iio_gts_avail_times(&data->gts, vals, type, length);
+	case IIO_CHAN_INFO_SCALE:
+		return iio_gts_all_avail_scales(&data->gts, vals, type, length);
+	}
+
+	return -EINVAL;
+}
+
+static int veml6031x00_write_raw(struct iio_dev *iio,
+				 struct iio_chan_spec const *chan,
+				 int val, int val2, long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_INT_TIME:
+		return veml6031x00_set_it(iio, val, val2);
+	case IIO_CHAN_INFO_SCALE:
+		return veml6031x00_set_scale(iio, val, val2);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int veml6031x00_write_raw_get_fmt(struct iio_dev *indio_dev,
+					 struct iio_chan_spec const *chan,
+					 long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_INT_TIME:
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int veml6031x00_set_interrupt(struct veml6031x00_data *data, bool state)
+{
+	int ret;
+
+	if (state) {
+		if (atomic_inc_return(&data->int_users) > 1)
+			return 0;
+	} else {
+		if (atomic_dec_return(&data->int_users) > 0)
+			return 0;
+	}
+
+	ret = regmap_field_write(data->rf.int_en, state);
+	if (ret) {
+		if (state)
+			atomic_dec(&data->int_users);
+		else
+			atomic_inc(&data->int_users);
+	}
+
+	return ret;
+}
+
+static int veml6031x00_read_event_val(struct iio_dev *iio,
+				      const struct iio_chan_spec *chan,
+				      enum iio_event_type type,
+				      enum iio_event_direction dir,
+				      enum iio_event_info info,
+				      int *val, int *val2)
+{
+	switch (type) {
+	case IIO_EV_TYPE_THRESH:
+		if (dir == IIO_EV_DIR_EITHER && info == IIO_EV_INFO_PERIOD)
+			return veml6031x00_read_period(iio, val);
+		else
+			return veml6031x00_read_th(iio, val, val2, dir);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int veml6031x00_write_event_val(struct iio_dev *iio,
+				       const struct iio_chan_spec *chan,
+				       enum iio_event_type type,
+				       enum iio_event_direction dir,
+				       enum iio_event_info info,
+				       int val, int val2)
+{
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		return veml6031x00_write_th(iio, val, val2, dir);
+	case IIO_EV_INFO_PERIOD:
+		return veml6031x00_write_period(iio, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int veml6031x00_read_event_config(struct iio_dev *iio,
+					 const struct iio_chan_spec *chan,
+					 enum iio_event_type type,
+					 enum iio_event_direction dir)
+{
+	struct veml6031x00_data *data = iio_priv(iio);
+
+	guard(mutex)(&data->lock);
+
+	return data->ev_en;
+}
+
+static int veml6031x00_write_event_config(struct iio_dev *iio,
+					  const struct iio_chan_spec *chan,
+					  enum iio_event_type type,
+					  enum iio_event_direction dir,
+					  bool state)
+{
+	struct veml6031x00_data *data = iio_priv(iio);
+	int ret;
+
+	scoped_guard(mutex, &data->lock) {
+		/* avoid multiple increments/decrements from one source */
+		if (state == data->ev_en)
+			return 0;
+
+		ret = veml6031x00_set_interrupt(data, state);
+		if (ret)
+			return ret;
+
+		data->ev_en = state;
+	}
+
+	if (state)
+		return pm_runtime_resume_and_get(data->dev);
+
+	pm_runtime_put_autosuspend(data->dev);
+
+	return 0;
+}
+
+static const struct iio_info veml6031x00_info = {
+	.read_raw = veml6031x00_read_raw,
+	.read_avail = veml6031x00_read_avail,
+	.write_raw = veml6031x00_write_raw,
+	.write_raw_get_fmt = veml6031x00_write_raw_get_fmt,
+	.read_event_value = veml6031x00_read_event_val,
+	.write_event_value = veml6031x00_write_event_val,
+	.read_event_config = veml6031x00_read_event_config,
+	.write_event_config = veml6031x00_write_event_config,
+	.event_attrs = &veml6031x00_event_attr_group,
+};
+
+static const struct iio_info veml6031x00_info_no_irq = {
+	.read_raw = veml6031x00_read_raw,
+	.read_avail = veml6031x00_read_avail,
+	.write_raw = veml6031x00_write_raw,
+	.write_raw_get_fmt = veml6031x00_write_raw_get_fmt,
+};
+
+/* AF_TRIG is reset by hardware, but the rest of the fields are persistent */
+static int veml6031x00_set_af_trig(struct veml6031x00_data *data, bool state)
+{
+	regcache_drop_region(data->regmap, VEML6031X00_REG_CONF0,
+			     VEML6031X00_REG_CONF0);
+
+	return regmap_update_bits(data->regmap, VEML6031X00_REG_CONF0,
+				  VEML6031X00_CONF0_AF_TRIG,
+				  FIELD_PREP(VEML6031X00_CONF0_AF_TRIG, state));
+}
+
+static irqreturn_t veml6031x00_interrupt(int irq, void *private)
+{
+	struct iio_dev *iio = private;
+	struct veml6031x00_data *data = iio_priv(iio);
+	s64 timestamp;
+	int ret, reg;
+
+	ret = regmap_read(data->regmap, VEML6031X00_REG_INT, &reg);
+	if (ret) {
+		dev_err(data->dev,
+			"Failed to read interrupt register %d\n", ret);
+		return IRQ_NONE;
+	}
+
+	if (!(reg & VEML6031X00_INT_MASK))
+		return IRQ_NONE;
+
+	guard(mutex)(&data->lock);
+
+	if ((reg & (VEML6031X00_INT_TH_H | VEML6031X00_INT_TH_L)) && data->ev_en) {
+		timestamp = iio_get_time_ns(iio);
+
+		if (reg & VEML6031X00_INT_TH_H)
+			iio_push_event(iio, IIO_UNMOD_EVENT_CODE(IIO_LIGHT, 0,
+								 IIO_EV_TYPE_THRESH,
+								 IIO_EV_DIR_RISING),
+				       timestamp);
+		if (reg & VEML6031X00_INT_TH_L)
+			iio_push_event(iio, IIO_UNMOD_EVENT_CODE(IIO_LIGHT, 0,
+								 IIO_EV_TYPE_THRESH,
+								 IIO_EV_DIR_FALLING),
+				       timestamp);
+	}
+
+	if ((reg & VEML6031X00_INT_DRDY) && data->trig_en) {
+		iio_trigger_poll_nested(data->trig);
+		ret = veml6031x00_set_af_trig(data, true);
+		if (ret)
+			dev_err(data->dev, "Failed to set trigger %d\n", ret);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int veml6031x00_buffer_preenable(struct iio_dev *iio)
+{
+	struct veml6031x00_data *data = iio_priv(iio);
+	int ret, it_sec, it_usec;
+
+	ret = pm_runtime_resume_and_get(data->dev);
+	if (ret)
+		return ret;
+
+	ret = veml6031x00_get_it(data, &it_sec, &it_usec);
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(data->dev);
+		return ret;
+	}
+
+	/*
+	 * Wait one integration period + 10% margin so the first triggered
+	 * read does not race with the sensor completing its first conversion
+	 * after power-on.
+	 */
+	fsleep((it_sec * MICRO) + it_usec + (it_usec / 10));
+
+	return 0;
+}
+
+static int veml6031x00_buffer_postdisable(struct iio_dev *iio)
+{
+	struct veml6031x00_data *data = iio_priv(iio);
+	struct device *dev = data->dev;
+
+	pm_runtime_put_autosuspend(dev);
+
+	return 0;
+}
+
+static int veml6031x00_set_trigger_state(struct iio_trigger *trig, bool state)
+{
+	struct iio_dev *iio = iio_trigger_get_drvdata(trig);
+	struct veml6031x00_data *data = iio_priv(iio);
+	int ret;
+
+	scoped_guard(mutex, &data->lock) {
+		if (state == data->trig_en)
+			return 0;
+
+		ret = veml6031x00_set_interrupt(data, state);
+		if (ret)
+			return ret;
+	}
+
+	/* The AF bit must be set before setting AF_TRIG */
+	ret = regmap_update_bits(data->regmap, VEML6031X00_REG_CONF0,
+				 VEML6031X00_CONF0_AF,
+				 FIELD_PREP(VEML6031X00_CONF0_AF, state));
+	if (ret)
+		goto err_disable_interrupt;
+
+	ret = veml6031x00_set_af_trig(data, state);
+	if (ret)
+		goto err_clear_af;
+
+	scoped_guard(mutex, &data->lock)
+		data->trig_en = state;
+
+	return 0;
+
+err_clear_af:
+	regmap_update_bits(data->regmap, VEML6031X00_REG_CONF0,
+			   VEML6031X00_CONF0_AF,
+			   FIELD_PREP(VEML6031X00_CONF0_AF, !state));
+err_disable_interrupt:
+	veml6031x00_set_interrupt(data, !state);
+	return ret;
+}
+
+static const struct iio_buffer_setup_ops veml6031x00_buffer_setup_ops = {
+	.preenable = veml6031x00_buffer_preenable,
+	.postdisable = veml6031x00_buffer_postdisable,
+};
+
+static const struct iio_trigger_ops veml6031x00_trigger_ops = {
+	.set_trigger_state = veml6031x00_set_trigger_state,
+};
+
+static irqreturn_t veml6031x00_trig_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *iio = pf->indio_dev;
+	struct veml6031x00_data *data = iio_priv(iio);
+	int ch, ret, i = 0;
+	struct {
+		__le16 chans[2];
+		aligned_s64 timestamp;
+	} scan;
+
+	memset(&scan, 0, sizeof(scan));
+
+	if (*iio->active_scan_mask == VEML6031X00_ALL_CH_MASK) {
+		ret = regmap_bulk_read(data->regmap,
+				       VEML6031X00_REG_ALS_L,
+				       &scan.chans, sizeof(scan.chans));
+		if (ret)
+			goto done;
+	} else {
+		iio_for_each_active_channel(iio, ch) {
+			ret = regmap_bulk_read(data->regmap,
+					       iio->channels[ch].address,
+					       &scan.chans[i++], 2);
+			if (ret)
+				goto done;
+		}
+	}
+
+	iio_push_to_buffers_with_timestamp(iio, &scan, pf->timestamp);
+
+done:
+	iio_trigger_notify_done(iio->trig);
+
+	return IRQ_HANDLED;
+}
+
+static int veml6031x00_validate_part_id(struct veml6031x00_data *data)
+{
+	int part_id, ret;
+	__le16 reg;
+
+	ret = regmap_bulk_read(data->regmap, VEML6031X00_REG_ID_L, &reg,
+			       sizeof(reg));
+	if (ret)
+		return dev_err_probe(data->dev, ret, "Failed to read ID\n");
+
+	part_id = le16_to_cpu(reg);
+	if (part_id != data->chip->part_id)
+		dev_warn(data->dev, "Unknown ID %04x\n", part_id);
+
+	return 0;
+}
+
+static int veml6031x00_hw_init(struct iio_dev *iio)
+{
+	struct veml6031x00_data *data = iio_priv(iio);
+	struct device *dev = data->dev;
+	int ret, val;
+	__le16 reg;
+
+	/* Max resolution = 6.9632 lx/cnt for gain = 0.125 and IT = 3.125ms */
+	ret = devm_iio_init_iio_gts(data->dev, 6, 963200000,
+				    veml6031x00_gain_sel,
+				    ARRAY_SIZE(veml6031x00_gain_sel),
+				    veml6031x00_it_sel,
+				    ARRAY_SIZE(veml6031x00_it_sel),
+				    &data->gts);
+	if (ret)
+		return dev_err_probe(data->dev, ret, "failed to init iio gts\n");
+
+	reg = 0;
+	ret = regmap_bulk_write(data->regmap, VEML6031X00_REG_WL_L, &reg,
+				sizeof(reg));
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to set low threshold\n");
+
+	reg = cpu_to_le16(U16_MAX);
+	ret = regmap_bulk_write(data->regmap, VEML6031X00_REG_WH_L, &reg,
+				sizeof(reg));
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to set high threshold\n");
+
+	ret = regmap_field_write(data->rf.int_en, 0);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_read(data->regmap, VEML6031X00_REG_INT, &val);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to clear interrupts\n");
+
+	return 0;
+}
+
+static int veml6031x00_setup_irq(struct i2c_client *i2c, struct iio_dev *iio)
+{
+	struct veml6031x00_data *data = iio_priv(iio);
+	struct device *dev = data->dev;
+	int ret;
+
+	data->trig = devm_iio_trigger_alloc(dev, "%s-drdy%d", iio->name,
+					    iio_device_id(iio));
+	if (!data->trig)
+		return -ENOMEM;
+
+	data->trig->ops = &veml6031x00_trigger_ops;
+	iio_trigger_set_drvdata(data->trig, iio);
+
+	ret = devm_iio_trigger_register(dev, data->trig);
+	if (ret)
+		return ret;
+
+	iio->trig = iio_trigger_get(data->trig);
+	ret = devm_request_threaded_irq(dev, i2c->irq, NULL,
+					veml6031x00_interrupt,
+					IRQF_ONESHOT,
+					iio->name, iio);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to request irq %d\n",
+				     i2c->irq);
+
+	iio->info = &veml6031x00_info;
+
+	return 0;
+}
+
+static int veml6031x00_probe(struct i2c_client *i2c)
+{
+	struct device *dev = &i2c->dev;
+	struct veml6031x00_data *data;
+	struct iio_dev *iio;
+	struct regmap *regmap;
+	int ret;
+
+	regmap = devm_regmap_init_i2c(i2c, &veml6031x00_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap),
+				     "Failed to set regmap\n");
+
+	iio = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!iio)
+		return -ENOMEM;
+
+	data = iio_priv(iio);
+	i2c_set_clientdata(i2c, iio);
+	data->dev = dev;
+	data->regmap = regmap;
+
+	ret = devm_mutex_init(dev, &data->lock);
+	if (ret)
+		return ret;
+
+	ret = veml6031x00_regfield_init(data);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to init regfield\n");
+
+	ret = devm_regulator_get_enable(dev, "vdd");
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable regulator\n");
+
+	data->chip = i2c_get_match_data(i2c);
+	if (!data->chip)
+		return dev_err_probe(dev, -EINVAL, "Failed to get chip data\n");
+
+	ret = devm_add_action_or_reset(dev, veml6031x00_als_shutdown_action, data);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to add shutdown action\n");
+
+	ret = pm_runtime_set_active(dev);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to activate PM runtime\n");
+
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable PM runtime\n");
+
+	pm_runtime_get_noresume(dev);
+	pm_runtime_set_autosuspend_delay(dev, VEML6031X00_AUTOSUSPEND_MS);
+	pm_runtime_use_autosuspend(dev);
+
+	ret = veml6031x00_validate_part_id(data);
+	if (ret)
+		return ret;
+
+	iio->name = data->chip->name;
+	iio->channels = veml6031x00_channels;
+	iio->num_channels = ARRAY_SIZE(veml6031x00_channels);
+	iio->modes = INDIO_DIRECT_MODE;
+
+	if (i2c->irq) {
+		ret = veml6031x00_setup_irq(i2c, iio);
+		if (ret < 0)
+			return ret;
+	} else {
+		iio->info = &veml6031x00_info_no_irq;
+	}
+
+	ret = veml6031x00_hw_init(iio);
+	if (ret < 0)
+		return ret;
+
+	ret = devm_iio_triggered_buffer_setup(dev, iio, NULL,
+					      veml6031x00_trig_handler,
+					      &veml6031x00_buffer_setup_ops);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to register triggered buffer\n");
+
+	pm_runtime_put_autosuspend(dev);
+
+	ret = devm_iio_device_register(dev, iio);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to register iio device\n");
+
+	return 0;
+}
+
+static int veml6031x00_runtime_suspend(struct device *dev)
+{
+	struct veml6031x00_data *data = iio_priv(dev_get_drvdata(dev));
+
+	return veml6031x00_als_shutdown(data);
+}
+
+static int veml6031x00_runtime_resume(struct device *dev)
+{
+	struct veml6031x00_data *data = iio_priv(dev_get_drvdata(dev));
+
+	return veml6031x00_als_power_on(data);
+}
+
+static DEFINE_RUNTIME_DEV_PM_OPS(veml6031x00_pm_ops, veml6031x00_runtime_suspend,
+				 veml6031x00_runtime_resume, NULL);
+
+static const struct veml6031x00_chip veml6031x00_chip = {
+	.name = "veml6031x00",
+	.part_id = 0x0001,
+};
+
+static const struct veml6031x00_chip veml6031x01_chip = {
+	.name = "veml6031x01",
+	.part_id = 0x0001,
+};
+
+static const struct veml6031x00_chip veml60311x00_chip = {
+	.name = "veml60311x00",
+	.part_id = 0x1001,
+};
+
+static const struct veml6031x00_chip veml60311x01_chip = {
+	.name = "veml60311x01",
+	.part_id = 0x1001,
+};
+
+static const struct of_device_id veml6031x00_of_match[] = {
+	{
+		.compatible = "vishay,veml6031x00",
+		.data = &veml6031x00_chip,
+	},
+	{
+		.compatible = "vishay,veml6031x01",
+		.data = &veml6031x01_chip,
+	},
+	{
+		.compatible = "vishay,veml60311x00",
+		.data = &veml60311x00_chip,
+	},
+	{
+		.compatible = "vishay,veml60311x01",
+		.data = &veml60311x01_chip,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, veml6031x00_of_match);
+
+static const struct i2c_device_id veml6031x00_id[] = {
+	{ "veml6031x00", (kernel_ulong_t)&veml6031x00_chip },
+	{ "veml6031x01", (kernel_ulong_t)&veml6031x01_chip },
+	{ "veml60311x00", (kernel_ulong_t)&veml60311x00_chip },
+	{ "veml60311x01", (kernel_ulong_t)&veml60311x01_chip },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, veml6031x00_id);
+
+static struct i2c_driver veml6031x00_driver = {
+	.driver = {
+		.name = "veml6031x00",
+		.of_match_table = veml6031x00_of_match,
+		.pm = pm_ptr(&veml6031x00_pm_ops),
+	},
+	.probe = veml6031x00_probe,
+	.id_table = veml6031x00_id,
+};
+module_i2c_driver(veml6031x00_driver);
+
+MODULE_AUTHOR("Javier Carrasco <javier.carrasco.cruz@gmail.com>");
+MODULE_DESCRIPTION("VEML6031X00 Ambient Light Sensor");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_GTS_HELPER");

-- 
2.43.0

