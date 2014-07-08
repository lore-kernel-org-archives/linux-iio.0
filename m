Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:51065 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751535AbaGHW0F (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 8 Jul 2014 18:26:05 -0400
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] iio: core : events ABI for specifying period
Date: Tue,  8 Jul 2014 15:29:51 -0700
Message-Id: <1404858591-10061-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The iio sysfs ABI defines a way to specify period for roc and thresholds.
What:		/sys/.../events/in_accel_x_thresh_rising_period
What:		/sys/.../events/in_accel_x_thresh_falling_period
what:		/sys/.../events/in_accel_x_roc_rising_period
What:		/sys/.../events/in_accel_x_roc_falling_period

But there is no way to add period with the current event info enum.

Added IIO_EV_INFO_PERIOD and corresponding string.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/industrialio-event.c | 1 +
 include/linux/iio/types.h        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index bfbf4d4..0c1e37e 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -209,6 +209,7 @@ static const char * const iio_ev_info_text[] = {
 	[IIO_EV_INFO_ENABLE] = "en",
 	[IIO_EV_INFO_VALUE] = "value",
 	[IIO_EV_INFO_HYSTERESIS] = "hysteresis",
+	[IIO_EV_INFO_PERIOD] = "period",
 };
 
 static enum iio_event_direction iio_ev_attr_dir(struct iio_dev_attr *attr)
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index d09c40d..4a2af8a 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -74,6 +74,7 @@ enum iio_event_info {
 	IIO_EV_INFO_ENABLE,
 	IIO_EV_INFO_VALUE,
 	IIO_EV_INFO_HYSTERESIS,
+	IIO_EV_INFO_PERIOD,
 };
 
 enum iio_event_direction {
-- 
1.9.1

