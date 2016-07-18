Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:34215 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762AbcGRTf0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jul 2016 15:35:26 -0400
Date: Mon, 18 Jul 2016 12:35:24 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: jic23@kernel.org
Cc: Michael.Hennerich@analog.com, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: ad7793: use iio helper function to guarantee
 direct mode
Message-ID: <20160718193513.GA3862@d830.WORKGROUP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Replace the code that guarantees the device stays in direct mode
with iio_device_claim_direct_mode() which does same.

Signed-off-by: Alison Schofield <amsfield22@gmail.com>
Cc: Daniel Baluta <daniel.baluta@gmail.com>
---
This driver is not doing any error checking on the code I just wrapped
in device_claim/release.  It first saves info to the global state and
then writes it to a register, with no error checking. 

Does similar in both *write_raw, and *write_frequency.  

I could add error checking in another patch if it's desired. I don't have
this sensor to verify.  Let me know if that would be welcome. Thanks!


 drivers/iio/adc/ad7793.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
index 847789b..e6706a0 100644
--- a/drivers/iio/adc/ad7793.c
+++ b/drivers/iio/adc/ad7793.c
@@ -519,11 +519,9 @@ static int ad7793_write_raw(struct iio_dev *indio_dev,
 	int ret, i;
 	unsigned int tmp;
 
-	mutex_lock(&indio_dev->mlock);
-	if (iio_buffer_enabled(indio_dev)) {
-		mutex_unlock(&indio_dev->mlock);
-		return -EBUSY;
-	}
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret)
+		return ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
@@ -548,7 +546,7 @@ static int ad7793_write_raw(struct iio_dev *indio_dev,
 		ret = -EINVAL;
 	}
 
-	mutex_unlock(&indio_dev->mlock);
+	iio_device_release_direct_mode(indio_dev);
 	return ret;
 }
 
-- 
2.1.4

