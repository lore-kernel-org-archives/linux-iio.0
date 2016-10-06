Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55236 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932260AbcJFRGx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 Oct 2016 13:06:53 -0400
From: Hans de Goede <hdegoede@redhat.com>
To: Rob Herring <robh+dt@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-iio@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2] dt: bindings: vendor-prefix: Add 3 accelerometer vendor prefixes
Date: Thu,  6 Oct 2016 19:06:50 +0200
Message-Id: <20161006170650.13518-1-hdegoede@redhat.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Recently the kernel has gotten support in the iio subsystem for a number
of new accelerometers from mCube, Memsic and MiraMEMS.

This commit adds the vendor prefixes already used for these vendors
in Documentation/devicetree/bindings/i2c/trivial-devices.txt to
vendor-prefixes.txt.

The "full" company names were taken from the company's websites:
http://www.mcubemems.com/
http://www.memsic.com/
http://www.miramems.com/en/

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Drop domintech, it is already in the iio/next tree
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 5c67e91..abe0129 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -157,13 +157,16 @@ lltc	Linear Technology Corporation
 marvell	Marvell Technology Group Ltd.
 maxim	Maxim Integrated Products
 meas	Measurement Specialties
+mcube	mCube
 mediatek	MediaTek Inc.
 melexis	Melexis N.V.
+memsic	MEMSIC Inc.
 merrii	Merrii Technology Co., Ltd.
 micrel	Micrel Inc.
 microchip	Microchip Technology Inc.
 micron	Micron Technology Inc.
 minix	MINIX Technology Ltd.
+miramems	MiraMEMS Sensing Technology Co., Ltd.
 mitsubishi	Mitsubishi Electric Corporation
 mosaixtech	Mosaix Technologies, Inc.
 moxa	Moxa
-- 
2.9.3

