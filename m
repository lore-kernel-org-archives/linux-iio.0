Return-Path: <srinivas.pandruvada@linux.intel.com>
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 8/8] iio: meter: ade7758: Remove indio_dev->trig assignment
Date: Fri, 11 Jul 2014 10:12:19 -0700
Message-Id: <1405098739-25470-8-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1405098739-25470-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1405098739-25470-1-git-send-email-srinivas.pandruvada@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

This can result in wrong reference count for trigger device, leave the binding
to user space via current_trigger sysfs entry.
Refer to http://www.spinics.net/lists/linux-iio/msg13669.html for discussion
with Jonathan.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/staging/iio/meter/ade7758_trigger.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7758_trigger.c b/drivers/staging/iio/meter/ade7758_trigger.c
index ea01b8f..3a98627 100644
--- a/drivers/staging/iio/meter/ade7758_trigger.c
+++ b/drivers/staging/iio/meter/ade7758_trigger.c
@@ -84,8 +84,6 @@ int ade7758_probe_trigger(struct iio_dev *indio_dev)
 	iio_trigger_set_drvdata(st->trig, indio_dev);
 	ret = iio_trigger_register(st->trig);
 
-	/* select default trigger */
-	indio_dev->trig = st->trig;
 	if (ret)
 		goto error_free_irq;
 
-- 
1.9.1
