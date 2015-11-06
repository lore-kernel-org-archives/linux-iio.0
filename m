Return-Path: <adriana.reus@intel.com>
From: Adriana Reus <adriana.reus@intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Adriana Reus <adriana.reus@intel.com>
Subject: [PATCH] iio: light: pa12203001: Poweroff chip  if register fails
Date: Fri,  6 Nov 2015 11:10:37 +0200
Message-Id: <1446801037-11453-1-git-send-email-adriana.reus@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Make sure we poweroff the chip if for any reason iio_register
returns an error.

Signed-off-by: Adriana Reus <adriana.reus@intel.com>
---
 drivers/iio/light/pa12203001.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/pa12203001.c b/drivers/iio/light/pa12203001.c
index 45f7bde..76a9e12 100644
--- a/drivers/iio/light/pa12203001.c
+++ b/drivers/iio/light/pa12203001.c
@@ -381,17 +381,23 @@ static int pa12203001_probe(struct i2c_client *client,
 		return ret;
 
 	ret = pm_runtime_set_active(&client->dev);
-	if (ret < 0) {
-		pa12203001_power_chip(indio_dev, PA12203001_CHIP_DISABLE);
-		return ret;
-	}
+	if (ret < 0)
+		goto out_err;
 
 	pm_runtime_enable(&client->dev);
 	pm_runtime_set_autosuspend_delay(&client->dev,
 					 PA12203001_SLEEP_DELAY_MS);
 	pm_runtime_use_autosuspend(&client->dev);
 
-	return iio_device_register(indio_dev);
+	ret = iio_device_register(indio_dev);
+	if (ret < 0)
+		goto out_err;
+
+	return 0;
+
+out_err:
+	pa12203001_power_chip(indio_dev, PA12203001_CHIP_DISABLE);
+	return ret;
 }
 
 static int pa12203001_remove(struct i2c_client *client)
-- 
1.9.1
