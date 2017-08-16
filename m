Return-Path: <SRS0=FVSF=7S=it-klinger.de=ak@kernel.org>
Date: Wed, 16 Aug 2017 21:33:23 +0200
From: Andreas Klinger <ak@it-klinger.de>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org
Cc: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com,
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/5] iio: srf08: add device tree binding for srf02 and
 srf10
Message-ID: <20170816193323.GA24405@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

add trivial device tree binding "devantech,srf02" and "devantech,srf10"

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 Documentation/devicetree/bindings/i2c/trivial-devices.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Do=
cumentation/devicetree/bindings/i2c/trivial-devices.txt
index ad10fbe61562..0e5fb016e912 100644
--- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
@@ -36,7 +36,9 @@ dallas,ds1775		Tiny Digital Thermometer and Thermostat
 dallas,ds3232		Extremely Accurate I=C2=B2C RTC with Integrated Crystal and=
 SRAM
 dallas,ds4510		CPU Supervisor with Nonvolatile Memory and Programmable I/O
 dallas,ds75		Digital Thermometer and Thermostat
+devantech,srf02		Devantech SRF02 ultrasonic ranger in I2C mode
 devantech,srf08		Devantech SRF08 ultrasonic ranger
+devantech,srf10		Devantech SRF10 ultrasonic ranger
 dlg,da9053		DA9053: flexible system level PMIC with multicore support
 dlg,da9063		DA9063: system PMIC for quad-core application processors
 domintech,dmard09	DMARD09: 3-axis Accelerometer
--=20
2.1.4


--=20
