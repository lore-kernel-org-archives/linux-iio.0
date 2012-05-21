Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from db3ehsobe003.messaging.microsoft.com ([213.199.154.141]:9130
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754431Ab2EUMaz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 21 May 2012 08:30:55 -0400
From: <michael.hennerich@analog.com>
To: <gregkh@linuxfoundation.org>
CC: <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
	<device-drivers-devel@blackfin.uclinux.org>,
	Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH] iio: documentation: Add out_altvoltage and friends
Date: Mon, 21 May 2012 14:30:31 +0200
Message-ID: <1337603431-1820-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

Continuous frequency/clock generating devices, such as DDSs or PLLs
should use out_altvoltage.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
 Documentation/ABI/testing/sysfs-bus-iio |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 5bc8a47..cfedf63 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -219,6 +219,7 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_supply_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_scale
 What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_scale
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_peak_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_scale
@@ -273,6 +274,7 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_accel_scale_available
 What:		/sys/.../iio:deviceX/in_voltageX_scale_available
 What:		/sys/.../iio:deviceX/in_voltage-voltage_scale_available
 What:		/sys/.../iio:deviceX/out_voltageX_scale_available
+What:		/sys/.../iio:deviceX/out_altvoltageX_scale_available
 What:		/sys/.../iio:deviceX/in_capacitance_scale_available
 KernelVersion:	2.635
 Contact:	linux-iio@vger.kernel.org
@@ -298,14 +300,19 @@ Description:
 		gives the 3dB frequency of the filter in Hz.

 What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_raw
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_raw
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Raw (unscaled, no bias etc.) output voltage for
 		channel Y.  The number must always be specified and
 		unique if the output corresponds to a single channel.
+		While DAC like devices typically use out_voltage,
+		a continuous frequency generating device, such as
+		a DDS or PLL should use out_altvoltage.

 What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY&Z_raw
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY&Z_raw
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -316,6 +323,8 @@ Description:

 What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_powerdown_mode
 What:		/sys/bus/iio/devices/iio:deviceX/out_voltage_powerdown_mode
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_powerdown_mode
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltage_powerdown_mode
 KernelVersion:	2.6.38
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -330,6 +339,8 @@ Description:

 What:		/sys/.../iio:deviceX/out_votlageY_powerdown_mode_available
 What:		/sys/.../iio:deviceX/out_voltage_powerdown_mode_available
+What:		/sys/.../iio:deviceX/out_altvotlageY_powerdown_mode_available
+What:		/sys/.../iio:deviceX/out_altvoltage_powerdown_mode_available
 KernelVersion:	2.6.38
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -338,6 +349,8 @@ Description:

 What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_powerdown
 What:		/sys/bus/iio/devices/iio:deviceX/out_voltage_powerdown
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_powerdown
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltage_powerdown
 KernelVersion:	2.6.38
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -346,6 +359,24 @@ Description:
 		normal operation. Y may be suppressed if all outputs are
 		controlled together.

+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_frequency
+KernelVersion:	3.4.0
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Output frequency for channel Y in Hz. The number must always be
+		specified and unique if the output corresponds to a single
+		channel.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_phase
+KernelVersion:	3.4.0
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Phase in radians of one frequency/clock output Y
+		(out_altvoltageY) relative to another frequency/clock output
+		(out_altvoltageZ) of the device X. The number must always be
+		specified and unique if the output corresponds to a single
+		channel.
+
 What:		/sys/bus/iio/devices/iio:deviceX/events
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
--
1.7.0.4


