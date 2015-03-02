Return-Path: <harald@ccbib.org>
From: Harald Geyer <harald@ccbib.org>
To: Jonathan Cameron <jic23@kernel.org>,
	John Stultz <john.stultz@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-iio@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Harald Geyer <harald@ccbib.org>
Subject: [PATCH 3/3] iio: dht11: Use new function iio_get_time_resolution_ns()
Date: Mon,  2 Mar 2015 20:56:06 +0000
Message-Id: <1425329766-14703-4-git-send-email-harald@ccbib.org>
In-Reply-To: <1425329766-14703-1-git-send-email-harald@ccbib.org>
References: <1425329766-14703-1-git-send-email-harald@ccbib.org>
List-ID: <linux-iio@vger.kernel.org>

This cleans up the most ugly workaround in this driver. There are no
functional changes yet in the decoding algorithm, but we improve the
following things:
 * Get rid of spurious warning messages on systems with fast HRTIMER.
 * If the clock is not fast enough for decoding to work, we give
   up immediately.
 * In that case we return EAGAIN instead of EIO, so it's easier to
   discriminate causes of failure.

Returning EAGAIN is somewhat controversial: It's technically correct
as a faster clock might become available. OTOH once all clocks are
enabled this is a permanent error. There is no ECLOCKTOOSLOW error
code.

Signed-off-by: Harald Geyer <harald@ccbib.org>
---
 drivers/iio/humidity/dht11.c |   33 +++++++++++++++++----------------
 1 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/humidity/dht11.c b/drivers/iio/humidity/dht11.c
index 7d79a1a..29cffa1 100644
--- a/drivers/iio/humidity/dht11.c
+++ b/drivers/iio/humidity/dht11.c
@@ -87,23 +87,11 @@ static unsigned char dht11_decode_byte(int *timing, int threshold)
 	return ret;
 }
 
-static int dht11_decode(struct dht11 *dht11, int offset)
+static int dht11_decode(struct dht11 *dht11, int offset, int timeres)
 {
-	int i, t, timing[DHT11_BITS_PER_READ], threshold,
-		timeres = DHT11_SENSOR_RESPONSE;
+	int i, t, timing[DHT11_BITS_PER_READ], threshold;
 	unsigned char temp_int, temp_dec, hum_int, hum_dec, checksum;
 
-	/* Calculate timestamp resolution */
-	for (i = 1; i < dht11->num_edges; ++i) {
-		t = dht11->edges[i].ts - dht11->edges[i-1].ts;
-		if (t > 0 && t < timeres)
-			timeres = t;
-	}
-	if (2*timeres > DHT11_DATA_BIT_HIGH) {
-		pr_err("dht11: timeresolution %d too bad for decoding\n",
-			timeres);
-		return -EIO;
-	}
 	threshold = DHT11_DATA_BIT_HIGH / timeres;
 	if (DHT11_DATA_BIT_LOW/timeres + 1 >= threshold)
 		pr_err("dht11: WARNING: decoding ambiguous\n");
@@ -170,10 +158,22 @@ static int dht11_read_raw(struct iio_dev *iio_dev,
 			int *val, int *val2, long m)
 {
 	struct dht11 *dht11 = iio_priv(iio_dev);
-	int ret;
+	int ret, timeres;
 
 	mutex_lock(&dht11->lock);
 	if (dht11->timestamp + DHT11_DATA_VALID_TIME < iio_get_time_ns()) {
+		timeres = iio_get_time_resolution_ns();
+		if (DHT11_DATA_BIT_HIGH < 2*timeres) {
+			dev_err(dht11->dev, "timeresolution %dns too low\n",
+						timeres);
+			/* In theory a better clock could become available
+			 * at some point ... and there is no error code
+			 * that really fits better.
+			 */
+			ret = -EAGAIN;
+			goto err;
+		}
+
 		reinit_completion(&dht11->completion);
 
 		dht11->num_edges = 0;
@@ -208,7 +208,8 @@ static int dht11_read_raw(struct iio_dev *iio_dev,
 		ret = dht11_decode(dht11,
 				dht11->num_edges == DHT11_EDGES_PER_READ ?
 					DHT11_EDGES_PREAMBLE :
-					DHT11_EDGES_PREAMBLE - 2);
+					DHT11_EDGES_PREAMBLE - 2,
+				timeres);
 		if (ret)
 			goto err;
 	}
-- 
1.7.2.5
