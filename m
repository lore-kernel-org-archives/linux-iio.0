Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34407 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751562AbdBIROi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Feb 2017 12:14:38 -0500
From: Tomasz Duszynski <tduszyns@gmail.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com
Subject: [PATCH v2 4/4] iio: chemical: add dsm501 particle sensor driver bindings
Date: Thu,  9 Feb 2017 18:12:52 +0100
Message-Id: <20170209171252.4802-1-tduszyns@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds bindings for dsm501 particle sensor driver.

Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
---
 Changes in v2:
  o add 'data' prefix to gpios property

 .../devicetree/bindings/iio/chemical/dsm501.txt          | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/dsm501.txt

diff --git a/Documentation/devicetree/bindings/iio/chemical/dsm501.txt b/Documentation/devicetree/bindings/iio/chemical/dsm501.txt
new file mode 100644
index 000000000000..126ce528f5eb
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
+- data-gpios: should specify the GPIO connected to the sensor's data line, see
+	      "gpios property" in Documentation/devicetree/bindings/gpio/gpio.txt
+
+Example:
+
+dsm501 {
+	compatible = "samyoung,dsm501";
+	data-gpios = <&gpio1 28 0>;
+};
--
2.11.1

