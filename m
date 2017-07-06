Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:58480 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752197AbdGFW4g (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 Jul 2017 18:56:36 -0400
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v2 2/9] staging: iio: tsl2x7x: add device tree documentation
Date: Thu,  6 Jul 2017 18:56:19 -0400
Message-Id: <20170706225626.6716-3-masneyb@onstation.org>
In-Reply-To: <20170706225626.6716-1-masneyb@onstation.org>
References: <20170706225626.6716-1-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add device tree documentation for the tsl2x7x IIO driver.

Signed-off-by: Brian Masney <masneyb@onstation.org>
CC: Rob Herring <robh+dt@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>
CC: devicetree@vger.kernel.org
---
 Documentation/devicetree/bindings/trivial-devices.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.txt b/Documentation/devicetree/bindings/trivial-devices.txt
index 35f406d..0e6e953 100644
--- a/Documentation/devicetree/bindings/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/trivial-devices.txt
@@ -21,6 +21,16 @@ adi,adt7490		+/-1C TDM Extended Temp Range I.C
 adi,adxl345		Three-Axis Digital Accelerometer
 adi,adxl346		Three-Axis Digital Accelerometer (backward-compatibility value "adi,adxl345" must be listed too)
 ams,iaq-core		AMS iAQ-Core VOC Sensor
+amstaos,tsl2571		AMS/TAOS ALS and proximity sensor
+amstaos,tsl2671		AMS/TAOS ALS and proximity sensor
+amstaos,tmd2671		AMS/TAOS ALS and proximity sensor
+amstaos,tsl2771		AMS/TAOS ALS and proximity sensor
+amstaos,tmd2771		AMS/TAOS ALS and proximity sensor
+amstaos,tsl2572		AMS/TAOS ALS and proximity sensor
+amstaos,tsl2672		AMS/TAOS ALS and proximity sensor
+amstaos,tmd2672		AMS/TAOS ALS and proximity sensor
+amstaos,tsl2772		AMS/TAOS ALS and proximity sensor
+amstaos,tmd2772		AMS/TAOS ALS and proximity sensor
 at,24c08		i2c serial eeprom  (24cxx)
 atmel,at97sc3204t	i2c trusted platform module (TPM)
 capella,cm32181		CM32181: Ambient Light Sensor
-- 
2.9.4

