Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34389 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753233AbdCTS56 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Mar 2017 14:57:58 -0400
Date: Tue, 21 Mar 2017 00:26:16 +0530
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: lars@metafoo.de
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: [PATCH v3] staging: ad7606: Replace mlock with driver private lock
Message-ID: <20170320185616.GA17444@arushi-HP-Pavilion-Notebook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The IIO subsystem is redefining iio_dev->mlock to be used by
the IIO core only for protecting device operating mode changes.
ie. Changes between INDIO_DIRECT_MODE, INDIO_BUFFER_* modes.

In this driver, mlock was being used to protect hardware state
changes.  Replace it with a lock in the devices global data.

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
---
 changes in v3
 - Add mutex_init.

 drivers/staging/iio/adc/ad7606.c | 9 +++++----
 drivers/staging/iio/adc/ad7606.h | 2 ++
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7606.c b/drivers/staging/iio/adc/ad7606.c
index 9dbfa64b1e53..18f5f139117e 100644
--- a/drivers/staging/iio/adc/ad7606.c
+++ b/drivers/staging/iio/adc/ad7606.c
@@ -208,7 +208,7 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
 		ret = -EINVAL;
-		mutex_lock(&indio_dev->mlock);
+		mutex_lock(&st->lock);
 		for (i = 0; i < ARRAY_SIZE(scale_avail); i++)
 			if (val2 == scale_avail[i][1]) {
 				gpiod_set_value(st->gpio_range, i);
@@ -217,7 +217,7 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
 				ret = 0;
 				break;
 			}
-		mutex_unlock(&indio_dev->mlock);
+		mutex_unlock(&st->lock);
 
 		return ret;
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
@@ -231,11 +231,11 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
 		values[1] = (ret >> 1) & 1;
 		values[2] = (ret >> 2) & 1;
 
-		mutex_lock(&indio_dev->mlock);
+		mutex_lock(&st->lock);
 		gpiod_set_array_value(ARRAY_SIZE(values), st->gpio_os->desc,
 				      values);
 		st->oversampling = val;
-		mutex_unlock(&indio_dev->mlock);
+		mutex_unlock(&st->lock);
 
 		return 0;
 	default:
@@ -413,6 +413,7 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 	st = iio_priv(indio_dev);
 
 	st->dev = dev;
+	mutex_init(&st->lock);
 	st->bops = bops;
 	st->base_address = base_address;
 	/* tied to logic low, analog input range is +/- 5V */
diff --git a/drivers/staging/iio/adc/ad7606.h b/drivers/staging/iio/adc/ad7606.h
index 746f9553d2ba..5d59bdd78727 100644
--- a/drivers/staging/iio/adc/ad7606.h
+++ b/drivers/staging/iio/adc/ad7606.h
@@ -14,6 +14,7 @@
  * @name:		identification string for chip
  * @channels:		channel specification
  * @num_channels:	number of channels
+ * @lock		protect sensor state
  */
 
 struct ad7606_chip_info {
@@ -37,6 +38,7 @@ struct ad7606_state {
 	bool				done;
 	void __iomem			*base_address;
 
+	struct mutex			lock; /* protect sensor state */
 	struct gpio_desc		*gpio_convst;
 	struct gpio_desc		*gpio_reset;
 	struct gpio_desc		*gpio_range;
-- 
2.11.0

