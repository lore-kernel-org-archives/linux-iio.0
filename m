Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 5/6] staging:iio:ade7758: Use iio_validate_scan_mask_onehot
Date: Mon,  9 Jul 2012 11:00:51 +0200
Message-Id: <1341824452-28803-5-git-send-email-lars@metafoo.de>
In-Reply-To: <1341824452-28803-1-git-send-email-lars@metafoo.de>
References: <1341824452-28803-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Only one of the channels of the ade7758 may be sampled at a time. Use the new
validate_scan_mask callback and the iio_validate_scan_mask_onehot function to
implement this restriction. Previously this was implemented using
available_scan_masks, but this requires a individual scan mask for each channel.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
No changes since v1
---
 drivers/staging/iio/meter/ade7758.h      |    1 -
 drivers/staging/iio/meter/ade7758_core.c |    7 +------
 drivers/staging/iio/meter/ade7758_ring.c |    1 +
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7758.h b/drivers/staging/iio/meter/ade7758.h
index bdd1b05..ec202b4 100644
--- a/drivers/staging/iio/meter/ade7758.h
+++ b/drivers/staging/iio/meter/ade7758.h
@@ -122,7 +122,6 @@ struct ade7758_state {
 	u8			*tx;
 	u8			*rx;
 	struct mutex		buf_lock;
-	unsigned long		available_scan_masks[AD7758_NUM_WAVESRC];
 	struct iio_chan_spec	*ade7758_ring_channels;
 	struct spi_transfer	ring_xfer[4];
 	struct spi_message	ring_msg;
diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
index 96d6114..7014a00 100644
--- a/drivers/staging/iio/meter/ade7758_core.c
+++ b/drivers/staging/iio/meter/ade7758_core.c
@@ -883,7 +883,7 @@ static const struct iio_info ade7758_info = {
 
 static int __devinit ade7758_probe(struct spi_device *spi)
 {
-	int i, ret;
+	int ret;
 	struct ade7758_state *st;
 	struct iio_dev *indio_dev = iio_device_alloc(sizeof(*st));
 
@@ -916,11 +916,6 @@ static int __devinit ade7758_probe(struct spi_device *spi)
 	indio_dev->info = &ade7758_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	for (i = 0; i < AD7758_NUM_WAVESRC; i++)
-		set_bit(i, &st->available_scan_masks[i]);
-
-	indio_dev->available_scan_masks = st->available_scan_masks;
-
 	ret = ade7758_configure_ring(indio_dev);
 	if (ret)
 		goto error_free_tx;
diff --git a/drivers/staging/iio/meter/ade7758_ring.c b/drivers/staging/iio/meter/ade7758_ring.c
index 92159f2..1ce10b2 100644
--- a/drivers/staging/iio/meter/ade7758_ring.c
+++ b/drivers/staging/iio/meter/ade7758_ring.c
@@ -114,6 +114,7 @@ static const struct iio_buffer_setup_ops ade7758_ring_setup_ops = {
 	.preenable = &ade7758_ring_preenable,
 	.postenable = &iio_triggered_buffer_postenable,
 	.predisable = &iio_triggered_buffer_predisable,
+	.validate_scan_mask = &iio_validate_scan_mask_onehot,
 };
 
 void ade7758_unconfigure_ring(struct iio_dev *indio_dev)
-- 
1.7.10.4
