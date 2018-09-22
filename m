Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io1-f66.google.com ([209.85.166.66]:44070 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727864AbeIWCxl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 Sep 2018 22:53:41 -0400
From: ryang <decatf@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ryang <decatf@gmail.com>
Subject: [PATCH v3 1/2] dt-bindings: iio: light: bh1750: Add device tree binding documentation
Date: Sat, 22 Sep 2018 16:57:53 -0400
Message-Id: <20180922205754.6100-1-decatf@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Document device tree bindings for ROHM BH1750 ambient light sensor driver.

Signed-off-by: ryang <decatf@gmail.com>
---
 .../devicetree/bindings/iio/light/bh1750.txt   | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/bh1750.txt

diff --git a/Documentation/devicetree/bindings/iio/light/bh1750.txt b/Documentation/devicetree/bindings/iio/light/bh1750.txt
new file mode 100644
index 000000000000..468350cc7af6
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/bh1750.txt
@@ -0,0 +1,18 @@
+ROHM BH1750 - ALS, Ambient light sensor
+
+Required properties:
+
+- compatible: Must be one of:
+    "rohm,bh1710"
+    "rohm,bh1715"
+    "rohm,bh1721"
+    "rohm,bh1750"
+    "rohm,bh1751"
+- reg: the I2C address of the sensor
+
+Example:
+
+bh1750@23 {
+	compatible = "rohm,bh1750";
+	reg = <0x23>;
+};
-- 
2.17.1
