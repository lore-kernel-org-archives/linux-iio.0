Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: greg@kroah.com
CC: drivers@analog.com, linux-iio@vger.kernel.org, jic23@cam.ac.uk,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH] staging: iio: adc: ad799x: Address iio list feedback
Date: Wed, 6 Oct 2010 10:25:49 +0200
Message-ID: <1286353549-12852-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

Address feedback from Shubhrajyoti Datta:
	Cast return value
Michael Hennerich:
	Use i2c_smbus_read_byte_data()
	Fix return value check

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/adc/ad799x_core.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index dca3f2a..2589856 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -65,13 +65,13 @@ static int ad799x_i2c_read8(struct ad799x_state *st, u8 reg, u8 *data)
 	struct i2c_client *client = st->client;
 	int ret = 0;
 
-	ret = i2c_smbus_read_word_data(client, reg);
+	ret = i2c_smbus_read_byte_data(client, reg);
 	if (ret < 0) {
 		dev_err(&client->dev, "I2C read error\n");
 		return ret;
 	}
 
-	*data = ret;
+	*data = (u8)ret;
 
 	return 0;
 }
@@ -182,11 +182,10 @@ static ssize_t ad799x_read_single_channel(struct device *dev,
 	mask = 1 << this_attr->address;
 	/* If ring buffer capture is occuring, query the buffer */
 	if (iio_ring_enabled(dev_info)) {
-		data = ad799x_single_channel_from_ring(st, mask);
-		if (data < 0) {
-			ret = data;
+		data = ret = ad799x_single_channel_from_ring(st, mask);
+		if (ret < 0)
 			goto error_ret;
-		}
+		ret = 0;
 	} else {
 		switch (st->id) {
 		case ad7991:
-- 
1.6.0.2
