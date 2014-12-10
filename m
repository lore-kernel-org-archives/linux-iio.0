Return-Path: <irina.tirdea@intel.com>
From: Irina Tirdea <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH v2 4/4] iio: accel: kxcjk-1013: power off device if probe fails
Date: Wed, 10 Dec 2014 18:23:54 +0200
Message-Id: <1418228634-10505-5-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1418228634-10505-1-git-send-email-irina.tirdea@intel.com>
References: <1418228634-10505-1-git-send-email-irina.tirdea@intel.com>
List-ID: <linux-iio@vger.kernel.org>

When the device is initialized in probe, it is also powered on.
If there is an error after the initialization, the device will
remain powered on.

Power off the device in case probe fails after device initialization.

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
Suggested-by: Daniel Baluta <daniel.baluta@intel.com>
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/accel/kxcjk-1013.c |   18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 0dc6ccf..a5e7d30 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1240,21 +1240,25 @@ static int kxcjk1013_probe(struct i2c_client *client,
 						KXCJK1013_IRQ_NAME,
 						indio_dev);
 		if (ret)
-			return ret;
+			goto err_poweroff;
 
 		data->dready_trig = devm_iio_trigger_alloc(&client->dev,
 							   "%s-dev%d",
 							   indio_dev->name,
 							   indio_dev->id);
-		if (!data->dready_trig)
-			return -ENOMEM;
+		if (!data->dready_trig) {
+			ret = -ENOMEM;
+			goto err_poweroff;
+		}
 
 		data->motion_trig = devm_iio_trigger_alloc(&client->dev,
 							  "%s-any-motion-dev%d",
 							  indio_dev->name,
 							  indio_dev->id);
-		if (!data->motion_trig)
-			return -ENOMEM;
+		if (!data->motion_trig) {
+			ret = -ENOMEM;
+			goto err_poweroff;
+		}
 
 		data->dready_trig->dev.parent = &client->dev;
 		data->dready_trig->ops = &kxcjk1013_trigger_ops;
@@ -1263,7 +1267,7 @@ static int kxcjk1013_probe(struct i2c_client *client,
 		iio_trigger_get(indio_dev->trig);
 		ret = iio_trigger_register(data->dready_trig);
 		if (ret)
-			return ret;
+			goto err_poweroff;
 
 		data->motion_trig->dev.parent = &client->dev;
 		data->motion_trig->ops = &kxcjk1013_trigger_ops;
@@ -1312,6 +1316,8 @@ err_trigger_unregister:
 		iio_trigger_unregister(data->dready_trig);
 	if (data->motion_trig)
 		iio_trigger_unregister(data->motion_trig);
+err_poweroff:
+	kxcjk1013_set_mode(data, STANDBY);
 
 	return ret;
 }
-- 
1.7.9.5
