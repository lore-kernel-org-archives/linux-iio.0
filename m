Return-Path: <hdegoede@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
To: Rob Herring <robh+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/2] dt: bindings: vendor-prefix: Add 3 accelerometer vendor prefixes
Date: Sun,  2 Oct 2016 17:51:35 +0200
Message-Id: <20161002155135.23298-2-hdegoede@redhat.com>
In-Reply-To: <20161002155135.23298-1-hdegoede@redhat.com>
References: <20161002155135.23298-1-hdegoede@redhat.com>
List-ID: <linux-iio@vger.kernel.org>

Recently the kernel has gotten support in the iio subsystem for a number
of new accelerometers from Domintech, mCube, Memsic and MiraMEMS.

This commit adds the vendor prefixes already used for these vendors
in Documentation/devicetree/bindings/i2c/trivial-devices.txt to
vendor-prefixes.txt.

Domintech's full company name was taken from copyright headers for
their drivers from: https://github.com/domintech/

The other full company names were taken from the company's websites:
http://www.mcubemems.com/
http://www.memsic.com/
http://www.miramems.com/en/

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 3651670..c4eb298 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -75,6 +75,7 @@ digilent	Diglent, Inc.
 dlg	Dialog Semiconductor
 dlink	D-Link Corporation
 dmo	Data Modul AG
+domintech	Domintech Technology Co.
 dptechnics	DPTechnics
 dragino	Dragino Technology Co., Limited
 ea	Embedded Artists AB
@@ -156,13 +157,16 @@ lltc	Linear Technology Corporation
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
