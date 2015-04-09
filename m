Return-Path: <sathyanarayanan.kuppuswamy@linux.intel.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: jic23@kernel.org,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org,
	srinivas.pandruvada@linux.intel.com,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH v3 1/6] iio: core : events ABI for specifying interrupt persistence
Date: Wed,  8 Apr 2015 17:06:05 -0700
Message-Id: <907f499ed208f06ed51b05403c82423dce64319e.1428537814.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <cover.1428537814.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1428537814.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <cover.1428537814.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1428537814.git.sathyanarayanan.kuppuswamy@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

This iio sysfs ABI defines a way to specify interrupt
persistence filter value for threshold based interrupts.

Example:

What: /sys/.../events/in_intensity0_thresh_persistence
What: /sys/.../events/in_proximity0_thresh_persistence

Currently, we don't have any way to specify the persistence
filter value in iio event framework. Many drivers use channel
ext info to work around this issue. This patch adds this option
to event info list.

Added IIO_EV_INFO_PERSISTENCE and corresponding string.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/iio/industrialio-event.c | 1 +
 include/linux/iio/types.h        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index a4b3970..7bd55b7 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -211,6 +211,7 @@ static const char * const iio_ev_info_text[] = {
 	[IIO_EV_INFO_VALUE] = "value",
 	[IIO_EV_INFO_HYSTERESIS] = "hysteresis",
 	[IIO_EV_INFO_PERIOD] = "period",
+	[IIO_EV_INFO_PERSISTENCE] = "persistence",
 };
 
 static enum iio_event_direction iio_ev_attr_dir(struct iio_dev_attr *attr)
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index 580ed5b..5240dc6 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -86,6 +86,7 @@ enum iio_event_info {
 	IIO_EV_INFO_VALUE,
 	IIO_EV_INFO_HYSTERESIS,
 	IIO_EV_INFO_PERIOD,
+	IIO_EV_INFO_PERSISTENCE,
 };
 
 enum iio_event_direction {
-- 
1.9.1
