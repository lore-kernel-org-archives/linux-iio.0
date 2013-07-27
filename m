Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:60617 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752157Ab3G0PcF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 27 Jul 2013 11:32:05 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 9/9] staging:iio:hmc5843: Use i2c_smbus_read_word_swapped()
Date: Sat, 27 Jul 2013 17:31:52 +0200
Message-Id: <1374939112-18237-10-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1374939112-18237-1-git-send-email-pmeerw@pmeerw.net>
References: <1374939112-18237-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/staging/iio/magnetometer/hmc5843.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index 0b24d7e..70541aa 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -221,12 +221,12 @@ static int hmc5843_read_measurement(struct iio_dev *indio_dev,
 		return -EIO;
 	}
 
-	result = i2c_smbus_read_word_data(client, address);
+	result = i2c_smbus_read_word_swapped(client, address);
 	mutex_unlock(&data->lock);
 	if (result < 0)
 		return -EINVAL;
 
-	*val = (s16)swab16((u16)result);
+	*val = result;
 	return IIO_VAL_INT;
 }
 
-- 
1.8.3.4

