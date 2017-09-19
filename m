Return-Path: <SRS0=gvug=AU=rwth-aachen.de=Stefan.Bruens@kernel.org>
From: =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>
To: <linux-iio@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter
 Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH 2/4] iio: light: vl6180: Avoid readback of integration time register
Date: Tue, 19 Sep 2017 05:11:42 +0200
Message-ID: <20170919031144.4968-3-stefan.bruens@rwth-aachen.de>
In-Reply-To: <20170919031144.4968-1-stefan.bruens@rwth-aachen.de>
References: <20170919031144.4968-1-stefan.bruens@rwth-aachen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

Instead of reading the value from the register on each query, store the
set value.

Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>
---
 drivers/iio/light/vl6180.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/vl6180.c b/drivers/iio/light/vl6180.c
index 57577d5d18ac..ae768c832d66 100644
--- a/drivers/iio/light/vl6180.c
+++ b/drivers/iio/light/vl6180.c
@@ -86,6 +86,7 @@
 struct vl6180_data {
 	struct i2c_client *client;
 	struct mutex lock;
+	unsigned int als_it_ms;
 };
 
 enum { VL6180_ALS, VL6180_RANGE, VL6180_PROX };
@@ -306,13 +307,11 @@ static int vl6180_read_raw(struct iio_dev *indio_dev,
 
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_INT_TIME:
-		ret = vl6180_read_word(data->client, VL6180_ALS_IT);
-		if (ret < 0)
-			return ret;
-		*val = 0; /* 1 count = 1ms (0 = 1ms) */
-		*val2 = (ret + 1) * 1000; /* convert to seconds */
+		*val = 0;
+		*val2 = data->als_it_ms * 1000;
 
 		return IIO_VAL_INT_PLUS_MICRO;
+
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_LIGHT:
@@ -401,6 +400,9 @@ static int vl6180_set_it(struct vl6180_data *data, int val, int val2)
 
 	ret = vl6180_write_word(data->client, VL6180_ALS_IT, it_ms - 1);
 
+	if (ret >= 0)
+		data->als_it_ms = it_ms;
+
 fail:
 	vl6180_hold(data, false);
 	mutex_unlock(&data->lock);
@@ -472,6 +474,7 @@ static int vl6180_init(struct vl6180_data *data)
 		return ret;
 
 	/* ALS integration time: 100ms */
+	data->als_it_ms = 100;
 	ret = vl6180_write_word(client, VL6180_ALS_IT, VL6180_ALS_IT_100);
 	if (ret < 0)
 		return ret;
-- 
2.14.1
