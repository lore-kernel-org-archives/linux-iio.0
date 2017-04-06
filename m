Return-Path: <SRS0=pypW=3O=jmondi.org=jacopo+renesas@kernel.org>
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: geert@linux-m68k.org,
	wsa+renesas@sang-engineering.com,
	magnus.damm@gmail.com,
	laurent.pinchart@ideasonboard.com,
	jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	robh+dt@kernel.org,
	mark.rutland@arm.com
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v5 2/4] iio: Documentation: Add max9611 sysfs documentation
Date: Thu,  6 Apr 2017 16:20:52 +0200
Message-Id: <1491488454-22468-3-git-send-email-jacopo+renesas@jmondi.org>
In-Reply-To: <1491488454-22468-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1491488454-22468-1-git-send-email-jacopo+renesas@jmondi.org>
List-ID: <linux-iio@vger.kernel.org>

Add documentation for max9611 driver.
Document attributes describing value of shunt resistor installed between
RS+ and RS- voltage sense inputs.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 Documentation/ABI/testing/sysfs-bus-iio-adc-max9611 | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-max9611

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-max9611 b/Documentation/ABI/testing/sysfs-bus-iio-adc-max9611
new file mode 100644
index 0000000..6d2d2b0
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-max9611
@@ -0,0 +1,17 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_power_shunt_resistor
+Date:		March 2017
+KernelVersion:	4.12
+Contact:	linux-iio@vger.kernel.org
+Description: 	The value of the shunt resistor used to compute power drain on
+                common input voltage pin (RS+). In Ohms.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_current_shunt_resistor
+Date:		March 2017
+KernelVersion:	4.12
+Contact:	linux-iio@vger.kernel.org
+Description: 	The value of the shunt resistor used to compute current flowing
+                between RS+ and RS- voltage sense inputs. In Ohms.
+
+These attributes describe a single physical component, exposed as two distinct
+attributes as it is used to calculate two different values: power load and
+current flowing between RS+ and RS- inputs.
-- 
2.7.4
