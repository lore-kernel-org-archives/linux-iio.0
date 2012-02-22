Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from db3ehsobe003.messaging.microsoft.com ([213.199.154.141]:5052
	"EHLO DB3EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751845Ab2BVMTw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 22 Feb 2012 07:19:52 -0500
From: <michael.hennerich@analog.com>
To: <greg@kroah.com>
CC: <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
	<device-drivers-devel@blackfin.uclinux.org>, <drivers@analog.com>,
	Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH] iio: core: constitfy available_scan_mask
Date: Wed, 22 Feb 2012 13:16:49 +0100
Message-ID: <1329913009-5024-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

The core must not modify available_scan_mask, because it causes problems
with drivers where multiple instances of the driver share the same mask set.
So make this explicit by marking available scan masks as const.

The max1363 driver needs some minor adjustment to accommodate this change.
Pull scan mask allocation into a separate function.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/adc/max1363_core.c    |   36 +++++++++++++++++++---------
 drivers/staging/iio/iio.h                 |    4 +-
 drivers/staging/iio/industrialio-buffer.c |    6 ++--
 3 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
index 3a5bd20..7f39ca3 100644
--- a/drivers/staging/iio/adc/max1363_core.c
+++ b/drivers/staging/iio/adc/max1363_core.c
@@ -1245,10 +1245,31 @@ static int max1363_initial_setup(struct max1363_state *st)
 	return max1363_set_scan_mode(st);
 }
 
+static int __devinit max1363_alloc_scan_masks(struct iio_dev *indio_dev)
+{
+	struct max1363_state *st = iio_priv(indio_dev);
+	unsigned long *masks;
+	int i;
+
+	masks = kzalloc(BITS_TO_LONGS(MAX1363_MAX_CHANNELS)*sizeof(long)*
+			  (st->chip_info->num_modes + 1), GFP_KERNEL);
+	if (!masks)
+		return -ENOMEM;
+
+	for (i = 0; i < st->chip_info->num_modes; i++)
+		bitmap_copy(masks + BITS_TO_LONGS(MAX1363_MAX_CHANNELS)*i,
+			    max1363_mode_table[st->chip_info->mode_list[i]]
+			    .modemask, MAX1363_MAX_CHANNELS);
+
+	indio_dev->available_scan_masks = masks;
+
+	return 0;
+}
+
 static int __devinit max1363_probe(struct i2c_client *client,
 				   const struct i2c_device_id *id)
 {
-	int ret, i;
+	int ret;
 	struct max1363_state *st;
 	struct iio_dev *indio_dev;
 	struct regulator *reg;
@@ -1276,19 +1297,10 @@ static int __devinit max1363_probe(struct i2c_client *client,
 	st->chip_info = &max1363_chip_info_tbl[id->driver_data];
 	st->client = client;
 
-	indio_dev->available_scan_masks
-		= kzalloc(BITS_TO_LONGS(MAX1363_MAX_CHANNELS)*sizeof(long)*
-			  (st->chip_info->num_modes + 1), GFP_KERNEL);
-	if (!indio_dev->available_scan_masks) {
-		ret = -ENOMEM;
+	ret = max1363_alloc_scan_masks(indio_dev);
+	if (ret)
 		goto error_free_device;
-	}
 
-	for (i = 0; i < st->chip_info->num_modes; i++)
-		bitmap_copy(indio_dev->available_scan_masks +
-			    BITS_TO_LONGS(MAX1363_MAX_CHANNELS)*i,
-			    max1363_mode_table[st->chip_info->mode_list[i]]
-			    .modemask, MAX1363_MAX_CHANNELS);
 	/* Estabilish that the iio_dev is a child of the i2c device */
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->name = id->name;
diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index be6ced3..42a362c 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -327,9 +327,9 @@ struct iio_dev {
 	struct iio_buffer		*buffer;
 	struct mutex			mlock;
 
-	unsigned long			*available_scan_masks;
+	const unsigned long		*available_scan_masks;
 	unsigned			masklength;
-	unsigned long			*active_scan_mask;
+	const unsigned long		*active_scan_mask;
 	struct iio_trigger		*trig;
 	struct iio_poll_func		*pollfunc;
 
diff --git a/drivers/staging/iio/industrialio-buffer.c b/drivers/staging/iio/industrialio-buffer.c
index d7b1e9e..386ba76 100644
--- a/drivers/staging/iio/industrialio-buffer.c
+++ b/drivers/staging/iio/industrialio-buffer.c
@@ -489,9 +489,9 @@ ssize_t iio_buffer_show_enable(struct device *dev,
 EXPORT_SYMBOL(iio_buffer_show_enable);
 
 /* note NULL used as error indicator as it doesn't make sense. */
-static unsigned long *iio_scan_mask_match(unsigned long *av_masks,
+static const unsigned long *iio_scan_mask_match(const unsigned long *av_masks,
 					  unsigned int masklength,
-					  unsigned long *mask)
+					  const unsigned long *mask)
 {
 	if (bitmap_empty(mask, masklength))
 		return NULL;
@@ -554,7 +554,7 @@ EXPORT_SYMBOL(iio_sw_buffer_preenable);
 int iio_scan_mask_set(struct iio_dev *indio_dev,
 		      struct iio_buffer *buffer, int bit)
 {
-	unsigned long *mask;
+	const unsigned long *mask;
 	unsigned long *trialmask;
 
 	trialmask = kmalloc(sizeof(*trialmask)*
-- 
1.7.0.4


