Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:33763 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751668AbcDAQyC (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 1 Apr 2016 12:54:02 -0400
Date: Fri, 1 Apr 2016 09:53:59 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: lars@metafoo.de, knaack.h@gmx.de, Michael.Hennerich@analog.com,
	pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: iio: ad7606: use
 iio_device_{claim|release}_direct_mode()
Message-ID: <20160401165349.GA2678@d830.WORKGROUP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Two instances are moved to the new claim/release API:

In the first instance, the driver was using mlock followed by
iio_buffer_enabled(). Replace that code with the new API to guarantee
the device stays in direct mode. There is no change in driver behavior.

In the second instance, the driver was not using mlock to hold the
device in direct mode, but should have been.  Here we introduce the
new API to guarantee direct mode. This is a change in driver behavior.

Signed-off-by: Alison Schofield <amsfield22@gmail.com>
---
 drivers/staging/iio/adc/ad7606_core.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
index 6dbc811..f914b8d 100644
--- a/drivers/staging/iio/adc/ad7606_core.c
+++ b/drivers/staging/iio/adc/ad7606_core.c
@@ -88,12 +88,12 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
 
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
-		mutex_lock(&indio_dev->mlock);
-		if (iio_buffer_enabled(indio_dev))
-			ret = -EBUSY;
-		else
-			ret = ad7606_scan_direct(indio_dev, chan->address);
-		mutex_unlock(&indio_dev->mlock);
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+
+		ret = ad7606_scan_direct(indio_dev, chan->address);
+		iio_device_release_direct_mode(indio_dev);
 
 		if (ret < 0)
 			return ret;
@@ -411,8 +411,9 @@ static irqreturn_t ad7606_interrupt(int irq, void *dev_id)
 	struct iio_dev *indio_dev = dev_id;
 	struct ad7606_state *st = iio_priv(indio_dev);
 
-	if (iio_buffer_enabled(indio_dev)) {
+	if (!iio_device_claim_direct_mode(indio_dev))  {
 		schedule_work(&st->poll_work);
+		iio_device_release_direct_mode(indio_dev);
 	} else {
 		st->done = true;
 		wake_up_interruptible(&st->wq_data_avail);
-- 
2.1.4

