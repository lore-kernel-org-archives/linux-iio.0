Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 080/111] staging:iio:max1363 add new 2 channels parts form maxim, 11644-7
Date: Wed, 18 May 2011 14:42:10 +0100
Message-Id: <1305726161-5606-81-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
References: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

V2: IIO_CHAN macro usage update.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/Kconfig        |    4 +-
 drivers/staging/iio/adc/max1363_core.c |   57 +++++++++++++++++++++++++++++++-
 2 files changed, 58 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
index 0a19cee..617af93 100644
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
index 20c6aae..0c80abb 100644
--- a/drivers/staging/iio/adc/max1363_core.c
+++ b/drivers/staging/iio/adc/max1363_core.c
@@ -417,6 +417,21 @@ static struct iio_chan_spec max11602_channels[] = MAX1363_8X_CHANS(8);
 static struct iio_chan_spec max11608_channels[] = MAX1363_8X_CHANS(10);
 static struct iio_chan_spec max11614_channels[] = MAX1363_8X_CHANS(12);
 
+static const enum max1363_modes max11644_mode_list[] = {
+	_s0, _s1, s0to1, d0m1, d1m0,
+};
+
+#define MAX1363_2X_CHANS(bits) {			\
+	MAX1363_CHAN_U(0, _s0, 0, bits),		\
+	MAX1363_CHAN_U(1, _s1, 1, bits),		\
+	MAX1363_CHAN_B(0, 1, d0m1, 2, bits),		\
+	MAX1363_CHAN_B(1, 0, d1m0, 3, bits),		\
+	IIO_CHAN_SOFT_TIMESTAMP(4)			\
+	}
+
+static struct iio_chan_spec max11646_channels[] = MAX1363_2X_CHANS(10);
+static struct iio_chan_spec max11644_channels[] = MAX1363_2X_CHANS(12);
+
 enum { max1361,
        max1362,
        max1363,
@@ -451,6 +466,10 @@ enum { max1361,
        max11615,
        max11616,
        max11617,
+       max11644,
+       max11645,
+       max11646,
+       max11647
 };
 
 /* max1363 and max1368 tested - rest from data sheet */
@@ -764,7 +783,43 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
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
