Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9723BF66D
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 20:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784579172; cv=none; b=Mro5ATxXao/EZ3zVjnpY+u0gYjDLa+zs1Ks1+up8P2VH8Re++XoNdU6dWNd0bd6fkYGU4p6scwbN6LAzYDINrBxL9Ws9hC0c3Asjte/zYKK911JT1rsX9ByMCXn0pW+Q1SWsZLB2eI0uaDBZ/shmFl3MM+X2yewNT1jI9iR67Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784579172; c=relaxed/simple;
	bh=u8sqJFwDMCgRXeJu9/AxLtYBFuVF587TRulRfeDXXMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=phRL5kG27QuWK9z/pw9RMzOhL86MfPxBqtROfSpF0lNX3K+mIkjd42S6TX5JV/AEYt/K7ZiSrZKAy5vBODyaMc3L1eI5c+QtlEo+uoSqbcdqk/18VVkyVMP6radz7uW4d4Arzx5+SvWYp6DGIFAuxc7iqfbm5B0FYW4ubujJX08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tKjr6tdH; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tKjr6tdH"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-492046a3313so4930703b6e.2
        for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 13:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784579169; x=1785183969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X7cKInG3LvCx702WPltJ7pIgcjx5mq1L90Yz6/fhnzA=;
        b=tKjr6tdHv5H6LoOtANTfU6BXR5/pS2H1D4gd/iHSagovfrX8fysol249mXOOYpU9DC
         l8XcWi4oK56c2a60v5mPvtOWYSYgDOe5RQkAcleJYsPjrsN9h/DQ7plfMfTKF0css5/O
         bQaGsYdJ5ly9lxlNEEip3bxRKbGZfs5+uVlt8TQlwrJBtL89r71Wy6WRtXEE9tXgBgo3
         KuiIlIxAj9JRd0txFBLjhmXfuBCxAnrgNOUlHk2+iVdoIu8xIpZurkQepvHhz28fhS70
         8S+lAkFIc7JoK+VoIdTXka0PTm3cKT66OBfoiADErvS+41PNgZ7uvOZszBijXOHCrU3Q
         /KtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784579169; x=1785183969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=X7cKInG3LvCx702WPltJ7pIgcjx5mq1L90Yz6/fhnzA=;
        b=ry+2ycIw2BBwjflJvFdr9ZrW8emTj1ALndRYrMI5FaPjptWD/MJPbqWz/iAyO7ySTl
         QEYDK+uUYIMduMRWpHNgNYuyJ0j12rznLNHEX1CJw80oVsc1zFzmcxSaTDuokV4MnWWe
         bjCyaoxRs4pTGogxcGbsz3q6EAwUFfg8CuAG4Lwlcstl7FLvOojBcS0zAnH4XLj0Kldm
         kmSOvjPiN6z0gT8B/YevwQcOIhAksU54IzrWMyb7HThAPLJSboycjvV0aLu98KXx+vPq
         wRafPK2vdyOYuTIkriXlxo6CUAXxJ1pWkfGLfH1fn1evFjy87O7ip9Tz/HQaLPDqRQ+a
         T94w==
X-Gm-Message-State: AOJu0YzI4xc0q6JDNhYnkdan+7VBZUqc5lgGDmmFCGehpKN2jklShxqD
	ebOU9zcwOcDz1e1Sa9ceoVYu/XHywhIQS8k6ScBqmNwr1ufe/VC10tnvaUXgUA==
X-Gm-Gg: AfdE7cn9JjMZC2cSh2Z6j0lDniwlrquHZ+hgtFsJ9slR8bYJQA5XO3lu8BN8fz5RDIh
	2i5tm9FZlMsguKfEnK1WpZSodgbV81bYiD9N2zdtwRV0O9NtkfGvRmZs/VBbbOQUYHg0iCZBgL0
	psmYrdp0qOUubt6xB30l4lOpaAQrNbXChakzpMdJx2D7EDXkufMhxzoAhuzZj0qmqMlD30wRB3Y
	+bYbw3RCGndQSOCRFRh0vy8aA2nFoKW3hUzgVLbLGJqrUq/3YyOMUzsjyBYLqDL49Kglw/JU0SN
	fmW9tUUga5+R0dCpfJVuq5nXjtV3iGzfc345Cb+qYq/6Sv0efY0ztEVQrZqD6Rb2z8h0RKsVU9u
	8ZEJXgbr18/6R0QCHTtaUVKF9v+3jj0Y9xDMoLgq9qLh2QjqxZgRiG0huOtShsjN61FisH3j2uF
	Hw7N559wmzQmJA/W5mx+qcOA==
X-Received: by 2002:a05:6808:4f24:b0:4a2:df67:d08 with SMTP id 5614622812f47-4a4d03f8446mr9963713b6e.39.1784579169438;
        Mon, 20 Jul 2026 13:26:09 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0:9988:5abf:3c51:d168])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a4d3e5a0cdsm8029550b6e.18.2026.07.20.13.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 13:26:08 -0700 (PDT)
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
Subject: [PATCH V18 4/9] iio: imu: inv_icm42607: Add SPI For icm42607
Date: Mon, 20 Jul 2026 15:23:36 -0500
Message-ID: <20260720202343.70138-5-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720202343.70138-1-macroalpha82@gmail.com>
References: <20260720202343.70138-1-macroalpha82@gmail.com>
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
 .../iio/imu/inv_icm42607/inv_icm42607_spi.c   | 106 ++++++++++++++++++
 3 files changed, 121 insertions(+)
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
index 000000000000..eb04036a6712
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 InvenSense, Inc.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/dev_printk.h>
+#include <linux/err.h>
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

