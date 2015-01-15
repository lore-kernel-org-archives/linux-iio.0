Return-Path: <roberta.dobrescu@gmail.com>
From: Roberta Dobrescu <roberta.dobrescu@gmail.com>
To: linux-iio@vger.kernel.org,
	jic23@kernel.org
Cc: octavian.purdila@intel.com,
	daniel.baluta@intel.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>
Subject: [PATCH] iio: light: tcs3414: Fix misindented lines
Date: Fri, 16 Jan 2015 00:25:02 +0200
Message-Id: <1421360702-1488-1-git-send-email-roberta.dobrescu@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
---
 drivers/iio/light/tcs3414.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/tcs3414.c b/drivers/iio/light/tcs3414.c
index a9e449b..71c2bde 100644
--- a/drivers/iio/light/tcs3414.c
+++ b/drivers/iio/light/tcs3414.c
@@ -149,8 +149,8 @@ static int tcs3414_read_raw(struct iio_dev *indio_dev,
 		*val = ret;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-	i = (data->gain & TCS3414_GAIN_MASK) >> TCS3414_GAIN_SHIFT;
-	*val = tcs3414_scales[i][0];
+		i = (data->gain & TCS3414_GAIN_MASK) >> TCS3414_GAIN_SHIFT;
+		*val = tcs3414_scales[i][0];
 		*val2 = tcs3414_scales[i][1];
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_INT_TIME:
-- 
1.9.1
