Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:60474 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbeHGMlH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Aug 2018 08:41:07 -0400
From: Parthiban Nallathambi <pn@denx.de>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, andy.shevchenko@gmail.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        matthias.bgg@gmail.com, wd@denx.de, sbabic@denx.de, hs@denx.de,
        Parthiban Nallathambi <pn@denx.de>
Subject: [PATCH v6 2/2] iio: light: Add device tree binding for vishay vcnl4035
Date: Tue,  7 Aug 2018 12:27:04 +0200
Message-Id: <20180807102704.1652656-2-pn@denx.de>
In-Reply-To: <20180807102704.1652656-1-pn@denx.de>
References: <20180807102704.1652656-1-pn@denx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Adding device tree binding for vcnl4035 and vendor
prefix for Vishay Intertechnology

Signed-off-by: Parthiban Nallathambi <pn@denx.de>

Changelog in v3:
- removed interrupt-parent property reference in documentation
- renamed vcnl4035 to light-sensor

Changelog in v4:
- commit message fix
- same indexing/space in binding
---
 .../devicetree/bindings/iio/light/vcnl4035.txt         | 18 ++++++++++++++++++
 Documentation/devicetree/bindings/vendor-prefixes.txt  |  1 +
 2 files changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/vcnl4035.txt

diff --git a/Documentation/devicetree/bindings/iio/light/vcnl4035.txt b/Documentation/devicetree/bindings/iio/light/vcnl4035.txt
new file mode 100644
index 000000000000..c07c7f052556
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/vcnl4035.txt
@@ -0,0 +1,18 @@
+VISHAY VCNL4035 -  Ambient Light and proximity sensor
+
+Link to datasheet: https://www.vishay.com/docs/84251/vcnl4035x01.pdf
+
+Required properties:
+
+	-compatible: should be "vishay,vcnl4035"
+	-reg: I2C address of the sensor, should be 0x60
+	-interrupts: interrupt mapping for GPIO IRQ (level active low)
+
+Example:
+
+light-sensor@60 {
+	compatible = "vishay,vcnl4035";
+	reg = <0x60>;
+	interrupt-parent = <&gpio4>;
+	interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+};
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 7cad066191ee..3cc46d5735a9 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -395,6 +395,7 @@ v3	V3 Semiconductor
 variscite	Variscite Ltd.
 via	VIA Technologies, Inc.
 virtio	Virtual I/O Device Specification, developed by the OASIS consortium
+vishay	Vishay Intertechnology, Inc
 vivante	Vivante Corporation
 vocore VoCore Studio
 voipac	Voipac Technologies s.r.o.
-- 
2.14.4

