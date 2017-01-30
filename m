Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:24127 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932183AbdA3OfZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Jan 2017 09:35:25 -0500
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>, <linux@armlinux.org.uk>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux-iio@vger.kernel.org>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <fabrice.gasnier@st.com>, <benjamin.gaignard@linaro.org>,
        <benjamin.gaignard@st.com>
Subject: [PATCH v2 4/5] iio: trigger: add support for STM32 EXTI triggers
Date: Mon, 30 Jan 2017 15:33:59 +0100
Message-ID: <1485786840-4557-5-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1485786840-4557-1-git-send-email-fabrice.gasnier@st.com>
References: <1485786840-4557-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

EXTi[0..15] gpio signal can be routed internally as trigger source for
ADC or DAC conversions. Configure them as interrupts to configure
trigger path in HW.

Note: interrupt handler isn't required here, and corresponding interrupt
can be kept masked at exti controller level.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/trigger/Kconfig                    |  11 +++
 drivers/iio/trigger/Makefile                   |   1 +
 drivers/iio/trigger/stm32-exti-trigger.c       | 124 +++++++++++++++++++++++++
 include/linux/iio/trigger/stm32-exti-trigger.h |  26 ++++++
 4 files changed, 162 insertions(+)
 create mode 100644 drivers/iio/trigger/stm32-exti-trigger.c
 create mode 100644 include/linux/iio/trigger/stm32-exti-trigger.h

diff --git a/drivers/iio/trigger/Kconfig b/drivers/iio/trigger/Kconfig
index e4d4e63..3fbf90c 100644
--- a/drivers/iio/trigger/Kconfig
+++ b/drivers/iio/trigger/Kconfig
@@ -24,6 +24,17 @@ config IIO_INTERRUPT_TRIGGER
 	  To compile this driver as a module, choose M here: the
 	  module will be called iio-trig-interrupt.
 
+config IIO_STM32_EXTI_TRIGGER
+	tristate "STM32 EXTI Trigger"
+	depends on (ARCH_STM32 && OF) || COMPILE_TEST
+	select STM32_EXTI
+	help
+	  Select this option to enable STM32 EXTI Triggers on GPIO. These
+	  maybe used then on other STM32 IPs like ADC or DAC.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called stm32-exti-trigger.
+
 config IIO_STM32_TIMER_TRIGGER
 	tristate "STM32 Timer Trigger"
 	depends on (ARCH_STM32 && OF && MFD_STM32_TIMERS) || COMPILE_TEST
diff --git a/drivers/iio/trigger/Makefile b/drivers/iio/trigger/Makefile
index 5c4ecd3..12d5d72 100644
--- a/drivers/iio/trigger/Makefile
+++ b/drivers/iio/trigger/Makefile
@@ -6,6 +6,7 @@
 
 obj-$(CONFIG_IIO_HRTIMER_TRIGGER) += iio-trig-hrtimer.o
 obj-$(CONFIG_IIO_INTERRUPT_TRIGGER) += iio-trig-interrupt.o
+obj-$(CONFIG_IIO_STM32_EXTI_TRIGGER) += stm32-exti-trigger.o
 obj-$(CONFIG_IIO_STM32_TIMER_TRIGGER) += stm32-timer-trigger.o
 obj-$(CONFIG_IIO_SYSFS_TRIGGER) += iio-trig-sysfs.o
 obj-$(CONFIG_IIO_TIGHTLOOP_TRIGGER) += iio-trig-loop.o
diff --git a/drivers/iio/trigger/stm32-exti-trigger.c b/drivers/iio/trigger/stm32-exti-trigger.c
new file mode 100644
index 0000000..2a3ec3c
--- /dev/null
+++ b/drivers/iio/trigger/stm32-exti-trigger.c
@@ -0,0 +1,124 @@
+/*
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
+/* STM32 has up to 16 EXTI triggers on GPIOs */
+#define STM32_MAX_EXTI_TRIGGER	16
+
+static const struct iio_trigger_ops exti_trigger_ops = {
+	.owner = THIS_MODULE,
+};
+
+bool is_stm32_exti_trigger(struct iio_trigger *trig)
+{
+	return (trig->ops == &exti_trigger_ops);
+}
+EXPORT_SYMBOL(is_stm32_exti_trigger);
+
+static irqreturn_t stm32_exti_trigger_handler(int irq, void *data)
+{
+	/* Exti handler shouldn't be invoked, and isn't used */
+	return IRQ_HANDLED;
+}
+
+static int stm32_exti_trigger_probe(struct platform_device *pdev)
+{
+	int irq, ret;
+	char name[8];
+	struct gpio_desc *gpio;
+	struct iio_trigger *trig;
+	unsigned int i;
+
+	for (i = 0; i < STM32_MAX_EXTI_TRIGGER; i++) {
+		snprintf(name, sizeof(name), "exti%d", i);
+
+		gpio = devm_gpiod_get_optional(&pdev->dev, name, GPIOD_IN);
+		if (IS_ERR_OR_NULL(gpio)) {
+			if (IS_ERR(gpio)) {
+				dev_err(&pdev->dev, "gpio %s get error %ld\n",
+					name, PTR_ERR(gpio));
+				return PTR_ERR(gpio);
+			}
+			dev_dbg(&pdev->dev, "No %s gpio\n", name);
+			continue;
+		}
+
+		irq = gpiod_to_irq(gpio);
+		if (irq < 0) {
+			dev_err(&pdev->dev, "gpio %d to irq failed\n", i);
+			return irq;
+		}
+
+		ret = devm_request_irq(&pdev->dev, irq,
+				       stm32_exti_trigger_handler,
+				       0, dev_name(&pdev->dev), pdev);
+		if (ret) {
+			dev_err(&pdev->dev, "request IRQ %d failed\n", irq);
+			return ret;
+		}
+
+		/*
+		 * gpios are configured as interrupts, so exti trigger path is
+		 * configured in HW, and can now be used as external trigger
+		 * source by other IPs. But getting interrupts when trigger
+		 * occurs is unused here, so mask irq on exti controller by
+		 * default.
+		 */
+		disable_irq(irq);
+
+		trig = devm_iio_trigger_alloc(&pdev->dev, "%s", name);
+		if (!trig)
+			return -ENOMEM;
+
+		trig->dev.parent = &pdev->dev;
+		trig->ops = &exti_trigger_ops;
+
+		ret = devm_iio_trigger_register(&pdev->dev, trig);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id stm32_exti_trigger_of_match[] = {
+	{ .compatible = "st,stm32-exti-trigger" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, stm32_exti_trigger_of_match);
+
+static struct platform_driver stm32_exti_trigger_driver = {
+	.probe = stm32_exti_trigger_probe,
+	.driver = {
+		.name = "stm32-exti-trigger",
+		.of_match_table = stm32_exti_trigger_of_match,
+	},
+};
+module_platform_driver(stm32_exti_trigger_driver);
+
+MODULE_AUTHOR("Fabrice Gasnier <fabrice.gasnier@st.com>");
+MODULE_DESCRIPTION("STMicroelectronics STM32 EXTI-GPIO IIO trigger driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:stm32-exti-trigger");
diff --git a/include/linux/iio/trigger/stm32-exti-trigger.h b/include/linux/iio/trigger/stm32-exti-trigger.h
new file mode 100644
index 0000000..157ae58
--- /dev/null
+++ b/include/linux/iio/trigger/stm32-exti-trigger.h
@@ -0,0 +1,26 @@
+/*
+ * This file is part of STM32 EXTI Trigger driver
+ *
+ * Copyright (C) STMicroelectronics 2017
+ * Author: Fabrice Gasnier <fabrice.gasnier@st.com>.
+ *
+ * License terms:  GNU General Public License (GPL), version 2
+ */
+
+#ifndef _STM32_EXTI_TRIGGER_H_
+#define _STM32_EXTI_TRIGGER_H_
+
+#include <linux/stddef.h>
+
+#define STM32_EXTI(n)		"exti"#n
+
+#if IS_ENABLED(CONFIG_IIO_STM32_EXTI_TRIGGER)
+bool is_stm32_exti_trigger(struct iio_trigger *trig);
+#else
+static inline bool is_stm32_exti_trigger(struct iio_trigger *trig)
+{
+	return false;
+}
+#endif
+
+#endif
-- 
1.9.1

