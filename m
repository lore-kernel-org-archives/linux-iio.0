Return-Path: <SRS0=RlyY=LM=analog.com=StefanSerban.Popa@kernel.org>
From: Stefan Popa <stefan.popa@analog.com>
To: <jic23@kernel.org>, <robh+dt@kernel.org>
CC: <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
	<mark.rutland@arm.com>, <Michael.Hennerich@analog.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Stefan Popa <stefan.popa@analog.com>
Subject: [PATCH] iio: dac: ad5758: Add support for hard reset
Date: Wed, 29 Aug 2018 17:58:42 +0300
Message-ID: <1535554722-1094-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

The ad5758 has a hardware reset active low input pin. This patch adds a
devicetree entry for a reset GPIO and a new ad5758_reset() function.
During
initialization, it is checked if the reset property is specified and the
the GPIO is being asserted, therefore the device will become active.

When the reset function is called, if the gpio_reset var is set, then
the
GPIO will be toggled, otherwise a software reset is performed.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 .../devicetree/bindings/iio/dac/ad5758.txt         |  5 ++++
 drivers/iio/dac/ad5758.c                           | 27 ++++++++++++++++++++--
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/ad5758.txt b/Documentation/devicetree/bindings/iio/dac/ad5758.txt
index bba01a5..bbcd789 100644
--- a/Documentation/devicetree/bindings/iio/dac/ad5758.txt
+++ b/Documentation/devicetree/bindings/iio/dac/ad5758.txt
@@ -50,6 +50,9 @@ Required properties:
 
 Optional properties:
 
+ - reset-gpios : GPIO spec for the RESET pin. If specified, it will be
+ 		 asserted during driver probe.
+
  - adi,dc-dc-ilim-microamp: The dc-to-dc converter current limit
 		   The following values are currently supported [uA]:
 			* 150000
@@ -71,6 +74,8 @@ AD5758 Example:
 		spi-max-frequency = <1000000>;
 		spi-cpha;
 
+		reset-gpios = <&gpio 22 0>;
+
 		adi,dc-dc-mode = <2>;
 		adi,range-microvolt = <0 10000000>;
 		adi,dc-dc-ilim-microamp = <200000>;
diff --git a/drivers/iio/dac/ad5758.c b/drivers/iio/dac/ad5758.c
index bd36333..b5cc5bd 100644
--- a/drivers/iio/dac/ad5758.c
+++ b/drivers/iio/dac/ad5758.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/property.h>
 #include <linux/spi/spi.h>
+#include <linux/gpio/consumer.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -108,6 +109,7 @@ struct ad5758_range {
 struct ad5758_state {
 	struct spi_device *spi;
 	struct mutex lock;
+	struct gpio_desc *gpio_reset;
 	struct ad5758_range out_range;
 	unsigned int dc_dc_mode;
 	unsigned int dc_dc_ilim;
@@ -474,6 +476,22 @@ static int ad5758_internal_buffers_en(struct ad5758_state *st, bool enable)
 					     AD5758_CAL_MEM_UNREFRESHED_MSK);
 }
 
+static int ad5758_reset(struct ad5758_state *st)
+{
+	if (st->gpio_reset) {
+		gpiod_set_value(st->gpio_reset, 0);
+		usleep_range(100, 1000);
+		gpiod_set_value(st->gpio_reset, 1);
+	} else {
+		/* Perform a software reset */
+		return ad5758_soft_reset(st);
+	}
+
+	usleep_range(100, 1000);
+
+	return 0;
+}
+
 static int ad5758_reg_access(struct iio_dev *indio_dev,
 			     unsigned int reg,
 			     unsigned int writeval,
@@ -768,13 +786,18 @@ static int ad5758_init(struct ad5758_state *st)
 {
 	int regval, ret;
 
+	st->gpio_reset = devm_gpiod_get_optional(&st->spi->dev, "reset",
+						 GPIOD_OUT_HIGH);
+	if (IS_ERR(st->gpio_reset))
+		return PTR_ERR(st->gpio_reset);
+
 	/* Disable CRC checks */
 	ret = ad5758_crc_disable(st);
 	if (ret < 0)
 		return ret;
 
-	/* Perform a software reset */
-	ret = ad5758_soft_reset(st);
+	/* Perform a reset */
+	ret = ad5758_reset(st);
 	if (ret < 0)
 		return ret;
 
-- 
2.7.4
