Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:35896 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643Ab2DVMNg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 22 Apr 2012 08:13:36 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 07/14] staging:iio:imu switch select kconfig elements to depends.
Date: Sun, 22 Apr 2012 13:13:32 +0100
Message-Id: <1335096819-19565-8-git-send-email-jic23@kernel.org>
In-Reply-To: <1335096819-19565-1-git-send-email-jic23@kernel.org>
References: <1335096819-19565-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

As we are moving the IIO core out of staging, we need to
stop drivers in staging controlling whether elements of the
core are built.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/imu/Kconfig |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/iio/imu/Kconfig b/drivers/staging/iio/imu/Kconfig
index 2c2f47d..6e693dc 100644
--- a/drivers/staging/iio/imu/Kconfig
+++ b/drivers/staging/iio/imu/Kconfig
@@ -6,8 +6,7 @@ menu "Inertial measurement units"
 config ADIS16400
 	tristate "Analog Devices ADIS16400 and similar IMU SPI driver"
 	depends on SPI
-	select IIO_SW_RING if IIO_BUFFER
-	select IIO_TRIGGER if IIO_BUFFER
+	depends on !IIO_BUFFER || (IIO_SW_RING && IIO_TRIGGER)
 	help
 	  Say yes here to build support for Analog Devices adis16300, adis16344,
 	  adis16350, adis16354, adis16355, adis16360, adis16362, adis16364,
-- 
1.7.9.4

