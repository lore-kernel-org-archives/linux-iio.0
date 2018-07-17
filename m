Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:58256 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729688AbeGQJNg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 17 Jul 2018 05:13:36 -0400
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
Cc: jonathan@marek.ca, jmaneyrol@invensense.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mkelly@xevo.com,
        fischerdouglasc@gmail.com, bshah@kde.org, ctatlor97@gmail.com,
        drew.paterson@ams.com
Subject: [PATCH v2 4/7] dt-bindings: trivial: remove tsl2772
Date: Tue, 17 Jul 2018 04:41:55 -0400
Message-Id: <20180717084158.23532-5-masneyb@onstation.org>
In-Reply-To: <20180717084158.23532-1-masneyb@onstation.org>
References: <20180717084158.23532-1-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Remove the tsl2772 driver from trivial-devices.txt. A separate
patch added the binding information to the file
Documentation/devicetree/bindings/iio/light/tsl2772.txt.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 Documentation/devicetree/bindings/trivial-devices.txt | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/trivial-devices.txt b/Documentation/devicetree/bindings/trivial-devices.txt
index 763a2808a95c..a977ccef7230 100644
--- a/Documentation/devicetree/bindings/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/trivial-devices.txt
@@ -21,16 +21,6 @@ adi,adt7490		+/-1C TDM Extended Temp Range I.C
 adi,adxl345		Three-Axis Digital Accelerometer
 adi,adxl346		Three-Axis Digital Accelerometer (backward-compatibility value "adi,adxl345" must be listed too)
 ams,iaq-core		AMS iAQ-Core VOC Sensor
-amstaos,tsl2571		AMS/TAOS ALS and proximity sensor
-amstaos,tsl2671		AMS/TAOS ALS and proximity sensor
-amstaos,tmd2671		AMS/TAOS ALS and proximity sensor
-amstaos,tsl2771		AMS/TAOS ALS and proximity sensor
-amstaos,tmd2771		AMS/TAOS ALS and proximity sensor
-amstaos,tsl2572		AMS/TAOS ALS and proximity sensor
-amstaos,tsl2672		AMS/TAOS ALS and proximity sensor
-amstaos,tmd2672		AMS/TAOS ALS and proximity sensor
-amstaos,tsl2772		AMS/TAOS ALS and proximity sensor
-amstaos,tmd2772		AMS/TAOS ALS and proximity sensor
 at,24c08		i2c serial eeprom  (24cxx)
 atmel,at97sc3204t	i2c trusted platform module (TPM)
 capella,cm32181		CM32181: Ambient Light Sensor
-- 
2.17.1

