Return-Path: <srinivas.pandruvada@linux.intel.com>
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] iio:core: Handle error when mask type is not separate
Date: Tue,  8 Jul 2014 14:03:34 -0700
Message-Id: <1404853414-9263-1-git-send-email-srinivas.pandruvada@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

When event spec is shared by multiple channels, which has definition
for mask_shared_by_type, iio_device_register_eventset fails.

For example:
static const struct iio_event_spec iio_dummy_events[] = {
	{
		.type = IIO_EV_TYPE_THRESH,
		.dir = IIO_EV_DIR_RISING,
		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE),
	}, {
		.type = IIO_EV_TYPE_THRESH,
		.dir = IIO_EV_DIR_FALLING,
		.mask_separate = BIT(IIO_EV_INFO_ENABLE),a
		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE),
	}
};

If two channels use this event spec, this will result in error.

This change handles EBUSY error similar to iio_device_add_info_mask_type().

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/industrialio-event.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index 258a973..bfbf4d4 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -345,6 +345,9 @@ static int iio_device_add_event(struct iio_dev *indio_dev,
 			&indio_dev->event_interface->dev_attr_list);
 		kfree(postfix);
 
+		if ((ret == -EBUSY) && (shared_by != IIO_SEPARATE))
+			continue;
+
 		if (ret)
 			return ret;
 
-- 
1.9.1
