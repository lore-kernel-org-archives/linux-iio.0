Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.135]:56613 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750939AbdAQNus (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Jan 2017 08:50:48 -0500
Date: Tue, 17 Jan 2017 14:50:06 +0100
From: Andreas Klinger <ak@it-klinger.de>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, ktsai@capellamicro.com,
        wsa@the-dreams.de, robh+dt@kernel.org, pawel.moll@arm.com,
        mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
        galak@codeaurora.org, trivial@kernel.org, mranostay@gmail.com,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org
Cc: ak@it-klinger.de
Subject: [PATCH v3 3/3] iio: distance: srf08: add driver ABI documentation
Message-ID: <20170117135006.GA22903@andreas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add sysfs-bus-iio-distance-srf08 for individual attributes of the driver,
especially:
 - sensitivity which the device documentation calls gain for amplifying the
   signal
 - max_range for limiting the maximum distance for expected echos and
   therefore limiting the time waiting for telegrams

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 .../ABI/testing/sysfs-bus-iio-distance-srf08       | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-distance-srf08

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-distance-srf08 b/Documentation/ABI/testing/sysfs-bus-iio-distance-srf08
new file mode 100644
index 000000000000..e96c28064748
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-distance-srf08
@@ -0,0 +1,27 @@
+What		/sys/bus/iio/devices/iio:deviceX/in_distance_raw
+Date:		January 2017
+KernelVersion:	4.11
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Get the current distance in meters between the sensor and
+		the first object recognized
+
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
+		Show or set the maximum range between the sensor and the
+		first object echoed in millimeters.
+		This setting limits the time the driver is waiting for a
+		echo.
+		Can be set between 43 and 11008 in a grid of 43 mm.
+		default 6020
-- 
2.1.4


-- 

