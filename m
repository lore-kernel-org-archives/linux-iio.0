Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: Michael.Hennerich@analog.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 16/16] staging:iio:adc:ad7887 stop using IIO_CHAN macro.
Date: Fri, 23 Sep 2011 13:01:42 +0100
Message-Id: <1316779302-12357-17-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1316779302-12357-1-git-send-email-jic23@cam.ac.uk>
References: <1316779302-12357-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

It's going away.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad7887_core.c |   26 ++++++++++++++++++--------
 1 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7887_core.c b/drivers/staging/iio/adc/ad7887_core.c
index 71af6cb..37e6cc9 100644
--- a/drivers/staging/iio/adc/ad7887_core.c
+++ b/drivers/staging/iio/adc/ad7887_core.c
@@ -71,14 +71,24 @@ static const struct ad7887_chip_info ad7887_chip_info_tbl[] = {
 	 * More devices added in future
 	 */
 	[ID_AD7887] = {
-		.channel[0] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 1, 0,
-				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
-				       1, 1, IIO_ST('u', 12, 16, 0), 0),
-
-		.channel[1] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
-				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
-				       0, 0, IIO_ST('u', 12, 16, 0), 0),
-
+		.channel[0] = {
+			.type = IIO_VOLTAGE,
+			.indexed = 1,
+			.channel = 1,
+			.info_mask = (1 << IIO_CHAN_INFO_SCALE_SHARED),
+			.address = 1,
+			.scan_index = 1,
+			.scan_type = IIO_ST('u', 12, 16, 0),
+		},
+		.channel[1] = {
+			.type = IIO_VOLTAGE,
+			.indexed = 1,
+			.channel = 0,
+			.info_mask = (1 << IIO_CHAN_INFO_SCALE_SHARED),
+			.address = 0,
+			.scan_index = 0,
+			.scan_type = IIO_ST('u', 12, 16, 0),
+		},
 		.channel[2] = IIO_CHAN_SOFT_TIMESTAMP(2),
 		.int_vref_mv = 2500,
 	},
-- 
1.7.3.4
