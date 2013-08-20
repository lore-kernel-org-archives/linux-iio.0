Return-Path: <j.anaszewski@samsung.com>
From: Jacek Anaszewski <j.anaszewski@samsung.com>
To: linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org, jic23@kernel.org, kyungmin.park@samsung.com,
 s.nawrocki@samsung.com, rob.herring@calxeda.com, pawel.moll@arm.com,
 mark.rutland@arm.com, swarren@wwwdotorg.org, ian.campbell@citrix.com,
 Jacek Anaszewski <j.anaszewski@samsung.com>
Subject: [PATCH/RFC v5 1/2] DT: Add documentation for gp2ap020a00f sensor
Date: Tue, 20 Aug 2013 16:47:13 +0200
Message-id: <1377010033-5190-1-git-send-email-j.anaszewski@samsung.com>
List-ID: <linux-iio@vger.kernel.org>

This patch adds device tree binding documentation
for the gp2ap020a00f proximity/als sensor.

Signed-off-by: Jacek Anaszewski <j.anaszewski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 .../devicetree/bindings/iio/light/gp2ap020a00f.txt |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/light/gp2ap020a00f.txt

diff --git a/Documentation/devicetree/bindings/iio/light/gp2ap020a00f.txt b/Documentation/devicetree/bindings/iio/light/gp2ap020a00f.txt
new file mode 100644
index 0000000..a92fccd
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/gp2ap020a00f.txt
@@ -0,0 +1,17 @@
+* Sharp GP2AP020A00F I2C Proximity/ALS sensor
+
+Required properties:
+
+  - compatible : should be "sharp,gp2ap020a00f"
+  - reg : the I2C slave address of the light sensor
+  - interrupts : should be interrupt line number the INT pin is routed to
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
