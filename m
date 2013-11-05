Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:59708 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752072Ab3KEJnv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 5 Nov 2013 04:43:51 -0500
From: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
To: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	dianders@chromium.org, gregkh@linuxfoundation.org,
	naveenkrishna.ch@gmail.com, lars@metafoo.de, grundler@chromium.org,
	cpgs@samsung.com
Subject: [PATCH v6] iio: exynos_adc: use wait_for_completion_timeout instead of
 interruptible
Date: Tue, 05 Nov 2013 15:15:30 +0530
Message-id: <1383644730-23228-1-git-send-email-ch.naveen@samsung.com>
In-reply-to: <1381479821-17276-1-git-send-email-ch.naveen@samsung.com>
References: <1381479821-17276-1-git-send-email-ch.naveen@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

1. The irq routine is so simple (just one register read) shouldn't be long
   Hence, reduce the timeout to 100milli secs,
2. With 100ms of wait time, interruptible is very much unnecessary.
   Hence, use wait_for_completion_timeout instead of
   wait_for_completion_interruptible_timeout
3. Reset software if a timeout happens.
4. Add reinit_completion() before the wait_for_completion_timeout in raw_read()

Note: submitted for review at https://patchwork.kernel.org/patch/2279591/

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Cc: Doug Anderson <dianders@chromium.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Reviewed-on: https://chromium-review.googlesource.com/172724
Reviewed-by: Doug Anderson <dianders@chromium.org>
---
Changes since v1:
As per discussion at
http://marc.info/?l=linux-kernel&m=136517637228869&w=3

Changes since v2:
None.
Rebased and reposting.

Changes since v3:
1. commit message change and
2. removed an unncessary assignment

Changes since v4:
Moved INIT_COMPLETION call to the starting of the function

Changes since v5:
INIT_COMPLETION was replaced by reinit_completion
("tree-wide: use reinit_completion instead of INIT_COMPLETION").
Use it to avoid the following build error:
undefined identifier 'INIT_COMPLETION'


 drivers/iio/adc/exynos_adc.c | 69 ++++++++++++++++++++++++--------------------
 1 file changed, 38 insertions(+), 31 deletions(-)

diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index 0f2ca60..a675751 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -81,7 +81,7 @@ enum adc_version {
 #define ADC_CON_EN_START	(1u << 0)
 #define ADC_DATX_MASK		0xFFF
 
-#define EXYNOS_ADC_TIMEOUT	(msecs_to_jiffies(1000))
+#define EXYNOS_ADC_TIMEOUT	(msecs_to_jiffies(100))
 
 struct exynos_adc {
 	void __iomem		*regs;
@@ -111,6 +111,30 @@ static inline unsigned int exynos_adc_get_version(struct platform_device *pdev)
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
@@ -120,11 +144,13 @@ static int exynos_read_raw(struct iio_dev *indio_dev,
 	struct exynos_adc *info = iio_priv(indio_dev);
 	unsigned long timeout;
 	u32 con1, con2;
+	int ret;
 
 	if (mask != IIO_CHAN_INFO_RAW)
 		return -EINVAL;
 
 	mutex_lock(&indio_dev->mlock);
+	reinit_completion(&info->completion);
 
 	/* Select the channel to be used and Trigger conversion */
 	if (info->version == ADC_V2) {
@@ -144,16 +170,21 @@ static int exynos_read_raw(struct iio_dev *indio_dev,
 				ADC_V1_CON(info->regs));
 	}
 
-	timeout = wait_for_completion_interruptible_timeout
+	timeout = wait_for_completion_timeout
 			(&info->completion, EXYNOS_ADC_TIMEOUT);
-	*val = info->value;
+	if (timeout == 0) {
+		dev_warn(&indio_dev->dev, "Conversion timed out! Resetting\n");
+		exynos_adc_hw_init(info);
+		ret = -ETIMEDOUT;
+	} else {
+		*val = info->value;
+		*val2 = 0;
+		ret = IIO_VAL_INT;
+	}
 
 	mutex_unlock(&indio_dev->mlock);
 
-	if (timeout == 0)
-		return -ETIMEDOUT;
-
-	return IIO_VAL_INT;
+	return ret;
 }
 
 static irqreturn_t exynos_adc_isr(int irq, void *dev_id)
@@ -225,30 +256,6 @@ static int exynos_adc_remove_devices(struct device *dev, void *c)
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
1.7.12.4

