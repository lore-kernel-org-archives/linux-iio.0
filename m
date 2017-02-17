Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:14874 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934337AbdBQQFV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Feb 2017 11:05:21 -0500
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>, <linux@armlinux.org.uk>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux-iio@vger.kernel.org>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <fabrice.gasnier@st.com>, <benjamin.gaignard@linaro.org>,
        <benjamin.gaignard@st.com>, <linus.walleij@linaro.org>
Subject: [RFC 4/4] iio: trigger: add GPIO trigger
Date: Fri, 17 Feb 2017 17:03:49 +0100
Message-ID: <1487347429-31761-5-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1487347429-31761-1-git-send-email-fabrice.gasnier@st.com>
References: <1487347429-31761-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

GPIOs can be used to generate triggers for any IIO device.
Introduce generic GPIO trigger driver. It offers some options
to tune polarity (e.g. rising/falling edge), and label so trigger
name may be customized.
By default, gpio triggers will be named gpiotrigX, where X is gpio
number as returned by desc_to_gpio() call.
Rising edge is selected if polarity isn't set.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/trigger/Kconfig         |   9 +++
 drivers/iio/trigger/Makefile        |   1 +
 drivers/iio/trigger/iio-trig-gpio.c | 112 ++++++++++++++++++++++++++++++++++++
 3 files changed, 122 insertions(+)
 create mode 100644 drivers/iio/trigger/iio-trig-gpio.c

diff --git a/drivers/iio/trigger/Kconfig b/drivers/iio/trigger/Kconfig
index e4d4e63..54b6706 100644
--- a/drivers/iio/trigger/Kconfig
+++ b/drivers/iio/trigger/Kconfig
@@ -5,6 +5,15 @@
 
 menu "Triggers - standalone"
 
+config IIO_GPIO_TRIGGER
+	tristate "Generic GPIO trigger"
+	help
+	  Provides support for a GPIO based IIO trigger, when trigger
+	  source has been connected to a GPIO line.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called iio-gpio-trigger.
+
 config IIO_HRTIMER_TRIGGER
 	tristate "High resolution timer trigger"
 	depends on IIO_SW_TRIGGER
diff --git a/drivers/iio/trigger/Makefile b/drivers/iio/trigger/Makefile
index 5c4ecd3..a984668 100644
--- a/drivers/iio/trigger/Makefile
+++ b/drivers/iio/trigger/Makefile
@@ -4,6 +4,7 @@
 
 # When adding new entries keep the list in alphabetical order
 
+obj-$(CONFIG_IIO_GPIO_TRIGGER) += iio-trig-gpio.o
 obj-$(CONFIG_IIO_HRTIMER_TRIGGER) += iio-trig-hrtimer.o
 obj-$(CONFIG_IIO_INTERRUPT_TRIGGER) += iio-trig-interrupt.o
 obj-$(CONFIG_IIO_STM32_TIMER_TRIGGER) += stm32-timer-trigger.o
diff --git a/drivers/iio/trigger/iio-trig-gpio.c b/drivers/iio/trigger/iio-trig-gpio.c
new file mode 100644
index 0000000..4b48df0
--- /dev/null
+++ b/drivers/iio/trigger/iio-trig-gpio.c
@@ -0,0 +1,112 @@
+/*
+ * Industrial I/O - GPIO based trigger support
+ *
+ * Copyright (C) 2017, STMicroelectronics - All Rights Reserved
+ * Author: Fabrice Gasnier <fabrice.gasnier@st.com>.
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
+#include <linux/gpio/consumer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+static const struct iio_trigger_ops iio_gpio_trigger_ops = {
+	.owner = THIS_MODULE,
+};
+
+static int iio_gpio_trigger_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct gpio_desc *gpio;
+	char name[16];
+	const char *label = NULL;
+	struct iio_trigger *trig;
+	unsigned long irqflags = IRQF_SHARED;
+	int irq, ret;
+
+	gpio = devm_gpiod_get(&pdev->dev, NULL, GPIOD_IN);
+	if (IS_ERR(gpio)) {
+		if (PTR_ERR(gpio) != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "gpio get failed (%ld)\n",
+				PTR_ERR(gpio));
+		return PTR_ERR(gpio);
+	}
+
+	if (of_property_read_string(np, "label", &label))
+		snprintf(name, sizeof(name), "gpiotrig%d", desc_to_gpio(gpio));
+
+	if (of_property_read_bool(np, "gpio-trigger-rising-edge"))
+		irqflags |= IRQF_TRIGGER_RISING;
+
+	if (of_property_read_bool(np, "gpio-trigger-falling-edge"))
+		irqflags |= IRQF_TRIGGER_FALLING;
+
+	/* Default to rising edge */
+	if (!(irqflags & IRQF_TRIGGER_MASK))
+		irqflags |= IRQF_TRIGGER_RISING;
+
+	trig = devm_iio_trigger_alloc(&pdev->dev, "%s", label ? label : name);
+	if (!trig)
+		return -ENOMEM;
+	trig->dev.parent = &pdev->dev;
+	trig->dev.of_node = pdev->dev.of_node;
+	trig->ops = &iio_gpio_trigger_ops;
+
+	irq = gpiod_to_irq(gpio);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "gpio %d to irq failed (%d)\n",
+			desc_to_gpio(gpio), irq);
+		return irq;
+	}
+
+	ret = devm_request_irq(&pdev->dev, irq,
+			       iio_trigger_generic_data_rdy_poll, irqflags,
+			       trig->name, trig);
+	if (ret) {
+		dev_err(&pdev->dev, "request IRQ %d failed\n", irq);
+		return ret;
+	}
+
+	ret = devm_iio_trigger_register(&pdev->dev, trig);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id iio_gpio_trigger_of_match[] = {
+	{ .compatible = "iio-gpio-trigger" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, iio_gpio_trigger_of_match);
+#endif
+
+static struct platform_driver iio_gpio_trigger_driver = {
+	.probe = iio_gpio_trigger_probe,
+	.driver = {
+		.name = "iio-gpio-trigger",
+		.of_match_table = of_match_ptr(iio_gpio_trigger_of_match),
+	},
+};
+module_platform_driver(iio_gpio_trigger_driver);
+
+MODULE_AUTHOR("Fabrice Gasnier <fabrice.gasnier@st.com>");
+MODULE_DESCRIPTION("GPIO trigger for iio subsystem");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1

