Return-Path: <m.niestroj@grinn-global.com>
From: Marcin Niestroj <m.niestroj@grinn-global.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Gregor Boirie <gregor.boirie@parrot.com>,
	Sanchayan Maity <maitysanchayan@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Marcin Niestroj <m.niestroj@grinn-global.com>
Subject: [PATCH 2/2] Documentation: DT: Add bmi160 imu binding
Date: Thu,  3 Nov 2016 12:25:27 +0100
Message-Id: <20161103112527.29623-2-m.niestroj@grinn-global.com>
In-Reply-To: <20161103112527.29623-1-m.niestroj@grinn-global.com>
References: <20161103112527.29623-1-m.niestroj@grinn-global.com>
List-ID: <linux-iio@vger.kernel.org>

This adds documentation for Bosch BMI160 Inertial Measurement Unit
device-tree bindings.

Signed-off-by: Marcin Niestroj <m.niestroj@grinn-global.com>
---
 .../devicetree/bindings/iio/imu/bmi160.txt         | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bmi160.txt

diff --git a/Documentation/devicetree/bindings/iio/imu/bmi160.txt b/Documentation/devicetree/bindings/iio/imu/bmi160.txt
new file mode 100644
index 0000000..b02ef3e
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/imu/bmi160.txt
@@ -0,0 +1,34 @@
+Bosch BMI160 - Inertial Measurement Unit with Accelerometer, Gyroscope
+and externally connectable Magnetometer
+
+https://www.bosch-sensortec.com/bst/products/all_products/bmi160
+
+Required properties:
+ - compatible : should be "bosch,bmi160"
+ - reg : the I2C address or SPI chip select number of the sensor
+ - spi-max-frequency : set maximum clock frequency (only for SPI)
+
+Optional properties:
+ - interrupt-parent : should be the phandle of the interrupt controller
+ - interrupts : interrupt mapping for GPIO IRQ, must be IRQ_TYPE_LEVEL_LOW
+ - interrupt-names : set to "INT2" if using INT2 pin
+
+Examples:
+
+bmi160@68 {
+	compatible = "bosch,bmi160";
+	reg = <0x68>;
+
+	interrupt-parent = <&gpio4>;
+	interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
+};
+
+bmi160@0 {
+	compatible = "bosch,bmi160";
+	reg = <0>;
+	spi-max-frequency = <10000000>;
+
+	interrupt-parent = <&gpio2>;
+	interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
+	interrupt-names = "INT2";
+};
-- 
2.10.1
