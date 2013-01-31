Return-Path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>
Cc: devicetree-discuss@lists.ozlabs.org,
	Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Doug Anderson <dianders@chromium.org>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 05/11] iio/adc: (max1363) Provide OF node information to iio device
Date: Thu, 31 Jan 2013 13:43:02 -0800
Message-Id: <1359668588-13678-6-git-send-email-linux@roeck-us.net>
In-Reply-To: <1359668588-13678-1-git-send-email-linux@roeck-us.net>
References: <1359668588-13678-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/iio/adc/max1363.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index 03b25b3..ca8bbc1 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -1538,6 +1538,7 @@ static int max1363_probe(struct i2c_client *client,
 		goto error_out;
 	}
 
+	indio_dev->dev.of_node = client->dev.of_node;
 	ret = iio_map_array_register(indio_dev, client->dev.platform_data);
 	if (ret < 0)
 		goto error_free_device;
-- 
1.7.9.7
