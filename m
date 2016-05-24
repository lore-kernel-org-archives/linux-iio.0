Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:33019 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753719AbcEXTTv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 24 May 2016 15:19:51 -0400
Date: Tue, 24 May 2016 12:19:49 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
	pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] iio: adc: ad7923: use iio helper function to guarantee
 direct mode
Message-ID: <50659d12998d47dfe9da2b7bc7fbfc483588e5da.1464115008.git.amsfield22@gmail.com>
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
 drivers/iio/adc/ad7923.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
index 45e29cc..ff444c1 100644
--- a/drivers/iio/adc/ad7923.c
+++ b/drivers/iio/adc/ad7923.c
@@ -233,12 +233,11 @@ static int ad7923_read_raw(struct iio_dev *indio_dev,
 
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
-		mutex_lock(&indio_dev->mlock);
-		if (iio_buffer_enabled(indio_dev))
-			ret = -EBUSY;
-		else
-			ret = ad7923_scan_direct(st, chan->address);
-		mutex_unlock(&indio_dev->mlock);
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+		ret = ad7923_scan_direct(st, chan->address);
+		iio_device_release_direct_mode(indio_dev);
 
 		if (ret < 0)
 			return ret;
-- 
2.1.4

