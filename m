Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:33237 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754454AbcEXTU0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 24 May 2016 15:20:26 -0400
Date: Tue, 24 May 2016 12:20:24 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
	pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] iio: adc: ad799x: use iio helper function to guarantee
 direct mode
Message-ID: <2df3d20cdbc9c3294ef91b515dcdfe0ad151bd01.1464115008.git.amsfield22@gmail.com>
References: <cover.1464115008.git.amsfield22@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1464115008.git.amsfield22@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Replace the code that guarantees the device stays in direct mode
with iio_device_claim_direct_mode() which does same.

Signed-off-by: Alison Schofield <amsfield22@gmail.com>
Cc: Daniel Baluta <daniel.baluta@gmail.com>
---
 drivers/iio/adc/ad799x.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index a3f5254..ec0200d 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -282,12 +282,11 @@ static int ad799x_read_raw(struct iio_dev *indio_dev,
 
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
-		mutex_lock(&indio_dev->mlock);
-		if (iio_buffer_enabled(indio_dev))
-			ret = -EBUSY;
-		else
-			ret = ad799x_scan_direct(st, chan->scan_index);
-		mutex_unlock(&indio_dev->mlock);
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+		ret = ad799x_scan_direct(st, chan->scan_index);
+		iio_device_release_direct_mode(indio_dev);
 
 		if (ret < 0)
 			return ret;
@@ -395,11 +394,9 @@ static int ad799x_write_event_config(struct iio_dev *indio_dev,
 	struct ad799x_state *st = iio_priv(indio_dev);
 	int ret;
 
-	mutex_lock(&indio_dev->mlock);
-	if (iio_buffer_enabled(indio_dev)) {
-		ret = -EBUSY;
-		goto done;
-	}
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret)
+		return ret;
 
 	if (state)
 		st->config |= BIT(chan->scan_index) << AD799X_CHANNEL_SHIFT;
@@ -412,10 +409,7 @@ static int ad799x_write_event_config(struct iio_dev *indio_dev,
 		st->config &= ~AD7998_ALERT_EN;
 
 	ret = ad799x_write_config(st, st->config);
-
-done:
-	mutex_unlock(&indio_dev->mlock);
-
+	iio_device_release_direct_mode(indio_dev);
 	return ret;
 }
 
-- 
2.1.4

