Return-Path: <pmeerw@pmeerw.net>
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH] iio: Fix endianness issue in ak8975_read_axis()
Date: Thu,  5 Jun 2014 10:53:30 +0200
Message-Id: <1401958410-21183-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

i2c_smbus_read_word_data() does host endian conversion already,
no need for le16_to_cpu()

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/magnetometer/ak8975.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 09ea5c4..ea08313 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -373,8 +373,6 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
 {
 	struct ak8975_data *data = iio_priv(indio_dev);
 	struct i2c_client *client = data->client;
-	u16 meas_reg;
-	s16 raw;
 	int ret;
 
 	mutex_lock(&data->lock);
@@ -422,16 +420,11 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
 		dev_err(&client->dev, "Read axis data fails\n");
 		goto exit;
 	}
-	meas_reg = ret;
 
 	mutex_unlock(&data->lock);
 
-	/* Endian conversion of the measured values. */
-	raw = (s16) (le16_to_cpu(meas_reg));
-
 	/* Clamp to valid range. */
-	raw = clamp_t(s16, raw, -4096, 4095);
-	*val = raw;
+	*val = clamp_t(s16, ret, -4096, 4095);
 	return IIO_VAL_INT;
 
 exit:
-- 
1.9.1
