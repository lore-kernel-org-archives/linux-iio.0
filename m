Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50186 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967351AbdD0Pan (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Apr 2017 11:30:43 -0400
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Sebastian Reichel <sre@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc: J Keerthy <j-keerthy@ti.com>, linux-iio@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCH 4/7] iio: adc: twl4030: Unexport twl4030_madc_conversion()
Date: Thu, 27 Apr 2017 17:30:09 +0200
Message-Id: <20170427153012.32310-5-sebastian.reichel@collabora.co.uk>
In-Reply-To: <20170427153012.32310-1-sebastian.reichel@collabora.co.uk>
References: <20170427153012.32310-1-sebastian.reichel@collabora.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

All madc users have been converted to IIO API, so drop the
legacy API. The function is still used inside of the driver.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 drivers/iio/adc/twl4030-madc.c   | 5 +++--
 include/linux/i2c/twl4030-madc.h | 2 --
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/twl4030-madc.c b/drivers/iio/adc/twl4030-madc.c
index 88e44066ef82..be60f76d1a50 100644
--- a/drivers/iio/adc/twl4030-madc.c
+++ b/drivers/iio/adc/twl4030-madc.c
@@ -72,6 +72,8 @@ struct twl4030_madc_data {
 	u8 isr;
 };
 
+static int twl4030_madc_conversion(struct twl4030_madc_request *req);
+
 static int twl4030_madc_read(struct iio_dev *iio_dev,
 			     const struct iio_chan_spec *chan,
 			     int *val, int *val2, long mask)
@@ -568,7 +570,7 @@ static int twl4030_madc_wait_conversion_ready(struct twl4030_madc_data *madc,
  * be a negative error value in the corresponding array element.
  * returns 0 if succeeds else error value
  */
-int twl4030_madc_conversion(struct twl4030_madc_request *req)
+static int twl4030_madc_conversion(struct twl4030_madc_request *req)
 {
 	const struct twl4030_madc_conversion_method *method;
 	int ret;
@@ -640,7 +642,6 @@ int twl4030_madc_conversion(struct twl4030_madc_request *req)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(twl4030_madc_conversion);
 
 /**
  * twl4030_madc_set_current_generator() - setup bias current
diff --git a/include/linux/i2c/twl4030-madc.h b/include/linux/i2c/twl4030-madc.h
index 0c919ebb31e0..be9260e261ac 100644
--- a/include/linux/i2c/twl4030-madc.h
+++ b/include/linux/i2c/twl4030-madc.h
@@ -141,6 +141,4 @@ struct twl4030_madc_user_parms {
 	int status;
 	u16 result;
 };
-
-int twl4030_madc_conversion(struct twl4030_madc_request *conv);
 #endif
-- 
2.11.0

