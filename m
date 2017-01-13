Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:46857 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751392AbdAMJvE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Jan 2017 04:51:04 -0500
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: wsa+renesas@sang-engineering.com, magnus.damm@gmail.com,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, marek.vasut@gmail.com, geert@linux-m68k.org,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v4 2/2] dt-bindings: iio: document MAX11100 ADC
Date: Fri, 13 Jan 2017 10:50:38 +0100
Message-Id: <1484301038-16386-3-git-send-email-jacopo+renesas@jmondi.org>
In-Reply-To: <1484301038-16386-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1484301038-16386-1-git-send-email-jacopo+renesas@jmondi.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add device tree bindings documentation for Maxim MAX11100 single-channel
ADC

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 .../devicetree/bindings/iio/adc/max11100.txt          | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/max11100.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/max11100.txt b/Documentation/devicetree/bindings/iio/adc/max11100.txt
new file mode 100644
index 0000000..ad0bc31
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/max11100.txt
@@ -0,0 +1,19 @@
+* Maxim max11100 Analog to Digital Converter (ADC)
+
+Required properties:
+  - compatible: Should be "maxim,max11100"
+  - reg: the adc unit address
+  - vref-supply: phandle to the regulator that provides reference voltage
+
+Optional properties:
+  - spi-max-frequency: SPI maximum frequency
+
+Example:
+
+max11100: adc@0 {
+        compatible = "maxim,max11100";
+        reg = <0>;
+        vref-supply = <&adc0_vref>;
+        spi-max-frequency = <240000>;
+};
+
-- 
2.7.4

