Return-Path: <srinivas.pandruvada@linux.intel.com>
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] iio: magnetometer: ak8975: Add AK8963
Date: Fri,  9 Jan 2015 15:30:38 -0800
Message-Id: <1420846238-31802-1-git-send-email-srinivas.pandruvada@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

Added AK8963 in the id table. Unfortunately some commercial devices
using caps version ak8963.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/magnetometer/ak8975.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 0d10a4b..b13936d 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -813,6 +813,7 @@ static int ak8975_probe(struct i2c_client *client,
 static const struct i2c_device_id ak8975_id[] = {
 	{"ak8975", AK8975},
 	{"ak8963", AK8963},
+	{"AK8963", AK8963},
 	{"ak09911", AK09911},
 	{"ak09912", AK09912},
 	{}
-- 
1.9.3
