Return-Path: <SRS0=vy6h=5P=linux.intel.com=andriy.shevchenko@kernel.org>
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] iio: accel: mma9551: use NULL for GPIO connection ID
Date: Sat, 10 Jun 2017 21:58:41 +0300
Message-Id: <20170610185841.49911-1-andriy.shevchenko@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

While using GPIO library API we might get into troubles in the future,
because we can't rely on label name in the driver since vendor firmware
might provide any GPIO pin there, e.g. "reset", and even mark it in _DSD
(in which case the request will fail).

To avoid inconsistency and potential issues we have two options:
a) generate GPIO ACPI mapping table and supply it via
acpi_dev_add_driver_gpios(), or
b) just pass NULL as connection ID.

The b) approach is much simpler and would work since the driver relies
on GPIO indices only. Moreover, the _CRS fallback mechanism, when
requesting GPIO, is going to be stricter, and supplying non-NULL
connection ID when neither _DSD, nor GPIO ACPI mapping is present, will
make request fail.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/accel/mma9551.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
index bf2704435629..1f53f08476f5 100644
--- a/drivers/iio/accel/mma9551.c
+++ b/drivers/iio/accel/mma9551.c
@@ -27,7 +27,6 @@
 
 #define MMA9551_DRV_NAME		"mma9551"
 #define MMA9551_IRQ_NAME		"mma9551_event"
-#define MMA9551_GPIO_NAME		"mma9551_int"
 #define MMA9551_GPIO_COUNT		4
 
 /* Tilt application (inclination in IIO terms). */
@@ -418,8 +417,7 @@ static int mma9551_gpio_probe(struct iio_dev *indio_dev)
 	struct device *dev = &data->client->dev;
 
 	for (i = 0; i < MMA9551_GPIO_COUNT; i++) {
-		gpio = devm_gpiod_get_index(dev, MMA9551_GPIO_NAME, i,
-					    GPIOD_IN);
+		gpio = devm_gpiod_get_index(dev, NULL, i, GPIOD_IN);
 		if (IS_ERR(gpio)) {
 			dev_err(dev, "acpi gpio get index failed\n");
 			return PTR_ERR(gpio);
-- 
2.11.0
