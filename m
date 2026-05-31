Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463FB33E37A
	for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 19:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780257521; cv=none; b=KW1y7A0p8acSKjqg1jxir7b8DU0inTyf9vsqww57toXPWi4x91nN9YomIyARBCadlrj/oQa+SGq0zCwndaiQy+BGJA1H83g/EbVOS2vITHy543bSClWmMp2M1P1X/JdTXxP/FFTKgUotWSy1RGn6Vujr32QcZ8j/NVWG6P4xVL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780257521; c=relaxed/simple;
	bh=dUeXI2B/ieLHS6AKK5iWOLKH86UnXfQa0fZpVX2ZWwQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SIR6xn0qbT5NsUwuq1TTeXI8pLSm/JjR1peJJfAlNHkDTRt+RceyuF7RqoM4h8aCUXd8kaSzxgEpyPFeUwiswee6SRju8sf693qGtcTcd7mfCwopd+evhMwTdXAUq06+o67M42DXXLBWtnU0vLde6dXoa8nv7bnsHD7w7BReIzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZRFsl8r; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZRFsl8r"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49039a8851fso96725655e9.2
        for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 12:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780257518; x=1780862318; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yCnn3guwabCfpkvuleLlt1JUIHD9BUV2uNEUmZL7NLU=;
        b=PZRFsl8rIIeKIDcnonxinfjb3cq6dHI+XT1fAaHfpWG8tVZiFA3dUHh5BwN5cZHZ8b
         kztDIP4lICHQhf6eL49kavpVAekw1Mm7e13eXsm+rAVD1HqsSD/GKF+b+B/okIlmG4Je
         /LUlr6/pVooffaoZ42CyB5ZbbFDLHGsPpJ3kjN2488DuMeXKTWYmOBy8aGbvCYLOnGh/
         fONzJAbdViEkSlDMDfoujiArH6YPfRZWOGz7R38r2hf7YMKEDOlXkdVy0melbyvpUl1Y
         Em6ClmDJiYIGDqvtKN/+u24JkviRbvczUgQ3YlOs4bcgx50bpsy7KiR1C2WZVBgjdIZ2
         xIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780257518; x=1780862318;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yCnn3guwabCfpkvuleLlt1JUIHD9BUV2uNEUmZL7NLU=;
        b=fXWIBGt5K9bFnxr9d0/jCDjx9ezet6PNTAUpmKCcytBB3qBeSMor6juFaUdF2/xCS1
         oS1R8jL/BnByWGtNTNoJPIH/VJYk4mDQYuzwbfUAqg19qTz2P3mYqKQ1XVk3EJ8Ew5VP
         MNXBT4DdT2kkwr0SBpBmCzO74YYyogsYlsCQ0xz85iXFE9QvE16f5WYr3gPmp3IkS9fH
         E6AUSOeLhHIdF4LH5zN2BS43WnJcE20M/d7w6T6swA/r28R5FeMUKUeyRvW+sEA/UUmn
         mBB4XVOJQc3fJH5SoLSaEMi0Y1DoSwt0yxfL4PVnDnd0Gbfj84wlOJ9QbtIqwLBdbGZK
         mwGA==
X-Gm-Message-State: AOJu0Yw2vD3GplmGMCbMtVNN9Kik8+JdNo/7WNfBiEZkTBbgzsmhMa/0
	Avut1nKtVp8Wei4LAqEps2sR1LVECMrTI+hpsHNYgu8YQnO1zRvNwg1W
X-Gm-Gg: Acq92OHqeV9OqKa/dccQG+TPUb3La+qZMIKyqatfBYZfk9J1gYVA9YVmarnJNsqDq4f
	nTCcqobt7wyZUxse2WK2uWht1GKjyIFQJdOmdz/spchoZ1Sexq46pwccM9UJXr5ze1iNvP33wv9
	WIXHmLz3h35YonKSvJJnCyphEVv0CwSlBh54gPosMUmDfqcJyc3ZqUwqycN8qGhxB9V30isTWtt
	P9/BathReBa+RwgHSv92noM16ivshk5E8Zyy9nkvATgiKRp68Em3GJbbeaj/6d3HMhleY2PvYh5
	ugLMBTUV7s0x0b3ngUtuqoJpUW77ZkOFa9zlThzrPDSdS2U6OWR8Jo3QBT9kNXhTYhvx6gUXAEv
	Ns24RZNjYsqSatJBVMCkX9Ocqhmm4RJXzn8mLu4B/s97eO4UfYBlbeKFLrVBxU1hYh6uGStxLta
	v06+Mv2Oorgy3UyioJg7MUVmClqf6SChVzhmViOL5Vaj8JqaF5Pqqd03fZYAnk
X-Received: by 2002:a05:600d:844a:10b0:48a:5565:ec3d with SMTP id 5b1f17b1804b1-490a294935bmr110375065e9.22.1780257517494;
        Sun, 31 May 2026 12:58:37 -0700 (PDT)
Received: from [127.0.1.1] ([2001:4bb8:152:df59:bc17:a305:8902:fb31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d7002e8sm220323775e9.15.2026.05.31.12.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 12:58:37 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sun, 31 May 2026 21:58:22 +0200
Subject: [PATCH v4 2/4] iio: light: add support for veml6031x00 ALS series
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-veml6031x00-v4-2-e64f7fdce38d@gmail.com>
References: <20260531-veml6031x00-v4-0-e64f7fdce38d@gmail.com>
In-Reply-To: <20260531-veml6031x00-v4-0-e64f7fdce38d@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780257511; l=21515;
 i=javier.carrasco.cruz@gmail.com; s=20260111; h=from:subject:message-id;
 bh=dUeXI2B/ieLHS6AKK5iWOLKH86UnXfQa0fZpVX2ZWwQ=;
 b=2Wrv93UTVZCArng5CDFqdZTsZVTEHTcv1PdReUXDVU/QAgoCv/3Ny5ShY1RHDQNzB3AD1d1BE
 VVamVvis8CSD/93iXLwjcPW+qRFO6kGInY0UsnhH4ilmbwLkyk5QFWN
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=Lge8w8xidNSf/INy7JAIbAW+Hezkp3nsBh2OjKL7lLU=

These sensors provide two light channels (ALS and IR), I2C communication
and a multiplexed interrupt line to signal data ready and configurable
threshold alarms.

This first implementation provides basic functionality (measurement
configuration, raw reads and ID validation) and defines the different
register regions in preparation for extended features in the subsequent
patches of the series.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 MAINTAINERS                     |   1 +
 drivers/iio/light/Kconfig       |  12 +
 drivers/iio/light/Makefile      |   1 +
 drivers/iio/light/veml6031x00.c | 680 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 694 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 921da7584963..db800537aefc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -28379,6 +28379,7 @@ VISHAY VEML6031X00 AMBIENT LIGHT SENSOR DRIVER
 M:	Javier Carrasco <javier.carrasco.cruz@gmail.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
+F:	drivers/iio/light/veml6031x00.c
 
 VISHAY VEML6046X00 RGBIR COLOR SENSOR DRIVER
 M:	Andreas Klinger <ak@it-klinger.de>
diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index eff33e456c70..99a6ed80c7db 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -713,6 +713,18 @@ config VEML6030
 	  To compile this driver as a module, choose M here: the
 	  module will be called veml6030.
 
+config VEML6031X00
+	tristate "VEML6031X00 ambient light sensor series"
+	select REGMAP_I2C
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
index 000000000000..6f9a7bad44d4
--- /dev/null
+++ b/drivers/iio/light/veml6031x00.c
@@ -0,0 +1,680 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * VEML6031X00 Ambient Light Sensor
+ *
+ * Copyright (c) 2026, Javier Carrasco <javier.carrasco.cruz@gmail.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/units.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/iio-gts-helper.h>
+
+/* Device registers */
+#define VEML6031X00_REG_CONF0       0x00
+#define VEML6031X00_REG_CONF1       0x01
+#define VEML6031X00_REG_ALS_L       0x10
+#define VEML6031X00_REG_ALS_H       0x11
+#define VEML6031X00_REG_IR_L        0x12
+#define VEML6031X00_REG_IR_H        0x13
+#define VEML6031X00_REG_ID_L        0x14
+#define VEML6031X00_REG_ID_H        0x15
+
+/* Bit masks for specific functionality */
+#define VEML6031X00_CONF0_SD        BIT(0)
+#define VEML6031X00_CONF1_IR_SD     BIT(7)
+
+struct veml6031x00_rf {
+	struct regmap_field *gain;
+	struct regmap_field *it;
+	struct regmap_field *pd_div4;
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
+	struct veml6031x00_rf rf;
+	const struct veml6031x00_chip *chip;
+	/*
+	 * Serialize access to scale register fields scattered across multiple
+	 * registers (rf.gain, rf.pd_div4, rf.it) to read and write them as a
+	 * consistent set.
+	 */
+	struct mutex scale_lock;
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
+	GAIN_SCALE_GAIN(1, VEML6031X00_SEL_MILLI_GAIN_X125),
+	GAIN_SCALE_GAIN(2, VEML6031X00_SEL_MILLI_GAIN_X250),
+	GAIN_SCALE_GAIN(4, VEML6031X00_SEL_MILLI_GAIN_X500),
+	GAIN_SCALE_GAIN(8, VEML6031X00_SEL_MILLI_GAIN_X1000),
+	GAIN_SCALE_GAIN(16, VEML6031X00_SEL_MILLI_GAIN_X2000),
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
+static const struct iio_chan_spec veml6031x00_channels[] = {
+	{
+		.type = IIO_LIGHT,
+		.address = VEML6031X00_REG_ALS_L,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),
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
+	},
+};
+
+static const struct regmap_range veml6031x00_readable_ranges[] = {
+	regmap_reg_range(VEML6031X00_REG_CONF0, VEML6031X00_REG_CONF1),
+	regmap_reg_range(VEML6031X00_REG_ALS_L, VEML6031X00_REG_ID_H),
+};
+
+static const struct regmap_access_table veml6031x00_readable_table = {
+	.yes_ranges = veml6031x00_readable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(veml6031x00_readable_ranges),
+};
+
+static const struct regmap_range veml6031x00_writable_ranges[] = {
+	regmap_reg_range(VEML6031X00_REG_CONF0, VEML6031X00_REG_CONF1),
+};
+
+static const struct regmap_access_table veml6031x00_writable_table = {
+	.yes_ranges = veml6031x00_writable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(veml6031x00_writable_ranges),
+};
+
+static const struct regmap_range veml6031x00_volatile_ranges[] = {
+	regmap_reg_range(VEML6031X00_REG_ALS_L, VEML6031X00_REG_IR_H),
+};
+
+static const struct regmap_access_table veml6031x00_volatile_table = {
+	.yes_ranges = veml6031x00_volatile_ranges,
+	.n_yes_ranges = ARRAY_SIZE(veml6031x00_volatile_ranges),
+};
+
+static const struct regmap_config veml6031x00_regmap_config = {
+	.name = "veml6031x00_regmap",
+	.reg_bits = 8,
+	.val_bits = 8,
+	.rd_table = &veml6031x00_readable_table,
+	.wr_table = &veml6031x00_writable_table,
+	.volatile_table = &veml6031x00_volatile_table,
+	.max_register = VEML6031X00_REG_ID_H,
+	.cache_type = REGCACHE_MAPLE,
+};
+
+static const struct reg_field veml6031x00_rf_it =
+	REG_FIELD(VEML6031X00_REG_CONF0, 4, 6);
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
+	return 0;
+}
+
+static int veml6031x00_get_it(struct veml6031x00_data *data, int *val2)
+{
+	int ret, it_idx;
+
+	scoped_guard(mutex, &data->scale_lock) {
+		ret = regmap_field_read(data->rf.it, &it_idx);
+		if (ret)
+			return ret;
+	}
+
+	ret = iio_gts_find_int_time_by_sel(&data->gts, it_idx);
+	if (ret < 0)
+		return ret;
+
+	*val2 = ret;
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
+	guard(mutex)(&data->scale_lock);
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
+static int veml6031x00_set_scale(struct iio_dev *iio, int val, int val2)
+{
+	struct veml6031x00_data *data = iio_priv(iio);
+	int gain_sel, it_sel, ret;
+
+	ret = iio_gts_find_gain_time_sel_for_scale(&data->gts, val, val2,
+						   &gain_sel, &it_sel);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&data->scale_lock);
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
+	scoped_guard(mutex, &data->scale_lock) {
+		ret = regmap_field_read(data->rf.gain, &gain_reg);
+		if (ret)
+			return ret;
+
+		ret = regmap_field_read(data->rf.pd_div4, &pd_div4);
+		if (ret)
+			return ret;
+
+		sel = (pd_div4 << 2) | gain_reg;
+		gain = iio_gts_find_gain_by_sel(&data->gts, sel);
+		if (gain < 0)
+			return gain;
+
+		ret = regmap_field_read(data->rf.it, &it_reg);
+		if (ret)
+			return ret;
+	}
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
+static int veml6031x00_single_read(struct iio_dev *iio, enum iio_chan_type type,
+				   int *val)
+{
+	struct veml6031x00_data *data = iio_priv(iio);
+	int addr, it_usec, ret;
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
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(data->dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return ret;
+
+	ret = veml6031x00_get_it(data, &it_usec);
+	if (ret < 0)
+		return ret;
+
+	/* integration time + 10 % to ensure completion */
+	fsleep(it_usec + (it_usec / 10));
+
+	ret = regmap_bulk_read(data->regmap, addr, &reg, sizeof(reg));
+	if (ret)
+		return ret;
+
+	*val = le16_to_cpu(reg);
+	return IIO_VAL_INT;
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
+		return veml6031x00_get_it(data, val2);
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
+	default:
+		return -EINVAL;
+	}
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
+static const struct iio_info veml6031x00_info = {
+	.read_raw = veml6031x00_read_raw,
+	.read_avail = veml6031x00_read_avail,
+	.write_raw = veml6031x00_write_raw,
+	.write_raw_get_fmt = veml6031x00_write_raw_get_fmt,
+};
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
+	int ret;
+
+	/* Max resolution = 6.9632 lx/cnt for gain = 0.125 and IT = 3.125ms */
+	ret = devm_iio_init_iio_gts(dev, 6, 963200000,
+				    veml6031x00_gain_sel,
+				    ARRAY_SIZE(veml6031x00_gain_sel),
+				    veml6031x00_it_sel,
+				    ARRAY_SIZE(veml6031x00_it_sel),
+				    &data->gts);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to init iio gts\n");
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
+	ret = devm_mutex_init(dev, &data->scale_lock);
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
+	/* The device starts in power down mode by default */
+	ret = veml6031x00_als_power_on(data);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to power on the device\n");
+
+	ret = devm_add_action_or_reset(dev, veml6031x00_als_shutdown_action, data);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add shutdown action\n");
+
+	pm_runtime_set_autosuspend_delay(dev, 2000);
+	pm_runtime_use_autosuspend(dev);
+	ret = devm_pm_runtime_set_active_enabled(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable runtime PM\n");
+
+	ret = devm_pm_runtime_get_noresume(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get runtime PM\n");
+
+	ret = veml6031x00_validate_part_id(data);
+	if (ret)
+		return ret;
+
+	iio->name = data->chip->name;
+	iio->channels = veml6031x00_channels;
+	iio->num_channels = ARRAY_SIZE(veml6031x00_channels);
+	iio->modes = INDIO_DIRECT_MODE;
+	iio->info = &veml6031x00_info;
+
+	ret = veml6031x00_hw_init(iio);
+	if (ret)
+		return ret;
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
+	{
+		.name = "veml6031x00",
+		.driver_data = (kernel_ulong_t)&veml6031x00_chip
+	},
+	{
+		.name = "veml6031x01",
+		.driver_data = (kernel_ulong_t)&veml6031x01_chip },
+	{
+		.name = "veml60311x00",
+		.driver_data = (kernel_ulong_t)&veml60311x00_chip
+	},
+	{
+		.name = "veml60311x01",
+		.driver_data = (kernel_ulong_t)&veml60311x01_chip
+	},
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

