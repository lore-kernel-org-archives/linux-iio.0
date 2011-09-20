Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org,
	greg@kroah.com
Cc: Stephen Warren <swarren@nvidia.com>,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 12/14] staging:iio:magnetometer:ak8975: Don't assume 0 is an invalid GPIO
Date: Tue, 20 Sep 2011 17:11:11 +0100
Message-Id: <1316535073-21444-13-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1316535073-21444-1-git-send-email-jic23@cam.ac.uk>
References: <1316535073-21444-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

From: Stephen Warren <swarren@nvidia.com>

gpio_is_valid() is the defined mechanism to determine whether a GPIO is
valid. Use this instead of assuming that 0 is an invalid GPIO.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
Acked-by: Andrew Chew <achew@nvidia.com>
Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/magnetometer/ak8975.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/ak8975.c b/drivers/staging/iio/magnetometer/ak8975.c
index 0e66d3f..9c53383 100644
--- a/drivers/staging/iio/magnetometer/ak8975.c
+++ b/drivers/staging/iio/magnetometer/ak8975.c
@@ -373,7 +373,7 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
 	}
 
 	/* Wait for the conversion to complete. */
-	if (data->eoc_gpio)
+	if (gpio_is_valid(data->eoc_gpio))
 		ret = wait_conversion_complete_gpio(data);
 	else
 		ret = wait_conversion_complete_polled(data);
@@ -484,7 +484,7 @@ static int ak8975_probe(struct i2c_client *client,
 
 	/* We may not have a GPIO based IRQ to scan, that is fine, we will
 	   poll if so */
-	if (eoc_gpio > 0) {
+	if (gpio_is_valid(eoc_gpio)) {
 		err = gpio_request(eoc_gpio, "ak_8975");
 		if (err < 0) {
 			dev_err(&client->dev,
@@ -500,8 +500,7 @@ static int ak8975_probe(struct i2c_client *client,
 						eoc_gpio, err);
 			goto exit_gpio;
 		}
-	} else
-		eoc_gpio = 0;	/* No GPIO available */
+	}
 
 	/* Register with IIO */
 	indio_dev = iio_allocate_device(sizeof(*data));
@@ -537,7 +536,7 @@ static int ak8975_probe(struct i2c_client *client,
 exit_free_iio:
 	iio_free_device(indio_dev);
 exit_gpio:
-	if (eoc_gpio)
+	if (gpio_is_valid(eoc_gpio))
 		gpio_free(eoc_gpio);
 exit:
 	return err;
@@ -551,7 +550,7 @@ static int ak8975_remove(struct i2c_client *client)
 
 	iio_device_unregister(indio_dev);
 
-	if (eoc_gpio)
+	if (gpio_is_valid(eoc_gpio))
 		gpio_free(eoc_gpio);
 
 	return 0;
-- 
1.7.3.4
