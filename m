Return-Path: <SRS0=wlXe=ZH=it-klinger.de=ak@kernel.org>
Date: Wed, 25 Jan 2017 20:07:47 +0100
From: Andreas Klinger <ak@it-klinger.de>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	ktsai@capellamicro.com, wsa@the-dreams.de, robh+dt@kernel.org,
	pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	trivial@kernel.org, mranostay@gmail.com, linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: ak@it-klinger.de
Subject: [PATCH v4 3/3] iio: distance: srf08: add driver ABI documentation
Message-ID: <20170125190747.GA9285@andreas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

Add sysfs-bus-iio-distance-srf08 for individual attributes of the driver,
especially:
 - sensitivity which the device documentation calls gain for amplifying the
   signal
 - max_range for limiting the maximum distance for expected echos and
   therefore limiting the time waiting for telegrams

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 .../ABI/testing/sysfs-bus-iio-distance-srf08       | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-distance-srf08

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-distance-srf08 b/Documentation/ABI/testing/sysfs-bus-iio-distance-srf08
new file mode 100644
index 000000000000..0a1ca1487fa9
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-distance-srf08
@@ -0,0 +1,22 @@
+What		/sys/bus/iio/devices/iio:deviceX/sensor_sensitivity
+Date:		January 2017
+KernelVersion:	4.11
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Show or set the gain boost of the amp, from 0-31 range.
+		default 31
+
+What		/sys/bus/iio/devices/iio:deviceX/sensor_max_range
+Date:		January 2017
+KernelVersion:	4.11
+Contact:	linux-iio@vger.kernel.org
+Description:
+                Show or set the maximum range between the sensor and the
+		first object echoed in meters. Default value is 6.020.
+		This setting limits the time the driver is waiting for a
+		echo.
+		Showing the range of available values is represented as the
+		minimum value, the step and the maximum value, all enclosed
+		in square brackets.
+		Example:
+		[0.043 0.043 11.008]
-- 
2.1.4
