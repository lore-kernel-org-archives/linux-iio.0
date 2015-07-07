Return-Path: <harald@ccbib.org>
From: Harald Geyer <harald@ccbib.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Jonathan Bell <jonathan@raspberrypi.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Harald Geyer <harald@ccbib.org>
Subject: [PATCHv3 4/4] iio: dht11: Use new function ktime_get_resolution_ns()
Date: Tue,  7 Jul 2015 13:39:31 +0000
Message-Id: <1436276371-7480-4-git-send-email-harald@ccbib.org>
In-Reply-To: <1436276371-7480-1-git-send-email-harald@ccbib.org>
References: <55991FEA.50703@kernel.org>
 <1436276371-7480-1-git-send-email-harald@ccbib.org>
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
 drivers/iio/humidity/dht11.c |   42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/humidity/dht11.c b/drivers/iio/humidity/dht11.c
index 91976e0..1165b1c 100644
--- a/drivers/iio/humidity/dht11.c
+++ b/drivers/iio/humidity/dht11.c
@@ -33,6 +33,7 @@
 #include <linux/delay.h>
 #include <linux/gpio.h>
 #include <linux/of_gpio.h>
+#include <linux/timekeeping.h>
 
 #include <linux/iio/iio.h>
 
@@ -89,23 +90,11 @@ static unsigned char dht11_decode_byte(int *timing, int threshold)
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
-		t = dht11->edges[i].ts - dht11->edges[i - 1].ts;
-		if (t > 0 && t < timeres)
-			timeres = t;
-	}
-	if (2 * timeres > DHT11_DATA_BIT_HIGH) {
-		pr_err("dht11: timeresolution %d too bad for decoding\n",
-		       timeres);
-		return -EIO;
-	}
 	threshold = DHT11_DATA_BIT_HIGH / timeres;
 	if (DHT11_DATA_BIT_LOW / timeres + 1 >= threshold)
 		pr_err("dht11: WARNING: decoding ambiguous\n");
@@ -128,7 +117,7 @@ static int dht11_decode(struct dht11 *dht11, int offset)
 	if (((hum_int + hum_dec + temp_int + temp_dec) & 0xff) != checksum)
 		return -EIO;
 
-	dht11->timestamp = iio_get_time_ns();
+	dht11->timestamp = ktime_get_real_ns();
 	if (hum_int < 20) {  /* DHT22 */
 		dht11->temperature = (((temp_int & 0x7f) << 8) + temp_dec) *
 					((temp_int & 0x80) ? -100 : 100);
@@ -156,7 +145,7 @@ static irqreturn_t dht11_handle_irq(int irq, void *data)
 
 	/* TODO: Consider making the handler safe for IRQ sharing */
 	if (dht11->num_edges < DHT11_EDGES_PER_READ && dht11->num_edges >= 0) {
-		dht11->edges[dht11->num_edges].ts = iio_get_time_ns();
+		dht11->edges[dht11->num_edges].ts = ktime_get_real_ns();
 		dht11->edges[dht11->num_edges++].value =
 						gpio_get_value(dht11->gpio);
 
@@ -172,10 +161,22 @@ static int dht11_read_raw(struct iio_dev *iio_dev,
 			int *val, int *val2, long m)
 {
 	struct dht11 *dht11 = iio_priv(iio_dev);
-	int ret;
+	int ret, timeres;
 
 	mutex_lock(&dht11->lock);
-	if (dht11->timestamp + DHT11_DATA_VALID_TIME < iio_get_time_ns()) {
+	if (dht11->timestamp + DHT11_DATA_VALID_TIME < ktime_get_real_ns()) {
+		timeres = ktime_get_resolution_ns();
+		if (DHT11_DATA_BIT_HIGH < 2 * timeres) {
+			dev_err(dht11->dev, "timeresolution %dns too low\n",
+				timeres);
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
@@ -210,7 +211,8 @@ static int dht11_read_raw(struct iio_dev *iio_dev,
 		ret = dht11_decode(dht11,
 				   dht11->num_edges == DHT11_EDGES_PER_READ ?
 					DHT11_EDGES_PREAMBLE :
-					DHT11_EDGES_PREAMBLE - 2);
+					DHT11_EDGES_PREAMBLE - 2,
+				timeres);
 		if (ret)
 			goto err;
 	}
@@ -277,7 +279,7 @@ static int dht11_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	dht11->timestamp = iio_get_time_ns() - DHT11_DATA_VALID_TIME - 1;
+	dht11->timestamp = ktime_get_real_ns() - DHT11_DATA_VALID_TIME - 1;
 	dht11->num_edges = -1;
 
 	platform_set_drvdata(pdev, iio);
-- 
1.7.10.4
