Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48DC3D9541
	for <linux-iio@vger.kernel.org>; Tue,  1 Sep 2026 13:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788267958; cv=none; b=J4q7vcwY9sG7SDvNCXxeWwz4VxCJf10TBM+qb2yL75SMQo4NT7aT3pd+P0x1z7CWUxOscZvqZdZbVGjgYuXKH43qWpC5YWNoEIYTyhtKnUz+WoNy4lTpkHmskKEc1ndQl68H621q2Xu/rdgemDMslJtW6lyGPLmaLUOW7UsDs6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788267958; c=relaxed/simple;
	bh=K+dZwDdX5FA+cBNgrU+MPKgYxneqoPoPqHtGtcjSp/k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YKwMQjLHo6o7keC2Rm7D4DHkoYdenDVpSoZn9DMfZvKeUlNg1/ofYY1Wu4oFAgD5Nyeh7ZNfBRD0dBkQoIFPLlyenRUshuh91OIiHJPD/z3sHkkDHkdrisCWE8m72WAHOexqZpZtpb3CpjG5z8KjKbGOb+1mV+/DVYD64tRzQ8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uhx4kKfD; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uhx4kKfD"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49b0eab380eso10911525e9.0
        for <linux-iio@vger.kernel.org>; Tue, 01 Sep 2026 06:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788267954; x=1788872754; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A5Qv66gxQUrcsxq+IMMc7XxmNJGfQIwe+qAYN0zRjnQ=;
        b=Uhx4kKfDltfmSJqTrF2E2ZbQsH4ODZiR/GWU+ISTYSGpmgl26ULziyzUAPmXsH8e8J
         hdunPJXIr9vnhH5If5MtLdAVSfsXwHjfMiXD3h+fYZl8GYG7m7uXV05xthzGR/VeIFDd
         jCeBSMaryvbuZArbmSECCWO/W2xyZxBpuJ/WMB0mdcBX2dycMVBgK4Un3kvPGtxAkE7Z
         /7ZYrCSABW8oW2/EK2e6bJbA7K5SCcw5/WpMC6tNeH6/bZho31omPomLYmybna7M09ab
         +wFr5eQsH6mf7G4jiJvYfnpk7EmHJ3EtNu7dyluDMPglLayhdQGqAQYcd1ZKVnte79Pp
         s+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788267954; x=1788872754;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A5Qv66gxQUrcsxq+IMMc7XxmNJGfQIwe+qAYN0zRjnQ=;
        b=iIPICwHPClNydQcb8Nq0ei8EEd68k1gWWxOrNh4M3Mi3kVa8Nqs1JZfONssAw0Bly9
         PurLtAZ/r/q4s2xCBWPXyc4sVkmIO1H/UDAzRXRvPl/v2qc2uQO393QDDIDVZWAp89fL
         mBLVBraYNM/Xj1wgriKp3cUyFOM8zpNZEhpT8aDCDz5YykVQFjgY/S1RC3okolr/4SLg
         47Br36619O10fg0na0eTG4xzY+LVz3j3x5sEu6qwYUGhkMhCeUHehCaBQr+s3Q8j9tUb
         fTtmcFk5/JizazdqtnPdIMK/ON0hgRrpm5FCMCUmf1HhPqQyAkhJ+LHjvfBuD+f41U5S
         nyPQ==
X-Gm-Message-State: AFuF++kmjODc2/S8v2S0XmH2mZZW0aQg1duNCPwFxMqvODcWJaD1leiv
	dzejn+zJlGGT2GYuebUw0XCvANvp4tyNg7PUm+xL22F6NftfzQ4w/T6j
X-Gm-Gg: AR+sD10NgnMFxqmfTwx7JsYCuQea8rLQ7Upw+LXGqTFH+TnN2ynTBQNshVMxxn8saYD
	QyT8VuyWKxzKTHtkgp9mBJkXh2oxEu5tV+aVysJbjVsarPTdgxd4qnZttay1NEagysz52CocomM
	ABzfRhmDnumR0i+gcrVtMrHvViJGIEla/Nt/9Wjal92BQPM99o/sbfyd7oMfYXFhR3qFnAMQDXU
	U3JQb89Mybh9xJCd6hkrTun4Sqd9dBprnspDJrH/L7hG7UntLv7t2jMpIPZ22RiMcT5Lv3ErJY0
	xBsCOjrCKBlhIkc8LIxzG+2/aovRGjuWMsJwrD/2i3gRrb+nnM7p6f19A+g7RU/YLdhzixTTAf1
	uAYG8ONE2k8y+vrhPP4eVa7SFF+618qU4Q+UmGpV6RQC36plykTXqt8BlQJtsfpyQVNt9Dz9ydH
	TaqwtWab7s3f9y3obsaJVAVnE3FgDPwyG2jptJIzIVLhdZ+jSvMJtdEZbphfKlstAfZztpM/790
	YlZ
X-Received: by 2002:a05:600c:a085:b0:499:59fd:dbfc with SMTP id 5b1f17b1804b1-49cdd402590mr91510595e9.1.1788267953432;
        Tue, 01 Sep 2026 06:05:53 -0700 (PDT)
Received: from [127.0.1.1] ([2001:4bb8:16d:f647:6bd8:c024:aa73:750e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce3e0desm70343395e9.11.2026.09.01.06.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 06:05:52 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 01 Sep 2026 15:05:47 +0200
Subject: [PATCH v8 2/4] iio: light: add support for veml6031x00 ALS series
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-veml6031x00-v8-2-532cb4f2168a@gmail.com>
References: <20260901-veml6031x00-v8-0-532cb4f2168a@gmail.com>
In-Reply-To: <20260901-veml6031x00-v8-0-532cb4f2168a@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788267947; l=21315;
 i=javier.carrasco.cruz@gmail.com; s=20260111; h=from:subject:message-id;
 bh=K+dZwDdX5FA+cBNgrU+MPKgYxneqoPoPqHtGtcjSp/k=;
 b=/Hf21ImgNfj0bX7g0dbZ4Pu+6AhVigr1g1unfLlNHOa0Gflx6+0ZYz/835bWKvjd5vSNdzEWl
 zZIzghWlU1VC96ex+m8w1fKdu6vbPxPs7xFO7YK0TlP1WcCKQuebNt5
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=Lge8w8xidNSf/INy7JAIbAW+Hezkp3nsBh2OjKL7lLU=

Support device identification, raw ALS and IR readings, and configuration
of the scale and integration time.

Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 MAINTAINERS                     |   1 +
 drivers/iio/light/Kconfig       |  12 +
 drivers/iio/light/Makefile      |   1 +
 drivers/iio/light/veml6031x00.c | 678 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 692 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 57202b51fb66..c83f5af23d97 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29099,6 +29099,7 @@ VISHAY VEML6031X00 AMBIENT LIGHT SENSOR DRIVER
 M:	Javier Carrasco <javier.carrasco.cruz@gmail.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
+F:	drivers/iio/light/veml6031x00.c
 
 VISHAY VEML6046X00 RGBIR COLOR SENSOR DRIVER
 M:	Andreas Klinger <ak@it-klinger.de>
diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index f23bbce12c72..02291abeff60 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -741,6 +741,18 @@ config VEML6030
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
index 64e354c49ed8..6672ed01a819 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -68,6 +68,7 @@ obj-$(CONFIG_VCNL4035)		+= vcnl4035.o
 obj-$(CONFIG_VEML3235)		+= veml3235.o
 obj-$(CONFIG_VEML3328)		+= veml3328.o
 obj-$(CONFIG_VEML6030)		+= veml6030.o
+obj-$(CONFIG_VEML6031X00)	+= veml6031x00.o
 obj-$(CONFIG_VEML6040)		+= veml6040.o
 obj-$(CONFIG_VEML6046X00)	+= veml6046x00.o
 obj-$(CONFIG_VEML6070)		+= veml6070.o
diff --git a/drivers/iio/light/veml6031x00.c b/drivers/iio/light/veml6031x00.c
new file mode 100644
index 000000000000..f3772577a05d
--- /dev/null
+++ b/drivers/iio/light/veml6031x00.c
@@ -0,0 +1,678 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * VEML6031X00 Ambient Light Sensor
+ *
+ * Copyright (c) 2026, Javier Carrasco <javier.carrasco.cruz@gmail.com>
+ */
+
+#include <linux/array_size.h>
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/cleanup.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/limits.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/types.h>
+
+#include <asm/byteorder.h>
+
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
+#define VEML6031X00_GAIN_SEL(pd_div4, gain) (((pd_div4) << 2) | (gain))
+
+struct veml6031x00_rf {
+	struct regmap_field *gain;
+	struct regmap_field *it;
+	struct regmap_field *pd_div4;
+};
+
+struct veml6031x00_chip {
+	const char *name;
+	const unsigned int part_id;
+};
+
+struct veml6031x00_data {
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
+ * TODO: add support for GAIN_0_165 and GAIN_0_660
+ */
+#define VEML6031X00_SEL_GAIN_0_125 0x07
+#define VEML6031X00_SEL_GAIN_0_250 0x04
+#define VEML6031X00_SEL_GAIN_0_500 0x03
+#define VEML6031X00_SEL_GAIN_1_000 0x00
+#define VEML6031X00_SEL_GAIN_2_000 0x01
+static const struct iio_gain_sel_pair veml6031x00_gain_sel[] = {
+	GAIN_SCALE_GAIN(1, VEML6031X00_SEL_GAIN_0_125),
+	GAIN_SCALE_GAIN(2, VEML6031X00_SEL_GAIN_0_250),
+	GAIN_SCALE_GAIN(4, VEML6031X00_SEL_GAIN_0_500),
+	GAIN_SCALE_GAIN(8, VEML6031X00_SEL_GAIN_1_000),
+	GAIN_SCALE_GAIN(16, VEML6031X00_SEL_GAIN_2_000),
+};
+
+/*
+ * The shutdown bits (SD and ALS_IR_SD) are in different registers, and both
+ * must be updated when changing the device power state.
+ */
+static int veml6031x00_set_power(struct veml6031x00_data *data, bool state)
+{
+	int ret;
+
+	ret = regmap_assign_bits(data->regmap, VEML6031X00_REG_CONF0,
+				 VEML6031X00_CONF0_SD, !state);
+	if (ret)
+		return ret;
+
+	return regmap_assign_bits(data->regmap, VEML6031X00_REG_CONF1,
+				  VEML6031X00_CONF1_IR_SD, !state);
+}
+
+static void veml6031x00_als_shutdown_action(void *data)
+{
+	struct veml6031x00_data *priv = data;
+	struct device *dev = regmap_get_device(priv->regmap);
+	int ret;
+
+	ret = veml6031x00_set_power(priv, false);
+	if (ret)
+		dev_warn(dev, "Failed to shut down device: %d\n", ret);
+}
+
+static const struct iio_chan_spec veml6031x00_channels[] = {
+	{
+		.type = IIO_LIGHT,
+		.address = VEML6031X00_REG_ALS_L,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_INT_TIME) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_INT_TIME) |
+						BIT(IIO_CHAN_INFO_SCALE),
+	},
+	{
+		.type = IIO_INTENSITY,
+		.address = VEML6031X00_REG_IR_L,
+		.modified = 1,
+		.channel2 = IIO_MOD_LIGHT_IR,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
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
+	/* AF_TRIG in CONF0 is volatile */
+	regmap_reg_range(VEML6031X00_REG_CONF0, VEML6031X00_REG_CONF0),
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
+	struct regmap *map = data->regmap;
+	struct device *dev = regmap_get_device(map);
+	struct regmap_field *rm_field;
+	struct veml6031x00_rf *rf = &data->rf;
+
+	rm_field = devm_regmap_field_alloc(dev, map, veml6031x00_rf_gain);
+	if (IS_ERR(rm_field))
+		return PTR_ERR(rm_field);
+	rf->gain = rm_field;
+
+	rm_field = devm_regmap_field_alloc(dev, map, veml6031x00_rf_it);
+	if (IS_ERR(rm_field))
+		return PTR_ERR(rm_field);
+	rf->it = rm_field;
+
+	rm_field = devm_regmap_field_alloc(dev, map, veml6031x00_rf_pd_div4);
+	if (IS_ERR(rm_field))
+		return PTR_ERR(rm_field);
+	rf->pd_div4 = rm_field;
+
+	return 0;
+}
+
+static int __veml6031x00_get_it(struct veml6031x00_data *data, int *val2)
+{
+	unsigned int it_idx;
+	int ret;
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
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int veml6031x00_get_it(struct veml6031x00_data *data, int *val2)
+{
+	guard(mutex)(&data->scale_lock);
+
+	return __veml6031x00_get_it(data, val2);
+}
+
+static int veml6031x00_write_gain(struct veml6031x00_data *data, unsigned int gain)
+{
+	int ret;
+
+	ret = regmap_field_write(data->rf.pd_div4, gain >> 2);
+	if (ret)
+		return ret;
+
+	return regmap_field_write(data->rf.gain, gain & 0x03);
+}
+
+static int veml6031x00_set_it(struct iio_dev *iio, int val, int val2)
+{
+	struct veml6031x00_data *data = iio_priv(iio);
+	struct device *dev = regmap_get_device(data->regmap);
+	int ret, gain_sel, new_gain, prev_gain, prev_it;
+	unsigned int gain_reg, it_idx, pd_div4;
+	struct iio_gts *gts = &data->gts;
+	bool gain_in_range;
+
+	if (val || !iio_gts_valid_time(gts, val2))
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
+	prev_it = iio_gts_find_int_time_by_sel(gts, it_idx);
+	if (prev_it < 0)
+		return prev_it;
+
+	if (prev_it == val2)
+		return 0;
+
+	gain_sel = VEML6031X00_GAIN_SEL(pd_div4, gain_reg);
+	prev_gain = iio_gts_find_gain_by_sel(gts, gain_sel);
+	if (prev_gain < 0)
+		return prev_gain;
+
+	ret = iio_gts_find_new_gain_by_gain_time_min(gts, prev_gain, prev_it, val2,
+						     &new_gain, &gain_in_range);
+	if (ret)
+		return ret;
+
+	if (!gain_in_range)
+		dev_dbg(dev, "Optimal gain out of range\n");
+
+	ret = iio_gts_find_sel_by_int_time(gts, val2);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_field_write(data->rf.it, ret);
+	if (ret)
+		return ret;
+
+	gain_sel = iio_gts_find_sel_by_gain(gts, new_gain);
+	if (gain_sel < 0)
+		return gain_sel;
+
+	return veml6031x00_write_gain(data, gain_sel);
+}
+
+static int veml6031x00_set_scale(struct iio_dev *iio, int val, int val2)
+{
+	struct veml6031x00_data *data = iio_priv(iio);
+	struct iio_gts *gts = &data->gts;
+	int gain_sel, it_sel, ret;
+
+	ret = iio_gts_find_gain_time_sel_for_scale(gts, val, val2, &gain_sel, &it_sel);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&data->scale_lock);
+
+	ret = regmap_field_write(data->rf.it, it_sel);
+	if (ret)
+		return ret;
+
+	return veml6031x00_write_gain(data, gain_sel);
+}
+
+static int veml6031x00_get_scale(struct veml6031x00_data *data, int *val, int *val2)
+{
+	unsigned int gain_reg, pd_div4, it_reg;
+	int gain, it, ret, sel;
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
+		sel = VEML6031X00_GAIN_SEL(pd_div4, gain_reg);
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
+	unsigned int addr;
+	int it_usec, ret;
+	__le16 regval;
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
+	guard(mutex)(&data->scale_lock);
+
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(regmap_get_device(data->regmap), pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return ret;
+
+	ret = __veml6031x00_get_it(data, &it_usec);
+	if (ret < 0)
+		return ret;
+
+	/* integration time + 10% to ensure completion */
+	fsleep(it_usec + (it_usec / 10));
+
+	ret = regmap_bulk_read(data->regmap, addr, &regval, sizeof(regval));
+	if (ret)
+		return ret;
+
+	*val = le16_to_cpu(regval);
+
+	return IIO_VAL_INT;
+}
+
+static int veml6031x00_read_raw(struct iio_dev *iio,
+				struct iio_chan_spec const *chan,
+				int *val, int *val2, long mask)
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
+	struct regmap *map = data->regmap;
+	struct device *dev = regmap_get_device(map);
+	unsigned int part_id;
+	int ret;
+	__le16 regval;
+
+	ret = regmap_bulk_read(map, VEML6031X00_REG_ID_L, &regval, sizeof(regval));
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to read ID\n");
+
+	part_id = le16_to_cpu(regval);
+	if (part_id != data->chip->part_id)
+		dev_info(dev, "Unknown or unexpected ID %04x\n", part_id);
+
+	return 0;
+}
+
+static int veml6031x00_probe(struct i2c_client *i2c)
+{
+	struct device *dev = &i2c->dev;
+	struct veml6031x00_data *data;
+	struct iio_dev *iio;
+	int ret;
+
+	iio = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!iio)
+		return -ENOMEM;
+
+	data = iio_priv(iio);
+	i2c_set_clientdata(i2c, iio);
+
+	data->chip = i2c_get_match_data(i2c);
+	if (!data->chip)
+		return dev_err_probe(dev, -ENODATA, "Failed to get chip data\n");
+
+	ret = devm_mutex_init(dev, &data->scale_lock);
+	if (ret)
+		return ret;
+
+	data->regmap = devm_regmap_init_i2c(i2c, &veml6031x00_regmap_config);
+	if (IS_ERR(data->regmap))
+		return dev_err_probe(dev, PTR_ERR(data->regmap),
+				     "Failed to set regmap\n");
+
+	iio->name = data->chip->name;
+	iio->channels = veml6031x00_channels;
+	iio->num_channels = ARRAY_SIZE(veml6031x00_channels);
+	iio->modes = INDIO_DIRECT_MODE;
+	iio->info = &veml6031x00_info;
+
+	ret = veml6031x00_regfield_init(data);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to init regfield\n");
+
+	ret = devm_regulator_get_enable(dev, "vdd");
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable regulator\n");
+
+	/* The device starts in power down mode by default */
+	ret = veml6031x00_set_power(data, true);
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
+	ret = veml6031x00_validate_part_id(data);
+	if (ret)
+		return ret;
+
+	/* Max resolution = 6.9632 lx/cnt for gain = 0.125 and IT = 3.125ms */
+	ret = devm_iio_init_iio_gts(dev, 6, 963200000,
+				    veml6031x00_gain_sel,
+				    ARRAY_SIZE(veml6031x00_gain_sel),
+				    veml6031x00_it_sel,
+				    ARRAY_SIZE(veml6031x00_it_sel),
+				    &data->gts);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to init IIO GTS\n");
+
+	ret = devm_iio_device_register(dev, iio);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to register IIO device\n");
+
+	return 0;
+}
+
+static int veml6031x00_runtime_suspend(struct device *dev)
+{
+	struct veml6031x00_data *data = iio_priv(dev_get_drvdata(dev));
+
+	return veml6031x00_set_power(data, false);
+}
+
+static int veml6031x00_runtime_resume(struct device *dev)
+{
+	struct veml6031x00_data *data = iio_priv(dev_get_drvdata(dev));
+
+	return veml6031x00_set_power(data, true);
+}
+
+static DEFINE_RUNTIME_DEV_PM_OPS(veml6031x00_pm_ops,
+				 veml6031x00_runtime_suspend,
+				 veml6031x00_runtime_resume,
+				 NULL);
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
+		.driver_data = (kernel_ulong_t)&veml6031x00_chip,
+	},
+	{
+		.name = "veml6031x01",
+		.driver_data = (kernel_ulong_t)&veml6031x01_chip,
+	},
+	{
+		.name = "veml60311x00",
+		.driver_data = (kernel_ulong_t)&veml60311x00_chip,
+	},
+	{
+		.name = "veml60311x01",
+		.driver_data = (kernel_ulong_t)&veml60311x01_chip,
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

