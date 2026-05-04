Received: from mail.kernel-space.org (v2202511311555398556.powersrv.de [46.38.245.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A913E3D94;
	Mon,  4 May 2026 17:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.245.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777915045; cv=none; b=TFtHX4Gh+r3+vBPBIfZnzDyN/Dgl0rtwcPKfPnESWuEWGrmUXja4z3OMOIDDd055Vo4peMDTSsifsFHUo4LbYiXO3YfFBsW93EXKG3f3ncLdmEdiybeXP9+55dJ01WXFht+ZLjpcfQftbYdI71xF0IwncM2f02a11H+kmmraaHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777915045; c=relaxed/simple;
	bh=cuHant5v1i0R8QScEMhqBEqLyPQGj9LB7hQLGCNzG2Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SJc/0gnDJysk2K3JVunka4qFddoWYhjijnA1Wlyl4ta+Ohu5woZwNWSLxL/1uCDKSaHVmqG/QEIo3O9t/WCrBjEzx/ouJsdokQz0G4IaSR8g37JgdwnyIZRwXpyN/4HEtYsPTt6YBLpwYurXrwgMuM2cfPmheipv2jXn+0t6YDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernel-space.org; spf=pass smtp.mailfrom=kernel-space.org; dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b=eDT1bIqi; arc=none smtp.client-ip=46.38.245.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel-space.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b="eDT1bIqi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
	s=s1; t=1777915007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SF9ujtZqkg8d6XrkmCnPPxOB0sj3C+v6KmHyURSyaJQ=;
	b=eDT1bIqixS8pNGPoQK/ss2hnGH1OH0SjZe5QFAo6c9FMidY5MsieyhPUIKzeva+kRSBOeA
	5XuTrTUtMwhfJ8uO74jX13XA/eFrWpF4JyRQ2aTDMTo0ID16V5szTJV3HiM5UuXAii/5aN
	a1yJAk6VktBHWRHb9+yZE3Vy8fOx23U=
Received: from [192.168.0.2] (<unknown> [2a07:7e81:7daa:0:62cf:84ff:feee:627])
	by oreshnik (OpenSMTPD) with ESMTPSA id a01d32f2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 4 May 2026 17:16:47 +0000 (UTC)
From: Angelo Dureghello <angelo@kernel-space.org>
Date: Mon, 04 May 2026 19:16:48 +0200
Subject: [PATCH 10/10] iio: dac: add mcf54415 DAC
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-wip-stmark2-dac-v1-10-874c36a4910d@baylibre.com>
References: <20260504-wip-stmark2-dac-v1-0-874c36a4910d@baylibre.com>
In-Reply-To: <20260504-wip-stmark2-dac-v1-0-874c36a4910d@baylibre.com>
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
analog output varying from ~DAC_VREFL to ~DAC_VREFH. The DAC module
consists of a conversion unit, an output amplifier, and the associated
digital control blocks. DAC_VREFL and DAC_VREFH defaults respectivley to
0 and 0xfff.

This initial version of the driver is minimalistic, "output raw" only, to
be extended in the future. DMA and external sync are disabled, default mode
is high speed, default format is right-justified 12bit on 16bit word.

Basic tests done on stmark2 mcf54415-based board, voltage check on DAC0:

/sys/bus/iio/devices/iio:device0 # ls
name                 out_voltage_raw      subsystem
out_conversion_mode  out_voltage_scale    uevent

/sys/bus/iio/devices/iio:device0 # cat name
mcf54415_dac.0

/sys/bus/iio/devices/iio:device0 #

echo 4095 > out_voltage_raw     => voltage abt 3.3V by oscilloscope
echo 4096 > out_voltage_raw     => roll over to 0V
echo 0 > out_voltage_raw        => voltage is 0V
echo 2048 > out_voltage_raw     => voltage is abt 1.7V, mid scale

Same behavior for /sys/bus/iio/devices/iio:device1.

Generated a sine wave by shell script, sine shape is good.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/Kconfig        |  10 +++
 drivers/iio/dac/Makefile       |   1 +
 drivers/iio/dac/mcf54415_dac.c | 200 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 211 insertions(+)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index cd4870b65415..17550e99cfdd 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -516,6 +516,16 @@ config MAX5821
 	  Say yes here to build support for Maxim MAX5821
 	  10 bits DAC.
 
+config MCF54415_DAC
+	tristate "NXP MCF54415 DAC driver"
+	depends on M5441x
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
index 000000000000..4031a5dc1f9d
--- /dev/null
+++ b/drivers/iio/dac/mcf54415_dac.c
@@ -0,0 +1,200 @@
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
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
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
+#define MCF54415_DAC_READY_US		12
+
+struct mcf54415_dac {
+	struct clk *clk;
+	struct device *dev;
+	void __iomem *regs;
+};
+
+static void mcf54415_dac_init(struct mcf54415_dac *info)
+{
+	int val;
+
+	/* Keeping defaults and enable DAC (bit 0 set to 0) */
+	val = MCF54415_DAC_CR_FILT;
+	val |= FIELD_PREP(MCF54415_DAC_CR_WMLVL, 1);
+
+	writew(val, info->regs + MCF54415_DAC_CR);
+
+	/* DAC is ready after 12us, from RM table 40-3  */
+	fsleep(MCF54415_DAC_READY_US);
+}
+
+static void mcf54415_dac_exit(void *data)
+{
+	struct mcf54415_dac *info = data;
+	int val;
+
+	val = readw(info->regs + MCF54415_DAC_CR);
+	val |= MCF54415_DAC_CR_PDN;
+	writew(val, info->regs + MCF54415_DAC_CR);
+}
+
+#define MCF54415_DAC_CHAN { \
+	.type = IIO_VOLTAGE, \
+	.output = 1, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
+}
+
+static const struct iio_chan_spec mcf54415_dac_iio_channels[] = {
+	MCF54415_DAC_CHAN
+};
+
+static int mcf54415_read_raw(struct iio_dev *indio_dev,
+			struct iio_chan_spec const *chan,
+			int *val, int *val2,
+			long mask)
+{
+	struct mcf54415_dac *info = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		*val = readw(info->regs + MCF54415_DAC_DATA);
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		/* Reference voltage as per ColdFire datasheet is 3.3V */
+		*val = 3300 /* mV */;
+		*val2 = 12;
+		return IIO_VAL_FRACTIONAL_LOG2;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int mcf54415_write_raw(struct iio_dev *indio_dev,
+			struct iio_chan_spec const *chan,
+			int val, int val2,
+			long mask)
+{
+	struct mcf54415_dac *info = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		writew(val, info->regs + MCF54415_DAC_DATA);
+		return 0;
+
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
+	struct iio_dev *indio_dev;
+	struct mcf54415_dac *info;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&pdev->dev,
+					  sizeof(struct mcf54415_dac));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	info = iio_priv(indio_dev);
+	info->dev = &pdev->dev;
+
+	info->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(info->regs))
+		return dev_err_probe(&pdev->dev, PTR_ERR(info->regs),
+				     "failed to get io regs\n");
+
+	info->clk = devm_clk_get_enabled(&pdev->dev, "dac");
+	if (IS_ERR(info->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(info->clk),
+				     "failed getting clock\n");
+
+	platform_set_drvdata(pdev, indio_dev);
+
+	indio_dev->name = dev_name(&pdev->dev);
+	indio_dev->info = &mcf54415_dac_iio_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = mcf54415_dac_iio_channels;
+	indio_dev->num_channels = ARRAY_SIZE(mcf54415_dac_iio_channels);
+
+	mcf54415_dac_init(info);
+
+	ret = devm_add_action_or_reset(&pdev->dev, mcf54415_dac_exit, info);
+	if (ret)
+		return ret;
+
+	ret = devm_iio_device_register(&pdev->dev, indio_dev);
+	if (ret)
+		dev_err(&pdev->dev, "couldn't register the device\n");
+
+	return ret;
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
+static DEFINE_SIMPLE_DEV_PM_OPS(mcf54415_dac_pm_ops, mcf54415_dac_suspend,
+				mcf54415_dac_resume);
+
+static struct platform_driver mcf54415_dac_driver = {
+	.probe          = mcf54415_dac_probe,
+	.driver         = {
+		.name   = "mcf54415_dac",
+		.pm     = pm_sleep_ptr(&mcf54415_dac_pm_ops),
+	},
+};
+module_platform_driver(mcf54415_dac_driver);
+
+MODULE_AUTHOR("Angelo Dureghello <angelo@kernel-space.org>");
+MODULE_DESCRIPTION("NXP MCF54415 DAC driver");
+MODULE_LICENSE("GPL");

-- 
2.54.0

