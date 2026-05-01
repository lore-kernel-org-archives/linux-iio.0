Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE5E374726
	for <linux-iio@vger.kernel.org>; Fri,  1 May 2026 22:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777673666; cv=none; b=jAybJhjB3hjvc30stbNsdCLiu9baYLbQ/+h4in33sq8gwv72KDTOL5pu2BSBz2KG3rp8BtXIN/24A1RyX0yNgVNPTZfg+pn8qS834B0QFj9wRwan87NjoJkKez4zf5GH9haQcHieFkL2iLtceADuKEQxzmk6vycJlvUWB2pAHQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777673666; c=relaxed/simple;
	bh=/xJONvBK5bLfdWZhJaP5om0wyJBgQot9dCOBrdx09h0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ESxe7k46WucF94Zu+3Wl413GT3eHbpKHRhDfZcKRVA4Bqk9DC0ZcILcGig1aRy2pGVMK27v7z8Bz05YZsPFTC5tVFGNzhMfwH6YYmhali2XuJNvFIvcIugC3VVL07VnOzN6U76vCmtdr/Bm/I1n5/coJzN77MvSOru+tBo2Sz5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZyD9Nm0E; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZyD9Nm0E"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d55b97f358so1671974a34.3
        for <linux-iio@vger.kernel.org>; Fri, 01 May 2026 15:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777673664; x=1778278464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUhEsFTxIv9vvjhFaz+CpThVyN6UFPYPzRieSjPZV28=;
        b=ZyD9Nm0EJrWGzRtvb7DX5ALUP9ypaPgJj2NfmDQ8KL/l0zh864JNoEewwZ8yU0lTEd
         lHqEBlSjh+Xp7MzQCD5ejUBQ4i1KDCfwUuuyJTJ6ajEt0HdYJeDOU4pt0pZugCa+KnGN
         3QxgCmH8hM78GpJ3LMCVMbqNSVp/+jMFqyAcvquJdY1Oeo2hzGnf9R+Y9W0JmIAxIGty
         xSlPboNIk0YzRKDcBm9KyJ27RuiRL+dMN0jrR8a6fiime+Rdlh0jeEJ+ZbisKElT6Wcd
         oVmp7kUTsXzYnAQT64VjYul4YLOShHsANt5D4td9o2M7HJwFCIoCoVyS2rP3ROlUaYck
         0xvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777673664; x=1778278464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CUhEsFTxIv9vvjhFaz+CpThVyN6UFPYPzRieSjPZV28=;
        b=QA2SNBBVcDydBeFujBtIcOZgwsSgfpNEHrMG5GYL3vJ4WIt8i+1rB6myolksXEspoK
         uFRvJdnXQYjGSjYtG4SxreX5zOXv4xlZTyS4/2oAYvkY2Fc/LjvdXu2iGdbPeoJHiJuU
         fbnEYr6XJAA6npxCQicI+y6DELSziKGVsNmrHJD7fjTrUErEW+qjm/dzgJT8cQozPMHx
         BhvjjIXqVLTpPECuHFyWf3f388dr6os+tguwfhLLl0XLgg53hrohnoayL4yKjLkSUn8Y
         sUN+f0qDnJaXFAVjEwwEgJJLCQNRLy6mEVgKnmPNz/DwuM7NmYz8b2RANJeYj2uoceos
         6/Cg==
X-Gm-Message-State: AOJu0YwWIc8pYiR6tWhyt4L+FrjxmeNGcA0IMcoqeDL+mTENaXUEC+pJ
	7/uqYNG6ZeHEuMHb76jdInYrN5KbWsqLKSevGHkpix41KW2Gk9BhyDfd8f6Ktw==
X-Gm-Gg: AeBDieuUJ2IMLnW5QZX/8dT+MXAQ4nQPAzqcAu3u2gcTae71cdu3nGpTNb45GhIJaDs
	knkHVJhsuH3v2mdK/A8fL7hsOlEIcMPVlwZGvejXYhtpHyWnhKnAja+k/FwUh2YB7W+Wikv9akg
	xCsjKY644pJkZfBsotl6Jft85gyGwc2rzkApYsgA+lDtLPUmYivsoTVQoNUtxJhZfVD1sdAC2Gt
	rAqJUKSrEatoAO2bK/E9fWZ8TwUKtpNHMy26w+Jmh7z3CoMn5q69LkA2KdqNW/kexo6LuT+lDlE
	ONU11fts163a8qBfYLarRA9tPZgjP7ybd6oYjQHjmhvT3NIMLRGIRNPkHlKTmuv3MLFIAhOI6Bk
	R5w0qJi7Md3K+C/u8/J+Sp2MXLaJA/v0yBfHT/6qSjxWpbYOGmOn5oTDfGk6P5grIDyd/FDFoVm
	OAxSV+fg8pfCbN2mGj6tf3vY/hXmNFA0E=
X-Received: by 2002:a05:6830:270a:b0:7d7:e59c:80e6 with SMTP id 46e09a7af769-7dee127f28dmr996319a34.12.1777673663700;
        Fri, 01 May 2026 15:14:23 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ded51a9612sm1827337a34.26.2026.05.01.15.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 15:14:23 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-iio@vger.kernel.org
Cc: andy@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com,
	jic23@kernel.org,
	jean-baptiste.maneyrol@tdk.com,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	andriy.shevchenko@intel.com,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V4 03/10] iio: imu: inv_icm42607: Add I2C and SPI For icm42607
Date: Fri,  1 May 2026 17:11:42 -0500
Message-ID: <20260501221152.194251-4-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260501221152.194251-1-macroalpha82@gmail.com>
References: <20260501221152.194251-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add I2C and SPI driver support for InvenSense ICM-42607 devices.
Add necessary Kconfig and Makefile to allow building of (incomplete)
driver.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/iio/imu/Kconfig                       |  1 +
 drivers/iio/imu/Makefile                      |  1 +
 drivers/iio/imu/inv_icm42607/Kconfig          | 30 ++++++
 drivers/iio/imu/inv_icm42607/Makefile         | 10 ++
 drivers/iio/imu/inv_icm42607/inv_icm42607.h   |  2 +
 .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 20 ++++
 .../iio/imu/inv_icm42607/inv_icm42607_i2c.c   | 90 +++++++++++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_spi.c   | 96 +++++++++++++++++++
 8 files changed, 250 insertions(+)
 create mode 100644 drivers/iio/imu/inv_icm42607/Kconfig
 create mode 100644 drivers/iio/imu/inv_icm42607/Makefile
 create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
 create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c

diff --git a/drivers/iio/imu/Kconfig b/drivers/iio/imu/Kconfig
index 7e0181c27bb6..8bab4616be20 100644
--- a/drivers/iio/imu/Kconfig
+++ b/drivers/iio/imu/Kconfig
@@ -109,6 +109,7 @@ config KMX61
 	  be called kmx61.
 
 source "drivers/iio/imu/inv_icm42600/Kconfig"
+source "drivers/iio/imu/inv_icm42607/Kconfig"
 source "drivers/iio/imu/inv_icm45600/Kconfig"
 source "drivers/iio/imu/inv_mpu6050/Kconfig"
 
diff --git a/drivers/iio/imu/Makefile b/drivers/iio/imu/Makefile
index 13fb7846e9c9..3268dc2371ae 100644
--- a/drivers/iio/imu/Makefile
+++ b/drivers/iio/imu/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_FXOS8700_I2C) += fxos8700_i2c.o
 obj-$(CONFIG_FXOS8700_SPI) += fxos8700_spi.o
 
 obj-y += inv_icm42600/
+obj-y += inv_icm42607/
 obj-y += inv_icm45600/
 obj-y += inv_mpu6050/
 
diff --git a/drivers/iio/imu/inv_icm42607/Kconfig b/drivers/iio/imu/inv_icm42607/Kconfig
new file mode 100644
index 000000000000..7ba64e6e8d80
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42607/Kconfig
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+config INV_ICM42607
+	tristate
+	select IIO_BUFFER
+	select IIO_INV_SENSORS_TIMESTAMP
+
+config INV_ICM42607_I2C
+	tristate "InvenSense ICM-42607X I2C driver"
+	depends on I2C
+	select INV_ICM42607
+	select REGMAP_I2C
+	help
+	  This driver supports the InvenSense ICM-42607 motion tracking
+	  device over I2C.
+
+	  This driver can be built as a module. The module will be called
+	  inv-icm42607-i2c.
+
+config INV_ICM42607_SPI
+	tristate "InvenSense ICM-42607X SPI driver"
+	depends on SPI_MASTER
+	select INV_ICM42607
+	select REGMAP_SPI
+	help
+	  This driver supports the InvenSense ICM-42607 motion tracking
+	  device over SPI.
+
+	  This driver can be built as a module. The module will be called
+	  inv-icm42607-spi.
diff --git a/drivers/iio/imu/inv_icm42607/Makefile b/drivers/iio/imu/inv_icm42607/Makefile
new file mode 100644
index 000000000000..be109102e203
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42607/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+obj-$(CONFIG_INV_ICM42607) += inv-icm42607.o
+inv-icm42607-y += inv_icm42607_core.o
+
+obj-$(CONFIG_INV_ICM42607_I2C) += inv-icm42607-i2c.o
+inv-icm42607-i2c-y += inv_icm42607_i2c.o
+
+obj-$(CONFIG_INV_ICM42607_SPI) += inv-icm42607-spi.o
+inv-icm42607-spi-y += inv_icm42607_spi.o
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
index f6b3cad8064a..763d731ccc60 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
@@ -389,6 +389,8 @@ struct inv_icm42607_sensor_state {
 
 typedef int (*inv_icm42607_bus_setup)(struct inv_icm42607_state *);
 
+extern const struct regmap_config inv_icm42607_regmap_config;
+
 u32 inv_icm42607_odr_to_period(enum inv_icm42607_odr odr);
 
 int inv_icm42607_debugfs_reg(struct iio_dev *indio_dev, unsigned int reg,
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
index a0bbd8a7ea4b..1ac3a573863c 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
@@ -16,6 +16,26 @@
 
 #include "inv_icm42607.h"
 
+static const struct regmap_range_cfg inv_icm42607_regmap_ranges[] = {
+	{
+		.name = "user bank",
+		.range_min = 0x0000,
+		.range_max = 0x00FF,
+		.window_start = 0,
+		.window_len = 0x0100,
+	},
+};
+
+const struct regmap_config inv_icm42607_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0x00FF,
+	.ranges = inv_icm42607_regmap_ranges,
+	.num_ranges = ARRAY_SIZE(inv_icm42607_regmap_ranges),
+	.cache_type = REGCACHE_NONE,
+};
+EXPORT_SYMBOL_NS_GPL(inv_icm42607_regmap_config, "IIO_ICM42607");
+
 struct inv_icm42607_hw {
 	uint8_t whoami;
 	const char *name;
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
new file mode 100644
index 000000000000..83cdb9c87167
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 InvenSense, Inc.
+ */
+
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+#include <linux/property.h>
+
+#include "inv_icm42607.h"
+
+static int inv_icm42607_i2c_bus_setup(struct inv_icm42607_state *st)
+{
+	unsigned int val;
+	int ret;
+
+	ret = regmap_clear_bits(st->map, INV_ICM42607_REG_INTF_CONFIG1,
+				INV_ICM42607_INTF_CONFIG1_I3C_DDR_EN |
+				INV_ICM42607_INTF_CONFIG1_I3C_SDR_EN);
+	if (ret)
+		return ret;
+
+	val = FIELD_PREP(INV_ICM42607_DRIVE_CONFIG2_I2C_MASK,
+			 INV_ICM42607_SLEW_RATE_12_36NS);
+	ret = regmap_update_bits(st->map, INV_ICM42607_REG_DRIVE_CONFIG2,
+				 INV_ICM42607_DRIVE_CONFIG2_I2C_MASK, val);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(st->map, INV_ICM42607_REG_INTF_CONFIG0,
+				  INV_ICM42607_INTF_CONFIG0_UI_SIFS_CFG_MASK,
+				  INV_ICM42607_INTF_CONFIG0_UI_SIFS_CFG_SPI_DIS);
+}
+
+static int inv_icm42607_probe(struct i2c_client *client)
+{
+	const void *match;
+	enum inv_icm42607_chip chip;
+	struct regmap *regmap;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_I2C_BLOCK))
+		return -EOPNOTSUPP;
+
+	match = i2c_get_match_data(client);
+	chip = (kernel_ulong_t)match;
+
+	regmap = devm_regmap_init_i2c(client, &inv_icm42607_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	return inv_icm42607_core_probe(regmap, chip, inv_icm42607_i2c_bus_setup);
+}
+
+static const struct i2c_device_id inv_icm42607_id[] = {
+	{ "icm42607", INV_CHIP_ICM42607 },
+	{ "icm42607p", INV_CHIP_ICM42607P },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, inv_icm42607_id);
+
+static const struct of_device_id inv_icm42607_of_matches[] = {
+	{
+		.compatible = "invensense,icm42607",
+		.data = (void *)INV_CHIP_ICM42607,
+	}, {
+		.compatible = "invensense,icm42607p",
+		.data = (void *)INV_CHIP_ICM42607P,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, inv_icm42607_of_matches);
+
+static struct i2c_driver inv_icm42607_driver = {
+	.driver = {
+		.name = "inv-icm42607-i2c",
+		.of_match_table = inv_icm42607_of_matches,
+	},
+	.id_table = inv_icm42607_id,
+	.probe = inv_icm42607_probe,
+};
+module_i2c_driver(inv_icm42607_driver);
+
+MODULE_AUTHOR("InvenSense, Inc.");
+MODULE_DESCRIPTION("InvenSense ICM-42607x I2C driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_ICM42607");
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c
new file mode 100644
index 000000000000..7a02bbab3a63
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 InvenSense, Inc.
+ */
+
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/spi/spi.h>
+#include <linux/regmap.h>
+#include <linux/property.h>
+
+#include "inv_icm42607.h"
+
+static int inv_icm42607_spi_bus_setup(struct inv_icm42607_state *st)
+{
+	unsigned int val;
+	int ret;
+
+	ret = regmap_set_bits(st->map, INV_ICM42607_REG_DEVICE_CONFIG,
+			      INV_ICM42607_DEVICE_CONFIG_SPI_AP_4WIRE);
+	if (ret)
+		return ret;
+
+	ret = regmap_clear_bits(st->map, INV_ICM42607_REG_INTF_CONFIG1,
+				INV_ICM42607_INTF_CONFIG1_I3C_DDR_EN |
+				INV_ICM42607_INTF_CONFIG1_I3C_SDR_EN);
+	if (ret)
+		return ret;
+
+	val = FIELD_PREP(INV_ICM42607_DRIVE_CONFIG3_SPI_MASK,
+			 INV_ICM42607_SLEW_RATE_INF_2NS);
+	ret = regmap_update_bits(st->map, INV_ICM42607_REG_DRIVE_CONFIG3,
+				 INV_ICM42607_DRIVE_CONFIG3_SPI_MASK, val);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(st->map, INV_ICM42607_REG_INTF_CONFIG0,
+				  INV_ICM42607_INTF_CONFIG0_UI_SIFS_CFG_MASK,
+				  INV_ICM42607_INTF_CONFIG0_UI_SIFS_CFG_I2C_DIS);
+}
+
+static int inv_icm42607_probe(struct spi_device *spi)
+{
+	const void *match;
+	enum inv_icm42607_chip chip;
+	struct regmap *regmap;
+
+	match = spi_get_device_match_data(spi);
+	chip = (kernel_ulong_t)match;
+
+	regmap = devm_regmap_init_spi(spi, &inv_icm42607_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(&spi->dev, PTR_ERR(regmap),
+				     "Failed to register spi regmap %ld\n",
+				     PTR_ERR(regmap));
+
+	return inv_icm42607_core_probe(regmap, chip,
+				       inv_icm42607_spi_bus_setup);
+}
+
+static const struct of_device_id inv_icm42607_of_matches[] = {
+	{
+		.compatible = "invensense,icm42607",
+		.data = (void *)INV_CHIP_ICM42607,
+	},
+	{
+		.compatible = "invensense,icm42607p",
+		.data = (void *)INV_CHIP_ICM42607P,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, inv_icm42607_of_matches);
+
+static const struct spi_device_id inv_icm42607_spi_id_table[] = {
+	{ "icm42607", INV_CHIP_ICM42607 },
+	{ "icm42607p", INV_CHIP_ICM42607P },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, inv_icm42607_spi_id_table);
+
+static struct spi_driver inv_icm42607_driver = {
+	.driver = {
+		.name = "inv-icm42607-spi",
+		.of_match_table = inv_icm42607_of_matches,
+	},
+	.id_table = inv_icm42607_spi_id_table,
+	.probe = inv_icm42607_probe,
+};
+module_spi_driver(inv_icm42607_driver);
+
+MODULE_AUTHOR("InvenSense, Inc.");
+MODULE_DESCRIPTION("InvenSense ICM-42607x SPI driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_ICM42607");
-- 
2.43.0

