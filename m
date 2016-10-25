Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:55791 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S941759AbcJYQ0o (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Oct 2016 12:26:44 -0400
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <linux@armlinux.org.uk>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <fabrice.gasnier@st.com>
Subject: [PATCH 04/10] iio: adc: stm32: add optional support for exti gpios
Date: Tue, 25 Oct 2016 18:25:16 +0200
Message-ID: <1477412722-24061-5-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1477412722-24061-1-git-send-email-fabrice.gasnier@st.com>
References: <1477412722-24061-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

STM32 ADC may use EXTi signals routed internally as trigger source
for conversions. Configure them as interrupt to configure this path
in HW to adc.
Note: interrupt handler isn't required here, and corresponding interrupt
can be kept masked at exti controller level.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/adc/stm32/stm32-adc.c | 45 +++++++++++++++++++++++++++++++++++++++
 drivers/iio/adc/stm32/stm32-adc.h |  3 +++
 2 files changed, 48 insertions(+)

diff --git a/drivers/iio/adc/stm32/stm32-adc.c b/drivers/iio/adc/stm32/stm32-adc.c
index 25d0307..1a13450 100644
--- a/drivers/iio/adc/stm32/stm32-adc.c
+++ b/drivers/iio/adc/stm32/stm32-adc.c
@@ -482,6 +482,12 @@ static irqreturn_t stm32_adc_common_isr(int irq, void *data)
 	return ret;
 }
 
+static irqreturn_t stm32_adc_exti_handler(int irq, void *data)
+{
+	/* Exti handler should not be invoqued, and is not used */
+	return IRQ_HANDLED;
+}
+
 /**
  * stm32_adc_validate_trigger() - validate trigger for stm32 adc
  * @indio_dev: IIO device
@@ -1051,6 +1057,41 @@ static void stm32_adc_unregister(struct stm32_adc *adc)
 	}
 }
 
+static int stm32_adc_exti_probe(struct stm32_adc_common *common)
+{
+	int i, irq, ret;
+
+	common->gpios = devm_gpiod_get_array_optional(common->dev, NULL,
+						      GPIOD_IN);
+	if (!common->gpios)
+		return 0;
+
+	for (i = 0; i < common->gpios->ndescs; i++) {
+		irq = gpiod_to_irq(common->gpios->desc[i]);
+		if (irq < 0) {
+			dev_err(common->dev, "gpio %d to irq failed\n", i);
+			return irq;
+		}
+
+		ret = devm_request_irq(common->dev, irq, stm32_adc_exti_handler,
+				       0, dev_name(common->dev), common);
+		if (ret) {
+			dev_err(common->dev, "request IRQ %d failed\n", irq);
+			return ret;
+		}
+
+		/*
+		 * gpios are configured as interrupts, so exti trigger path is
+		 * configured in HW. But getting interrupts when starting
+		 * conversions is unused here, so mask it in on exti
+		 * controller by default.
+		 */
+		disable_irq(irq);
+	}
+
+	return 0;
+}
+
 int stm32_adc_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node, *child;
@@ -1131,6 +1172,10 @@ int stm32_adc_probe(struct platform_device *pdev)
 		goto err_clk_disable;
 	}
 
+	ret = stm32_adc_exti_probe(common);
+	if (ret)
+		goto err_clk_disable;
+
 	/* Parse adc child nodes to retrieve master/slave instances data */
 	for_each_available_child_of_node(np, child) {
 		ret = stm32_adc_register(common, child);
diff --git a/drivers/iio/adc/stm32/stm32-adc.h b/drivers/iio/adc/stm32/stm32-adc.h
index 01a0dda..fe3568b 100644
--- a/drivers/iio/adc/stm32/stm32-adc.h
+++ b/drivers/iio/adc/stm32/stm32-adc.h
@@ -23,6 +23,7 @@
 #define __STM32_ADC_H
 
 #include <linux/dmaengine.h>
+#include <linux/gpio/consumer.h>
 #include <linux/irq_work.h>
 
 /*
@@ -323,6 +324,7 @@ struct stm32_adc {
  * @aclk:		common clock for the analog circuitry
  * @vref:		regulator reference
  * @vref_mv:		vref voltage (mv)
+ * @gpio_descs:		gpio descriptor used to configure EXTi triggers
  * @lock:		mutex
  */
 struct stm32_adc_common {
@@ -335,6 +337,7 @@ struct stm32_adc_common {
 	struct clk			*aclk;
 	struct regulator		*vref;
 	int				vref_mv;
+	struct gpio_descs		*gpios;
 	struct mutex			lock;	/* read_raw lock */
 };
 
-- 
1.9.1

