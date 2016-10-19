Return-Path: <masneyb@onstation.org>
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org
Cc: knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] iio: light: tsl2583: check return values from taos_chip_{on,off}
Date: Wed, 19 Oct 2016 06:32:08 -0400
Message-Id: <1476873130-24926-5-git-send-email-masneyb@onstation.org>
In-Reply-To: <1476873130-24926-1-git-send-email-masneyb@onstation.org>
References: <1476873130-24926-1-git-send-email-masneyb@onstation.org>
List-ID: <linux-iio@vger.kernel.org>

The return values from taos_chip_on() and taos_chip_off() was not
checked in several places. This patch adds proper error checking to
these function calls.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2583.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index a60433e..60f0ce9 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -515,15 +515,18 @@ static ssize_t power_state_store(struct device *dev,
 				 const char *buf, size_t len)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	int value;
+	int value, ret;
 
 	if (kstrtoint(buf, 0, &value))
 		return -EINVAL;
 
 	if (!value)
-		taos_chip_off(indio_dev);
+		ret = taos_chip_off(indio_dev);
 	else
-		taos_chip_on(indio_dev);
+		ret = taos_chip_on(indio_dev);
+
+	if (ret < 0)
+		return ret;
 
 	return len;
 }
@@ -775,14 +778,20 @@ static ssize_t illuminance0_lux_table_store(struct device *dev,
 		goto luxable_store_done;
 	}
 
-	if (chip->taos_chip_status == TSL258X_CHIP_WORKING)
-		taos_chip_off(indio_dev);
+	if (chip->taos_chip_status == TSL258X_CHIP_WORKING) {
+		ret = taos_chip_off(indio_dev);
+		if (ret < 0)
+			return ret;
+	}
 
 	/* Zero out the table */
 	memset(taos_device_lux, 0, sizeof(taos_device_lux));
 	memcpy(taos_device_lux, &value[1], (value[0] * 4));
 
-	taos_chip_on(indio_dev);
+	ret = taos_chip_on(indio_dev);
+	if (ret < 0)
+		return ret;
+
 	ret = len;
 
 luxable_store_done:
@@ -914,7 +923,9 @@ static int taos_probe(struct i2c_client *clientp,
 	taos_defaults(chip);
 
 	/* Make sure the chip is on */
-	taos_chip_on(indio_dev);
+	ret = taos_chip_on(indio_dev);
+	if (ret < 0)
+		return ret;
 
 	dev_info(&clientp->dev, "Light sensor found.\n");
 
-- 
2.7.4
