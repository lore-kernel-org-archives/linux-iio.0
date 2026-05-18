Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A83A392814
	for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 20:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779134877; cv=none; b=aOZOIaXJAl+50WYNHjJaY68Mkd+uoFOUcZPMr5Lns74xExAseWaWAC9uiCjkcsC/Np6JFUK39S+B+pIyAeqrlmhwFtz60HU0AKbLLS7gW7G0o8PlJWkOAJwuqxZrpG41wSMkIC7BR8tbA7LI0clYvwl+RzsSCrBLrBbVubtkNb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779134877; c=relaxed/simple;
	bh=JfTxzwUZb3Vs88xbgcWUzlvQjPAARQIEFpIBBiB6/fM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YYFfatYQqdRBthKryoFvZzIK/Fg/omhVyv90US/aqrP843nBWYiFl4G7A6Arx1HCUZMo5gUmZDZ8WKqyS9B2ogFqeAvvbTwGHH8a1PTv7z4Eu/5776+rEyKAS806sj8LypybnZIorojZ8wV6kyNRzfoDHs6sGLpjVoesL+bQIjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fC6v2tYw; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fC6v2tYw"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-43a833aeda0so1645513fac.2
        for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 13:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779134874; x=1779739674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kH4gFpS7/IpK5FyN0sA+FWbLnkslNPg1NtQ7x3ZP+ss=;
        b=fC6v2tYw+QVE7Slbw1IJ4xgPyu8XcsXbquGAUADcOVK0/o/yDjX6iIhfUxUYjYtQ5n
         jU0kPGqolFBNb7dfcBKLTtPkXpURrLSS99RTRJ6USJ9OEFu6cjmRkwpsGUyn2gmv6dSA
         4f404jyj34fvmqdkIyI/v77H0557EPNC3qkkLkYTog45a6aGuPyCukqswHMlQY2/7fi1
         RoznLtnJQ+j6lg2Q4IZkSx37A6wszcT446AWU+hBqxXi5GJlU5UkaHvsBxkcR3/FIlYY
         RqC8y4ET3O0P128gXWcYxfyeyCJpYBpD0/uHWobIVJ/U3NlR5XIUf11EOvLo6nUfgsnx
         Nh3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779134874; x=1779739674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kH4gFpS7/IpK5FyN0sA+FWbLnkslNPg1NtQ7x3ZP+ss=;
        b=k1g47yEGA5Nrwug9tONMY8gJiiy+VZyBk5c1+Lk2AaXpn9Ox90on7BJw5p5cZqdwfk
         FVaVQzjMFqaSnOLd3BSpsLDlY/GrAj88jNoKyhOsk65BhOIeoiDf0Cs4El2ZtnKl+2ob
         uEvncXw3m8fy6l7bsDPKL7gaKxJilLWseduPdvBqnuOJ+8kQIrVgUG8BNy2tIVwNpAsD
         xjPiiea44ihnkFOy5Hz4NpD9IWTVDyYs1Px2VtHelCGA+AJXP7sG9XGYguFcBxURypxo
         JloxT9E/WJdo/PS7PAMe4DQFHpW7bqgTU8/y5Q93Ztee74eU0cMRQybjm4ssf5sUmKIL
         GOZQ==
X-Gm-Message-State: AOJu0YyEODepH9CLTSb2Wp8+ZZvCryafsiMfA3nccRFYGt+BceiVcbUd
	xitvJvIRk9DUxUSKwwzpO65YHDVFHWvs69uWLR5cebhB9eAZtKYccEsQqpdCFS0+
X-Gm-Gg: Acq92OGCe3klSu1/YETEJZ2ikla+MLVUL6dRdCHHYwb77yBu9+WSO+cs2fzEFatZjBH
	nokf56VH4OiRwhIxlL3MYLcYqXolWQvk6xgMINPJhCkU4cvM9gTVhqd5p4PuP0Em0OMT5apmB8C
	YFhgu79NY+CRQaIesoErHFLyJjOhR1S6qVMhf42/JddgbLqyVG9r5x6Qo8dIq7hNH9m2LFqODKR
	6xo5H9jwyxuzsK8DqQhFB38ctdABQjj1zJ4B9n8vkRWWftbuCxJ99atOfG0+wnRvtW13+N45MZt
	8uDUXe/B+dSDn+J5ZOuNbg7rWloH44wdvDk24OOqmDSdUaNzBJAdfzibisa/ivdNJ5FK4iOCMiy
	sNN1JTgZZgoBxugefUnZB6SxOu65kTM+mT8Mex+sb/FvSJKyd6iNQxGx5lg5NkjzUKEXfLdO71G
	1dRD2ddS3Veo505jApVsTJTm4zmZPmOPI=
X-Received: by 2002:a4a:ee04:0:b0:694:9861:ec6d with SMTP id 006d021491bc7-69c9437d9eamr10118170eaf.32.1779134873660;
        Mon, 18 May 2026 13:07:53 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69d0462e85esm6113360eaf.6.2026.05.18.13.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 13:07:53 -0700 (PDT)
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
Subject: [PATCH V8 04/10] iio: imu: inv_icm42607: Add I2C and SPI For icm42607
Date: Mon, 18 May 2026 15:05:19 -0500
Message-ID: <20260518200526.458421-5-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518200526.458421-1-macroalpha82@gmail.com>
References: <20260518200526.458421-1-macroalpha82@gmail.com>
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
 drivers/iio/imu/Kconfig                       |   1 +
 drivers/iio/imu/Makefile                      |   1 +
 drivers/iio/imu/inv_icm42607/Kconfig          |  30 ++++++
 drivers/iio/imu/inv_icm42607/Makefile         |  10 ++
 drivers/iio/imu/inv_icm42607/inv_icm42607.h   |  12 +++
 .../iio/imu/inv_icm42607/inv_icm42607_core.c  |  62 +++++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_i2c.c   |  89 +++++++++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_spi.c   | 101 ++++++++++++++++++
 8 files changed, 306 insertions(+)
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
index 6c5e7d9b08b7..74d8d3d7c890 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
@@ -13,6 +13,16 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 
+/* serial bus slew rates */
+enum inv_icm42607_slew_rate {
+	INV_ICM42607_SLEW_RATE_20_60NS,
+	INV_ICM42607_SLEW_RATE_12_36NS,
+	INV_ICM42607_SLEW_RATE_6_18NS,
+	INV_ICM42607_SLEW_RATE_4_12NS,
+	INV_ICM42607_SLEW_RATE_2_6NS,
+	INV_ICM42607_SLEW_RATE_INF_2NS
+};
+
 enum inv_icm42607_sensor_mode {
 	INV_ICM42607_SENSOR_MODE_OFF,
 	INV_ICM42607_SENSOR_MODE_STANDBY,
@@ -325,6 +335,8 @@ struct inv_icm42607_state {
 typedef int (*inv_icm42607_bus_setup)(struct inv_icm42607_state *);
 
 extern const struct regmap_config inv_icm42607_regmap_config;
+extern const struct inv_icm42607_hw inv_icm42607_hw_data;
+extern const struct inv_icm42607_hw inv_icm42607p_hw_data;
 
 int inv_icm42607_core_probe(struct regmap *regmap, const struct inv_icm42607_hw *hw,
 			    inv_icm42607_bus_setup bus_setup);
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
index b270d48335ba..e9c81b52f9ef 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
@@ -15,6 +15,63 @@
 
 #include "inv_icm42607.h"
 
+static bool inv_icm42607_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case INV_ICM42607_REG_MCLK_RDY:
+	case INV_ICM42607_REG_SIGNAL_PATH_RESET:
+	case INV_ICM42607_REG_TEMP_DATA1 ... INV_ICM42607_REG_APEX_DATA5:
+	case INV_ICM42607_REG_APEX_CONFIG0:
+	case INV_ICM42607_REG_FIFO_CONFIG2 ... INV_ICM42607_REG_FIFO_CONFIG3:
+	case INV_ICM42607_REG_FIFO_LOST_PKT0 ... INV_ICM42607_REG_APEX_DATA3:
+	case INV_ICM42607_REG_INT_STATUS_DRDY:
+	case INV_ICM42607_REG_INT_STATUS ... INV_ICM42607_REG_FIFO_DATA:
+		return true;
+	}
+
+	return false;
+}
+
+const struct regmap_config inv_icm42607_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = INV_ICM42607_REG_WHOAMI,
+	.cache_type = REGCACHE_MAPLE,
+	.volatile_reg = inv_icm42607_is_volatile_reg,
+};
+EXPORT_SYMBOL_NS_GPL(inv_icm42607_regmap_config, "IIO_ICM42607");
+
+/* chip initial default configuration */
+static const struct inv_icm42607_conf inv_icm42607_default_conf = {
+	.gyro = {
+		.mode = INV_ICM42607_SENSOR_MODE_OFF,
+		.fs = INV_ICM42607_GYRO_FS_1000DPS,
+		.odr = INV_ICM42607_ODR_100HZ,
+		.filter = INV_ICM42607_FILTER_BW_25HZ,
+	},
+	.accel = {
+		.mode = INV_ICM42607_SENSOR_MODE_OFF,
+		.fs = INV_ICM42607_ACCEL_FS_4G,
+		.odr = INV_ICM42607_ODR_100HZ,
+		.filter = INV_ICM42607_FILTER_BW_25HZ,
+	},
+	.temp_en = false,
+};
+
+const struct inv_icm42607_hw inv_icm42607_hw_data = {
+	.whoami = INV_ICM42607_WHOAMI,
+	.name = "icm42607",
+	.conf = &inv_icm42607_default_conf,
+};
+EXPORT_SYMBOL_NS_GPL(inv_icm42607_hw_data, "IIO_ICM42607");
+
+const struct inv_icm42607_hw inv_icm42607p_hw_data = {
+	.whoami = INV_ICM42607P_WHOAMI,
+	.name = "icm42607p",
+	.conf = &inv_icm42607_default_conf,
+};
+EXPORT_SYMBOL_NS_GPL(inv_icm42607p_hw_data, "IIO_ICM42607");
+
 static int inv_icm42607_set_conf(struct inv_icm42607_state *st,
 				 const struct inv_icm42607_conf *conf)
 {
@@ -95,6 +152,11 @@ static int inv_icm42607_setup(struct inv_icm42607_state *st,
 		return dev_err_probe(dev, ret,
 				     "reset error, reset done bit not set\n");
 
+	/* Sync the regcache again after a reset. */
+	ret = regcache_sync(st->map);
+	if (ret)
+		return ret;
+
 	ret = bus_setup(st);
 	if (ret)
 		return ret;
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
new file mode 100644
index 000000000000..8631579a609a
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 InvenSense, Inc.
+ */
+
+#include <linux/device.h>
+#include <linux/i2c.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
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
+	const struct inv_icm42607_hw *hw;
+	struct regmap *regmap;
+
+	hw = i2c_get_match_data(client);
+	if (!hw)
+		return dev_err_probe(&client->dev, -ENODEV,
+				     "Failed to get i2c data\n");
+
+	regmap = devm_regmap_init_i2c(client, &inv_icm42607_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(&client->dev, PTR_ERR(regmap),
+				     "Failed to register i2c regmap %ld\n",
+				     PTR_ERR(regmap));
+
+	return inv_icm42607_core_probe(regmap, hw, inv_icm42607_i2c_bus_setup);
+}
+
+static const struct i2c_device_id inv_icm42607_id[] = {
+	{ "icm42607", (kernel_ulong_t)&inv_icm42607_hw_data },
+	{ "icm42607p", (kernel_ulong_t)&inv_icm42607p_hw_data },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, inv_icm42607_id);
+
+static const struct of_device_id inv_icm42607_of_matches[] = {
+	{
+		.compatible = "invensense,icm42607",
+		.data = &inv_icm42607_hw_data,
+	}, {
+		.compatible = "invensense,icm42607p",
+		.data = &inv_icm42607p_hw_data,
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
index 000000000000..960b5d3e9abc
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 InvenSense, Inc.
+ */
+
+#include <linux/device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+
+#include "inv_icm42607.h"
+
+static int inv_icm42607_spi_bus_setup(struct inv_icm42607_state *st)
+{
+	unsigned int val;
+	int ret;
+
+	/* Only support 4-wire mode for now. */
+	ret = regmap_set_bits(st->map, INV_ICM42607_REG_DEVICE_CONFIG,
+				      INV_ICM42607_DEVICE_CONFIG_SPI_AP_4WIRE);
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
+	const struct inv_icm42607_hw *hw;
+	struct regmap *regmap;
+
+	hw = spi_get_device_match_data(spi);
+	if (!hw)
+		return dev_err_probe(&spi->dev, -ENODEV,
+				     "Failed to get SPI data\n");
+
+	if (spi->mode & SPI_3WIRE)
+		return dev_err_probe(&spi->dev, -ENODEV,
+				     "SPI 3-wire mode not supported\n");
+
+	regmap = devm_regmap_init_spi(spi, &inv_icm42607_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(&spi->dev, PTR_ERR(regmap),
+				     "Failed to register spi regmap %ld\n",
+				     PTR_ERR(regmap));
+
+	return inv_icm42607_core_probe(regmap, hw,
+				       inv_icm42607_spi_bus_setup);
+}
+
+static const struct of_device_id inv_icm42607_of_matches[] = {
+	{
+		.compatible = "invensense,icm42607",
+		.data = &inv_icm42607_hw_data,
+	},
+	{
+		.compatible = "invensense,icm42607p",
+		.data = &inv_icm42607p_hw_data,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, inv_icm42607_of_matches);
+
+static const struct spi_device_id inv_icm42607_spi_id_table[] = {
+	{ "icm42607", (kernel_ulong_t)&inv_icm42607_hw_data },
+	{ "icm42607p", (kernel_ulong_t)&inv_icm42607p_hw_data },
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

