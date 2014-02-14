Return-Path: <sre@ring0.de>
From: Sebastian Reichel <sre@debian.org>
To: Sebastian Reichel <sre@ring0.de>,
	Marek Belisko <marek@goldelico.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lee Jones <lee.jones@linaro.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Grant Likely <grant.likely@linaro.org>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Sebastian Reichel <sre@debian.org>
Subject: [RFCv1 3/4] Documentation: DT: Document twl4030-madc binding
Date: Fri, 14 Feb 2014 19:46:25 +0100
Message-Id: <1392403586-30540-3-git-send-email-sre@debian.org>
In-Reply-To: <1392403586-30540-1-git-send-email-sre@debian.org>
References: <20140214174040.GB26969@earth.universe>
 <1392403586-30540-1-git-send-email-sre@debian.org>
List-ID: <linux-iio@vger.kernel.org>

Add devicetree binding documentation for twl4030-madc
analog digital converter.

Signed-off-by: Sebastian Reichel <sre@debian.org>
---
 .../devicetree/bindings/iio/adc/twl4030-madc.txt      | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/twl4030-madc.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/twl4030-madc.txt b/Documentation/devicetree/bindings/iio/adc/twl4030-madc.txt
new file mode 100644
index 0000000..d074286
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/twl4030-madc.txt
@@ -0,0 +1,19 @@
+* TWL4030 Monitoring Analog to Digital Converter (MADC)
+
+The MADC subsystem in the TWL4030 consists of a 10-bit ADC
+combined with a 16-input analog multiplexer.
+
+Required properties:
+  - compatible: Should contain "ti,twl4030-madc".
+  - interrupts: IRQ line for the MADC submodule.
+  - #io-channel-cells: Should be set to <1>.
+
+Example:
+
+&twl {
+	madc {
+		compatible = "ti,twl4030-madc";
+		interrupts = <3>;
+		#io-channel-cells = <1>;
+	};
+};
-- 
1.8.5.3
