Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from h1.radempa.de ([176.9.142.194]:35790 "EHLO mail.cosmopool.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750884AbcAQQNr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 17 Jan 2016 11:13:47 -0500
From: Harald Geyer <harald@ccbib.org>
To: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Jonathan Bell <jonathan@raspberrypi.org>
Cc: Richard Weinberger <richard@nod.at>,
	Harald Geyer <harald@ccbib.org>
Subject: [PATCHv2 1/3] iio: dht11: Improve reliability - be more tolerant about missing start bits
Date: Sun, 17 Jan 2016 16:13:29 +0000
Message-Id: <1453047211-16661-1-git-send-email-harald@ccbib.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Instead of guessing where the data starts, we now just try to decode from
every possible start position. This causes no additional overhead if we
properly received the full preamble and only costs a few extra CPU cycles
in the case where the preamble is corrupted. This is much more efficient
than to return an error to userspace and start over again.

Signed-off-by: Harald Geyer <harald@ccbib.org>
---
No changes since V1, but compile tested the entire series patch by patch
additionally to test the whole series with DHT11 and DHT22 on an
imx233-olinuxino board.

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

