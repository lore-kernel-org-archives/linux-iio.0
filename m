Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:58564 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751782Ab3HPNM7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 16 Aug 2013 09:12:59 -0400
From: Jacek Anaszewski <j.anaszewski@samsung.com>
To: linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org, jic23@kernel.org,
	kyungmin.park@samsung.com, s.nawrocki@samsung.com,
	rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com,
	swarren@wwwdotorg.org, ian.campbell@citrix.com,
	Jacek Anaszewski <j.anaszewski@samsung.com>
Subject: [PATCH/RFC v4 3/3] DT: Add documentation for gp2ap020a00f sensor
Date: Fri, 16 Aug 2013 15:12:40 +0200
Message-id: <1376658760-3459-1-git-send-email-j.anaszewski@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds device tree binding documentation
for the gp2ap020a00f proximity/als sensor.

Signed-off-by: Jacek Anaszewski <j.anaszewski@samsung.com>
Signed-off-by: Kyunmin Park <kyungmin.park@samsung.com>
---
 .../devicetree/bindings/iio/light/gp2ap020a00f.txt |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/light/gp2ap020a00f.txt

diff --git a/Documentation/devicetree/bindings/iio/light/gp2ap020a00f.txt b/Documentation/devicetree/bindings/iio/light/gp2ap020a00f.txt
new file mode 100644
index 0000000..e4f377d
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/gp2ap020a00f.txt
@@ -0,0 +1,20 @@
+* Sharp GP2AP020A00F I2C Proximity/ALS sensor
+
+Required properties:
+
+  - compatible : should be "sharp,gp2ap020a00f"
+  - reg : the I2C address of the light sensor
+  - interrupt-parent : phandle to the parent interrupt controller
+  - interrupts : should be INT interrupt pin
+  - vled-supply : VLED power supply, as covered
+		  in Documentation/devicetree/bindings/regulator/regulator.txt
+
+Example:
+
+gp2ap020a00f@39 {
+	compatible = "sharp,gp2ap020a00f";
+	reg = <0x39>;
+	interrupt-parent = <&gpx0>;
+	interrupts = <2 0>;
+	vled-supply = <...>;
+};
-- 
1.7.5.4

