Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54217 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751156AbeERSWy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 May 2018 14:22:54 -0400
Date: Fri, 18 May 2018 20:22:50 +0200
From: David Veenstra <davidjulianveenstra@gmail.com>
To: jic23@kernel.org, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org
Cc: Michael.Hennerich@analog.com, knaack.h@gmx.de,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 08/12] dt-bindings: iio: resolver: Document AD2S1200
 bindings
Message-ID: <cbe0f4194cca49c303fbe62b215bfaf0af6e2bbb.1526667118.git.davidjulianveenstra@gmail.com>
References: <cover.1526667118.git.davidjulianveenstra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1526667118.git.davidjulianveenstra@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add documentation for the device tree bindings of the AD2S1200 resolver.

Signed-off-by: David Veenstra <davidjulianveenstra@gmail.com>
---
Changes in v4:
 - Added vendor prefix to gpio function name.
 - Added unit address.
 - Changed commit subject to be more inline with other dt-bindings
   commit .

 .../bindings/iio/resolver/ad2s1200.txt           | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/resolver/ad2s1200.txt

diff --git a/Documentation/devicetree/bindings/iio/resolver/ad2s1200.txt b/Documentation/devicetree/bindings/iio/resolver/ad2s1200.txt
new file mode 100644
index 000000000000..bbf54260c911
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/resolver/ad2s1200.txt
@@ -0,0 +1,16 @@
+Analog Devices AD2S1200 and AD2S1205 Resolver-to-Digital Converter
+
+Required properties:
+ - compatible : should be "adi,ad2s1200" or "adi,ad2s1205"
+ - reg : the SPI chip select number of the device
+ - adi,sample-gpios : The GPIO pin connected to the SAMPLE line of the AD2S1200
+ - adi,rdvel-gpios : The GPIO pin connected to the RDVEL line of the AD2S1200
+
+Example:
+
+	resolver@0 {
+		compatible = "adi,ad2s1200";
+		reg = <4>;
+		adi,sample-gpios = <&gpio 5 GPIO_ACTIVE_HIGH>;
+		adi,rdvel-gpios = <&gpio 6 GPIO_ACTIVE_HIGH>;
+	};
-- 
2.17.0

