Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:19296 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755603AbaJ2Upo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 29 Oct 2014 16:45:44 -0400
From: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
To: <linux-iio@vger.kernel.org>, <lars@metafoo.de>, <jic23@kernel.org>,
	<Naidu.Tellapati@imgtec.com>, <james.hartley@imgtec.com>,
	<abrestic@chromium.org>
CC: Phani Movva <Phani.Movva@imgtec.com>,
	Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Subject: [PATCH 2/2] DT: iio: adc: Add CC_10001 binding documentation
Date: Wed, 29 Oct 2014 20:45:31 +0000
Message-ID: <1414615531-26172-3-git-send-email-ezequiel.garcia@imgtec.com>
In-Reply-To: <1414615531-26172-1-git-send-email-ezequiel.garcia@imgtec.com>
References: <1414615531-26172-1-git-send-email-ezequiel.garcia@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Phani Movva <Phani.Movva@imgtec.com>

Add the devicetree binding document for Cosmic Circuits 10001 ADC device.

Signed-off-by: Phani Movva <Phani.Movva@imgtec.com>
Signed-off-by: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
[Ezequiel: minor style cleaning]
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
---
 .../devicetree/bindings/iio/adc/cc_10001_adc.txt      | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/cc_10001_adc.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/cc_10001_adc.txt b/Documentation/devicetree/bindings/iio/adc/cc_10001_adc.txt
new file mode 100644
index 0000000..6491839
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/cc_10001_adc.txt
@@ -0,0 +1,19 @@
+* Cosmic Circuits - Analog to Digital Converter (CC-10001-ADC)
+
+Required properties:
+  - compatible: Should be "cosmic,10001-adc"
+  - reg: Should contain adc registers location and length.
+  - cosmic,adc-available-channels: Bitmask of the channels currently enabled.
+  - clock-names: Should contain "adc".
+  - clocks: phandles to input clocks.
+  - vref-supply: The regulator supply ADC reference voltage.
+
+Example:
+adc: adc@18101600 {
+	compatible = "cosmic,10001-adc";
+	reg = <0x18101600 0x24>;
+	cosmic,adc-available-channels = <0xa>;
+	clocks = <&adc_clk>;
+	clock-names = "adc";
+	vref-supply = <&reg_1v8>;
+};
-- 
2.1.2

