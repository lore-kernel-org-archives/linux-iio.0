Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36062 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751674AbcJHMfI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 8 Oct 2016 08:35:08 -0400
From: Hans de Goede <hdegoede@redhat.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 1/4] dt: bindings: i2c/trivial-devices.txt: Add 2 iio supported accelerometers
Date: Sat,  8 Oct 2016 14:34:23 +0200
Message-Id: <20161008123426.8991-2-hdegoede@redhat.com>
In-Reply-To: <20161008123426.8991-1-hdegoede@redhat.com>
References: <20161008123426.8991-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add compatible strings for 2 accelerometers which follow the trivial
i2c device bindings and have been supported by the iio subsystem for
a while now.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 Documentation/devicetree/bindings/i2c/trivial-devices.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
index fbbad64..ce9db50 100644
--- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
@@ -44,6 +44,7 @@ epson,rx8025		High-Stability. I2C-Bus INTERFACE REAL TIME CLOCK MODULE
 epson,rx8581		I2C-BUS INTERFACE REAL TIME CLOCK MODULE
 fsl,mag3110		MAG3110: Xtrinsic High Accuracy, 3D Magnetometer
 fsl,mc13892		MC13892: Power Management Integrated Circuit (PMIC) for i.MX35/51
+fsl,mma7660		MMA7660FC: 3-Axis Orientation/Motion Detection Sensor
 fsl,mma8450		MMA8450Q: Xtrinsic Low-power, 3-axis Xtrinsic Accelerometer
 fsl,mpl3115		MPL3115: Absolute Digital Pressure Sensor
 fsl,mpr121		MPR121: Proximity Capacitive Touch Sensor Controller
@@ -57,6 +58,7 @@ maxim,max1237		Low-Power, 4-/12-Channel, 2-Wire Serial, 12-Bit ADCs
 maxim,max6625		9-Bit/12-Bit Temperature Sensors with I²C-Compatible Serial Interface
 mc,rv3029c2		Real Time Clock Module with I2C-Bus
 mcube,mc3230		mCube 3-axis 8-bit digital accelerometer
+memsic,mxc6225		MEMSIC 2-axis 8-bit digital accelerometer
 microchip,mcp4531-502	Microchip 7-bit Single I2C Digital Potentiometer (5k)
 microchip,mcp4531-103	Microchip 7-bit Single I2C Digital Potentiometer (10k)
 microchip,mcp4531-503	Microchip 7-bit Single I2C Digital Potentiometer (50k)
-- 
2.9.3

