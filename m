Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:36679 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754823AbbG0XHK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jul 2015 19:07:10 -0400
Received: by wicgb10 with SMTP id gb10so132373384wic.1
        for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2015 16:07:09 -0700 (PDT)
From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, cory.tusar@pid1solutions.com
Subject: [PATCH v2 3/5] dt: Document Holt HI-8435 bindings
Date: Tue, 28 Jul 2015 02:07:05 +0300
Message-Id: <1438038425-13004-1-git-send-email-vladimir.barinov@cogentembedded.com>
In-Reply-To: <1438038300-12855-1-git-send-email-vladimir.barinov@cogentembedded.com>
References: <1438038300-12855-1-git-send-email-vladimir.barinov@cogentembedded.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

These bindings can be used to register Holt HI-8435 threshold detector

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
---
Changes in version 2:
- renamed file name hi-843x.txt to hi8435.txt
- removed hi-8436,hi-8436,hi-8437
- removed holt,debounce-soft field
- renamed holt,debounc-soft-delay to holt,debounce-interval
- renamed mr-gpio to reset-gpios

 .../devicetree/bindings/iio/adc/hi8435.txt         | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/hi8435.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/hi8435.txt b/Documentation/devicetree/bindings/iio/adc/hi8435.txt
new file mode 100644
index 0000000..1d33ad0
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/hi8435.txt
@@ -0,0 +1,25 @@
+Holt Integrated Circuits HI-8435 threshold detector bindings
+
+Required properties:
+ - compatible: should be "holt,hi8435"
+ - reg: spi chip select number for the device
+
+Recommended properties:
+ - spi-max-frequency: definition as per
+		Documentation/devicetree/bindings/spi/spi-bus.txt
+
+Optional properties:
+ - holt,reset-gpios: GPIO used for controlling the reset pin
+ - holt,debounce-interval: software debounce interval in milliseconds
+
+Example:
+sensor@0 {
+	compatible = "holt,hi8435";
+	reg = <0>;
+
+	holt,reset-gpios = <&gpio6 1 0>;
+
+	holt,debounce-interval = <100>;
+
+	spi-max-frequency = <1000000>;
+};
-- 
1.9.1

