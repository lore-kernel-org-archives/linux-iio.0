Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:38679 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429AbaA3L7M (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 30 Jan 2014 06:59:12 -0500
Date: Thu, 30 Jan 2014 14:58:50 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Wei Yongjun <yongjun_wei@trendmicro.com.cn>,
	Sachin Kamat <sachin.kamat@linaro.org>,
	linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [patch] iio: dac: ad7303: remove an unneeded check
Message-ID: <20140130115849.GI12734@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

"ret" is zero here.  There is no need to check again.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/iio/dac/ad7303.c b/drivers/iio/dac/ad7303.c
index d0505fd22ef4..fa2810032968 100644
--- a/drivers/iio/dac/ad7303.c
+++ b/drivers/iio/dac/ad7303.c
@@ -92,7 +92,7 @@ static ssize_t ad7303_write_dac_powerdown(struct iio_dev *indio_dev,
 	ad7303_write(st, chan->channel, st->dac_cache[chan->channel]);
 
 	mutex_unlock(&indio_dev->mlock);
-	return ret ? ret : len;
+	return len;
 }
 
 static int ad7303_get_vref(struct ad7303_state *st,
