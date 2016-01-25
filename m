Return-Path: <MAILER-DAEMON>
From: "Andrew F. Davis" <afd@ti.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>, Dan
 Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>, Pawel Moll
	<pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell
	<ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>
CC: <linux-iio@vger.kernel.org>, <linux-api@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Andrew F.
 Davis" <afd@ti.com>
Subject: [PATCH v4 1/4] Documentation: afe4404: Add DT bindings for the AFE4404 heart monitor
Date: Mon, 25 Jan 2016 11:28:58 -0600
Message-ID: <1453742941-12086-2-git-send-email-afd@ti.com>
In-Reply-To: <1453742941-12086-1-git-send-email-afd@ti.com>
References: <1453742941-12086-1-git-send-email-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Add the TI afe4404 heart monitor DT bindings documentation.
Create health directory created under iio.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 .../devicetree/bindings/iio/health/afe4404.txt     | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/health/afe4404.txt

diff --git a/Documentation/devicetree/bindings/iio/health/afe4404.txt b/Documentation/devicetree/bindings/iio/health/afe4404.txt
new file mode 100644
index 0000000..de69f20
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/health/afe4404.txt
@@ -0,0 +1,30 @@
+Texas Instruments AFE4404 Heart rate and Pulse Oximeter
+
+Required properties:
+ - compatible		: Should be "ti,afe4404".
+ - reg			: I2C address of the device.
+ - tx-supply		: Regulator supply to transmitting LEDs.
+ - interrupt-parent	: Phandle to he parent interrupt controller.
+ - interrupts		: The interrupt line the device ADC_RDY pin is
+			  connected to. For details refer to,
+			  ../interrupt-controller/interrupts.txt.
+
+Optional properties:
+ - reset-gpios		: GPIO used to reset the device.
+			  For details refer to, ../gpio/gpio.txt.
+
+Example:
+
+&i2c2 {
+	heart_mon@58 {
+		compatible = "ti,afe4404";
+		reg = <0x58>;
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
2.7.0
