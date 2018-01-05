Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-by2nam03on0054.outbound.protection.outlook.com ([104.47.42.54]:6833
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751514AbeAEP2q (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 5 Jan 2018 10:28:46 -0500
Received: from NWD2HUBCAS9.ad.analog.com (nwd2hubcas9.ad.analog.com [10.64.69.109])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id w05FSg0e016590
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
        for <linux-iio@vger.kernel.org>; Fri, 5 Jan 2018 07:28:42 -0800
From: <alexandru.ardelean@analog.com>
To: <linux-iio@vger.kernel.org>
CC: <michael.hennerich@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 2/2][V2] staging:iio:docs: add ad7192 doc to detail dt usage
Date: Fri, 5 Jan 2018 17:28:26 +0200
Message-ID: <20180105152826.12076-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Alexandru Ardelean <alexandru.ardelean@analog.com>

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/staging/iio/Documentation/adc/ad7192.txt | 60 ++++++++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 drivers/staging/iio/Documentation/adc/ad7192.txt

diff --git a/drivers/staging/iio/Documentation/adc/ad7192.txt b/drivers/staging/iio/Documentation/adc/ad7192.txt
new file mode 100644
index 000000000000..19efc0a9411c
--- /dev/null
+++ b/drivers/staging/iio/Documentation/adc/ad7192.txt
@@ -0,0 +1,60 @@
+Analog Devices AD719x ADC Driver
+
+1. Overview
+
+The driver is intended to work with all AD719x ADC chips
+from Analog Devices (AD7190, AD7192, AD7193, AD7195).
+
+It's based on top of the AD Sigma Delta driver
+
+2. Device Tree Configuration
+
+Example for use on a Raspberry Pi with interrupt line
+connected to PIN 25 on the GPIO:
+
+	adc_vref: fixedregulator@0 {
+		reg = <0>;
+
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-supply";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+	};
+
+	ad7190@0 {
+		compatible = "ad7190";
+		reg = <0>;
+		spi-max-frequency = <1000000>;
+		spi-cpol;
+		spi-cpha;
+
+		#interrupt-cells = <2>;
+		interrupts = <25 0x2>;
+		interrupt-parent = <&gpio>;
+		avdd-supply = <&adc_vref>;
+
+		adi,clock-source-select = /bits/ 8 <0>;
+		adi,reference-voltage-mv = /bits/ 16 <3300>;
+
+		adi,refin2-pins-enable;
+		adi,rejection-60-Hz-enable;
+		adi,chop-enable;
+		adi,buffer-enable;
+		adi,burnout-currents-enable;
+		adi,sinc3-filter-enable;
+		adi,unipolar-enable;
+	};
+
+Notes (about this example):
+* be sure to replace `compatible = "ad7190";` with
+  your actual chip model (ad7190, ad7192, ad7193, ad7195)
+  in order to make sure it works correctly
+* PIN 25 must also be connected also to the DOUT pin
+  of the ADC (or MISO on the host)
+* be sure to add the "/bits/" specifiers ; newer dtc versions
+  specify the property type/size using this field,
+  and the driver may not be able to find the property
+* not all "adi,xxx" parameters are required ;
+  see the datasheet to get an idea of what you need
+
-- 
2.14.1

