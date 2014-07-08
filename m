Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.20]:55145 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752753AbaGHLG7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 8 Jul 2014 07:06:59 -0400
Message-ID: <53BBD0CD.3030203@gmx.de>
Date: Tue, 08 Jul 2014 13:06:53 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: linux-iio@vger.kernel.org
CC: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/6] staging:iio:ad7291 fix ad7291_threshold_reg()
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

ad7291_threshold_reg() should return the register number of a threshold
register, and thus be safe without handling a default case.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
index f5d29ef..b868c64 100644
--- a/drivers/staging/iio/adc/ad7291.c
+++ b/drivers/staging/iio/adc/ad7291.c
@@ -174,8 +174,6 @@ static unsigned int ad7291_threshold_reg(const struct iio_chan_spec *chan,
 	case IIO_TEMP:
 		offset = 8;
 		break;
-	default:
-	    return 0;
 	}
 
 	switch (info) {
@@ -186,10 +184,7 @@ static unsigned int ad7291_threshold_reg(const struct iio_chan_spec *chan,
 			return AD7291_DATA_LOW(offset);
 	case IIO_EV_INFO_HYSTERESIS:
 		return AD7291_HYST(offset);
-	default:
-		break;
 	}
-	return 0;
 }
 
 static int ad7291_read_event_value(struct iio_dev *indio_dev,
