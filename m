Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:49576 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755491Ab2GAKUP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 1 Jul 2012 06:20:15 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>,
	Jon Brenner <jbrenner@taosinc.com>
Subject: [PATCH] iio: add channel modifiers for RGBC (red/green/blue/clear) data
Date: Sun,  1 Jul 2012 12:20:12 +0200
Message-Id: <1341138013-28267-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1341138013-28267-1-git-send-email-pmeerw@pmeerw.net>
References: <1341138013-28267-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

this patch steals the RGBC-related stuff from Jon Brenner's proposal
(http://permalink.gmane.org/gmane.linux.kernel.iio/4354), CCT parts
are left out for now

the adjd_s311 driver is making use of RGBC modifiers

shouldn't the documentation (sysfs-bus-iio-light) be migrated
from staging?

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Jon Brenner <jbrenner@taosinc.com>
---
 drivers/iio/industrialio-core.c                    |    4 ++++
 .../staging/iio/Documentation/sysfs-bus-iio-light  |   13 +++++++++++++
 include/linux/iio/types.h                          |    4 ++++
 3 files changed, 21 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index bb3c692..0e2f997 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -74,6 +74,10 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_SUM_SQUARED_X_Y_Z] = "x^2+y^2+z^2",
 	[IIO_MOD_LIGHT_BOTH] = "both",
 	[IIO_MOD_LIGHT_IR] = "ir",
+	[IIO_MOD_LIGHT_CLEAR] = "clear",
+	[IIO_MOD_LIGHT_RED] = "red",
+	[IIO_MOD_LIGHT_GREEN] = "green",
+	[IIO_MOD_LIGHT_BLUE] = "blue",
 };
 
 /* relies on pairs of these shared then separate */
diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio-light b/drivers/staging/iio/Documentation/sysfs-bus-iio-light
index d52be03..1f4f6bf 100644
--- a/drivers/staging/iio/Documentation/sysfs-bus-iio-light
+++ b/drivers/staging/iio/Documentation/sysfs-bus-iio-light
@@ -82,3 +82,16 @@ Contact:	linux-iio@vger.kernel.org
 Description:
 		This property gets/sets the table of coefficients
 		used in calculating illuminance in lux.
+
+What:		/sys/bus/iio/devices/device[n]/in_intensity_clear[_input|_raw]
+What:		/sys/bus/iio/devices/device[n]/in_intensity_red[_input|_raw]
+What:		/sys/bus/iio/devices/device[n]/in_intensity_green[_input|_raw]
+What:		/sys/bus/iio/devices/device[n]/in_intensity_blue[_input|_raw]
+KernelVersion:	3.6
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This property is supported by sensors that have a RGBC
+		sensing mode. This value should be the output from a reading
+		and if expressed in SI units, should include _input. If this
+		value is not in SI units (irradiance, uW/mm^2), then it should
+		include _raw.
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index e250401..63d85a8 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -46,6 +46,10 @@ enum iio_modifier {
 	IIO_MOD_LIGHT_IR,
 	IIO_MOD_ROOT_SUM_SQUARED_X_Y,
 	IIO_MOD_SUM_SQUARED_X_Y_Z,
+	IIO_MOD_LIGHT_CLEAR,
+	IIO_MOD_LIGHT_RED,
+	IIO_MOD_LIGHT_GREEN,
+	IIO_MOD_LIGHT_BLUE,
 };
 
 #define IIO_VAL_INT 1
-- 
1.7.9.5

