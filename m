Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40041 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753061AbaIAGbY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 1 Sep 2014 02:31:24 -0400
From: Vignesh R <vigneshr@ti.com>
To: Lee Jones <lee.jones@linaro.org>
CC: Samuel Ortiz <sameo@linux.intel.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Felipe Balbi <balbi@ti.com>, <linux-iio@vger.kernel.org>,
	<nsekhar@ti.com>
Subject: [PATCH v2] mfd: ti_am335x_tscadc: Fix TSC operation after ADC continouous mode
Date: Mon, 1 Sep 2014 12:01:06 +0530
Message-ID: <1409553066-25000-1-git-send-email-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

After enabling and disabling ADC continuous mode via sysfs, ts_print_raw
fails to return any data. This is because when ADC is configured for
continuous mode, it disables touch screen steps.These steps are not
re-enabled when ADC continuous mode is disabled. Therefore existing values
of REG_SE needs to be cached before enabling continuous mode and
disabling touch screen steps and enabling ADC steps. The cached value
are to be restored to REG_SE once ADC is disabled.

Fixes: 7ca6740cd1cd ("mfd: input: iio: ti_amm335x: Rework TSC/ADC synchronization")

Cc: stable@vger.kernel.org # v3.13+
Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Vignesh R <vigneshr@ti.com>
---
fixed $SUBJECT, added stable and ack from Lee Jones.
No code change.

 drivers/mfd/ti_am335x_tscadc.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index d4e860413bb5..e3076afe6b3c 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -54,7 +54,7 @@ void am335x_tsc_se_set_cache(struct ti_tscadc_dev *tsadc, u32 val)
 	unsigned long flags;
 
 	spin_lock_irqsave(&tsadc->reg_lock, flags);
-	tsadc->reg_se_cache = val;
+	tsadc->reg_se_cache |= val;
 	if (tsadc->adc_waiting)
 		wake_up(&tsadc->reg_se_wait);
 	else if (!tsadc->adc_in_use)
@@ -97,6 +97,7 @@ static void am335x_tscadc_need_adc(struct ti_tscadc_dev *tsadc)
 void am335x_tsc_se_set_once(struct ti_tscadc_dev *tsadc, u32 val)
 {
 	spin_lock_irq(&tsadc->reg_lock);
+	tsadc->reg_se_cache |= val;
 	am335x_tscadc_need_adc(tsadc);
 
 	tscadc_writel(tsadc, REG_SE, val);
-- 
1.7.9.5

