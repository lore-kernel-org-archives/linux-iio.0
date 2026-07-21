Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A6446D096
	for <linux-iio@vger.kernel.org>; Tue, 21 Jul 2026 18:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784658286; cv=none; b=jP+ORcyegzed5Rn3vEDhXqpi4oIbNoEQ0wEYwFUtv0wq2omMm93aZDXsj0gURTArpXmnrI/DfCZGhgqQit2btZEOJnYEl68mbMbdfDvfFzGLpzw7Hjx6a1EAsMytGTal53lF1dBUJyDUVK1Kd35eXe5W1o91M+8Qv6jPTtUuchw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784658286; c=relaxed/simple;
	bh=DAsAkRrlrjB+LjOM1hc9zi+WIM7VFhwalTrcnp+qYgQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gdr5eHrw3wAE8ZD37NFoOOoXKJmmqLuyUvcorqCk0wCqHstUmUrVrMdm0SKPkmOWtI2Bshr3fAYxdJwLvdw5DN1lYMGqU2CdbUKdEIv9/cDbF/XKdqJG0YCLVg9zjxPCQWYB1edRsczTjVUx3bk5W4BdLrRmtdFm6yFw30231tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHWxDExS; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHWxDExS"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4954df200ddso26640605e9.0
        for <linux-iio@vger.kernel.org>; Tue, 21 Jul 2026 11:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784658283; x=1785263083; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6h1vgoNij8ASaqzGn9OonNwFVqwllRJ2VF0KwZtNt30=;
        b=WHWxDExSzm73kAY5nc8HSrCMVg8ZOab8YdgnlfASl4yYX6NDo97qFyrWyfFAemJGTr
         smddeM+tBspYHYaJI6gmjG1qxDqJH5SQgMIaIylT11573Oi7Cz+QDX1hmmiMj0aKadCA
         rF7jWI4BG7YJFsrZcst6bA4b/BWEQ/kk7FOzEsKvXSzH/5AsRCvwmSL8AEJ9YXzItjvp
         s9nU357KeR1UVqJ4cMBT4610ISQ7a6dnmnnOycx6k/IzogxNNZMYYk9oECNdixSVNhgm
         SczcfuOTlQ/OUUiNkQ1dBNIGhiW4VTjgV5UxIpJMtJTs6iNkMSxQCba44DrPQ3WUYsLX
         rz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784658283; x=1785263083;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6h1vgoNij8ASaqzGn9OonNwFVqwllRJ2VF0KwZtNt30=;
        b=TbiW4/P6QnHK3b+SOZ6jaUZoX6h3bWPAap0CSFOpB804jT+w+5QCkBhIfpYrsjpBMK
         TCdj6kn5gROT2yAvgCmJvLUL/ERehVnvOGqzqjxJl6RguUm0G4TBAeV9N6ZjTFhqgSU4
         Fq6Wd8oZpwrNzoXfO1mIB+FFMAhEhviBLAO4iDO2leflvs6quwjEDiQqEoPHKD2ShkPG
         aAMT1Aced0OqP+0pKInYnO92PYC55qHIuJzTGUsxxpKUlCt271N4DsoNcYs83vd9H0GP
         0+heDftPVAOx2ebz5zccW/zTTIMzjKPiXZOSlJq/lWQTXzCAMZ70ys1bfBa//JkSwurS
         LNKQ==
X-Gm-Message-State: AOJu0Yx/3SVfLXweKhQpDpatvU1jLluSGhIu8SXr7g9RyGTGxlpp8rWQ
	Ckk/lX9Do6PlUVNewy2zYW23fzR6nzdtsgSeOlc7HVTFEaOuKcJ9hQvsx+AHWA==
X-Gm-Gg: AfdE7ckoENmZDGC5Bcd2ET7cDO55OUuGo3r2V8ZYe1anJSu5gJ1HiqLUlcIwUqS/z0h
	ldG3y8NZJxuFPX8Ogb+Yn5uAl4ILO10AoP6SHnPd77JOEVUh1DP6s5t37AqxV3RH5rthflddL+9
	HtWk0GehDr5NpWvPsxLnL4SlwtOdAO4+nz0QUAk56vsd3fCqT2QjGM/5ElTcDy5M6Z/DPtuwlZd
	qhqFarOHuDv9rV4myXa0VoON3/lAW1zqdOgjPRB5yUDmzz/W6amgggk1UAkAUD7VzQWVcFjqapV
	DE0UbUaccf+3wW1BFsYrz447E6puqKe+AO/4qWMfIAgmnhvCIyBHc9R10s8SCxrqaen6IxTt/fh
	vLpdXfwKTYYxCbYp7G/5OgTkLiw6OWp1OgLPFmhX+C7gQuNEYaWUUIXaiIynr6RQcSkhrnBxxcE
	utbUhCuuvVjCcDpPHVCFVhhEMLHHmjMJ5j0gb2ho2p1MRQlBNY3IUwAZhVEcr2pKIlfoB9acgI5
	jBwP9iBzER3qvr7btehCsp3fjNsZxW4cct5eFZivumcUqn+SvZKQCU/23Zjhe03SJ5PerD4JWWI
	OsWeY6oCp8EI6gaAc2Pf4ogU9qptjRyejkVleFj55S3JbhuV096cyPa+wrNuOxEtStovRgKqUfY
	T8vGtVbk4uonRoZA=
X-Received: by 2002:a05:600c:1d1e:b0:493:b6ee:fcb7 with SMTP id 5b1f17b1804b1-4954a3f39ffmr209579125e9.14.1784658282775;
        Tue, 21 Jul 2026 11:24:42 -0700 (PDT)
Received: from [192.168.1.187] (ip-86-49-244-181.bb.vodafone.cz. [86.49.244.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63eddd1csm40835081f8f.29.2026.07.21.11.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 11:24:42 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Tue, 21 Jul 2026 20:24:39 +0200
Subject: [PATCH 2/2] iio: dac: mcp47a1: add support for new device
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-mcp47a1-add-support-v1-2-da045a2567e3@gmail.com>
References: <20260721-mcp47a1-add-support-v1-0-da045a2567e3@gmail.com>
In-Reply-To: <20260721-mcp47a1-add-support-v1-0-da045a2567e3@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784658280; l=7331;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=DAsAkRrlrjB+LjOM1hc9zi+WIM7VFhwalTrcnp+qYgQ=;
 b=rg7LCJjs3WYqnvTRZbGWbpuzWuXCuFPMBOxlvzHl70WuOt/TBUviI8b29HN6djik++z2nz7uI
 RdhAYvFRiK+AJG9gzJsxEGgK3JvrikUPoluKsnTDMr3+0vSSsKPuHWY
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

The Microchip MCP47A1 is a 6-bit volatile Digital-to-Analog converted
which communicates via I2C.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 MAINTAINERS               |   1 +
 drivers/iio/dac/Kconfig   |  11 +++
 drivers/iio/dac/Makefile  |   1 +
 drivers/iio/dac/mcp47a1.c | 193 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 206 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b44693593b94..9b124bbdd6ff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17704,6 +17704,7 @@ M:	Joshua Crofts <joshua.crofts1@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/dac/microchip,mcp47a1.yaml
+F:	drivers/iio/dac/mcp47a1.c
 
 MICROCHIP MCP9982 TEMPERATURE DRIVER
 M:	Victor Duicu <victor.duicu@microchip.com>
diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 17529509da9d..a7f5711e9c3b 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -563,6 +563,17 @@ config MCP4728
 	  To compile this driver as a module, choose M here: the module
 	  will be called mcp4728.
 
+config MCP47A1
+	tristate "MCP47A1 DAC driver"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Say Y here if you want to build a driver for the Microchip
+	  MCP47A1 digital-to-analog converter with an I2C interface.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called mcp47a1.
+
 config MCP47FEB02
 	tristate "MCP47F(E/V)B01/02/04/08/11/12/14/18/21/22/24/28 DAC driver"
 	depends on I2C
diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index 5d20d37e44ce..992f8930f95c 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -55,6 +55,7 @@ obj-$(CONFIG_MAX5821) += max5821.o
 obj-$(CONFIG_MCF54415_DAC) += mcf54415_dac.o
 obj-$(CONFIG_MCP4725) += mcp4725.o
 obj-$(CONFIG_MCP4728) += mcp4728.o
+obj-$(CONFIG_MCP47A1) += mcp47a1.o
 obj-$(CONFIG_MCP47FEB02) += mcp47feb02.o
 obj-$(CONFIG_MCP4821) += mcp4821.o
 obj-$(CONFIG_MCP4922) += mcp4922.o
diff --git a/drivers/iio/dac/mcp47a1.c b/drivers/iio/dac/mcp47a1.c
new file mode 100644
index 000000000000..251c2281634f
--- /dev/null
+++ b/drivers/iio/dac/mcp47a1.c
@@ -0,0 +1,193 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Microchip MCP47A1 DAC driver
+ *
+ * Copyright (c) 2026 Joshua Crofts <joshua.crofts1@gmail.com>
+ *
+ * Datasheet: https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/25154A.pdf
+ */
+
+#include <linux/array_size.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/types.h>
+#include <linux/units.h>
+
+#include <linux/iio/iio.h>
+
+#define MCP47A1_REG_MAX		0x40
+#define MCP47A1_CMD_CODE	0x00
+#define MCP47A1_MAX_STEPS	64
+
+struct mcp47a1_data {
+	struct regmap *regmap;
+	int vref_mv;
+};
+
+static const int mcp47a1_raw_avail[] = { 0, 1, MCP47A1_MAX_STEPS };
+
+static const struct regmap_config mcp47a1_regmap_config = {
+	.name = "mcp47a1",
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = MCP47A1_CMD_CODE,
+};
+
+static const struct iio_chan_spec mcp47a1_channels[] = {
+	{
+		.type = IIO_VOLTAGE,
+		.indexed = 1,
+		.output = 1,
+		.channel = 0,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
+	},
+};
+
+static int mcp47a1_write(struct iio_dev *indio_dev,
+			 struct iio_chan_spec const *chan,
+			 int val, int val2, long mask)
+{
+	struct mcp47a1_data *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (val < 0 || val > MCP47A1_REG_MAX)
+			return -EINVAL;
+
+		return regmap_write(data->regmap, MCP47A1_CMD_CODE, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int mcp47a1_read(struct iio_dev *indio_dev,
+			struct iio_chan_spec const *chan,
+			int *val, int *val2, long mask)
+{
+	struct mcp47a1_data *data = iio_priv(indio_dev);
+	int reg_val;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = regmap_read(data->regmap, MCP47A1_CMD_CODE, &reg_val);
+		if (ret)
+			return ret;
+
+		*val = reg_val;
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = data->vref_mv;
+		*val2 = MCP47A1_MAX_STEPS;
+
+		return IIO_VAL_FRACTIONAL;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int mcp47a1_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      const int **vals, int *type, int *length,
+			      long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		*vals = mcp47a1_raw_avail;
+		*type = IIO_VAL_INT;
+		return IIO_AVAIL_RANGE;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info mcp47a1_info = {
+	.write_raw = mcp47a1_write,
+	.read_raw = mcp47a1_read,
+	.read_avail = mcp47a1_read_avail,
+};
+
+static int mcp47a1_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct mcp47a1_data *data;
+	struct iio_dev *indio_dev;
+	int reg_val;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+
+	data->regmap = devm_regmap_init_i2c(client, &mcp47a1_regmap_config);
+	if (IS_ERR(data->regmap))
+		return dev_err_probe(dev, PTR_ERR(data->regmap),
+				     "Failed to initialize regmap\n");
+
+	ret = devm_regulator_get_enable(dev, "vdd");
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable regulator\n");
+
+	ret = devm_regulator_get_enable_read_voltage(dev, "vref");
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to read vref\n");
+
+	data->vref_mv = ret / MILLI;
+
+	/*
+	 * This is a volatile DAC which doesn't have an ID register, instead
+	 * the value register is set to 0x20 every Power-on-Reset (table 4-1).
+	 * Any other read value at startup could indicate that the device is
+	 * damaged etc.
+	 */
+	ret = regmap_read(data->regmap, MCP47A1_CMD_CODE, &reg_val);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to read register on startup\n");
+
+	if (reg_val != 0x20)
+		dev_info(dev, "Read value 0x%02x at startup\n", reg_val);
+
+	indio_dev->name = "mcp47a1";
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &mcp47a1_info;
+	indio_dev->channels = mcp47a1_channels;
+	indio_dev->num_channels = ARRAY_SIZE(mcp47a1_channels);
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct of_device_id mcp47a1_of_match[] = {
+	{ .compatible = "microchip,mcp47a1" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, mcp47a1_of_match);
+
+static const struct i2c_device_id mcp47a1_id[] = {
+	{ .name = "mcp47a1" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, mcp47a1_id);
+
+static struct i2c_driver mcp47a1_driver = {
+	.driver = {
+		.name = "mcp47a1",
+		.of_match_table = mcp47a1_of_match,
+	},
+	.probe = mcp47a1_probe,
+	.id_table = mcp47a1_id,
+};
+module_i2c_driver(mcp47a1_driver);
+
+MODULE_AUTHOR("Joshua Crofts <joshua.crofts1@gmail.com>");
+MODULE_DESCRIPTION("MCP47A1 DAC");
+MODULE_LICENSE("GPL");

-- 
2.55.0

