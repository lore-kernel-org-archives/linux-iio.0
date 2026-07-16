Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC956434E51
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 18:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784226548; cv=none; b=HQCp7Bi/vz7ryiHEA61abzcLXreB0TPKz0V7g13AUJDuYbGGn+agwRrKA5nWYfGkkrNYpobWcSDEQS/itNTWIvU/ixCywdykSv2IIxCGb5NEpgGzFvetyShqO3htflWhVaQtP6ufiCBeo+I+o9jqok7VdGJkoQIG+KsbT2E43c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784226548; c=relaxed/simple;
	bh=WQutJRijrnKBWEOL5ffHyp1U1A8V6uH9D0gypdIpfJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Js5Pn3IJZPkuNEvXf/4QNBdKe6Gmmd5T8E/sDwDXySSuG44J1McklPtLRGc1wAcaXYUnaQuHSPEEstXu/3VAI337vg5K5CHXKZdjqxe1pY4lv47eLzr54WyVyXi6HI4W89c5onzkIJOq0IUxYGPvFxqCG7OId7aYl1VNfuM9nOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XCSeQgeK; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCSeQgeK"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7e9f69ee6f4so2743038a34.2
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 11:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784226544; x=1784831344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BBQj5o1xBe0UYUjJRFQjbTlsi/qLCduPzV5e4TThaHw=;
        b=XCSeQgeKOd+JX2QIHW3SI91cl2H2K+H4zXYMjxRqANnG+M3RJW+OSIPY2ixx/Swxwk
         SVHSGpxuBZlSaqFmyZkFHNwwt05HlIoyS/ubIYXZat7xxY5XWiiA+1dGFpfeyRxeKlz4
         SK86tDDpcBhoMlZxCmGX0v4JukKdggoGkUfiW6A3zugoZALXVIBVV42Y65qh3j/uoeKH
         rZYX/6VgTF+eX6AY0Z87BPYKJDeQ7eCC7pYmxDaVbjGztn4ub/KBIaSzw32kNVVzaLvs
         2ZbNk+cv2rRXxkr6yPIyOZKzeVIcblVtdNg0kLTkukadbiwufwxtE20+prkkOtfsQ/lG
         3DGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784226544; x=1784831344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BBQj5o1xBe0UYUjJRFQjbTlsi/qLCduPzV5e4TThaHw=;
        b=NX+AjfPeYl1eLpvdEqKSh0tefqvpKxjl+2c5Mw9ev1KPQ6wiwSpCPI5QzUKHp1/nO5
         TN7F689WI3AuJRI+nzcZDDDogx1CymmlPTMgyReCkS60WEPHlTf1UzTW7IP3u5QjDVNX
         YU0FQJUtQHIgJiLCprwo+BTeURO8bQES10w+QCqAY0WrHppernqyAVl8opyfKqZODSgK
         iGvkp+L2ekgCm2RdVjjFMKQS+Z9fSsp3WGYWlmGCCt1bXu2MAE0aVMeJDXWoybKA234G
         8n7ngz8KzqPQ/vtkhbLAP6o0yytI5WB8s64bm4Uwr77v6VQTU6ESSuVg59t8JNs63UpL
         DRIQ==
X-Gm-Message-State: AOJu0YwAeoUBYLcfgjOTLurEIvdGl4WDhETxQE9U5B+zmGv0MgQmXMGj
	z4iitObGFqt0+UiLz1jz7rpbrDIHLD4NZ/6JsHMTWKzwfws1Fc00XeSWeDsgsw==
X-Gm-Gg: AfdE7ckkEpXrfLXTPkhn9MfJZLYscBhjVUGSTO6cCe42IWsFH6ubmeiqCt6YYPXm2B3
	DzggjaKMW4mNORHJ2ymdb7gvu4GauBF9chLg66OcftziGLYwYhKzOX6HnrJWc+WSKBXHf/Y72b0
	dpbUXUXsUEnR4nBuOPA+d875bib3Gqb5DfhmqMTXUmsvq3/QoCdTS2naIUUB9xNU2rh+4EpVLt1
	uB3VRYSAXNp2v2rXLbo/+6vJXB+asST+922GiYvR/46Hpy4ZwTLwIOPXLExnd27/1UMxwYWlRzp
	KtyS2D5XKiUwczacFRhiiwsrZIdpqJ7ocEqhrDOCxlKI15cbS9qWW9GU9IIdBxlPtYqV0JgsdVq
	nX+6luQZrvY5QghPLz07YavcEBUSH0RV4+zG+1m2E4i3eQL1uYUVk1lhTwm9Ov3OszVuo/VF89+
	yY
X-Received: by 2002:a05:6830:710e:b0:7ec:6749:f38f with SMTP id 46e09a7af769-7ec9fe96c9emr470066a34.22.1784226544055;
        Thu, 16 Jul 2026 11:29:04 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcb3f6826sm19939993a34.27.2026.07.16.11.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 11:29:03 -0700 (PDT)
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
Subject: [PATCH V17 4/9] iio: imu: inv_icm42607: Add SPI For icm42607
Date: Thu, 16 Jul 2026 13:26:31 -0500
Message-ID: <20260716182637.24310-5-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260716182637.24310-1-macroalpha82@gmail.com>
References: <20260716182637.24310-1-macroalpha82@gmail.com>
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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
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
index 000000000000..8eee7f162126
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
+
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
+		return dev_err_probe(dev, -ENODATA, "Failed to get SPI data\n");
+
+	if (spi->mode & SPI_3WIRE)
+		return dev_err_probe(dev, -ENODEV, "SPI 3-wire mode not supported\n");
+
+	regmap = devm_regmap_init_spi(spi, &inv_icm42607_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap),
+				     "Failed to register spi regmap\n");
+
+	return inv_icm42607_core_probe(regmap, hw, inv_icm42607_spi_bus_setup);
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

