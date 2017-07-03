Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:45721 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752229AbdGCNJw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Jul 2017 09:09:52 -0400
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, maxime.ripard@free-electrons.com, wens@csie.org
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@free-electrons.com
Subject: [PATCH] iio: adc: sun4i-gpadc-iio: fix unbalanced irq enable/disable
Date: Mon,  3 Jul 2017 15:09:26 +0200
Message-Id: <20170703130926.32315-1-quentin.schulz@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

When initializing interrupts, the devm_request_any_context_irq will
enable them right away. An atomic flag was set in sun4i_irq_init and read
in the interrupt handler to make sure no unwanted interrupts were
handled. If an unwanted interrupt occurred, the handler would disable
the irq and return IRQ_HANDLED. However, at the end of sun4i_irq_init,
the irq would be disabled as well, resulting in an unbalanced enable
(since there are more disables than enables, the code enabling the
interrupt would never be called).

When reading the ADC or the temperature, the respective irq would be
enabled in the read function and disabled in the irq handler. In the
read function, we would wait for a completion (with a timeout) that will
be set in the irq handler. However, if the completion is never set or if
the wait for completion times out, the irq would not be disabled in the
read function resulting in an unbalanced enable once the read function
is called again (since there are 2+ enables for no disable).

Moving disable_irq from the irq handler to the read function get rid of
these two cases of unbalanced enable.

Fixes: d1caa9905538 ("iio: adc: add support for Allwinner SoCs ADC")

Reported-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 drivers/iio/adc/sun4i-gpadc-iio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index 81d4c39e414a..137f577d9432 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -256,6 +256,7 @@ static int sun4i_gpadc_read(struct iio_dev *indio_dev, int channel, int *val,
 
 err:
 	pm_runtime_put_autosuspend(indio_dev->dev.parent);
+	disable_irq(irq);
 	mutex_unlock(&info->mutex);
 
 	return ret;
@@ -365,7 +366,6 @@ static irqreturn_t sun4i_gpadc_temp_data_irq_handler(int irq, void *dev_id)
 		complete(&info->completion);
 
 out:
-	disable_irq_nosync(info->temp_data_irq);
 	return IRQ_HANDLED;
 }
 
@@ -380,7 +380,6 @@ static irqreturn_t sun4i_gpadc_fifo_data_irq_handler(int irq, void *dev_id)
 		complete(&info->completion);
 
 out:
-	disable_irq_nosync(info->fifo_data_irq);
 	return IRQ_HANDLED;
 }
 
-- 
2.11.0

