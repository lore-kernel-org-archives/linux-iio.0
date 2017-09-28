Return-Path: <SRS0=2XkP=A5=samsung.com=m.purski@kernel.org>
From: Maciej Purski <m.purski@samsung.com>
To: devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>,
	Jonathan Corbet <corbet@lwn.net>, Russell King <linux@armlinux.org.uk>,
	Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>, Maciej Purski
	<m.purski@samsung.com>
Subject: [PATCH 3/4] dt-bindings: hwmon: Add max-expected-current property
 to ina2xx
Date: Thu, 28 Sep 2017 14:50:14 +0200
Message-id: <1506603015-27202-4-git-send-email-m.purski@samsung.com>
In-reply-to: <1506603015-27202-1-git-send-email-m.purski@samsung.com>
References: <1506603015-27202-1-git-send-email-m.purski@samsung.com>
	<CGME20170928125104eucas1p20a3ead82624005331e36b8ebeca46815@eucas1p2.samsung.com>
List-ID: <linux-iio@vger.kernel.org>

Add optional max expected current property which allows calibrating
the ina sensor in order to achieve requested precision. Document
the changes in Documentation/hwmon/ina2xx.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 Documentation/devicetree/bindings/hwmon/ina2xx.txt | 4 +++-
 Documentation/hwmon/ina2xx                         | 9 +++++----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/ina2xx.txt b/Documentation/devicetree/bindings/hwmon/ina2xx.txt
index 02af0d9..25ba372 100644
--- a/Documentation/devicetree/bindings/hwmon/ina2xx.txt
+++ b/Documentation/devicetree/bindings/hwmon/ina2xx.txt
@@ -14,11 +14,13 @@ Optional properties:
 
 - shunt-resistor
 	Shunt resistor value in micro-Ohm
-
+- max-expected-current
+	Max expected current value in mA
 Example:
 
 ina220@44 {
 	compatible = "ti,ina220";
 	reg = <0x44>;
 	shunt-resistor = <1000>;
+	max-expected-current = <3000>;
 };
diff --git a/Documentation/hwmon/ina2xx b/Documentation/hwmon/ina2xx
index cfd31d9..e9ca838 100644
--- a/Documentation/hwmon/ina2xx
+++ b/Documentation/hwmon/ina2xx
@@ -51,10 +51,11 @@ INA230 and INA231 are high or low side current shunt and power monitors
 with an I2C interface. The chips monitor both a shunt voltage drop and
 bus supply voltage.
 
-The shunt value in micro-ohms can be set via platform data or device tree at
-compile-time or via the shunt_resistor attribute in sysfs at run-time. Please
-refer to the Documentation/devicetree/bindings/i2c/ina2xx.txt for bindings
-if the device tree is used.
+The shunt value in micro-ohms and max expected current in mA can be set
+via platform data or device tree at compile-time or via the shunt_resistor
+and max_expected_current attributes in sysfs at run-time. Please refer to the
+Documentation/devicetree/bindings/i2c/ina2xx.txt for bindings if the
+device tree is used.
 
 Additionally ina226 supports update_interval attribute as described in
 Documentation/hwmon/sysfs-interface. Internally the interval is the sum of
-- 
2.7.4
