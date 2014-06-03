Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:58635 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933843AbaFCWm1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 3 Jun 2014 18:42:27 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, knaack.h@gmx.de,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 10/15] iio:adc:ad799x: Check event value range on write
Date: Wed,  4 Jun 2014 00:42:10 +0200
Message-Id: <1401835335-29969-11-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1401835335-29969-1-git-send-email-pmeerw@pmeerw.net>
References: <1401835335-29969-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

event values are 10 or 12 bit max., and need to be left-shifted
on ad7993, ad7997

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/adc/ad799x.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index 0d8e950..dbc7c2b 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -368,9 +368,13 @@ static int ad799x_write_event_value(struct iio_dev *indio_dev,
 	int ret;
 	struct ad799x_state *st = iio_priv(indio_dev);
 
+	if (val > GENMASK(chan->scan_type.realbits - 1, 0))
+		return -EINVAL;
+
 	mutex_lock(&indio_dev->mlock);
 	ret = i2c_smbus_write_word_swapped(st->client,
-		ad799x_threshold_reg(chan, dir, info), val);
+		ad799x_threshold_reg(chan, dir, info),
+		val << chan->scan_type.shift);
 	mutex_unlock(&indio_dev->mlock);
 
 	return ret;
-- 
1.9.1

