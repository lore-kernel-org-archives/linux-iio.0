Return-Path: <nicola@corna.info>
From: Nicola Corna <nicola@corna.info>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org,
	Nicola Corna <nicola@corna.info>
Subject: [PATCH 1/3] iio:humidity:si7020: replaced bitmask on humidity values with range check
Date: Thu, 20 Aug 2015 16:11:47 +0200
Message-Id: <1440079909-1337-1-git-send-email-nicola@corna.info>
List-ID: <linux-iio@vger.kernel.org>

The maximum possible value for the relative humidity is 55575 (100%RH).
This value, if shifted right by 2 bits, uses 14 bits and masking it with
a 12 bit mask removes 2 meaningful bits.
The masking has been replaced with a range check that sets the minimum
value at 3194 (0%RH) and the maximum at 55575 (100%RH).

Signed-off-by: Nicola Corna <nicola@corna.info>
---
 drivers/iio/humidity/si7020.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/humidity/si7020.c b/drivers/iio/humidity/si7020.c
index fa3b809..62fdbcf 100644
--- a/drivers/iio/humidity/si7020.c
+++ b/drivers/iio/humidity/si7020.c
@@ -57,8 +57,16 @@ static int si7020_read_raw(struct iio_dev *indio_dev,
 		if (ret < 0)
 			return ret;
 		*val = ret >> 2;
-		if (chan->type == IIO_HUMIDITYRELATIVE)
-			*val &= GENMASK(11, 0);
+		/*
+		 * Humidity values can sligthly exceed the 0-100%RH
+		 * range and should be corrected by software
+		 */
+		if (chan->type == IIO_HUMIDITYRELATIVE) {
+			if (*val < 3194) /* 0%RH */
+				*val = 3194;
+			else if (*val > 55575) /* 100%RH */
+				*val = 55575;
+		}
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		if (chan->type == IIO_TEMP)
-- 
2.5.0
