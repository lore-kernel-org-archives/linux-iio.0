Return-Path: <SRS0=tIE8=YY=it-klinger.de=ak@kernel.org>
Date: Tue, 10 Jan 2017 16:27:36 +0100
From: Andreas Klinger <ak@it-klinger.de>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	ktsai@capellamicro.com, wsa@the-dreams.de, robh+dt@kernel.org,
	pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	trivial@kernel.org, mranostay@gmail.com, linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: ak@it-klinger.de
Subject: [PATCH 1/2] iio: distance: srf08: add trivial DT binding
Message-ID: <20170110152736.GA29260@andreas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

Add DT binding for devantech,srf08
Add vendor devantech to vendor list

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 Documentation/devicetree/bindings/i2c/trivial-devices.txt | 1 +
 Documentation/devicetree/bindings/vendor-prefixes.txt     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Do=
cumentation/devicetree/bindings/i2c/trivial-devices.txt
index 539874490492..86c6930c3c91 100644
--- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
@@ -36,6 +36,7 @@ dallas,ds1775		Tiny Digital Thermometer and Thermostat
 dallas,ds3232		Extremely Accurate I=C2=B2C RTC with Integrated Crystal and=
 SRAM
 dallas,ds4510		CPU Supervisor with Nonvolatile Memory and Programmable I/O
 dallas,ds75		Digital Thermometer and Thermostat
+devantech,srf08		Devantech SRF08 ultrasonic ranger
 dlg,da9053		DA9053: flexible system level PMIC with multicore support
 dlg,da9063		DA9063: system PMIC for quad-core application processors
 epson,rx8010		I2C-BUS INTERFACE REAL TIME CLOCK MODULE
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Docume=
ntation/devicetree/bindings/vendor-prefixes.txt
index 4696bb5c2198..80325e602403 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -65,6 +65,7 @@ dallas	Maxim Integrated Products (formerly Dallas Semicon=
ductor)
 davicom	DAVICOM Semiconductor, Inc.
 delta	Delta Electronics, Inc.
 denx	Denx Software Engineering
+devantech	Devantech, Ltd.
 digi	Digi International Inc.
 digilent	Diglent, Inc.
 dlg	Dialog Semiconductor
--=20
2.1.4
