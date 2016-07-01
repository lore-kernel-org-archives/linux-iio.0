Return-Path: <mranostay@gmail.com>
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	Matt Ranostay <mranostay@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>
Subject: [PATCH] iio: adc: ti-ads1015: add indio_dev->dev.of_node reference
Date: Thu, 30 Jun 2016 19:33:50 -0700
Message-Id: <1467340430-15184-1-git-send-email-mranostay@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Add the pointer to the device tree node of the ADC so that iio
consumers can reference the respective channels.

Cc: Daniel Baluta <daniel.baluta@intel.com>
Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 drivers/iio/adc/ti-ads1015.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 8be192a84893..6f75a4aa67c1 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -585,6 +585,7 @@ static int ads1015_probe(struct i2c_client *client,
 	mutex_init(&data->lock);
 
 	indio_dev->dev.parent = &client->dev;
+	indio_dev->dev.of_node = client->dev.of_node;
 	indio_dev->name = ADS1015_DRV_NAME;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-- 
2.7.4
