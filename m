Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F614B44A0;
	Fri, 18 Sep 2026 09:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789722496; cv=none; b=WrJVv6HQp2xHxd7JvFQHMqNQiCrgO1Wqm8Oc0/bv2E4jHawv8VMUAOhsPLHaZpbQ+sMpY4vPYEuJzS2D/cc5x1VHern8GG+JkIeTQqSNmGbbomvNP92OM3TeFzaqXkjRvUCP8SIbqeGKMQ3ppOdr7lK4/yS6AIK+07YCO/5eVs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789722496; c=relaxed/simple;
	bh=fnwglVRd0N7CEdYDw2KT1aqYRa7VFSfsMYiSc27yegc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=oXGWHofD7YExS77WjCc+SSWF860QDe4RfVkW9r708vUp3pulZIdIcbrAmY1WPPTU0UBd9GzkSHvvu93T1TOaFXRJWIp+34muxLiLVi18gk2RqoLxH4nHX0Qz5oUmZA/3nhJzgSvKPnYQyd+nSWPFDHvBhh6mNX+rrhb4z8rMbas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vGWshEh8; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vGWshEh8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1789722499; x=1821258499;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=fnwglVRd0N7CEdYDw2KT1aqYRa7VFSfsMYiSc27yegc=;
  b=vGWshEh8f7zGEREbs9zboJmoq7yhF/sYqVis1OAWjLxqA15h3X/goE4p
   AfljhR1xCmE0DxcMDk30yJrYA8YB+OeCqdGpdAur26kEcuO7mneWRHw7e
   11uJuXaV4A/OdLIPy+Q9/uKIcwXSdiocSjgonHaA6R2ag0UDehIEZvOIq
   aUzhxS+N6yhl95L/2pPxT+GVij8lwSzHAnU5Y+FpDzjrX5J5cboaEtYDo
   OvGtVpOrXrtl1XzT1jJVemIVzZhCwgoQp6ByJOI8B+GOt2U6HdoRODAE8
   m/qaI+sKfb9cR+CH8BrKkx7FzYJ0lob6kyzdsS0L5pwF9KIyAo/WvXUbJ
   w==;
X-CSE-ConnectionGUID: /2T7RFSHS62a9DWM7cFiTA==
X-CSE-MsgGUID: 1J+TM8hnRlqHwRtuDwg/Vw==
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="295219157"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 02:08:18 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Fri, 18 Sep 2026 02:08:13 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 18 Sep 2026 02:08:10 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Fri, 18 Sep 2026 12:06:37 +0300
Subject: [PATCH v7 11/11] iio: dac: add support for Microchip MCP48FEB02
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260918-mcp47feb02_refactor-v7-11-82ca794eafe2@microchip.com>
References: <20260918-mcp47feb02_refactor-v7-0-82ca794eafe2@microchip.com>
In-Reply-To: <20260918-mcp47feb02_refactor-v7-0-82ca794eafe2@microchip.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Ariana Lazar <ariana.lazar@microchip.com>,
	Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789722457; l=11356;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=fnwglVRd0N7CEdYDw2KT1aqYRa7VFSfsMYiSc27yegc=;
 b=+u2HQYWDFNgZazl1MclRusFl42TU6eaud0WfoISOE4aPp+OB3H5CvoXfy+IHgySXtsTf3ipRO
 llrArNA1cFfA5p4UpTsyEZWywJlFGl80iBYRymIqcJx0uHbTLuEdGNW
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
index c99c32b229fb683d6407f30682f7ea6104984421..3e37db1f772a2ccf9c872d7e128766f342e13d6f 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -618,6 +618,29 @@ config MCP47FEB02_I2C
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
index 6377a9c42d983f615a0aa4d36a0c3d3639c62951..b665ff638cdc6e6e8ee32521c9c12a9e3d192eef 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -58,6 +58,7 @@ obj-$(CONFIG_MCP4728) += mcp4728.o
 obj-$(CONFIG_MCP47A1) += mcp47a1.o
 obj-$(CONFIG_MCP47FEB02) += mcp47feb02-core.o
 obj-$(CONFIG_MCP47FEB02_I2C) += mcp47feb02-i2c.o
+obj-$(CONFIG_MCP47FEB02_SPI) += mcp47feb02-spi.o
 obj-$(CONFIG_MCP4821) += mcp4821.o
 obj-$(CONFIG_MCP4922) += mcp4922.o
 obj-$(CONFIG_STM32_DAC_CORE) += stm32-dac-core.o
diff --git a/drivers/iio/dac/mcp47feb02-core.c b/drivers/iio/dac/mcp47feb02-core.c
index 91fad42df2168f32b3de2757b4de7c1bb4b07b3a..d2b940abbd31be2019b04c35df35dc67b5949a3a 100644
--- a/drivers/iio/dac/mcp47feb02-core.c
+++ b/drivers/iio/dac/mcp47feb02-core.c
@@ -977,5 +977,5 @@ int mcp47feb02_common_probe(const struct mcp47feb02_features *chip_features,
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

