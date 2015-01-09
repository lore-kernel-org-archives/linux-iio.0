Return-Path: <srinivas.pandruvada@linux.intel.com>
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] iio: imu: inv_mpu6050: Prevent dereferencing NULL
Date: Fri,  9 Jan 2015 15:13:37 -0800
Message-Id: <1420845217-16920-1-git-send-email-srinivas.pandruvada@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

When id is null, with ACPI enumeration, don't dereference it.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index f73e60b..d8d5bed 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -780,7 +780,11 @@ static int inv_mpu_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, indio_dev);
 	indio_dev->dev.parent = &client->dev;
-	indio_dev->name = id->name;
+	/* id will be NULL when enumerated via ACPI */
+	if (id)
+		indio_dev->name = (char *)id->name;
+	else
+		indio_dev->name = (char *)dev_name(&client->dev);
 	indio_dev->channels = inv_mpu_channels;
 	indio_dev->num_channels = ARRAY_SIZE(inv_mpu_channels);
 
-- 
1.9.3
