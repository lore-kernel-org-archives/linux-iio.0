Return-Path: <irina.tirdea@intel.com>
From: Irina Tirdea <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>
Cc: linux-kernel@vger.kernel.org,
	Vlad Dogaru <vlad.dogaru@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH v2 04/17] iio: accel: mma9553: add enable channel for activity
Date: Mon, 13 Apr 2015 18:40:51 +0300
Message-Id: <1428939664-12503-5-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1428939664-12503-1-git-send-email-irina.tirdea@intel.com>
References: <1428939664-12503-1-git-send-email-irina.tirdea@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Since we need to specifically power on the device if used
in polling mode, we have an enable channel for each type
(step count, distance, speed, calories, etc.).

Add also an enable channel for activity, so it can also
be polled independently of events or other channels.

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
Reported-by: Daniel Baluta <daniel.baluta@intel.com>
---
 drivers/iio/accel/mma9553.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
index 03120fb..365a109 100644
--- a/drivers/iio/accel/mma9553.c
+++ b/drivers/iio/accel/mma9553.c
@@ -972,7 +972,8 @@ static const struct iio_chan_spec_ext_info mma9553_ext_info[] = {
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
