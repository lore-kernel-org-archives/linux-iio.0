Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:42975 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753612AbeDVWDw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Apr 2018 18:03:52 -0400
Date: Mon, 23 Apr 2018 00:03:47 +0200
From: David Veenstra <davidjulianveenstra@gmail.com>
To: jic23@kernel.org, lars@metafoo.de, pmeerw@pmeerw.net
Cc: robh+dt@kernel.org, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        linux-iio@vger.kernel.org, daniel.baluta@nxp.com,
        devel@driverdev.osuosl.org, devicetree@vger.kernel.org
Subject: [PATCH v3 5/9] staging: iio: ad2s1200: Add documentation for device
 tree binding
Message-ID: <0aa68c6684c2b45dd0af398c166d6b36c18be1af.1524432236.git.davidjulianveenstra@gmail.com>
References: <cover.1524432236.git.davidjulianveenstra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1524432236.git.davidjulianveenstra@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add documentation for the added device tree bindings.

Signed-off-by: David Veenstra <davidjulianveenstra@gmail.com>
---
Changes in v3:
 - Documentation is added to Documentation/devicetree/bindings/iio/resolver
   instead of staging directory.
 - Add mention to ad2s1205 device.

 .../devicetree/bindings/iio/resolver/ad2s1200.txt        | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/resolver/ad2s1200.txt

diff --git a/Documentation/devicetree/bindings/iio/resolver/ad2s1200.txt b/Documentation/devicetree/bindings/iio/resolver/ad2s1200.txt
new file mode 100644
index 000000000000..46b51db38368
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/resolver/ad2s1200.txt
@@ -0,0 +1,16 @@
+Analog Devices AD2S1200 and AD2S1205 Resolver-to-Digital Converter
+
+Required properties:
+ - compatible : should be "adi,ad2s1200" or "adi,ad2s1205"
+ - reg : the SPI chip select number of the device
+ - sample-gpios : The GPIO pin connected to the SAMPLE line of the AD2S1200
+ - rdvel-gpios : The GPIO pin connected to the RDVEL line of the AD2S1200
+
+Example:
+
+	resolver {
+		compatible = "adi,ad2s1200";
+		reg = <4>;
+		sample-gpios = <&gpio 5 GPIO_ACTIVE_HIGH>;
+		rdvel-gpios = <&gpio 6 GPIO_ACTIVE_HIGH>;
+	};
-- 
2.16.2

