Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:55189 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752583AbaBYTxN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 25 Feb 2014 14:53:13 -0500
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH] iio:magnetometer:mag3110: Fix unreachable code
Date: Tue, 25 Feb 2014 20:53:05 +0100
Message-Id: <1393357985-9314-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <20140224220419.GC29170@elgon.mountain>
References: <20140224220419.GC29170@elgon.mountain>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

        drivers/iio/magnetometer/mag3110.c:197 mag3110_read_raw()
        info: ignoring unreachable code.

drivers/iio/magnetometer/mag3110.c
   185          case IIO_CHAN_INFO_SCALE:
   186                  switch (chan->type) {
   187                  case IIO_MAGN:
   188                          *val = 0;
   189                          *val2 = 1000;
   190                          return IIO_VAL_INT_PLUS_MICRO;
   191                  case IIO_TEMP:
   192                          *val = 1000;
   193                          return IIO_VAL_INT;
   194                  default:
   195                          return -EINVAL;
   196                  }
   197                  return IIO_VAL_INT_PLUS_MICRO;
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

introduced by f9279d3a, mag3110: Scale factor missing

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/iio/magnetometer/mag3110.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/magnetometer/mag3110.c b/drivers/iio/magnetometer/mag3110.c
index 9f260a5..e3106b4 100644
--- a/drivers/iio/magnetometer/mag3110.c
+++ b/drivers/iio/magnetometer/mag3110.c
@@ -194,7 +194,6 @@ static int mag3110_read_raw(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
-		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		i = data->ctrl_reg1 >> MAG3110_CTRL_DR_SHIFT;
 		*val = mag3110_samp_freq[i][0];
-- 
1.8.3.2

