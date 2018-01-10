Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-sn1nam02on0074.outbound.protection.outlook.com ([104.47.36.74]:54948
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932174AbeAJLal (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 10 Jan 2018 06:30:41 -0500
From: <alexandru.ardelean@analog.com>
To: <linux-iio@vger.kernel.org>, <michael.hennerich@analog.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC: <devicetree@vger.kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 3/3] staging: iio: docs: add ad7192 doc to detail dt usage
Date: Wed, 10 Jan 2018 13:29:56 +0200
Message-ID: <20180110112956.23931-3-alexandru.ardelean@analog.com>
In-Reply-To: <20180110112956.23931-1-alexandru.ardelean@analog.com>
References: <20180110112956.23931-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Alexandru Ardelean <alexandru.ardelean@analog.com>

Document the device-tree bindings of the "ad7192" driver.
Added datasheet references for supported devices,
explanation for each property supported by the driver,
and an example.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 .../staging/iio/Documentation/adc/adi,ad7192.txt   | 71 ++++++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 drivers/staging/iio/Documentation/adc/adi,ad7192.txt

diff --git a/drivers/staging/iio/Documentation/adc/adi,ad7192.txt b/drivers/staging/iio/Documentation/adc/adi,ad7192.txt
new file mode 100644
index 000000000000..1f8f769a003f
--- /dev/null
+++ b/drivers/staging/iio/Documentation/adc/adi,ad7192.txt
@@ -0,0 +1,71 @@
+Analog Devices AD719x ADC Driver
+
+Reference:
+[1] http://www.analog.com/en/products/analog-to-digital-converters/ad7190.html
+[2] http://www.analog.com/en/products/analog-to-digital-converters/ad7192.html
+[3] http://www.analog.com/en/products/analog-to-digital-converters/ad7193.html
+[4] http://www.analog.com/en/products/analog-to-digital-converters/ad7195.html
+
+Required properties:
+  - compatible: Should be "adi,ad7190", "adi,ad7192", "adi,ad7193"
+  or "adi,ad7195"
+  - reg: SPI chip select number for the device
+  - spi-cpol, spi-cpha: Controller support only mode 3, so both spi-cpol
+  and spi-cpha should be present
+  - spi-max-frequency: Definition as per
+  see: Documentation/devicetree/bindings/spi/spi-bus.txt
+  - interrupt-parent: phandle to the parent interrupt controller
+  see: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
+  - interrupts: IRQ line for the ADC
+  see: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
+
+Recommended properties:
+  - adi,clock-source-select: sets the clock source to be used; values are
+   * 0 - external crystal, connected from pin MCLK1 to MCLK2
+   * 1 - external clock, applied to MCLK2 pin
+   * 2 - internal 4.92 Mhz clock; pin MCLK2 is tristated (default)
+   * 3 - internal 4.92 Mhz clock; internal clock is available on MCLK2
+  - adi,external-clock-Hz: if "adi,clock-source-select" is value '1',
+  this value should be specified to the ADC
+  - avdd-supply: Analog Supply Voltage, 4.75V to 5.25V. AVDD is
+  independent of DVDD
+  - dvdd-supply: Digital Supply Voltage, 2.7V to 5.25V. DVDD
+  is independent of AVDD
+
+Optional properties:
+  - adi,refin2-pins-enable: select external reference to be applied
+  to P1,REFIN2(+) & P0,REFIN2(-) pins instead of REFIN1(+) & REFIN1(-);
+  not available for "ad7195"
+  - adi,rejection-60-Hz-enable: enables simultaneous 50/60 Hz rejection
+  - adi,chop-enable: enable chop to minimize ADC offset and offset drift
+  - adi,buffer-enable: enables the buffer on the analog inputs
+  - adi,burnout-currents-enable: when selected, the 500 nA current sources
+  in the signal path are enabled; can be enabled only when buffer is active
+  and chop is disabled
+  - adi,sinc3-filter-enable: enables the SINC3 filter; if unset
+  the SINC4 digital filter is used after the modulator
+  - adi,unipolar-enable: when this is set voltage ranges must be unipolar
+  (e.g 0 to 5V) versus bipolar voltage ranges (e.g. -5V to 5V)
+
+Example:
+ad7190@0 {
+	compatible = "adi,ad7190";
+	reg = <0>;
+	spi-max-frequency = <1000000>;
+	spi-cpol;
+	spi-cpha;
+
+	#interrupt-cells = <2>;
+	interrupts = <25 0x2>;
+	interrupt-parent = <&gpio>;
+	avdd-supply = <&adc_avdd>;
+
+	adi,clock-source-select = /bits/ 8 <0>;
+
+	adi,refin2-pins-enable;
+	adi,rejection-60-Hz-enable;
+	adi,buffer-enable;
+	adi,burnout-currents-enable;
+	adi,sinc3-filter-enable;
+	adi,unipolar-enable;
+};
-- 
2.14.1

