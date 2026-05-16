Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92E5377EA5
	for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 21:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778968269; cv=none; b=jSAhTs9heEi6CAR6bknEP6J2kZqHP0I7yFn9ZOiGjoNhBurfqy6AlG2eMf9Ja8j02h69t6jgwX1hBtMueer3fjsLOjFJwhOPoaR5Vn3LHin+DlFzQOqQaU36TW78RwdF8U/MshtfG17MmrjWOCWduMCLG5IihIsUXoNx7nj9zrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778968269; c=relaxed/simple;
	bh=KZW5/Dll6J6EEbWPhU7nuTEI5oB+csDjYEK41JlHkY8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DM7J2rw2Zj3aIhSDsm5mhv+Prg0ILmPZsWAuvloBTr2t+3IW+2akgKCAtIq+AGNhjN1JJ6dX9dLbqwdtAzb2z4lkFuWUW6nQKRAPDVtdJc2XLrR7EugBuj+Y9U/kOLAaSOpesA105xbv+A+J+5sduNSFAT+Nqr1d5E5KNAs5fok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZwBEia8; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZwBEia8"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-44c350a5b87so460376f8f.3
        for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 14:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778968265; x=1779573065; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M1tECVgMGwqDJlxm0nkrTu8RzXxKUzfjy6GbpXEs9tc=;
        b=IZwBEia8MYTXIcRksfLky40ltibADY1DnvRefdoMJN2RFT/ADcrX7T3GMsI9ig/YTy
         8bVQAfkCF/ruAY/vwvMpwGqBHiSHoL+X1jwXKz8h6eR12X/r1mEZZlMK8v5FqXWOV0vk
         uWBIlMVK+YZhaH7y/JNw83hzLW4J42AFDeiH1ZWw3UAi/GfIwndzluoe5w6h/RWjYKiR
         iLJc/PgdK/ZzXu1PNj6ueFDGwLVuE3AJeR1z+fuIcfCmoBIFSy9RzfdiI4vhHyEVQYu7
         zrbLa3tiP1Nxu03GZ1qpUsZGB/n5Y0akDWAtIM/ihYQsP+6v90opYXOkTNt7TcZBfCD+
         0+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778968265; x=1779573065;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M1tECVgMGwqDJlxm0nkrTu8RzXxKUzfjy6GbpXEs9tc=;
        b=WNWOGldAsB9ymBkF4ROpU52FhttBed5OCRuaJcQSs23ruDoA7pxghjz393IEko+Y8C
         Q0TdP2RQLzr88SGTB/gQ/GIHTIy2FG73FX3N1bRIXtnhKc2IfINLRIhtvmrohabJJ6n1
         7xuEg7E/BOks0RUfqgCZ8lXwacGsT5nV32hib/xKjvnKqruf3m7kbmGEQENYNgOvwo5p
         YGNBRrfO2cmNoCRoZnNVOIeKkK1cDqJqRbvES+1d7SGsI+9J6rHJJWdjJ8X4TORkS8Kj
         H3MBKGU0VtZpi8c9+pv3D1HkO3izg433cK0m+Bl1H316FYvW46I8+/6KLBl/Rn2UMk6s
         8/NA==
X-Gm-Message-State: AOJu0YwblDpJl1SQsgJAEkkdzEI4zYc8grog4JGZbL4na0Cw8WhxBl2o
	GdfdSgaUZ1ZteQwXCscLrInvobMZv4H0ekvA2XHszjDU2rGKHidjBSyZ
X-Gm-Gg: Acq92OHfo8dYANqTB0NUdXmzU5g6uAVQldCyrhEcqvBWBAIEhEdL7lSxT/uMNu6kqRN
	L0zNed9n/Ir379GFpxkp68iVR4dSSJKoyK3HTUWdWTMW2bQurqWY+n9Ifat38gHFELFG9d1lYyS
	NSyGmILNFUSOYbwtp/eqRyC3lh5A54VwY8T1r0V6pChVbY4GIgCRQiX+0oSmX8gg9KKBN3JilZj
	jFr5wwpfcdcQwLdgMXmo7SQutPJguEIfIiC8Ygy+7NOZ3UvNLzBZ0EbuwrlLaFOpp8PTQ+SjNcO
	NPRMB5drIWSf+EicLxhpqw6OBF+uTqf/1bDWjDVZGg/L4P/Ek6p1XVoErZVw7lC3TESq6sPQlpR
	DZ80n3rDzpry5j6MDRiuT7yoj2jTzY7lNCikcbyWKweu+ap5y8FZrndrDoTKyvdq2CI5+M3tkHP
	XWaHBl18RYMNadtXEFdeC+fyiMz53FaG6u69FcfLrppT0xJE52FQSuW9wJk3JpyeeodI/EAr0Ys
	jn8dR6GuOfAVHU3tuBjicWFTPHySLJW4bSBntFTgrqt3b1kwLTAO2Yj8Lxj49Ja3ySi8LeBI555
	/RnEoWAikiK/5BhX2nNPW0N7+lahfXlDBzGJvmgVJ5YG78uaVwVkhLChGJA=
X-Received: by 2002:a05:6000:1787:b0:45b:d5d7:1f59 with SMTP id ffacd0b85a97d-45e5c5e3282mr13468934f8f.24.1778968264916;
        Sat, 16 May 2026 14:51:04 -0700 (PDT)
Received: from systembl0wer.localdomain ([213.194.212.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da15a5653sm25819528f8f.35.2026.05.16.14.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 14:51:04 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sat, 16 May 2026 23:50:54 +0200
Subject: [PATCH 2/2] iio: light: veml3328: add support for new device
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-veml3328-v1-2-1d4b663e2fe3@gmail.com>
References: <20260516-veml3328-v1-0-1d4b663e2fe3@gmail.com>
In-Reply-To: <20260516-veml3328-v1-0-1d4b663e2fe3@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778968262; l=12175;
 i=joshua.crofts1@gmail.com; s=20260516; h=from:subject:message-id;
 bh=KZW5/Dll6J6EEbWPhU7nuTEI5oB+csDjYEK41JlHkY8=;
 b=vVoYdC5cMa5D3OLeAs0EIgvhpzKmzZdahPvALm0eMUxjHCr22JQNR+mJhBjD6HiPJUrvQWfu9
 p4BiM4/Z6aUBmGEaRLD5wRH8d8HvO81TXn/lwyiNhyFK40SRLaTtIpg
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=d2X8EVKEB2uF4AaPPi3iSSI+IJF3/9kOoDYVVmc+G1o=

Add support for the Vishay VEML3328 RGB/IR light sensor communicating
via I2C (SMBus compatible).

Also add a new entry for said driver into Kconfig and Makefile.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/light/Kconfig    |  11 ++
 drivers/iio/light/Makefile   |   1 +
 drivers/iio/light/veml3328.c | 405 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 417 insertions(+)

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
index 000000000000..9eb5429c813d
--- /dev/null
+++ b/drivers/iio/light/veml3328.c
@@ -0,0 +1,405 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Vishay VEML3328 RGBCIR light sensor driver
+ *
+ * Copyright (c) 2026 Joshua Crofts <joshua.crofts1@gmail.com>
+ *
+ * Datasheet: https://www.vishay.com/docs/84968/veml3328.pdf
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
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
+#define VEML3328_IT_MASK		GENMASK(5, 4)
+#define VEML3328_GAIN_MASK		GENMASK(11, 10)
+
+#define VEML3328_ID_VAL			0x28
+
+#define VEML3328_CONF_SD0		BIT(0)
+#define VEML3328_CONF_SD1		BIT(15)
+#define VEML3328_SHUTDOWN		(VEML3328_CONF_SD0 | VEML3328_CONF_SD1)
+
+struct veml3328_data {
+	struct regmap *regmap;
+	struct device *dev;
+	struct mutex lock;
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
+	{ 0, 50000 },
+	{ 0, 100000 },
+	{ 0, 200000 },
+	{ 0, 400000 },
+};
+
+static int veml3328_power_down(struct veml3328_data *data)
+{
+	return regmap_update_bits(data->regmap, VEML3328_REG_CONF,
+				  VEML3328_SHUTDOWN, VEML3328_SHUTDOWN);
+}
+
+static int veml3328_power_up(struct veml3328_data *data)
+{
+	int ret;
+
+	ret = regmap_update_bits(data->regmap, VEML3328_REG_CONF,
+				 VEML3328_SHUTDOWN, 0);
+	if (ret < 0)
+		return ret;
+
+	fsleep(veml3328_it_times[3][1]);
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
+	unsigned int reg_val;
+	int ret;
+	int reg;
+
+	guard(mutex)(&data->lock);
+
+	ret = pm_runtime_resume_and_get(data->dev);
+	if (ret < 0)
+		return ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = regmap_read(regmap, chan->address, &reg_val);
+		if (ret < 0)
+			goto exit;
+
+		*val = reg_val;
+		ret = IIO_VAL_INT;
+		break;
+
+	case IIO_CHAN_INFO_INT_TIME:
+		ret = regmap_read(regmap, VEML3328_REG_CONF, &reg_val);
+		if (ret < 0)
+			goto exit;
+
+		reg = FIELD_GET(VEML3328_IT_MASK, reg_val);
+		if (reg >= ARRAY_SIZE(veml3328_it_times)) {
+			ret = -EINVAL;
+			goto exit;
+		}
+
+		*val = veml3328_it_times[reg][0];
+		*val2 = veml3328_it_times[reg][1];
+		ret = IIO_VAL_INT_PLUS_MICRO;
+		break;
+
+	case IIO_CHAN_INFO_SCALE:
+		ret = regmap_read(regmap, VEML3328_REG_CONF, &reg_val);
+		if (ret < 0)
+			goto exit;
+
+		reg = FIELD_GET(VEML3328_GAIN_MASK, reg_val);
+		if (reg >= ARRAY_SIZE(veml3328_scale_vals)) {
+			ret = -EINVAL;
+			goto exit;
+		}
+
+		*val = veml3328_scale_vals[reg][0];
+		*val2 = veml3328_scale_vals[reg][1];
+		ret = IIO_VAL_INT_PLUS_MICRO;
+		break;
+
+	default:
+		ret = -EINVAL;
+	}
+
+exit:
+	pm_runtime_put_autosuspend(data->dev);
+
+	return ret;
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
+	int ret;
+	int i;
+
+	guard(mutex)(&data->lock);
+
+	ret = pm_runtime_resume_and_get(data->dev);
+	if (ret < 0)
+		return ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_INT_TIME:
+		if (val != 0) {
+			ret = -EINVAL;
+			goto exit;
+		}
+
+		for (i = 0; i < ARRAY_SIZE(veml3328_it_times); i++) {
+			if (veml3328_it_times[i][1] == val2)
+				break;
+		}
+
+		if (i == ARRAY_SIZE(veml3328_it_times)) {
+			ret = -EINVAL;
+			goto exit;
+		}
+
+		ret = regmap_update_bits(regmap, VEML3328_REG_CONF,
+					 VEML3328_IT_MASK,
+					 FIELD_PREP(VEML3328_IT_MASK, i));
+		break;
+
+	case IIO_CHAN_INFO_SCALE:
+		for (i = 0; i < ARRAY_SIZE(veml3328_scale_vals); i++) {
+			if (val == veml3328_scale_vals[i][0] &&
+			    val2 == veml3328_scale_vals[i][1])
+				break;
+		}
+
+		if (i == ARRAY_SIZE(veml3328_scale_vals)) {
+			ret = -EINVAL;
+			goto exit;
+		}
+
+		ret = regmap_update_bits(regmap, VEML3328_REG_CONF,
+					 VEML3328_GAIN_MASK,
+					 FIELD_PREP(VEML3328_GAIN_MASK, i));
+
+		break;
+
+	default:
+		ret = -EINVAL;
+	}
+
+exit:
+	pm_runtime_put_autosuspend(data->dev);
+
+	return ret;
+}
+
+static int veml3328_write_raw_get_fmt(struct iio_dev *indio_dev,
+				      struct iio_chan_spec const *chan,
+				      long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+	case IIO_CHAN_INFO_INT_TIME:
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info veml3328_info = {
+	.read_raw = veml3328_read_raw,
+	.write_raw = veml3328_write_raw,
+	.read_avail = veml3328_read_avail,
+	.write_raw_get_fmt = veml3328_write_raw_get_fmt,
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
+	data->dev = dev;
+
+	data->regmap = devm_regmap_init_i2c(client, &veml3328_regmap_config);
+	if (IS_ERR(data->regmap))
+		return dev_err_probe(dev, PTR_ERR(data->regmap),
+				     "Failed to initialize regmap\n");
+
+	ret = devm_mutex_init(dev, &data->lock);
+	if (ret)
+		return ret;
+
+	ret = devm_regulator_get_enable(dev, "vdd");
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable regulator\n");
+
+	ret = regmap_read(data->regmap, VEML3328_REG_ID, &reg_val);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to read ID register\n");
+
+	if ((reg_val & 0xff) != VEML3328_ID_VAL)
+		return dev_err_probe(dev, -ENODEV, "Invalid device ID\n");
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
+	if (ret < 0)
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
+	if (ret < 0)
+		dev_err(dev, "Failed to resume: %d\n", ret);
+
+	return ret;
+}
+
+static DEFINE_RUNTIME_DEV_PM_OPS(veml3328_pm_ops, veml3328_runtime_suspend,
+				 veml3328_runtime_resume, NULL);
+
+static const struct of_device_id veml3328_of_match[] = {
+	{ .compatible = "vishay,veml3328" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, veml3328_of_match);
+
+static const struct i2c_device_id veml3328_id[] = {
+	{ "veml3328" },
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
+MODULE_DESCRIPTION("VEML3328 RGB Light Sensor");
+MODULE_LICENSE("GPL");

-- 
2.34.1

