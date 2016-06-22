Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:35961 "EHLO
	mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453AbcFVPLx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 22 Jun 2016 11:11:53 -0400
Received: by mail-lf0-f46.google.com with SMTP id q132so76461611lfe.3
        for <linux-iio@vger.kernel.org>; Wed, 22 Jun 2016 08:11:27 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	devicetree@vger.kernel.org, Samu Onkalo <samu.p.onkalo@nokia.com>
Subject: [PATCH 1/2] iio: magn: DT bindings for AK8974
Date: Wed, 22 Jun 2016 17:11:16 +0200
Message-Id: <1466608276-10401-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This adds device tree bindings for the AK8974 magnetometer, similar
to those for the AK8975.

Cc: devicetree@vger.kernel.org
Cc: Samu Onkalo <samu.p.onkalo@nokia.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../bindings/iio/magnetometer/ak8974.txt           | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/ak8974.txt

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/ak8974.txt b/Documentation/devicetree/bindings/iio/magnetometer/ak8974.txt
new file mode 100644
index 000000000000..967f8e9b9319
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/magnetometer/ak8974.txt
@@ -0,0 +1,28 @@
+* Asahi Kasei AK8974 magnetometer sensor
+
+Required properties:
+
+- compatible : should be "asahi-kasei,ak8974"
+- reg : the I2C address of the magnetometer
+
+Optional properties:
+
+- avdd-supply: regulator supply for the analog voltage
+  (see regulator/regulator.txt)
+- dvdd-supply: regulator supply for the digital voltage
+  (see regulator/regulator.txt)
+- interrupts: data ready (DRDY) and interrupt (INT1) lines
+  from the chip, the DRDY interrupt must be placed first.
+  The interrupts can be triggered on rising or falling
+  edges alike.
+
+Example:
+
+ak8974@0f {
+	compatible = "asahi-kasei,ak8974";
+	reg = <0x0f>;
+	avdd-supply = <&foo_reg>;
+	dvdd-supply = <&bar_reg>;
+	interrupts = <0 IRQ_TYPE_EDGE_RISING>,
+		     <1 IRQ_TYPE_EDGE_RISING>;
+};
-- 
2.4.11

