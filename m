Return-Path: <srinivas.pandruvada@linux.intel.com>
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 6/8] iio: gyro: itg3200: Remove indio_dev->trig assignment
Date: Fri, 11 Jul 2014 10:12:17 -0700
Message-Id: <1405098739-25470-6-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1405098739-25470-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1405098739-25470-1-git-send-email-srinivas.pandruvada@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

This can result in wrong reference count for trigger device, leave the binding
to user space via current_trigger sysfs entry.
Refer to http://www.spinics.net/lists/linux-iio/msg13669.html for discussion
with Jonathan.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/gyro/itg3200_buffer.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iio/gyro/itg3200_buffer.c b/drivers/iio/gyro/itg3200_buffer.c
index e3b3c50..2ba20f6 100644
--- a/drivers/iio/gyro/itg3200_buffer.c
+++ b/drivers/iio/gyro/itg3200_buffer.c
@@ -131,9 +131,6 @@ int itg3200_probe_trigger(struct iio_dev *indio_dev)
 	if (ret)
 		goto error_free_irq;
 
-	/* select default trigger */
-	indio_dev->trig = st->trig;
-
 	return 0;
 
 error_free_irq:
-- 
1.9.1
