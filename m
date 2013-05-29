Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:54972 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965224Ab3E2Iqr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 29 May 2013 04:46:47 -0400
Date: Wed, 29 May 2013 10:46:42 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Samuel Ortiz <sameo@linux.intel.com>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Felipe Balbi <balbi@ti.com>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 19/19 v2] mfd/ti_am335x_tscadc: add private lock/unlock
 function for regmap read/write
Message-ID: <20130529084642.GA18273@linutronix.de>
References: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de>
 <1369681926-22185-20-git-send-email-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1369681926-22185-20-git-send-email-bigeasy@linutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Without this, devm_regmap_init_mmio() creates & uses a simple
spin_lock() and this should be enough. Within the probe function the
registers are read and written in process context. Later they are
accessed from the ISR and lockdep complains because now the lock is
taken suddenly with IRQs enabled. Currently I don't see any other way to
keep lockdep quiet than doing this.

Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

v1..v2: pass a ti_tscadc_dev via lock arg

 drivers/mfd/ti_am335x_tscadc.c       |   21 ++++++++++++++++++++-
 include/linux/mfd/ti_am335x_tscadc.h |    2 ++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index 5e4076f..bd982e5 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -42,11 +42,27 @@ static void tscadc_writel(struct ti_tscadc_dev *tsadc, unsigned int reg,
 	regmap_write(tsadc->regmap_tscadc, reg, val);
 }
 
+static void tscadc_lock_spinlock(void *__map)
+{
+	struct ti_tscadc_dev *tsadc = __map;
+
+	spin_lock_irqsave(&tsadc->reg_map_lock, tsadc->reg_map_flags);
+}
+
+static void tscadc_unlock_spinlock(void *__map)
+{
+	struct ti_tscadc_dev *tsadc = __map;
+
+	spin_unlock_irqrestore(&tsadc->reg_map_lock, tsadc->reg_map_flags);
+}
+
 static const struct regmap_config tscadc_regmap_config = {
 	.name = "ti_tscadc",
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
+	.lock = tscadc_lock_spinlock,
+	.unlock = tscadc_unlock_spinlock,
 };
 
 static void tscadc_idle_config(struct ti_tscadc_dev *config)
@@ -69,6 +85,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	int			err, ctrl;
 	int			clk_value, clock_rate;
 	int			tsc_wires = 0, adc_channels = 0, total_channels;
+	struct regmap_config	tscadc_regmap_cfg = tscadc_regmap_config;
 
 	if (!pdev->dev.of_node) {
 		dev_err(&pdev->dev, "Could not find valid DT data.\n");
@@ -110,6 +127,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	} else
 		tscadc->irq = err;
 
+	spin_lock_init(&tscadc->reg_map_lock);
 	res = devm_request_mem_region(&pdev->dev,
 			res->start, resource_size(res), pdev->name);
 	if (!res) {
@@ -124,8 +142,9 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	tscadc_regmap_cfg.lock_arg = tscadc;
 	tscadc->regmap_tscadc = devm_regmap_init_mmio(&pdev->dev,
-			tscadc->tscadc_base, &tscadc_regmap_config);
+			tscadc->tscadc_base, &tscadc_regmap_cfg);
 	if (IS_ERR(tscadc->regmap_tscadc)) {
 		dev_err(&pdev->dev, "regmap init failed\n");
 		err = PTR_ERR(tscadc->regmap_tscadc);
diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
index c985262..284e482 100644
--- a/include/linux/mfd/ti_am335x_tscadc.h
+++ b/include/linux/mfd/ti_am335x_tscadc.h
@@ -129,6 +129,8 @@
 #define TSCADC_CELLS		2
 
 struct ti_tscadc_dev {
+	spinlock_t reg_map_lock;
+	unsigned long reg_map_flags;
 	struct device *dev;
 	struct regmap *regmap_tscadc;
 	void __iomem *tscadc_base;
-- 
1.7.10.4

