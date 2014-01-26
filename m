Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from am1ehsobe006.messaging.microsoft.com ([213.199.154.209]:20439
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751174AbaAZGRl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jan 2014 01:17:41 -0500
From: Fugang Duan <B38611@freescale.com>
To: <jic23@kernel.org>
CC: <shawn.guo@linaro.org>, <sachin.kamat@linaro.org>,
	<pmeerw@pmeerw.net>, <lars@metafoo.de>, <mark.rutland@arm.com>,
	<linux-iio@vger.kernel.org>
Subject: [PATCH v5 3/3] Documentation: add the binding file for Freescale vf610 ADC driver
Date: Sun, 26 Jan 2014 13:39:33 +0800
Message-ID: <1390714773-23066-4-git-send-email-B38611@freescale.com>
In-Reply-To: <1390714773-23066-1-git-send-email-B38611@freescale.com>
References: <1390714773-23066-1-git-send-email-B38611@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The patch adds the binding file for Freescale vf610 ADC driver.

CC: Shawn Guo <shawn.guo@linaro.org>
CC: Jonathan Cameron <jic23@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>
CC: Otavio Salvador <otavio@ossystems.com.br>
CC: Peter Meerwald <pmeerw@pmeerw.net>
CC: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Fugang Duan <B38611@freescale.com>
---
 .../devicetree/bindings/iio/adc/vf610-adc.txt      |   22 ++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/vf610-adc.txt b/Documentation/devicetree/bindings/iio/adc/vf610-adc.txt
new file mode 100644
index 0000000..dcebff1
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/vf610-adc.txt
@@ -0,0 +1,22 @@
+Freescale vf610 Analog to Digital Converter bindings
+
+The devicetree bindings are for the new ADC driver written for
+vf610/i.MX6slx and upward SoCs from Freescale.
+
+Required properties:
+- compatible: Should contain "fsl,vf610-adc"
+- reg: Offset and length of the register set for the device
+- interrupts: Should contain the interrupt for the device
+- clocks: The clock is needed by the ADC controller, ADC clock source is ipg clock.
+- clock-names: Must contain "adc", matching entry in the clocks property.
+- vref-supply: The regulator supply ADC refrence voltage.
+
+Example:
+adc0: adc@4003b000 {
+	compatible = "fsl,vf610-adc";
+	reg = <0x4003b000 0x1000>;
+	interrupts = <0 53 0x04>;
+	clocks = <&clks VF610_CLK_ADC0>;
+	clock-names = "adc";
+	vref-supply = <&reg_vcc_3v3_mcu>;
+};
-- 
1.7.2.rc3


