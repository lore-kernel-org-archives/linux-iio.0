Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:34869 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753691AbdK1PI1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Nov 2017 10:08:27 -0500
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
To: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC: <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <arnaud.pouliquen@st.com>
Subject: [PATCH v5 06/13] IIO: ADC: add sigma delta modulator support
Date: Tue, 28 Nov 2017 16:05:50 +0100
Message-ID: <1511881557-28596-7-git-send-email-arnaud.pouliquen@st.com>
In-Reply-To: <1511881557-28596-1-git-send-email-arnaud.pouliquen@st.com>
References: <1511881557-28596-1-git-send-email-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add generic driver to support sigma delta modulators.
Typically, this device is hardware connected to
an IIO device in charge of the conversion. Devices are
bonded through the hardware consumer API.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
V4-> v5
  - Add mare descritpion in commit message.
  - Suppress scan_index specification in iio_chan_spec .
 
 drivers/iio/adc/Kconfig            | 12 ++++++
 drivers/iio/adc/Makefile           |  1 +
 drivers/iio/adc/sd_adc_modulator.c | 81 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 94 insertions(+)
 create mode 100644 drivers/iio/adc/sd_adc_modulator.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 5762565..c5db62f 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -626,6 +626,18 @@ config SPEAR_ADC
 	  To compile this driver as a module, choose M here: the
 	  module will be called spear_adc.
 
+config SD_ADC_MODULATOR
+	tristate "Generic sigma delta modulator"
+	depends on OF
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  Select this option to enables sigma delta modulator. This driver can
+	  support generic sigma delta modulators.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called sd_adc_modulator.
+
 config STM32_ADC_CORE
 	tristate "STMicroelectronics STM32 adc core"
 	depends on ARCH_STM32 || COMPILE_TEST
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 9874e05..d800325 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -81,3 +81,4 @@ obj-$(CONFIG_VF610_ADC) += vf610_adc.o
 obj-$(CONFIG_VIPERBOARD_ADC) += viperboard_adc.o
 xilinx-xadc-y := xilinx-xadc-core.o xilinx-xadc-events.o
 obj-$(CONFIG_XILINX_XADC) += xilinx-xadc.o
+obj-$(CONFIG_SD_ADC_MODULATOR) += sd_adc_modulator.o
diff --git a/drivers/iio/adc/sd_adc_modulator.c b/drivers/iio/adc/sd_adc_modulator.c
new file mode 100644
index 0000000..08bd7b6
--- /dev/null
+++ b/drivers/iio/adc/sd_adc_modulator.c
@@ -0,0 +1,81 @@
+/*
+ * Generic sigma delta modulator driver
+ *
+ * Copyright (C) 2017, STMicroelectronics - All Rights Reserved
+ * Author: Arnaud Pouliquen <arnaud.pouliquen@st.com>.
+ *
+ * License type: GPLv2
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+ * or FITNESS FOR A PARTICULAR PURPOSE.
+ * See the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/iio/iio.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+
+static const struct iio_info iio_sd_mod_iio_info;
+
+static const struct iio_chan_spec iio_sd_mod_ch = {
+	.type = IIO_VOLTAGE,
+	.indexed = 1,
+	.scan_type = {
+		.sign = 'u',
+		.realbits = 1,
+		.shift = 0,
+	},
+};
+
+static int iio_sd_mod_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct iio_dev *iio;
+
+	iio = devm_iio_device_alloc(dev, 0);
+	if (!iio)
+		return -ENOMEM;
+
+	iio->dev.parent = dev;
+	iio->dev.of_node = dev->of_node;
+	iio->name = dev_name(dev);
+	iio->info = &iio_sd_mod_iio_info;
+	iio->modes = INDIO_BUFFER_HARDWARE;
+
+	iio->num_channels = 1;
+	iio->channels = &iio_sd_mod_ch;
+
+	platform_set_drvdata(pdev, iio);
+
+	return devm_iio_device_register(&pdev->dev, iio);
+}
+
+static const struct of_device_id sd_adc_of_match[] = {
+	{ .compatible = "sd-modulator" },
+	{ .compatible = "ads1201" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sd_adc_of_match);
+
+static struct platform_driver iio_sd_mod_adc = {
+	.driver = {
+		.name = "iio_sd_adc_mod",
+		.of_match_table = of_match_ptr(sd_adc_of_match),
+	},
+	.probe = iio_sd_mod_probe,
+};
+
+module_platform_driver(iio_sd_mod_adc);
+
+MODULE_DESCRIPTION("Basic sigma delta modulator");
+MODULE_AUTHOR("Arnaud Pouliquen <arnaud.pouliquen@st.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

