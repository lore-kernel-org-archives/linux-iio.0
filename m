Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:40384 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752314Ab3JKIVj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 11 Oct 2013 04:21:39 -0400
From: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
To: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	dianders@chromium.org, gregkh@linuxfoundation.org,
	naveenkrishna.ch@gmail.com, lars@metafoo.de, tomasz.figa@gmail.com
Subject: [PATCH v3] iio: exynos_adc: use wait_for_completion_timeout instead of
 interruptible
Date: Fri, 11 Oct 2013 13:53:41 +0530
Message-id: <1381479821-17276-1-git-send-email-ch.naveen@samsung.com>
In-reply-to: <1365048389-6364-1-git-send-email-naveenkrishna.ch@gmail.com>
References: <1365048389-6364-1-git-send-email-naveenkrishna.ch@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch does the following
1. use wait_for_completion_timeout instead of
   wait_for_completion_interruptible_timeout
2. Reset software if a timeout happens.
3. Also reduce the timeout to 100milli secs

Note: submitted for review at https://patchwork.kernel.org/patch/2279591/

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Cc: Doug Anderson <dianders@chromium.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
Changes since v1:
As per discussion at
http://marc.info/?l=linux-kernel&m=136517637228869&w=3

This patch does the following
1. use wait_for_completion_timeout instead of
   wait_for_completion_interruptible_timeout
2. Reset software if a timeout happens.
3. Also reduce the timeout to 100milli secs

Changes since v2:
None.
Rebased and reposting.

---
 drivers/iio/adc/exynos_adc.c |   66 +++++++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 30 deletions(-)

diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index d25b262..f18ed7e 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -82,7 +82,7 @@ enum adc_version {
 #define ADC_CON_EN_START	(1u << 0)
 #define ADC_DATX_MASK		0xFFF
 
-#define EXYNOS_ADC_TIMEOUT	(msecs_to_jiffies(1000))
+#define EXYNOS_ADC_TIMEOUT	(msecs_to_jiffies(100))
 
 struct exynos_adc {
 	void __iomem		*regs;
@@ -112,6 +112,30 @@ static inline unsigned int exynos_adc_get_version(struct platform_device *pdev)
 	return (unsigned int)match->data;
 }
 
+static void exynos_adc_hw_init(struct exynos_adc *info)
+{
+	u32 con1, con2;
+
+	if (info->version == ADC_V2) {
+		con1 = ADC_V2_CON1_SOFT_RESET;
+		writel(con1, ADC_V2_CON1(info->regs));
+
+		con2 = ADC_V2_CON2_OSEL | ADC_V2_CON2_ESEL |
+			ADC_V2_CON2_HIGHF | ADC_V2_CON2_C_TIME(0);
+		writel(con2, ADC_V2_CON2(info->regs));
+
+		/* Enable interrupts */
+		writel(1, ADC_V2_INT_EN(info->regs));
+	} else {
+		/* set default prescaler values and Enable prescaler */
+		con1 =  ADC_V1_CON_PRSCLV(49) | ADC_V1_CON_PRSCEN;
+
+		/* Enable 12-bit ADC resolution */
+		con1 |= ADC_V1_CON_RES;
+		writel(con1, ADC_V1_CON(info->regs));
+	}
+}
+
 static int exynos_read_raw(struct iio_dev *indio_dev,
 				struct iio_chan_spec const *chan,
 				int *val,
@@ -121,6 +145,7 @@ static int exynos_read_raw(struct iio_dev *indio_dev,
 	struct exynos_adc *info = iio_priv(indio_dev);
 	unsigned long timeout;
 	u32 con1, con2;
+	int ret;
 
 	if (mask != IIO_CHAN_INFO_RAW)
 		return -EINVAL;
@@ -145,16 +170,21 @@ static int exynos_read_raw(struct iio_dev *indio_dev,
 				ADC_V1_CON(info->regs));
 	}
 
-	timeout = wait_for_completion_interruptible_timeout
+	timeout = wait_for_completion_timeout
 			(&info->completion, EXYNOS_ADC_TIMEOUT);
+	if (timeout == 0) {
+		dev_warn(&indio_dev->dev, "Conversion timed out reseting\n");
+		exynos_adc_hw_init(info);
+		ret = -ETIMEDOUT;
+	} else {
+		*val = info->value;
+		ret = IIO_VAL_INT;
+	}
 	*val = info->value;
 
 	mutex_unlock(&indio_dev->mlock);
 
-	if (timeout == 0)
-		return -ETIMEDOUT;
-
-	return IIO_VAL_INT;
+	return ret;
 }
 
 static irqreturn_t exynos_adc_isr(int irq, void *dev_id)
@@ -226,30 +256,6 @@ static int exynos_adc_remove_devices(struct device *dev, void *c)
 	return 0;
 }
 
-static void exynos_adc_hw_init(struct exynos_adc *info)
-{
-	u32 con1, con2;
-
-	if (info->version == ADC_V2) {
-		con1 = ADC_V2_CON1_SOFT_RESET;
-		writel(con1, ADC_V2_CON1(info->regs));
-
-		con2 = ADC_V2_CON2_OSEL | ADC_V2_CON2_ESEL |
-			ADC_V2_CON2_HIGHF | ADC_V2_CON2_C_TIME(0);
-		writel(con2, ADC_V2_CON2(info->regs));
-
-		/* Enable interrupts */
-		writel(1, ADC_V2_INT_EN(info->regs));
-	} else {
-		/* set default prescaler values and Enable prescaler */
-		con1 =  ADC_V1_CON_PRSCLV(49) | ADC_V1_CON_PRSCEN;
-
-		/* Enable 12-bit ADC resolution */
-		con1 |= ADC_V1_CON_RES;
-		writel(con1, ADC_V1_CON(info->regs));
-	}
-}
-
 static int exynos_adc_probe(struct platform_device *pdev)
 {
 	struct exynos_adc *info = NULL;
-- 
1.7.10.4

