Return-Path: <irina.tirdea@intel.com>
From: Irina Tirdea <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH] iio: Documentation: fix kernel version for 4.0 new ABI
Date: Mon, 30 Mar 2015 14:22:13 +0300
Message-Id: <1427714533-28176-1-git-send-email-irina.tirdea@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Kernel version for new ABI in 4.0 has been documented
as 3.20, since the changes have been merged before the kernel
version number change.

Change kernel version from 3.20 to 4.0.

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 103dd9b..3befcb1 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -351,7 +351,7 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_activity_calibgender
 What:		/sys/bus/iio/devices/iio:deviceX/in_energy_calibgender
 What:		/sys/bus/iio/devices/iio:deviceX/in_distance_calibgender
 What:		/sys/bus/iio/devices/iio:deviceX/in_velocity_calibgender
-KernelVersion:	3.20
+KernelVersion:	4.0
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Gender of the user (e.g.: male, female) used by some pedometers
@@ -362,7 +362,7 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_activity_calibgender_available
 What:		/sys/bus/iio/devices/iio:deviceX/in_energy_calibgender_available
 What:		/sys/bus/iio/devices/iio:deviceX/in_distance_calibgender_available
 What:		/sys/bus/iio/devices/iio:deviceX/in_velocity_calibgender_available
-KernelVersion:	3.20
+KernelVersion:	4.0
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Lists all available gender values (e.g.: male, female).
@@ -379,7 +379,7 @@ Description:
 		type.
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_energy_calibweight
-KernelVersion:	3.20
+KernelVersion:	4.0
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Weight of the user (in kg). It is needed by some pedometers
@@ -947,7 +947,7 @@ Description:
 		this type.
 
 What:		/sys/.../events/in_steps_change_en
-KernelVersion:	3.20
+KernelVersion:	4.0
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Event generated when channel passes a threshold on the absolute
@@ -956,7 +956,7 @@ Description:
 		in_steps_change_value.
 
 What:		/sys/.../events/in_steps_change_value
-KernelVersion:	3.20
+KernelVersion:	4.0
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Specifies the value of change threshold that the
@@ -1131,7 +1131,7 @@ Description:
 
 What:		/sys/.../iio:deviceX/in_energy_input
 What:		/sys/.../iio:deviceX/in_energy_raw
-KernelVersion:	3.20
+KernelVersion:	4.0
 Contact:	linux-iio@vger.kernel.org
 Description:
 		This attribute is used to read the energy value reported by the
@@ -1140,7 +1140,7 @@ Description:
 
 What:		/sys/.../iio:deviceX/in_distance_input
 What:		/sys/.../iio:deviceX/in_distance_raw
-KernelVersion:	3.20
+KernelVersion:	4.0
 Contact:	linux-iio@vger.kernel.org
 Description:
 		This attribute is used to read the distance covered by the user
@@ -1205,7 +1205,7 @@ Description:
 		seconds.
 
 What:		/sys/.../iio:deviceX/in_velocity_sqrt(x^2+y^2+z^2)_integration_time
-KernelVersion:	3.20
+KernelVersion:	4.0
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Number of seconds in which to compute speed.
@@ -1267,7 +1267,7 @@ Description:
 		Units after application of scale are m/s.
 
 What:		/sys/.../iio:deviceX/in_steps_debounce_count
-KernelVersion:	3.20
+KernelVersion:	4.0
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Specifies the number of steps that must occur within
@@ -1275,7 +1275,7 @@ Description:
 		consumer is making steps.
 
 What:		/sys/.../iio:deviceX/in_steps_debounce_time
-KernelVersion:	3.20
+KernelVersion:	4.0
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Specifies number of seconds in which we compute the steps
-- 
1.9.1
