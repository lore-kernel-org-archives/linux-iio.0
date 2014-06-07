Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:43275 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753021AbaFGPbt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 7 Jun 2014 11:31:49 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, jic23@kernel.org,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH v2 08/13] iio:adc:ad799x: Check range when writing event value
Date: Sat,  7 Jun 2014 17:31:32 +0200
Message-Id: <1402155097-435-9-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1402155097-435-1-git-send-email-pmeerw@pmeerw.net>
References: <1402155097-435-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

event values are 10 (ad7993, ad7997) or 12 bit max.,
check the range on write

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/adc/ad799x.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index ae32ea1..fbdefcd 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -368,6 +368,9 @@ static int ad799x_write_event_value(struct iio_dev *indio_dev,
 	int ret;
 	struct ad799x_state *st = iio_priv(indio_dev);
 
+	if (val < 0 || val > GENMASK(chan->scan_type.realbits - 1, 0))
+		return -EINVAL;
+
 	mutex_lock(&indio_dev->mlock);
 	ret = i2c_smbus_write_word_swapped(st->client,
 		ad799x_threshold_reg(chan, dir, info),
-- 
1.9.1

