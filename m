Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35926 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752591AbbI3Bg1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 29 Sep 2015 21:36:27 -0400
Received: by pablk4 with SMTP id lk4so22131614pab.3
        for <linux-iio@vger.kernel.org>; Tue, 29 Sep 2015 18:36:26 -0700 (PDT)
From: Suresh Rajashekara <sureshraj@google.com>
To: linux-iio@vger.kernel.org
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	devicetree@vger.kernel.org, matthias.bgg@gmail.com,
	linux-kernel@vger.kernel.org, jic23@kernel.org,
	Suresh Rajashekara <sureshraj@google.com>
Subject: [PATCH v3 2/2] iio:light:ap3223: Add DT support
Date: Tue, 29 Sep 2015 18:36:21 -0700
Message-Id: <1443576981-1210-2-git-send-email-sureshraj@google.com>
In-Reply-To: <1443576981-1210-1-git-send-email-sureshraj@google.com>
References: <1443576981-1210-1-git-send-email-sureshraj@google.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

* Add Device Tree support for the Dyna Image AP3223 ambient light sensor and
* proximity driver,
* Document the binding and
* Add a vendor prefix for Dyna Image

v3
* Fixing typo in comment
v2
* Seperating the device tree changes from code

Signed-off-by: Suresh Rajashekara <sureshraj@google.com>
---
 Documentation/devicetree/bindings/iio/light/ap3223.txt | 18 ++++++++++++++++++
 Documentation/devicetree/bindings/vendor-prefixes.txt  |  1 +
 2 files changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/ap3223.txt

diff --git a/Documentation/devicetree/bindings/iio/light/ap3223.txt b/Documentation/devicetree/bindings/iio/light/ap3223.txt
new file mode 100644
index 0000000..b255d27
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/ap3223.txt
@@ -0,0 +1,18 @@
+* Dyna Image AP3223 ambient light sensor and proximity sensor
+
+http://www.dyna-image.com/english/product/optical-sensor-detail.php?cpid=2&dpid=8
+
+Required properties:
+
+  - compatible : should be "dynaimage,ap3223"
+  - reg : the I2C address of the sensor
+
+Example:
+
+ap3223@1c {
+	compatible = "dynaimage,ap3223";
+	reg = <0x1c>;
+
+	pinctrl-0 = <&ap3223_pins>;
+	pinctrl-names = "default";
+};
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 5f20add..704da45 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -46,6 +46,7 @@ digilent	Diglent, Inc.
 dlg	Dialog Semiconductor
 dlink	D-Link Corporation
 dmo	Data Modul AG
+dynaimage	Dyna-Image
 ebv	EBV Elektronik
 edt	Emerging Display Technologies
 elan	Elan Microelectronic Corp.
-- 
2.6.0.rc2.230.g3dd15c0

