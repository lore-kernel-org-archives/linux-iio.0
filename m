Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BF3361DAB
	for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 22:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783980072; cv=none; b=L92kbTLk9S7Tgx5ZnjYoSOKQp2MtHYNAo9PAW+2nrJwoS4qpS9ZVTnWXNvdBPLAbkgVZe4Q4EEbspizBmY3mnEOazENKFIiGmM/gXitC77JHlSDB1URcqKj7s7JR74dfzUo94xvDfcVFyJQneTP2aoKgMWkooBre5AxbYfMTQA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783980072; c=relaxed/simple;
	bh=7hJ+FTl6h+6fyNcy5OF/K7CW2W/fE3cMOF+DresIZGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ayvu8d0vYyIsk3H7GUSt4PbFdi354QZvkzO91LmlUwwdDPYCiyaJGcvGzkaYOYcR7WwpiB5RHKqBhnqUG9BJxBJZU5RalYa0G3JvtVLn3vB1CwgSAzGTDXoo/yG8y+bXGXTf+OXgy5/qtS2S3R+QgHRvzgIOQ/NH6DJbeCNPcWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rW1uVTJl; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rW1uVTJl"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-44cf70de986so1042994fac.0
        for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 15:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783980070; x=1784584870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MdGvXpxhZV3aMifO6F6NzYEcuT1/loZxmdAdWZDr/EU=;
        b=rW1uVTJlv3TbjbKOn+9AIbknTqQrRJ0RiV8Q8RnV1Ys2LttIJrC1jfsxOkQSaxEIVo
         RUVQe7vj546RdnflmLMKqD/OAV7r9WLLX7bb7uqzVyOamVryc+ORVe0QljIew3HyN7kD
         ZFaAfDm7VDJ/IfMtNKyPDdI457a55MJBI1QvPHzXqvlE9E39U5E3qrDRKQVAveJ89VQi
         OjiRkniVCGU71o3NjHeLrI7TqoGE69AMCM/bEeJssZawPXIV10oePMCPzSsaIiEjpBpZ
         AWM0lVDTaBi+N7oQuiif8IFBoe2aVEbN+FzveFNPJZkKgxiBkLyyJYPYG//Q3sSmhZHz
         oJwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783980070; x=1784584870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MdGvXpxhZV3aMifO6F6NzYEcuT1/loZxmdAdWZDr/EU=;
        b=YCO6nRJCA4t3rgHge4otnfBW/2q1BjpSo7bEwwrHjtFEX4tPCRofvRIRx9LAInqJDG
         u0Y/B/fIueQ93q/EzqtvZrEg6K97aY3BZIjTxn7amU6vJ44xxpaLVtEy1AhSExY5Rol1
         c/euPvxARVfkwuHkq9vP7DO1cp+UYuElcvKpCl2RtRT4xX5gfYrG7dIQQGB1MfOPFvKc
         7s7YNNT43BIOZOa6pvf1a8RJZz1D0WRi5tRhavVWNUtdwwjj2nNSlOGznSlREOrXGYYa
         BeGdUPr1aiMi/9YVgj9Gr9VrJEivSqGsH7qd+znyF3Sd6bDPI99PrW8OtIYW8Q7QjyyL
         BrMQ==
X-Gm-Message-State: AOJu0YwZ8jeiR0urei5y1bOsz1FRWEfjC+6a9/pjUjwuqu0aXWXUANEC
	lRX5mft4j4rEql0zRf2imngC8z+EFOYMcsIgfq67xPemy1jdKGvgHX5zyKK4FQ==
X-Gm-Gg: AfdE7cl5YTal+8lO0ShVEaiBW1Z7vksWGv3D29eXQONS578oIFfx+tcvJqMXExJAtK4
	5kpHzPh8RKr8YmRm00Sz2rJDfvmFy94MsIGjDTBmGFoE3El+v4vNBYbekygT8RZNtn4A1mbxGXv
	wBLPE7Iui/9Bjw0cCcdmz7uQMZIROR8jS5XVH5suc2XVExdTCg/khb2qmnjeipD5JmflI9cBsHV
	yII+QTPh8G9KFvPYP3PwOA2/bTdPsAA3r8MgjqDuw3kiKaoeJcWNtgTqNT2OCeXANikT06FJd/j
	P21OzvYolZgL+/KaEjGDJ8cmIQ55qdyHLrq/u1540xnRx01sonvlOedYYlCf8kxiMeTYsMsZmcG
	7M98whgTSono4X2iEhqNSAUSXhdpOT14CtOgTbZCVo3egxdzUoZNb2EFE/hLPvSx18z3FctnJTw
	LIFHfRCC1+e3o=
X-Received: by 2002:a05:6808:190e:b0:495:db8f:ded8 with SMTP id 5614622812f47-4a42abc07e5mr7937055b6e.9.1783980070324;
        Mon, 13 Jul 2026 15:01:10 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a1acc82f3csm12939785b6e.3.2026.07.13.15.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 15:01:09 -0700 (PDT)
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
Subject: [PATCH v16 05/10] iio: imu: inv_icm42607: Add SPI For icm42607
Date: Mon, 13 Jul 2026 16:58:35 -0500
Message-ID: <20260713215842.69097-6-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713215842.69097-1-macroalpha82@gmail.com>
References: <20260713215842.69097-1-macroalpha82@gmail.com>
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
index 000000000000..6072ed7adc86
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
+		.driver_data = (kernel_ulong_t)&inv_icm42607_hw_data,
+	}, {
+		.name = "icm42607p",
+		.driver_data = (kernel_ulong_t)&inv_icm42607p_hw_data,
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
+MODULE_DESCRIPTION("InvenSense ICM-42607 SPI driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_ICM42607");
-- 
2.43.0

