Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:59556 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933751Ab1IONhW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 15 Sep 2011 09:37:22 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 2/8] staging:iio:documentation Add abi docs for capacitance adcs.
Date: Thu, 15 Sep 2011 14:45:31 +0100
Message-Id: <1316094337-12542-3-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1316094337-12542-1-git-send-email-jic23@cam.ac.uk>
References: <1316094337-12542-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/Documentation/sysfs-bus-iio |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio b/drivers/staging/iio/Documentation/sysfs-bus-iio
index f7bc59a..fb6c381 100644
--- a/drivers/staging/iio/Documentation/sysfs-bus-iio
+++ b/drivers/staging/iio/Documentation/sysfs-bus-iio
@@ -92,6 +92,24 @@ Description:
 		is required is a consistent labeling.  Units after application
 		of scale and offset are microvolts.
 
+What:		/sys/bus/iio/devices/iio:deviceX/in_capacitanceY_raw
+KernelVersion:	3.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Raw capacitance measurement from channel Y. Units after
+		application of scale and offset are nanofarads.
+
+What:		/sys/.../iio:deviceX/in_capacitanceY-in_capacitanceZ_raw
+KernelVersion:	3.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Raw differential capacitance measurement equivalent to
+		channel Y - channel Z where these channel numbers apply to the
+		physically equivalent inputs when non differential readings are
+		separately available. In differential only parts, then all that
+		is required is a consistent labeling.  Units after application
+		of scale and offset are nanofarads..
+
 What:		/sys/bus/iio/devices/iio:deviceX/in_temp_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_tempX_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_temp_x_raw
@@ -251,6 +269,7 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_accel_scale_available
 What:		/sys/.../iio:deviceX/in_voltageX_scale_available
 What:		/sys/.../iio:deviceX/in_voltage-voltage_scale_available
 What:		/sys/.../iio:deviceX/out_voltageX_scale_available
+What:		/sys/.../iio:deviceX/in_capacitance_scale_available
 KernelVersion:	2.635
 Contact:	linux-iio@vger.kernel.org
 Description:
-- 
1.7.3.4

