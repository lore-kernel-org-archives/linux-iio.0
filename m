Return-Path: <SRS0=fWxU=2F=jmondi.org=jacopo+renesas@kernel.org>
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: geert@linux-m68k.org,
	wsa+renesas@sang-engineering.com,
	magnus.damm@gmail.com,
	laurent.pinchart@ideasonboard.com,
	jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	meerw@pmeerw.net,
	robh+dt@kernel.org,
	mark.rutland@arm.com
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 2/4] iio: Documentation: Add max961x sysfs documentation
Date: Fri, 24 Feb 2017 16:05:54 +0100
Message-Id: <1487948756-25172-3-git-send-email-jacopo+renesas@jmondi.org>
In-Reply-To: <1487948756-25172-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1487948756-25172-1-git-send-email-jacopo+renesas@jmondi.org>
List-ID: <linux-iio@vger.kernel.org>

Add documentation for max961x driver.
The only attribute to document is the current sense shunt resistor
value.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 Documentation/ABI/testing/sysfs-bus-iio-adc-max961x | 5 +++++
 1 file changed, 5 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-max961x

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-max961x b/Documentation/ABI/testing/sysfs-bus-iio-adc-max961x
new file mode 100644
index 0000000..dbd5e75
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-max961x
@@ -0,0 +1,5 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_shunt_resistor
+Date:		February 2017
+KernelVersion:	4.10
+Contact:	linux-iio@vger.kernel.org
+Description: 	The value of the shunt resistor in micro Ohms.
-- 
2.7.4
