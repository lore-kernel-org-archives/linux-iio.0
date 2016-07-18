Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35077 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751923AbcGRTeU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jul 2016 15:34:20 -0400
Date: Mon, 18 Jul 2016 12:34:17 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: jic23@kernel.org
Cc: Michael.Hennerich@analog.com, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: ad7298: use iio helper function to guarantee
 direct mode
Message-ID: <20160718193408.GA3854@d830.WORKGROUP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Replace the code that guarantees the device stays in direct mode
with iio_device_claim_direct_mode() which does same.

Signed-off-by: Alison Schofield <amsfield22@gmail.com>
Cc: Daniel Baluta <daniel.baluta@gmail.com>
---
 drivers/iio/adc/ad7298.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/ad7298.c b/drivers/iio/adc/ad7298.c
index 10ec8fc..e399bf0 100644
--- a/drivers/iio/adc/ad7298.c
+++ b/drivers/iio/adc/ad7298.c
@@ -239,16 +239,16 @@ static int ad7298_read_raw(struct iio_dev *indio_dev,
 
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
-		mutex_lock(&indio_dev->mlock);
-		if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
-			ret = -EBUSY;
-		} else {
-			if (chan->address == AD7298_CH_TEMP)
-				ret = ad7298_scan_temp(st, val);
-			else
-				ret = ad7298_scan_direct(st, chan->address);
-		}
-		mutex_unlock(&indio_dev->mlock);
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+
+		if (chan->address == AD7298_CH_TEMP)
+			ret = ad7298_scan_temp(st, val);
+		else
+			ret = ad7298_scan_direct(st, chan->address);
+
+		iio_device_release_direct_mode(indio_dev);
 
 		if (ret < 0)
 			return ret;
-- 
2.1.4

