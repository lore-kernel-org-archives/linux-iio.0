Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35745 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046AbbHEEjz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 5 Aug 2015 00:39:55 -0400
From: Matt Ranostay <mranostay@gmail.com>
To: marex@denx.de, jic23@kernel.org, lars@metafoo.de,
	vladimir.barinov@cogentembedded.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v4 1/2] devicetree: add PulsedLight vendor + device docs
Date: Tue,  4 Aug 2015 21:41:15 -0700
Message-Id: <1438749676-28781-2-git-send-email-mranostay@gmail.com>
In-Reply-To: <1438749676-28781-1-git-send-email-mranostay@gmail.com>
References: <1438749676-28781-1-git-send-email-mranostay@gmail.com>
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
index d77d412..9d0e781 100644
--- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
@@ -80,6 +80,7 @@ oki,ml86v7667		OKI ML86V7667 video decoder
 ovti,ov5642		OV5642: Color CMOS QSXGA (5-megapixel) Image Sensor with OmniBSI and Embedded TrueFocus
 pericom,pt7c4338	Real-time Clock Module
 plx,pex8648		48-Lane, 12-Port PCI Express Gen 2 (5.0 GT/s) Switch
+pulsedlight,lidar	Pulsedlight LIDAR range-finding sensor
 ramtron,24c64		i2c serial eeprom  (24cxx)
 ricoh,r2025sd		I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
 ricoh,r2221tl		I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 6284568..0f318c3 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -164,6 +164,7 @@ phytec	PHYTEC Messtechnik GmbH
 picochip	Picochip Ltd
 plathome	Plat'Home Co., Ltd.
 pixcir  PIXCIR MICROELECTRONICS Co., Ltd
+pulsedlight	PulsedLight, Inc
 powervr	PowerVR (deprecated, use img)
 qca	Qualcomm Atheros, Inc.
 qcom	Qualcomm Technologies, Inc
-- 
1.9.1

