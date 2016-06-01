Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:10319 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822AbcFAMrN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 1 Jun 2016 08:47:13 -0400
From: Laxman Dewangan <ldewangan@nvidia.com>
To: <robh+dt@kernel.org>, <jic23@kernel.org>, <corbet@lwn.net>,
	<lars@metafoo.de>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH 3/3] iio: adc: ina3221: Add sysfs details for TI INA3221
Date: Wed, 1 Jun 2016 18:04:14 +0530
Message-ID: <1464784454-7988-3-git-send-email-ldewangan@nvidia.com>
In-Reply-To: <1464784454-7988-1-git-send-email-ldewangan@nvidia.com>
References: <1464784454-7988-1-git-send-email-ldewangan@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The INA3221 is a three-channel, high-side current and bus voltage monitor
with an I2C interface from Texas Instruments. The INA3221 monitors both
shunt voltage drops and bus supply voltages in addition to having
programmable conversion times and averaging modes for these signals.
The INA3221 offers both critical and warning alerts to detect multiple
programmable out-of-range conditions for each channel.

The device export the SW interface  with IIO framework. Detail out the
all sysfs exposed by device for reference.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 Documentation/iio/adc/ina3221.txt | 81 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 Documentation/iio/adc/ina3221.txt

diff --git a/Documentation/iio/adc/ina3221.txt b/Documentation/iio/adc/ina3221.txt
new file mode 100644
index 0000000..30cbd6d
--- /dev/null
+++ b/Documentation/iio/adc/ina3221.txt
@@ -0,0 +1,81 @@
+The INA3221 is a three-channel, high-side current and bus voltage monitor
+with an I2C interface from Texas Instruments. The INA3221 monitors both
+shunt voltage drops and bus supply voltages in addition to having
+programmable conversion times and averaging modes for these signals.
+The INA3221 offers both critical and warning alerts to detect multiple
+programmable out-of-range conditions for each channel.
+
+Driver exposes multiple sysfs whose details are as follows:
+
+/sys/bus/iio/devices/iio:device0/operating_mode:
+	Operating mode of device whether it is in oneshot mode or
+	continuous conversion mode.
+	To change mode to continuous mode say:
+		echo "c" > operating_mode
+	 or
+		echo "C" > operating_mode
+
+	To change mode to one shot mode, say
+		echo "o" > operating_mode
+	or
+		echo "O" > operating_mode
+
+/sys/bus/iio/devices/iio:device0/continuous_oversampling_ratio:
+	Oversampling ratio (number of sample used for average) when device
+	is in continuous mode.
+	The possible values for number of average samples are:
+		1, 4, 16, 64, 128, 256, 512, 1024
+
+/sys/bus/iio/devices/iio:device0/continuous_vbus_conv_time:
+	ADC conversion time for voltage bus in continuous mode.
+	This is in microseconds.
+	The possible value for conversion times are:
+		140, 204, 332, 588, 1100, 2116, 4156, 8244
+
+/sys/bus/iio/devices/iio:device0/continuous_vshunt_conv_time:
+	ADC conversion time for shunt voltage in continuous mode.
+	This is in microseconds.
+	The possible value for conversion times are:
+		140, 204, 332, 588, 1100, 2116, 4156, 8244
+
+/sys/bus/iio/devices/iio:device0/oneshot_oversampling_ratio:
+	Oversampling ratio (number of sample used for average) when device
+	is in one-shot mode.
+	The possible values for number of average samples are:
+		1, 4, 16, 64, 128, 256, 512, 1024
+
+/sys/bus/iio/devices/iio:device0/oneshot_vbus_conv_time:
+	ADC conversion time for voltage bus in one-shot mode.
+	This is in microseconds.
+	The possible value for conversion times are:
+		140, 204, 332, 588, 1100, 2116, 4156, 8244
+
+/sys/bus/iio/devices/iio:device0/oneshot_vshunt_conv_time
+	ADC conversion time for shunt voltage in one-shot mode.
+	This is in microseconds.
+	The possible value for conversion times are:
+		140, 204, 332, 588, 1100, 2116, 4156, 8244
+
+/sys/bus/iio/devices/iio:device0/rail_name_<x>
+	The rail name of each channels.
+
+/sys/bus/iio/devices/iio:device0/in_voltage<x>_input:
+	The voltage bus voltage measured by device. This is processed
+	data in microvolts.
+
+/sys/bus/iio/devices/iio:device0/in_current<x>_input:
+	The current flow in the bus in microamps.
+
+/sys/bus/iio/devices/iio:device0/in_power<x>_input:
+	The input power in the bus for each channel in micro-watt.
+
+/sys/bus/iio/devices/iio:device0/in_current<x>_critical_input:
+	The critical current threshold on bus to generate critical
+	alert signal for each channel. This is provide in micro-amps.
+	The value can be override from sysfs for new critical current.
+
+/sys/bus/iio/devices/iio:device0/in_current<x>_warning_input:
+	The warning current threshold on bus to generate warning
+	alert signal for each channel. This is provide in micro-amps.
+	The value can be override from sysfs for new warning threshold.
+
-- 
2.1.4

