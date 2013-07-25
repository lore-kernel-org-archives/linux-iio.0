Return-Path: <oleksandr.kozaruk@ti.com>
From: Oleksandr Kozaruk <oleksandr.kozaruk@ti.com>
To: <tony@atomide.com>, <benoit.cousson@linaro.org>, <rnayak@ti.com>,
        <peter.ujfalusi@ti.com>, <kishon@ti.com>, <jic23@cam.ac.uk>,
        <grant.likely@linaro.org>, <rob.herring@calxeda.com>,
        <lars@metafoo.de>, <sameo@linux.intel.com>, <ch.naveen@samsung.com>,
        <poeschel@lemonage.de>, <milo.kim@ti.com>, <balajitk@ti.com>,
        <gg@slimlogic.co.uk>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
Subject: [PATCH v8 1/2] ARM: dts: twl: Add GPADC data to device tree
Date: Thu, 25 Jul 2013 16:26:52 +0300
Message-ID: <1374758813-6539-2-git-send-email-oleksandr.kozaruk@ti.com>
In-Reply-To: <1374758813-6539-1-git-send-email-oleksandr.kozaruk@ti.com>
References: <1374758813-6539-1-git-send-email-oleksandr.kozaruk@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

GPADC is the general purpose ADC present on twl6030.
The dt data is interrupt used to trigger end of ADC
conversion.

Signed-off-by: Oleksandr Kozaruk <oleksandr.kozaruk@ti.com>
---
 arch/arm/boot/dts/twl6030.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/twl6030.dtsi b/arch/arm/boot/dts/twl6030.dtsi
index 2e3bd31..b78e1d5 100644
--- a/arch/arm/boot/dts/twl6030.dtsi
+++ b/arch/arm/boot/dts/twl6030.dtsi
@@ -103,4 +103,10 @@
 		compatible = "ti,twl6030-pwmled";
 		#pwm-cells = <2>;
 	};
+
+	adc {
+		compatible = "ti,twl6030-gpadc";
+		interrupts = <3>;
+		#io-channel-cells = <1>;
+	};
 };
-- 
1.8.1.2
