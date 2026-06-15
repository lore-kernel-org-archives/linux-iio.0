Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484D94183DC
	for <linux-iio@vger.kernel.org>; Mon, 15 Jun 2026 17:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781544493; cv=none; b=pN/i8zx4nJ4GoAIfACBuyC4/wfVHaH/0Ix6RukmnPS4D54WFs7iW8SMmB978MHVysjUa4K9XZvmbjuPUiiHO05oOULY2mFVbWiExlY1OG37t71CL0CbX/VvqHtccZdo1JSC1704FT9i3ePR8hWDUJaT8jYwMZUQ3c7XX+vIOoyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781544493; c=relaxed/simple;
	bh=7hJ+FTl6h+6fyNcy5OF/K7CW2W/fE3cMOF+DresIZGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gp4pB9gylu8ODvNfUKBziJPKFeq5j5AgLfs+NiOPFGvHEaOi+n5IEuWxnEnp85SFWyoVUmDml81lTNKqX6iao/4hO2xILxnRn7zSswOkScQfjYoHaBcVmM+H2Ted4+wrgCAK+FiZQGYekyvgwvw+0DPyPfVR1X0Q88Zp6hdLvuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrZjg8iW; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrZjg8iW"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7e709dd1ab2so1427349a34.1
        for <linux-iio@vger.kernel.org>; Mon, 15 Jun 2026 10:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781544491; x=1782149291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MdGvXpxhZV3aMifO6F6NzYEcuT1/loZxmdAdWZDr/EU=;
        b=jrZjg8iWTcjxTl9gElg+4Mnrf2loUZofjifsb9nskFjkWNBBMrsX2ssKNHtkM2l3tn
         rD3pMIFDqLFHbd1jXgcX33q/NIHw+CnRAZvJSluzsnhg5sdepAeqMgKGq6mVMQVJFGTg
         hb8/h66V1sUhMw5udw4E6AryIeaVoajOITDv2zopxg134Z1cYMT1WsVeJFFIuuFS/RaO
         rTAq1j3vqqUUGJ4z0TDsoyXdKe4U3LLWifAZtkE4caJfvF/9xlm+8ZbAV6Cql1568s6s
         RUXGq240wBFEJBNhAzFcZysRYpOEizTGGDYzSYS1vuk9r0PcSxRIzr3Wnljtb/YVFZAh
         Zkig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781544491; x=1782149291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MdGvXpxhZV3aMifO6F6NzYEcuT1/loZxmdAdWZDr/EU=;
        b=ACyY37DnSaY9quz8y2CDhKR7HzwIenZ3asMsQY+7NrGdoIahXXW2PAULfyZVeu3ghS
         yGBQOhedYxPZudqhJHJYk0uEp6aLzPRKVfDVNTZ7vDTi8U646/bT7upu0sVGR3F5UyLu
         U6l/5+TCKzmUaSd7qIbvBp/kiTId8kIJ7XAJomiCcSWPoJj4T+7fsl/SgWP/Bx1xKfkm
         mqm7H9PCB84rhY5hDMarv8DRdhA8emaYmACC5rCcKRVQos1Nrbygy1qgU7evw0kv139E
         lZm0MBlFOzjFNGn6t9VuO2cxwJjEn7QJsLl6qgmQGIIJvX/I5RUtdseaCz3OYNEO1jOM
         f7fQ==
X-Gm-Message-State: AOJu0Yw/lgjZlhw4XyZYae2NJ+OpH6J+OLb0dauEWlnCvx6AEtVct16/
	a//ar8SbxbUWNyAronPFs5Kot728tX+3aCfirNsYS3ZQHeI39ULQzQDN8yzttx32
X-Gm-Gg: Acq92OHyrsOVEclRsM5BjqH2Mg2qDHoGZRgUBewAdroSYsTenAiXJGiaQv1M65eb8OE
	y1mElB7rEJClrW0x6HgAjSLgAlEc2PjQNL3dQ0y2+jGwJ296JTWgD/f5fNPJdKoEl6B2N8MZMLH
	+ngLTkFwv5+7czJe6fzrl5IIo2lraUjS3vaWqYISliAXApeELLl2CkRQNLfyj6AlzDroIz32QAM
	9W0ACdUvfgNixolFpCRRPS7QX0qZC6+06nDFEh7WOetz70nVq4q4LR7jgpb9zadvkXdbL0By8cb
	EJvhp9Toi3mO7nyFfWyc9A0EYb7ZcLZqOf3r1TPsKdKa3iw75gDa0wOlVUjPqUHWWrYaor3razu
	TejhylVyTrcIzRrTgUBUbKORljYfyuhJ0KcYtOYM+Yd/0sb1tL+k5rN5s82JX6sZhZERBusbHil
	Pfp2DSLm79k6yi0xldPM1phg==
X-Received: by 2002:a05:6830:7009:b0:7e6:dc7a:f459 with SMTP id 46e09a7af769-7e7847fbf8emr9879773a34.11.1781544491219;
        Mon, 15 Jun 2026 10:28:11 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e79f451fe7sm4480033a34.0.2026.06.15.10.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 10:28:10 -0700 (PDT)
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
Subject: [PATCH V13 4/9] iio: imu: inv_icm42607: Add SPI For icm42607
Date: Mon, 15 Jun 2026 12:25:47 -0500
Message-ID: <20260615172554.160910-5-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615172554.160910-1-macroalpha82@gmail.com>
References: <20260615172554.160910-1-macroalpha82@gmail.com>
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

