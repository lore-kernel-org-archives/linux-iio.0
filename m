Return-Path: <SRS0=ysYS=AZ=rwth-aachen.de=Stefan.Bruens@kernel.org>
From: =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>
To: <linux-iio@vger.kernel.org>
CC: Rob Herring <robh@kernel.org>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	=?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>,
	<linux-kernel@vger.kernel.org>, Manivannan Sadhasivam
	<manivannanece23@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, "Jonathan
 Cameron" <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>
Subject: [PATCH v3 1/4] iio: light: vl6180: Move range check to integration time setter, cleanup
Date: Sun, 24 Sep 2017 23:59:17 +0200
In-Reply-To: <20170924215920.7465-1-stefan.bruens@rwth-aachen.de>
References: <20170924215920.7465-1-stefan.bruens@rwth-aachen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Message-ID: <61978114-05a9-4557-806d-65bf7a4b0e2d@rwthex-w2-a.rwth-ad.de>
List-ID: <linux-iio@vger.kernel.org>

This improves code uniformity (range checks for als_gain are also done
in the setter). Also unmangle rounding and calculation of register value.

The calculated integration time it_ms is required in the next patch of
the series.

Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>

---

Changes in v3:
- Drop whitespace change

Changes in v2:
- Removed redundant parenthesis

 drivers/iio/light/vl6180.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/light/vl6180.c b/drivers/iio/light/vl6180.c
index 6e25b724d941..3b6351b89ce7 100644
--- a/drivers/iio/light/vl6180.c
+++ b/drivers/iio/light/vl6180.c
@@ -386,16 +386,21 @@ static int vl6180_set_als_gain(struct vl6180_data *data, int val, int val2)
 	return -EINVAL;
 }
 
-static int vl6180_set_it(struct vl6180_data *data, int val2)
+static int vl6180_set_it(struct vl6180_data *data, int val, int val2)
 {
-	int ret;
+	int ret, it_ms;
+
+	it_ms = (val2 + 500) / 1000; /* round to ms */
+	if (val != 0 || it_ms < 1 || it_ms > 512)
+		return -EINVAL;
 
 	mutex_lock(&data->lock);
 	ret = vl6180_hold(data, true);
 	if (ret < 0)
 		goto fail;
-	ret = vl6180_write_word(data->client, VL6180_ALS_IT,
-		(val2 - 500) / 1000); /* write value in ms */
+
+	ret = vl6180_write_word(data->client, VL6180_ALS_IT, it_ms - 1);
+
 fail:
 	vl6180_hold(data, false);
 	mutex_unlock(&data->lock);
@@ -411,10 +416,8 @@ static int vl6180_write_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_INT_TIME:
-		if (val != 0 || val2 < 500 || val2 >= 512500)
-			return -EINVAL;
+		return vl6180_set_it(data, val, val2);
 
-		return vl6180_set_it(data, val2);
 	case IIO_CHAN_INFO_HARDWAREGAIN:
 		if (chan->type != IIO_LIGHT)
 			return -EINVAL;
-- 
2.14.1
