Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:44959 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753031AbdIISfO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 9 Sep 2017 14:35:14 -0400
Message-Id: <c5a93c6dd0859cb8ed093e222970cdca3a61aa9a.1504807204.git.lukas@wunner.de>
In-Reply-To: <cover.1504807204.git.lukas@wunner.de>
References: <cover.1504807204.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 9 Sep 2017 20:32:41 +0200
Subject: [PATCH v2 6/6 INFORMATIONAL/RFT] iio: adc: mcp320x: Support continuous conversion mode
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mathias Duckeck <m.duckeck@kunbus.de>,
        Phil Elwell <phil@raspberrypi.org>,
        Oskar Andero <oskar.andero@gmail.com>,
        Andrea Galbusera <gizero@gmail.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Manfred Schlaegl <manfred.schlaegl@gmx.at>,
        Michael Welling <mwelling@ieee.org>,
        Soeren Andersen <san@rosetechnology.dk>,
        linux-iio@vger.kernel.org
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The MCP3550/1/3 can be run in "continuous conversion mode", allowing
conversions to be fetched at any time without observing a delay,
at the expense of higher energy consumption.

The mode is enabled by permanently driving CS low, e.g. by wiring it to
ground.  This requires either exclusive bus usage by the chip or that
CLK and MISO are AND-gated with the CS signal coming from the master.

I only have boards available which use the chip in single conversion
mode, so cannot test its behaviour in continuous conversion mode.
I am putting this commit out there as a basis for others to work on.
It introduces a device property to indicate that continuous conversion
mode is enabled permanently.

In theory it may also be possible to enter the mode temporarily, e.g. as
long as the chardev is opened:  Setting the cs_change bit of transfer[1]
in struct mcp320x should enter the mode, clearing the bit should exit it.
However as can be seen in mcp320x_probe(), a magic sequence of two
consecutive conversions is sometimes necessary to switch from continuous
to single conversion mode lest the chip remains stuck in shutdown.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
Changes since v1:
- Move support for continuous conversion mode to separate patch
  which is marked informational / not for merging.  Rename device
  property to "continuous" for consistency with the existing
  similar property of drivers/iio/light/us5182d.c. (Rob, Jonathan)

 Documentation/devicetree/bindings/iio/adc/mcp320x.txt | 9 +++++++++
 drivers/iio/adc/mcp320x.c                             | 8 +++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/mcp320x.txt b/Documentation/devicetree/bindings/iio/adc/mcp320x.txt
index 7d64753df949..cf28af9ec0ac 100644
--- a/Documentation/devicetree/bindings/iio/adc/mcp320x.txt
+++ b/Documentation/devicetree/bindings/iio/adc/mcp320x.txt
@@ -46,6 +46,15 @@ Required properties:
 
 	- vref-supply:	Phandle to the external reference voltage supply.
 
+Optional properties:
+	- microchip,continuous (boolean):
+			Only applicable to MCP3550/1/3:  These ADCs have long
+			conversion times and therefore support "continuous
+			conversion mode" to allow retrieval of conversions
+			at any time without observing a delay.  The mode is
+			enabled by permanently driving CS low, e.g. by wiring
+			it to ground.
+
 Examples:
 spi_controller {
 	mcp3x0x@0 {
diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
index a04856d8afdb..446700ea6110 100644
--- a/drivers/iio/adc/mcp320x.c
+++ b/drivers/iio/adc/mcp320x.c
@@ -77,6 +77,9 @@ struct mcp320x_chip_info {
  * @transfer: SPI transfers used by @msg
  * @start_conv_msg: SPI message to start a conversion by briefly asserting CS
  * @start_conv_transfer: SPI transfer used by @start_conv_msg
+ * @continuous_conv: whether CS is permanently driven low such that conversions
+ *	take place continuously, obviating the need to explicitly start them
+ *	and wait for them to finish
  * @reg: regulator generating Vref
  * @lock: protects read sequences
  * @chip_info: ADC properties
@@ -89,6 +92,7 @@ struct mcp320x {
 	struct spi_transfer transfer[2];
 	struct spi_message start_conv_msg;
 	struct spi_transfer start_conv_transfer;
+	bool continuous_conv;
 
 	struct regulator *reg;
 	struct mutex lock;
@@ -124,7 +128,7 @@ static int mcp320x_adc_conversion(struct mcp320x *adc, u8 channel,
 {
 	int ret;
 
-	if (adc->chip_info->conv_time) {
+	if (adc->chip_info->conv_time && !adc->continuous_conv) {
 		ret = spi_sync(adc->spi, &adc->start_conv_msg);
 		if (ret < 0)
 			return ret;
@@ -427,6 +431,8 @@ static int mcp320x_probe(struct spi_device *spi)
 		adc->start_conv_transfer.delay_usecs = 8;
 		spi_message_init_with_transfers(&adc->start_conv_msg,
 						&adc->start_conv_transfer, 1);
+		adc->continuous_conv = device_property_read_bool(&spi->dev,
+						      "microchip,continuous");
 
 		/*
 		 * If CS was previously kept low (continuous conversion mode)
-- 
2.11.0

