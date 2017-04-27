Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50175 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968291AbdD0Pap (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Apr 2017 11:30:45 -0400
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
Subject: [PATCH 3/7] iio: adc: twl4030: Drop twl4030_get_madc_conversion()
Date: Thu, 27 Apr 2017 17:30:08 +0200
Message-Id: <20170427153012.32310-4-sebastian.reichel@collabora.co.uk>
In-Reply-To: <20170427153012.32310-1-sebastian.reichel@collabora.co.uk>
References: <20170427153012.32310-1-sebastian.reichel@collabora.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Drop legacy twl4030_get_madc_conversion() method. It has been
used by drivers to get madc data before it conversion to IIO
API. There are no users in the mainline kernel anymore.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 drivers/iio/adc/twl4030-madc.c   | 21 ---------------------
 include/linux/i2c/twl4030-madc.h |  1 -
 2 files changed, 22 deletions(-)

diff --git a/drivers/iio/adc/twl4030-madc.c b/drivers/iio/adc/twl4030-madc.c
index 0c74869a540a..88e44066ef82 100644
--- a/drivers/iio/adc/twl4030-madc.c
+++ b/drivers/iio/adc/twl4030-madc.c
@@ -642,27 +642,6 @@ int twl4030_madc_conversion(struct twl4030_madc_request *req)
 }
 EXPORT_SYMBOL_GPL(twl4030_madc_conversion);
 
-int twl4030_get_madc_conversion(int channel_no)
-{
-	struct twl4030_madc_request req;
-	int temp = 0;
-	int ret;
-
-	req.channels = (1 << channel_no);
-	req.method = TWL4030_MADC_SW2;
-	req.active = 0;
-	req.raw = 0;
-	req.func_cb = NULL;
-	ret = twl4030_madc_conversion(&req);
-	if (ret < 0)
-		return ret;
-	if (req.rbuf[channel_no] > 0)
-		temp = req.rbuf[channel_no];
-
-	return temp;
-}
-EXPORT_SYMBOL_GPL(twl4030_get_madc_conversion);
-
 /**
  * twl4030_madc_set_current_generator() - setup bias current
  *
diff --git a/include/linux/i2c/twl4030-madc.h b/include/linux/i2c/twl4030-madc.h
index 1c0134dd3271..0c919ebb31e0 100644
--- a/include/linux/i2c/twl4030-madc.h
+++ b/include/linux/i2c/twl4030-madc.h
@@ -143,5 +143,4 @@ struct twl4030_madc_user_parms {
 };
 
 int twl4030_madc_conversion(struct twl4030_madc_request *conv);
-int twl4030_get_madc_conversion(int channel_no);
 #endif
-- 
2.11.0

