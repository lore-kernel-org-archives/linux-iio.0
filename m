Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:58759 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751167AbdBSUfB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Feb 2017 15:35:01 -0500
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, michal.simek@xilinx.com,
        soren.brinkmann@xilinx.com
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] iio: adc: xilinx: Fix error handling
Date: Sun, 19 Feb 2017 21:29:28 +0100
Message-Id: <20170219202928.20296-1-christophe.jaillet@wanadoo.fr>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Reorder error handling labels in order to match the way resources have
been allocated.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/iio/adc/xilinx-xadc-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 0a6beb3d99cb..515b91963db5 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -1268,6 +1268,8 @@ static int xadc_probe(struct platform_device *pdev)
 
 err_free_irq:
 	free_irq(irq, indio_dev);
+err_clk_disable_unprepare:
+	clk_disable_unprepare(xadc->clk);
 err_free_samplerate_trigger:
 	if (xadc->ops->flags & XADC_FLAGS_BUFFERED)
 		iio_trigger_free(xadc->samplerate_trigger);
@@ -1277,8 +1279,6 @@ static int xadc_probe(struct platform_device *pdev)
 err_triggered_buffer_cleanup:
 	if (xadc->ops->flags & XADC_FLAGS_BUFFERED)
 		iio_triggered_buffer_cleanup(indio_dev);
-err_clk_disable_unprepare:
-	clk_disable_unprepare(xadc->clk);
 err_device_free:
 	kfree(indio_dev->channels);
 
-- 
2.9.3

