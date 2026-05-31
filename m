Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724783914FF
	for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 15:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780241174; cv=none; b=qRVYbmOa4Lqh4E3pOuN+1i7ocfU6udJ+8AvChh1GkKyqkEWwJOxBXeuTRcPUhyv2JDncXIJqIYZnJuTldoCsoAq9IubzQkVT8Adaursf9SdGyaLW9aMcmbS42Nc3rZ7rxxNk3P2yRIiqCktE0z5uF3u3HDm09s02GDR3igsg6Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780241174; c=relaxed/simple;
	bh=23oTPBHvXItUdTs2c6G8aZFherUEjBkcOigiHSGyId4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pmy3uM/nsVhRBXL0ydU6neZ968jdB0mIHUpJfuba8BMQ0GnJNouM1aZnjH6+0LUK0nHGNNgQuL46+NXs3GDpoDeq7fVriduquymZJM1rOn/UFOyl83cdLzuO+kL9v8/OsnyrC2FtSjbc5KnwmIL82zsvEiBcQiFoiZ0W4L5+nxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=DWlq7NYK; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="DWlq7NYK"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-45eecb8bf67so2385784f8f.2
        for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 08:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1780241170; x=1780845970; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vbLPyTAr/7pOES4+QYKflXQW79LkqiEBBw61edcaLvY=;
        b=DWlq7NYKVHunnLN2AW8sw23hsw+GD+UwUFKbWeq1sIX+G5D5qMQNPSkn/iTn4oNA2b
         7wFSxTCkpYnFOh690F9btAi7EvLQAR98042q3CKcRfQDCeClY/dWsWEgbZSfq0CxF6Y9
         MBuM5Dcmqqavj2jdHoHJIOScZ4fN8qLjDeCUIpg6sDFv6cPOe2rJFGIq7ka/M1DzQajL
         BhEEbLhXcWnVQKJf60rggTOP2PA8C04scWf0Jda28NSMnD+gDBUzGjKtu7qPlgl2l03i
         ndN1yPf4RT9WVDPa8GWTvepc0USoCeynE61ztxfNsPFeAq2IGOf3PlVHTSR1zsqC6Gfq
         otRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780241170; x=1780845970;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vbLPyTAr/7pOES4+QYKflXQW79LkqiEBBw61edcaLvY=;
        b=ieIWoQn1fbh6LwkuJBbxU/s6B09GLChC/2ZWnGJsJieunuivz2xr3Vcfj7532Mtv/F
         TtrC5eHX2DiO9as+dKqYzw0mihntmwxl2w/RbhYr1z9HH6gB2aUkG2jxAAMy3G5UYpI5
         g5UCF4NbRgVCzXkbGe1HRxz1ygTP2xrsBxGC3B0ObKovUuj9km9d7CQaO58AynaEFVXf
         LYdJXB3IbZGf9OWuotm46CAMHquWaz3CgKEXOCDBpva/YvXFJkmYtx0+UCao3yDs7zIA
         vqHlUTZPNRWWqCpaL88yZ4ehWkwx0k2xn6fIGJJpN2SV2Ia63waiODX7G34EfYstL84P
         bmOA==
X-Forwarded-Encrypted: i=1; AFNElJ+yh2/46LrIEHZK0jEcrOtY7+02eL6/0oHmipcHpGIIyItjAUXLR4mwxGcrMIyTP2gKAyt/JMiNIKs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/WkDqj9SpJLYAc47UlM8I96ojdbUT13BoRJxlnuw3ZRMHkJXq
	/jLVozEBZ2ScW5ujavgenA8poRwBPp9FRvXwx8k7e9J09LboIDplumAw69AfWpXOueuD/FvtlDD
	nhlTi1CM=
X-Gm-Gg: Acq92OFEfglKUdcx0wELFzooKdAXSJo1P4VmnapZz56NDtJ3CkHw3Ro5hFhZxeieK4m
	sq0hwPQV4vHIlCyybDTYAJMP3lOxyQPwpWcRmrxdytIgQN8g1NWk5mLpluIHzjxmdVodZcIyiJq
	JtrmbjjiEuxTuF8JkWr65353fzg/y07wfrT3iOeq3md5zNXRGYSI8YAwXmWLKUeJIlSGXKAvMvl
	IEbLgwb0eUJxvjvqiq/rk6TzDa6NK6/s+m4U8fBZStS5T31SVqkSnvdTtzmNlDVaNf7K775lBT3
	QbbdTqFLw9xb5q1Knf/wn5uTZ71ZFHzfcefzZ2LDbVmgJbXb/4swWoZER6kJwV0JRCFIHpyKnKn
	qPHwwH9xpVnRSrP7uDYzr2hfmXSvxJzR7xwIs3BNRqiHBtXNUaH/Tq4wKV28+NiEhGTCG/RjUia
	NWDPWynutxg++Lw6Wi8vAi3eaTIjPigSuReILQ+l9bPA==
X-Received: by 2002:a05:6000:e11:b0:45e:73b3:8118 with SMTP id ffacd0b85a97d-45ef6b79fa7mr8922789f8f.29.1780241169883;
        Sun, 31 May 2026 08:26:09 -0700 (PDT)
Received: from [192.168.0.2] ([2a07:7e81:7daa:0:202:c9ff:fe53:eda4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354cf0dsm18526622f8f.17.2026.05.31.08.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 08:26:09 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Sun, 31 May 2026 17:26:04 +0200
Subject: [PATCH v4 11/11] iio: dac: add mcf54415 DAC
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-wip-stmark2-dac-v4-11-7e65ab4215dd@baylibre.com>
References: <20260531-wip-stmark2-dac-v4-0-7e65ab4215dd@baylibre.com>
In-Reply-To: <20260531-wip-stmark2-dac-v4-0-7e65ab4215dd@baylibre.com>
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
---
 drivers/iio/dac/Kconfig        |  11 +++
 drivers/iio/dac/Makefile       |   1 +
 drivers/iio/dac/mcf54415_dac.c | 211 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 223 insertions(+)

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
index 000000000000..474a2c327fcd
--- /dev/null
+++ b/drivers/iio/dac/mcf54415_dac.c
@@ -0,0 +1,211 @@
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
+#include <linux/compiler_types.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
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
+	int ret;
+	u16 val = MCF54415_DAC_CR_FILT | FIELD_PREP(MCF54415_DAC_CR_WMLVL, 1);
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
+	int ret;
+	u32 reg;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = regmap_read(info->map, MCF54415_DAC_DATA, &reg);
+		if (ret)
+			return ret;
+		*val = (int)reg & 0xfff;
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
+		return ret;
+	}
+
+	return 0;
+
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(mcf54415_dac_pm_ops,
+				mcf54415_dac_suspend, mcf54415_dac_resume);
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

