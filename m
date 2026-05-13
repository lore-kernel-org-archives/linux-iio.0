Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9CB3E9C1E
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 09:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778663695; cv=none; b=MSBe2zSSsT/ZwKTe6as5YWa7AhmoKace0VBDlixQ3c1cc7BuxSeuwR6PtBEnxGX1Naqqn6A5qwH8VSBKB8j0G74TU/RTPHfnyYZ5pm6jkM3VXhSgUNx50cGDYKvCFCJzvRC2K0c4i1O1EUtbNtQT6pItnyVAwyccxdFljp2CjaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778663695; c=relaxed/simple;
	bh=GtwzAhIxMfi/CJvzqKiHfIKzVUHYCN6Oj95QRBsTvmI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WP8MO0Cd5UcmiuP2X9WKd+BZmWP37Mm+t0YMIQ7lz/6ht8J1eIdQQY54seXYeUx7W//3v5xFTM5VM4N+Vx0bpxJ5XlTJZfrJY/koCmXsUO4nViWpvXgdVJidPi3btmqbFKHNnmg+m9kCSOsbFwuBq1Dhs0iUjR9K9C1HqpNol1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=E0F5sp9u; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="E0F5sp9u"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-449d6c68ed8so5590420f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 02:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778663692; x=1779268492; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q0tVlr4iz4Q1UmdBPJxjhIok3j0IOwmGIzUfZBi5eQA=;
        b=E0F5sp9uENJ2VHrBplp6QRXqC0PbK6wGpgnaimxkgwnO43G+qJKiisEflDw1OZkW6n
         jdDi0SBtXZfz0MOhTu5/1wl5UNeTQzL8189XXy/V9QQ1KbakKStAzL68GL/8tTT/RQ7l
         OCC58EYIbDTPBI+lxl/CMBaDe+wJK5JKbH4WP9MyUT1Txgl90XX0g5jR624GlwbmI14o
         Tf9IaVRfZKLSEk9BDalV+eCL0E0PCG32ctby8fH5j8MJk8Xe5UO2q44xPPqIzkf0WzP3
         lSze3lVk10QQPBDov8maCvLszcr9XTo3/kt77HsBiUCo3oviSuZW09CsRMUx49KwiY8y
         I0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778663692; x=1779268492;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q0tVlr4iz4Q1UmdBPJxjhIok3j0IOwmGIzUfZBi5eQA=;
        b=UPmNLrJSJwuhFE77di3oxhoqA985VIQbNVX03upwbGGqdmEkvQ/qy0iSF39nelxEJU
         Ta6ydR94OwH5QNBNNiTYTHrWeZmz1HdiwkDRH1IUtooHqLkRIV50reoWwq4soJUDsQXp
         36q5OE4d81KxgE9zctlvtOU4UjNrPIQV0DRHP0dojJonUdzHRHlH3vFJ/i2tH7pWUxqS
         Z3b2I3AmFoutWTA81rlYhdAAWMBDt8lP+lD+Q/HnEO6nTiL6oBG5wDL3JiHZV1lKQuK5
         qs/VEYj22RtxD5NVEAxmkYnfz7f/PaUoWDUNhnHEbE0pVbIqlDH9eeesiqOs58HTWi+P
         lfew==
X-Forwarded-Encrypted: i=1; AFNElJ/vTcSVydltW8Tvgz26T+3vUEDiI0Po0FUZql1WNUJZ8jj8gx3MLNsdP4wbc4f+O2Dc/riI2YdSS+o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2jMjO38BaMT/j/tTvQLd/Nk75hJOgZDV7P+d0Ee+/tDDyH15X
	CjAG3lBD5Uo3uO5V58e0OBHPCvkoF7/VIWXUNGL6cOnPqs1JSpVPKdtDNN/fnQIMYXY=
X-Gm-Gg: Acq92OH1lraiaPA06hQR+oeWNsePRL2ZhIJZ8VrXocVRdsufd5/lmz4zhoU1pxTdcTj
	gH//LSNJMKFbK1K2xEB/+KFED9qsqoYtHtB4qGrsrYSh1StwkTlBrK8wNxQ/IF1KpNArgeikxmC
	nRawBBrbl6Z9rv3dqUagru5LXXNtY/h4QVnJcmRu9r+1jYdDKYScENwbULxdC31BNP+ODVj/rig
	HDIXyKabT13XK5vyypZbYW1jxaXHIpgptcIvCX4nlj179rGi0Fp/NOb8inOcvz27LoOec1wr1ws
	fXpzUG9+Uvhco1DlfQ71QWcqS7PWDuIorqRSaWaYRt5YZDBEWdXlMsXmLLDNY57qPpzM4I3U53E
	gPNsPv3hSGYRzzKtuGKb4Imet0Lm5FTjqWMnG8lj2045jj+NGsU3gTjI7Y4WlipUUnFjQB7SoR2
	yYHJHu+YXdN7pvYpXPqyFcA9bxEaD89Xo=
X-Received: by 2002:a05:6000:26c9:b0:455:544d:68c9 with SMTP id ffacd0b85a97d-45c59bd670cmr3730735f8f.25.1778663691553;
        Wed, 13 May 2026 02:14:51 -0700 (PDT)
Received: from [192.168.0.2] ([2a07:7e81:7daa:0:62cf:84ff:feee:627])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e6a66bfsm34590821f8f.4.2026.05.13.02.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 02:14:51 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Wed, 13 May 2026 11:14:35 +0200
Subject: [PATCH v2 11/11] iio: dac: add mcf54415 DAC
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-wip-stmark2-dac-v2-11-fcdae50cf51a@baylibre.com>
References: <20260513-wip-stmark2-dac-v2-0-fcdae50cf51a@baylibre.com>
In-Reply-To: <20260513-wip-stmark2-dac-v2-0-fcdae50cf51a@baylibre.com>
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

Add basic version of mcf54415 DAC driver. DAC is embedded in the cpu and
DAC configuration registers are mapped in the internal IO address space.

The DAC accepts a 12-bit digital signal and creates a monotonic 12-bit
analog output varying from DAC_VREFL to DAC_VREFH. The DAC module
consists of a conversion unit, an output amplifier, and the associated
digital control blocks. Default register values for DAC_VREFL and DAC_VREFH
are respectively 0 and 0xfff, left untouched in this initial version.

This initial version of the driver is minimalistic, "output raw" only, to
be extended in the future. DMA and external sync are disabled, default mode
is high speed, default format is right-justified 12bit on 16bit word.

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
---
 drivers/iio/dac/Kconfig        |  10 ++
 drivers/iio/dac/Makefile       |   1 +
 drivers/iio/dac/mcf54415_dac.c | 203 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 214 insertions(+)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index cd4870b65415..85147df00aa3 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -516,6 +516,16 @@ config MAX5821
 	  Say yes here to build support for Maxim MAX5821
 	  10 bits DAC.
 
+config MCF54415_DAC
+	tristate "NXP MCF54415 DAC driver"
+	depends on M5441x || COMPILE_TEST
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
index 000000000000..e95ab6b89b17
--- /dev/null
+++ b/drivers/iio/dac/mcf54415_dac.c
@@ -0,0 +1,203 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * NXP mcf54415 DAC driver
+ *
+ * Copyright 2026 BayLibre - adureghello@baylibre.com
+ */
+
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/compiler_types.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
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
+	struct clk *clk;
+	struct regmap *map;
+};
+
+static const struct regmap_config mcf54415_dac_regmap_config = {
+	.reg_bits = 16,
+	.reg_stride = 2,
+	.val_bits = 16,
+	.io_port = true,
+	.max_register = 0x1F,
+};
+
+static void mcf54415_dac_init(struct mcf54415_dac *info)
+{
+	/* Keeping defaults and enable DAC (bit 0 set to 0) */
+	regmap_write(info->map, MCF54415_DAC_CR, MCF54415_DAC_CR_FILT |
+		     FIELD_PREP(MCF54415_DAC_CR_WMLVL, 1));
+
+	/* DAC is ready after 12us, from RM table 40-3  */
+	fsleep(12);
+}
+
+static void mcf54415_dac_exit(void *data)
+{
+	struct mcf54415_dac *info = data;
+
+	regmap_update_bits(info->map, MCF54415_DAC_CR, MCF54415_DAC_CR_PDN,
+			   MCF54415_DAC_CR_PDN);
+}
+
+#define MCF54415_DAC_CHAN \
+{ \
+	.type = IIO_VOLTAGE, \
+	.output = 1, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
+}
+
+static const struct iio_chan_spec mcf54415_dac_iio_channels[] = {
+	MCF54415_DAC_CHAN,
+};
+
+static int mcf54415_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int *val, int *val2, long mask)
+{
+	struct mcf54415_dac *info = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		regmap_read(info->map, MCF54415_DAC_DATA, val);
+		*val &= 0xfff;
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
+		if (val < 0 || val > 4095)
+			return -EINVAL;
+		regmap_write(info->map, MCF54415_DAC_DATA, val);
+		return 0;
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
+		return dev_err_probe(dev, PTR_ERR(regs),
+				     "failed to get io regs\n");
+
+	info->map = devm_regmap_init_mmio(dev, regs,
+					  &mcf54415_dac_regmap_config);
+	if (IS_ERR(info->map))
+		return PTR_ERR(info->map);
+
+	info->clk = devm_clk_get_enabled(dev, "dac");
+	if (IS_ERR(info->clk))
+		return dev_err_probe(dev, PTR_ERR(info->clk),
+				     "failed getting clock\n");
+
+	platform_set_drvdata(pdev, indio_dev);
+
+	indio_dev->name = "mcf54415";
+	indio_dev->info = &mcf54415_dac_iio_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = mcf54415_dac_iio_channels;
+	indio_dev->num_channels = ARRAY_SIZE(mcf54415_dac_iio_channels);
+
+	mcf54415_dac_init(info);
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
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct mcf54415_dac *info = iio_priv(indio_dev);
+
+	mcf54415_dac_exit(info);
+	clk_disable_unprepare(info->clk);
+
+	return 0;
+}
+
+static int mcf54415_dac_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct mcf54415_dac *info = iio_priv(indio_dev);
+	int ret;
+
+	ret = clk_prepare_enable(info->clk);
+	if (ret)
+		return ret;
+
+	mcf54415_dac_init(info);
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(mcf54415_dac_pm_ops,
+				mcf54415_dac_suspend,
+				mcf54415_dac_resume);
+
+static struct platform_driver mcf54415_dac_driver = {
+	.probe = mcf54415_dac_probe,
+	.driver = {
+		.name = "mcf54415_dac",
+		.pm = pm_sleep_ptr(&mcf54415_dac_pm_ops),
+	},
+};
+module_platform_driver(mcf54415_dac_driver);
+
+MODULE_AUTHOR("Angelo Dureghello <angelo@kernel-space.org>");
+MODULE_DESCRIPTION("NXP MCF54415 DAC driver");
+MODULE_LICENSE("GPL");

-- 
2.54.0

