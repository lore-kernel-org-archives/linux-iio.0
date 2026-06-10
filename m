Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D0E481641
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 20:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781123725; cv=none; b=VlsCxtVWT1GG2/lz59EAhoKxjzafg58ZOSIEyXH4AQexnw5iWq1lPDkgbsaMqzulSZ1swEUd0gj6NilgKJ+Zk8b2WRuWWtV9WNsiBGp8qAsg3bqJuN1vW/bfY5chnVm5uXzomHrR1LiRGivp7TdcVScY9s1qG5zohK8dyNIgUO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781123725; c=relaxed/simple;
	bh=88p5UUCAgErkiEKYAGjUsDrZYg15GfG4i+DbXosQZ8U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CRQUTD3EKcuOpQnkPdqjEM372aFU7CeNbkTU5rJ8HtOiEVFwalKHKXFbANS00X8PtrNq5rBUMSXtVcuZD0hVHqffgpQEWZZVtfXaASFAWohoA/Xq49j+7lk4ne7Hqbq7dFBSPDww9QEysd1s6oi5+A1hxovwbdIFFbBco6nHx44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=ZO6/3rkt; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="ZO6/3rkt"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490b64c8311so79620135e9.3
        for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 13:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781123722; x=1781728522; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=88uLPGneF+DaMVH5ENraIcWVNnqf2O5+6TBapW7G/ZE=;
        b=ZO6/3rktsOAyWivA6YLihedz29CDRCUXTQGHvGwXOTUpiraHkob5MOWEk8NOdElnar
         ZLSfZgxsANHvbPZeyfDDtF/MGs6EiquLoXcLB1aUJuZH8LzkYMrCgKz9jQbDiL4BCIic
         so5fKHHYBgP1D8Ex7r/Zth504kcLFGveOcS07Te4mvDitxcKask/1mHWk+PYqyadFru/
         BjECRHZFqM+VtUCNhkhDIPCKDD+6TTfHMME3lnOGMDw9hEUzAZvD2ytMLSflO2Q/g165
         vfKhhm9qrhIOhuL8x+eDwWqJZ6QfX5Yb0eRL7OPVHGPi1mEX8yJ2ngm2S66G7PUhlbJE
         wEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781123722; x=1781728522;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=88uLPGneF+DaMVH5ENraIcWVNnqf2O5+6TBapW7G/ZE=;
        b=RxHStLpRgsY4gKkKiIm9kNeJa+fetmrRk76BDb0vTFPIqljLffUvBB7PG+pqTn897D
         rskdWoaHgJps9AX1uck1QJ1C6uMDSEPughtwpXy6fIsXLTpfaNgp06+eSktq3q/zVkcI
         KounB5x+RuFOB+dKPkLrEEz6KUYO6BPf9QYLa6AQ+jmQtA9gCYbsAL1odePIM0lI5b9P
         Ve+XVI4MVPTzJIIuwpwX+sVVZJIdG7M1gxskmLkF4GAUIIsoc/P7fLO/pf9KkmIxP5bM
         ktQ8TAgNkFATNdxqa9kI+nqiFDZTWMJMHH+4OwJ7pZ4h89MThkm7Ui6yc5XzRTSliI/c
         0tTw==
X-Forwarded-Encrypted: i=1; AFNElJ+5/xAeA54OMh6olNB1nM0nFfBuFi6KLAwLawmjeruRU/YV8ck0NU5FWeZYNX+x3wwIOMV9UZ+dlf8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6NbxoGrL/hFpzTCaSbnUjD0uXU3E0ah8i6hUJK3qWcU93qBKs
	pPZNT0hdXFS6ncUrkWPnGAVJ9uLwSmJWapMTfZUbjNf7TJf4q9xda+KVv71yFh/jR+A=
X-Gm-Gg: Acq92OFlRokweDEv/92DfYRCK6baHBRDhTRbh6PtC2o3DA+Md5elHZQM6KL/dLvXWGt
	yUvaP+1NlDnde6wwhC16BlTW/LMLd+0dTTemRp4mfwTLKbga+cdBAPYVoVCwyTONjiFIf30ZqxN
	f//6py6Z0P9bAtrBiTIukKs8mr+E5tuQKAuAJAcyE5ersyqHxRYnrmgFSqR+qSguhJvDYRCgCm7
	PZ8j6u884zviZ7doGLoIdb5VwDs0bpghmY9gAO5DuFsTPvw3INoUAF0Omk6jZ5AZQ1IjgIsxRag
	GpyIXU7uj5YDYjk+M2qHMTZE5TFyLDqhWuu1/C1pKKpiAataDhb2/D2VvW2K4mIWCCDdmjz4XgT
	qxg7rll0H4MfHaG2Hi1fVZanFMvXqh0/JtgWbVCbiCVTQKu4EARP8jb0nrGEWUzJgjvGdvfWhHz
	0g9uCwxWLJ8aSngAAbrj5t+V703wNofC5nCk/eQHj4mw==
X-Received: by 2002:a05:600c:83c3:b0:48f:d612:3c59 with SMTP id 5b1f17b1804b1-490c25a21a9mr457348005e9.9.1781123721593;
        Wed, 10 Jun 2026 13:35:21 -0700 (PDT)
Received: from [192.168.0.2] ([2a07:7e81:7daa:0:202:c9ff:fe53:eda4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490dc4715e4sm62390975e9.0.2026.06.10.13.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 13:35:21 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Wed, 10 Jun 2026 22:35:14 +0200
Subject: [PATCH v5 09/10] iio: dac: add mcf54415 DAC
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-wip-stmark2-dac-v5-9-b76b83366d5c@baylibre.com>
References: <20260610-wip-stmark2-dac-v5-0-b76b83366d5c@baylibre.com>
In-Reply-To: <20260610-wip-stmark2-dac-v5-0-b76b83366d5c@baylibre.com>
To: Greg Ungerer <gerg@linux-m68k.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, Steven King <sfking@fdwdc.com>, 
 Arnd Bergmann <arnd@arndb.de>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Greg Ungerer <gerg@uclinux.org>, linux-m68k@lists.linux-m68k.org, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.15.2

From: Angelo Dureghello <adureghello@baylibre.com>

Add basic version of mcf54415 DAC driver. DAC is embedded in the SoC and
DAC configuration registers are mapped in the internal IO address space.

The DAC accepts a 12-bit digital signal and creates a monotonic 12-bit
analog output varying from DAC_VREFL to DAC_VREFH. The DAC module
consists of a conversion unit, an output amplifier, and the associated
digital control blocks. Default register values for DAC_VREFL and DAC_VREFH
are respectively 0 and 0xfff, left untouched in this initial version.

This initial version of the driver is minimalistic, "output raw" only, to
be extended in the future. DMA and external sync are disabled, default mode
is high speed, default format is right-justified 12-bit on 16-bit word.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
Changes in v2:
- remove tests from commit message, moved to patch 0
- remove additional blank lines
- remove dead code and unused definitions
- use regmap
- add limit check on raw write
- non functional style fixes
- add COMPILE_TEST to Kconfig
Changes in v3:
- add comments where needed
- code style changes
- remove unneeded variables
- use regmap_set_bits where possible
- remove macro not needed to define a single channel
- set up regmap to big_endian accesses for next patches that will come,
  that will adjust ColdFire readx/writex as standard LE (links in 0/x).
- add return value check on regmap calls
- sashiko: remove unneeded .io_port from regmap init.
- sashiko: add select REGMAP_MMIO in Kconfig
Changes in v4:
- remove unused includes
- sashiko: return "ret" as regmap_read ret value in case of error
- sashiko: using u32 as regmap_read value
- use local variable in mcf54415_dac_init() for better readability
- sashiko: check mcf54415_dac_init return value also in resume()
Changes in v5:
- commit syntax fixes
- minor code style fixes
- use include <linux/type.h>
- removed unneeded cast
- disable clock in case of DAC init error
- use unsigned int for regmap_read and GENMASK for masking 12 bits
- add id table to match "mcfdac" platform device name
---
 drivers/iio/dac/Kconfig        |  11 +++
 drivers/iio/dac/Makefile       |   1 +
 drivers/iio/dac/mcf54415_dac.c | 216 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 228 insertions(+)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index cd4870b65415..b1a578076188 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -516,6 +516,17 @@ config MAX5821
 	  Say yes here to build support for Maxim MAX5821
 	  10 bits DAC.
 
+config MCF54415_DAC
+	tristate "NXP MCF54415 DAC driver"
+	depends on M5441x || COMPILE_TEST
+	select REGMAP_MMIO
+	help
+	  Say yes here to build support for NXP MCF54415
+	  12bit DAC.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called mcf54415_dac.
+
 config MCP4725
 	tristate "MCP4725/6 DAC driver"
 	depends on I2C
diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index 2a80bbf4e80a..1cb93e83d0eb 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -51,6 +51,7 @@ obj-$(CONFIG_MAX517) += max517.o
 obj-$(CONFIG_MAX22007) += max22007.o
 obj-$(CONFIG_MAX5522) += max5522.o
 obj-$(CONFIG_MAX5821) += max5821.o
+obj-$(CONFIG_MCF54415_DAC) += mcf54415_dac.o
 obj-$(CONFIG_MCP4725) += mcp4725.o
 obj-$(CONFIG_MCP4728) += mcp4728.o
 obj-$(CONFIG_MCP47FEB02) += mcp47feb02.o
diff --git a/drivers/iio/dac/mcf54415_dac.c b/drivers/iio/dac/mcf54415_dac.c
new file mode 100644
index 000000000000..f223aa80aabf
--- /dev/null
+++ b/drivers/iio/dac/mcf54415_dac.c
@@ -0,0 +1,216 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * NXP mcf54415 DAC driver
+ *
+ * Copyright 2026 BayLibre - adureghello@baylibre.com
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/types.h>
+
+#include <linux/iio/iio.h>
+
+#define MCF54415_DAC_CR			0x00
+#define MCF54415_DAC_CR_PDN		BIT(0)
+#define MCF54415_DAC_CR_HSLS		BIT(6)
+#define MCF54415_DAC_CR_WMLVL		GENMASK(9, 8)
+#define MCF54415_DAC_CR_FILT		BIT(12)
+
+#define MCF54415_DAC_DATA		0x02
+
+struct mcf54415_dac {
+	struct regmap *map;
+	struct clk *clk;
+};
+
+static const struct regmap_config mcf54415_dac_regmap_config = {
+	.reg_bits = 16,
+	.reg_stride = 2,
+	.val_bits = 16,
+	.max_register = 0x0c, /* DACX_FILTCNT,  R.M. Table 30-2 */
+	.val_format_endian = REGMAP_ENDIAN_BIG,
+	.reg_format_endian = REGMAP_ENDIAN_BIG,
+};
+
+static int mcf54415_dac_init(struct mcf54415_dac *info)
+{
+	u16 val = MCF54415_DAC_CR_FILT | FIELD_PREP(MCF54415_DAC_CR_WMLVL, 1);
+	int ret;
+
+	/* Fixed defaults and enable DAC (bit 0 set to 0) */
+	ret = regmap_write(info->map, MCF54415_DAC_CR, val);
+	if (ret)
+		return ret;
+
+	/* DAC is ready after 12us, from RM table 40-3  */
+	fsleep(12);
+
+	return 0;
+}
+
+static void mcf54415_dac_exit(void *data)
+{
+	struct mcf54415_dac *info = data;
+
+	regmap_set_bits(info->map, MCF54415_DAC_CR, MCF54415_DAC_CR_PDN);
+}
+
+static const struct iio_chan_spec mcf54415_dac_iio_channel = {
+	.type = IIO_VOLTAGE,
+	.output = 1,
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
+};
+
+static int mcf54415_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int *val, int *val2, long mask)
+{
+	struct mcf54415_dac *info = iio_priv(indio_dev);
+	unsigned int reg;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = regmap_read(info->map, MCF54415_DAC_DATA, &reg);
+		if (ret)
+			return ret;
+		*val = reg & GENMASK(11, 0);
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		/* Reference voltage as per ColdFire datasheet is 3.3V */
+		*val = 3300 /* mV */;
+		*val2 = 12;
+		return IIO_VAL_FRACTIONAL_LOG2;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int mcf54415_write_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int val, int val2, long mask)
+{
+	struct mcf54415_dac *info = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		/* Check based on RM 30.3.2 (DACn_DATA) reg. resolution */
+		if (val < 0 || val > 4095)
+			return -EINVAL;
+		return regmap_write(info->map, MCF54415_DAC_DATA, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info mcf54415_dac_iio_info = {
+	.read_raw = &mcf54415_read_raw,
+	.write_raw = &mcf54415_write_raw,
+};
+
+static int mcf54415_dac_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct iio_dev *indio_dev;
+	struct mcf54415_dac *info;
+	void __iomem *regs;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*info));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	info = iio_priv(indio_dev);
+
+	regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(regs))
+		return dev_err_probe(dev, PTR_ERR(regs), "failed to get io regs\n");
+
+	info->map = devm_regmap_init_mmio(dev, regs, &mcf54415_dac_regmap_config);
+	if (IS_ERR(info->map))
+		return PTR_ERR(info->map);
+
+	info->clk = devm_clk_get_enabled(dev, "dac");
+	if (IS_ERR(info->clk))
+		return dev_err_probe(dev, PTR_ERR(info->clk), "failed getting clock\n");
+
+	platform_set_drvdata(pdev, indio_dev);
+
+	indio_dev->name = "mcf54415";
+	indio_dev->info = &mcf54415_dac_iio_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = &mcf54415_dac_iio_channel;
+	indio_dev->num_channels = 1;
+
+	ret = mcf54415_dac_init(info);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(dev, mcf54415_dac_exit, info);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static int mcf54415_dac_suspend(struct device *dev)
+{
+	struct mcf54415_dac *info = iio_priv(dev_get_drvdata(dev));
+
+	mcf54415_dac_exit(info);
+	clk_disable_unprepare(info->clk);
+
+	return 0;
+}
+
+static int mcf54415_dac_resume(struct device *dev)
+{
+	struct mcf54415_dac *info = iio_priv(dev_get_drvdata(dev));
+	int ret;
+
+	ret = clk_prepare_enable(info->clk);
+	if (ret)
+		return ret;
+
+	ret = mcf54415_dac_init(info);
+	if (ret) {
+		dev_err(dev, "could not resume device\n");
+		clk_disable_unprepare(info->clk);
+	}
+
+	return ret;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(mcf54415_dac_pm_ops,
+				mcf54415_dac_suspend, mcf54415_dac_resume);
+
+static const struct platform_device_id mcf54415_dac_ids[] = {
+	{ .name = "mcfdac", .driver_data = 0 },
+	{ }, /* sentinel */
+};
+
+MODULE_DEVICE_TABLE(platform, mcf54415_dac_ids);
+
+static struct platform_driver mcf54415_dac_driver = {
+	.driver = {
+		.name = "mcf54415_dac",
+		.pm = pm_sleep_ptr(&mcf54415_dac_pm_ops),
+	},
+	.probe = mcf54415_dac_probe,
+	.id_table = mcf54415_dac_ids,
+};
+module_platform_driver(mcf54415_dac_driver);
+
+MODULE_AUTHOR("Angelo Dureghello <angelo@kernel-space.org>");
+MODULE_DESCRIPTION("NXP MCF54415 DAC driver");
+MODULE_LICENSE("GPL");

-- 
2.54.0

