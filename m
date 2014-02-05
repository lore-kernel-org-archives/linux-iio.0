Return-Path: <slm@iis.fraunhofer.de>
From: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
To: jic23@cam.ac.uk
Cc: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>,
	linux-iio@vger.kernel.org
Subject: [PATCH 1/1] iio: ak8975: Set name
Date: Wed,  5 Feb 2014 11:29:41 +0100
Message-Id: <1391596181-21377-1-git-send-email-manuel.stahl@iis.fraunhofer.de>
List-ID: <linux-iio@vger.kernel.org>

This creates the mandatory name attribute for the device.

Signed-off-by: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
---
 drivers/iio/magnetometer/ak8975.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index ff284e5..c61a764 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -508,6 +508,7 @@ static int ak8975_probe(struct i2c_client *client,
 	mutex_init(&data->lock);
 	data->eoc_gpio = eoc_gpio;
 	indio_dev->dev.parent = &client->dev;
+	indio_dev->name = id->name;
 	indio_dev->channels = ak8975_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ak8975_channels);
 	indio_dev->info = &ak8975_info;
-- 
1.8.3.2
