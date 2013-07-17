Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-051.synserver.de ([212.40.185.51]:1090 "EHLO
	smtp-out-051.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755703Ab3GQOoF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 17 Jul 2013 10:44:05 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 06/15] staging:iio:adis16260: Add value range check for calibscale/-bias
Date: Wed, 17 Jul 2013 16:44:30 +0200
Message-Id: <1374072279-7140-6-git-send-email-lars@metafoo.de>
In-Reply-To: <1374072279-7140-1-git-send-email-lars@metafoo.de>
References: <1374072279-7140-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Instead of just cutting of the upper bits of the value make sure that the value
is in the valid range and return an error if it is not.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/gyro/adis16260_core.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index a01c243..55e6795 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -311,18 +311,21 @@ static int adis16260_write_raw(struct iio_dev *indio_dev,
 			       long mask)
 {
 	struct adis *adis = iio_priv(indio_dev);
-	int bits = 12;
-	s16 val16;
 	u8 addr;
+
 	switch (mask) {
 	case IIO_CHAN_INFO_CALIBBIAS:
-		val16 = val & ((1 << bits) - 1);
+		if (val < -2048 || val >= 2048)
+			return -EINVAL;
+
 		addr = adis16260_addresses[chan->scan_index][0];
-		return adis_write_reg_16(adis, addr, val16);
+		return adis_write_reg_16(adis, addr, val);
 	case IIO_CHAN_INFO_CALIBSCALE:
-		val16 = val & ((1 << bits) - 1);
+		if (val < 0 || val >= 4096)
+			return -EINVAL;
+
 		addr = adis16260_addresses[chan->scan_index][1];
-		return adis_write_reg_16(adis, addr, val16);
+		return adis_write_reg_16(adis, addr, val);
 	}
 	return -EINVAL;
 }
-- 
1.8.0

