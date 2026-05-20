Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F84937BE9C
	for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 21:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779311781; cv=none; b=TnVSJr3Q2lmrITCo4mcfKNmL942kD+H2ciIMo4eYVGoq5ceoDiSM3pBmcLKfk1JE9jTfa1Q1jLLBRaLGu+x73ars71DR6aT6hOnRjcGBqL6Ksrq328ZeHwH/HaExwEG1nCIFiDt6tB3oMKlHXZ3Wtcxvw+bT7EL5yPlXsV/IzRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779311781; c=relaxed/simple;
	bh=jcxmhUYCLzvJomDllJwXOr8J+/4SyOyHiCVicCdhhyM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tEkVO6F9WTKM9/bAipj4AJQhcUJUDCkJFVYyy+LPWtncYJQfTgNKlrhcgNUwC0eOLcmFMU1rZiS+kui2sIdr963/9gvvX398uxnEfprhMJ9Go0jSIxETX8sHW+2rBq/elqmAOWSLag2K9N4hdIL2PoqvIJCTuzGuACXi2pmQER4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YlgrCGBW; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlgrCGBW"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso47573825e9.2
        for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 14:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779311778; x=1779916578; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k2Wno4iGEmIqRcLVb/jC6n8e0g4QLXyqrnnmfOd1vJA=;
        b=YlgrCGBWb9S1iUZagYuRuDRQc0mB2/KuSxgFRjDcqTdbtmdTUOS7Jn9hCZACbAvs/L
         WmNt58bYUve4aCQOLw19iq67i5z2qIFoaa2LlRvC7U0EKXWVBpKHcxYzOOcx0FnJWz4m
         vgpoJFWMYnKMfwmNwqlKx6S1O+ZbFlsQ9gUCZR7c7N1+XA6gThO5ro9khAfOG7RFCgj5
         VLaAXeq5nPpMqcmEMSBp462iRcJVUDD4mJl+i4pmJXYmCJ9PP0kf4IjljhEh0Gubl/vr
         8kgeR/j9a9+rzk4Ske07K1y3apHGKEezYz7FK3m2qh93ROVxIhLnp/fK/ydKUsGkUGLz
         2fPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779311778; x=1779916578;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k2Wno4iGEmIqRcLVb/jC6n8e0g4QLXyqrnnmfOd1vJA=;
        b=j+utsnwxqYoVayA6OuGWizX6+grKicJTaHgyPCspKbkL+1206yeWJUEFSkTiaAD1iq
         Wk2vKLgXA3bx2Hd1Hur1A+l5T4J91TBYCueplXJBYBKqBHlb422v+aLFwBrUyLMGaWdz
         ZHeQPUGu6jcLHjW41HeV3JLoPy3MSDPvBdHLV7X0T5MDvU/bMU6UUJSx28NTzMvTMnSV
         9uu0Tp309/lWA2Ms5tmUP2aB82p9KGnjahuDd0CnjfMN9lHDAtw3D6cfvf3MlAPaXOe/
         KGPJmitzEdSSFqyCAxmHOHt9FU4x4jzPG6KsFIh3BHGzq4I3N7uJziz6VmWkLcwT4PWF
         up8w==
X-Gm-Message-State: AOJu0YytTtriAVe8Z2jeK937bleRakMIFEYVVrAVMQEqczIjEw1gZ7Uf
	d72cnz5nI0B/rFnaxJ2cP9XwkunsU+8zOHq8HTxy2rY3hUdBMK8gA13u
X-Gm-Gg: Acq92OGADedNqhGmPe2ykx36M+AjBzg2Nvy+uom3G/jAJBSVK6EDnHOD/XZnWTBxt4M
	Mos+vWEz3AE4J/Mg9s4JLu7331MAn40vMlWdDCH6NP9Cb4Ki+Zs9NrXW+q2+t7aYoh8v3r0QbZc
	MzNvSqAcGrrWC82hMlMndJSnHfaO6UuvewmN/0YqiKmIZrghioRr3vEno1YFtodhfj9gOBYCaL3
	QUMQHWkAQNxqVEa7LAZ/scMIy05M9J9v5ljhlPJxJrhWZbfVdaTB9/Hd/jnTk8LJ6jg+8+vU09U
	vrBkLFrCqUc7Y6vG8SnYilACwKcUoJxqd5NNVw2F5y5Fdch4dHDJbApsdddbmlQXZG0fZYVybUh
	HSaVcSnToKglHyHhI1kNDSXBMoXioS6retUUd6X5X+MXBK0wUoN4dHQZaeOFLYp1xZSkKcUbMOe
	2ATZr3gIjv8h+P1OZNoi18gKAD61sEkbSt9mKozBWHq1ANxkJlY3k6PjsmazfOOINRZMFCOSuaK
	ltNR/oQXD0RJd3K+lBePrwF2AmU2ZcTHUXGlN2J96l37eVmiUejRYWrE8d6zkrsx/5n5dqfXAh0
	tWthugPBofETiu6r5yccMYhtkWHQQDFrDT+F8fvZsijvkG8UKfDciUNkYSqQ2HUoOeDJZLKyL7/
	1sJY=
X-Received: by 2002:a05:600c:5298:b0:48a:563c:c8c0 with SMTP id 5b1f17b1804b1-49036034241mr669855e9.7.1779311777792;
        Wed, 20 May 2026 14:16:17 -0700 (PDT)
Received: from systembl0wer.localdomain (ip-86-49-246-187.bb.vodafone.cz. [86.49.246.187])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49033d5987esm16499845e9.12.2026.05.20.14.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 14:16:17 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 20 May 2026 23:15:38 +0200
Subject: [PATCH v2 2/2] iio: light: veml3328: add support for new device
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-veml3328-v2-2-a57f0d9e28d4@gmail.com>
References: <20260520-veml3328-v2-0-a57f0d9e28d4@gmail.com>
In-Reply-To: <20260520-veml3328-v2-0-a57f0d9e28d4@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Rishi Gupta <gupt21@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779311774; l=13434;
 i=joshua.crofts1@gmail.com; s=20260516; h=from:subject:message-id;
 bh=jcxmhUYCLzvJomDllJwXOr8J+/4SyOyHiCVicCdhhyM=;
 b=e6cztAnbWfR4Oq5Kx5j+AzARS/kwrjvNW+++YOCDNHi3yWRTtHWBnMt4Onsh9UKdz0Fdm62Zn
 mCXhqdRmJWGBi8/dqYL/JjHxBLY6SgTORYLhXII33uRNJkggLaa9jWi
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=d2X8EVKEB2uF4AaPPi3iSSI+IJF3/9kOoDYVVmc+G1o=

Add support for the Vishay VEML3328 RGB/IR light sensor communicating
via I2C (SMBus compatible).

Also add a new entry for said driver into Kconfig and Makefile.

Assisted-by: Gemini:3.1-Pro
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 MAINTAINERS                  |   5 +
 drivers/iio/light/Kconfig    |  11 ++
 drivers/iio/light/Makefile   |   1 +
 drivers/iio/light/veml3328.c | 416 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 433 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d6c3c7d22403..8236ba0c41ca 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -28386,6 +28386,11 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
 F:	drivers/iio/light/veml3235.c
 
+VISHAY VEML3328 RGB IR LIGHT SENSOR DRIVER
+M:	Joshua Crofts <joshua.crofts1@gmail.com>
+S:	Maintained
+F:	drivers/iio/light/veml3328.c
+
 VISHAY VEML6030 AMBIENT LIGHT SENSOR DRIVER
 M:	Javier Carrasco <javier.carrasco.cruz@gmail.com>
 S:	Maintained
diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index eff33e456c70..1c00bb0de6c8 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -699,6 +699,17 @@ config VEML3235
 	  To compile this driver as a module, choose M here: the
 	  module will be called veml3235.
 
+config VEML3328
+	tristate "VEML3328 RGBCIR light sensor"
+	select REGMAP_I2C
+	depends on I2C
+	help
+	  Say Y here if you want to build a driver for the Vishay VEML3328
+	  RGB IR light sensor.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called veml3328
+
 config VEML6030
 	tristate "VEML6030 and VEML6035 ambient light sensors"
 	select REGMAP_I2C
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index c0048e0d5ca8..e03c6e23a9a4 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -65,6 +65,7 @@ obj-$(CONFIG_US5182D)		+= us5182d.o
 obj-$(CONFIG_VCNL4000)		+= vcnl4000.o
 obj-$(CONFIG_VCNL4035)		+= vcnl4035.o
 obj-$(CONFIG_VEML3235)		+= veml3235.o
+obj-$(CONFIG_VEML3328)		+= veml3328.o
 obj-$(CONFIG_VEML6030)		+= veml6030.o
 obj-$(CONFIG_VEML6040)		+= veml6040.o
 obj-$(CONFIG_VEML6046X00)	+= veml6046x00.o
diff --git a/drivers/iio/light/veml3328.c b/drivers/iio/light/veml3328.c
new file mode 100644
index 000000000000..fdfa8fd1666b
--- /dev/null
+++ b/drivers/iio/light/veml3328.c
@@ -0,0 +1,416 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Vishay VEML3328 RGBCIR light sensor driver
+ *
+ * Copyright (c) 2026 Joshua Crofts <joshua.crofts1@gmail.com>
+ *
+ * Datasheet: https://www.vishay.com/docs/84968/veml3328.pdf
+ */
+
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/time.h>
+#include <linux/types.h>
+
+#include <linux/iio/iio.h>
+
+#define VEML3328_REG_CONF		0x00
+#define VEML3328_REG_ID			0x0c
+#define VEML3328_REG_DATA_C		0x04
+#define VEML3328_REG_DATA_R		0x05
+#define VEML3328_REG_DATA_G		0x06
+#define VEML3328_REG_DATA_B		0x07
+#define VEML3328_REG_DATA_IR		0x08
+
+#define VEML3328_CONF_IT_MASK		GENMASK(5, 4)
+#define VEML3328_CONF_GAIN_MASK		GENMASK(11, 10)
+
+#define VEML3328_MAX_IT_TIME		(400 * USEC_PER_MSEC)
+
+#define VEML3328_ID_VAL			0x28
+
+#define VEML3328_SHUTDOWN		(BIT(0) | BIT(15))
+
+struct veml3328_data {
+	struct regmap *regmap;
+};
+
+static const struct regmap_config veml3328_regmap_config = {
+	.name = "veml3328",
+	.reg_bits = 8,
+	.val_bits = 16,
+	.max_register = VEML3328_REG_ID,
+	.val_format_endian = REGMAP_ENDIAN_LITTLE,
+};
+
+#define VEML3328_CHAN_SPEC(_color, _addr) { \
+	.type = IIO_INTENSITY, \
+	.modified = 1, \
+	.channel2 = IIO_MOD_LIGHT_##_color, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) | \
+				   BIT(IIO_CHAN_INFO_SCALE), \
+	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) | \
+					     BIT(IIO_CHAN_INFO_SCALE), \
+	.address = _addr, \
+}
+
+static const struct iio_chan_spec veml3328_channels[] = {
+	{
+		.type = IIO_LIGHT,
+
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
+		.address = VEML3328_REG_DATA_G,
+	},
+	VEML3328_CHAN_SPEC(CLEAR, VEML3328_REG_DATA_C),
+	VEML3328_CHAN_SPEC(RED, VEML3328_REG_DATA_R),
+	VEML3328_CHAN_SPEC(GREEN, VEML3328_REG_DATA_G),
+	VEML3328_CHAN_SPEC(BLUE, VEML3328_REG_DATA_B),
+	VEML3328_CHAN_SPEC(IR, VEML3328_REG_DATA_IR),
+};
+
+/* scale values per datasheet */
+static const int veml3328_scale_vals[][2] = {
+	{ 0, 500000 },
+	{ 1, 0 },
+	{ 2, 0 },
+	{ 4, 0 },
+};
+
+/* integration times in microseconds */
+static const int veml3328_it_times[][2] = {
+	{ 0, 50 * USEC_PER_MSEC },
+	{ 0, 100 * USEC_PER_MSEC },
+	{ 0, 200 * USEC_PER_MSEC },
+	{ 0, 400 * USEC_PER_MSEC },
+};
+
+static int veml3328_power_down(struct veml3328_data *data)
+{
+	return regmap_set_bits(data->regmap, VEML3328_REG_CONF,
+			       VEML3328_SHUTDOWN);
+}
+
+static int veml3328_power_up(struct veml3328_data *data)
+{
+	int ret;
+
+	ret = regmap_clear_bits(data->regmap, VEML3328_REG_CONF,
+				VEML3328_SHUTDOWN);
+	if (ret)
+		return ret;
+
+	/*
+	 * Sleep for maximum integration time to ensure sensor is powered on
+	 * correctly.
+	 */
+	fsleep(VEML3328_MAX_IT_TIME);
+
+	return 0;
+}
+
+static void veml3328_power_down_action(void *data)
+{
+	veml3328_power_down(data);
+}
+
+static int veml3328_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int *val, int *val2, long mask)
+{
+	struct veml3328_data *data = iio_priv(indio_dev);
+	struct regmap *regmap = data->regmap;
+	struct device *dev = regmap_get_device(regmap);
+	unsigned int reg_val;
+	int ret;
+	int reg;
+
+	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = regmap_read(regmap, chan->address, &reg_val);
+		if (ret)
+			return ret;
+
+		*val = reg_val;
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_INT_TIME:
+		ret = regmap_read(regmap, VEML3328_REG_CONF, &reg_val);
+		if (ret)
+			return ret;
+
+		reg = FIELD_GET(VEML3328_CONF_IT_MASK, reg_val);
+		if (reg >= ARRAY_SIZE(veml3328_it_times))
+			return -EINVAL;
+
+		*val = veml3328_it_times[reg][0];
+		*val2 = veml3328_it_times[reg][1];
+		return IIO_VAL_INT_PLUS_MICRO;
+
+	case IIO_CHAN_INFO_SCALE:
+		ret = regmap_read(regmap, VEML3328_REG_CONF, &reg_val);
+		if (ret)
+			return ret;
+
+		if (chan->type == IIO_LIGHT) {
+			int it_inx, gain_inx;
+			int it_us, scale_u;
+
+			it_inx = FIELD_GET(VEML3328_CONF_IT_MASK, reg_val);
+			gain_inx = FIELD_GET(VEML3328_CONF_GAIN_MASK, reg_val);
+
+			if (it_inx >= ARRAY_SIZE(veml3328_it_times) ||
+			    gain_inx >= ARRAY_SIZE(veml3328_scale_vals))
+				return -EINVAL;
+
+			it_us = veml3328_it_times[it_inx][1];
+
+			/*
+			 * Equation for calculating ambient light scale:
+			 * Scale = 0.384 * (50000 / Current_IT) * (1x / Current_Gain)
+			 */
+			scale_u = 384 * USEC_PER_MSEC;
+			scale_u = scale_u  * 50000 / it_us;
+
+			switch (gain_inx) {
+			case 0:
+				scale_u *= 2;
+				break;
+			case 1:
+				break;
+			case 2:
+				scale_u /= 2;
+				break;
+			case 3:
+				scale_u /= 4;
+				break;
+			default:
+				return -EINVAL;
+			}
+
+			*val = 0;
+			*val2 = scale_u;
+
+			return IIO_VAL_INT_PLUS_MICRO;
+		}
+
+		reg = FIELD_GET(VEML3328_CONF_GAIN_MASK, reg_val);
+		if (reg >= ARRAY_SIZE(veml3328_scale_vals))
+			return -EINVAL;
+
+		*val = veml3328_scale_vals[reg][0];
+		*val2 = veml3328_scale_vals[reg][1];
+		return IIO_VAL_INT_PLUS_MICRO;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int veml3328_read_avail(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       const int **vals, int *type, int *length,
+			       long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_INT_TIME:
+		*length = ARRAY_SIZE(veml3328_it_times) * 2;
+		*vals = (const int *)veml3328_it_times;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		return IIO_AVAIL_LIST;
+
+	case IIO_CHAN_INFO_SCALE:
+		*length = ARRAY_SIZE(veml3328_scale_vals) * 2;
+		*vals = (const int *)veml3328_scale_vals;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		return IIO_AVAIL_LIST;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int veml3328_write_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int val, int val2, long mask)
+{
+	struct veml3328_data *data = iio_priv(indio_dev);
+	struct regmap *regmap = data->regmap;
+	struct device *dev = regmap_get_device(regmap);
+	int ret;
+	int i;
+
+	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_INT_TIME:
+		if (val != 0)
+			return -EINVAL;
+
+		for (i = 0; i < ARRAY_SIZE(veml3328_it_times); i++) {
+			if (veml3328_it_times[i][1] == val2)
+				break;
+		}
+
+		if (i == ARRAY_SIZE(veml3328_it_times))
+			return -EINVAL;
+
+		return regmap_update_bits(regmap, VEML3328_REG_CONF,
+					  VEML3328_CONF_IT_MASK,
+					  FIELD_PREP(VEML3328_CONF_IT_MASK, i));
+
+	case IIO_CHAN_INFO_SCALE:
+		for (i = 0; i < ARRAY_SIZE(veml3328_scale_vals); i++) {
+			if (val == veml3328_scale_vals[i][0] &&
+			    val2 == veml3328_scale_vals[i][1])
+				break;
+		}
+
+		if (i == ARRAY_SIZE(veml3328_scale_vals))
+			return -EINVAL;
+
+		return regmap_update_bits(regmap, VEML3328_REG_CONF,
+					  VEML3328_CONF_GAIN_MASK,
+					  FIELD_PREP(VEML3328_CONF_GAIN_MASK, i));
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info veml3328_info = {
+	.read_raw = veml3328_read_raw,
+	.write_raw = veml3328_write_raw,
+	.read_avail = veml3328_read_avail,
+};
+
+static int veml3328_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct veml3328_data *data;
+	struct iio_dev *indio_dev;
+	unsigned int reg_val;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+
+	data->regmap = devm_regmap_init_i2c(client, &veml3328_regmap_config);
+	if (IS_ERR(data->regmap))
+		return dev_err_probe(dev, PTR_ERR(data->regmap),
+				     "Failed to initialize regmap\n");
+
+	ret = devm_regulator_get_enable(dev, "vdd");
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable regulator\n");
+
+	ret = regmap_read(data->regmap, VEML3328_REG_ID, &reg_val);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to read ID register\n");
+
+	if ((reg_val & 0xff) != VEML3328_ID_VAL)
+		dev_warn(dev, "Unknown device ID: 0x%02x\n", reg_val & 0xff);
+
+	ret = veml3328_power_up(data);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to power on sensor\n");
+
+	ret = devm_add_action_or_reset(dev, veml3328_power_down_action, data);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to register teardown\n");
+
+	indio_dev->name = "veml3328";
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &veml3328_info;
+	indio_dev->channels = veml3328_channels;
+	indio_dev->num_channels = ARRAY_SIZE(veml3328_channels);
+
+	pm_runtime_set_active(dev);
+	pm_runtime_set_autosuspend_delay(dev, 2000);
+	pm_runtime_use_autosuspend(dev);
+
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable runtime PM\n");
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static int veml3328_runtime_suspend(struct device *dev)
+{
+	struct veml3328_data *data = iio_priv(dev_get_drvdata(dev));
+	int ret;
+
+	ret = veml3328_power_down(data);
+	if (ret)
+		dev_err(dev, "Failed to suspend: %d\n", ret);
+
+	return ret;
+}
+
+static int veml3328_runtime_resume(struct device *dev)
+{
+	struct veml3328_data *data = iio_priv(dev_get_drvdata(dev));
+	int ret;
+
+	ret = veml3328_power_up(data);
+	if (ret)
+		dev_err(dev, "Failed to resume: %d\n", ret);
+
+	return ret;
+}
+
+static DEFINE_RUNTIME_DEV_PM_OPS(veml3328_pm_ops,
+				 veml3328_runtime_suspend,
+				 veml3328_runtime_resume,
+				 NULL);
+
+static const struct of_device_id veml3328_of_match[] = {
+	{ .compatible = "vishay,veml3328" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, veml3328_of_match);
+
+static const struct i2c_device_id veml3328_id[] = {
+	{ .name = "veml3328" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, veml3328_id);
+
+static struct i2c_driver veml3328_driver = {
+	.driver = {
+		.name = "veml3328",
+		.of_match_table = veml3328_of_match,
+		.pm = pm_ptr(&veml3328_pm_ops),
+	},
+	.probe = veml3328_probe,
+	.id_table = veml3328_id,
+};
+module_i2c_driver(veml3328_driver);
+
+MODULE_AUTHOR("Joshua Crofts <joshua.crofts1@gmail.com>");
+MODULE_DESCRIPTION("VEML3328 RGBCIR Light Sensor");
+MODULE_LICENSE("GPL");

-- 
2.34.1

