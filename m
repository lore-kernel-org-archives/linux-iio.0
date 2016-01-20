Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35217 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933838AbcATQHp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 20 Jan 2016 11:07:45 -0500
Received: by mail-pa0-f67.google.com with SMTP id gi1so556977pac.2
        for <linux-iio@vger.kernel.org>; Wed, 20 Jan 2016 08:07:45 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH] iio: pressure: mpl115: fix temperature offset sign
Date: Thu, 21 Jan 2016 01:07:31 +0900
Message-Id: <1453306051-8817-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

According to the datasheet, the resolusion of temperature sensor is
-5.35 counts/C. Temperature ADC is 472 counts at 25C.
(https://www.sparkfun.com/datasheets/Sensors/Pressure/MPL115A1.pdf
NOTE: This is older revision, but this information is removed from the
latest datasheet from nxp somehow)

Temp [C] = (Tadc - 472) / -5.35 + 25
         = (Tadc - 605.750000) * -0.186915888

So the correct offset is -605.750000.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org
---
 drivers/iio/pressure/mpl115.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/mpl115.c b/drivers/iio/pressure/mpl115.c
index 138344c..73f2f0c 100644
--- a/drivers/iio/pressure/mpl115.c
+++ b/drivers/iio/pressure/mpl115.c
@@ -118,7 +118,7 @@ static int mpl115_read_raw(struct iio_dev *indio_dev,
 		*val = ret >> 6;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_OFFSET:
-		*val = 605;
+		*val = -605;
 		*val2 = 750000;
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_SCALE:
-- 
2.5.0

