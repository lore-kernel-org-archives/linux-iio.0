Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-137.synserver.de ([212.40.185.137]:1093 "EHLO
	smtp-out-134.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752408Ab2GBMkz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 2 Jul 2012 08:40:55 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/5] staging:iio:ad7793: Use iio_validate_scan_mask_onehot
Date: Mon,  2 Jul 2012 14:44:42 +0200
Message-Id: <1341233083-8765-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1341233083-8765-1-git-send-email-lars@metafoo.de>
References: <1341233083-8765-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Only one of the channels of the ad7793 may be sampled at a time. Use the new
validate_scan_mask callback and the iio_validate_scan_mask_onehot function to
implement this restriction. Previously this was implemented using
available_scan_masks, but this requires a individual scan mask for each channel.

Also the previous code was adding the scan index of the timestamp channel to
each available scan mask, this is not required though since the timestamp
channel is not restricted by the available scan masks and can be enabled or
disabled independently. So the new code does not have to take care of this.
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad7793.c |   14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7793.c b/drivers/staging/iio/adc/ad7793.c
index eaa0cc9..76fdd71 100644
--- a/drivers/staging/iio/adc/ad7793.c
+++ b/drivers/staging/iio/adc/ad7793.c
@@ -52,8 +52,7 @@ struct ad7793_state {
 	u16				mode;
 	u16				conf;
 	u32				scale_avail[8][2];
-	/* Note this uses fact that 8 the mask always fits in a long */
-	unsigned long			available_scan_masks[7];
+
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
 	 * transfer buffers to live in their own cache lines.
@@ -403,6 +402,7 @@ static const struct iio_buffer_setup_ops ad7793_ring_setup_ops = {
 	.postenable = &iio_triggered_buffer_postenable,
 	.predisable = &iio_triggered_buffer_predisable,
 	.postdisable = &ad7793_ring_postdisable,
+	.validate_scan_mask = &iio_validate_scan_mask_onehot,
 };
 
 static int ad7793_register_ring_funcs_and_init(struct iio_dev *indio_dev)
@@ -864,7 +864,7 @@ static int __devinit ad7793_probe(struct spi_device *spi)
 	struct ad7793_platform_data *pdata = spi->dev.platform_data;
 	struct ad7793_state *st;
 	struct iio_dev *indio_dev;
-	int ret, i, voltage_uv = 0;
+	int ret, voltage_uv = 0;
 
 	if (!pdata) {
 		dev_err(&spi->dev, "no platform data?\n");
@@ -910,17 +910,9 @@ static int __devinit ad7793_probe(struct spi_device *spi)
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = st->chip_info->channel;
-	indio_dev->available_scan_masks = st->available_scan_masks;
 	indio_dev->num_channels = 7;
 	indio_dev->info = &ad7793_info;
 
-	for (i = 0; i < indio_dev->num_channels; i++) {
-		set_bit(i, &st->available_scan_masks[i]);
-		set_bit(indio_dev->
-			channels[indio_dev->num_channels - 1].scan_index,
-			&st->available_scan_masks[i]);
-	}
-
 	init_waitqueue_head(&st->wq_data_avail);
 
 	ret = ad7793_register_ring_funcs_and_init(indio_dev);
-- 
1.7.10

