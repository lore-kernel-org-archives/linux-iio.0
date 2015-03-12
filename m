Return-Path: <hamohammed.sa@gmail.com>
Date: Thu, 12 Mar 2015 18:52:50 +0300
From: Haneen Mohammed <hamohammed.sa@gmail.com>
To: outreachy-kernel@googlegroups.com
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, gregkh@linuxfoundation.org,
	daniel.baluta@intel.com
Subject: [PATCH v2] iio: Add ABI documentation for proximity scan_elements
Message-ID: <20150312155250.GA20385@haneen-vb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

This patch adds ABI documentation entries for in_proximity_en,
in_proximity_type, and in_proximity_index in the scan_elements directory.
At least one user for these is present, the AS3935 Franklin lightning sensor.

Signed-off-by: Haneen Mohammed <hamohammed.sa@gmail.com>
---
v2: Fix typos in commit subject/body.

 Documentation/ABI/testing/sysfs-bus-iio | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 9a1a5fc..fd026d9 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -999,6 +999,7 @@ What:		/sys/.../iio:deviceX/scan_elements/in_incli_y_en
 What:		/sys/.../iio:deviceX/scan_elements/in_pressureY_en
 What:		/sys/.../iio:deviceX/scan_elements/in_pressure_en
 What:		/sys/.../iio:deviceX/scan_elements/in_rot_quaternion_en
+What:		/sys/.../iio:deviceX/scan_elements/in_proximity_en
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -1015,6 +1016,7 @@ What:		/sys/.../iio:deviceX/scan_elements/in_timestamp_type
 What:		/sys/.../iio:deviceX/scan_elements/in_pressureY_type
 What:		/sys/.../iio:deviceX/scan_elements/in_pressure_type
 What:		/sys/.../iio:deviceX/scan_elements/in_rot_quaternion_type
+What:		/sys/.../iio:deviceX/scan_elements/in_proximity_type
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -1066,6 +1068,7 @@ What:		/sys/.../iio:deviceX/scan_elements/in_timestamp_index
 What:		/sys/.../iio:deviceX/scan_elements/in_pressureY_index
 What:		/sys/.../iio:deviceX/scan_elements/in_pressure_index
 What:		/sys/.../iio:deviceX/scan_elements/in_rot_quaternion_index
+What:		/sys/.../iio:deviceX/scan_elements/in_proximity_index
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
-- 
1.9.1
