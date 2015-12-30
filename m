Return-Path: <harald@ccbib.org>
From: Harald Geyer <harald@ccbib.org>
To: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Bell <jonathan@raspberrypi.org>
Cc: Richard Weinberger <richard@nod.at>,
	Harald Geyer <harald@ccbib.org>
Subject: [PATCH 1/3] iio: dht11: Improve reliability - be more tolerant about missing start bits
Date: Wed, 30 Dec 2015 14:26:43 +0000
Message-Id: <1451485605-3441-1-git-send-email-harald@ccbib.org>
List-ID: <linux-iio@vger.kernel.org>

Instead of guessing where the data starts, we now just try to decode from
every possible start position. This causes no additional overhead if we
properly received the full preamble and only costs a few extra CPU cycles
in the case where the preamble is corrupted. This is much more efficient
than to return an error to userspace and start over again.

Signed-off-by: Harald Geyer <harald@ccbib.org>
---
Jonathan Bell:
Can you test if this fixes the problems you reported on RPi?

(It does fix problems I noticed when I slowed down my test HW with
enabling the debug logging introduced later in this series, so including
this patch is a good thing even if it doesn't fix Jonathan's problems.)

 drivers/iio/humidity/dht11.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/humidity/dht11.c b/drivers/iio/humidity/dht11.c
index 1165b1c..1ca284a 100644
--- a/drivers/iio/humidity/dht11.c
+++ b/drivers/iio/humidity/dht11.c
@@ -161,7 +161,7 @@ static int dht11_read_raw(struct iio_dev *iio_dev,
 			int *val, int *val2, long m)
 {
 	struct dht11 *dht11 = iio_priv(iio_dev);
-	int ret, timeres;
+	int ret, timeres, offset;
 
 	mutex_lock(&dht11->lock);
 	if (dht11->timestamp + DHT11_DATA_VALID_TIME < ktime_get_real_ns()) {
@@ -208,11 +208,14 @@ static int dht11_read_raw(struct iio_dev *iio_dev,
 		if (ret < 0)
 			goto err;
 
-		ret = dht11_decode(dht11,
-				   dht11->num_edges == DHT11_EDGES_PER_READ ?
-					DHT11_EDGES_PREAMBLE :
-					DHT11_EDGES_PREAMBLE - 2,
-				timeres);
+		offset = DHT11_EDGES_PREAMBLE +
+				dht11->num_edges - DHT11_EDGES_PER_READ;
+		for (; offset >= 0; --offset) {
+			ret = dht11_decode(dht11, offset, timeres);
+			if (!ret)
+				break;
+		}
+
 		if (ret)
 			goto err;
 	}
-- 
2.1.4
