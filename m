Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:54326 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752084AbbEDJG3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 4 May 2015 05:06:29 -0400
From: Antoine Tenart <antoine.tenart@free-electrons.com>
To: sebastian.hesselbarth@gmail.com, jic23@kernel.org, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net
Cc: Antoine Tenart <antoine.tenart@free-electrons.com>,
	zmxu@marvell.com, jszhang@marvell.com, yrliao@marvell.com,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] Documentation: bindings: document the Berlin ADC driver
Date: Mon,  4 May 2015 11:06:23 +0200
Message-Id: <1430730384-11318-3-git-send-email-antoine.tenart@free-electrons.com>
In-Reply-To: <1430730384-11318-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1430730384-11318-1-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Following the addition of a Berlin ADC driver, this patch adds the
corresponding bindings documentation.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
 .../devicetree/bindings/iio/adc/berlin2_adc.txt       | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/berlin2_adc.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/berlin2_adc.txt b/Documentation/devicetree/bindings/iio/adc/berlin2_adc.txt
new file mode 100644
index 000000000000..908334c6b07f
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/berlin2_adc.txt
@@ -0,0 +1,19 @@
+* Berlin Analog to Digital Converter (ADC)
+
+The Berlin ADC has 8 channels, with one connected to a temperature sensor.
+It is part of the system controller register set. The ADC node should be a
+sub-node of the system controller node.
+
+Required properties:
+- compatible: must be "marvell,berlin2-adc"
+- interrupts: the interrupts for the ADC and the temperature sensor
+- interrupt-names: should be "adc" and "tsen"
+
+Example:
+
+adc: adc {
+	compatible = "marvell,berlin2-adc";
+	interrupt-parent = <&sic>;
+	interrupts = <12>, <14>;
+	interrupt-names = "adc", "tsen";
+};
-- 
2.4.0

