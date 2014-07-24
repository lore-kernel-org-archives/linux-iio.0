Return-Path: <festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
To: jic23@kernel.org
Cc: mfuzzey@parkeon.com,
	pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH] iio: mma8452: Simplify the PM related hooks
Date: Thu, 24 Jul 2014 17:16:09 -0300
Message-Id: <1406232969-26394-1-git-send-email-festevam@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

From: Fabio Estevam <fabio.estevam@freescale.com>

We do not need to define MMA8452_PM_OPS as SIMPLE_DEV_PM_OPS handles the 
CONFIG_PM_SLEEP=n case just fine.

While at it get rid of the PM related ifdef's by marking the suspend/resume
functions as '__maybe_unused'.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/iio/accel/mma8452.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 3c12d49..dc455d7 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -404,24 +404,19 @@ static int mma8452_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int mma8452_suspend(struct device *dev)
+static int __maybe_unused mma8452_suspend(struct device *dev)
 {
 	return mma8452_standby(iio_priv(i2c_get_clientdata(
 		to_i2c_client(dev))));
 }
 
-static int mma8452_resume(struct device *dev)
+static int __maybe_unused mma8452_resume(struct device *dev)
 {
 	return mma8452_active(iio_priv(i2c_get_clientdata(
 		to_i2c_client(dev))));
 }
 
 static SIMPLE_DEV_PM_OPS(mma8452_pm_ops, mma8452_suspend, mma8452_resume);
-#define MMA8452_PM_OPS (&mma8452_pm_ops)
-#else
-#define MMA8452_PM_OPS NULL
-#endif
 
 static const struct i2c_device_id mma8452_id[] = {
 	{ "mma8452", 0 },
@@ -438,7 +433,7 @@ static struct i2c_driver mma8452_driver = {
 	.driver = {
 		.name	= "mma8452",
 		.of_match_table = of_match_ptr(mma8452_dt_ids),
-		.pm	= MMA8452_PM_OPS,
+		.pm	= &mma8452_pm_ops,
 	},
 	.probe = mma8452_probe,
 	.remove = mma8452_remove,
-- 
1.8.3.2
