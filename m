Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:36772 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752296AbbC1ADa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 27 Mar 2015 20:03:30 -0400
Received: by wibg7 with SMTP id g7so43252992wib.1
        for <linux-iio@vger.kernel.org>; Fri, 27 Mar 2015 17:03:29 -0700 (PDT)
From: Haneen Mohammed <hamohammed.sa@gmail.com>
To: outreachy-kernel@googlegroups.com, linux-iio@vger.kernel.org,
	jic23@kernel.org, daniel.baluta@intel.com
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
Subject: [PATCH] iio: Add ABI documentation for in_rot offset value
Date: Sat, 28 Mar 2015 03:02:39 +0300
Message-Id: <1427500959-3404-1-git-send-email-hamohammed.sa@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds ABI documentation entries for in_rot_offset.
At least one user for these is present that is the  HID Sensors Driver.

Signed-off-by: Haneen Mohammed <hamohammed.sa@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 5cabafb..4736a34 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -254,6 +254,7 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_pressureY_offset
 What:		/sys/bus/iio/devices/iio:deviceX/in_pressure_offset
 What:		/sys/bus/iio/devices/iio:deviceX/in_humidityrelative_offset
 What:		/sys/bus/iio/devices/iio:deviceX/in_magn_offset
+What:		/sys/bus/iio/devices/iio:deviceX/in_rot_offset
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
-- 
1.9.1

