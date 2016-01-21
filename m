Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33043 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbcAUT70 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 21 Jan 2016 14:59:26 -0500
Received: by mail-pf0-f178.google.com with SMTP id e65so28761614pfe.0
        for <linux-iio@vger.kernel.org>; Thu, 21 Jan 2016 11:59:26 -0800 (PST)
From: Shraddha Barke <shraddha.6596@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Cc: Shraddha Barke <shraddha.6596@gmail.com>
Subject: [PATCH] Staging: iio: Documentation: Remove unused sysfs attributes
Date: Thu, 21 Jan 2016 12:22:59 +0530
Message-Id: <1453359179-9675-1-git-send-email-shraddha.6596@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch removes the unused sysfs attributes range, range_available,
adc_resolution and adc_resolution_available.

Signed-off-by: Shraddha Barke <shraddha.6596@gmail.com>
---
 .../staging/iio/Documentation/sysfs-bus-iio-light  | 28 ----------------------
 1 file changed, 28 deletions(-)

diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio-light b/drivers/staging/iio/Documentation/sysfs-bus-iio-light
index 17e5c9c..7c7cd84 100644
--- a/drivers/staging/iio/Documentation/sysfs-bus-iio-light
+++ b/drivers/staging/iio/Documentation/sysfs-bus-iio-light
@@ -1,31 +1,3 @@
-
-What:		/sys/bus/iio/devices/device[n]/range
-KernelVersion:	2.6.37
-Contact:	linux-iio@vger.kernel.org
-Description:
-		Hardware dependent ADC Full Scale Range used for some ambient
-		light sensors in calculating lux.
-
-What:		/sys/bus/iio/devices/device[n]/range_available
-KernelVersion:	2.6.37
-Contact:	linux-iio@vger.kernel.org
-Description:
-		Hardware dependent supported vales for ADC Full Scale Range.
-
-What:		/sys/bus/iio/devices/device[n]/adc_resolution
-KernelVersion:	2.6.37
-Contact:	linux-iio@vger.kernel.org
-Description:
-		Hardware dependent ADC resolution of the ambient light sensor
-		used in calculating the lux.
-
-What:		/sys/bus/iio/devices/device[n]/adc_resolution_available
-KernelVersion:	2.6.37
-Contact:	linux-iio@vger.kernel.org
-Description:
-		Hardware dependent list of possible values supported for the
-		adc_resolution of the given sensor.
-
 What:		/sys/bus/iio/devices/device[n]/in_illuminance0[_input|_raw]
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
-- 
2.1.4

