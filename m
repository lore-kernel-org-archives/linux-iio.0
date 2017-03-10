Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:34618 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935305AbdCJKjx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Mar 2017 05:39:53 -0500
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@free-electrons.com,
        wens@csie.org, lee.jones@linaro.org, linux@armlinux.org.uk,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, stefan.mavrodiev@gmail.com
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-sunxi@googlegroups.com, thomas.petazzoni@free-electrons.com
Subject: [PATCH v2 05/11] Documentation: DT: bindings: mfd: add A33 GPADC binding
Date: Fri, 10 Mar 2017 11:39:15 +0100
Message-Id: <20170310103921.19469-6-quentin.schulz@free-electrons.com>
In-Reply-To: <20170310103921.19469-1-quentin.schulz@free-electrons.com>
References: <20170310103921.19469-1-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds documentation for the A33 GPADC binding.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---

added in v2

 .../devicetree/bindings/mfd/sun4i-gpadc.txt        | 59 ++++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt

diff --git a/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt b/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
new file mode 100644
index 0000000..17242c8
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
@@ -0,0 +1,59 @@
+Allwinner SoCs' GPADC Device Tree bindings
+------------------------------------------
+The Allwinner SoCs all have an ADC that can also act as a thermal sensor
+and sometimes as a touchscreen controller.
+
+Required properties:
+  - compatible: "sun8i-a33-gpadc-iio",
+  - reg: mmio address range of the chip,
+  - #thermal-sensor-cells: shall be 0,
+  - #io-channel-cells: shall be 0,
+
+Example:
+	rtp: rtp@01c25000 {
+		compatible = "allwinner,sun8i-a33-gpadc-iio";
+		reg = <0x01c25000 0x100>;
+		#thermal-sensor-cells = <0>;
+		#io-channel-cells = <0>;
+	};
+
+sun4i, sun5i and sun6i SoCs are also supported via the older binding:
+
+sun4i resistive touchscreen controller
+--------------------------------------
+
+Required properties:
+ - compatible: "allwinner,sun4i-a10-ts", "allwinner,sun5i-a13-ts" or
+   "allwinner,sun6i-a31-ts"
+ - reg: mmio address range of the chip
+ - interrupts: interrupt to which the chip is connected
+ - #thermal-sensor-cells: shall be 0
+
+Optional properties:
+ - allwinner,ts-attached	 : boolean indicating that an actual touchscreen
+				   is attached to the controller
+ - allwinner,tp-sensitive-adjust : integer (4 bits)
+				   adjust sensitivity of pen down detection
+				   between 0 (least sensitive) and 15
+				   (defaults to 15)
+ - allwinner,filter-type	 : integer (2 bits)
+				   select median and averaging filter
+				   samples used for median / averaging filter
+				   0: 4/2
+				   1: 5/3
+				   2: 8/4
+				   3: 16/8
+				   (defaults to 1)
+
+Example:
+
+	rtp: rtp@01c25000 {
+		compatible = "allwinner,sun4i-a10-ts";
+		reg = <0x01c25000 0x100>;
+		interrupts = <29>;
+		allwinner,ts-attached;
+		#thermal-sensor-cells = <0>;
+		/* sensitive/noisy touch panel */
+		allwinner,tp-sensitive-adjust = <0>;
+		allwinner,filter-type = <3>;
+	};
-- 
2.9.3

