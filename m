Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:52891 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751809AbdHBXXm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Aug 2017 19:23:42 -0400
Date: Thu, 3 Aug 2017 01:23:35 +0200
From: Andreas Klinger <ak@it-klinger.de>
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org
Subject: [PATCH 1/7] iio: srf08: add device tree binding for srf02 and srf10
Message-ID: <20170802232335.GA15222@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

add trivial device tree binding "devantech,srf02" and "devantech,srf10"

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 Documentation/devicetree/bindings/i2c/trivial-devices.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
index ad10fbe61562..0e5fb016e912 100644
--- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
@@ -36,7 +36,9 @@ dallas,ds1775		Tiny Digital Thermometer and Thermostat
 dallas,ds3232		Extremely Accurate I²C RTC with Integrated Crystal and SRAM
 dallas,ds4510		CPU Supervisor with Nonvolatile Memory and Programmable I/O
 dallas,ds75		Digital Thermometer and Thermostat
+devantech,srf02		Devantech SRF02 ultrasonic ranger in I2C mode
 devantech,srf08		Devantech SRF08 ultrasonic ranger
+devantech,srf10		Devantech SRF10 ultrasonic ranger
 dlg,da9053		DA9053: flexible system level PMIC with multicore support
 dlg,da9063		DA9063: system PMIC for quad-core application processors
 domintech,dmard09	DMARD09: 3-axis Accelerometer
-- 
2.1.4


-- 
Andreas Klinger
Grabenreith 27
84508 Burgkirchen
+49 8623 919966
ak@it-klinger.de
www.it-klinger.de
www.grabenreith.de
