Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49257 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751190AbdLIXZl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 9 Dec 2017 18:25:41 -0500
From: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Marius Tarcatu <marius.tarcatu@infineon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH 1/2] dt-bindings: Add Infineon TLV493D-A1B6
Date: Sun, 10 Dec 2017 00:25:06 +0100
Message-Id: <20171209232507.18594-2-afaerber@suse.de>
In-Reply-To: <20171209232507.18594-1-afaerber@suse.de>
References: <20171209232507.18594-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The Infineon TLV493D-A1B6 is an I2C-based 3D Magnetic Sensor.

Cc: Marius Tarcatu <marius.tarcatu@infineon.com>
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 Documentation/devicetree/bindings/trivial-devices.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.txt b/Documentation/devicetree/bindings/trivial-devices.txt
index 5f3143f97098..7ad1939cb0d6 100644
--- a/Documentation/devicetree/bindings/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/trivial-devices.txt
@@ -63,6 +63,7 @@ fsl,sgtl5000		SGTL5000: Ultra Low-Power Audio Codec
 gmt,g751		G751: Digital Temperature Sensor and Thermal Watchdog with Two-Wire Interface
 infineon,slb9635tt	Infineon SLB9635 (Soft-) I2C TPM (old protocol, max 100khz)
 infineon,slb9645tt	Infineon SLB9645 I2C TPM (new protocol, max 400khz)
+infineon,tlv493d-a1b6	Infineon TLV493D-A1B6 I2C 3D Magnetic Sensor
 isil,isl1208		Intersil ISL1208 Low Power RTC with Battery Backed SRAM
 isil,isl1218		Intersil ISL1218 Low Power RTC with Battery Backed SRAM
 isil,isl12022		Intersil ISL12022 Real-time Clock
-- 
2.13.6

