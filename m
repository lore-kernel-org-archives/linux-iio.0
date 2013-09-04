Return-Path: <lee.jones@linaro.org>
From: Lee Jones <lee.jones@linaro.org>
To: linux-kernel@vger.kernel.org,
	wsa@the-dreams.de
Cc: jic23@cam.ac.uk,
	linux-iio@vger.kernel.org,
	mark.rutland@arm.com,
	Lee Jones <lee.jones@linaro.org>
Subject: [PATCH] Documentation: dt: i2c: Add LPS001WP to the Trivial Devices list
Date: Wed,  4 Sep 2013 14:50:55 +0100
Message-Id: <1378302655-13258-1-git-send-email-lee.jones@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

LPS001WP is a Pressure and Temperature sensor.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 Documentation/devicetree/bindings/i2c/trivial-devices.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
index ad6a738..6038807e6 100644
--- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
@@ -57,6 +57,7 @@ st-micro,24c256		i2c serial eeprom  (24cxx)
 stm,m41t00		Serial Access TIMEKEEPER
 stm,m41t62		Serial real-time clock (RTC) with alarm
 stm,m41t80		M41T80 - SERIAL ACCESS RTC WITH ALARMS
+stm,lps001wp		Pressure and Temperature sensor
 taos,tsl2550		Ambient Light Sensor with SMBUS/Two Wire Serial Interface
 ti,tsc2003		I2C Touch-Screen Controller
 ti,tmp102		Low Power Digital Temperature Sensor with SMBUS/Two Wire Serial Interface
-- 
1.8.1.2
