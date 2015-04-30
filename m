Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:35002 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389AbbD3NQY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 30 Apr 2015 09:16:24 -0400
Received: by labbd9 with SMTP id bd9so43937516lab.2
        for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2015 06:16:22 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	Denis CIOCCA <denis.ciocca@st.com>
Cc: Lee Jones <lee.jones@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 04/10] iio: st_sensors: make detection more helpful
Date: Thu, 30 Apr 2015 15:15:49 +0200
Message-Id: <1430399755-26475-4-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1430399755-26475-1-git-send-email-linus.walleij@linaro.org>
References: <1430399755-26475-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The ST sensors are detected by reading a WhoAmI register and
matching the number found to a sensor name string. To make it
easier to figure out what happens when things go wrong, print
the WhoAmI value and the device name we're trying to match.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/common/st_sensors/st_sensors_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index cbeb5e01bc3a..1255b157c71c 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -503,7 +503,8 @@ int st_sensors_check_device_support(struct iio_dev *indio_dev,
 			break;
 	}
 	if (n == ARRAY_SIZE(sensor_settings[i].sensors_supported)) {
-		dev_err(&indio_dev->dev, "device name and WhoAmI mismatch.\n");
+		dev_err(&indio_dev->dev, "device name \"%s\" and WhoAmI (0x%02x) mismatch",
+			indio_dev->name, wai);
 		goto sensor_name_mismatch;
 	}
 
-- 
1.9.3

