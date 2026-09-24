Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E413481673;
	Thu, 24 Sep 2026 12:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790254780; cv=none; b=nYAwCZA2nSKK59MzXLLKjAo93kkSofnTxUKNx6CxJMvxyrEKVV9SI2xxc3PROZIwKcK68dgZGB+/mpNLeGGZ87QBwIwG0nI50rU7X35+8eKp93UTeFQ6Q3NQI7Xys4U6sK5UyJnXADDkdKg/Z0pS2Ntzr9GJ7Yqob4+i/DxTkDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790254780; c=relaxed/simple;
	bh=PYotjUOjYp32RwTwnCi/yuyBRDGGYADKvjO5TaMYsqk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=H0rnVaViRKRXgrXKbv1iQ7BmZu72MuUenL/F3222BaY0QQoYczq9O08/+ij0KlbZCDC2Y7tZSZKqN6Gk76qQka8El7M5WCgRU3vwVBB4LnAolFQhdCN2j7pjy3GY0QSHllb061rPOiEEEg3GGGgCwf6yIzngTVw9hles5J5cVPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=tA3mOiuf; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="tA3mOiuf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1790254777; x=1821790777;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=PYotjUOjYp32RwTwnCi/yuyBRDGGYADKvjO5TaMYsqk=;
  b=tA3mOiufOgb9SRFQkQVu6GiXmzv9BI1gHB+nkwXf7ixmtkrlZ/RU5chL
   SMlvEaDssgLZRBhmoG4Uj2ig50VbjQh0qjsLKADB9IfVKMFM5fTaSg9Wn
   S2TJ9xulp9V2QYxj+sN1iimuFqEEpiU50CnV7qcjFnnZiTb8NmlLmpqcL
   19q5Sy0lqrg3ooywtT05T1hF3gcOm7uZXiU2ka2v+blPAjmfPkp9Mf1sk
   5SPvmrkKlttERsq3eXdXAQe0EFvhC9V7TKdfqGMN2e+8/yPxfxHyxNbZF
   ypczMZNDBUVfpvBuVyYM6xKDpPh+aAHcQavuHtKWIpSob+cNTPk8ss6VC
   g==;
X-CSE-ConnectionGUID: 6/WP8FjVREmCcPj4nvJS9g==
X-CSE-MsgGUID: mmpDM7tvSGWDejeAr+I+qA==
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="64097083"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Sep 2026 05:59:36 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 24 Sep 2026 05:59:35 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Thu, 24 Sep 2026 05:59:32 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Thu, 24 Sep 2026 15:59:21 +0300
Subject: [PATCH v8 3/5] iio: dac: mcp47feb02: refactor MCP47FEB02 I2C
 driver into two modules
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260924-mcp47feb02_refactor-v8-3-17dc2ce3485e@microchip.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790254762; l=28673;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=PYotjUOjYp32RwTwnCi/yuyBRDGGYADKvjO5TaMYsqk=;
 b=cWStY9CKM7kFwLfN+dYgIvU1O7akHQnzxuGCIMgJO+znstVF8RWf9ENHnIzg30jQ5mh8eEFQj
 8K3KjMeXrlcAj6CrCidzv1HKkN+aiN0lSz2H3l8kfeOPvyQif9YoV5F
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

Prepare the driver for the bus-specific code by refactoring into separate
files. The renamed file will contain the common DAC functionality shared by
the MCP47FxBy1/2/4/8 I2C and MCP48FxBy1/2/4/8 SPI drivers. The MCP47FEB02
driver was refactored into two modules: mcp47feb02-core.c and
mcp47feb02-i2c.c in order to prepare the support for SPI MCP48FxBy1/2/4/8
DAC family on top of the current implementation.

Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
 MAINTAINERS                                        |   2 +-
 drivers/iio/dac/Kconfig                            |   9 +-
 drivers/iio/dac/Makefile                           |   3 +-
 .../iio/dac/{mcp47feb02.c => mcp47feb02-core.c}    | 322 ++-------------------
 drivers/iio/dac/mcp47feb02-i2c.c                   | 145 ++++++++++
 drivers/iio/dac/mcp47feb02.h                       |  43 +++
 6 files changed, 219 insertions(+), 305 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2e98d052fbdcf43f70376fdb3a553e97bf91dc82..ecc22d1149d19ae7798ebd54c52b1b2486d1f9f1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16352,7 +16352,7 @@ M:	Ariana Lazar <ariana.lazar@microchip.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml
-F:	drivers/iio/dac/mcp47feb02.c
+F:	drivers/iio/dac/mcp47feb02*
 
 MCP4821 DAC DRIVER
 M:	Anshul Dalal <anshulusr@gmail.com>
diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index b6c8873c68c54d13f80ea7116bee1ac00f374574..8121a71945f63a23b35fcab010fda1d03d0afba0 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -611,9 +611,13 @@ config MCP47A1
 	  will be called mcp47a1.
 
 config MCP47FEB02
-	tristate "MCP47F(E/V)B01/02/04/08/11/12/14/18/21/22/24/28 DAC driver"
+	tristate
+
+config MCP47FEB02_I2C
+	tristate "MCP47F(E/V)B01/02/04/08/11/12/14/18/21/22/24/28 I2C DAC driver"
 	depends on I2C
 	select REGMAP_I2C
+	select MCP47FEB02
 	help
 	  Say yes here if you want to build the driver for the Microchip:
 	  - 8-bit DAC:
@@ -629,7 +633,8 @@ config MCP47FEB02
 	  (DAC) with I2C interface.
 
 	  To compile this driver as a module, choose M here: the module
-	  will be called mcp47feb02.
+	  will be called mcp47feb02_i2c and you will also get
+	  mcp47feb02_core for the core module.
 
 config MCP4821
 	tristate "MCP4801/02/11/12/21/22 DAC driver"
diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index 8dc644522b1e52152abacc32cacb6ee90881ef9a..4394278d9fd874b94ae2d680378fb3b043ac8672 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -57,7 +57,8 @@ obj-$(CONFIG_MCF54415_DAC) += mcf54415_dac.o
 obj-$(CONFIG_MCP4725) += mcp4725.o
 obj-$(CONFIG_MCP4728) += mcp4728.o
 obj-$(CONFIG_MCP47A1) += mcp47a1.o
-obj-$(CONFIG_MCP47FEB02) += mcp47feb02.o
+obj-$(CONFIG_MCP47FEB02) += mcp47feb02-core.o
+obj-$(CONFIG_MCP47FEB02_I2C) += mcp47feb02-i2c.o
 obj-$(CONFIG_MCP4821) += mcp4821.o
 obj-$(CONFIG_MCP4922) += mcp4922.o
 obj-$(CONFIG_STM32_DAC_CORE) += stm32-dac-core.o
diff --git a/drivers/iio/dac/mcp47feb02.c b/drivers/iio/dac/mcp47feb02-core.c
similarity index 73%
rename from drivers/iio/dac/mcp47feb02.c
rename to drivers/iio/dac/mcp47feb02-core.c
index 8f8a67919cc2ecdb203ad350174bac2be1a307dc..29d69cb2f68b5d7c6a615481bb1045aed468e9cf 100644
--- a/drivers/iio/dac/mcp47feb02.c
+++ b/drivers/iio/dac/mcp47feb02-core.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * IIO driver for MCP47FEB02 Multi-Channel DAC with I2C interface
+ * IIO driver for MCP47FEB02 Multi-Channel DAC with I2C and SPI interface
  *
- * Copyright (C) 2025 Microchip Technology Inc. and its subsidiaries
+ * Copyright (C) 2025-2026 Microchip Technology Inc. and its subsidiaries
  *
  * Author: Ariana Lazar <ariana.lazar@microchip.com>
  *
@@ -16,7 +16,6 @@
 #include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/err.h>
-#include <linux/i2c.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/kstrtox.h>
@@ -29,6 +28,8 @@
 #include <linux/types.h>
 #include <linux/units.h>
 
+#include "mcp47feb02.h"
+
 /* Register addresses must be left shifted with 3 positions in order to append command mask */
 #define MCP47FEB02_DAC0_REG_ADDR			0x00
 #define MCP47FEB02_VREF_REG_ADDR			0x40
@@ -82,220 +83,12 @@ enum mcp47feb02_gain_bit_mode {
 	MCP47FEB02_GAIN_BIT_X2 = 1,
 };
 
-static const char * const mcp47feb02_powerdown_modes[] = {
+const char * const mcp47feb02_powerdown_modes[] = {
 	"1kohm_to_gnd",
 	"100kohm_to_gnd",
 	"open_circuit",
 };
 
-/**
- * struct mcp47feb02_features - chip specific data
- * @name: device name
- * @phys_channels: number of hardware channels
- * @resolution: DAC resolution
- * @have_ext_vref1: does the hardware have an the second external voltage reference?
- * @have_eeprom: does the hardware have an internal eeprom?
- */
-struct mcp47feb02_features {
-	const char *name;
-	unsigned int phys_channels;
-	unsigned int resolution;
-	bool have_ext_vref1;
-	bool have_eeprom;
-};
-
-static const struct mcp47feb02_features mcp47feb01_chip_features = {
-	.name = "mcp47feb01",
-	.phys_channels = 1,
-	.resolution = 8,
-	.have_ext_vref1 = false,
-	.have_eeprom = true,
-};
-
-static const struct mcp47feb02_features mcp47feb02_chip_features = {
-	.name = "mcp47feb02",
-	.phys_channels = 2,
-	.resolution = 8,
-	.have_ext_vref1 = false,
-	.have_eeprom = true,
-};
-
-static const struct mcp47feb02_features mcp47feb04_chip_features = {
-	.name = "mcp47feb04",
-	.phys_channels = 4,
-	.resolution = 8,
-	.have_ext_vref1 = true,
-	.have_eeprom = true,
-};
-
-static const struct mcp47feb02_features mcp47feb08_chip_features = {
-	.name = "mcp47feb08",
-	.phys_channels = 8,
-	.resolution = 8,
-	.have_ext_vref1 = true,
-	.have_eeprom = true,
-};
-
-static const struct mcp47feb02_features mcp47feb11_chip_features = {
-	.name = "mcp47feb11",
-	.phys_channels = 1,
-	.resolution = 10,
-	.have_ext_vref1 = false,
-	.have_eeprom = true,
-};
-
-static const struct mcp47feb02_features mcp47feb12_chip_features = {
-	.name = "mcp47feb12",
-	.phys_channels = 2,
-	.resolution = 10,
-	.have_ext_vref1 = false,
-	.have_eeprom = true,
-};
-
-static const struct mcp47feb02_features mcp47feb14_chip_features = {
-	.name = "mcp47feb14",
-	.phys_channels = 4,
-	.resolution = 10,
-	.have_ext_vref1 = true,
-	.have_eeprom = true,
-};
-
-static const struct mcp47feb02_features mcp47feb18_chip_features = {
-	.name = "mcp47feb18",
-	.phys_channels = 8,
-	.resolution = 10,
-	.have_ext_vref1 = true,
-	.have_eeprom = true,
-};
-
-static const struct mcp47feb02_features mcp47feb21_chip_features = {
-	.name = "mcp47feb21",
-	.phys_channels = 1,
-	.resolution = 12,
-	.have_ext_vref1 = false,
-	.have_eeprom = true,
-};
-
-static const struct mcp47feb02_features mcp47feb22_chip_features = {
-	.name = "mcp47feb22",
-	.phys_channels = 2,
-	.resolution = 12,
-	.have_ext_vref1 = false,
-	.have_eeprom = true,
-};
-
-static const struct mcp47feb02_features mcp47feb24_chip_features = {
-	.name = "mcp47feb24",
-	.phys_channels = 4,
-	.resolution = 12,
-	.have_ext_vref1 = true,
-	.have_eeprom = true,
-};
-
-static const struct mcp47feb02_features mcp47feb28_chip_features = {
-	.name = "mcp47feb28",
-	.phys_channels = 8,
-	.resolution = 12,
-	.have_ext_vref1 = true,
-	.have_eeprom = true,
-};
-
-static const struct mcp47feb02_features mcp47fvb01_chip_features = {
-	.name = "mcp47fvb01",
-	.phys_channels = 1,
-	.resolution = 8,
-	.have_ext_vref1 = false,
-	.have_eeprom = false,
-};
-
-static const struct mcp47feb02_features mcp47fvb02_chip_features = {
-	.name = "mcp47fvb02",
-	.phys_channels = 2,
-	.resolution = 8,
-	.have_ext_vref1 = false,
-	.have_eeprom = false,
-};
-
-static const struct mcp47feb02_features mcp47fvb04_chip_features = {
-	.name = "mcp47fvb04",
-	.phys_channels = 4,
-	.resolution = 8,
-	.have_ext_vref1 = true,
-	.have_eeprom = false,
-};
-
-static const struct mcp47feb02_features mcp47fvb08_chip_features = {
-	.name = "mcp47fvb08",
-	.phys_channels = 8,
-	.resolution = 8,
-	.have_ext_vref1 = true,
-	.have_eeprom = false,
-};
-
-static const struct mcp47feb02_features mcp47fvb11_chip_features = {
-	.name = "mcp47fvb11",
-	.phys_channels = 1,
-	.resolution = 10,
-	.have_ext_vref1 = false,
-	.have_eeprom = false,
-};
-
-static const struct mcp47feb02_features mcp47fvb12_chip_features = {
-	.name = "mcp47fvb12",
-	.phys_channels = 2,
-	.resolution = 10,
-	.have_ext_vref1 = false,
-	.have_eeprom = false,
-};
-
-static const struct mcp47feb02_features mcp47fvb14_chip_features = {
-	.name = "mcp47fvb14",
-	.phys_channels = 4,
-	.resolution = 10,
-	.have_ext_vref1 = true,
-	.have_eeprom = false,
-};
-
-static const struct mcp47feb02_features mcp47fvb18_chip_features = {
-	.name = "mcp47fvb18",
-	.phys_channels = 8,
-	.resolution = 10,
-	.have_ext_vref1 = true,
-	.have_eeprom = false,
-};
-
-static const struct mcp47feb02_features mcp47fvb21_chip_features = {
-	.name = "mcp47fvb21",
-	.phys_channels = 1,
-	.resolution = 12,
-	.have_ext_vref1 = false,
-	.have_eeprom = false,
-};
-
-static const struct mcp47feb02_features mcp47fvb22_chip_features = {
-	.name = "mcp47fvb22",
-	.phys_channels = 2,
-	.resolution = 12,
-	.have_ext_vref1 = false,
-	.have_eeprom = false,
-};
-
-static const struct mcp47feb02_features mcp47fvb24_chip_features = {
-	.name = "mcp47fvb24",
-	.phys_channels = 4,
-	.resolution = 12,
-	.have_ext_vref1 = true,
-	.have_eeprom = false,
-};
-
-static const struct mcp47feb02_features mcp47fvb28_chip_features = {
-	.name = "mcp47fvb28",
-	.phys_channels = 8,
-	.resolution = 12,
-	.have_ext_vref1 = true,
-	.have_eeprom = false,
-};
-
 /**
  * struct mcp47feb02_channel_data - channel configuration
  * @ref_mode: chosen voltage for reference
@@ -376,7 +169,7 @@ static const struct regmap_access_table mcp47feb02_volatile_table = {
 	.n_yes_ranges = ARRAY_SIZE(mcp47feb02_volatile_ranges),
 };
 
-static const struct regmap_config mcp47feb02_regmap_config = {
+const struct regmap_config mcp47feb02_regmap_config = {
 	.name = "mcp47feb02_regmap",
 	.reg_bits = 8,
 	.val_bits = 16,
@@ -388,6 +181,7 @@ static const struct regmap_config mcp47feb02_regmap_config = {
 	.cache_type = REGCACHE_MAPLE,
 	.val_format_endian = REGMAP_ENDIAN_BIG,
 };
+EXPORT_SYMBOL_NS_GPL(mcp47feb02_regmap_config, "IIO_MCP47FEB02");
 
 /* For devices that doesn't have nonvolatile memory */
 static const struct regmap_range mcp47fvb02_readable_ranges[] = {
@@ -418,7 +212,7 @@ static const struct regmap_access_table mcp47fvb02_volatile_table = {
 	.n_yes_ranges = ARRAY_SIZE(mcp47fvb02_volatile_ranges),
 };
 
-static const struct regmap_config mcp47fvb02_regmap_config = {
+const struct regmap_config mcp47fvb02_regmap_config = {
 	.name = "mcp47fvb02_regmap",
 	.reg_bits = 8,
 	.val_bits = 16,
@@ -430,6 +224,7 @@ static const struct regmap_config mcp47fvb02_regmap_config = {
 	.cache_type = REGCACHE_MAPLE,
 	.val_format_endian = REGMAP_ENDIAN_BIG,
 };
+EXPORT_SYMBOL_NS_GPL(mcp47fvb02_regmap_config, "IIO_MCP47FEB02");
 
 static int mcp47feb02_write_to_eeprom(struct mcp47feb02_data *data, unsigned int reg,
 				      unsigned int val)
@@ -575,12 +370,10 @@ static int mcp47feb02_resume(struct device *dev)
 	guard(mutex)(&data->lock);
 
 	for_each_set_bit(ch, &data->active_channels_mask, data->phys_channels) {
-		u8 pd_mode;
 		u32 mask;
 		int ret;
 
 		data->chdata[ch].powerdown = false;
-		pd_mode = data->chdata[ch].powerdown_mode + 1;
 
 		ret = regmap_write(data->regmap, REG_ADDR(ch), data->chdata[ch].dac_data);
 		if (ret)
@@ -588,7 +381,7 @@ static int mcp47feb02_resume(struct device *dev)
 
 		mask =  MCP47FEB02_VREF_PD_MASK(ch);
 		ret = regmap_update_bits(data->regmap, MCP47FEB02_VREF_REG_ADDR,
-					 mask, field_prep(mask, pd_mode));
+					 mask, field_prep(mask, data->chdata[ch].ref_mode));
 		if (ret)
 			return ret;
 
@@ -668,7 +461,8 @@ static ssize_t mcp47feb02_write_powerdown(struct iio_dev *indio_dev, uintptr_t p
 	return len;
 }
 
-static DEFINE_SIMPLE_DEV_PM_OPS(mcp47feb02_pm_ops, mcp47feb02_suspend, mcp47feb02_resume);
+EXPORT_NS_SIMPLE_DEV_PM_OPS(mcp47feb02_pm_ops, mcp47feb02_suspend,
+			    mcp47feb02_resume, IIO_MCP47FEB02);
 
 static const struct iio_enum mcp47febxx_powerdown_mode_enum = {
 	.items = mcp47feb02_powerdown_modes,
@@ -1105,10 +899,10 @@ static int mcp47feb02_init_ch_scales(struct mcp47feb02_data *data, int vdd_uV,
 	return 0;
 }
 
-static int mcp47feb02_probe(struct i2c_client *client)
+int mcp47feb02_common_probe(const struct mcp47feb02_features *chip_features,
+			    struct regmap *regmap)
 {
-	const struct mcp47feb02_features *chip_features;
-	struct device *dev = &client->dev;
+	struct device *dev = regmap_get_device(regmap);
 	struct mcp47feb02_data *data;
 	struct iio_dev *indio_dev;
 	int vref1_uV, vref_uV, vdd_uV, ret;
@@ -1117,22 +911,16 @@ static int mcp47feb02_probe(struct i2c_client *client)
 	if (!indio_dev)
 		return -ENOMEM;
 
-	data = iio_priv(indio_dev);
-	chip_features = i2c_get_match_data(client);
-	if (!chip_features)
-		return -EINVAL;
+	dev_set_drvdata(dev, indio_dev);
 
+	data = iio_priv(indio_dev);
 	data->chip_features = chip_features;
+	data->regmap = regmap;
 
-	if (chip_features->have_eeprom) {
-		data->regmap = devm_regmap_init_i2c(client, &mcp47feb02_regmap_config);
+	if (chip_features->have_eeprom)
 		indio_dev->info = &mcp47feb02_info;
-	} else {
-		data->regmap = devm_regmap_init_i2c(client, &mcp47fvb02_regmap_config);
+	else
 		indio_dev->info = &mcp47fvb02_info;
-	}
-	if (IS_ERR(data->regmap))
-		return dev_err_probe(dev, PTR_ERR(data->regmap), "Error initializing i2c regmap\n");
 
 	indio_dev->name = chip_features->name;
 
@@ -1189,75 +977,7 @@ static int mcp47feb02_probe(struct i2c_client *client)
 
 	return devm_iio_device_register(dev, indio_dev);
 }
-
-static const struct i2c_device_id mcp47feb02_id[] = {
-	{ .name = "mcp47feb01", .driver_data = (kernel_ulong_t)&mcp47feb01_chip_features },
-	{ .name = "mcp47feb02", .driver_data = (kernel_ulong_t)&mcp47feb02_chip_features },
-	{ .name = "mcp47feb04", .driver_data = (kernel_ulong_t)&mcp47feb04_chip_features },
-	{ .name = "mcp47feb08", .driver_data = (kernel_ulong_t)&mcp47feb08_chip_features },
-	{ .name = "mcp47feb11", .driver_data = (kernel_ulong_t)&mcp47feb11_chip_features },
-	{ .name = "mcp47feb12", .driver_data = (kernel_ulong_t)&mcp47feb12_chip_features },
-	{ .name = "mcp47feb14", .driver_data = (kernel_ulong_t)&mcp47feb14_chip_features },
-	{ .name = "mcp47feb18", .driver_data = (kernel_ulong_t)&mcp47feb18_chip_features },
-	{ .name = "mcp47feb21", .driver_data = (kernel_ulong_t)&mcp47feb21_chip_features },
-	{ .name = "mcp47feb22", .driver_data = (kernel_ulong_t)&mcp47feb22_chip_features },
-	{ .name = "mcp47feb24", .driver_data = (kernel_ulong_t)&mcp47feb24_chip_features },
-	{ .name = "mcp47feb28", .driver_data = (kernel_ulong_t)&mcp47feb28_chip_features },
-	{ .name = "mcp47fvb01", .driver_data = (kernel_ulong_t)&mcp47fvb01_chip_features },
-	{ .name = "mcp47fvb02", .driver_data = (kernel_ulong_t)&mcp47fvb02_chip_features },
-	{ .name = "mcp47fvb04", .driver_data = (kernel_ulong_t)&mcp47fvb04_chip_features },
-	{ .name = "mcp47fvb08", .driver_data = (kernel_ulong_t)&mcp47fvb08_chip_features },
-	{ .name = "mcp47fvb11", .driver_data = (kernel_ulong_t)&mcp47fvb11_chip_features },
-	{ .name = "mcp47fvb12", .driver_data = (kernel_ulong_t)&mcp47fvb12_chip_features },
-	{ .name = "mcp47fvb14", .driver_data = (kernel_ulong_t)&mcp47fvb14_chip_features },
-	{ .name = "mcp47fvb18", .driver_data = (kernel_ulong_t)&mcp47fvb18_chip_features },
-	{ .name = "mcp47fvb21", .driver_data = (kernel_ulong_t)&mcp47fvb21_chip_features },
-	{ .name = "mcp47fvb22", .driver_data = (kernel_ulong_t)&mcp47fvb22_chip_features },
-	{ .name = "mcp47fvb24", .driver_data = (kernel_ulong_t)&mcp47fvb24_chip_features },
-	{ .name = "mcp47fvb28", .driver_data = (kernel_ulong_t)&mcp47fvb28_chip_features },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, mcp47feb02_id);
-
-static const struct of_device_id mcp47feb02_of_match[] = {
-	{ .compatible = "microchip,mcp47feb01", .data = &mcp47feb01_chip_features },
-	{ .compatible = "microchip,mcp47feb02", .data = &mcp47feb02_chip_features },
-	{ .compatible = "microchip,mcp47feb04", .data = &mcp47feb04_chip_features },
-	{ .compatible = "microchip,mcp47feb08", .data = &mcp47feb08_chip_features },
-	{ .compatible = "microchip,mcp47feb11", .data = &mcp47feb11_chip_features },
-	{ .compatible = "microchip,mcp47feb12", .data = &mcp47feb12_chip_features },
-	{ .compatible = "microchip,mcp47feb14", .data = &mcp47feb14_chip_features },
-	{ .compatible = "microchip,mcp47feb18", .data = &mcp47feb18_chip_features },
-	{ .compatible = "microchip,mcp47feb21", .data = &mcp47feb21_chip_features },
-	{ .compatible = "microchip,mcp47feb22", .data = &mcp47feb22_chip_features },
-	{ .compatible = "microchip,mcp47feb24", .data = &mcp47feb24_chip_features },
-	{ .compatible = "microchip,mcp47feb28", .data = &mcp47feb28_chip_features },
-	{ .compatible = "microchip,mcp47fvb01", .data = &mcp47fvb01_chip_features },
-	{ .compatible = "microchip,mcp47fvb02", .data = &mcp47fvb02_chip_features },
-	{ .compatible = "microchip,mcp47fvb04", .data = &mcp47fvb04_chip_features },
-	{ .compatible = "microchip,mcp47fvb08", .data = &mcp47fvb08_chip_features },
-	{ .compatible = "microchip,mcp47fvb11", .data = &mcp47fvb11_chip_features },
-	{ .compatible = "microchip,mcp47fvb12", .data = &mcp47fvb12_chip_features },
-	{ .compatible = "microchip,mcp47fvb14",	.data = &mcp47fvb14_chip_features },
-	{ .compatible = "microchip,mcp47fvb18", .data = &mcp47fvb18_chip_features },
-	{ .compatible = "microchip,mcp47fvb21", .data = &mcp47fvb21_chip_features },
-	{ .compatible = "microchip,mcp47fvb22", .data = &mcp47fvb22_chip_features },
-	{ .compatible = "microchip,mcp47fvb24", .data = &mcp47fvb24_chip_features },
-	{ .compatible = "microchip,mcp47fvb28", .data = &mcp47fvb28_chip_features },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, mcp47feb02_of_match);
-
-static struct i2c_driver mcp47feb02_driver = {
-	.driver = {
-		.name	= "mcp47feb02",
-		.of_match_table = mcp47feb02_of_match,
-		.pm	= pm_sleep_ptr(&mcp47feb02_pm_ops),
-	},
-	.probe		= mcp47feb02_probe,
-	.id_table	= mcp47feb02_id,
-};
-module_i2c_driver(mcp47feb02_driver);
+EXPORT_SYMBOL_NS(mcp47feb02_common_probe, "IIO_MCP47FEB02");
 
 MODULE_AUTHOR("Ariana Lazar <ariana.lazar@microchip.com>");
 MODULE_DESCRIPTION("IIO driver for MCP47FEB02 Multi-Channel DAC with I2C interface");
diff --git a/drivers/iio/dac/mcp47feb02-i2c.c b/drivers/iio/dac/mcp47feb02-i2c.c
new file mode 100644
index 0000000000000000000000000000000000000000..7ec0cccad79bc9e9e3f919209c34d0f39656a370
--- /dev/null
+++ b/drivers/iio/dac/mcp47feb02-i2c.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * IIO driver for MCP47FEB02 Multi-Channel DAC with I2C interface
+ *
+ * Copyright (C) 2025-2026 Microchip Technology Inc. and its subsidiaries
+ *
+ * Author: Ariana Lazar <ariana.lazar@microchip.com>
+ *
+ * Datasheet links for devices with I2C interface:
+ * [MCP47FEBxx] https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/20005375A.pdf
+ * [MCP47FVBxx] https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/20005405A.pdf
+ * [MCP47FxBx4/8] https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/MCP47FXBX48-Data-Sheet-DS200006368A.pdf
+ */
+#include <linux/dev_printk.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/pm.h>
+#include <linux/regmap.h>
+#include <linux/types.h>
+
+#include "mcp47feb02.h"
+
+/* Parts with EEPROM memory */
+MCP47FEB02_CHIP_INFO(mcp47feb01, 1, 8,  false, true);
+MCP47FEB02_CHIP_INFO(mcp47feb02, 2, 8,  false, true);
+MCP47FEB02_CHIP_INFO(mcp47feb04, 4, 8,  true,  true);
+MCP47FEB02_CHIP_INFO(mcp47feb08, 8, 8,  true,  true);
+MCP47FEB02_CHIP_INFO(mcp47feb11, 1, 10, false, true);
+MCP47FEB02_CHIP_INFO(mcp47feb12, 2, 10, false, true);
+MCP47FEB02_CHIP_INFO(mcp47feb14, 4, 10, true,  true);
+MCP47FEB02_CHIP_INFO(mcp47feb18, 8, 10, true,  true);
+MCP47FEB02_CHIP_INFO(mcp47feb21, 1, 12, false, true);
+MCP47FEB02_CHIP_INFO(mcp47feb22, 2, 12, false, true);
+MCP47FEB02_CHIP_INFO(mcp47feb24, 4, 12, true,  true);
+MCP47FEB02_CHIP_INFO(mcp47feb28, 8, 12, true,  true);
+
+/* Parts without EEPROM memory */
+MCP47FEB02_CHIP_INFO(mcp47fvb01, 1, 8,  false, false);
+MCP47FEB02_CHIP_INFO(mcp47fvb02, 2, 8,  false, false);
+MCP47FEB02_CHIP_INFO(mcp47fvb04, 4, 8,  true,  false);
+MCP47FEB02_CHIP_INFO(mcp47fvb08, 8, 8,  true,  false);
+MCP47FEB02_CHIP_INFO(mcp47fvb11, 1, 10, false, false);
+MCP47FEB02_CHIP_INFO(mcp47fvb12, 2, 10, false, false);
+MCP47FEB02_CHIP_INFO(mcp47fvb14, 4, 10, true,  false);
+MCP47FEB02_CHIP_INFO(mcp47fvb18, 8, 10, true,  false);
+MCP47FEB02_CHIP_INFO(mcp47fvb21, 1, 12, false, false);
+MCP47FEB02_CHIP_INFO(mcp47fvb22, 2, 12, false, false);
+MCP47FEB02_CHIP_INFO(mcp47fvb24, 4, 12, true,  false);
+MCP47FEB02_CHIP_INFO(mcp47fvb28, 8, 12, true,  false);
+
+static int mcp47feb02_i2c_probe(struct i2c_client *client)
+{
+	const struct mcp47feb02_features *chip_features;
+	struct device *dev = &client->dev;
+	struct regmap *regmap;
+
+	chip_features = i2c_get_match_data(client);
+	if (!chip_features)
+		return dev_err_probe(dev, -ENODATA, "No match data found\n");
+
+	if (chip_features->have_eeprom)
+		regmap = devm_regmap_init_i2c(client, &mcp47feb02_regmap_config);
+	else
+		regmap = devm_regmap_init_i2c(client, &mcp47fvb02_regmap_config);
+
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap), "Error initializing I2C regmap\n");
+
+	return mcp47feb02_common_probe(chip_features, regmap);
+}
+
+static const struct i2c_device_id mcp47feb02_i2c_id[] = {
+	{ .name = "mcp47feb01", .driver_data = (kernel_ulong_t)&mcp47feb01_chip_features },
+	{ .name = "mcp47feb02", .driver_data = (kernel_ulong_t)&mcp47feb02_chip_features },
+	{ .name = "mcp47feb04", .driver_data = (kernel_ulong_t)&mcp47feb04_chip_features },
+	{ .name = "mcp47feb08", .driver_data = (kernel_ulong_t)&mcp47feb08_chip_features },
+	{ .name = "mcp47feb11", .driver_data = (kernel_ulong_t)&mcp47feb11_chip_features },
+	{ .name = "mcp47feb12", .driver_data = (kernel_ulong_t)&mcp47feb12_chip_features },
+	{ .name = "mcp47feb14", .driver_data = (kernel_ulong_t)&mcp47feb14_chip_features },
+	{ .name = "mcp47feb18", .driver_data = (kernel_ulong_t)&mcp47feb18_chip_features },
+	{ .name = "mcp47feb21", .driver_data = (kernel_ulong_t)&mcp47feb21_chip_features },
+	{ .name = "mcp47feb22", .driver_data = (kernel_ulong_t)&mcp47feb22_chip_features },
+	{ .name = "mcp47feb24", .driver_data = (kernel_ulong_t)&mcp47feb24_chip_features },
+	{ .name = "mcp47feb28", .driver_data = (kernel_ulong_t)&mcp47feb28_chip_features },
+	{ .name = "mcp47fvb01", .driver_data = (kernel_ulong_t)&mcp47fvb01_chip_features },
+	{ .name = "mcp47fvb02", .driver_data = (kernel_ulong_t)&mcp47fvb02_chip_features },
+	{ .name = "mcp47fvb04", .driver_data = (kernel_ulong_t)&mcp47fvb04_chip_features },
+	{ .name = "mcp47fvb08", .driver_data = (kernel_ulong_t)&mcp47fvb08_chip_features },
+	{ .name = "mcp47fvb11", .driver_data = (kernel_ulong_t)&mcp47fvb11_chip_features },
+	{ .name = "mcp47fvb12", .driver_data = (kernel_ulong_t)&mcp47fvb12_chip_features },
+	{ .name = "mcp47fvb14", .driver_data = (kernel_ulong_t)&mcp47fvb14_chip_features },
+	{ .name = "mcp47fvb18", .driver_data = (kernel_ulong_t)&mcp47fvb18_chip_features },
+	{ .name = "mcp47fvb21", .driver_data = (kernel_ulong_t)&mcp47fvb21_chip_features },
+	{ .name = "mcp47fvb22", .driver_data = (kernel_ulong_t)&mcp47fvb22_chip_features },
+	{ .name = "mcp47fvb24", .driver_data = (kernel_ulong_t)&mcp47fvb24_chip_features },
+	{ .name = "mcp47fvb28", .driver_data = (kernel_ulong_t)&mcp47fvb28_chip_features },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, mcp47feb02_i2c_id);
+
+static const struct of_device_id mcp47feb02_of_i2c_match[] = {
+	{ .compatible = "microchip,mcp47feb01", .data = &mcp47feb01_chip_features },
+	{ .compatible = "microchip,mcp47feb02", .data = &mcp47feb02_chip_features },
+	{ .compatible = "microchip,mcp47feb04", .data = &mcp47feb04_chip_features },
+	{ .compatible = "microchip,mcp47feb08", .data = &mcp47feb08_chip_features },
+	{ .compatible = "microchip,mcp47feb11", .data = &mcp47feb11_chip_features },
+	{ .compatible = "microchip,mcp47feb12", .data = &mcp47feb12_chip_features },
+	{ .compatible = "microchip,mcp47feb14", .data = &mcp47feb14_chip_features },
+	{ .compatible = "microchip,mcp47feb18", .data = &mcp47feb18_chip_features },
+	{ .compatible = "microchip,mcp47feb21", .data = &mcp47feb21_chip_features },
+	{ .compatible = "microchip,mcp47feb22", .data = &mcp47feb22_chip_features },
+	{ .compatible = "microchip,mcp47feb24", .data = &mcp47feb24_chip_features },
+	{ .compatible = "microchip,mcp47feb28", .data = &mcp47feb28_chip_features },
+	{ .compatible = "microchip,mcp47fvb01", .data = &mcp47fvb01_chip_features },
+	{ .compatible = "microchip,mcp47fvb02", .data = &mcp47fvb02_chip_features },
+	{ .compatible = "microchip,mcp47fvb04", .data = &mcp47fvb04_chip_features },
+	{ .compatible = "microchip,mcp47fvb08", .data = &mcp47fvb08_chip_features },
+	{ .compatible = "microchip,mcp47fvb11", .data = &mcp47fvb11_chip_features },
+	{ .compatible = "microchip,mcp47fvb12", .data = &mcp47fvb12_chip_features },
+	{ .compatible = "microchip,mcp47fvb14",	.data = &mcp47fvb14_chip_features },
+	{ .compatible = "microchip,mcp47fvb18", .data = &mcp47fvb18_chip_features },
+	{ .compatible = "microchip,mcp47fvb21", .data = &mcp47fvb21_chip_features },
+	{ .compatible = "microchip,mcp47fvb22", .data = &mcp47fvb22_chip_features },
+	{ .compatible = "microchip,mcp47fvb24", .data = &mcp47fvb24_chip_features },
+	{ .compatible = "microchip,mcp47fvb28", .data = &mcp47fvb28_chip_features },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, mcp47feb02_of_i2c_match);
+
+static struct i2c_driver mcp47feb02_i2c_driver = {
+	.driver = {
+		.name = "mcp47feb02",
+		.of_match_table = mcp47feb02_of_i2c_match,
+		.pm = pm_sleep_ptr(&mcp47feb02_pm_ops),
+	},
+	.probe = mcp47feb02_i2c_probe,
+	.id_table = mcp47feb02_i2c_id,
+};
+module_i2c_driver(mcp47feb02_i2c_driver);
+
+MODULE_AUTHOR("Ariana Lazar <ariana.lazar@microchip.com>");
+MODULE_DESCRIPTION("IIO driver for MCP47FEB02 Multi-Channel DAC with I2C interface");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_MCP47FEB02");
diff --git a/drivers/iio/dac/mcp47feb02.h b/drivers/iio/dac/mcp47feb02.h
new file mode 100644
index 0000000000000000000000000000000000000000..5bcce1f9ae112c4fecc930f9927442eb93832f20
--- /dev/null
+++ b/drivers/iio/dac/mcp47feb02.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+#ifndef __DRIVERS_IIO_DAC_MCP47FEB02_H__
+#define __DRIVERS_IIO_DAC_MCP47FEB02_H__
+
+#include <linux/pm.h>
+#include <linux/types.h>
+
+extern const char * const mcp47feb02_powerdown_modes[];
+
+#define MCP47FEB02_CHIP_INFO(_name, _channels, _res, _vref1, _eeprom) \
+static const struct mcp47feb02_features _name##_chip_features = { \
+	.name = #_name, \
+	.phys_channels = _channels, \
+	.resolution = _res, \
+	.have_ext_vref1 = _vref1, \
+	.have_eeprom = _eeprom, \
+}
+
+/**
+ * struct mcp47feb02_features - chip specific data
+ * @name: device name
+ * @phys_channels: number of hardware channels
+ * @resolution: DAC resolution
+ * @have_ext_vref1: does the hardware have an the second external voltage reference?
+ * @have_eeprom: does the hardware have an internal eeprom?
+ */
+struct mcp47feb02_features {
+	const char *name;
+	unsigned int phys_channels;
+	unsigned int resolution;
+	bool have_ext_vref1;
+	bool have_eeprom;
+};
+
+extern const struct regmap_config mcp47feb02_regmap_config;
+extern const struct regmap_config mcp47fvb02_regmap_config;
+
+int mcp47feb02_common_probe(const struct mcp47feb02_features *chip_features,
+			    struct regmap *regmap);
+
+extern const struct dev_pm_ops mcp47feb02_pm_ops;
+
+#endif /* __DRIVERS_IIO_DAC_MCP47FEB02_H__ */

-- 
2.43.0

