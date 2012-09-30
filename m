Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:36651 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750716Ab2I3KDh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 30 Sep 2012 06:03:37 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>, srinivas.pandruvada@intel.com
Subject: [PATCH] iio: fix spelling of Accelerometer in Kconfig
Date: Sun, 30 Sep 2012 12:03:33 +0200
Message-Id: <1348999413-19042-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Cc: srinivas.pandruvada@intel.com
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

