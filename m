Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35016 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547AbcF3HfU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 30 Jun 2016 03:35:20 -0400
From: Florian Vaussard <florian.vaussard@gmail.com>
To: devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Peter Rosin <peda@axentia.se>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Slawomir Stepien <sst@poczta.fm>,
	Joachim Eastwood <manabian@gmail.com>,
	Matt Ranostay <mranostay@gmail.com>,
	Cristina Moraru <cristina.moraru09@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Florian Vaussard <florian.vaussard@heig-vd.ch>
Subject: [PATCH v3 2/4] iio: potentiometer: mcp4531: Add device tree binding documentation
Date: Thu, 30 Jun 2016 09:34:49 +0200
Message-Id: <1467272091-28087-3-git-send-email-florian.vaussard@heig-vd.ch>
In-Reply-To: <1467272091-28087-1-git-send-email-florian.vaussard@heig-vd.ch>
References: <1467272091-28087-1-git-send-email-florian.vaussard@heig-vd.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add the device tree documentation for all the supported parts. Apart the
compatible string and standard I2C binding, no other binding is currently
needed.

Signed-off-by: Florian Vaussard <florian.vaussard@heig-vd.ch>
---
 .../devicetree/bindings/i2c/trivial-devices.txt    | 64 ++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
index 53987449..acc5cd6 100644
--- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
@@ -56,6 +56,70 @@ maxim,ds1050		5 Bit Programmable, Pulse-Width Modulator
 maxim,max1237		Low-Power, 4-/12-Channel, 2-Wire Serial, 12-Bit ADCs
 maxim,max6625		9-Bit/12-Bit Temperature Sensors with I²C-Compatible Serial Interface
 mc,rv3029c2		Real Time Clock Module with I2C-Bus
+microchip,mcp4531-502	Microchip 7-bit Single I2C Digital Potentiometer (5k)
+microchip,mcp4531-103	Microchip 7-bit Single I2C Digital Potentiometer (10k)
+microchip,mcp4531-503	Microchip 7-bit Single I2C Digital Potentiometer (50k)
+microchip,mcp4531-104	Microchip 7-bit Single I2C Digital Potentiometer (100k)
+microchip,mcp4532-502	Microchip 7-bit Single I2C Digital Potentiometer (5k)
+microchip,mcp4532-103	Microchip 7-bit Single I2C Digital Potentiometer (10k)
+microchip,mcp4532-503	Microchip 7-bit Single I2C Digital Potentiometer (50k)
+microchip,mcp4532-104	Microchip 7-bit Single I2C Digital Potentiometer (100k)
+microchip,mcp4541-502	Microchip 7-bit Single I2C Digital Potentiometer with NV Memory (5k)
+microchip,mcp4541-103	Microchip 7-bit Single I2C Digital Potentiometer with NV Memory (10k)
+microchip,mcp4541-503	Microchip 7-bit Single I2C Digital Potentiometer with NV Memory (50k)
+microchip,mcp4541-104	Microchip 7-bit Single I2C Digital Potentiometer with NV Memory (100k)
+microchip,mcp4542-502	Microchip 7-bit Single I2C Digital Potentiometer with NV Memory (5k)
+microchip,mcp4542-103	Microchip 7-bit Single I2C Digital Potentiometer with NV Memory (10k)
+microchip,mcp4542-503	Microchip 7-bit Single I2C Digital Potentiometer with NV Memory (50k)
+microchip,mcp4542-104	Microchip 7-bit Single I2C Digital Potentiometer with NV Memory (100k)
+microchip,mcp4551-502	Microchip 8-bit Single I2C Digital Potentiometer (5k)
+microchip,mcp4551-103	Microchip 8-bit Single I2C Digital Potentiometer (10k)
+microchip,mcp4551-503	Microchip 8-bit Single I2C Digital Potentiometer (50k)
+microchip,mcp4551-104	Microchip 8-bit Single I2C Digital Potentiometer (100k)
+microchip,mcp4552-502	Microchip 8-bit Single I2C Digital Potentiometer (5k)
+microchip,mcp4552-103	Microchip 8-bit Single I2C Digital Potentiometer (10k)
+microchip,mcp4552-503	Microchip 8-bit Single I2C Digital Potentiometer (50k)
+microchip,mcp4552-104	Microchip 8-bit Single I2C Digital Potentiometer (100k)
+microchip,mcp4561-502	Microchip 8-bit Single I2C Digital Potentiometer with NV Memory (5k)
+microchip,mcp4561-103	Microchip 8-bit Single I2C Digital Potentiometer with NV Memory (10k)
+microchip,mcp4561-503	Microchip 8-bit Single I2C Digital Potentiometer with NV Memory (50k)
+microchip,mcp4561-104	Microchip 8-bit Single I2C Digital Potentiometer with NV Memory (100k)
+microchip,mcp4562-502	Microchip 8-bit Single I2C Digital Potentiometer with NV Memory (5k)
+microchip,mcp4562-103	Microchip 8-bit Single I2C Digital Potentiometer with NV Memory (10k)
+microchip,mcp4562-503	Microchip 8-bit Single I2C Digital Potentiometer with NV Memory (50k)
+microchip,mcp4562-104	Microchip 8-bit Single I2C Digital Potentiometer with NV Memory (100k)
+microchip,mcp4631-502	Microchip 7-bit Dual I2C Digital Potentiometer (5k)
+microchip,mcp4631-103	Microchip 7-bit Dual I2C Digital Potentiometer (10k)
+microchip,mcp4631-503	Microchip 7-bit Dual I2C Digital Potentiometer (50k)
+microchip,mcp4631-104	Microchip 7-bit Dual I2C Digital Potentiometer (100k)
+microchip,mcp4632-502	Microchip 7-bit Dual I2C Digital Potentiometer (5k)
+microchip,mcp4632-103	Microchip 7-bit Dual I2C Digital Potentiometer (10k)
+microchip,mcp4632-503	Microchip 7-bit Dual I2C Digital Potentiometer (50k)
+microchip,mcp4632-104	Microchip 7-bit Dual I2C Digital Potentiometer (100k)
+microchip,mcp4641-502	Microchip 7-bit Dual I2C Digital Potentiometer with NV Memory (5k)
+microchip,mcp4641-103	Microchip 7-bit Dual I2C Digital Potentiometer with NV Memory (10k)
+microchip,mcp4641-503	Microchip 7-bit Dual I2C Digital Potentiometer with NV Memory (50k)
+microchip,mcp4641-104	Microchip 7-bit Dual I2C Digital Potentiometer with NV Memory (100k)
+microchip,mcp4642-502	Microchip 7-bit Dual I2C Digital Potentiometer with NV Memory (5k)
+microchip,mcp4642-103	Microchip 7-bit Dual I2C Digital Potentiometer with NV Memory (10k)
+microchip,mcp4642-503	Microchip 7-bit Dual I2C Digital Potentiometer with NV Memory (50k)
+microchip,mcp4642-104	Microchip 7-bit Dual I2C Digital Potentiometer with NV Memory (100k)
+microchip,mcp4651-502	Microchip 8-bit Dual I2C Digital Potentiometer (5k)
+microchip,mcp4651-103	Microchip 8-bit Dual I2C Digital Potentiometer (10k)
+microchip,mcp4651-503	Microchip 8-bit Dual I2C Digital Potentiometer (50k)
+microchip,mcp4651-104	Microchip 8-bit Dual I2C Digital Potentiometer (100k)
+microchip,mcp4652-502	Microchip 8-bit Dual I2C Digital Potentiometer (5k)
+microchip,mcp4652-103	Microchip 8-bit Dual I2C Digital Potentiometer (10k)
+microchip,mcp4652-503	Microchip 8-bit Dual I2C Digital Potentiometer (50k)
+microchip,mcp4652-104	Microchip 8-bit Dual I2C Digital Potentiometer (100k)
+microchip,mcp4661-502	Microchip 8-bit Dual I2C Digital Potentiometer with NV Memory (5k)
+microchip,mcp4661-103	Microchip 8-bit Dual I2C Digital Potentiometer with NV Memory (10k)
+microchip,mcp4661-503	Microchip 8-bit Dual I2C Digital Potentiometer with NV Memory (50k)
+microchip,mcp4661-104	Microchip 8-bit Dual I2C Digital Potentiometer with NV Memory (100k)
+microchip,mcp4662-502	Microchip 8-bit Dual I2C Digital Potentiometer with NV Memory (5k)
+microchip,mcp4662-103	Microchip 8-bit Dual I2C Digital Potentiometer with NV Memory (10k)
+microchip,mcp4662-503	Microchip 8-bit Dual I2C Digital Potentiometer with NV Memory (50k)
+microchip,mcp4662-104	Microchip 8-bit Dual I2C Digital Potentiometer with NV Memory (100k)
 national,lm63		Temperature sensor with integrated fan control
 national,lm75		I2C TEMP SENSOR
 national,lm80		Serial Interface ACPI-Compatible Microprocessor System Hardware Monitor
-- 
2.5.5

