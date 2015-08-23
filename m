Return-Path: <nicola@corna.info>
From: Nicola Corna <nicola@corna.info>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org,
	Nicola Corna <nicola@corna.info>
Subject: [PATCH v4 1/2] iio: humidity: si7020: replaced bitmask on humidity values with range check
Date: Sun, 23 Aug 2015 23:06:19 +0200
Message-Id: <1440363979-4845-1-git-send-email-nicola@corna.info>
List-ID: <linux-iio@vger.kernel.org>

The maximum possible value for the relative humidity is 55575 (100%RH).
This value, if shifted right by 2 bits, uses 14 bits and masking it with
a 12 bit mask removes 2 meaningful bits.
The masking has been replaced with a range check that sets the minimum
value at 786 (0%RH) and the maximum at 13893 (99.998%RH).

Signed-off-by: Nicola Corna <nicola@corna.info>
Reviewed-by: Hartmut Knaack <knaack.h@gmx.de>
---
 drivers/iio/humidity/si7020.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/humidity/si7020.c b/drivers/iio/humidity/si7020.c
index fa3b809..12128d1 100644
--- a/drivers/iio/humidity/si7020.c
+++ b/drivers/iio/humidity/si7020.c
@@ -57,8 +57,12 @@ static int si7020_read_raw(struct iio_dev *indio_dev,
 		if (ret < 0)
 			return ret;
 		*val = ret >> 2;
+		/*
+		 * Humidity values can slightly exceed the 0-100%RH
+		 * range and should be corrected by software
+		 */
 		if (chan->type == IIO_HUMIDITYRELATIVE)
-			*val &= GENMASK(11, 0);
+			*val = clamp_val(*val, 786, 13893);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		if (chan->type == IIO_TEMP)
-- 
2.5.0
