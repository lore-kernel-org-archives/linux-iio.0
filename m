Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:50833 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915Ab3HUPGh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 21 Aug 2013 11:06:37 -0400
From: Jacek Anaszewski <j.anaszewski@samsung.com>
To: linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org, jic23@kernel.org,
	kyungmin.park@samsung.com, s.nawrocki@samsung.com,
	rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com,
	swarren@wwwdotorg.org, ian.campbell@citrix.com,
	Jacek Anaszewski <j.anaszewski@samsung.com>
Subject: [PATCH/RFC v6 1/2] DT: Add documentation for gp2ap020a00f sensor
Date: Wed, 21 Aug 2013 17:06:20 +0200
Message-id: <1377097580-4492-1-git-send-email-j.anaszewski@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds device tree binding documentation
for the gp2ap020a00f proximity/als sensor.

Signed-off-by: Jacek Anaszewski <j.anaszewski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 .../devicetree/bindings/iio/light/gp2ap020a00f.txt |   21 ++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/light/gp2ap020a00f.txt

diff --git a/Documentation/devicetree/bindings/iio/light/gp2ap020a00f.txt b/Documentation/devicetree/bindings/iio/light/gp2ap020a00f.txt
new file mode 100644
index 0000000..9231c82
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/gp2ap020a00f.txt
@@ -0,0 +1,21 @@
+* Sharp GP2AP020A00F I2C Proximity/ALS sensor
+
+The proximity detector sensor requires power supply
+for its built-in led. It is also defined by this binding.
+
+Required properties:
+
+  - compatible : should be "sharp,gp2ap020a00f"
+  - reg : the I2C slave address of the light sensor
+  - interrupts : interrupt specifier for the sole interrupt generated
+		 by the device
+  - vled-supply : VLED power supply, as covered in ../regulator/regulator.txt
+
+Example:
+
+gp2ap020a00f@39 {
+	compatible = "sharp,gp2ap020a00f";
+	reg = <0x39>;
+	interrupts = <2 0>;
+	vled-supply = <...>;
+};
-- 
1.7.5.4

