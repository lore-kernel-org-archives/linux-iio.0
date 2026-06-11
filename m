Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA213CAE95
	for <linux-iio@vger.kernel.org>; Thu, 11 Jun 2026 20:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781209719; cv=none; b=HQHbm9CX9A7BHbf2aYEp6ZM37nokcmjhRPwTfv0z6O6hqcggHx9p+r/mxK8pY8zTcf6oTMaP1Me8ApRRd4eTy4Mltc7tTMNtV/WGIfQYzIIR513NiKRxJSFs9TpDWimRth9ZynMWeMd0KWU+9RXOnAgP/coxkJmOk8CZUDhAmhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781209719; c=relaxed/simple;
	bh=6R3XnO996BbYcLcFPf1RpCFAFC9nrxaTq3ip5Pzn05w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=djIhnoiE3M0SKoMhw6FNWjpijI/gSBtZB8gMFkQPw5pKq7LwWndKUtRKCdwcThNTimiK9zoJXJNiHmy2RIsty4oPFZ97O9kaxSUww22UhfeXKkYYnQwU1/H57FyTasLlq1AQy50sknailoZEgFnbETkRPJsw7nbqwSpxOHJsbiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDdDnGwM; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDdDnGwM"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4871618372cso254530b6e.3
        for <linux-iio@vger.kernel.org>; Thu, 11 Jun 2026 13:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781209717; x=1781814517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k4uA4P4kk9jq7ZtuhJVafMWUPGD8gwOjaxoN1zj0c04=;
        b=LDdDnGwMQnyjTF6Q4ER+qxdMK1LmcoM7QD0fEHaHoamIlsd7algH6cIAOpF9WkfhEI
         V+io1FXV75rjzLyehaIZHDBW9vLwvD6sGGdWQfSz0XbQU0yiUsPoH1pMj/Z9I4wArwwv
         DzTq80WsXGST05x4JZf+0PQDkG26VPE3GH0yOx9wij0JRQhMFX2uiHPIsERIVrKTTxSh
         Lkz7PQlhI3Mch/Lnaq0DFAjJ0TjSvNjFkmL0jeWE5bYI3Zx2i9zQjKmy2R5r5bmY08PJ
         QsNCjJg+CG0cKCPPVBbUwBF/dlUgeJUWk/ZzKLAuRqA6j0R+dWL1hi2LfW0cwjYlg0x5
         w/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781209717; x=1781814517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k4uA4P4kk9jq7ZtuhJVafMWUPGD8gwOjaxoN1zj0c04=;
        b=oJQ6lD4IPhmO3Oi38Nrtr7zNXtG/1gLHQRkYA5pvs+sKIFnO26lB9crQWS60d1boJI
         slXuSEEYwTh4UQlwZ+Fv8QvCV0GTEQSc1VzU+0YLOKKJdwE9Zxgq46v6/BSWrKIkzZO6
         YZRwnhAMtjXU3Nfo7nATjdqVZ+z12gA/BdcaYKO0uD+6EVaQjHY+pjTOzmitj7xBgeiO
         yKIph7ysfKtncjPvfFd28d9tgl5qDG80n8TZi2bpS8Em26OqilHepWRJ+2mPl7mFUajX
         IkBfwRkDt+eQaNVg5wn8/IwYOs7PvdT6uaVnv3oXMRMOSq70FAIbgb5xexDF3eMBWbHs
         Mw/w==
X-Gm-Message-State: AOJu0Yz8PFKa3tzowwsmr8s52DpkrDKTNna5QBrOyDBsad8wWKkMYA/D
	8+kuktK7nAN6uZFTH87QYE/wjoVMQ4WSWvV3V57XDaZ8y7/g08hGMVh6YXN1zwjV
X-Gm-Gg: Acq92OGIuoiwLEef37ssuuwR0Ve2nd+xMYoHmmlnyhiX1gX6beBAAuvdIFm00LSyZh4
	hkQk5JD3PeLV0dqP13tMrjAT75UEL0qc7Gbpcu5RwKRoekuwQ6PIALO/01d8cMVL8ESso8trmos
	cN/J+/8kC7fMP8AUr33FocC57jgwdOzO8CpEE77ADV6Yp2HhxSZzhg7aHpgu3OnTVBTJ5CMkTBK
	o2H5/mYMIbdbHU1DfimtAiSriCxPhAybWatcW9UYa2dFERBpKD6mfgXJSCFWDx5UEktSWKrBhJo
	4cWnrAUBevyuyJrHHF38PBgTK2ThK9FGU9zMnuh7oXtlzCmE7vfr2SC+KHgulIVRpwNuuCxZwaJ
	cbiwakkeLtZnhVwG4IjWjxhOwjXxAZGA0HfyoSVBuoNWDsBw0bZ6670m1lJkQkZ59iBYmQPtyng
	e3dB6pPEAFp7MZ9AENf9VaIg==
X-Received: by 2002:a05:6808:10c1:b0:486:79ad:96e9 with SMTP id 5614622812f47-4871a5a5280mr3521468b6e.37.1781209717146;
        Thu, 11 Jun 2026 13:28:37 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44244cd05c9sm1796134fac.18.2026.06.11.13.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 13:28:36 -0700 (PDT)
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
Subject: [PATCH V12 4/9] iio: imu: inv_icm42607: Add SPI For icm42607
Date: Thu, 11 Jun 2026 15:26:01 -0500
Message-ID: <20260611202607.85376-5-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611202607.85376-1-macroalpha82@gmail.com>
References: <20260611202607.85376-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add SPI driver support for InvenSense ICM-42607 devices.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/iio/imu/inv_icm42607/Kconfig          |  12 ++
 drivers/iio/imu/inv_icm42607/Makefile         |   3 +
 .../iio/imu/inv_icm42607/inv_icm42607_spi.c   | 107 ++++++++++++++++++
 3 files changed, 122 insertions(+)
 create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c

diff --git a/drivers/iio/imu/inv_icm42607/Kconfig b/drivers/iio/imu/inv_icm42607/Kconfig
index 083c212087ab..23f461f57afc 100644
--- a/drivers/iio/imu/inv_icm42607/Kconfig
+++ b/drivers/iio/imu/inv_icm42607/Kconfig
@@ -16,3 +16,15 @@ config INV_ICM42607_I2C
 
 	  This driver can be built as a module. The module will be called
 	  inv-icm42607-i2c.
+
+config INV_ICM42607_SPI
+	tristate "InvenSense ICM-42607 SPI driver"
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
index 32046e2727d7..be109102e203 100644
--- a/drivers/iio/imu/inv_icm42607/Makefile
+++ b/drivers/iio/imu/inv_icm42607/Makefile
@@ -5,3 +5,6 @@ inv-icm42607-y += inv_icm42607_core.o
 
 obj-$(CONFIG_INV_ICM42607_I2C) += inv-icm42607-i2c.o
 inv-icm42607-i2c-y += inv_icm42607_i2c.o
+
+obj-$(CONFIG_INV_ICM42607_SPI) += inv-icm42607-spi.o
+inv-icm42607-spi-y += inv_icm42607_spi.o
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c
new file mode 100644
index 000000000000..0c8deb1f33e2
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 InvenSense, Inc.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/dev_printk.h>
+#include <linux/err.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
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
+			 INV_ICM42607_SLEW_RATE_2NS);
+	ret = regmap_update_bits(st->map, INV_ICM42607_REG_DRIVE_CONFIG3,
+				 INV_ICM42607_DRIVE_CONFIG3_SPI_MASK, val);
+	if (ret)
+		return ret;
+
+	val = FIELD_PREP(INV_ICM42607_INTF_CONFIG0_UI_SIFS_CFG_MASK,
+			 INV_ICM42607_INTF_CONFIG0_UI_SIFS_CFG_I2C_DIS);
+	return regmap_update_bits(st->map, INV_ICM42607_REG_INTF_CONFIG0,
+				  INV_ICM42607_INTF_CONFIG0_UI_SIFS_CFG_MASK,
+				  val);
+}
+
+static int inv_icm42607_probe(struct spi_device *spi)
+{
+	const struct inv_icm42607_hw *hw;
+	struct device *dev = &spi->dev;
+	struct regmap *regmap;
+
+	hw = spi_get_device_match_data(spi);
+	if (!hw)
+		return dev_err_probe(dev, -ENODEV, "Failed to get SPI data\n");
+
+	if (spi->mode & SPI_3WIRE)
+		return dev_err_probe(dev, -ENODEV, "SPI 3-wire mode not supported\n");
+
+	regmap = devm_regmap_init_spi(spi, &inv_icm42607_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap),
+				     "Failed to register spi regmap\n");
+
+	return inv_icm42607_core_probe(regmap, hw,
+				       inv_icm42607_spi_bus_setup);
+}
+
+static const struct spi_device_id inv_icm42607_spi_id_table[] = {
+	{
+		.name = "icm42607",
+		.driver_data = (kernel_ulong_t)&inv_icm42607_hw_data
+	}, {
+		.name = "icm42607p",
+		.driver_data = (kernel_ulong_t)&inv_icm42607p_hw_data
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, inv_icm42607_spi_id_table);
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

