Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:43256 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752954AbaFGPbr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 7 Jun 2014 11:31:47 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, jic23@kernel.org,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH v2 01/13] iio:adc:ad799x: Fix reading and writing of event values, apply shift
Date: Sat,  7 Jun 2014 17:31:25 +0200
Message-Id: <1402155097-435-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1402155097-435-1-git-send-email-pmeerw@pmeerw.net>
References: <1402155097-435-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

last two bits of ADC and limit values are zero and should not be reported
(ad7993, ad7997); compare with read_raw()

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/adc/ad799x.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index 39b4cb4..099b830 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -429,7 +429,8 @@ static int ad799x_write_event_value(struct iio_dev *indio_dev,
 
 	mutex_lock(&indio_dev->mlock);
 	ret = ad799x_i2c_write16(st, ad799x_threshold_reg(chan, dir, info),
-		val);
+		(val & RES_MASK(chan->scan_type.realbits))
+			<< chan->scan_type.shift);
 	mutex_unlock(&indio_dev->mlock);
 
 	return ret;
@@ -452,7 +453,8 @@ static int ad799x_read_event_value(struct iio_dev *indio_dev,
 	mutex_unlock(&indio_dev->mlock);
 	if (ret < 0)
 		return ret;
-	*val = valin;
+	*val = (valin >> chan->scan_type.shift) &
+		RES_MASK(chan->scan_type.realbits);
 
 	return IIO_VAL_INT;
 }
-- 
1.9.1

