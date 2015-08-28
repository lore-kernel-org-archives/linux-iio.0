Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:33364 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752509AbbH1O2e (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 28 Aug 2015 10:28:34 -0400
Received: by wieo17 with SMTP id o17so17690692wie.0
        for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2015 07:28:33 -0700 (PDT)
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
Subject: [PATCH v5 2/2] dt: Document Holt HI-8435 bindings
Date: Fri, 28 Aug 2015 17:28:20 +0300
Message-Id: <1440772100-3115-1-git-send-email-vladimir.barinov@cogentembedded.com>
In-Reply-To: <1440772029-3022-1-git-send-email-vladimir.barinov@cogentembedded.com>
References: <1440772029-3022-1-git-send-email-vladimir.barinov@cogentembedded.com>
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
Changes in version 3:
- none
Changes in version 4:
- removed debounce_interval property
- removed reset-gpios to use GPIO descriptor API
Changes in version 5:
- none

 .../devicetree/bindings/iio/adc/hi8435.txt          | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/hi8435.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/hi8435.txt b/Documentation/devicetree/bindings/iio/adc/hi8435.txt
new file mode 100644
index 0000000..3b0348c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/hi8435.txt
@@ -0,0 +1,21 @@
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
+ - gpios: GPIO used for controlling the reset pin
+
+Example:
+sensor@0 {
+	compatible = "holt,hi8435";
+	reg = <0>;
+	gpios = <&gpio6 1 0>;
+
+	spi-max-frequency = <1000000>;
+};
-- 
1.9.1

