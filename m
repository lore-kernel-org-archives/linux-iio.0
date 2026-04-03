Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D3833F8C1;
	Fri,  3 Apr 2026 10:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775213469; cv=none; b=nL7cR64Wqv9AJ3QBRQcvx7Fma0a0/O03eCfxVGuvetfyzE7mZTUB7aCxMUn8syiDxzbxLEe0uEmrkp/RVFSS2VpGUEBN/k04JcNqSX91eMZntwFEKHPAEDpfFGEiLfQeWeRKfK/sgJGiYy7vd6m5DUrA5A2ryfqNC94tzRhKCZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775213469; c=relaxed/simple;
	bh=Z4sCw/tXCwUCpxM3lMTl5uhv1+oiMgAILF99F59ctuM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=mz+amoyvaCRhooUd6nvrM0Ox8uYxWZYlRuUI8VHswY62pzIHfHWkewfEQpPbWFII+KC8qkIjZD4IvzpAKXIBRtD2uAUYpoGe1uNMvcs7ucH09zOX8edwhQgka8+UarN5V9yoSNc/nsFO5Ww+FvXtZR46RfzNcOH6QTGEg6Lr1PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=mckPh+8+; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="mckPh+8+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1775213465; x=1806749465;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Z4sCw/tXCwUCpxM3lMTl5uhv1+oiMgAILF99F59ctuM=;
  b=mckPh+8+eH1FdSi5ZJ6P5gdsuWc7BTFGKS5WkttyIgioMI+T5UtpOAS2
   mYGe/fFpmXEztb1X4WA4y73eBrTb9hSv7r9AjNcc5eibH1dLiyDb7GoSI
   GELS26EeZ6PrLhce8733K3NoMQi5jfRyHV7xuuDVCGQUcaURafd6FxIz+
   L0x+x8DPQpxch7dnCMiSf6cdLG7wBwLEXRkFhsjeXcPejTqqIN2jLD8+U
   IZ7cTGxWNV8OGN9ldpIh6tDLFY/8AZgsUsgtqOEfB94HsMrU0u7vb/VUQ
   hZPcKw26TCMmKXXkG3zo1Zl/17DXhYgaEvz3neF8LkuHkiGO5sqhS9upV
   Q==;
X-CSE-ConnectionGUID: +J8K7zl5QKSgnEPocQxErg==
X-CSE-MsgGUID: fmO3P+f4RJKmSVtSIlg6IA==
X-IronPort-AV: E=Sophos;i="6.23,157,1770620400"; 
   d="scan'208";a="287003119"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Apr 2026 03:51:04 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 3 Apr 2026 03:50:26 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 3 Apr 2026 03:50:23 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Fri, 3 Apr 2026 13:50:14 +0300
Subject: [PATCH 2/2] iio: dac: mcp47feb02: add MCP48FEB02 SPI driver to
 MCP47FEB02 I2C driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260403-mcp47feb02-fix2-v1-2-da60c773550e@microchip.com>
References: <20260403-mcp47feb02-fix2-v1-0-da60c773550e@microchip.com>
In-Reply-To: <20260403-mcp47feb02-fix2-v1-0-da60c773550e@microchip.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Conor Dooley
	<conor.dooley@microchip.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Ariana Lazar
	<ariana.lazar@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775213414; l=52331;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=Z4sCw/tXCwUCpxM3lMTl5uhv1+oiMgAILF99F59ctuM=;
 b=rtaXT3zbbZBtdXvrYp3jellaIDmenTLX70ZdXUbyB+c1YfbKdRugEqWvFM1YrZb+Hv1Pp6iW/
 WkY3eYVZ6OQBiufuIyPVDfr+WT28D7BzhpBmkaQDp5FXOkJ3P1a38Y3
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

This is the iio driver for Microchip MCP48FxBy1/2/4/8 series of
buffered voltage output Digital-to-Analog Converters with nonvolatile or
volatile memory on top of MCP47FEB02. The families support up to 8
output channels and have 8-bit, 10-bit or 12-bit resolution.

The MCP47FEB02 driver was split into three modules: mcp47feb02-core.c,
mcp47feb02-i2c.c and mcp47feb02-spi.c in order to support both DAC families
- I2C (MCP47F(E/V)BXX) and SPI (MCP48F(E/V)BXX).

Fixes: bf394cc80369 ("iio: dac: adding support for Microchip MCP47FEB02")
Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
Link: https://lore.kernel.org/all/aY4yaVP2TQFRI1E4@smile.fi.intel.com/
---
 MAINTAINERS                       |   4 +
 drivers/iio/dac/Kconfig           |  29 +-
 drivers/iio/dac/Makefile          |   3 +
 drivers/iio/dac/mcp47feb02-core.c | 845 ++++++++++++++++++++++++++++++++++++++
 drivers/iio/dac/mcp47feb02-i2c.c  | 145 +++++++
 drivers/iio/dac/mcp47feb02-spi.c  | 145 +++++++
 drivers/iio/dac/mcp47feb02.h      | 158 +++++++
 7 files changed, 1328 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5997cf04b0732beaf69ac78cb762c42c56e4fcd6..af747c5449681807d3d74014dc11dffea5acc012 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15850,6 +15850,10 @@ M:	Ariana Lazar <ariana.lazar@microchip.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml
+F:	drivers/iio/dac/mcp47feb02-core.c
+F:	drivers/iio/dac/mcp47feb02-i2c.c
+F:	drivers/iio/dac/mcp47feb02-spi.c
+F:	drivers/iio/dac/mcp47feb02.h
 
 MCP4821 DAC DRIVER
 M:	Anshul Dalal <anshulusr@gmail.com>
diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index cd4870b654153e91c3c44860be43d231ee3b5519..5bec52552d263532ffe357666a64a1c6bb968d85 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -539,8 +539,12 @@ config MCP4728
 	  will be called mcp4728.
 
 config MCP47FEB02
+	tristate
+
+config MCP47FEB02_I2C
 	tristate "MCP47F(E/V)B01/02/04/08/11/12/14/18/21/22/24/28 DAC driver"
 	depends on I2C
+	select MCP47FEB02
 	help
 	  Say yes here if you want to build the driver for the Microchip:
 	  - 8-bit DAC:
@@ -556,7 +560,30 @@ config MCP47FEB02
 	  (DAC) with I2C interface.
 
 	  To compile this driver as a module, choose M here: the module
-	  will be called mcp47feb02.
+	  will be called mcp47feb02_i2c and you will also get
+	  mcp47feb02_core for the core module.
+
+config MCP47FEB02_SPI
+	tristate "MCP48F(E/V)B01/02/04/08/11/12/14/18/21/22/24/28 DAC driver"
+	depends on SPI
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
 
 config MCP4821
 	tristate "MCP4801/02/11/12/21/22 DAC driver"
diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index 2a80bbf4e80ad557da79ed916027cedff286984b..d2a2279b15499e1b43ed0e3e1f180b5b1ff72785 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -54,6 +54,9 @@ obj-$(CONFIG_MAX5821) += max5821.o
 obj-$(CONFIG_MCP4725) += mcp4725.o
 obj-$(CONFIG_MCP4728) += mcp4728.o
 obj-$(CONFIG_MCP47FEB02) += mcp47feb02.o
+mcp47feb02-objs := mcp47feb02-core.o
+obj-$(CONFIG_MCP47FEB02_I2C) += mcp47feb02-i2c.o
+obj-$(CONFIG_MCP47FEB02_SPI) += mcp47feb02-spi.o
 obj-$(CONFIG_MCP4821) += mcp4821.o
 obj-$(CONFIG_MCP4922) += mcp4922.o
 obj-$(CONFIG_STM32_DAC_CORE) += stm32-dac-core.o
diff --git a/drivers/iio/dac/mcp47feb02-core.c b/drivers/iio/dac/mcp47feb02-core.c
new file mode 100644
index 0000000000000000000000000000000000000000..728da45c27beb3f523f5ae7b63eae57ab18c6492
--- /dev/null
+++ b/drivers/iio/dac/mcp47feb02-core.c
@@ -0,0 +1,845 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * IIO driver for MCP47FEB02 Multi-Channel DAC with I2C or SPI interface
+ *
+ * Copyright (C) 2026 Microchip Technology Inc. and its subsidiaries
+ *
+ * Author: Ariana Lazar <ariana.lazar@microchip.com>
+ *
+ * Datasheet links for devices with I2C interface:
+ * [MCP47FEBxx] https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/20005375A.pdf
+ * [MCP47FVBxx] https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/20005405A.pdf
+ * [MCP47FxBx4/8] https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/MCP47FXBX48-Data-Sheet-DS200006368A.pdf
+ *
+ * Datasheet links for devices with SPI interface:
+ * [MCP48FEBxx] https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/20005429B.pdf
+ * [MCP48FVBxx] https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/20005466A.pdf
+ * [MCP48FxBx4/8] https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/MCP48FXBX4-8-Family-Data-Sheet-DS20006362A.pdf
+ */
+#include <linux/array_size.h>
+#include <linux/bitops.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/device.h>
+#include <linux/export.h>
+#include <linux/kstrtox.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/time64.h>
+#include <linux/types.h>
+#include <linux/units.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+#include "mcp47feb02.h"
+
+const char * const mcp47feb02_powerdown_modes[] = {
+	"1kohm_to_gnd",
+	"100kohm_to_gnd",
+	"open_circuit",
+};
+
+static const struct regmap_range mcp47feb02_readable_ranges[] = {
+	regmap_reg_range(MCP47FEB02_DAC0_REG_ADDR, MCP47FEB02_WIPERLOCK_STATUS_REG_ADDR),
+	regmap_reg_range(MCP47FEB02_NV_DAC0_REG_ADDR, MCP47FEB02_NV_GAIN_CTRL_I2C_SLAVE_REG_ADDR),
+};
+
+static const struct regmap_range mcp47feb02_writable_ranges[] = {
+	regmap_reg_range(MCP47FEB02_DAC0_REG_ADDR, MCP47FEB02_WIPERLOCK_STATUS_REG_ADDR),
+	regmap_reg_range(MCP47FEB02_NV_DAC0_REG_ADDR, MCP47FEB02_NV_GAIN_CTRL_I2C_SLAVE_REG_ADDR),
+};
+
+static const struct regmap_range mcp47feb02_volatile_ranges[] = {
+	regmap_reg_range(MCP47FEB02_DAC0_REG_ADDR, MCP47FEB02_WIPERLOCK_STATUS_REG_ADDR),
+	regmap_reg_range(MCP47FEB02_NV_DAC0_REG_ADDR, MCP47FEB02_NV_GAIN_CTRL_I2C_SLAVE_REG_ADDR),
+	regmap_reg_range(MCP47FEB02_DAC0_REG_ADDR, MCP47FEB02_WIPERLOCK_STATUS_REG_ADDR),
+	regmap_reg_range(MCP47FEB02_NV_DAC0_REG_ADDR, MCP47FEB02_NV_GAIN_CTRL_I2C_SLAVE_REG_ADDR),
+};
+
+static const struct regmap_access_table mcp47feb02_readable_table = {
+	.yes_ranges = mcp47feb02_readable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(mcp47feb02_readable_ranges),
+};
+
+static const struct regmap_access_table mcp47feb02_writable_table = {
+	.yes_ranges = mcp47feb02_writable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(mcp47feb02_writable_ranges),
+};
+
+static const struct regmap_access_table mcp47feb02_volatile_table = {
+	.yes_ranges = mcp47feb02_volatile_ranges,
+	.n_yes_ranges = ARRAY_SIZE(mcp47feb02_volatile_ranges),
+};
+
+const struct regmap_config mcp47feb02_regmap_config = {
+	.name = "mcp47feb02_regmap",
+	.reg_bits = 8,
+	.val_bits = 16,
+	.rd_table = &mcp47feb02_readable_table,
+	.wr_table = &mcp47feb02_writable_table,
+	.volatile_table = &mcp47feb02_volatile_table,
+	.max_register = MCP47FEB02_NV_GAIN_CTRL_I2C_SLAVE_REG_ADDR,
+	.read_flag_mask = READFLAG_MASK,
+	.cache_type = REGCACHE_MAPLE,
+	.val_format_endian = REGMAP_ENDIAN_BIG,
+};
+EXPORT_SYMBOL_NS_GPL(mcp47feb02_regmap_config, "IIO_MCP47FEB02");
+
+/* For devices that doesn't have nonvolatile memory */
+static const struct regmap_range mcp47fvb02_readable_ranges[] = {
+	regmap_reg_range(MCP47FEB02_DAC0_REG_ADDR, MCP47FEB02_WIPERLOCK_STATUS_REG_ADDR),
+};
+
+static const struct regmap_range mcp47fvb02_writable_ranges[] = {
+	regmap_reg_range(MCP47FEB02_DAC0_REG_ADDR, MCP47FEB02_WIPERLOCK_STATUS_REG_ADDR),
+};
+
+static const struct regmap_range mcp47fvb02_volatile_ranges[] = {
+	regmap_reg_range(MCP47FEB02_DAC0_REG_ADDR, MCP47FEB02_WIPERLOCK_STATUS_REG_ADDR),
+	regmap_reg_range(MCP47FEB02_DAC0_REG_ADDR, MCP47FEB02_WIPERLOCK_STATUS_REG_ADDR),
+};
+
+static const struct regmap_access_table mcp47fvb02_readable_table = {
+	.yes_ranges = mcp47fvb02_readable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(mcp47fvb02_readable_ranges),
+};
+
+static const struct regmap_access_table mcp47fvb02_writable_table = {
+	.yes_ranges = mcp47fvb02_writable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(mcp47fvb02_writable_ranges),
+};
+
+static const struct regmap_access_table mcp47fvb02_volatile_table = {
+	.yes_ranges = mcp47fvb02_volatile_ranges,
+	.n_yes_ranges = ARRAY_SIZE(mcp47fvb02_volatile_ranges),
+};
+
+const struct regmap_config mcp47fvb02_regmap_config = {
+	.name = "mcp47fvb02_regmap",
+	.reg_bits = 8,
+	.val_bits = 16,
+	.rd_table = &mcp47fvb02_readable_table,
+	.wr_table = &mcp47fvb02_writable_table,
+	.volatile_table = &mcp47fvb02_volatile_table,
+	.max_register = MCP47FEB02_WIPERLOCK_STATUS_REG_ADDR,
+	.read_flag_mask = READFLAG_MASK,
+	.cache_type = REGCACHE_MAPLE,
+	.val_format_endian = REGMAP_ENDIAN_BIG,
+};
+EXPORT_SYMBOL_NS_GPL(mcp47fvb02_regmap_config, "IIO_MCP47FEB02");
+
+static int mcp47feb02_write_to_eeprom(struct mcp47feb02_data *data, unsigned int reg,
+				      unsigned int val)
+{
+	unsigned int eewa_val;
+	int ret;
+
+	ret = regmap_read_poll_timeout(data->regmap, MCP47FEB02_GAIN_CTRL_STATUS_REG_ADDR,
+				       eewa_val,
+				       !(eewa_val & MCP47FEB02_GAIN_BIT_STATUS_EEWA_MASK),
+				       1 * USEC_PER_MSEC, 5 * USEC_PER_MSEC);
+	if (ret)
+		return ret;
+
+	return regmap_write(data->regmap, reg, val);
+}
+
+static ssize_t store_eeprom_store(struct device *dev, struct device_attribute *attr,
+				  const char *buf, size_t len)
+{
+	struct mcp47feb02_data *data = iio_priv(dev_to_iio_dev(dev));
+	unsigned int i, val, val1, eewa_val;
+	bool state;
+	int ret;
+
+	ret = kstrtobool(buf, &state);
+	if (ret)
+		return ret;
+
+	if (!state)
+		return 0;
+
+	/*
+	 * Wait until the currently occurring EEPROM Write Cycle is completed.
+	 * Only serial commands to the volatile memory are allowed.
+	 */
+	guard(mutex)(&data->lock);
+
+	/*
+	 * Verify DAC Wiper and DAC Configuration are unlocked. If both are disabled,
+	 * writing to EEPROM is available.
+	 */
+	ret = regmap_read(data->regmap, MCP47FEB02_WIPERLOCK_STATUS_REG_ADDR, &val);
+	if (ret)
+		return ret;
+
+	if (val) {
+		dev_err(dev, "DAC Wiper and DAC Configuration are not unlocked\n");
+		return -EINVAL;
+	}
+
+	for_each_set_bit(i, &data->active_channels_mask, data->phys_channels) {
+		ret = mcp47feb02_write_to_eeprom(data, NV_REG_ADDR(i),
+						 data->chdata[i].dac_data);
+		if (ret)
+			return ret;
+	}
+
+	ret = regmap_read(data->regmap, MCP47FEB02_VREF_REG_ADDR, &val);
+	if (ret)
+		return ret;
+
+	ret = mcp47feb02_write_to_eeprom(data, MCP47FEB02_NV_VREF_REG_ADDR, val);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(data->regmap, MCP47FEB02_POWER_DOWN_REG_ADDR, &val);
+	if (ret)
+		return ret;
+
+	ret = mcp47feb02_write_to_eeprom(data, MCP47FEB02_NV_POWER_DOWN_REG_ADDR, val);
+	if (ret)
+		return ret;
+
+	ret = regmap_read_poll_timeout(data->regmap, MCP47FEB02_GAIN_CTRL_STATUS_REG_ADDR, eewa_val,
+				       !(eewa_val & MCP47FEB02_GAIN_BIT_STATUS_EEWA_MASK),
+				       USEC_PER_MSEC, USEC_PER_MSEC * 5);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(data->regmap, MCP47FEB02_NV_GAIN_CTRL_I2C_SLAVE_REG_ADDR, &val);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(data->regmap, MCP47FEB02_GAIN_CTRL_STATUS_REG_ADDR, &val1);
+	if (ret)
+		return ret;
+
+	ret = mcp47feb02_write_to_eeprom(data, MCP47FEB02_NV_GAIN_CTRL_I2C_SLAVE_REG_ADDR,
+					 (val1 & MCP47FEB02_GAIN_BITS_MASK) |
+					 (val & MCP47FEB02_NV_I2C_SLAVE_ADDR_MASK));
+	if (ret)
+		return ret;
+
+	return len;
+}
+static IIO_DEVICE_ATTR_WO(store_eeprom, 0);
+
+static struct attribute *mcp47feb02_attributes[] = {
+	&iio_dev_attr_store_eeprom.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group mcp47feb02_attribute_group = {
+	.attrs = mcp47feb02_attributes,
+};
+
+static int mcp47feb02_suspend(struct device *dev)
+{
+	struct mcp47feb02_data *data = iio_priv(dev_get_drvdata(dev));
+	int ret;
+	u8 ch;
+
+	guard(mutex)(&data->lock);
+
+	for_each_set_bit(ch, &data->active_channels_mask, data->phys_channels) {
+		u8 pd_mode;
+
+		data->chdata[ch].powerdown = true;
+		pd_mode = data->chdata[ch].powerdown_mode + 1;
+		ret = regmap_update_bits(data->regmap, MCP47FEB02_POWER_DOWN_REG_ADDR,
+					 DAC_CTRL_MASK(ch), DAC_CTRL_VAL(ch, pd_mode));
+		if (ret)
+			return ret;
+
+		ret = regmap_write(data->regmap, REG_ADDR(ch), data->chdata[ch].dac_data);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int mcp47feb02_resume(struct device *dev)
+{
+	struct mcp47feb02_data *data = iio_priv(dev_get_drvdata(dev));
+	u8 ch;
+
+	guard(mutex)(&data->lock);
+
+	for_each_set_bit(ch, &data->active_channels_mask, data->phys_channels) {
+		int ret;
+
+		data->chdata[ch].powerdown = false;
+
+		ret = regmap_write(data->regmap, REG_ADDR(ch), data->chdata[ch].dac_data);
+		if (ret)
+			return ret;
+
+		ret = regmap_update_bits(data->regmap, MCP47FEB02_VREF_REG_ADDR,
+					 DAC_CTRL_MASK(ch),
+					 DAC_CTRL_VAL(ch, data->chdata[ch].ref_mode));
+		if (ret)
+			return ret;
+
+		ret = regmap_update_bits(data->regmap, MCP47FEB02_GAIN_CTRL_STATUS_REG_ADDR,
+					 DAC_GAIN_MASK(ch),
+					 DAC_GAIN_VAL(ch, data->chdata[ch].use_2x_gain));
+		if (ret)
+			return ret;
+
+		ret = regmap_update_bits(data->regmap, MCP47FEB02_POWER_DOWN_REG_ADDR,
+					 DAC_CTRL_MASK(ch),
+					 DAC_CTRL_VAL(ch, MCP47FEB02_NORMAL_OPERATION));
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int mcp47feb02_get_powerdown_mode(struct iio_dev *indio_dev,
+					 const struct iio_chan_spec *chan)
+{
+	struct mcp47feb02_data *data = iio_priv(indio_dev);
+
+	return data->chdata[chan->address].powerdown_mode;
+}
+
+static int mcp47feb02_set_powerdown_mode(struct iio_dev *indio_dev, const struct iio_chan_spec *ch,
+					 unsigned int mode)
+{
+	struct mcp47feb02_data *data = iio_priv(indio_dev);
+
+	data->chdata[ch->address].powerdown_mode = mode;
+
+	return 0;
+}
+
+static ssize_t mcp47feb02_read_powerdown(struct iio_dev *indio_dev, uintptr_t private,
+					 const struct iio_chan_spec *ch, char *buf)
+{
+	struct mcp47feb02_data *data = iio_priv(indio_dev);
+
+	/* Print if channel is in a power-down mode or not */
+	return sysfs_emit(buf, "%d\n", data->chdata[ch->address].powerdown);
+}
+
+static ssize_t mcp47feb02_write_powerdown(struct iio_dev *indio_dev, uintptr_t private,
+					  const struct iio_chan_spec *ch, const char *buf,
+					  size_t len)
+{
+	struct mcp47feb02_data *data = iio_priv(indio_dev);
+	u32 reg = ch->address;
+	u8 tmp_pd_mode;
+	bool state;
+	int ret;
+
+	guard(mutex)(&data->lock);
+
+	ret = kstrtobool(buf, &state);
+	if (ret)
+		return ret;
+
+	/*
+	 * Set the channel to the specified power-down mode. Exiting power-down mode
+	 * requires writing normal operation mode (0) to the channel-specific register bits.
+	 */
+	tmp_pd_mode = state ? (data->chdata[reg].powerdown_mode + 1) : MCP47FEB02_NORMAL_OPERATION;
+	ret = regmap_update_bits(data->regmap, MCP47FEB02_POWER_DOWN_REG_ADDR,
+				 DAC_CTRL_MASK(reg), DAC_CTRL_VAL(reg, tmp_pd_mode));
+	if (ret)
+		return ret;
+
+	data->chdata[reg].powerdown = state;
+
+	return len;
+}
+
+EXPORT_SIMPLE_DEV_PM_OPS(mcp47feb02_pm_ops, mcp47feb02_suspend, mcp47feb02_resume);
+
+static const struct iio_enum mcp47febxx_powerdown_mode_enum = {
+	.items = mcp47feb02_powerdown_modes,
+	.num_items = ARRAY_SIZE(mcp47feb02_powerdown_modes),
+	.get = mcp47feb02_get_powerdown_mode,
+	.set = mcp47feb02_set_powerdown_mode,
+};
+
+static const struct iio_chan_spec_ext_info mcp47feb02_ext_info[] = {
+	{
+		.name = "powerdown",
+		.read = mcp47feb02_read_powerdown,
+		.write = mcp47feb02_write_powerdown,
+		.shared = IIO_SEPARATE,
+	},
+	IIO_ENUM("powerdown_mode", IIO_SEPARATE, &mcp47febxx_powerdown_mode_enum),
+	IIO_ENUM_AVAILABLE("powerdown_mode", IIO_SHARED_BY_TYPE, &mcp47febxx_powerdown_mode_enum),
+	{ }
+};
+
+static const struct iio_chan_spec mcp47febxx_ch_template = {
+	.type = IIO_VOLTAGE,
+	.output = 1,
+	.indexed = 1,
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+	.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),
+	.ext_info = mcp47feb02_ext_info,
+};
+
+static void mcp47feb02_init_scale(struct mcp47feb02_data *data, enum mcp47feb02_scale scale,
+				  int vref_uV, int scale_avail[])
+{
+	u32 tmp;
+
+	/*
+	 * Avoid expensive 64-bit division.
+	 */
+	tmp = (vref_uV * (MILLI / 8)) >> (data->chip_features->resolution - 3);
+	scale_avail[scale * 2] = tmp / MICRO;
+	scale_avail[scale * 2 + 1] = tmp % MICRO;
+}
+
+static int mcp47feb02_init_scales_avail(struct mcp47feb02_data *data, int vdd_uV,
+					int vref_uV, int vref1_uV)
+{
+	int tmp_vref;
+
+	mcp47feb02_init_scale(data, MCP47FEB02_SCALE_VDD, vdd_uV, data->scale_0);
+
+	tmp_vref = data->use_vref ? vref_uV : MCP47FEB02_INTERNAL_BAND_GAP_uV;
+	mcp47feb02_init_scale(data, MCP47FEB02_SCALE_GAIN_X1, tmp_vref, data->scale_0);
+	mcp47feb02_init_scale(data, MCP47FEB02_SCALE_GAIN_X2, tmp_vref * 2, data->scale_0);
+
+	if (data->phys_channels >= 4) {
+		mcp47feb02_init_scale(data, MCP47FEB02_SCALE_VDD, vdd_uV, data->scale_1);
+		tmp_vref = data->use_vref1 ? vref1_uV : MCP47FEB02_INTERNAL_BAND_GAP_uV;
+
+		mcp47feb02_init_scale(data, MCP47FEB02_SCALE_GAIN_X1,
+				      tmp_vref, data->scale_1);
+		mcp47feb02_init_scale(data, MCP47FEB02_SCALE_GAIN_X2,
+				      tmp_vref * 2, data->scale_1);
+	}
+
+	return 0;
+}
+
+static int mcp47feb02_read_avail(struct iio_dev *indio_dev, struct iio_chan_spec const *ch,
+				 const int **vals, int *type, int *length, long info)
+{
+	struct mcp47feb02_data *data = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_CHAN_INFO_SCALE:
+		switch (ch->type) {
+		case IIO_VOLTAGE:
+			*vals = data->chdata[ch->address].scale_avail;
+			*length = 2 * MCP47FEB02_MAX_SCALES_CH;
+			*type = IIO_VAL_INT_PLUS_MICRO;
+			return IIO_AVAIL_LIST;
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static void mcp47feb02_get_scale(int ch, struct mcp47feb02_data *data, int *val, int *val2)
+{
+	enum mcp47feb02_scale current_scale;
+	int *scale;
+
+	if (data->chdata[ch].ref_mode == MCP47FEB02_VREF_VDD)
+		current_scale = MCP47FEB02_SCALE_VDD;
+	else if (data->chdata[ch].use_2x_gain)
+		current_scale = MCP47FEB02_SCALE_GAIN_X2;
+	else
+		current_scale = MCP47FEB02_SCALE_GAIN_X1;
+
+	scale = data->chdata[ch].scale_avail;
+	*val = scale[current_scale * 2];
+	*val2 = scale[current_scale * 2 + 1];
+}
+
+static int mcp47feb02_check_scale(struct mcp47feb02_data *data, int val, int val2, int scale[])
+{
+	unsigned int i;
+
+	for (i = 0; i < MCP47FEB02_MAX_SCALES_CH; i++) {
+		if (scale[i * 2] == val && scale[i * 2 + 1] == val2)
+			return i;
+	}
+
+	return -EINVAL;
+}
+
+static int mcp47feb02_ch_scale(struct mcp47feb02_data *data, int ch, int scale)
+{
+	int tmp_val, ret;
+
+	if (scale == MCP47FEB02_SCALE_VDD) {
+		tmp_val = MCP47FEB02_VREF_VDD;
+	} else if (data->phys_channels >= 4 && (ch % 2)) {
+		if (data->use_vref1) {
+			if (data->vref1_buffered)
+				tmp_val = MCP47FEB02_EXTERNAL_VREF_BUFFERED;
+			else
+				tmp_val = MCP47FEB02_EXTERNAL_VREF_UNBUFFERED;
+		} else {
+			tmp_val = MCP47FEB02_INTERNAL_BAND_GAP;
+		}
+	} else if (data->use_vref) {
+		if (data->vref_buffered)
+			tmp_val = MCP47FEB02_EXTERNAL_VREF_BUFFERED;
+		else
+			tmp_val = MCP47FEB02_EXTERNAL_VREF_UNBUFFERED;
+	} else {
+		tmp_val = MCP47FEB02_INTERNAL_BAND_GAP;
+	}
+
+	ret = regmap_update_bits(data->regmap, MCP47FEB02_VREF_REG_ADDR,
+				 DAC_CTRL_MASK(ch), DAC_CTRL_VAL(ch, tmp_val));
+	if (ret)
+		return ret;
+
+	data->chdata[ch].ref_mode = tmp_val;
+
+	return 0;
+}
+
+/*
+ * Setting the scale in order to choose between VDD and (Vref or Band Gap) from the user
+ * space. The VREF pin is either an input or an output, therefore the user cannot
+ * simultaneously connect an external voltage reference to the pin and select the
+ * internal Band Gap.
+ * When the DAC’s voltage reference is configured as the VREF pin, the pin is an input.
+ * When the DAC’s voltage reference is configured as the internal Band Gap,
+ * the VREF pin is an output.
+ * If Vref/Vref1 voltage is not available, then the internal Band Gap will be used
+ * to calculate the values for the scale.
+ */
+static int mcp47feb02_set_scale(struct mcp47feb02_data *data, int ch, int scale)
+{
+	unsigned int tmp_val;
+	int ret;
+
+	ret = mcp47feb02_ch_scale(data, ch, scale);
+	if (ret)
+		return ret;
+
+	if (scale == MCP47FEB02_SCALE_GAIN_X2)
+		tmp_val = MCP47FEB02_GAIN_BIT_X2;
+	else
+		tmp_val = MCP47FEB02_GAIN_BIT_X1;
+
+	ret = regmap_update_bits(data->regmap, MCP47FEB02_GAIN_CTRL_STATUS_REG_ADDR,
+				 DAC_GAIN_MASK(ch), DAC_GAIN_VAL(ch, tmp_val));
+	if (ret)
+		return ret;
+
+	data->chdata[ch].use_2x_gain = tmp_val;
+
+	return 0;
+}
+
+static int mcp47feb02_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *ch,
+			       int *val, int *val2, long mask)
+{
+	struct mcp47feb02_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = regmap_read(data->regmap, REG_ADDR(ch->address), val);
+		if (ret)
+			return ret;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		mcp47feb02_get_scale(ch->address, data, val, val2);
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int mcp47feb02_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *ch,
+				int val, int val2, long mask)
+{
+	struct mcp47feb02_data *data = iio_priv(indio_dev);
+	int ret;
+
+	guard(mutex)(&data->lock);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = regmap_write(data->regmap, REG_ADDR(ch->address), val);
+		if (ret)
+			return ret;
+
+		data->chdata[ch->address].dac_data = val;
+		return 0;
+	case IIO_CHAN_INFO_SCALE:
+		ret = mcp47feb02_check_scale(data, val, val2,
+					     data->chdata[ch->address].scale_avail);
+		if (ret < 0)
+			return ret;
+
+		return mcp47feb02_set_scale(data, ch->address, ret);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int mcp47feb02_read_label(struct iio_dev *indio_dev, struct iio_chan_spec const *ch,
+				 char *label)
+{
+	struct mcp47feb02_data *data = iio_priv(indio_dev);
+
+	return sysfs_emit(label, "%s\n", data->labels[ch->address]);
+}
+
+static const struct iio_info mcp47feb02_info = {
+	.read_raw = mcp47feb02_read_raw,
+	.write_raw = mcp47feb02_write_raw,
+	.read_label = mcp47feb02_read_label,
+	.read_avail = &mcp47feb02_read_avail,
+	.attrs = &mcp47feb02_attribute_group,
+};
+
+static const struct iio_info mcp47fvb02_info = {
+	.read_raw = mcp47feb02_read_raw,
+	.write_raw = mcp47feb02_write_raw,
+	.read_label = mcp47feb02_read_label,
+	.read_avail = &mcp47feb02_read_avail,
+};
+
+static int mcp47feb02_parse_fw(struct iio_dev *indio_dev,
+			       const struct mcp47feb02_features *chip_features)
+{
+	struct iio_chan_spec chanspec = mcp47febxx_ch_template;
+	struct mcp47feb02_data *data = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(data->regmap);
+	struct iio_chan_spec *channels;
+	u32 num_channels;
+	u8 chan_idx;
+
+	num_channels = device_get_child_node_count(dev);
+	if (num_channels > chip_features->phys_channels)
+		return dev_err_probe(dev, -EINVAL, "More channels than the chip supports\n");
+
+	if (num_channels == 0)
+		return dev_err_probe(dev, -EINVAL, "No channel specified in the devicetree\n");
+
+	channels = devm_kcalloc(dev, num_channels, sizeof(*channels), GFP_KERNEL);
+	if (!channels)
+		return -ENOMEM;
+
+	chan_idx = 0;
+	device_for_each_child_node_scoped(dev, child) {
+		u32 reg;
+		int ret;
+
+		ret = fwnode_property_read_u32(child, "reg", &reg);
+		if (ret)
+			return dev_err_probe(dev, ret, "Invalid channel number\n");
+
+		if (reg >= chip_features->phys_channels)
+			return dev_err_probe(dev, -EINVAL,
+					     "The index of the channels does not match the chip\n");
+
+		__set_bit(reg, &data->active_channels_mask);
+
+		ret = fwnode_property_read_string(child, "label", &data->labels[reg]);
+		if (ret)
+			dev_dbg(dev, "%pfw: invalid label\n", child);
+
+		chanspec.address = reg;
+		chanspec.channel = reg;
+		channels[chan_idx] = chanspec;
+		chan_idx++;
+	}
+
+	indio_dev->num_channels = num_channels;
+	indio_dev->channels = channels;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	data->phys_channels = chip_features->phys_channels;
+
+	data->vref_buffered = device_property_read_bool(dev, "microchip,vref-buffered");
+
+	if (chip_features->have_ext_vref1)
+		data->vref1_buffered = device_property_read_bool(dev, "microchip,vref1-buffered");
+
+	return 0;
+}
+
+static int mcp47feb02_init_ctrl_regs(struct mcp47feb02_data *data)
+{
+	unsigned int i, vref_ch, gain_ch, pd_ch;
+	int ret;
+
+	ret = regmap_read(data->regmap, MCP47FEB02_VREF_REG_ADDR, &vref_ch);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(data->regmap, MCP47FEB02_GAIN_CTRL_STATUS_REG_ADDR, &gain_ch);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(data->regmap, MCP47FEB02_POWER_DOWN_REG_ADDR, &pd_ch);
+	if (ret)
+		return ret;
+
+	gain_ch = gain_ch & MCP47FEB02_GAIN_BITS_MASK;
+	for_each_set_bit(i, &data->active_channels_mask, data->phys_channels) {
+		struct device *dev = regmap_get_device(data->regmap);
+		unsigned int pd_tmp;
+
+		data->chdata[i].ref_mode = (vref_ch >> (2 * i)) & MCP47FEB02_DAC_CTRL_MASK;
+		data->chdata[i].use_2x_gain = (gain_ch >> i)  & MCP47FEB02_GAIN_BIT_MASK;
+
+		/*
+		 * Inform the user that the current voltage reference read from the volatile
+		 * register of the chip is different from the one specified in the device tree.
+		 * Considering that the user cannot have an external voltage reference connected
+		 * to the pin and select the internal Band Gap at the same time, in order to avoid
+		 * miscofiguring the reference voltage, the volatile register will not be written.
+		 * In order to overwrite the setting from volatile register with the one from the
+		 * device tree, the user needs to write the chosen scale.
+		 */
+		switch (data->chdata[i].ref_mode) {
+		case MCP47FEB02_INTERNAL_BAND_GAP:
+			if (data->phys_channels >= 4 && (i % 2) && data->use_vref1) {
+				dev_dbg(dev,
+					"ch[%u]: was configured to use internal band gap\n", i);
+				dev_dbg(dev, "ch[%u]: reference voltage set to VREF1\n", i);
+				break;
+			}
+			if (data->use_vref && ((data->phys_channels >= 4 && !(i % 2)) ||
+					       data->phys_channels < 4)) {
+				dev_dbg(dev,
+					"ch[%u]: was configured to use internal band gap\n", i);
+				dev_dbg(dev, "ch[%u]: reference voltage set to vref\n", i);
+				break;
+			}
+			break;
+		case MCP47FEB02_EXTERNAL_VREF_UNBUFFERED:
+		case MCP47FEB02_EXTERNAL_VREF_BUFFERED:
+			if (!data->use_vref1 && data->phys_channels >= 4 && (i % 2)) {
+				dev_dbg(dev, "ch[%u]: was configured to use vref1\n", i);
+				dev_dbg(dev,
+					"ch[%u]: reference voltage set to internal band gap\n", i);
+				break;
+			}
+			if (!data->use_vref && ((data->phys_channels >= 4 && !(i % 2)) ||
+						data->phys_channels < 4)) {
+				dev_dbg(dev, "ch[%u]: was configured to use vref\n", i);
+				dev_dbg(dev,
+					"ch[%u]: reference voltage set to internal band gap\n", i);
+				break;
+			}
+			break;
+		}
+
+		pd_tmp = (pd_ch >> (2 * i)) & MCP47FEB02_DAC_CTRL_MASK;
+		data->chdata[i].powerdown_mode = pd_tmp ? (pd_tmp - 1) : pd_tmp;
+		data->chdata[i].powerdown = !!(data->chdata[i].powerdown_mode);
+	}
+
+	return 0;
+}
+
+static int mcp47feb02_init_ch_scales(struct mcp47feb02_data *data, int vdd_uV,
+				     int vref_uV, int vref1_uV)
+{
+	struct device *dev = regmap_get_device(data->regmap);
+	unsigned int i;
+	int ret;
+
+	ret = mcp47feb02_init_scales_avail(data, vdd_uV, vref_uV, vref1_uV);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to init scales\n");
+
+	for_each_set_bit(i, &data->active_channels_mask, data->phys_channels) {
+		if (data->phys_channels >= 4 && (i % 2))
+			data->chdata[i].scale_avail = data->scale_1;
+		else
+			data->chdata[i].scale_avail = data->scale_0;
+	}
+
+	return 0;
+}
+
+int mcp47feb02_common_probe(const struct mcp47feb02_features *chip_features, struct regmap *regmap)
+{
+	struct device *dev = regmap_get_device(regmap);
+	int vref1_uV, vref_uV, vdd_uV;
+	struct mcp47feb02_data *data;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	data->chip_features = chip_features;
+	data->regmap = regmap;
+
+	indio_dev->info = chip_features->have_eeprom ? &mcp47feb02_info : &mcp47fvb02_info;
+	indio_dev->name = chip_features->name;
+
+	ret = devm_mutex_init(dev, &data->lock);
+	if (ret)
+		return ret;
+
+	ret = mcp47feb02_parse_fw(indio_dev, chip_features);
+	if (ret)
+		return dev_err_probe(dev, ret, "Error parsing firmware data\n");
+
+	ret = devm_regulator_get_enable_read_voltage(dev, "vdd");
+	if (ret < 0)
+		return ret;
+
+	vdd_uV = ret;
+
+	ret = devm_regulator_get_enable_read_voltage(dev, "vref");
+	if (ret > 0) {
+		vref_uV = ret;
+		data->use_vref = true;
+	} else {
+		vref_uV = 0;
+		dev_dbg(dev, "Using internal band gap as voltage reference.\n");
+		dev_dbg(dev, "Vref is unavailable.\n");
+	}
+
+	if (chip_features->have_ext_vref1) {
+		ret = devm_regulator_get_enable_read_voltage(dev, "vref1");
+		if (ret > 0) {
+			vref1_uV = ret;
+			data->use_vref1 = true;
+		} else {
+			vref1_uV = 0;
+			dev_dbg(dev, "Using internal band gap as voltage reference 1.\n");
+			dev_dbg(dev, "Vref1 is unavailable.\n");
+		}
+	}
+
+	ret = mcp47feb02_init_ctrl_regs(data);
+	if (ret)
+		return dev_err_probe(dev, ret, "Error initialising vref register\n");
+
+	ret = mcp47feb02_init_ch_scales(data, vdd_uV, vref_uV, vref1_uV);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+EXPORT_SYMBOL_NS(mcp47feb02_common_probe, "IIO_MCP47FEB02");
+
+MODULE_AUTHOR("Ariana Lazar <ariana.lazar@microchip.com>");
+MODULE_DESCRIPTION("IIO driver for MCP47FXBX4/8 and MCP48FXBX4/8 DAC with I2C or SPI interface");
+MODULE_LICENSE("GPL");
diff --git a/drivers/iio/dac/mcp47feb02-i2c.c b/drivers/iio/dac/mcp47feb02-i2c.c
new file mode 100644
index 0000000000000000000000000000000000000000..78e4e380d42c9686625e749ba2f0965a3fb4fff7
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
+#include <linux/export.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/pm.h>
+#include <linux/regmap.h>
+
+#include "mcp47feb02.h"
+
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
+		.name	= "mcp47feb02",
+		.of_match_table = mcp47feb02_of_i2c_match,
+		.pm	= pm_sleep_ptr(&mcp47feb02_pm_ops),
+	},
+	.probe		= mcp47feb02_i2c_probe,
+	.id_table	= mcp47feb02_i2c_id,
+};
+module_i2c_driver(mcp47feb02_i2c_driver);
+
+MODULE_AUTHOR("Ariana Lazar <ariana.lazar@microchip.com>");
+MODULE_DESCRIPTION("IIO driver for MCP47FEB02 Multi-Channel DAC with I2C interface");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_MCP47FEB02");
diff --git a/drivers/iio/dac/mcp47feb02-spi.c b/drivers/iio/dac/mcp47feb02-spi.c
new file mode 100644
index 0000000000000000000000000000000000000000..82e99388ac75860d534d0f2cc05dcc6628d96f6b
--- /dev/null
+++ b/drivers/iio/dac/mcp47feb02-spi.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * IIO driver for MCP48FEB02 Multi-Channel DAC with SPI interface
+ *
+ * Copyright (C) 2026 Microchip Technology Inc. and its subsidiaries
+ *
+ * Author: Ariana Lazar <ariana.lazar@microchip.com>
+ *
+ * Datasheet links for devices with SPI interface:
+ * [MCP48FEBxx] https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/20005429B.pdf
+ * [MCP48FVBxx] https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/20005466A.pdf
+ * [MCP48FxBx4/8] https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/MCP48FXBX4-8-Family-Data-Sheet-DS20006362A.pdf
+ */
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/pm.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+
+#include "mcp47feb02.h"
+
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
+		return -EINVAL;
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
+	{ "mcp48feb01", (kernel_ulong_t)&mcp48feb01_chip_features },
+	{ "mcp48feb02", (kernel_ulong_t)&mcp48feb02_chip_features },
+	{ "mcp48feb04", (kernel_ulong_t)&mcp48feb04_chip_features },
+	{ "mcp48feb08", (kernel_ulong_t)&mcp48feb08_chip_features },
+	{ "mcp48feb11", (kernel_ulong_t)&mcp48feb11_chip_features },
+	{ "mcp48feb12", (kernel_ulong_t)&mcp48feb12_chip_features },
+	{ "mcp48feb14", (kernel_ulong_t)&mcp48feb14_chip_features },
+	{ "mcp48feb18", (kernel_ulong_t)&mcp48feb18_chip_features },
+	{ "mcp48feb21", (kernel_ulong_t)&mcp48feb21_chip_features },
+	{ "mcp48feb22", (kernel_ulong_t)&mcp48feb22_chip_features },
+	{ "mcp48feb24", (kernel_ulong_t)&mcp48feb24_chip_features },
+	{ "mcp48feb28", (kernel_ulong_t)&mcp48feb28_chip_features },
+	{ "mcp48fvb01", (kernel_ulong_t)&mcp48fvb01_chip_features },
+	{ "mcp48fvb02", (kernel_ulong_t)&mcp48fvb02_chip_features },
+	{ "mcp48fvb04", (kernel_ulong_t)&mcp48fvb04_chip_features },
+	{ "mcp48fvb08", (kernel_ulong_t)&mcp48fvb08_chip_features },
+	{ "mcp48fvb11", (kernel_ulong_t)&mcp48fvb11_chip_features },
+	{ "mcp48fvb12", (kernel_ulong_t)&mcp48fvb12_chip_features },
+	{ "mcp48fvb14", (kernel_ulong_t)&mcp48fvb14_chip_features },
+	{ "mcp48fvb18", (kernel_ulong_t)&mcp48fvb18_chip_features },
+	{ "mcp48fvb21", (kernel_ulong_t)&mcp48fvb21_chip_features },
+	{ "mcp48fvb22", (kernel_ulong_t)&mcp48fvb22_chip_features },
+	{ "mcp48fvb24", (kernel_ulong_t)&mcp48fvb24_chip_features },
+	{ "mcp48fvb28", (kernel_ulong_t)&mcp48fvb28_chip_features },
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
+		.name	= "mcp47feb02",
+		.of_match_table = mcp47feb02_of_spi_match,
+		.pm	= pm_sleep_ptr(&mcp47feb02_pm_ops),
+	},
+	.probe		= mcp47feb02_spi_probe,
+	.id_table	= mcp47feb02_spi_id,
+};
+module_spi_driver(mcp47feb02_spi_driver);
+
+MODULE_AUTHOR("Ariana Lazar <ariana.lazar@microchip.com>");
+MODULE_DESCRIPTION("IIO driver for MCP48FEB02 Multi-Channel DAC with SPI interface");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_MCP47FEB02");
diff --git a/drivers/iio/dac/mcp47feb02.h b/drivers/iio/dac/mcp47feb02.h
new file mode 100644
index 0000000000000000000000000000000000000000..41de47166019ef23a89e531d7b0326273b14d175
--- /dev/null
+++ b/drivers/iio/dac/mcp47feb02.h
@@ -0,0 +1,158 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * IIO driver for MCP47FEB02 Multi-Channel DAC with I2C or SPI interface
+ *
+ * Copyright (C) 2026 Microchip Technology Inc. and its subsidiaries
+ *
+ * Author: Ariana Lazar <ariana.lazar@microchip.com>
+ */
+#ifndef _MCP47FEB02_H_
+#define _MCP47FEB02_H_
+
+#include <linux/bits.h>
+#include <linux/mutex.h>
+#include <linux/pm.h>
+#include <linux/regmap.h>
+#include <linux/types.h>
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
+#define DAC_GAIN_MASK(ch)				BIT(8 + (ch))
+#define DAC_GAIN_VAL(ch, val)				((val) * BIT(8 + (ch)))
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
+/**
+ * struct mcp47feb02_channel_data - channel configuration
+ * @scale_avail: scales available for the channel based on current configuration
+ * @dac_data: DAC value
+ * @ref_mode: chosen voltage for reference
+ * @powerdown_mode: selected power-down mode
+ * @use_2x_gain: output driver gain control
+ * @powerdown: is false if the channel is in normal operation mode
+ */
+struct mcp47feb02_channel_data {
+	int *scale_avail;
+	u16 dac_data;
+	u8 ref_mode;
+	u8 powerdown_mode;
+	bool use_2x_gain;
+	bool powerdown;
+};
+
+/**
+ * struct mcp47feb02_data - chip configuration
+ * @chdata: options configured for each channel on the device
+ * @lock: prevents concurrent reads/writes to driver's state members
+ * @chip_features: pointer to features struct
+ * @scale_1: scales set on channels that are based on Vref1
+ * @scale_0: scales set on channels that are based on Vref/Vref0
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
+	int scale_0[2 * MCP47FEB02_MAX_SCALES_CH];
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
+#endif /* _MCP47FEB02_H_ */

-- 
2.43.0

