Return-Path: <pmeerw@pmeerw.net>
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH] iio: fix spelling of Accelerometer in Kconfig
Date: Sat, 13 Oct 2012 10:06:35 +0200
Message-Id: <1350115595-7107-4-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1350115595-7107-1-git-send-email-pmeerw@pmeerw.net>
References: <1350115595-7107-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Acked-by: Srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/accel/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index b2510c4..fe4bcd7 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -8,7 +8,7 @@ config HID_SENSOR_ACCEL_3D
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	select HID_SENSOR_IIO_COMMON
-	tristate "HID Acelerometers 3D"
+	tristate "HID Accelerometers 3D"
 	help
 	  Say yes here to build support for the HID SENSOR
 	  accelerometers 3D.
-- 
1.7.9.5
