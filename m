Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34518 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750841AbeDTTa7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Apr 2018 15:30:59 -0400
Date: Fri, 20 Apr 2018 21:30:54 +0200
From: David Veenstra <davidjulianveenstra@gmail.com>
To: lars@metafoo.de, jic23@kernel.org, pmeerw@pmeerw.net
Cc: robh+dt@kernel.org, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        daniel.baluta@nxp.com, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, devicetree@vger.kernel.org
Subject: [PATCH v2 09/13] staging: iio: ad2s1200: Add documentation for
 device tree binding
Message-ID: <2b0596e9dd109a8ea949c38d9e9abb0e38e8bc5e.1524247563.git.davidjulianveenstra@gmail.com>
References: <cover.1524247563.git.davidjulianveenstra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1524247563.git.davidjulianveenstra@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add documentation for the added device tree bindings.

Signed-off-by: David Veenstra <davidjulianveenstra@gmail.com>
---
Changes in v2:
  - Introduced in this version.

 .../bindings/staging/iio/resolver/ad2s1200.txt           | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/staging/iio/resolver/ad2s1200.txt

diff --git a/Documentation/devicetree/bindings/staging/iio/resolver/ad2s1200.txt b/Documentation/devicetree/bindings/staging/iio/resolver/ad2s1200.txt
new file mode 100644
index 000000000000..85c009987878
--- /dev/null
+++ b/Documentation/devicetree/bindings/staging/iio/resolver/ad2s1200.txt
@@ -0,0 +1,16 @@
+Analog Devices AD2S1200 Resolver-to-Digital Converter
+
+Required properties:
+ - compatible : should be "adi,ad2s1200"
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

