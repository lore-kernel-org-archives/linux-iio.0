Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:60596 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752071Ab3G0PcE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 27 Jul 2013 11:32:04 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>,
	Shubhrajyoti Datta <shubhrajyoti@ti.com>
Subject: [PATCH 3/9] staging:iio:hmc5843: Implement timeout in read function
Date: Sat, 27 Jul 2013 17:31:46 +0200
Message-Id: <1374939112-18237-4-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1374939112-18237-1-git-send-email-pmeerw@pmeerw.net>
References: <1374939112-18237-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

avoid polling data ready bit forever; msleep() may be too long
for high sampling frequencies but the driver interface does not
support buffering

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Shubhrajyoti Datta <shubhrajyoti@ti.com>
---
 drivers/staging/iio/magnetometer/hmc5843.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index c281342..79117ad 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -26,6 +26,7 @@
 #include <linux/types.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/delay.h>
 
 #define HMC5843_CONFIG_REG_A			0x00
 #define HMC5843_CONFIG_REG_B			0x01
@@ -210,11 +211,22 @@ static int hmc5843_read_measurement(struct iio_dev *indio_dev,
 	struct i2c_client *client = to_i2c_client(indio_dev->dev.parent);
 	struct hmc5843_data *data = iio_priv(indio_dev);
 	s32 result;
+	int tries = 150;
 
 	mutex_lock(&data->lock);
-	result = i2c_smbus_read_byte_data(client, HMC5843_STATUS_REG);
-	while (!(result & HMC5843_DATA_READY))
-		result = i2c_smbus_read_byte_data(client, HMC5843_STATUS_REG);
+	while (tries-- > 0) {
+		result = i2c_smbus_read_byte_data(client,
+			HMC5843_STATUS_REG);
+		if (result & HMC5843_DATA_READY)
+			break;
+		msleep(20);
+	}
+
+	if (tries < 0) {
+		dev_err(&client->dev, "data not ready\n");
+		mutex_unlock(&data->lock);
+		return -EIO;
+	}
 
 	result = i2c_smbus_read_word_data(client, address);
 	mutex_unlock(&data->lock);
-- 
1.8.3.4

