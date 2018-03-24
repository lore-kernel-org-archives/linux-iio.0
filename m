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
Subject: [PATCH 2/4] staging: iio: tsl2x7x: move IIO_CHAN_INFO_CALIB{SCALE,BIAS} to IIO_LIGHT channel
Date: Sat, 24 Mar 2018 16:05:53 -0400
Message-Id: <20180324200555.1403-3-masneyb@onstation.org>
In-Reply-To: <20180324200555.1403-1-masneyb@onstation.org>
References: <20180324200555.1403-1-masneyb@onstation.org>
List-ID: <linux-iio@vger.kernel.org>

The IIO_CHAN_INFO_CALIBSCALE and IIO_CHAN_INFO_CALIBBIAS masks are
currently associated with the IIO_INTENSITY channel but should be
associated with the IIO_LIGHT channel since these values are used to
calculate the lux. Directory listing of the sysfs attributes for a
TSL2772 with this patch applied:

dev
events
in_illuminance0_calibbias
in_illuminance0_calibrate
in_illuminance0_calibscale
in_illuminance0_calibscale_available
in_illuminance0_input
in_illuminance0_integration_time
in_illuminance0_integration_time_available
in_illuminance0_lux_table
in_illuminance0_target_input
in_intensity0_raw
in_intensity1_raw
in_proximity0_calibrate
in_proximity0_calibscale
in_proximity0_calibscale_available
in_proximity0_raw
name
of_node
power
subsystem
uevent

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 8530bccdb317..d5a237fb0a0b 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -1491,14 +1491,14 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
 			.indexed = 1,
 			.channel = 0,
 			.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
-					      BIT(IIO_CHAN_INFO_INT_TIME),
+				BIT(IIO_CHAN_INFO_INT_TIME) |
+				BIT(IIO_CHAN_INFO_CALIBSCALE) |
+				BIT(IIO_CHAN_INFO_CALIBBIAS),
 			}, {
 			.type = IIO_INTENSITY,
 			.indexed = 1,
 			.channel = 0,
-			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-				BIT(IIO_CHAN_INFO_CALIBSCALE) |
-				BIT(IIO_CHAN_INFO_CALIBBIAS),
+			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 			.event_spec = tsl2x7x_events,
 			.num_event_specs = ARRAY_SIZE(tsl2x7x_events),
 			}, {
@@ -1531,14 +1531,14 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
 			.indexed = 1,
 			.channel = 0,
 			.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
-					      BIT(IIO_CHAN_INFO_INT_TIME),
+				BIT(IIO_CHAN_INFO_INT_TIME) |
+				BIT(IIO_CHAN_INFO_CALIBSCALE) |
+				BIT(IIO_CHAN_INFO_CALIBBIAS),
 			}, {
 			.type = IIO_INTENSITY,
 			.indexed = 1,
 			.channel = 0,
-			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-				BIT(IIO_CHAN_INFO_CALIBSCALE) |
-				BIT(IIO_CHAN_INFO_CALIBBIAS),
+			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 			.event_spec = tsl2x7x_events,
 			.num_event_specs = ARRAY_SIZE(tsl2x7x_events),
 			}, {
@@ -1580,14 +1580,14 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
 			.indexed = 1,
 			.channel = 0,
 			.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
-					      BIT(IIO_CHAN_INFO_INT_TIME),
+				BIT(IIO_CHAN_INFO_INT_TIME) |
+				BIT(IIO_CHAN_INFO_CALIBSCALE) |
+				BIT(IIO_CHAN_INFO_CALIBBIAS),
 			}, {
 			.type = IIO_INTENSITY,
 			.indexed = 1,
 			.channel = 0,
-			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-				BIT(IIO_CHAN_INFO_CALIBSCALE) |
-				BIT(IIO_CHAN_INFO_CALIBBIAS),
+			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 			.event_spec = tsl2x7x_events,
 			.num_event_specs = ARRAY_SIZE(tsl2x7x_events),
 			}, {
-- 
2.14.3
