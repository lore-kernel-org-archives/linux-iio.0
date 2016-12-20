Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:34572 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753523AbcLTK2T (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Dec 2016 05:28:19 -0500
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@free-electrons.com, wens@csie.org,
        lee.jones@linaro.org, linux@armlinux.org.uk,
        stefan.mavrodiev@gmail.com
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@free-electrons.com
Subject: [PATCH 1/7] Documentation: DT: bindings: iio: adc: add documentation for Allwinner SoCs' GPADC driver
Date: Tue, 20 Dec 2016 11:27:03 +0100
Message-Id: <20161220102709.9504-2-quentin.schulz@free-electrons.com>
In-Reply-To: <20161220102709.9504-1-quentin.schulz@free-electrons.com>
References: <20161220102709.9504-1-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The Allwinner SoCs all have an ADC that can also act as a thermal sensor
and sometimes as a touchscreen controller. If there is a touchscreen
controller, the first four channels can be used either for the ADC or
the touchscreen and the fifth channel is used for the thermal sensor.
If there is not a touchscreen controller, the one and only channel is
used for the thermal sensor.

This patch adds the documentation for the driver of the Allwinner SoCs'
GPADC.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 .../bindings/iio/adc/sun4i-gpadc-iio.txt           | 57 ++++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/sun4i-gpadc-iio.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/sun4i-gpadc-iio.txt b/Documentation/devicetree/bindings/iio/adc/sun4i-gpadc-iio.txt
new file mode 100644
index 0000000..aab768d
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/sun4i-gpadc-iio.txt
@@ -0,0 +1,57 @@
+Allwinner SoCs' GPADC Device Tree bindings
+------------------------------------------
+
+The Allwinner SoCs all have an ADC that can also act as a thermal sensor and
+sometimes as a touchscreen controller. If there is a touchscreen controller, the
+first four channels can be used either for the ADC or the touchscreen and the
+fifth channel is used for the thermal sensor.
+If there is not a touchscreen controller, the one and only channel is used for
+the thermal sensor.
+
+Currently, the touchscreen controller does not have a driver using this ADC
+driver. The touchscreen controller is currently driven only by
+input/touchscreen/sun4i-ts.c which is absolutely incompatible with this driver.
+
+The Allwinner A10, A13 and A31 SoCs already have a DT binding for the
+aforementioned input driver, thus an MFD driver matches the existing DT binding
+(mfd/sun4i-gpadc.c) and replaces the input driver. No DT binding is required for
+these SoCs' ADC, everything is handled by the MFD which is matching the existing
+DT binding for input/touchscreen/sun4i-ts.c.
+
+The Allwinner A33 GPADC only have a thermal sensor and have a proper DT binding
+for this driver unlike the previously mentioned SoCs.
+
+Required properties:
+ - compatible: "allwinner,sun8i-a33-gpadc-iio"
+
+Optional properties:
+(for use with thermal framework for CPU thermal throttling for example, and/or
+ IIO consumers)
+ - #thermal-sensor-cells = <0>; (see
+Documentation/devicetree/bindings/thermal/thermal.txt)
+ - #io-channel-cells = <0>; (see
+Documentation/devicetree/bindings/iio/iio-bindings.txt)
+
+Example:
+
+thermal-zones {
+	cpu_thermal {
+		thermal-sensors = <&rtp>;
+		[...]
+	};
+};
+
+soc@01c00000 {
+	[...]
+	rtp: rtp@01c25000 {
+		compatible = "allwinner,sun8i-a33-gpadc-iio";
+		reg = <0x01c25000 0x100>;
+		#thermal-sensor-cells = <0>;
+		#io-channel-cells = <0>;
+	};
+}
+
+iio_hwmon {
+	compatible = "iio-hwmon";
+	io-channels = <&rtp>;
+};
-- 
2.9.3

