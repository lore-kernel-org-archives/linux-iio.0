Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B903438A1
	for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 21:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781816666; cv=none; b=h3kLLTGkswCMD1FW6KTB+I5v+KKLTpAKMTqDc/bv7lsR4bQEZR64jg6Zs8rhlevNDj8fMbDgpX19NYYL628Xs0eg8QLg++mXpn3Zl8RRJFTzMN1RBSRWLhuSKCJSXVCwRRSmdZuADM9p1QqQytKCRg0vMZY2cRL0ldrteLc3F7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781816666; c=relaxed/simple;
	bh=JShbb5NxpeJnn/K6Q7dYvW9LuAGX8BDNlofd1eRZDW8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pkjWlIKuSvF+3n0ugye9p8y9fxHSiTcotCIf4miTPyhLwSl0wriLKdgSSn55Ae53Ih++ZEANwLMs4b5g2A/x82dT+KiGpgTSIvdHAh2Rk6pqc7Bc0Ipk1RmNmF/GJ5iPRTlac3Pjt7KTDGh0eOuVarmnqiktrp4GRYcSq+Itb14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=oS9gZZrx; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="oS9gZZrx"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5ad583dc41eso5333e87.1
        for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 14:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781816661; x=1782421461; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YHTc2d1gfZfmsv6g60s61hpLDdJiCapvFvPkETN2gak=;
        b=oS9gZZrxlBp2WeroJoR+1PZwNeDtphP7Fgw1mpFQ/KbWX4Kyoz91uJZubjTGCtmCIp
         O7Tue7lpCmZHzIBdmTeVxQVMjWzYUD6f94yfVVq1DBuagWHwpzvk2dp5djtjYaMTb0bz
         SuNZOWEUOsw7kIQ6drg7WrCDsVj3I8i1bjhFrlsGsyDF+AYKtaa1jAfVI1iLPMWVP0Ks
         ep9Xp38ER83nUPZP5jccHuRiyDp3AA2Ebt0hIOgSy8+GFEskUith/9acis9fbO76p8rI
         8vDS+2oGEG9aQ0JY/LH27bGjY82JqRuIUK6SrMg9+wCCh0cchlKBnkr5CK+xrOCHd+DI
         HQPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781816661; x=1782421461;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YHTc2d1gfZfmsv6g60s61hpLDdJiCapvFvPkETN2gak=;
        b=GM9+jJ/Rqac2QXTDztk/lWguIgYKPaenWgUTqLDI2k/W4NH1C3q5vWvQ4u4TroaRhc
         TWAPSf0VNP32iMUwf6EXdo68CbUdbIav/uRhgspjMpokT4FbCMUTd0YF51vTw5UmQzuw
         1a0vWL8n1wDtgzVxGXRLRBwL5WLPC8gxkZYlK+L7SuBSlDL/N2eEtL4aV1Wh32jx02tZ
         gQoEOJN5z4vf44Dkfm2Xjhd1c/eVR8jFlBY2XHjI4uMyfOLsY1MNal7EtYVSPL4dc+4H
         akJkbxpyjZtIuHiBm52EW99LhnLrPeGROu5VkjCu0yLnk9PtwGvW16PgO/2amRFmsdCt
         BioA==
X-Forwarded-Encrypted: i=1; AFNElJ95Tb09waX/U3NXVI0H2zxbauQxMclL4xcejF5L8K3sKUDKWvrdUlk3e4DFbYkBL8lLc/8bNGwHuGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOmnRhZmvvP2TL8tU3SPcuB55/nEByrIomtGi7DVfmMUpTbGYK
	LgvTasNf5dohg7KzSFrf8F3VedmKsRXD/Pfz/xiyQRS2m3YSEZdbEtkkTAO2P/8THhI=
X-Gm-Gg: AfdE7ckilJ464DEeXMpgzJEzFJqxfY53gihHZ2SrF2vYRntDFlkhLayStogA+ogEhQs
	U2Fv6DOf4M3Swqc/ExCztvf5iCKgqFkAEIzRdYWE83QJWiMHtGCe9lZuFknHh5NKrJOuI7IUpOb
	qppbzKVT9pCQzuqlsjZ7SdRlW+hk68yhJeocpPQISc7rqEv78anYnb9PsNHSTFUNT7ku1PCbpzV
	+WPfrChFHPTTy3wh4DluSZgeOY1G61nDCXj6k3eddacQi3Sq+E6MzHxtuOaifxCGrBLRj719EAQ
	WiGbhdnuthrf9ZswI7bAlP89FQ3t9QgBF78bRLepspI9YeU8/FJleW7qOYWGwfRzVpOkfxEXrOn
	KhJ9WcQDFcs0SIdZVq7jrmA5nTbkTZHktTUoTQ2ZSrl0InSDh4SsNsiEJYLKIrFq7Z4GFeiSve7
	Pp+SJRNcp5BFBVVODiNeFg
X-Received: by 2002:a05:6512:2526:b0:5aa:7aba:2a5f with SMTP id 2adb3069b0e04-5ad5627b4edmr302039e87.6.1781816660782;
        Thu, 18 Jun 2026 14:04:20 -0700 (PDT)
Received: from [192.168.0.2] ([2a07:7e81:7daa:0:202:c9ff:fe53:eda4])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad57493145sm108586e87.69.2026.06.18.14.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 14:04:20 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Thu, 18 Jun 2026 23:04:15 +0200
Subject: [PATCH v6 1/2] iio: dac: add mcf54415 DAC
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-wip-stmark2-dac-v6-1-48761dbb96d7@baylibre.com>
References: <20260618-wip-stmark2-dac-v6-0-48761dbb96d7@baylibre.com>
In-Reply-To: <20260618-wip-stmark2-dac-v6-0-48761dbb96d7@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-m68k@lists.linux-m68k.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, 
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
Changes in v6:
- removed pm ops, can't be tested for mcf54415 with mmu enabled
- Kconfig desc line rewrap
- minor coding style fixes
---
 drivers/iio/dac/Kconfig        |  11 +++
 drivers/iio/dac/Makefile       |   1 +
 drivers/iio/dac/mcf54415_dac.c | 183 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 195 insertions(+)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index cd4870b65415..b23078c8986a 100644
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
+	  Say yes here if you want to build support for NXP ColdFire
+	  MCF54415/6/7/8 12-bit DAC module.
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
index 000000000000..986c4c6ac727
--- /dev/null
+++ b/drivers/iio/dac/mcf54415_dac.c
@@ -0,0 +1,183 @@
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
+static const struct platform_device_id mcf54415_dac_ids[] = {
+	{ .name = "mcfdac" },
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, mcf54415_dac_ids);
+
+static struct platform_driver mcf54415_dac_driver = {
+	.driver = {
+		.name = "mcf54415_dac",
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

