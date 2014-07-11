Return-Path: <srinivas.pandruvada@linux.intel.com>
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/8] iio: accel: bma180: Remove indio_dev->trig assignment
Date: Fri, 11 Jul 2014 10:12:12 -0700
Message-Id: <1405098739-25470-1-git-send-email-srinivas.pandruvada@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

This can result in wrong reference count for trigger device, leave the binding
to user space via current_trigger sysfs entry.
Refer to http://www.spinics.net/lists/linux-iio/msg13669.html for discussion
with Jonathan.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/accel/bma180.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index a7e68c8..1595065 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -569,7 +569,6 @@ static int bma180_probe(struct i2c_client *client,
 	trig->ops = &bma180_trigger_ops;
 	iio_trigger_set_drvdata(trig, indio_dev);
 	data->trig = trig;
-	indio_dev->trig = trig;
 
 	ret = iio_trigger_register(trig);
 	if (ret)
-- 
1.9.1
