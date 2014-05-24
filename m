Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Erik.Habbinga@schneider-electric.com,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH] iio:adc:max1363 incorrect resolutions for max11604, max11605, max11610 and max11611.
Date: Sat, 24 May 2014 13:04:01 +0100
Message-Id: <1400933041-7007-1-git-send-email-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

Reported-by: Erik Habbinga <Erik.Habbinga@schneider-electric.com>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/adc/max1363.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index 9cf3229..1b3b74b 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -1252,8 +1252,8 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
 		.num_modes = ARRAY_SIZE(max1238_mode_list),
 		.default_mode = s0to11,
 		.info = &max1238_info,
-		.channels = max1238_channels,
-		.num_channels = ARRAY_SIZE(max1238_channels),
+		.channels = max1038_channels,
+		.num_channels = ARRAY_SIZE(max1038_channels),
 	},
 	[max11605] = {
 		.bits = 8,
@@ -1262,8 +1262,8 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
 		.num_modes = ARRAY_SIZE(max1238_mode_list),
 		.default_mode = s0to11,
 		.info = &max1238_info,
-		.channels = max1238_channels,
-		.num_channels = ARRAY_SIZE(max1238_channels),
+		.channels = max1038_channels,
+		.num_channels = ARRAY_SIZE(max1038_channels),
 	},
 	[max11606] = {
 		.bits = 10,
@@ -1312,8 +1312,8 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
 		.num_modes = ARRAY_SIZE(max1238_mode_list),
 		.default_mode = s0to11,
 		.info = &max1238_info,
-		.channels = max1238_channels,
-		.num_channels = ARRAY_SIZE(max1238_channels),
+		.channels = max1138_channels,
+		.num_channels = ARRAY_SIZE(max1138_channels),
 	},
 	[max11611] = {
 		.bits = 10,
@@ -1322,8 +1322,8 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
 		.num_modes = ARRAY_SIZE(max1238_mode_list),
 		.default_mode = s0to11,
 		.info = &max1238_info,
-		.channels = max1238_channels,
-		.num_channels = ARRAY_SIZE(max1238_channels),
+		.channels = max1138_channels,
+		.num_channels = ARRAY_SIZE(max1138_channels),
 	},
 	[max11612] = {
 		.bits = 12,
-- 
1.9.3
