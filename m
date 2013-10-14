Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Marek Vasut <marex@denx.de>
Subject: [PATCH 13/17] staging:iio:mxs-lradc: Remove redundant call to iio_sw_buffer_preenable()
Date: Mon, 14 Oct 2013 18:49:26 +0200
Message-Id: <1381769370-17100-13-git-send-email-lars@metafoo.de>
In-Reply-To: <1381769370-17100-1-git-send-email-lars@metafoo.de>
References: <1381769370-17100-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

The equivalent of iio_sw_buffer_preenable() is now done in the IIO buffer core,
so there is no need to do this from the driver anymore.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Marek Vasut <marex@denx.de>
---
 drivers/staging/iio/adc/mxs-lradc.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index dfd1bc1..1bb03e1 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -1041,10 +1041,6 @@ static int mxs_lradc_buffer_preenable(struct iio_dev *iio)
 		goto err_mem;
 	}
 
-	ret = iio_sw_buffer_preenable(iio);
-	if (ret < 0)
-		goto err_buf;
-
 	if (lradc->soc == IMX28_LRADC)
 		mxs_lradc_reg_clear(lradc, LRADC_CTRL1_MX28_LRADC_IRQ_EN_MASK,
 							LRADC_CTRL1);
@@ -1069,8 +1065,6 @@ static int mxs_lradc_buffer_preenable(struct iio_dev *iio)
 
 	return 0;
 
-err_buf:
-	kfree(lradc->buffer);
 err_mem:
 	mutex_unlock(&lradc->lock);
 	return ret;
-- 
1.8.0
