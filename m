Return-Path: <srinivas.pandruvada@linux.intel.com>
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1 8/8] iio: meter: ade7758: Fix indio_dev->trig assignment
Date: Fri, 22 Aug 2014 13:48:36 -0700
Message-Id: <1408740516-31261-9-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1408740516-31261-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1408740516-31261-1-git-send-email-srinivas.pandruvada@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

This can result in wrong reference count for trigger device, call
iio_trigger_get to increment reference.
Refer to http://www.spinics.net/lists/linux-iio/msg13669.html for discussion
with Jonathan.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/staging/iio/meter/ade7758_trigger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/meter/ade7758_trigger.c b/drivers/staging/iio/meter/ade7758_trigger.c
index ea01b8f..6f45ce0 100644
--- a/drivers/staging/iio/meter/ade7758_trigger.c
+++ b/drivers/staging/iio/meter/ade7758_trigger.c
@@ -85,7 +85,7 @@ int ade7758_probe_trigger(struct iio_dev *indio_dev)
 	ret = iio_trigger_register(st->trig);
 
 	/* select default trigger */
-	indio_dev->trig = st->trig;
+	indio_dev->trig = iio_trigger_get(st->trig);
 	if (ret)
 		goto error_free_irq;
 
-- 
1.9.3
