Return-Path: <srinivas.pandruvada@linux.intel.com>
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 3/8] iio: adc: ad_sigma_delta: Remove indio_dev->trig assignment
Date: Fri, 11 Jul 2014 10:12:14 -0700
Message-Id: <1405098739-25470-3-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1405098739-25470-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1405098739-25470-1-git-send-email-srinivas.pandruvada@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

This can result in wrong reference count for trigger device, leave the binding
to user space via current_trigger sysfs entry.
Refer to http://www.spinics.net/lists/linux-iio/msg13669.html for discussion
with Jonathan.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/adc/ad_sigma_delta.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index c55b81f..966159e 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -471,9 +471,6 @@ static int ad_sd_probe_trigger(struct iio_dev *indio_dev)
 	if (ret)
 		goto error_free_irq;
 
-	/* select default trigger */
-	indio_dev->trig = sigma_delta->trig;
-
 	return 0;
 
 error_free_irq:
-- 
1.9.1
