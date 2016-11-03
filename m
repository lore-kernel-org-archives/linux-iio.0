Return-Path: <masneyb@onstation.org>
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: devel@driverdev.osuosl.org,
	gregkh@linuxfoundation.org,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	knaack.h@gmx.de,
	linux-kernel@vger.kernel.org,
	Jon.Brenner@ams.com
Subject: [PATCH 5/9] staging: iio: tsl2583: don't shutdown chip when updating the lux table
Date: Thu,  3 Nov 2016 08:56:16 -0400
Message-Id: <1478177780-28699-6-git-send-email-masneyb@onstation.org>
In-Reply-To: <1478177780-28699-1-git-send-email-masneyb@onstation.org>
References: <1478177780-28699-1-git-send-email-masneyb@onstation.org>
List-ID: <linux-iio@vger.kernel.org>

in_illuminance_lux_table_store() shuts down the chip, updates the
contents of the lux table, and then turns the chip back on. The values
in lux table are not used by the chip and are only used internally by
the driver. It is not necessary to change the power state on the chip.
This patch removes the calls to taos_chip_off() and taos_chip_on()
in in_illuminance_lux_table_store().

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2583.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index 7fb09c6..af1cf9b 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -564,20 +564,10 @@ static ssize_t in_illuminance_lux_table_store(struct device *dev,
 		goto done;
 	}
 
-	if (chip->taos_chip_status == TSL258X_CHIP_WORKING) {
-		ret = taos_chip_off(indio_dev);
-		if (ret < 0)
-			goto done;
-	}
-
 	/* Zero out the table */
 	memset(taos_device_lux, 0, sizeof(taos_device_lux));
 	memcpy(taos_device_lux, &value[1], (value[0] * 4));
 
-	ret = taos_chip_on(indio_dev);
-	if (ret < 0)
-		goto done;
-
 	ret = len;
 
 done:
-- 
2.5.5
