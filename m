Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.fastquake.com ([45.33.83.177]:47576 "EHLO
        mail.fastquake.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750817AbdARWd3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Jan 2017 17:33:29 -0500
Date: Wed, 18 Jan 2017 21:50:39 +0000
From: John Brooks <john@fastquake.com>
To: linux-iio@vger.kernel.org, Harald Geyer <harald@ccbib.org>
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH] iio: dht11: Use usleep_range instead of msleep for start
 signal
Message-ID: <20170118215008.GA12173@oldkitsune.fastquake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The DHT22 (AM2302) datasheet specifies that the LOW start pulse should not
exceed 20ms. However, observations with an oscilloscope of an RPi Model 2B
(rev 1.1) communicating with a DHT22 sensor showed that the driver was
consistently sending start pulses longer than 20ms:

Kernel 4.7.10-v7+ (n=132):
    Minimum pulse length: 20.20ms
    Maximum:              29.84ms
    Mean:                 24.96ms
    StDev:                2.82ms
    Sensor response rate: 100%
    Read success rate:    76%

On kernel 4.8, the start pulse was so long that the sensor would not even
respond 97% of the time:

Kernel 4.8.16-v7+ (n=100):
    Minimum pulse length: 30.4ms
    Maximum:              74.4ms
    Mean:                 39.3ms
    StDev:                10.2ms
    Sensor response rate: 3%
    Read success rate:    3%

The driver would return ETIMEDOUT and write log messages like this:

[   51.430987] dht11 dht11@0: Only 1 signal edges detected
[   66.311019] dht11 dht11@0: Only 0 signal edges detected

Replacing msleep(18) with usleep_range(18000, 20000) made the pulse length
sane again and restored responsiveness:

Kernel 4.8.16-v7+ with usleep_range (n=123):
    Minimum pulse length: 18.16ms
    Maximum:              20.20ms
    Mean:                 19.85ms
    StDev:                0.51ms
    Sensor response rate: 100%
    Read success rate:    84%

Cc: stable@vger.kernel.org
Signed-off-by: John Brooks <john@fastquake.com>
---
 drivers/iio/humidity/dht11.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/humidity/dht11.c b/drivers/iio/humidity/dht11.c
index 9c47bc9..2a22ad9 100644
--- a/drivers/iio/humidity/dht11.c
+++ b/drivers/iio/humidity/dht11.c
@@ -71,7 +71,8 @@
  * a) select an implementation using busy loop polling on those systems
  * b) use the checksum to do some probabilistic decoding
  */
-#define DHT11_START_TRANSMISSION	18  /* ms */
+#define DHT11_START_TRANSMISSION_MIN	18000  /* us */
+#define DHT11_START_TRANSMISSION_MAX	20000  /* us */
 #define DHT11_MIN_TIMERES	34000  /* ns */
 #define DHT11_THRESHOLD		49000  /* ns */
 #define DHT11_AMBIG_LOW		23000  /* ns */
@@ -228,7 +229,8 @@ static int dht11_read_raw(struct iio_dev *iio_dev,
 		ret = gpio_direction_output(dht11->gpio, 0);
 		if (ret)
 			goto err;
-		msleep(DHT11_START_TRANSMISSION);
+		usleep_range(DHT11_START_TRANSMISSION_MIN,
+			     DHT11_START_TRANSMISSION_MAX);
 		ret = gpio_direction_input(dht11->gpio);
 		if (ret)
 			goto err;
-- 
2.7.4

