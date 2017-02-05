Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34421 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751442AbdBEPEn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Feb 2017 10:04:43 -0500
From: Tomasz Duszynski <tduszyns@gmail.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com
Subject: [PATCH 4/4] iio: chemical: add dsm501 particle sensor driver bindings
Date: Sun,  5 Feb 2017 16:03:44 +0100
Message-Id: <20170205150344.11000-1-tduszyns@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds bindings for dsm501 particle sensor driver.

Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
---
 .../devicetree/bindings/iio/chemical/dsm501.txt          | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/dsm501.txt

diff --git a/Documentation/devicetree/bindings/iio/chemical/dsm501.txt b/Documentation/devicetree/bindings/iio/chemical/dsm501.txt
new file mode 100644
index 000000000000..918c55c4c401
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/chemical/dsm501.txt
@@ -0,0 +1,16 @@
+* DSM501 particle sensor
+
+Required properties:
+
+- compatible: should be one of:
+	      "samyoung,dsm501"
+	      "shinyei,ppd42ns"
+- gpios: should specify the GPIO connected to the sensor's data line, see
+  	 "gpios property" in Documentation/devicetree/bindings/gpio/gpio.txt
+
+Example:
+
+dsm501 {
+	compatible = "samyoung,dsm501";
+	gpios = <&gpio1 28 0>;
+};
-- 
2.11.1

