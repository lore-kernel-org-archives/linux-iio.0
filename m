Return-Path: <SRS0=rDdW=FF=ccbib.org=harald@kernel.org>
From: Harald Geyer <harald@ccbib.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Edward Attfield <edward@attfield.ca>,
	Harald Geyer <harald@ccbib.org>
Subject: [PATCH] iio: dht11: Improve detection of sensor type
Date: Sun, 11 Feb 2018 11:09:40 +0000
Message-Id: <1518347380-9624-1-git-send-email-harald@ccbib.org>
List-ID: <linux-iio@vger.kernel.org>

The old code was based on a DHT11 datasheet which specifies a measurement
range of 20%-90% RH. Turns out the sensor actually reports values outside
this range, so we should support it as far as possible.

Reported-by: Edward Attfield <edward@attfield.ca>
Signed-off-by: Harald Geyer <harald@ccbib.org>
---
 drivers/iio/humidity/dht11.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/humidity/dht11.c b/drivers/iio/humidity/dht11.c
index df6bab4..1a9f8f4 100644
--- a/drivers/iio/humidity/dht11.c
+++ b/drivers/iio/humidity/dht11.c
@@ -159,7 +159,7 @@ static int dht11_decode(struct dht11 *dht11, int offset)
 	}
 
 	dht11->timestamp = ktime_get_boot_ns();
-	if (hum_int < 20) {  /* DHT22 */
+	if (hum_int < 4) {  /* DHT22: 100000 = (3*256+232)*100 */
 		dht11->temperature = (((temp_int & 0x7f) << 8) + temp_dec) *
 					((temp_int & 0x80) ? -100 : 100);
 		dht11->humidity = ((hum_int << 8) + hum_dec) * 100;
-- 
2.1.4
