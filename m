Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:63374 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751994AbaHVUsK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 22 Aug 2014 16:48:10 -0400
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1 3/8] iio: adc: ad_sigma_delta: Fix indio_dev->trig assignment
Date: Fri, 22 Aug 2014 13:48:31 -0700
Message-Id: <1408740516-31261-4-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1408740516-31261-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1408740516-31261-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This can result in wrong reference count for trigger device, call
iio_trigger_get to increment reference.
Refer to http://www.spinics.net/lists/linux-iio/msg13669.html for discussion
with Jonathan.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/adc/ad_sigma_delta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index c55b81f..d10bd0c 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -472,7 +472,7 @@ static int ad_sd_probe_trigger(struct iio_dev *indio_dev)
 		goto error_free_irq;
 
 	/* select default trigger */
-	indio_dev->trig = sigma_delta->trig;
+	indio_dev->trig = iio_trigger_get(sigma_delta->trig);
 
 	return 0;
 
-- 
1.9.3

