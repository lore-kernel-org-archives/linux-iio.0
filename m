Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:63608 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751736AbdKCNES (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 3 Nov 2017 09:04:18 -0400
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 1/5] iio: proximity: sx9500: Assign interrupt from GpioIo()
Date: Fri,  3 Nov 2017 15:03:36 +0200
Message-Id: <20171103130340.42459-1-andriy.shevchenko@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The commit 0f0796509c07

("iio: remove gpio interrupt probing from drivers that use a single interrupt")

removed custom IRQ assignment for the drivers which are enumerated via
ACPI or OF. Unfortunately, some ACPI tables have IRQ line defined as
GpioIo() resource and thus automatic IRQ allocation will fail.

Partially revert the commit 0f0796509c07 to restore original behaviour.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/proximity/sx9500.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
index 53c5d653e780..df23dbcc030a 100644
--- a/drivers/iio/proximity/sx9500.c
+++ b/drivers/iio/proximity/sx9500.c
@@ -869,6 +869,7 @@ static int sx9500_init_device(struct iio_dev *indio_dev)
 static void sx9500_gpio_probe(struct i2c_client *client,
 			      struct sx9500_data *data)
 {
+	struct gpio_desc *gpiod_int;
 	struct device *dev;
 
 	if (!client)
@@ -876,6 +877,14 @@ static void sx9500_gpio_probe(struct i2c_client *client,
 
 	dev = &client->dev;
 
+	if (client->irq <= 0) {
+		gpiod_int = devm_gpiod_get(dev, SX9500_GPIO_INT, GPIOD_IN);
+		if (IS_ERR(gpiod_int))
+			dev_err(dev, "gpio get irq failed\n");
+		else
+			client->irq = gpiod_to_irq(gpiod_int);
+	}
+
 	data->gpiod_rst = devm_gpiod_get(dev, SX9500_GPIO_RESET, GPIOD_OUT_HIGH);
 	if (IS_ERR(data->gpiod_rst)) {
 		dev_warn(dev, "gpio get reset pin failed\n");
-- 
2.14.2

