Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
To: linux-iio@vger.kernel.org
Cc: otavio@ossystems.com.br,
	Marek Vasut <marex@denx.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH V2] iio: mxs-lradc: Remove useless check in read_raw
Date: Wed,  3 Jul 2013 23:25:14 +0200
Message-Id: <1372886714-25456-1-git-send-email-marex@denx.de>
List-ID: <linux-iio@vger.kernel.org>

The removed check in the read_raw implementation was always true,
therefore remove it. This also fixes a bug, by closely inspecting
the code, one can notice the iio_validate_scan_mask_onehot() will
always return 1 and therefore the subsequent condition will always
succeed, therefore making the mxs_lradc_read_raw() function always
return -EINVAL; .

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/staging/iio/adc/mxs-lradc.c |    7 -------
 1 file changed, 7 deletions(-)

V2: Update the patch description, by discussion on the ML, we found
    out this accidentally fixes a bug.

diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index d92c97a..c318eb6 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -234,7 +234,6 @@ static int mxs_lradc_read_raw(struct iio_dev *iio_dev,
 {
 	struct mxs_lradc *lradc = iio_priv(iio_dev);
 	int ret;
-	unsigned long mask;
 
 	if (m != IIO_CHAN_INFO_RAW)
 		return -EINVAL;
@@ -243,12 +242,6 @@ static int mxs_lradc_read_raw(struct iio_dev *iio_dev,
 	if (chan->channel > LRADC_MAX_TOTAL_CHANS)
 		return -EINVAL;
 
-	/* Validate the channel if it doesn't intersect with reserved chans. */
-	bitmap_set(&mask, chan->channel, 1);
-	ret = iio_validate_scan_mask_onehot(iio_dev, &mask);
-	if (ret)
-		return -EINVAL;
-
 	/*
 	 * See if there is no buffered operation in progess. If there is, simply
 	 * bail out. This can be improved to support both buffered and raw IO at
-- 
1.7.10.4
