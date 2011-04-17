Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:35607 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754170Ab1DQTFK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 17 Apr 2011 15:05:10 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 66/70] staging:iio:max1363 add new 2 channels parts form maxim, 11644-7
Date: Sun, 17 Apr 2011 20:06:39 +0100
Message-Id: <1303067203-4894-67-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1303067203-4894-1-git-send-email-jic23@cam.ac.uk>
References: <1303067203-4894-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/Kconfig        |    4 +-
 drivers/staging/iio/adc/max1363_core.c |   66 +++++++++++++++++++++++++++++++-
 2 files changed, 67 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
index 4159389..228274b 100644
--- a/drivers/staging/iio/adc/Kconfig
+++ b/drivers/staging/iio/adc/Kconfig
@@ -15,8 +15,8 @@ config MAX1363
 	  max1139, max1236, max1237, max11238, max1239, max11600, max11601,
 	  max11602, max11603, max11604, max11605, max11606, max11607,
 	  max11608, max11609, max11610, max11611, max11612, max11613,
-	  max11614, max11615, max11616, max11617) Provides direct access
-	  via sysfs.
+	  max11614, max11615, max11616, max11617, max11644, max11645,
+	  max11646, max11647) Provides direct access via sysfs.
 
 config MAX1363_RING_BUFFER
 	bool "MAXIM max1363: use ring buffer"
diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
index ab07a59..10c75c0 100644
--- a/drivers/staging/iio/adc/max1363_core.c
+++ b/drivers/staging/iio/adc/max1363_core.c
@@ -598,6 +598,30 @@ static struct iio_chan_spec max11614_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(16)
 };
 
+static const enum max1363_modes max11644_mode_list[] = {
+	_s0, _s1, s0to1, d0m1, d1m0,
+};
+
+static struct iio_chan_spec max11644_channels[] = {
+	IIO_CHAN(IIO_IN, 0, MAX1363_INFO_MASK, _s0, 0, IIO_ST('u', 12, 16, 0)),
+	IIO_CHAN(IIO_IN, 1, MAX1363_INFO_MASK, _s0, 1, IIO_ST('u', 12, 16, 0)),
+	IIO_CHAN_COMPOUND(IIO_IN_DIFF, 0, 1, MAX1363_INFO_MASK,
+			  d0m1, 2, IIO_ST('s', 12, 16, 0)),
+	IIO_CHAN_COMPOUND(IIO_IN_DIFF, 1, 0, MAX1363_INFO_MASK,
+			  d1m0, 3, IIO_ST('s', 12, 16, 0)),
+	IIO_CHAN_SOFT_TIMESTAMP(4)
+};
+
+static struct iio_chan_spec max11646_channels[] = {
+	IIO_CHAN(IIO_IN, 0, MAX1363_INFO_MASK, _s0, 0, IIO_ST('u', 10, 16, 0)),
+	IIO_CHAN(IIO_IN, 1, MAX1363_INFO_MASK, _s0, 1, IIO_ST('u', 10, 16, 0)),
+	IIO_CHAN_COMPOUND(IIO_IN_DIFF, 0, 1, MAX1363_INFO_MASK,
+			  d0m1, 2, IIO_ST('s', 10, 16, 0)),
+	IIO_CHAN_COMPOUND(IIO_IN_DIFF, 1, 0, MAX1363_INFO_MASK,
+			  d1m0, 3, IIO_ST('s', 10, 16, 0)),
+	IIO_CHAN_SOFT_TIMESTAMP(4)
+};
+
 enum { max1361,
        max1362,
        max1363,
@@ -632,6 +656,10 @@ enum { max1361,
        max11615,
        max11616,
        max11617,
+       max11644,
+       max11645,
+       max11646,
+       max11647
 };
 
 /* max1363 and max1368 tested - rest from data sheet */
@@ -945,7 +973,43 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
 		.default_mode = s0to11,
 		.channels = max1238_channels,
 		.num_channels = ARRAY_SIZE(max1238_channels),
-	}
+	},
+	[max11644] = {
+		.bits = 12,
+		.int_vref_mv = 2048,
+		.mode_list = max11644_mode_list,
+		.num_modes = ARRAY_SIZE(max11644_mode_list),
+		.default_mode = s0to1,
+		.channels = max11644_channels,
+		.num_channels = ARRAY_SIZE(max11644_channels),
+	},
+	[max11645] = {
+		.bits = 12,
+		.int_vref_mv = 4096,
+		.mode_list = max11644_mode_list,
+		.num_modes = ARRAY_SIZE(max11644_mode_list),
+		.default_mode = s0to1,
+		.channels = max11644_channels,
+		.num_channels = ARRAY_SIZE(max11644_channels),
+	},
+	[max11646] = {
+		.bits = 10,
+		.int_vref_mv = 2048,
+		.mode_list = max11644_mode_list,
+		.num_modes = ARRAY_SIZE(max11644_mode_list),
+		.default_mode = s0to1,
+		.channels = max11644_channels,
+		.num_channels = ARRAY_SIZE(max11646_channels),
+	},
+	[max11647] = {
+		.bits = 10,
+		.int_vref_mv = 4096,
+		.mode_list = max11644_mode_list,
+		.num_modes = ARRAY_SIZE(max11644_mode_list),
+		.default_mode = s0to1,
+		.channels = max11644_channels,
+		.num_channels = ARRAY_SIZE(max11646_channels),
+	},
 };
 
 static const int max1363_monitor_speeds[] = { 133000, 665000, 33300, 16600,
-- 
1.7.3.4

