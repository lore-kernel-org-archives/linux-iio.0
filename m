Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99767572692;
	Wed,  9 Sep 2026 14:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963565; cv=none; b=bQihonIHj3k3g/Awog893VGbOMEcgG4ogOjODpweXewRPS3qySTPHNPezeMbZ7MqYvQDaUZH4xsehEF7zV4yiePvGJXll+rw3Rz9KrWke99ffj1OdFboZVhu7ZNAt+4xgwgfCdMwfTyMTOI0GLSBQp5CEhICx3+S0Ww0AEp5a+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963565; c=relaxed/simple;
	bh=gHrQC0pT4WPCYBiQrHsxPJcU+8ZI3XHSzBYSPRRGlME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=rvk7pPTX9WQn81O8rfVbim3MeogZbmRk78bAM7Q9jZ3lOmw+9bGZulG+iG+7OM5XVSAgiQIAsUhsqQAj3gvOFfs9lCRLXiY+A5fyWRDLDX787gsdNJECDo1vKAkXL3VSax3Z1PX9DFX3dyqjPoHEJVUsiCLNFyPFKku/l8H6OgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=qyTbWB70; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="qyTbWB70"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1788963562; x=1820499562;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=gHrQC0pT4WPCYBiQrHsxPJcU+8ZI3XHSzBYSPRRGlME=;
  b=qyTbWB70lfWwxCMTTtXoKb3+I1bw9vhXYox4YDRHHSyW6IFqT9fCT67L
   /ezcoMswrUx1P5Z9QvK9/udv03fKZaEh4ArjXOdu+w0+yzqUq+pL2d0nA
   vft6hLUrjBmZ5mG52ilGD/iQrQrUeudr1wsrwFhSUiC/nA/JfRzFqiw9z
   Gi6BvgaWxiTIvymdpPL+sNg7u95C3bOVlD0H1ABg8qcETI1UqvmPlaA8b
   A5DpYPRZ1fmPzciTd1DPTP5nGT2O51yymnSJfeBMIZpbx0OL/kuuMvhJV
   mPLmEZO27y+sEblg4g1xfbZpPC2IPk5CvxyTeyrHj8dGQPS3WyenkXed3
   Q==;
X-CSE-ConnectionGUID: RkyHt+quTuG/QkuAJ6Dhwg==
X-CSE-MsgGUID: vI0hHk1ATh+IDBJqzTD2HQ==
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="62449354"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 07:19:21 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Wed, 9 Sep 2026 07:19:21 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 9 Sep 2026 07:19:18 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Wed, 9 Sep 2026 17:18:53 +0300
Subject: [PATCH v5 10/10] iio: dac: add support for Microchip MCP48FEB02
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260909-mcp47feb02_refactor-v5-10-8b67bcab93d1@microchip.com>
References: <20260909-mcp47feb02_refactor-v5-0-8b67bcab93d1@microchip.com>
In-Reply-To: <20260909-mcp47feb02_refactor-v5-0-8b67bcab93d1@microchip.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Ariana Lazar <ariana.lazar@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788963530; l=10612;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=gHrQC0pT4WPCYBiQrHsxPJcU+8ZI3XHSzBYSPRRGlME=;
 b=rjClFrs7KAVjTbqTtG3eUrHoC3AaR2x4+zhqw8CRdwp5FOtdAuOkNKrd5f44b51OAidrNydiR
 LTGGcMKeXMvCGHX63iH2VXFjifJTF9QPH7ZPtcyCgJq3eWPdSe6KKci
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

This is the IIO driver for Microchip MCP48FxBy1/2/4/8 series of buffered
voltage output Digital-to-Analog Converters with nonvolatile or volatile
memory and an SPI Interface.

The families support up to 8 output channels.

The devices can be 8-bit, 10-bit and 12-bit.

Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
 drivers/iio/dac/Kconfig          |  23 +++++++
 drivers/iio/dac/Makefile         |   1 +
 drivers/iio/dac/mcp47feb02-spi.c | 145 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 169 insertions(+)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index cc10d43ffd1e89bbf945ef89ea5af0abe1a91084..d941f78f7110b185fee6f025be829bae1e4534da 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -575,6 +575,29 @@ config MCP47FEB02_I2C
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
index 28c8646a987cff1ac4d693fe86898d66c901d5bd..9903198b934e8b66a4ea6562b662d8073ed9cc59 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -56,6 +56,7 @@ obj-$(CONFIG_MCP4725) += mcp4725.o
 obj-$(CONFIG_MCP4728) += mcp4728.o
 obj-$(CONFIG_MCP47FEB02) += mcp47feb02-core.o
 obj-$(CONFIG_MCP47FEB02_I2C) += mcp47feb02-i2c.o
+obj-$(CONFIG_MCP47FEB02_SPI) += mcp47feb02-spi.o
 obj-$(CONFIG_MCP4821) += mcp4821.o
 obj-$(CONFIG_MCP4922) += mcp4922.o
 obj-$(CONFIG_STM32_DAC_CORE) += stm32-dac-core.o
diff --git a/drivers/iio/dac/mcp47feb02-spi.c b/drivers/iio/dac/mcp47feb02-spi.c
new file mode 100644
index 0000000000000000000000000000000000000000..0c68d7c318cb2269a9d713d3c6ec0854a576c19e
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
+		return dev_err_probe(dev, -ENODEV, "No SPI device found\n");
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

