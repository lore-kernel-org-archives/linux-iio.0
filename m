Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:42361 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753802Ab3COQ3C (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 15 Mar 2013 12:29:02 -0400
From: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
To: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	dianders@chromium.org, gregkh@linuxfoundation.org,
	naveenkrishna.ch@gmail.com, lars@metafoo.de
Subject: [RFC: PATCH 2/2] iio: adc: exynos_adc: Handle timeout and race
 conditions
Date: Fri, 15 Mar 2013 21:56:41 +0530
Message-id: <1363364801-23684-1-git-send-email-ch.naveen@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch does the following
1. Handle the return values of wait_for_completion_interruptible_timeout
2. Add spin locks to avoid race conditions during ISR.

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Cc: Doug Anderson <dianders@chromium.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
Discussion thread for this patch can be found at
http://www.gossamer-threads.com/lists/linux/kernel/1693284?page=last

I've not seen any reference to spin lock usage in IIO.
Kindly, suggest me if there is a better way to avoid the race.

Thanks,
Naveen
 drivers/iio/adc/exynos_adc.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index ed6fdd7..4de28ae 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -91,6 +91,7 @@ struct exynos_adc {
 
 	struct completion	completion;
 
+	spinlock_t		reg_lock;
 	u32			value;
 	unsigned int            version;
 };
@@ -117,7 +118,7 @@ static int exynos_read_raw(struct iio_dev *indio_dev,
 				long mask)
 {
 	struct exynos_adc *info = iio_priv(indio_dev);
-	unsigned long timeout;
+	long timeout;
 	u32 con1, con2;
 
 	if (mask != IIO_CHAN_INFO_RAW)
@@ -143,15 +144,19 @@ static int exynos_read_raw(struct iio_dev *indio_dev,
 				ADC_V1_CON(info->regs));
 	}
 
+	INIT_COMPLETION(info->completion);
+
 	timeout = wait_for_completion_interruptible_timeout
 			(&info->completion, EXYNOS_ADC_TIMEOUT);
+
 	*val = info->value;
 
 	mutex_unlock(&indio_dev->mlock);
 
 	if (timeout == 0)
 		return -ETIMEDOUT;
-
+	else if (timeout < 0)
+		return timeout;
 	return IIO_VAL_INT;
 }
 
@@ -159,6 +164,8 @@ static irqreturn_t exynos_adc_isr(int irq, void *dev_id)
 {
 	struct exynos_adc *info = (struct exynos_adc *)dev_id;
 
+	spin_lock(&info->reg_lock);
+
 	/* Read value */
 	info->value = readl(ADC_V1_DATX(info->regs)) &
 						ADC_DATX_MASK;
@@ -170,6 +177,8 @@ static irqreturn_t exynos_adc_isr(int irq, void *dev_id)
 
 	complete(&info->completion);
 
+	spin_unlock(&info->reg_lock);
+
 	return IRQ_HANDLED;
 }
 
@@ -327,6 +336,7 @@ static int exynos_adc_probe(struct platform_device *pdev)
 	else
 		indio_dev->num_channels = MAX_ADC_V2_CHANNELS;
 
+	spin_lock_init(&info->reg_lock);
 	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto err_irq;
-- 
1.7.9.5

