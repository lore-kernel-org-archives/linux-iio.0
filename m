Return-Path: <daniel.baluta@intel.com>
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org,
	pmeerw@pmeerw.net,
	srinivas.pandruvada@linux.intel.com,
	knaack.h@gmx.de
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	daniel.baluta@intel.com
Subject: [PATCH v4 4/6] iio: imu: kmx61: Add PM sleep support
Date: Wed,  3 Dec 2014 15:31:51 +0200
Message-Id: <1417613513-28285-5-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1417613513-28285-1-git-send-email-daniel.baluta@intel.com>
References: <1417613513-28285-1-git-send-email-daniel.baluta@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Per sensor state (ACTIVE/STANDBY) is saved in driver's
private data (acc_stby/mag_stby) and restored when
resume is called.

Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
---
 drivers/iio/imu/kmx61.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
index 7536043..f69ae5a7 100644
--- a/drivers/iio/imu/kmx61.c
+++ b/drivers/iio/imu/kmx61.c
@@ -16,6 +16,7 @@
 #include <linux/acpi.h>
 #include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
+#include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -796,6 +797,33 @@ static int kmx61_remove(struct i2c_client *client)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int kmx61_suspend(struct device *dev)
+{
+	int ret;
+	struct kmx61_data *data = i2c_get_clientdata(to_i2c_client(dev));
+
+	mutex_lock(&data->lock);
+	ret = kmx61_set_mode(data, KMX61_ALL_STBY, KMX61_ACC | KMX61_MAG,
+			     false);
+	mutex_unlock(&data->lock);
+
+	return ret;
+}
+
+static int kmx61_resume(struct device *dev)
+{
+	u8 stby = 0;
+	struct kmx61_data *data = i2c_get_clientdata(to_i2c_client(dev));
+
+	if (data->acc_stby)
+		stby |= KMX61_ACC_STBY_BIT;
+	if (data->mag_stby)
+		stby |= KMX61_MAG_STBY_BIT;
+
+	return kmx61_set_mode(data, stby, KMX61_ACC | KMX61_MAG, true);
+}
+#endif
 
 #ifdef CONFIG_PM_RUNTIME
 static int kmx61_runtime_suspend(struct device *dev)
@@ -825,6 +853,7 @@ static int kmx61_runtime_resume(struct device *dev)
 #endif
 
 static const struct dev_pm_ops kmx61_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(kmx61_suspend, kmx61_resume)
 	SET_RUNTIME_PM_OPS(kmx61_runtime_suspend, kmx61_runtime_resume, NULL)
 };
 
-- 
1.9.1
