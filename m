Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1486747F2DD;
	Thu, 24 Sep 2026 12:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790254786; cv=none; b=p5QmIvbSfcwAjCZ7M6NmRmjs9Hr3TgrTos7v7YCFI+iFEeMGZST7n918I+ofNqSrqdtHkU6UpKsy4mhHMnJkSV4U67HttwBXmRh3yCbGJwYKaAn2yBZEmzvSYxSQ1ifhr+Lk6fohAra43Dkwj5zaCpdIUJtaT5gatwAkkA8mdks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790254786; c=relaxed/simple;
	bh=zFHyK11vjmn1B/boKtCmqPSbQGI/J8o+C9re7SgkhzI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=VsnFE6wy9hZn3+pJ7P96k0RRQICJYrZAd9ImPgY8LOuaa6oIElXW0Av8kngis45H/PWjY1xKWFMh9YXOG3+Ysc7/h20AsA4mLJh7JmqpdB93veeRhV1T75HrvYwbDmsemEq9NMk3x7GL7TOIHAjoH7dJaEW8/yc8+swgyFs05vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=f4s1rH4z; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="f4s1rH4z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1790254784; x=1821790784;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=zFHyK11vjmn1B/boKtCmqPSbQGI/J8o+C9re7SgkhzI=;
  b=f4s1rH4zH4M3vZr4+rmJ/nP1CofD12H6ZYXKrOVOJOBZjIvaGG52U/8Z
   hqFhj3FszlebBx5c1uQn0YSfBAv1Xo6jkRflMDAqWb8QtNvyXj7fcvcwJ
   C18xRHscwUGI4ol7NLkEC5qhyH3ZXm5ZHq9meGMd+1MNzHOSA3zDxwzAc
   1aDDUwT/BzcUOz+Eo+i7oz7GVu0CiL2DIopsgst9XRHuJsxarwc1dyh/2
   mNjjSSt1Lu2H9P/zm9qZx11hw4PgsYdizTEQPO5V/MayMob+hjz001ZJa
   1tdQLzNmKwLO8eUMOfWqivalrA/sQ4bIFknkdn8R0JkqiSwfj/bUbBgXv
   Q==;
X-CSE-ConnectionGUID: 3drwJJ2cQWmseNhnV/erdQ==
X-CSE-MsgGUID: 6oAOLRtpSy+o6p6qliw8pQ==
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="64097086"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 05:59:42 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Thu, 24 Sep 2026 05:59:41 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Thu, 24 Sep 2026 05:59:38 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Thu, 24 Sep 2026 15:59:23 +0300
Subject: [PATCH v8 5/5] iio: dac: add support for Microchip MCP48FEB02
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260924-mcp47feb02_refactor-v8-5-17dc2ce3485e@microchip.com>
References: <20260924-mcp47feb02_refactor-v8-0-17dc2ce3485e@microchip.com>
In-Reply-To: <20260924-mcp47feb02_refactor-v8-0-17dc2ce3485e@microchip.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Ariana Lazar <ariana.lazar@microchip.com>,
	Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790254762; l=11356;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=zFHyK11vjmn1B/boKtCmqPSbQGI/J8o+C9re7SgkhzI=;
 b=z5UIwaRZHtvnAkXkH8MDnCl84y+5FvbDDwHBbMcSVMtbiIek1uTi1Cy+IUkG08I8LmgVhMiuv
 Ftk7J1ns2V0AlvI40XYqj5DKyFqTkdcVpIBiTvbB2l4zwvzumImcKG5
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

This is the IIO driver for Microchip MCP48FxBy1/2/4/8 series of buffered
voltage output Digital-to-Analog Converters with nonvolatile or volatile
memory and an SPI Interface.

The families support up to 8 output channels.

The devices can be 8-bit, 10-bit and 12-bit.

Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
 drivers/iio/dac/Kconfig           |  23 ++++++
 drivers/iio/dac/Makefile          |   1 +
 drivers/iio/dac/mcp47feb02-core.c |   2 +-
 drivers/iio/dac/mcp47feb02-spi.c  | 145 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 170 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 8121a71945f63a23b35fcab010fda1d03d0afba0..e373885e7c7a13129f39fb8617763c8c2bf3ae74 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -636,6 +636,29 @@ config MCP47FEB02_I2C
 	  will be called mcp47feb02_i2c and you will also get
 	  mcp47feb02_core for the core module.
 
+config MCP47FEB02_SPI
+	tristate "MCP48F(E/V)B01/02/04/08/11/12/14/18/21/22/24/28 SPI DAC driver"
+	depends on SPI
+	select REGMAP_SPI
+	select MCP47FEB02
+	help
+	  Say yes here if you want to build the driver for the Microchip:
+	  - 8-bit DAC:
+	    MCP48FEB01, MCP48FEB02, MCP48FEB04, MCP48FEB08,
+	    MCP48FVB01, MCP48FVB02, MCP48FVB04, MCP48FVB08
+	  - 10-bit DAC:
+	    MCP48FEB11, MCP48FEB12, MCP48FEB14, MCP48FEB18,
+	    MCP48FVB11, MCP48FVB12, MCP48FVB14, MCP48FVB18
+	  - 12-bit DAC:
+	    MCP48FEB21, MCP48FEB22, MCP48FEB24, MCP48FEB28,
+	    MCP48FVB21, MCP48FVB22, MCP48FVB24, MCP48FVB28
+	  having 1 to 8 channels, 8/10/12-bit digital-to-analog converter
+	  (DAC) with SPI interface.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called mcp47feb02_spi and you will also get
+	  mcp47feb02_core for the core module.
+
 config MCP4821
 	tristate "MCP4801/02/11/12/21/22 DAC driver"
 	depends on SPI
diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index 4394278d9fd874b94ae2d680378fb3b043ac8672..2cd0fe23db9e60245cbe515a99c5eaff60db3c6c 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -59,6 +59,7 @@ obj-$(CONFIG_MCP4728) += mcp4728.o
 obj-$(CONFIG_MCP47A1) += mcp47a1.o
 obj-$(CONFIG_MCP47FEB02) += mcp47feb02-core.o
 obj-$(CONFIG_MCP47FEB02_I2C) += mcp47feb02-i2c.o
+obj-$(CONFIG_MCP47FEB02_SPI) += mcp47feb02-spi.o
 obj-$(CONFIG_MCP4821) += mcp4821.o
 obj-$(CONFIG_MCP4922) += mcp4922.o
 obj-$(CONFIG_STM32_DAC_CORE) += stm32-dac-core.o
diff --git a/drivers/iio/dac/mcp47feb02-core.c b/drivers/iio/dac/mcp47feb02-core.c
index 29d69cb2f68b5d7c6a615481bb1045aed468e9cf..06063d77739582faad3010202390aead1d5a0aa1 100644
--- a/drivers/iio/dac/mcp47feb02-core.c
+++ b/drivers/iio/dac/mcp47feb02-core.c
@@ -980,5 +980,5 @@ int mcp47feb02_common_probe(const struct mcp47feb02_features *chip_features,
 EXPORT_SYMBOL_NS(mcp47feb02_common_probe, "IIO_MCP47FEB02");
 
 MODULE_AUTHOR("Ariana Lazar <ariana.lazar@microchip.com>");
-MODULE_DESCRIPTION("IIO driver for MCP47FEB02 Multi-Channel DAC with I2C interface");
+MODULE_DESCRIPTION("IIO driver for MCP47FEB02/MCP48FEB02 Multi-Channel DAC");
 MODULE_LICENSE("GPL");
diff --git a/drivers/iio/dac/mcp47feb02-spi.c b/drivers/iio/dac/mcp47feb02-spi.c
new file mode 100644
index 0000000000000000000000000000000000000000..974f8fe1b86e939e99e6b2a7d3d05f025a73aa67
--- /dev/null
+++ b/drivers/iio/dac/mcp47feb02-spi.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * IIO driver for MCP48FEB02 Multi-Channel DAC with SPI interface
+ *
+ * Copyright (C) 2025-2026 Microchip Technology Inc. and its subsidiaries
+ *
+ * Author: Ariana Lazar <ariana.lazar@microchip.com>
+ *
+ * Datasheet links for devices with SPI interface:
+ * [MCP48FEBxx] https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/20005429B.pdf
+ * [MCP48FVBxx] https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/20005466A.pdf
+ * [MCP48FxBx4/8] https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/MCP48FXBX4-8-Family-Data-Sheet-DS20006362A.pdf
+ */
+#include <linux/dev_printk.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/pm.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+#include <linux/types.h>
+
+#include "mcp47feb02.h"
+
+/* Parts with EEPROM memory */
+MCP47FEB02_CHIP_INFO(mcp48feb01, 1, 8,  false, true);
+MCP47FEB02_CHIP_INFO(mcp48feb02, 2, 8,  false, true);
+MCP47FEB02_CHIP_INFO(mcp48feb04, 4, 8,  true,  true);
+MCP47FEB02_CHIP_INFO(mcp48feb08, 8, 8,  true,  true);
+MCP47FEB02_CHIP_INFO(mcp48feb11, 1, 10, false, true);
+MCP47FEB02_CHIP_INFO(mcp48feb12, 2, 10, false, true);
+MCP47FEB02_CHIP_INFO(mcp48feb14, 4, 10, true,  true);
+MCP47FEB02_CHIP_INFO(mcp48feb18, 8, 10, true,  true);
+MCP47FEB02_CHIP_INFO(mcp48feb21, 1, 12, false, true);
+MCP47FEB02_CHIP_INFO(mcp48feb22, 2, 12, false, true);
+MCP47FEB02_CHIP_INFO(mcp48feb24, 4, 12, true,  true);
+MCP47FEB02_CHIP_INFO(mcp48feb28, 8, 12, true,  true);
+
+/* Parts without EEPROM memory */
+MCP47FEB02_CHIP_INFO(mcp48fvb01, 1, 8,  false, false);
+MCP47FEB02_CHIP_INFO(mcp48fvb02, 2, 8,  false, false);
+MCP47FEB02_CHIP_INFO(mcp48fvb04, 4, 8,  true,  false);
+MCP47FEB02_CHIP_INFO(mcp48fvb08, 8, 8,  true,  false);
+MCP47FEB02_CHIP_INFO(mcp48fvb11, 1, 10, false, false);
+MCP47FEB02_CHIP_INFO(mcp48fvb12, 2, 10, false, false);
+MCP47FEB02_CHIP_INFO(mcp48fvb14, 4, 10, true,  false);
+MCP47FEB02_CHIP_INFO(mcp48fvb18, 8, 10, true,  false);
+MCP47FEB02_CHIP_INFO(mcp48fvb21, 1, 12, false, false);
+MCP47FEB02_CHIP_INFO(mcp48fvb22, 2, 12, false, false);
+MCP47FEB02_CHIP_INFO(mcp48fvb24, 4, 12, true,  false);
+MCP47FEB02_CHIP_INFO(mcp48fvb28, 8, 12, true,  false);
+
+static int mcp47feb02_spi_probe(struct spi_device *spi)
+{
+	const struct mcp47feb02_features *chip_features;
+	struct device *dev = &spi->dev;
+	struct regmap *regmap;
+
+	chip_features = spi_get_device_match_data(spi);
+	if (!chip_features)
+		return dev_err_probe(dev, -ENODATA, "No match data found\n");
+
+	if (chip_features->have_eeprom)
+		regmap = devm_regmap_init_spi(spi, &mcp47feb02_regmap_config);
+	else
+		regmap = devm_regmap_init_spi(spi, &mcp47fvb02_regmap_config);
+
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap), "Error initializing SPI regmap\n");
+
+	return mcp47feb02_common_probe(chip_features, regmap);
+}
+
+static const struct spi_device_id mcp47feb02_spi_id[] = {
+	{ .name = "mcp48feb01", .driver_data = (kernel_ulong_t)&mcp48feb01_chip_features },
+	{ .name = "mcp48feb02", .driver_data = (kernel_ulong_t)&mcp48feb02_chip_features },
+	{ .name = "mcp48feb04", .driver_data = (kernel_ulong_t)&mcp48feb04_chip_features },
+	{ .name = "mcp48feb08", .driver_data = (kernel_ulong_t)&mcp48feb08_chip_features },
+	{ .name = "mcp48feb11", .driver_data = (kernel_ulong_t)&mcp48feb11_chip_features },
+	{ .name = "mcp48feb12", .driver_data = (kernel_ulong_t)&mcp48feb12_chip_features },
+	{ .name = "mcp48feb14", .driver_data = (kernel_ulong_t)&mcp48feb14_chip_features },
+	{ .name = "mcp48feb18", .driver_data =  (kernel_ulong_t)&mcp48feb18_chip_features },
+	{ .name = "mcp48feb21", .driver_data = (kernel_ulong_t)&mcp48feb21_chip_features },
+	{ .name = "mcp48feb22", .driver_data = (kernel_ulong_t)&mcp48feb22_chip_features },
+	{ .name = "mcp48feb24", .driver_data = (kernel_ulong_t)&mcp48feb24_chip_features },
+	{ .name = "mcp48feb28", .driver_data = (kernel_ulong_t)&mcp48feb28_chip_features },
+	{ .name = "mcp48fvb01", .driver_data = (kernel_ulong_t)&mcp48fvb01_chip_features },
+	{ .name = "mcp48fvb02", .driver_data = (kernel_ulong_t)&mcp48fvb02_chip_features },
+	{ .name = "mcp48fvb04", .driver_data = (kernel_ulong_t)&mcp48fvb04_chip_features },
+	{ .name = "mcp48fvb08", .driver_data = (kernel_ulong_t)&mcp48fvb08_chip_features },
+	{ .name = "mcp48fvb11", .driver_data = (kernel_ulong_t)&mcp48fvb11_chip_features },
+	{ .name = "mcp48fvb12", .driver_data = (kernel_ulong_t)&mcp48fvb12_chip_features },
+	{ .name = "mcp48fvb14", .driver_data = (kernel_ulong_t)&mcp48fvb14_chip_features },
+	{ .name = "mcp48fvb18", .driver_data = (kernel_ulong_t)&mcp48fvb18_chip_features },
+	{ .name = "mcp48fvb21", .driver_data = (kernel_ulong_t)&mcp48fvb21_chip_features },
+	{ .name = "mcp48fvb22", .driver_data = (kernel_ulong_t)&mcp48fvb22_chip_features },
+	{ .name = "mcp48fvb24", .driver_data = (kernel_ulong_t)&mcp48fvb24_chip_features },
+	{ .name = "mcp48fvb28", .driver_data = (kernel_ulong_t)&mcp48fvb28_chip_features },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, mcp47feb02_spi_id);
+
+static const struct of_device_id mcp47feb02_of_spi_match[] = {
+	{ .compatible = "microchip,mcp48feb01", .data = &mcp48feb01_chip_features },
+	{ .compatible = "microchip,mcp48feb02", .data = &mcp48feb02_chip_features },
+	{ .compatible = "microchip,mcp48feb04", .data = &mcp48feb04_chip_features },
+	{ .compatible = "microchip,mcp48feb08", .data = &mcp48feb08_chip_features },
+	{ .compatible = "microchip,mcp48feb11", .data = &mcp48feb11_chip_features },
+	{ .compatible = "microchip,mcp48feb12", .data = &mcp48feb12_chip_features },
+	{ .compatible = "microchip,mcp48feb14", .data = &mcp48feb14_chip_features },
+	{ .compatible = "microchip,mcp48feb18", .data = &mcp48feb18_chip_features },
+	{ .compatible = "microchip,mcp48feb21", .data = &mcp48feb21_chip_features },
+	{ .compatible = "microchip,mcp48feb22", .data = &mcp48feb22_chip_features },
+	{ .compatible = "microchip,mcp48feb24", .data = &mcp48feb24_chip_features },
+	{ .compatible = "microchip,mcp48feb28", .data = &mcp48feb28_chip_features },
+	{ .compatible = "microchip,mcp48fvb01", .data = &mcp48fvb01_chip_features },
+	{ .compatible = "microchip,mcp48fvb02", .data = &mcp48fvb02_chip_features },
+	{ .compatible = "microchip,mcp48fvb04", .data = &mcp48fvb04_chip_features },
+	{ .compatible = "microchip,mcp48fvb08", .data = &mcp48fvb08_chip_features },
+	{ .compatible = "microchip,mcp48fvb11", .data = &mcp48fvb11_chip_features },
+	{ .compatible = "microchip,mcp48fvb12", .data = &mcp48fvb12_chip_features },
+	{ .compatible = "microchip,mcp48fvb14",	.data = &mcp48fvb14_chip_features },
+	{ .compatible = "microchip,mcp48fvb18", .data = &mcp48fvb18_chip_features },
+	{ .compatible = "microchip,mcp48fvb21", .data = &mcp48fvb21_chip_features },
+	{ .compatible = "microchip,mcp48fvb22", .data = &mcp48fvb22_chip_features },
+	{ .compatible = "microchip,mcp48fvb24", .data = &mcp48fvb24_chip_features },
+	{ .compatible = "microchip,mcp48fvb28", .data = &mcp48fvb28_chip_features },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, mcp47feb02_of_spi_match);
+
+static struct spi_driver mcp47feb02_spi_driver = {
+	.driver = {
+		.name = "mcp47feb02",
+		.of_match_table = mcp47feb02_of_spi_match,
+		.pm = pm_sleep_ptr(&mcp47feb02_pm_ops),
+	},
+	.probe = mcp47feb02_spi_probe,
+	.id_table = mcp47feb02_spi_id,
+};
+module_spi_driver(mcp47feb02_spi_driver);
+
+MODULE_AUTHOR("Ariana Lazar <ariana.lazar@microchip.com>");
+MODULE_DESCRIPTION("IIO driver for MCP48FEB02 Multi-Channel DAC with SPI interface");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_MCP47FEB02");

-- 
2.43.0

