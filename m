Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:50112 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753413AbaGHLHE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 8 Jul 2014 07:07:04 -0400
Message-ID: <53BBD0D1.2070507@gmx.de>
Date: Tue, 08 Jul 2014 13:06:57 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: linux-iio@vger.kernel.org
CC: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 5/6] staging:iio:ad7291 faciliate ad7291_read_event_config()
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Save some lines in returning a voltage event.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
index 654b39e..06eb0c0 100644
--- a/drivers/staging/iio/adc/ad7291.c
+++ b/drivers/staging/iio/adc/ad7291.c
@@ -242,10 +242,7 @@ static int ad7291_read_event_config(struct iio_dev *indio_dev,
 
 	switch (chan->type) {
 	case IIO_VOLTAGE:
-		if (chip->c_mask & BIT(15 - chan->channel))
-			return 1;
-		else
-			return 0;
+		return !!(chip->c_mask & BIT(15 - chan->channel));
 	case IIO_TEMP:
 		/* always on */
 		return 1;
