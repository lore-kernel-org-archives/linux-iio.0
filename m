Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:36608 "EHLO
	mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751145AbcGYNzH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Jul 2016 09:55:07 -0400
Received: by mail-lf0-f42.google.com with SMTP id g62so128960093lfe.3
        for <linux-iio@vger.kernel.org>; Mon, 25 Jul 2016 06:55:06 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	devicetree@vger.kernel.org, Samu Onkalo <samu.onkalo@intel.com>,
	Sebastian Reichel <sre@kernel.org>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH 1/2 v5] iio: magn: DT bindings for AK8974
Date: Mon, 25 Jul 2016 15:54:54 +0200
Message-Id: <1469454895-13659-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This adds device tree bindings for the AK8974 magnetometer, similar
to those for the AK8975.

Cc: devicetree@vger.kernel.org
Cc: Samu Onkalo <samu.onkalo@intel.com>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v4->v5:
- No changes, just resend.
ChangeLog v3->v4:
- Add support for an optional mounting matrix
ChangeLog v2->v3:
- No changes, just reposting to keep together with the series
ChangeLog v1->v2:
- No changes, just reposting to keep together with the series
---
 .../bindings/iio/magnetometer/ak8974.txt           | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/ak8974.txt

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/ak8974.txt b/Documentation/devicetree/bindings/iio/magnetometer/ak8974.txt
new file mode 100644
index 000000000000..77d5aba1bd8c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/magnetometer/ak8974.txt
@@ -0,0 +1,29 @@
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
+- mount-matrix: an optional 3x3 mounting rotation matrix
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
2.7.4

