Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:46179 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752600Ab3LRQxO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Dec 2013 11:53:14 -0500
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Lee Jones <lee.jones@linaro.org>,
	Zubair Lutfullah <zubair.lutfullah@gmail.com>,
	Felipe Balbi <balbi@ti.com>, linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/5] mfd: ti_am335x_tscadc: make am335x_tsc_se_update() local
Date: Wed, 18 Dec 2013 17:52:54 +0100
Message-Id: <1387385577-24447-3-git-send-email-bigeasy@linutronix.de>
In-Reply-To: <1387385577-24447-1-git-send-email-bigeasy@linutronix.de>
References: <1387385577-24447-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

since the "recent" changes, am335x_tsc_se_update() has no longer any
users outside of this file so make it local.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/mfd/ti_am335x_tscadc.c       | 3 +--
 include/linux/mfd/ti_am335x_tscadc.h | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index 88718ab..67d0eb4 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -48,11 +48,10 @@ static const struct regmap_config tscadc_regmap_config = {
 	.val_bits = 32,
 };
 
-void am335x_tsc_se_update(struct ti_tscadc_dev *tsadc)
+static void am335x_tsc_se_update(struct ti_tscadc_dev *tsadc)
 {
 	tscadc_writel(tsadc, REG_SE, tsadc->reg_se_cache);
 }
-EXPORT_SYMBOL_GPL(am335x_tsc_se_update);
 
 void am335x_tsc_se_set(struct ti_tscadc_dev *tsadc, u32 val)
 {
diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
index d498d98f..1fe7219 100644
--- a/include/linux/mfd/ti_am335x_tscadc.h
+++ b/include/linux/mfd/ti_am335x_tscadc.h
@@ -176,7 +176,6 @@ static inline struct ti_tscadc_dev *ti_tscadc_dev_get(struct platform_device *p)
 	return *tscadc_dev;
 }
 
-void am335x_tsc_se_update(struct ti_tscadc_dev *tsadc);
 void am335x_tsc_se_set(struct ti_tscadc_dev *tsadc, u32 val);
 void am335x_tsc_se_clr(struct ti_tscadc_dev *tsadc, u32 val);
 
-- 
1.8.5.1

