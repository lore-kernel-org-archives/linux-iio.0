Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42487 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728939AbeJWFYL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 Oct 2018 01:24:11 -0400
Received: by mail-ed1-f66.google.com with SMTP id b7-v6so39296114edd.9
        for <linux-iio@vger.kernel.org>; Mon, 22 Oct 2018 14:04:01 -0700 (PDT)
From: Charles-Antoine Couret <charles-antoine.couret@essensium.com>
To: linux-iio@vger.kernel.org
Cc: Charles-Antoine Couret <charles-antoine.couret@essensium.com>,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Subject: [PATCH V3 2/2] doc:devicetree: Add ti,dac7311 device tree bindings in documentation
Date: Mon, 22 Oct 2018 23:03:40 +0200
Message-Id: <20181022210340.1136-2-charles-antoine.couret@essensium.com>
In-Reply-To: <20181022210340.1136-1-charles-antoine.couret@essensium.com>
References: <20181022210340.1136-1-charles-antoine.couret@essensium.com>
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Description how to invoke ti-dac7311 driver from device tree file.

Signed-off-by: Charles-Antoine Couret <charles-antoine.couret@essensium.com>
---

V1 to V3:
* Cosmetic changes
* Improve description of the patch

 .../bindings/iio/dac/ti,dac7311.txt           | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/ti,dac7311.txt

diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac7311.txt b/Documentation/devicetree/bindings/iio/dac/ti,dac7311.txt
new file mode 100644
index 000000000000..b681060579b4
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/ti,dac7311.txt
@@ -0,0 +1,20 @@
+TI DAC7311 device tree bindings
+
+Required properties:
+
+- compatible: Must be set to "ti,dac7311", "ti,dac6311" or "ti,dac5311"
+- reg: spi chip select number for the device
+- vref-supply: The regulator supply for ADC reference voltage
+- spi-max-frequency: Max SPI frequency to use (< 50000000)
+
+Example:
+
+	spi_master {
+		dac: dac7311@0 {
+			compatible = "ti,dac7311";
+			reg = <0>; /* CS0 */
+			spi-max-frequency = <1000000>;
+			vref-supply = <&vdd_supply>;
+		};
+	};
+
-- 
2.19.1
