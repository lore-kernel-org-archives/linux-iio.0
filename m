Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34696 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753127AbdATUZe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Jan 2017 15:25:34 -0500
Date: Fri, 20 Jan 2017 12:22:58 -0800
From: Alison Schofield <amsfield22@gmail.com>
To: jic23@kernel.org
Cc: tduszyns@gmail.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iio: pressure: ms5611: claim direct mode during oversampling
 changes
Message-ID: <20170120202242.GA2153@d830.WORKGROUP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Driver was checking for direct mode before changing oversampling
ratios, but was not locking it.  Use the claim/release helper
functions to guarantee the device stays in direct mode while the
oversampling ratios are being updated.  Continue to use the drivers
private state lock to protect against conflicting direct mode access
of the state data.

Signed-off-by: Alison Schofield <amsfield22@gmail.com>
---
 drivers/iio/pressure/ms5611_core.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/pressure/ms5611_core.c b/drivers/iio/pressure/ms5611_core.c
index 6bd53e7..2a77a2f 100644
--- a/drivers/iio/pressure/ms5611_core.c
+++ b/drivers/iio/pressure/ms5611_core.c
@@ -308,6 +308,7 @@ static int ms5611_write_raw(struct iio_dev *indio_dev,
 {
 	struct ms5611_state *st = iio_priv(indio_dev);
 	const struct ms5611_osr *osr = NULL;
+	int ret;
 
 	if (mask != IIO_CHAN_INFO_OVERSAMPLING_RATIO)
 		return -EINVAL;
@@ -321,12 +322,11 @@ static int ms5611_write_raw(struct iio_dev *indio_dev,
 	if (!osr)
 		return -EINVAL;
 
-	mutex_lock(&st->lock);
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret)
+		return ret;
 
-	if (iio_buffer_enabled(indio_dev)) {
-		mutex_unlock(&st->lock);
-		return -EBUSY;
-	}
+	mutex_lock(&st->lock);
 
 	if (chan->type == IIO_TEMP)
 		st->temp_osr = osr;
@@ -334,6 +334,8 @@ static int ms5611_write_raw(struct iio_dev *indio_dev,
 		st->pressure_osr = osr;
 
 	mutex_unlock(&st->lock);
+	iio_device_release_direct_mode(indio_dev);
+
 	return 0;
 }
 
-- 
2.1.4

