Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42149 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbeHKXBw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Aug 2018 19:01:52 -0400
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: iio: dac: add bindings for ltc166x
Date: Sat, 11 Aug 2018 22:02:25 +0200
Message-Id: <20180811200226.28776-2-marcus.folkesson@gmail.com>
In-Reply-To: <20180811200226.28776-1-marcus.folkesson@gmail.com>
References: <20180811200226.28776-1-marcus.folkesson@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

LTC1665/LTC1660 is a 8/10-bit Digital-to-Analog Converter (DAC)
with eight individual channels.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 .../devicetree/bindings/iio/dac/ltc166x.txt         | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/ltc166x.txt

diff --git a/Documentation/devicetree/bindings/iio/dac/ltc166x.txt b/Documentation/devicetree/bindings/iio/dac/ltc166x.txt
new file mode 100644
index 000000000000..c5b5f22d6c64
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/ltc166x.txt
@@ -0,0 +1,21 @@
+* Linear Technology Micropower octal 8-Bit and 10-Bit DACs
+
+Required properties:
+ - compatible: Must be one of the following:
+		"lltc,ltc1660"
+		"lltc,ltc1665"
+ - reg: SPI chip select number for the device
+ - vref-supply: Phandle to the voltage reference supply
+
+Recommended properties:
+ - spi-max-frequency: Definition as per
+	 Documentation/devicetree/bindings/spi/spi-bus.txt.
+	 Max frequency for this chip is 5 MHz.
+
+Example:
+dac@0 {
+	compatible = "lltc,ltc1660";
+	reg = <0>;
+	spi-max-frequency = <5000000>;
+	vref-supply = <&vref_reg>;
+};
-- 
2.11.0.rc2
