Return-Path: <SRS0=Um4Y=GO=onstation.org=masneyb@kernel.org>
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	devel@driverdev.osuosl.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-kernel@vger.kernel.org,
	Jon.Brenner@ams.com
Subject: [PATCH 3/4] staging: iio: tsl2x7x: use either direction for IIO_EV_INFO_{ENABLE,PERIOD}
Date: Sat, 24 Mar 2018 16:05:54 -0400
Message-Id: <20180324200555.1403-4-masneyb@onstation.org>
In-Reply-To: <20180324200555.1403-1-masneyb@onstation.org>
References: <20180324200555.1403-1-masneyb@onstation.org>
List-ID: <linux-iio@vger.kernel.org>

The events IIO_EV_INFO_VALUE and IIO_EV_INFO_ENABLE currently have a
falling and rising direction configured. There does not need to be a
separate distinction so this patch changes these to use the
either direction. Directory listing of event sysfs attributes for a
TSL2772 with this patch applied:

in_intensity0_thresh_either_en
in_intensity0_thresh_either_period
in_intensity0_thresh_falling_value
in_intensity0_thresh_rising_value
in_proximity0_thresh_either_en
in_proximity0_thresh_either_period
in_proximity0_thresh_falling_value
in_proximity0_thresh_rising_value

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index d5a237fb0a0b..940bea2378a9 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -1469,17 +1469,16 @@ static const struct iio_event_spec tsl2x7x_events[] = {
 	{
 		.type = IIO_EV_TYPE_THRESH,
 		.dir = IIO_EV_DIR_RISING,
-		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
-			BIT(IIO_EV_INFO_ENABLE),
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
 	}, {
 		.type = IIO_EV_TYPE_THRESH,
 		.dir = IIO_EV_DIR_FALLING,
-		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
-			BIT(IIO_EV_INFO_ENABLE),
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
 	}, {
 		.type = IIO_EV_TYPE_THRESH,
 		.dir = IIO_EV_DIR_EITHER,
-		.mask_separate = BIT(IIO_EV_INFO_PERIOD),
+		.mask_separate = BIT(IIO_EV_INFO_PERIOD) |
+			BIT(IIO_EV_INFO_ENABLE),
 	},
 };
 
-- 
2.14.3
