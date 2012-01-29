Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: greg@kroah.com,
	guenter.roeck@ericsson.com,
	khali@linux-fr.org,
	dmitry.torokhov@gmail.com,
	broonie@opensource.wolfsonmicro.com,
	alan@lxorguk.ukuu.org.uk,
	arnd@arndb.de,
	linus.walleij@linaro.org,
	maxime.ripard@free-electrons.com,
	thomas.petazzoni@free-electrons.com,
	zdevai@gmail.com,
	w.sang@pengutronix.de,
	marek.vasut@gmail.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 5/5] stargate2: example of map configuration for iio to hwmon example.
Date: Sun, 29 Jan 2012 11:46:54 +0000
Message-Id: <1327837614-24176-6-git-send-email-jic23@kernel.org>
In-Reply-To: <1327837614-24176-1-git-send-email-jic23@kernel.org>
References: <1327837614-24176-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

From: Jonathan Cameron <jic23@cam.ac.uk>

Do not commit.
---
 arch/arm/mach-pxa/stargate2.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/stargate2.c b/arch/arm/mach-pxa/stargate2.c
index b0656e15..d2d9a27 100644
--- a/arch/arm/mach-pxa/stargate2.c
+++ b/arch/arm/mach-pxa/stargate2.c
@@ -54,6 +54,8 @@
 #include <linux/mfd/da903x.h>
 #include <linux/sht15.h>
 
+#include "../../../drivers/staging/iio/machine.h"
+
 #include "devices.h"
 #include "generic.h"
 
@@ -406,6 +408,23 @@ static struct i2c_pxa_platform_data i2c_pdata = {
 	.fast_mode = 1,
 };
 
+static struct platform_device iio_hwmon_test = {
+	.name = "iio_hwmon",
+};
+
+static struct iio_map max1363_consumer_map[] = {
+	{
+		.adc_channel_label = "AIN1",
+		.consumer_dev = &iio_hwmon_test.dev,
+		.consumer_channel = "testchan1",
+	}, {
+		.adc_channel_label = "AIN2",
+		.consumer_dev = &iio_hwmon_test.dev,
+		.consumer_channel = "testchan2",
+	},
+	{}
+};
+
 static void __init imote2_stargate2_init(void)
 {
 
@@ -561,6 +580,7 @@ static struct i2c_board_info __initdata imote2_i2c_board_info[] = {
 		 * pull up resistors are missing.
 		 */
 		.irq = PXA_GPIO_TO_IRQ(99),
+		.platform_data = max1363_consumer_map,
 	}, { /* ITS400 Sensor board only */
 		.type = "tsl2561",
 		.addr = 0x49,
@@ -945,6 +965,7 @@ static struct i2c_board_info __initdata stargate2_i2c_board_info[] = {
 		 * pull up resistors are missing.
 		 */
 		.irq = PXA_GPIO_TO_IRQ(99),
+		.platform_data = max1363_consumer_map,
 	}, { /* ITS400 Sensor board only */
 		.type = "tsl2561",
 		.addr = 0x49,
@@ -977,6 +998,7 @@ static struct platform_device *stargate2_devices[] = {
 	&stargate2_sram,
 	&smc91x_device,
 	&sht15,
+	&iio_hwmon_test,
 };
 
 static void __init stargate2_init(void)
-- 
1.7.8.4
