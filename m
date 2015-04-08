Return-Path: <irina.tirdea@intel.com>
From: Irina Tirdea <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>
Cc: linux-kernel@vger.kernel.org,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH 8/8] iio: accel: mma9553: add enable channel for activity
Date: Wed,  8 Apr 2015 17:37:37 +0300
Message-Id: <1428503857-9081-9-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1428503857-9081-1-git-send-email-irina.tirdea@intel.com>
References: <1428503857-9081-1-git-send-email-irina.tirdea@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Since we need to specifically power on the device if used
in polling mode, we have an enable channel for each type
(step count, distance, speed, calories, etc.).

Add also an enable channel for activity, so it can also
be polled independenly of events or other channels.

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
Suggested-by: Daniel Baluta <daniel.baluta@intel.com>
---
 drivers/iio/accel/mma9553.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
index 6991b01..1359985 100644
--- a/drivers/iio/accel/mma9553.c
+++ b/drivers/iio/accel/mma9553.c
@@ -942,7 +942,8 @@ static const struct iio_chan_spec_ext_info mma9553_ext_info[] = {
 	.modified = 1,							\
 	.channel2 = _chan2,						\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),		\
-	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_CALIBHEIGHT),	\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_CALIBHEIGHT) |	\
+				    BIT(IIO_CHAN_INFO_ENABLE),		\
 	.event_spec = mma9553_activity_events,				\
 	.num_event_specs = ARRAY_SIZE(mma9553_activity_events),		\
 	.ext_info = mma9553_ext_info,					\
-- 
1.9.1
