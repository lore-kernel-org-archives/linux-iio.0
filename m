Return-Path: <SRS0=m70m=AY=rwth-aachen.de=Stefan.Bruens@kernel.org>
From: =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>
To: <linux-iio@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter
 Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH v2 4/4] iio: light: vl6180: Correct ALS scale for non-default gain/integration time
Date: Sun, 24 Sep 2017 00:58:24 +0200
Message-ID: <20170923225824.8435-5-stefan.bruens@rwth-aachen.de>
In-Reply-To: <20170923225824.8435-1-stefan.bruens@rwth-aachen.de>
References: <20170923225824.8435-1-stefan.bruens@rwth-aachen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

The reported scale was only correct for the default settings of 100 ms
integration time and gain 1.

This aligns the reported scale with the behaviour of any other IIO driver
and the documented ABI, but may require userspace changes if someone uses
non-default settings.

Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>
---
 drivers/iio/light/vl6180.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/vl6180.c b/drivers/iio/light/vl6180.c
index 5de64bce305c..52dfa2de88f7 100644
--- a/drivers/iio/light/vl6180.c
+++ b/drivers/iio/light/vl6180.c
@@ -315,9 +315,12 @@ static int vl6180_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_LIGHT:
-			*val = 0; /* one ALS count is 0.32 Lux */
-			*val2 = 320000;
-			break;
+			/* one ALS count is 0.32 Lux @ gain 1, IT 100 ms */
+			*val = 32000; /* 0.32 * 1000 * 100 */
+			*val2 = data->als_gain_milli * data->als_it_ms;
+
+			return IIO_VAL_FRACTIONAL;
+
 		case IIO_DISTANCE:
 			*val = 0; /* sensor reports mm, scale to meter */
 			*val2 = 1000;
-- 
2.14.1
