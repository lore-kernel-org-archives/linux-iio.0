Return-Path: <SRS0=A4gG=F6=axentia.se=peda@kernel.org>
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: trivial: add various mcp4017/18/19 potentiometers
Date: Thu,  8 Mar 2018 20:58:29 +0100
Message-Id: <20180308195830.16348-2-peda@axentia.se>
In-Reply-To: <20180308195830.16348-1-peda@axentia.se>
References: <20180308195830.16348-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

They come in 5 kOhm, 10 kOhm, 50 kOhm and 100 kOhm variations.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 Documentation/devicetree/bindings/trivial-devices.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.txt b/Documentation/devicetree/bindings/trivial-devices.txt
index 2e3740f98c41..763a2808a95c 100644
--- a/Documentation/devicetree/bindings/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/trivial-devices.txt
@@ -75,6 +75,18 @@ maxim,max6621		PECI-to-I2C translator for PECI-to-SMBus/I2C protocol conversion
 maxim,max6625		9-Bit/12-Bit Temperature Sensors with I²C-Compatible Serial Interface
 mcube,mc3230		mCube 3-axis 8-bit digital accelerometer
 memsic,mxc6225		MEMSIC 2-axis 8-bit digital accelerometer
+microchip,mcp4017-502	Microchip 7-bit Single I2C Digital POT (5k)
+microchip,mcp4017-103	Microchip 7-bit Single I2C Digital POT (10k)
+microchip,mcp4017-503	Microchip 7-bit Single I2C Digital POT (50k)
+microchip,mcp4017-104	Microchip 7-bit Single I2C Digital POT (100k)
+microchip,mcp4018-502	Microchip 7-bit Single I2C Digital POT (5k)
+microchip,mcp4018-103	Microchip 7-bit Single I2C Digital POT (10k)
+microchip,mcp4018-503	Microchip 7-bit Single I2C Digital POT (50k)
+microchip,mcp4018-104	Microchip 7-bit Single I2C Digital POT (100k)
+microchip,mcp4019-502	Microchip 7-bit Single I2C Digital POT (5k)
+microchip,mcp4019-103	Microchip 7-bit Single I2C Digital POT (10k)
+microchip,mcp4019-503	Microchip 7-bit Single I2C Digital POT (50k)
+microchip,mcp4019-104	Microchip 7-bit Single I2C Digital POT (100k)
 microchip,mcp4531-502	Microchip 7-bit Single I2C Digital Potentiometer (5k)
 microchip,mcp4531-103	Microchip 7-bit Single I2C Digital Potentiometer (10k)
 microchip,mcp4531-503	Microchip 7-bit Single I2C Digital Potentiometer (50k)
-- 
2.11.0
