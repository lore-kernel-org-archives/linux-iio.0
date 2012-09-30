Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:36689 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750794Ab2I3KFt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 30 Sep 2012 06:05:49 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>, manuel.stahl@iis.fraunhofer.de
Subject: [PATCH 3/3] staging iio: consistent commas in adis16400 channel spec
Date: Sun, 30 Sep 2012 12:05:45 +0200
Message-Id: <1348999545-19099-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1348999545-19099-1-git-send-email-pmeerw@pmeerw.net>
References: <1348999545-19099-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

probably not the most important patch in the world

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Cc: manuel.stahl@iis.fraunhofer.de
---
 drivers/staging/iio/imu/adis16400_core.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index b302c9b..5eab327 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -622,7 +622,7 @@ static const struct iio_chan_spec adis16400_channels[] = {
 		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 		.address = in_supply,
 		.scan_index = ADIS16400_SCAN_SUPPLY,
-		.scan_type = IIO_ST('u', 14, 16, 0)
+		.scan_type = IIO_ST('u', 14, 16, 0),
 	}, {
 		.type = IIO_ANGL_VEL,
 		.modified = 1,
@@ -633,7 +633,7 @@ static const struct iio_chan_spec adis16400_channels[] = {
 		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
 		.address = gyro_x,
 		.scan_index = ADIS16400_SCAN_GYRO_X,
-		.scan_type = IIO_ST('s', 14, 16, 0)
+		.scan_type = IIO_ST('s', 14, 16, 0),
 	}, {
 		.type = IIO_ANGL_VEL,
 		.modified = 1,
@@ -752,7 +752,7 @@ static const struct iio_chan_spec adis16350_channels[] = {
 		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 		.address = in_supply,
 		.scan_index = ADIS16400_SCAN_SUPPLY,
-		.scan_type = IIO_ST('u', 12, 16, 0)
+		.scan_type = IIO_ST('u', 12, 16, 0),
 	}, {
 		.type = IIO_ANGL_VEL,
 		.modified = 1,
@@ -763,7 +763,7 @@ static const struct iio_chan_spec adis16350_channels[] = {
 		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
 		.address = gyro_x,
 		.scan_index = ADIS16400_SCAN_GYRO_X,
-		.scan_type = IIO_ST('s', 14, 16, 0)
+		.scan_type = IIO_ST('s', 14, 16, 0),
 	}, {
 		.type = IIO_ANGL_VEL,
 		.modified = 1,
@@ -877,7 +877,7 @@ static const struct iio_chan_spec adis16300_channels[] = {
 		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 		.address = in_supply,
 		.scan_index = ADIS16400_SCAN_SUPPLY,
-		.scan_type = IIO_ST('u', 12, 16, 0)
+		.scan_type = IIO_ST('u', 12, 16, 0),
 	}, {
 		.type = IIO_ANGL_VEL,
 		.modified = 1,
-- 
1.7.9.5

