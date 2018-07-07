Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from gateway34.websitewelcome.com ([192.185.149.101]:20120 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932546AbeGGRoF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 7 Jul 2018 13:44:05 -0400
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 6E67B16111F
        for <linux-iio@vger.kernel.org>; Sat,  7 Jul 2018 12:44:04 -0500 (CDT)
Date: Sat, 7 Jul 2018 12:44:01 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] iio: sca3000: Fix missing return in switch
Message-ID: <20180707174401.GA11730@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY case is missing a
return and will fall through to the default case and errorenously
return -EINVAL.

Fix this by adding in missing *return ret*.

Fixes: 626f971b5b07 ("staging:iio:accel:sca3000 Add write support to the low pass filter control")
Reported-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/iio/accel/sca3000.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index 4dceb75..4964561 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -797,6 +797,7 @@ static int sca3000_write_raw(struct iio_dev *indio_dev,
 		mutex_lock(&st->lock);
 		ret = sca3000_write_3db_freq(st, val);
 		mutex_unlock(&st->lock);
+		return ret;
 	default:
 		return -EINVAL;
 	}
-- 
2.7.4

