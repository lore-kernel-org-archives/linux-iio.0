Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:32929 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753605AbcDFEL5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 6 Apr 2016 00:11:57 -0400
From: Alison Schofield <amsfield22@gmail.com>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: lars@metafoo.de, knaack.h@gmx.de, Michael.Hennerich@analog.com,
	pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: iio: ad7606: use iio_device_{claim|release}_direct_mode()
Date: Tue,  5 Apr 2016 21:11:31 -0700
Message-Id: <1459915891-2586-1-git-send-email-amsfield22@gmail.com>
In-Reply-To: <20160401165349.GA2678@d830.WORKGROUP>
References: <20160401165349.GA2678@d830.WORKGROUP>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Replace the code that guarantees the device stays in direct mode with
iio_device_{claim|release}_direct_mode() which does same.

Signed-off-by: Alison Schofield <amsfield22@gmail.com>
---
Changed in v2:
 - removed improper application of claim/release from intr handler
 - updated changelog

 drivers/staging/iio/adc/ad7606_core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
index 6dbc811..f79ee61 100644
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
-- 
2.1.4

