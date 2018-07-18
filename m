Return-Path: <SRS0=qv6e=KC=xilinx.com=MNARANI@kernel.org>
From: Manish Narani <manish.narani@xilinx.com>
To: <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
	<pmeerw@pmeerw.net>, <michal.simek@xilinx.com>, <manish.narani@xilinx.com>,
	<linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <anirudh@xilinx.com>, <sgoud@xilinx.com>
Subject: [PATCH 4/4] iio: adc: xilinx: Use devm_ functions while requesting irq
Date: Wed, 18 Jul 2018 16:42:11 +0530
Message-ID: <1531912331-26431-5-git-send-email-manish.narani@xilinx.com>
In-Reply-To: <1531912331-26431-1-git-send-email-manish.narani@xilinx.com>
References: <1531912331-26431-1-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

This patch adds support for using devm_ functions for requesting irq.
This will let the core free irq itself whenever the error condition
happens in probe or when xadc_remove is called.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 47eb364..7cadcc77 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -1229,8 +1229,8 @@ static int xadc_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_clk_disable_unprepare;
 
-	ret = request_irq(irq, xadc->ops->interrupt_handler, 0,
-			dev_name(&pdev->dev), indio_dev);
+	ret = devm_request_irq(&pdev->dev, irq, xadc->ops->interrupt_handler, 0,
+			       dev_name(&pdev->dev), indio_dev);
 	if (ret)
 		goto err_clk_disable_unprepare;
 
@@ -1240,7 +1240,7 @@ static int xadc_probe(struct platform_device *pdev)
 
 	ret = xadc_write_adc_reg(xadc, XADC_REG_CONF0, conf0);
 	if (ret)
-		goto err_free_irq;
+		goto err_clk_disable_unprepare;
 
 	bipolar_mask = 0;
 	for (i = 0; i < indio_dev->num_channels; i++) {
@@ -1250,17 +1250,17 @@ static int xadc_probe(struct platform_device *pdev)
 
 	ret = xadc_write_adc_reg(xadc, XADC_REG_INPUT_MODE(0), bipolar_mask);
 	if (ret)
-		goto err_free_irq;
+		goto err_clk_disable_unprepare;
 	ret = xadc_write_adc_reg(xadc, XADC_REG_INPUT_MODE(1),
 		bipolar_mask >> 16);
 	if (ret)
-		goto err_free_irq;
+		goto err_clk_disable_unprepare;
 
 	/* Disable all alarms */
 	ret = xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_ALARM_MASK,
 				  XADC_CONF1_ALARM_MASK);
 	if (ret)
-		goto err_free_irq;
+		goto err_clk_disable_unprepare;
 
 	/* Set thresholds to min/max */
 	for (i = 0; i < 16; i++) {
@@ -1281,14 +1281,12 @@ static int xadc_probe(struct platform_device *pdev)
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
-		goto err_free_irq;
+		goto err_clk_disable_unprepare;
 
 	platform_set_drvdata(pdev, indio_dev);
 
 	return 0;
 
-err_free_irq:
-	free_irq(irq, indio_dev);
 err_clk_disable_unprepare:
 	clk_disable_unprepare(xadc->clk);
 err_free_samplerate_trigger:
@@ -1310,7 +1308,6 @@ static int xadc_remove(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct xadc *xadc = iio_priv(indio_dev);
-	int irq = platform_get_irq(pdev, 0);
 
 	iio_device_unregister(indio_dev);
 	if (xadc->ops->flags & XADC_FLAGS_BUFFERED) {
@@ -1318,7 +1315,6 @@ static int xadc_remove(struct platform_device *pdev)
 		iio_trigger_free(xadc->convst_trigger);
 		iio_triggered_buffer_cleanup(indio_dev);
 	}
-	free_irq(irq, indio_dev);
 	clk_disable_unprepare(xadc->clk);
 	cancel_delayed_work(&xadc->zynq_unmask_work);
 	kfree(xadc->data);
-- 
2.1.1
