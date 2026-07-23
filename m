Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F83241D237;
	Thu, 23 Jul 2026 13:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784814212; cv=none; b=F3Blr8SVQgfPrTsKg0wNNimdHhbd7FgUTnEtvHkLYsN7yG0CQB6vCz2+DJL93gz1DBOaqRkIPzjzSKPRla/pM2hA9HLp9sTwDjEdRPdniwEgUG/UrgNMXQNOwPVHd8pRLjKQbEIqOQvkPrdy37IhhqSYwl/fQp4Lz4AKQ3nIi2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784814212; c=relaxed/simple;
	bh=Mhai/yJWlg46MESWfPRp6obiFFa/8GcRXHYra2YJRv0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=d1h8gWLeY2CuSdh9Ehj394PMmK8BXa7TdXdM5ldvUYHLKIUkO1QfwPZVtCudfV2chjBD9YYIe/0A5WZRPWPwrEv/geg6DwCLHIkUKcg6HanKjraqNQZkvkUPsnCnIB46xkkDbqqd6hB4OZrLtDRevFMEpSQY4cx8w2FTrr0lmhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=VFv1eaFY; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="VFv1eaFY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1784814208; x=1816350208;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Mhai/yJWlg46MESWfPRp6obiFFa/8GcRXHYra2YJRv0=;
  b=VFv1eaFYkB2TcQFIXiwWMwBKAguWCYco01D+8VgOCbMYgnAD/fpGP/7u
   8HBPJfw3n4x5kLd+Kt6uELaJh0SOt9VAsS7ZhFXKM491psrWnBojulkSG
   tbAjsCPrhvTDvSOyxX0d3Vxh5dAG1f5dc+5ZNwDV88TEqxH9fyLMpFzri
   jwr+zLaqGheaS5IoYgJLdzzy6IX9JMot2vRDVZfgFu8A6aQZbO2P+BoX/
   hL4dDqsRwT4NxrHsly/CtWH3Hy9pp8Fl1rOaKrThqmSAO4ZBb/FDhh7EZ
   /WpFEWf7CW4QeYb7wCdZdejv7LmU47x0hR3MSmV+pmOvX7U2IdgKTl6K0
   g==;
X-CSE-ConnectionGUID: CbaVrIJ+R2mp7lU6UtioWQ==
X-CSE-MsgGUID: eLejrbRnTMiAnDhN/xwoqA==
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="292445387"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 06:43:21 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.43; Thu, 23 Jul 2026 06:43:19 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Thu, 23 Jul 2026 06:43:16 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Thu, 23 Jul 2026 16:43:10 +0300
Subject: [PATCH 1/3] iio: dac: mcp47feb02: refactor MCP47FEB02 I2C driver
 into two modules
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260723-mcp47feb02_refactor-v1-1-ee59e63672bc@microchip.com>
References: <20260723-mcp47feb02_refactor-v1-0-ee59e63672bc@microchip.com>
In-Reply-To: <20260723-mcp47feb02_refactor-v1-0-ee59e63672bc@microchip.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Ariana Lazar <ariana.lazar@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784814192; l=34734;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=Mhai/yJWlg46MESWfPRp6obiFFa/8GcRXHYra2YJRv0=;
 b=Sb1QQc/DQn9wd6pjY+B76LeAAHW9xMWNJyvW53+JuVucnShP70/1bJvGNprfENdJcJ/15yXFB
 7NgdxVy04XMBrJ0Im247dGkqr1kOGKGdZYMTLjgdx1sA7ei61k8no93
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

Prepare the driver for the bus-specific code refactoring into
separate files. The renamed file will contain the common DAC functionality
shared by the MCP47FxBy1/2/4/8 I2C and MCP48FxBy1/2/4/8 SPI drivers. The
MCP47FEB02 driver was refactored into two modules: mcp47feb02-core.c
and mcp47feb02-i2c.c in order to prepare the support for SPI
MCP48FxBy1/2/4/8 DAC family on top of the current implementation.

Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
 MAINTAINERS                                        |   4 +-
 drivers/iio/dac/Kconfig                            |  10 +-
 drivers/iio/dac/Makefile                           |   3 +-
 .../iio/dac/{mcp47feb02.c => mcp47feb02-core.c}    | 414 +--------------------
 drivers/iio/dac/mcp47feb02-i2c.c                   | 145 ++++++++
 drivers/iio/dac/mcp47feb02.h                       | 153 ++++++++
 6 files changed, 325 insertions(+), 404 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6b4560681b51cfabf0b0e98fd89b69d8c527228b..fc87609865f26a9f484edc42058f7df659a0fa4f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16118,7 +16118,9 @@ M:	Ariana Lazar <ariana.lazar@microchip.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml
-F:	drivers/iio/dac/mcp47feb02.c
+F:	drivers/iio/dac/mcp47feb02-core.c
+F:	drivers/iio/dac/mcp47feb02-i2c.c
+F:	drivers/iio/dac/mcp47feb02.h
 
 MCP4821 DAC DRIVER
 M:	Anshul Dalal <anshulusr@gmail.com>
diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 657c68e75542e47ad5603165bcbc3660e90c6450..cc10d43ffd1e89bbf945ef89ea5af0abe1a91084 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -550,8 +550,13 @@ config MCP4728
 	  will be called mcp4728.
 
 config MCP47FEB02
-	tristate "MCP47F(E/V)B01/02/04/08/11/12/14/18/21/22/24/28 DAC driver"
+	tristate
+
+config MCP47FEB02_I2C
+	tristate "MCP47F(E/V)B01/02/04/08/11/12/14/18/21/22/24/28 I2C DAC driver"
 	depends on I2C
+	select REGMAP_I2C
+	select MCP47FEB02
 	help
 	  Say yes here if you want to build the driver for the Microchip:
 	  - 8-bit DAC:
@@ -567,7 +572,8 @@ config MCP47FEB02
 	  (DAC) with I2C interface.
 
 	  To compile this driver as a module, choose M here: the module
-	  will be called mcp47feb02.
+	  will be called mcp47feb02_i2c and you will also get
+	  mcp47feb02_core for the core module.
 
 config MCP4821
 	tristate "MCP4801/02/11/12/21/22 DAC driver"
diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index 0034317984985035f7987a744899924bfd4612e3..28c8646a987cff1ac4d693fe86898d66c901d5bd 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -54,7 +54,8 @@ obj-$(CONFIG_MAX5522) += max5522.o
 obj-$(CONFIG_MAX5821) += max5821.o
 obj-$(CONFIG_MCP4725) += mcp4725.o
 obj-$(CONFIG_MCP4728) += mcp4728.o
-obj-$(CONFIG_MCP47FEB02) += mcp47feb02.o
+obj-$(CONFIG_MCP47FEB02) += mcp47feb02-core.o
+obj-$(CONFIG_MCP47FEB02_I2C) += mcp47feb02-i2c.o
 obj-$(CONFIG_MCP4821) += mcp4821.o
 obj-$(CONFIG_MCP4922) += mcp4922.o
 obj-$(CONFIG_STM32_DAC_CORE) += stm32-dac-core.o
diff --git a/drivers/iio/dac/mcp47feb02.c b/drivers/iio/dac/mcp47feb02-core.c
similarity index 64%
rename from drivers/iio/dac/mcp47feb02.c
rename to drivers/iio/dac/mcp47feb02-core.c
index a823c2a673a26d70e5829cb587034da435af0451..6c86fa40e6eb2f1f602cac4c75265b6af7000c72 100644
--- a/drivers/iio/dac/mcp47feb02.c
+++ b/drivers/iio/dac/mcp47feb02-core.c
@@ -2,7 +2,7 @@
 /*
  * IIO driver for MCP47FEB02 Multi-Channel DAC with I2C interface
  *
- * Copyright (C) 2025 Microchip Technology Inc. and its subsidiaries
+ * Copyright (C) 2026 Microchip Technology Inc. and its subsidiaries
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
@@ -30,324 +29,14 @@
 #include <linux/types.h>
 #include <linux/units.h>
 
-/* Register addresses must be left shifted with 3 positions in order to append command mask */
-#define MCP47FEB02_DAC0_REG_ADDR			0x00
-#define MCP47FEB02_VREF_REG_ADDR			0x40
-#define MCP47FEB02_POWER_DOWN_REG_ADDR			0x48
-#define MCP47FEB02_DAC_CTRL_MASK			GENMASK(1, 0)
-
-#define MCP47FEB02_GAIN_CTRL_STATUS_REG_ADDR		0x50
-#define MCP47FEB02_GAIN_BIT_MASK			BIT(0)
-#define MCP47FEB02_GAIN_BIT_STATUS_EEWA_MASK		BIT(6)
-#define MCP47FEB02_GAIN_BITS_MASK			GENMASK(15, 8)
-
-#define MCP47FEB02_WIPERLOCK_STATUS_REG_ADDR		0x58
-
-#define MCP47FEB02_NV_DAC0_REG_ADDR			0x80
-#define MCP47FEB02_NV_VREF_REG_ADDR			0xC0
-#define MCP47FEB02_NV_POWER_DOWN_REG_ADDR		0xC8
-#define MCP47FEB02_NV_GAIN_CTRL_I2C_SLAVE_REG_ADDR	0xD0
-#define MCP47FEB02_NV_I2C_SLAVE_ADDR_MASK		GENMASK(7, 0)
-
-/* Voltage reference, Power-Down control register and DAC Wiperlock status register fields */
-#define DAC_CTRL_MASK(ch)				(GENMASK(1, 0) << (2 * (ch)))
-#define DAC_CTRL_VAL(ch, val)				((val) << (2 * (ch)))
-
-/* Gain Control and I2C Slave Address Reguster fields */
-#define DAC_GAIN_MASK(ch)				(BIT(0) << (8 + (ch)))
-#define DAC_GAIN_VAL(ch, val)				((val) << (8 + (ch)))
-
-#define REG_ADDR(reg)					((reg) << 3)
-#define NV_REG_ADDR(reg)				((NV_DAC_ADDR_OFFSET + (reg)) << 3)
-#define READFLAG_MASK					GENMASK(2, 1)
-
-#define MCP47FEB02_MAX_CH				8
-#define MCP47FEB02_MAX_SCALES_CH			3
-#define MCP47FEB02_DAC_WIPER_UNLOCKED			0
-#define MCP47FEB02_NORMAL_OPERATION			0
-#define MCP47FEB02_INTERNAL_BAND_GAP_uV			2440000
-#define NV_DAC_ADDR_OFFSET				0x10
-
-enum mcp47feb02_vref_mode {
-	MCP47FEB02_VREF_VDD = 0,
-	MCP47FEB02_INTERNAL_BAND_GAP = 1,
-	MCP47FEB02_EXTERNAL_VREF_UNBUFFERED = 2,
-	MCP47FEB02_EXTERNAL_VREF_BUFFERED = 3,
-};
-
-enum mcp47feb02_scale {
-	MCP47FEB02_SCALE_VDD = 0,
-	MCP47FEB02_SCALE_GAIN_X1 = 1,
-	MCP47FEB02_SCALE_GAIN_X2 = 2,
-};
-
-enum mcp47feb02_gain_bit_mode {
-	MCP47FEB02_GAIN_BIT_X1 = 0,
-	MCP47FEB02_GAIN_BIT_X2 = 1,
-};
+#include "mcp47feb02.h"
 
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
-/**
- * struct mcp47feb02_channel_data - channel configuration
- * @ref_mode: chosen voltage for reference
- * @use_2x_gain: output driver gain control
- * @powerdown: is false if the channel is in normal operation mode
- * @powerdown_mode: selected power-down mode
- * @dac_data: dac value
- */
-struct mcp47feb02_channel_data {
-	u8 ref_mode;
-	bool use_2x_gain;
-	bool powerdown;
-	u8 powerdown_mode;
-	u16 dac_data;
-};
-
-/**
- * struct mcp47feb02_data - chip configuration
- * @chdata: options configured for each channel on the device
- * @lock: prevents concurrent reads/writes to driver's state members
- * @chip_features: pointer to features struct
- * @scale_1: scales set on channels that are based on Vref1
- * @scale: scales set on channels that are based on Vref/Vref0
- * @active_channels_mask: enabled channels
- * @regmap: regmap for directly accessing device register
- * @labels: table with channels labels
- * @phys_channels: physical channels on the device
- * @vref1_buffered: Vref1 buffer is enabled
- * @vref_buffered: Vref/Vref0 buffer is enabled
- * @use_vref1: vref1-supply is defined
- * @use_vref: vref-supply is defined
- */
-struct mcp47feb02_data {
-	struct mcp47feb02_channel_data chdata[MCP47FEB02_MAX_CH];
-	struct mutex lock; /* prevents concurrent reads/writes to driver's state members */
-	const struct mcp47feb02_features *chip_features;
-	int scale_1[2 * MCP47FEB02_MAX_SCALES_CH];
-	int scale[2 * MCP47FEB02_MAX_SCALES_CH];
-	unsigned long active_channels_mask;
-	struct regmap *regmap;
-	const char *labels[MCP47FEB02_MAX_CH];
-	u16 phys_channels;
-	bool vref1_buffered;
-	bool vref_buffered;
-	bool use_vref1;
-	bool use_vref;
-};
-
 static const struct regmap_range mcp47feb02_readable_ranges[] = {
 	regmap_reg_range(MCP47FEB02_DAC0_REG_ADDR, MCP47FEB02_WIPERLOCK_STATUS_REG_ADDR),
 	regmap_reg_range(MCP47FEB02_NV_DAC0_REG_ADDR, MCP47FEB02_NV_GAIN_CTRL_I2C_SLAVE_REG_ADDR),
@@ -380,7 +69,7 @@ static const struct regmap_access_table mcp47feb02_volatile_table = {
 	.n_yes_ranges = ARRAY_SIZE(mcp47feb02_volatile_ranges),
 };
 
-static const struct regmap_config mcp47feb02_regmap_config = {
+const struct regmap_config mcp47feb02_regmap_config = {
 	.name = "mcp47feb02_regmap",
 	.reg_bits = 8,
 	.val_bits = 16,
@@ -392,6 +81,7 @@ static const struct regmap_config mcp47feb02_regmap_config = {
 	.cache_type = REGCACHE_MAPLE,
 	.val_format_endian = REGMAP_ENDIAN_BIG,
 };
+EXPORT_SYMBOL_NS_GPL(mcp47feb02_regmap_config, "IIO_MCP47FEB02");
 
 /* For devices that doesn't have nonvolatile memory */
 static const struct regmap_range mcp47fvb02_readable_ranges[] = {
@@ -422,7 +112,7 @@ static const struct regmap_access_table mcp47fvb02_volatile_table = {
 	.n_yes_ranges = ARRAY_SIZE(mcp47fvb02_volatile_ranges),
 };
 
-static const struct regmap_config mcp47fvb02_regmap_config = {
+const struct regmap_config mcp47fvb02_regmap_config = {
 	.name = "mcp47fvb02_regmap",
 	.reg_bits = 8,
 	.val_bits = 16,
@@ -434,6 +124,7 @@ static const struct regmap_config mcp47fvb02_regmap_config = {
 	.cache_type = REGCACHE_MAPLE,
 	.val_format_endian = REGMAP_ENDIAN_BIG,
 };
+EXPORT_SYMBOL_NS_GPL(mcp47fvb02_regmap_config, "IIO_MCP47FEB02");
 
 static int mcp47feb02_write_to_eeprom(struct mcp47feb02_data *data, unsigned int reg,
 				      unsigned int val)
@@ -666,7 +357,7 @@ static ssize_t mcp47feb02_write_powerdown(struct iio_dev *indio_dev, uintptr_t p
 	return len;
 }
 
-static DEFINE_SIMPLE_DEV_PM_OPS(mcp47feb02_pm_ops, mcp47feb02_suspend, mcp47feb02_resume);
+EXPORT_SIMPLE_DEV_PM_OPS(mcp47feb02_pm_ops, mcp47feb02_suspend, mcp47feb02_resume);
 
 static const struct iio_enum mcp47febxx_powerdown_mode_enum = {
 	.items = mcp47feb02_powerdown_modes,
@@ -1091,10 +782,9 @@ static int mcp47feb02_init_ch_scales(struct mcp47feb02_data *data, int vdd_uV,
 	return 0;
 }
 
-static int mcp47feb02_probe(struct i2c_client *client)
+int mcp47feb02_common_probe(const struct mcp47feb02_features *chip_features, struct regmap *regmap)
 {
-	const struct mcp47feb02_features *chip_features;
-	struct device *dev = &client->dev;
+	struct device *dev = regmap_get_device(regmap);
 	struct mcp47feb02_data *data;
 	struct iio_dev *indio_dev;
 	int vref1_uV, vref_uV, vdd_uV, ret;
@@ -1104,21 +794,13 @@ static int mcp47feb02_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	data = iio_priv(indio_dev);
-	chip_features = i2c_get_match_data(client);
-	if (!chip_features)
-		return -EINVAL;
-
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
 
@@ -1175,75 +857,7 @@ static int mcp47feb02_probe(struct i2c_client *client)
 
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
index 0000000000000000000000000000000000000000..808c51d0afdf564321abcd46a5a7d9595c5472da
--- /dev/null
+++ b/drivers/iio/dac/mcp47feb02-i2c.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * IIO driver for MCP47FEB02 Multi-Channel DAC with I2C interface
+ *
+ * Copyright (C) 2026 Microchip Technology Inc. and its subsidiaries
+ *
+ * Author: Ariana Lazar <ariana.lazar@microchip.com>
+ *
+ * Datasheet links for devices with I2C interface:
+ * [MCP47FEBxx] https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/20005375A.pdf
+ * [MCP47FVBxx] https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/20005405A.pdf
+ * [MCP47FxBx4/8] https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/MCP47FXBX48-Data-Sheet-DS200006368A.pdf
+ */
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/pm.h>
+#include <linux/regmap.h>
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
+		return -EINVAL;
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
+	{ "mcp47feb01", (kernel_ulong_t)&mcp47feb01_chip_features },
+	{ "mcp47feb02", (kernel_ulong_t)&mcp47feb02_chip_features },
+	{ "mcp47feb04", (kernel_ulong_t)&mcp47feb04_chip_features },
+	{ "mcp47feb08", (kernel_ulong_t)&mcp47feb08_chip_features },
+	{ "mcp47feb11", (kernel_ulong_t)&mcp47feb11_chip_features },
+	{ "mcp47feb12", (kernel_ulong_t)&mcp47feb12_chip_features },
+	{ "mcp47feb14", (kernel_ulong_t)&mcp47feb14_chip_features },
+	{ "mcp47feb18", (kernel_ulong_t)&mcp47feb18_chip_features },
+	{ "mcp47feb21", (kernel_ulong_t)&mcp47feb21_chip_features },
+	{ "mcp47feb22", (kernel_ulong_t)&mcp47feb22_chip_features },
+	{ "mcp47feb24", (kernel_ulong_t)&mcp47feb24_chip_features },
+	{ "mcp47feb28", (kernel_ulong_t)&mcp47feb28_chip_features },
+	{ "mcp47fvb01", (kernel_ulong_t)&mcp47fvb01_chip_features },
+	{ "mcp47fvb02", (kernel_ulong_t)&mcp47fvb02_chip_features },
+	{ "mcp47fvb04", (kernel_ulong_t)&mcp47fvb04_chip_features },
+	{ "mcp47fvb08", (kernel_ulong_t)&mcp47fvb08_chip_features },
+	{ "mcp47fvb11", (kernel_ulong_t)&mcp47fvb11_chip_features },
+	{ "mcp47fvb12", (kernel_ulong_t)&mcp47fvb12_chip_features },
+	{ "mcp47fvb14", (kernel_ulong_t)&mcp47fvb14_chip_features },
+	{ "mcp47fvb18", (kernel_ulong_t)&mcp47fvb18_chip_features },
+	{ "mcp47fvb21", (kernel_ulong_t)&mcp47fvb21_chip_features },
+	{ "mcp47fvb22", (kernel_ulong_t)&mcp47fvb22_chip_features },
+	{ "mcp47fvb24", (kernel_ulong_t)&mcp47fvb24_chip_features },
+	{ "mcp47fvb28", (kernel_ulong_t)&mcp47fvb28_chip_features },
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
index 0000000000000000000000000000000000000000..7dbf157d7d6dcfeda7e47141ad447dfa0a79fd51
--- /dev/null
+++ b/drivers/iio/dac/mcp47feb02.h
@@ -0,0 +1,153 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+#ifndef __DRIVERS_IIO_DAC_MCP47FEB02_H__
+#define __DRIVERS_IIO_DAC_MCP47FEB02_H__
+
+#include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+
+#include <linux/iio/iio.h>
+
+/* Register addresses must be left shifted with 3 positions in order to append command mask */
+#define MCP47FEB02_DAC0_REG_ADDR			0x00
+#define MCP47FEB02_VREF_REG_ADDR			0x40
+#define MCP47FEB02_POWER_DOWN_REG_ADDR			0x48
+#define MCP47FEB02_DAC_CTRL_MASK			GENMASK(1, 0)
+
+#define MCP47FEB02_GAIN_CTRL_STATUS_REG_ADDR		0x50
+#define MCP47FEB02_GAIN_BIT_MASK			BIT(0)
+#define MCP47FEB02_GAIN_BIT_STATUS_EEWA_MASK		BIT(6)
+#define MCP47FEB02_GAIN_BITS_MASK			GENMASK(15, 8)
+
+#define MCP47FEB02_WIPERLOCK_STATUS_REG_ADDR		0x58
+
+#define MCP47FEB02_NV_DAC0_REG_ADDR			0x80
+#define MCP47FEB02_NV_VREF_REG_ADDR			0xC0
+#define MCP47FEB02_NV_POWER_DOWN_REG_ADDR		0xC8
+#define MCP47FEB02_NV_GAIN_CTRL_I2C_SLAVE_REG_ADDR	0xD0
+#define MCP47FEB02_NV_I2C_SLAVE_ADDR_MASK		GENMASK(7, 0)
+
+/* Voltage reference, Power-Down control register and DAC Wiperlock status register fields */
+#define DAC_CTRL_MASK(ch)				(GENMASK(1, 0) << (2 * (ch)))
+#define DAC_CTRL_VAL(ch, val)				((val) << (2 * (ch)))
+
+/* Gain Control and I2C Slave Address Reguster fields */
+#define DAC_GAIN_MASK(ch)				(BIT(0) << (8 + (ch)))
+#define DAC_GAIN_VAL(ch, val)				((val) << (8 + (ch)))
+
+#define REG_ADDR(reg)					((reg) << 3)
+#define NV_REG_ADDR(reg)				((NV_DAC_ADDR_OFFSET + (reg)) << 3)
+#define READFLAG_MASK					GENMASK(2, 1)
+
+#define MCP47FEB02_MAX_CH				8
+#define MCP47FEB02_MAX_SCALES_CH			3
+#define MCP47FEB02_DAC_WIPER_UNLOCKED			0
+#define MCP47FEB02_NORMAL_OPERATION			0
+#define MCP47FEB02_INTERNAL_BAND_GAP_uV			2440000
+#define NV_DAC_ADDR_OFFSET				0x10
+
+/* Macro used for generating chip features structures */
+#define MCP47FEB02_CHIP_INFO(_name, _channels, _res, _vref1, _eeprom) \
+static const struct mcp47feb02_features _name##_chip_features = { \
+	.name = #_name, \
+	.phys_channels = _channels, \
+	.resolution = _res, \
+	.have_ext_vref1 = _vref1, \
+	.have_eeprom = _eeprom, \
+}
+
+enum mcp47feb02_vref_mode {
+	MCP47FEB02_VREF_VDD = 0,
+	MCP47FEB02_INTERNAL_BAND_GAP = 1,
+	MCP47FEB02_EXTERNAL_VREF_UNBUFFERED = 2,
+	MCP47FEB02_EXTERNAL_VREF_BUFFERED = 3,
+};
+
+enum mcp47feb02_scale {
+	MCP47FEB02_SCALE_VDD = 0,
+	MCP47FEB02_SCALE_GAIN_X1 = 1,
+	MCP47FEB02_SCALE_GAIN_X2 = 2,
+};
+
+enum mcp47feb02_gain_bit_mode {
+	MCP47FEB02_GAIN_BIT_X1 = 0,
+	MCP47FEB02_GAIN_BIT_X2 = 1,
+};
+
+extern const char * const mcp47feb02_powerdown_modes[];
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
+/**
+ * struct mcp47feb02_channel_data - channel configuration
+ * @ref_mode: chosen voltage for reference
+ * @use_2x_gain: output driver gain control
+ * @powerdown: is false if the channel is in normal operation mode
+ * @powerdown_mode: selected power-down mode
+ * @dac_data: dac value
+ */
+struct mcp47feb02_channel_data {
+	u8 ref_mode;
+	bool use_2x_gain;
+	bool powerdown;
+	u8 powerdown_mode;
+	u16 dac_data;
+};
+
+/**
+ * struct mcp47feb02_data - chip configuration
+ * @chdata: options configured for each channel on the device
+ * @lock: prevents concurrent reads/writes to driver's state members
+ * @chip_features: pointer to features struct
+ * @scale_1: scales set on channels that are based on Vref1
+ * @scale: scales set on channels that are based on Vref/Vref0
+ * @active_channels_mask: enabled channels
+ * @regmap: regmap for directly accessing device register
+ * @labels: table with channels labels
+ * @phys_channels: physical channels on the device
+ * @vref1_buffered: Vref1 buffer is enabled
+ * @vref_buffered: Vref/Vref0 buffer is enabled
+ * @use_vref1: vref1-supply is defined
+ * @use_vref: vref-supply is defined
+ */
+struct mcp47feb02_data {
+	struct mcp47feb02_channel_data chdata[MCP47FEB02_MAX_CH];
+	struct mutex lock; /* prevents concurrent reads/writes to driver's state members */
+	const struct mcp47feb02_features *chip_features;
+	int scale_1[2 * MCP47FEB02_MAX_SCALES_CH];
+	int scale[2 * MCP47FEB02_MAX_SCALES_CH];
+	unsigned long active_channels_mask;
+	struct regmap *regmap;
+	const char *labels[MCP47FEB02_MAX_CH];
+	u16 phys_channels;
+	bool vref1_buffered;
+	bool vref_buffered;
+	bool use_vref1;
+	bool use_vref;
+};
+
+extern const struct regmap_config mcp47feb02_regmap_config;
+extern const struct regmap_config mcp47fvb02_regmap_config;
+
+/* Properties shared by I2C and SPI families */
+int mcp47feb02_common_probe(const struct mcp47feb02_features *chip_features, struct regmap *regmap);
+
+extern const struct dev_pm_ops mcp47feb02_pm_ops;
+
+#endif /* __DRIVERS_IIO_DAC_MCP47FEB02_H__ */
+

-- 
2.43.0

