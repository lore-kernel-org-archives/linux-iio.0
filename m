Return-Path: <SRS0=oVhW=BE=gmail.com=vilhelm.gray@kernel.org>
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: jic23@kernel.org,
	benjamin.gaignard@linaro.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v3 3/6] iio: Documentation: Add IIO Generic Counter sysfs documentation
Date: Thu,  5 Oct 2017 14:13:59 -0400
Message-Id: <7390f98f0285ef5172df64367c0946334824db6c.1507220144.git.vilhelm.gray@gmail.com>
In-Reply-To: <cover.1507220144.git.vilhelm.gray@gmail.com>
References: <cover.1507220144.git.vilhelm.gray@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patch adds standard documentation for the userspace sysfs
atrributes of the IIO Generic Counter Interface.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 .../testing/sysfs-bus-iio-generic-counter-sysfs    | 63 ++++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-generic-counter-sysfs

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-generic-counter-sysfs b/Documentation/ABI/testing/sysfs-bus-iio-generic-counter-sysfs
new file mode 100644
index 000000000000..b2c09254ec5a
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-generic-counter-sysfs
@@ -0,0 +1,63 @@
+What:		/sys/bus/iio/devices/iio:deviceX/countX-Y_function
+KernelVersion:	4.14
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Counter function mode for Value Y of Counter X; counter function
+		evaluation triggered by conditions specified by the
+		countX-Y_trigger_signalX-Z attributes.
+
+What:		/sys/bus/iio/devices/iio:deviceX/countX-Y_function_available
+KernelVersion:	4.14
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Discrete set of available function modes for the configuration
+		of the respective Value Y of Counter X are listed in this file.
+
+What:		/sys/bus/iio/devices/iio:deviceX/countX-Y_name
+KernelVersion:	4.14
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only attribute that indicates the device-specific name of
+		Value Y of Counter X.
+
+What:		/sys/bus/iio/devices/iio:deviceX/countX-Y_raw
+KernelVersion:	4.14
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Raw count data of Value Y of Counter X.
+
+What:		/sys/bus/iio/devices/iio:deviceX/countX-Y_triggers
+KernelVersion:	4.14
+Contact:	linux-iio@vger.kernel.org
+Description:
+		List of Signals associated to Value Y of Counter X.
+
+What:		/sys/bus/iio/devices/iio:deviceX/countX-Y_trigger_signalX-Z
+KernelVersion:	4.14
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Trigger mode of Value Y for Signal Z. This attribute indicates
+		the condition of Signal Z that triggers the counter function
+		evaluation for Value Y. Both Value Y and Signal Z are part of
+		Counter X.
+
+What:		/sys/bus/iio/devices/iio:deviceX/countX-Y_trigger_signalX-Z_available
+KernelVersion:	4.14
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Discrete set of available trigger modes are listed in this file
+		for the configuration of the respective Trigger associating
+		Signal Z of Counter X with Value Y of Counter X.
+
+What:		/sys/bus/iio/devices/iio:deviceX/signalX-Y_name
+KernelVersion:	4.14
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read-only attribute that indicates the device-specific name of
+		Signal Y of Counter X.
+
+What:		/sys/bus/iio/devices/iio:deviceX/signalX-Y_raw
+KernelVersion:	4.14
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Raw signal data of Signal Y of Counter X.
-- 
2.14.1
