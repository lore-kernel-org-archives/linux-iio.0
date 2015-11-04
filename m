Return-Path: <adriana.reus@intel.com>
From: Adriana Reus <adriana.reus@intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	pmeerw@pmeerw.net,
	srinivas.pandruvada@linux.intel.com,
	daniel.baluta@intel.com,
	Adriana Reus <adriana.reus@intel.com>
Subject: [RFC PATCH] iio: accel: kxcj: Reconcile operation order between iio_register/unregister and pm functions
Date: Wed,  4 Nov 2015 18:42:04 +0200
Message-Id: <1446655324-32143-1-git-send-email-adriana.reus@intel.com>
List-ID: <linux-iio@vger.kernel.org>

At probe runtime pm should be setup before registering the sysfs interface.
Also when removing the device we should unregister first to make sure
that the interfaces that may result in wakeups etc are no longer available.

Signed-off-by: Adriana Reus <adriana.reus@intel.com>
---
 I remember having a conversation on the order of iio_unregister
 and pm disable functions (http://www.spinics.net/lists/linux-iio/msg19606.html)
 and why it is best that unregister is the first call in remove.
 Also I'm thinking that at probe it would be best to enable runtime pm before 
 exposing it in sysfs for the (theoretical) case when pm attributes might be checked before
 they update. I noticed that a lot of drivers do it the other way around and I'm not sure 
 if maybe there's a reason for this that I am missing.

 If this is reasonable I can send patches for the other drivers also 
 (bmc150, bmg160, kmx and some other ones)

 drivers/iio/accel/kxcjk-1013.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 18c1b06..edec1d0 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1264,25 +1264,23 @@ static int kxcjk1013_probe(struct i2c_client *client,
 		goto err_trigger_unregister;
 	}
 
-	ret = iio_device_register(indio_dev);
-	if (ret < 0) {
-		dev_err(&client->dev, "unable to register iio device\n");
-		goto err_buffer_cleanup;
-	}
-
 	ret = pm_runtime_set_active(&client->dev);
 	if (ret)
-		goto err_iio_unregister;
+		goto err_buffer_cleanup;
 
 	pm_runtime_enable(&client->dev);
 	pm_runtime_set_autosuspend_delay(&client->dev,
 					 KXCJK1013_SLEEP_DELAY_MS);
 	pm_runtime_use_autosuspend(&client->dev);
 
+	ret = iio_device_register(indio_dev);
+	if (ret < 0) {
+		dev_err(&client->dev, "unable to register iio device\n");
+		goto err_buffer_cleanup;
+	}
+
 	return 0;
 
-err_iio_unregister:
-	iio_device_unregister(indio_dev);
 err_buffer_cleanup:
 	if (data->dready_trig)
 		iio_triggered_buffer_cleanup(indio_dev);
@@ -1302,12 +1300,12 @@ static int kxcjk1013_remove(struct i2c_client *client)
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	struct kxcjk1013_data *data = iio_priv(indio_dev);
 
+	iio_device_unregister(indio_dev);
+
 	pm_runtime_disable(&client->dev);
 	pm_runtime_set_suspended(&client->dev);
 	pm_runtime_put_noidle(&client->dev);
 
-	iio_device_unregister(indio_dev);
-
 	if (data->dready_trig) {
 		iio_triggered_buffer_cleanup(indio_dev);
 		iio_trigger_unregister(data->dready_trig);
-- 
1.9.1
