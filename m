Return-Path: <MAILER-DAEMON>
From: "Andrew F. Davis" <afd@ti.com>
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark
 Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter
 Meerwald <pmeerw@pmeerw.net>
CC: <devicetree@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-api@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Andrew F.
 Davis" <afd@ti.com>
Subject: [PATCH v3 4/5] Documentation: afe4403: Add DT bindings for the AFE4403 heart monitor
Date: Mon, 14 Dec 2015 16:36:00 -0600
Message-ID: <1450132561-5245-5-git-send-email-afd@ti.com>
In-Reply-To: <1450132561-5245-1-git-send-email-afd@ti.com>
References: <1450132561-5245-1-git-send-email-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Add the TI AFE4403 heart monitor DT bindings documentation.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 .../devicetree/bindings/iio/health/afe4403.txt     | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/health/afe4403.txt

diff --git a/Documentation/devicetree/bindings/iio/health/afe4403.txt b/Documentation/devicetree/bindings/iio/health/afe4403.txt
new file mode 100644
index 0000000..2fffd70
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/health/afe4403.txt
@@ -0,0 +1,34 @@
+Texas Instruments AFE4403 Heart rate and Pulse Oximeter
+
+Required properties:
+ - compatible		: Should be "ti,afe4403".
+ - reg			: SPI chip select address of device.
+ - tx-supply		: Regulator supply to transmitting LEDs.
+ - interrupt-parent	: Phandle to he parent interrupt controller.
+ - interrupts		: The interrupt line the device ADC_RDY pin is
+			  connected to. For details refer to,
+			  ../../interrupt-controller/interrupts.txt.
+
+Optional properties:
+ - reset-gpios		: GPIO used to reset the device.
+			  For details refer to, ../../gpio/gpio.txt.
+
+For other required and optional properties of SPI slave nodes
+please refer to ../../spi/spi-bus.txt.
+
+Example:
+
+&spi0 {
+	heart_mon@0 {
+		compatible = "ti,afe4403";
+		reg = <0>;
+		spi-max-frequency = <10000000>;
+
+		tx-supply = <&vbat>;
+
+		interrupt-parent = <&gpio1>;
+		interrupts = <28 IRQ_TYPE_EDGE_RISING>;
+
+		reset-gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
+	};
+};
-- 
2.6.4
