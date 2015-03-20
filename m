Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:38374 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751337AbbCTNg3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 20 Mar 2015 09:36:29 -0400
From: Antoine Tenart <antoine.tenart@free-electrons.com>
To: sebastian.hesselbarth@gmail.com, jic23@kernel.org, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net
Cc: Antoine Tenart <antoine.tenart@free-electrons.com>,
	zmxu@marvell.com, jszhang@marvell.com, yrliao@marvell.com,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] Documentation: bindings: document the Berlin ADC driver
Date: Fri, 20 Mar 2015 14:36:03 +0100
Message-Id: <1426858565-31053-3-git-send-email-antoine.tenart@free-electrons.com>
In-Reply-To: <1426858565-31053-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1426858565-31053-1-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Following the addition of a Berlin ADC driver, this patch adds the
corresponding bindings documentation.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
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
2.3.3

