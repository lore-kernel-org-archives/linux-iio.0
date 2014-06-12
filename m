Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:47784 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750896AbaFLEy2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 12 Jun 2014 00:54:28 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH v3 01/12] iio:adc:ad799x: Fix reading and writing of event values, apply shift
Date: Thu, 12 Jun 2014 06:54:05 +0200
Message-Id: <1402548856-3564-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1402548856-3564-1-git-send-email-pmeerw@pmeerw.net>
References: <1402548856-3564-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

last two bits of ADC and limit values are zero and should not be reported
(ad7993, ad7997); compare with read_raw()

event values are 10 (ad7993, ad7997) or 12 bit max., check the range on write

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/adc/ad799x.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index 39b4cb4..6eba301 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -427,9 +427,12 @@ static int ad799x_write_event_value(struct iio_dev *indio_dev,
 	int ret;
 	struct ad799x_state *st = iio_priv(indio_dev);
 
+	if (val < 0 || val > RES_MASK(chan->scan_type.realbits))
+		return -EINVAL;
+
 	mutex_lock(&indio_dev->mlock);
 	ret = ad799x_i2c_write16(st, ad799x_threshold_reg(chan, dir, info),
-		val);
+		val << chan->scan_type.shift);
 	mutex_unlock(&indio_dev->mlock);
 
 	return ret;
@@ -452,7 +455,8 @@ static int ad799x_read_event_value(struct iio_dev *indio_dev,
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

