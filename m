Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50193 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968341AbdD0PbL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Apr 2017 11:31:11 -0400
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
Subject: [PATCH 5/7] iio: adc: twl4030: Drop struct twl4030_madc_user_parms
Date: Thu, 27 Apr 2017 17:30:10 +0200
Message-Id: <20170427153012.32310-6-sebastian.reichel@collabora.co.uk>
In-Reply-To: <20170427153012.32310-1-sebastian.reichel@collabora.co.uk>
References: <20170427153012.32310-1-sebastian.reichel@collabora.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This struct is no longer used by anything in the kernel.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 include/linux/i2c/twl4030-madc.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/i2c/twl4030-madc.h b/include/linux/i2c/twl4030-madc.h
index be9260e261ac..f395700fb933 100644
--- a/include/linux/i2c/twl4030-madc.h
+++ b/include/linux/i2c/twl4030-madc.h
@@ -135,10 +135,4 @@ enum sample_type {
 #define TWL4030_REG_GPBR1		0x0c
 #define TWL4030_GPBR1_MADC_HFCLK_EN	(1 << 7)
 
-struct twl4030_madc_user_parms {
-	int channel;
-	int average;
-	int status;
-	u16 result;
-};
 #endif
-- 
2.11.0

