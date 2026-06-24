Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B2532B135
	for <linux-iio@vger.kernel.org>; Wed, 24 Jun 2026 18:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782325972; cv=none; b=jkb4GzRBPG8WD5pYq5Y3zuRuMuJAfRhluh9FCx0nbWEFsKhcUN07TBba8m03bheCpXMaabHVbP7kwfvXCatLmcupoACKo9dD7uWo7c554HlfxxHWZw5oUkekm74NxmTGDKu0nH3y2KH+BpFDd2jMRqndD1aFmc9wb/2FcO9gODM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782325972; c=relaxed/simple;
	bh=7hJ+FTl6h+6fyNcy5OF/K7CW2W/fE3cMOF+DresIZGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hXiUnipGaSGTi1zZnxhI9N4aeYG0JFX+TKA1KF7s7DGcUTANC/CVqk+h2HTbAJqWsApyqmRXOPiM4VXhVoV3ftLo7JG6i2rAddalMNUqiU82iAlE36jo+rF4OsK7SddJ8S6/j4H1ge0pq5cgm7csdISx3LqqmAK0PBd8zUcUTSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHwJC7QW; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHwJC7QW"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-43f5e285111so946501fac.1
        for <linux-iio@vger.kernel.org>; Wed, 24 Jun 2026 11:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782325970; x=1782930770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MdGvXpxhZV3aMifO6F6NzYEcuT1/loZxmdAdWZDr/EU=;
        b=AHwJC7QWuuXuAKs4/sPJN2/gNttUMxSXof01v3yH+FNEG2R9rCaf3Os9uG9O2JUlLm
         BPUWYTf3npgF/DIo8d+znt99LbTeRF4i/FrrY3kM7zdMUMNfwyNh3J4BCkzGiVIBTZ+N
         M5yemAeMe5dme3jLf8nY65ysbXR9cZ2H+RP+8gQd/Or/PWPnHHFLaXxHMRY2sJzpC4Py
         9kAD0ftbmvPbrEfGpGa2UQQ8Tu67BYiS9dm/TzGSoV3SAG/JRk/U1iRqHgOVE2Fx0V2g
         I0CvJieGa+7t5347gfPNHIlSL2uXFP/XmKkp6AVy4Hnd9ZlLGZsaskeQUvzsZsQnMlM6
         KgBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782325970; x=1782930770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MdGvXpxhZV3aMifO6F6NzYEcuT1/loZxmdAdWZDr/EU=;
        b=CuSKl75lL+0d1lAvv+n2neSt5fILrm4WlehMoenQpCuqi4WECGwwgquhQAzD3jSUwj
         Kxm9eay9oM5r7TTwETH2FJMSh6S5Yj+BeFwa/gnho3W3QoQ+onDCnZBeSLCzyWfvVnWr
         hqn19q+6Nc0JKvU1TdZBswmQA9MkOxKkoof4JTbaRZNOZ61Hh8qxyDJ/kuxuViihZjkm
         2gTnD2TUGkMKl5rRXvKMKRPhSbyvUqAWeA9IhluvzUT756YAhvybt4MaODbkZ7OUWUcm
         XKqypCJyTMz9gZUWpEzdYxuAjwESN2i1a5kWhQ6LrQz8aWj5d8Emk5Comgp69v6pPmEg
         U4rw==
X-Gm-Message-State: AOJu0YyfJj0PBF5VS9bx+kl/ZM7oYwKw4NwACpVYBS3qGpVWUMR2JDqH
	nTDYXetzj+GeqYpQ4YY0VvAZhqwZob6k4aW/XY7LouENhq9EraMqVBLAPlIJ1OfG
X-Gm-Gg: AfdE7cmdZkDKvuJpGhUM+mTqdw0OWAUfMoYE2o7WZmMcPKyD2KrGNtVUSqblLXyWLJ5
	bnSf+tTaBHMbEZ72SRtYUfyqXd7XAsFb5JZBQlc4o7aEfrg4EB2d5bFNcsGUyeyLNFQmjKKCpP6
	imEYN9W8r1iFNnPAL1twENFPdwTZmG3RgQTaO8F3B5moLQ6DybvA2GiXfACre90CsXUjy6pm6/L
	6F8ERSL/okr2cXAIyah5ngg8Lh9mNpkq+DBtU8D42TkUUqTd4IcooVeQEloXuYFjjD65ejltm4E
	5weTXndTMqPP3FQsldhJk2YN/69gcqgRRhgbOKzwOswbjtNi4HXsLi5v8QXjcb0FhOHBWjYAtmv
	5XI1qzJcbnEdT0sUjR534mmS4rg69LycYna/0iP75F5+DxqsWVAADvva9op4uD2luL8S45/7OCG
	9RWZtDlFPnPLQ=
X-Received: by 2002:a05:6870:8254:b0:43b:4d09:5bab with SMTP id 586e51a60fabf-44732105f4fmr16336868fac.4.1782325970370;
        Wed, 24 Jun 2026 11:32:50 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4472f042517sm9968060fac.13.2026.06.24.11.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 11:32:50 -0700 (PDT)
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
Subject: [PATCH V14 4/9] iio: imu: inv_icm42607: Add SPI For icm42607
Date: Wed, 24 Jun 2026 13:23:43 -0500
Message-ID: <20260624182350.50467-5-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260624182350.50467-1-macroalpha82@gmail.com>
References: <20260624182350.50467-1-macroalpha82@gmail.com>
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

