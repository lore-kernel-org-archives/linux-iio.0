Return-Path: <SRS0=TPgR=R5=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181FEC43381
	for <linux-iio@archiver.kernel.org>; Tue, 26 Mar 2019 14:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D20422075C
	for <linux-iio@archiver.kernel.org>; Tue, 26 Mar 2019 14:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730697AbfCZOvn (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 26 Mar 2019 10:51:43 -0400
Received: from mga03.intel.com ([134.134.136.65]:13201 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbfCZOvn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 26 Mar 2019 10:51:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP; 26 Mar 2019 07:51:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,271,1549958400"; 
   d="scan'208";a="134948640"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 26 Mar 2019 07:51:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 53C6E2E7; Tue, 26 Mar 2019 16:51:38 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Vincent Pelletier <plr.vincent@gmail.com>,
        Tomasz Duszynski <tduszyns@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2] iio: adc: intel_mrfld_adc: Add Basin Cove ADC driver
Date:   Tue, 26 Mar 2019 16:51:38 +0200
Message-Id: <20190326145138.19717-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Vincent Pelletier <plr.vincent@gmail.com>

Exposes the ADC device present on, at least, Intel Merrifield platform.

Based on work done by:
  Yang Bin <bin.yang@intel.com>
  Huiquan Zhong <huiquan.zhong@intel.com>
  Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
  Pavan Kumar S <pavan.kumar.s@intel.com>

Though it has been heavily rewritten for upstream.

Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
- reordered headers, dependent on the patch against iio/driver.h (Jonathan, Tomasz)
- dropped buffer dead code (Tomasz)
- used get_unaligned_be16() (Tomasz)
- replaced iio_device_{claim,release}_direct_mode by mutex (Tomasz)
- COMPILE_TEST is not included due to implicit x86 requirement anyway (via MFD)

 drivers/iio/adc/Kconfig           |  11 ++
 drivers/iio/adc/Makefile          |   1 +
 drivers/iio/adc/intel_mrfld_adc.c | 262 ++++++++++++++++++++++++++++++
 3 files changed, 274 insertions(+)
 create mode 100644 drivers/iio/adc/intel_mrfld_adc.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 76db6e5cc296..88b06393d152 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -419,6 +419,17 @@ config INGENIC_ADC
 	  This driver can also be built as a module. If so, the module will be
 	  called ingenic_adc.
 
+config INTEL_MRFLD_ADC
+	tristate "Intel Merrifield Basin Cove ADC driver"
+	depends on INTEL_SOC_PMIC_MRFLD
+	help
+	  Say yes here to have support for Basin Cove power management IC (PMIC) ADC
+	  device. Depending on platform configuration, this general purpose ADC can
+	  be used for sampling sensors such as thermal resistors.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called intel_mrfld_adc.
+
 config IMX7D_ADC
 	tristate "Freescale IMX7D ADC driver"
 	depends on ARCH_MXC || COMPILE_TEST
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 6fcebd167524..6cbf2e5a51a7 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -41,6 +41,7 @@ obj-$(CONFIG_HX711) += hx711.o
 obj-$(CONFIG_IMX7D_ADC) += imx7d_adc.o
 obj-$(CONFIG_INA2XX_ADC) += ina2xx-adc.o
 obj-$(CONFIG_INGENIC_ADC) += ingenic-adc.o
+obj-$(CONFIG_INTEL_MRFLD_ADC) += intel_mrfld_adc.o
 obj-$(CONFIG_LP8788_ADC) += lp8788_adc.o
 obj-$(CONFIG_LPC18XX_ADC) += lpc18xx_adc.o
 obj-$(CONFIG_LPC32XX_ADC) += lpc32xx_adc.o
diff --git a/drivers/iio/adc/intel_mrfld_adc.c b/drivers/iio/adc/intel_mrfld_adc.c
new file mode 100644
index 000000000000..67d096f8180d
--- /dev/null
+++ b/drivers/iio/adc/intel_mrfld_adc.c
@@ -0,0 +1,262 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ADC driver for Basin Cove PMIC
+ *
+ * Copyright (C) 2012 Intel Corporation
+ * Author: Bin Yang <bin.yang@intel.com>
+ *
+ * Rewritten for upstream by:
+ *	 Vincent Pelletier <plr.vincent@gmail.com>
+ *	 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/completion.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/intel_soc_pmic.h>
+#include <linux/mfd/intel_soc_pmic_mrfld.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include <linux/iio/driver.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/machine.h>
+
+#include <asm/unaligned.h>
+
+#define BCOVE_GPADCREQ			0xDC
+#define BCOVE_GPADCREQ_BUSY		BIT(0)
+#define BCOVE_GPADCREQ_IRQEN		BIT(1)
+
+#define BCOVE_ADCIRQ_ALL (		\
+	BCOVE_ADCIRQ_BATTEMP |		\
+	BCOVE_ADCIRQ_SYSTEMP |		\
+	BCOVE_ADCIRQ_BATTID |		\
+	BCOVE_ADCIRQ_VIBATT |		\
+	BCOVE_ADCIRQ_CCTICK)
+
+#define BCOVE_ADC_TIMEOUT		msecs_to_jiffies(1000)
+
+static const u8 mrfld_adc_requests[] = {
+	BCOVE_ADCIRQ_VIBATT,
+	BCOVE_ADCIRQ_BATTID,
+	BCOVE_ADCIRQ_VIBATT,
+	BCOVE_ADCIRQ_SYSTEMP,
+	BCOVE_ADCIRQ_BATTEMP,
+	BCOVE_ADCIRQ_BATTEMP,
+	BCOVE_ADCIRQ_SYSTEMP,
+	BCOVE_ADCIRQ_SYSTEMP,
+	BCOVE_ADCIRQ_SYSTEMP,
+};
+
+struct mrfld_adc {
+	struct regmap *regmap;
+	struct completion completion;
+	/* Lock to protect the IPC transfers */
+	struct mutex lock;
+};
+
+static irqreturn_t mrfld_adc_thread_isr(int irq, void *data)
+{
+	struct iio_dev *indio_dev = data;
+	struct mrfld_adc *adc = iio_priv(indio_dev);
+
+	complete(&adc->completion);
+	return IRQ_HANDLED;
+}
+
+static int mrfld_adc_single_conv(struct iio_dev *indio_dev,
+				 struct iio_chan_spec const *chan,
+				 int *result)
+{
+	struct mrfld_adc *adc = iio_priv(indio_dev);
+	struct regmap *regmap = adc->regmap;
+	unsigned int req;
+	long timeout;
+	u8 buf[2];
+	int ret;
+
+	reinit_completion(&adc->completion);
+
+	regmap_update_bits(regmap, BCOVE_MADCIRQ, BCOVE_ADCIRQ_ALL, 0);
+	regmap_update_bits(regmap, BCOVE_MIRQLVL1, BCOVE_LVL1_ADC, 0);
+
+	ret = regmap_read_poll_timeout(regmap, BCOVE_GPADCREQ, req,
+				       !(req & BCOVE_GPADCREQ_BUSY),
+				       2000, 1000000);
+	if (ret)
+		goto done;
+
+	req = mrfld_adc_requests[chan->channel];
+	ret = regmap_write(regmap, BCOVE_GPADCREQ, BCOVE_GPADCREQ_IRQEN | req);
+	if (ret)
+		goto done;
+
+	timeout = wait_for_completion_interruptible_timeout(&adc->completion,
+							    BCOVE_ADC_TIMEOUT);
+	if (timeout < 0) {
+		ret = timeout;
+		goto done;
+	}
+	if (timeout == 0) {
+		ret = -ETIMEDOUT;
+		goto done;
+	}
+
+	ret = regmap_bulk_read(regmap, chan->address, buf, 2);
+	if (ret)
+		goto done;
+
+	*result = get_unaligned_be16(buf);
+	ret = IIO_VAL_INT;
+
+done:
+	regmap_update_bits(regmap, BCOVE_MIRQLVL1, BCOVE_LVL1_ADC, 0xff);
+	regmap_update_bits(regmap, BCOVE_MADCIRQ, BCOVE_ADCIRQ_ALL, 0xff);
+
+	return ret;
+}
+
+static int mrfld_adc_read_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int *val, int *val2, long mask)
+{
+	struct mrfld_adc *adc = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&adc->lock);
+		ret = mrfld_adc_single_conv(indio_dev, chan, val);
+		mutex_unlock(&adc->lock);
+		return ret;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info mrfld_adc_iio_info = {
+	.read_raw = &mrfld_adc_read_raw,
+};
+
+#define BCOVE_ADC_CHANNEL(_type, _channel, _datasheet_name, _address)	\
+	{								\
+		.indexed = 1,						\
+		.type = _type,						\
+		.channel = _channel,					\
+		.address = _address,					\
+		.datasheet_name = _datasheet_name,			\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+	}
+
+static const struct iio_chan_spec mrfld_adc_channels[] = {
+	BCOVE_ADC_CHANNEL(IIO_VOLTAGE,    0, "CH0", 0xE9),
+	BCOVE_ADC_CHANNEL(IIO_RESISTANCE, 1, "CH1", 0xEB),
+	BCOVE_ADC_CHANNEL(IIO_CURRENT,    2, "CH2", 0xED),
+	BCOVE_ADC_CHANNEL(IIO_TEMP,       3, "CH3", 0xCC),
+	BCOVE_ADC_CHANNEL(IIO_TEMP,       4, "CH4", 0xC8),
+	BCOVE_ADC_CHANNEL(IIO_TEMP,       5, "CH5", 0xCA),
+	BCOVE_ADC_CHANNEL(IIO_TEMP,       6, "CH6", 0xC2),
+	BCOVE_ADC_CHANNEL(IIO_TEMP,       7, "CH7", 0xC4),
+	BCOVE_ADC_CHANNEL(IIO_TEMP,       8, "CH8", 0xC6),
+};
+
+static struct iio_map iio_maps[] = {
+	IIO_MAP("CH0", "bcove-battery", "VBATRSLT"),
+	IIO_MAP("CH1", "bcove-battery", "BATTID"),
+	IIO_MAP("CH2", "bcove-battery", "IBATRSLT"),
+	IIO_MAP("CH3", "bcove-temp",    "PMICTEMP"),
+	IIO_MAP("CH4", "bcove-temp",    "BATTEMP0"),
+	IIO_MAP("CH5", "bcove-temp",    "BATTEMP1"),
+	IIO_MAP("CH6", "bcove-temp",    "SYSTEMP0"),
+	IIO_MAP("CH7", "bcove-temp",    "SYSTEMP1"),
+	IIO_MAP("CH8", "bcove-temp",    "SYSTEMP2"),
+	{}
+};
+
+static int mrfld_adc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct intel_soc_pmic *pmic = dev_get_drvdata(dev->parent);
+	struct iio_dev *indio_dev;
+	struct mrfld_adc *adc;
+	int irq;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*indio_dev));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	adc = iio_priv(indio_dev);
+
+	mutex_init(&adc->lock);
+	init_completion(&adc->completion);
+	adc->regmap = pmic->regmap;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	ret = devm_request_threaded_irq(dev, irq, NULL, mrfld_adc_thread_isr,
+					IRQF_ONESHOT | IRQF_SHARED, pdev->name,
+					indio_dev);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, indio_dev);
+
+	indio_dev->dev.parent = dev;
+	indio_dev->name = pdev->name;
+
+	indio_dev->channels = mrfld_adc_channels;
+	indio_dev->num_channels = ARRAY_SIZE(mrfld_adc_channels);
+	indio_dev->info = &mrfld_adc_iio_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = iio_map_array_register(indio_dev, iio_maps);
+	if (ret)
+		return ret;
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret < 0)
+		goto err_array_unregister;
+
+	return 0;
+
+err_array_unregister:
+	iio_map_array_unregister(indio_dev);
+	return ret;
+}
+
+static int mrfld_adc_remove(struct platform_device *pdev)
+{
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+
+	iio_map_array_unregister(indio_dev);
+
+	return 0;
+}
+
+static const struct platform_device_id mrfld_adc_id_table[] = {
+	{ .name = "mrfld_bcove_adc" },
+	{}
+};
+MODULE_DEVICE_TABLE(platform, mrfld_adc_id_table);
+
+static struct platform_driver mrfld_adc_driver = {
+	.driver = {
+		.name = "mrfld_bcove_adc",
+	},
+	.probe = mrfld_adc_probe,
+	.remove = mrfld_adc_remove,
+	.id_table = mrfld_adc_id_table,
+};
+module_platform_driver(mrfld_adc_driver);
+
+MODULE_AUTHOR("Bin Yang <bin.yang@intel.com>");
+MODULE_AUTHOR("Vincent Pelletier <plr.vincent@gmail.com>");
+MODULE_AUTHOR("Andy Shevchenko <andriy.shevchenko@linux.intel.com>");
+MODULE_DESCRIPTION("ADC driver for Basin Cove PMIC");
+MODULE_LICENSE("GPL v2");
-- 
2.20.1

