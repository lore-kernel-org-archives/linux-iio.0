Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34500 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728313AbeKXLKE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 24 Nov 2018 06:10:04 -0500
Received: by mail-qt1-f195.google.com with SMTP id r14so12058521qtp.1
        for <linux-iio@vger.kernel.org>; Fri, 23 Nov 2018 16:23:43 -0800 (PST)
From: Matheus Tavares <matheus.bernardino@usp.br>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        kernel-usp@googlegroups.com, victorcolombo@gmail.com
Subject: [PATCH v3 4/7] dt-bindings:iio:resolver: Add docs for ad2s90
Date: Fri, 23 Nov 2018 22:23:09 -0200
Message-Id: <20181124002312.6923-5-matheus.bernardino@usp.br>
In-Reply-To: <20181124002312.6923-1-matheus.bernardino@usp.br>
References: <20181124002312.6923-1-matheus.bernardino@usp.br>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds the device tree binding documentation for the ad2s90
resolver-to-digital converter.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
Changes in v3:
 - Added reference to spi-bus documentation after spi properties, as
 suggested by Alexandru Ardelean.

Changes in v2:
 - Rewritten 'spi-cpol and spi-cpha' item to say that the device can
 work in either mode (0,0) or (1,1) and explain how they should be
 specified in DT.

 .../bindings/iio/resolver/ad2s90.txt          | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/resolver/ad2s90.txt

diff --git a/Documentation/devicetree/bindings/iio/resolver/ad2s90.txt b/Documentation/devicetree/bindings/iio/resolver/ad2s90.txt
new file mode 100644
index 000000000000..477d41fa6467
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/resolver/ad2s90.txt
@@ -0,0 +1,31 @@
+Analog Devices AD2S90 Resolver-to-Digital Converter
+
+https://www.analog.com/en/products/ad2s90.html
+
+Required properties:
+  - compatible: should be "adi,ad2s90"
+  - reg: SPI chip select number for the device
+  - spi-max-frequency: set maximum clock frequency, must be 830000
+  - spi-cpol and spi-cpha:
+        Either SPI mode (0,0) or (1,1) must be used, so specify none or both of
+        spi-cpha, spi-cpol.
+
+See for more details:
+    Documentation/devicetree/bindings/spi/spi-bus.txt
+
+Note about max frequency:
+    Chip's max frequency, as specified in its datasheet, is 2Mhz. But a 600ns
+    delay is expected between the application of a logic LO to CS and the
+    application of SCLK, as also specified. And since the delay is not
+    implemented in the spi code, to satisfy it, SCLK's period should be at most
+    2 * 600ns, so the max frequency should be 1 / (2 * 6e-7), which gives
+    roughly 830000Hz.
+
+Example:
+resolver@0 {
+	compatible = "adi,ad2s90";
+	reg = <0>;
+	spi-max-frequency = <830000>;
+	spi-cpol;
+	spi-cpha;
+};
-- 
2.18.0
