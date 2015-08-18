Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:36727 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750950AbbHROkr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 18 Aug 2015 10:40:47 -0400
Received: by pdbmi9 with SMTP id mi9so28294425pdb.3
        for <linux-iio@vger.kernel.org>; Tue, 18 Aug 2015 07:40:47 -0700 (PDT)
From: Matt Ranostay <mranostay@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v6 1/2] devicetree: add PulsedLight vendor + device docs
Date: Tue, 18 Aug 2015 07:40:37 -0700
Message-Id: <1439908838-6945-2-git-send-email-mranostay@gmail.com>
In-Reply-To: <1439908838-6945-1-git-send-email-mranostay@gmail.com>
References: <1439908838-6945-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add pulsedlight vendor to vendor-prefixes.txt, and LIDAR device
documentation to trivial-devices.txt

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 Documentation/devicetree/bindings/i2c/trivial-devices.txt | 1 +
 Documentation/devicetree/bindings/vendor-prefixes.txt     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
index d77d412..cecd315 100644
--- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
@@ -80,6 +80,7 @@ oki,ml86v7667		OKI ML86V7667 video decoder
 ovti,ov5642		OV5642: Color CMOS QSXGA (5-megapixel) Image Sensor with OmniBSI and Embedded TrueFocus
 pericom,pt7c4338	Real-time Clock Module
 plx,pex8648		48-Lane, 12-Port PCI Express Gen 2 (5.0 GT/s) Switch
+pulsedlight,lidar-lite-v2	Pulsedlight LIDAR range-finding sensor
 ramtron,24c64		i2c serial eeprom  (24cxx)
 ricoh,r2025sd		I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
 ricoh,r2221tl		I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 3ac71a8..c220209 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -166,6 +166,7 @@ phytec	PHYTEC Messtechnik GmbH
 picochip	Picochip Ltd
 plathome	Plat'Home Co., Ltd.
 pixcir  PIXCIR MICROELECTRONICS Co., Ltd
+pulsedlight	PulsedLight, Inc
 powervr	PowerVR (deprecated, use img)
 qca	Qualcomm Atheros, Inc.
 qcom	Qualcomm Technologies, Inc
-- 
1.9.1

