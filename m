Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:49969 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932843Ab3DDD7r (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 3 Apr 2013 23:59:47 -0400
From: Naveen Krishna Chatradhi <naveenkrishna.ch@gmail.com>
To: linux-iio@vger.kernel.org
Cc: --linux-samsung@vger.kernel.org, jic23@cam.ac.uk,
	Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
	Doug Anderson <dianders@chromium.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 14/14] temp: iio: adc: exynos_adc: Handle timeout issues
Date: Wed,  3 Apr 2013 20:59:29 -0700
Message-Id: <1365047969-6000-1-git-send-email-naveenkrishna.ch@gmail.com>
In-Reply-To: <1363364801-23684-1-git-send-email-ch.naveen@samsung.com>
References: <1363364801-23684-1-git-send-email-ch.naveen@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Naveen Krishna Chatradhi <ch.naveen@samsung.com>

This patch does the following
1. Handle the return values of wait_for_completion_interruptible_timeout
2. Reset software if a timeout happes.

Note: submitted for review at https://patchwork.kernel.org/patch/2279591/

BUG=None
TEST=None

Change-Id: I9858d19ba40353e72ae38a6cbf7e6f400e6d3c22
Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Cc: Doug Anderson <dianders@chromium.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
As per the comments from Doug at
http://marc.info/?l=linux-kernel&m=136500878406955&w=3

Changes since v1:
1. Remove the spin lock implememtation and the INIT_COMPLETION
2. Rearrange the code and reset the ADC in cases of timeout.

 drivers/iio/adc/exynos_adc.c | 73 ++++++++++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 30 deletions(-)

diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index 5ab0dfd..a6c4df5 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -111,6 +111,35 @@ static inline unsigned int exynos_adc_get_version(struct platform_device *pdev)
 	return (unsigned int)match->data;
 }
 
+static void exynos_adc_hw_init(struct exynos_adc *info)
+{
+	u32 con1, con2;
+	int delay;
+
+	if (info->version == ADC_V2) {
+		con1 = ADC_V2_CON1_SOFT_RESET;
+		writel(con1, ADC_V2_CON1(info->regs));
+
+		/* ADC H/W requires 25PCLKs before other register access */
+		delay = DIV_ROUND_UP(25 * 1000000, clk_get_rate(info->clk));
+		udelay(delay);
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
@@ -118,8 +147,9 @@ static int exynos_read_raw(struct iio_dev *indio_dev,
 				long mask)
 {
 	struct exynos_adc *info = iio_priv(indio_dev);
-	unsigned long timeout;
+	long timeout;
 	u32 con1, con2;
+	int ret;
 
 	if (mask != IIO_CHAN_INFO_RAW)
 		return -EINVAL;
@@ -146,14 +176,21 @@ static int exynos_read_raw(struct iio_dev *indio_dev,
 
 	timeout = wait_for_completion_interruptible_timeout
 			(&info->completion, EXYNOS_ADC_TIMEOUT);
-	*val = info->value;
 
-	mutex_unlock(&indio_dev->mlock);
+	if (timeout == 0) {
+		dev_warn(&indio_dev->dev, "Conversion timed out reseting\n");
+		exynos_adc_hw_init(info);
+		ret = -ETIMEDOUT;
+	} else if (timeout < 0) {
+		ret = timeout;
+	} else {
+		*val = info->value;
+		ret = IIO_VAL_INT;
+	}
 
-	if (timeout == 0)
-		return -ETIMEDOUT;
+	mutex_unlock(&indio_dev->mlock);
 
-	return IIO_VAL_INT;
+	return ret;
 }
 
 static irqreturn_t exynos_adc_isr(int irq, void *dev_id)
@@ -225,30 +262,6 @@ static int exynos_adc_remove_devices(struct device *dev, void *c)
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

