Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33709 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751121AbdATWSM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Jan 2017 17:18:12 -0500
Date: Fri, 20 Jan 2017 14:11:30 -0800
From: Alison Schofield <amsfield22@gmail.com>
To: jic23@kernel.org
Cc: ddvlad@gmail.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iio: proximity: sx9500: claim direct mode during raw
 proximity reads
Message-ID: <20170120221123.GA22905@d830.WORKGROUP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Driver was checking for direct mode but not locking it.  Use the
claim/release helper functions to guarantee the device stays in
direct mode during raw reads of proximity data.

Signed-off-by: Alison Schofield <amsfield22@gmail.com>
---
 drivers/iio/proximity/sx9500.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
index 1f06282..9ea147f 100644
--- a/drivers/iio/proximity/sx9500.c
+++ b/drivers/iio/proximity/sx9500.c
@@ -387,14 +387,18 @@ static int sx9500_read_raw(struct iio_dev *indio_dev,
 			   int *val, int *val2, long mask)
 {
 	struct sx9500_data *data = iio_priv(indio_dev);
+	int ret;
 
 	switch (chan->type) {
 	case IIO_PROXIMITY:
 		switch (mask) {
 		case IIO_CHAN_INFO_RAW:
-			if (iio_buffer_enabled(indio_dev))
-				return -EBUSY;
-			return sx9500_read_proximity(data, chan, val);
+			ret = iio_device_claim_direct_mode(indio_dev);
+			if (ret)
+				return ret;
+			ret = sx9500_read_proximity(data, chan, val);
+			iio_device_release_direct_mode(indio_dev);
+			return ret;
 		case IIO_CHAN_INFO_SAMP_FREQ:
 			return sx9500_read_samp_freq(data, val, val2);
 		default:
-- 
2.1.4

