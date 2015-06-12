Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:3640 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751198AbbFKQAg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 11 Jun 2015 12:00:36 -0400
From: Adriana Reus <adriana.reus@intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, Adriana Reus <adriana.reus@intel.com>
Subject: [PATCH] iio: Documentation: Add additional *scale_available attributes
Date: Fri, 12 Jun 2015 19:01:07 +0300
Message-Id: <1434124867-30071-1-git-send-email-adriana.reus@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Added some more *scale_available attributes to the list that
are used in various drivers but were missiong from Documentation.

Signed-off-by: Adriana Reus <adriana.reus@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index bbed111..666a341 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -413,6 +413,11 @@ Description:
 		to compute the calories burnt by the user.
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_scale_available
+What:		/sys/.../iio:deviceX/in_anglvel_scale_available
+What:		/sys/.../iio:deviceX/in_magn_scale_available
+What:		/sys/.../iio:deviceX/in_illuminance_scale_available
+What:		/sys/.../iio:deviceX/in_intensity_scale_available
+What:		/sys/.../iio:deviceX/in_proximity_scale_available
 What:		/sys/.../iio:deviceX/in_voltageX_scale_available
 What:		/sys/.../iio:deviceX/in_voltage-voltage_scale_available
 What:		/sys/.../iio:deviceX/out_voltageX_scale_available
-- 
1.9.1

