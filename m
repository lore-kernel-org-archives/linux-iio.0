Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:47553 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756076Ab3DWJGu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 23 Apr 2013 05:06:50 -0400
Received: by mail-pd0-f176.google.com with SMTP id r11so305089pdi.7
        for <linux-iio@vger.kernel.org>; Tue, 23 Apr 2013 02:06:49 -0700 (PDT)
Message-ID: <1366708003.10246.1.camel@phoenix>
Subject: [PATCH] hwmon: (iio_hwmon) Fix missing iio_channel_release_all call
 if devm_kzalloc fail
From: Axel Lin <axel.lin@ingics.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Jean Delvare <khali@linux-fr.org>,
	Guenter Roeck <linux@roeck-us.net>, lm-sensors@lm-sensors.org,
	linux-iio@vger.kernel.org
Date: Tue, 23 Apr 2013 17:06:43 +0800
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/iio_hwmon.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/iio_hwmon.c b/drivers/hwmon/iio_hwmon.c
index aafa453..368497f 100644
--- a/drivers/hwmon/iio_hwmon.c
+++ b/drivers/hwmon/iio_hwmon.c
@@ -84,8 +84,10 @@ static int iio_hwmon_probe(struct platform_device *pdev)
 		return PTR_ERR(channels);
 
 	st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
-	if (st == NULL)
-		return -ENOMEM;
+	if (st == NULL) {
+		ret = -ENOMEM;
+		goto error_release_channels;
+	}
 
 	st->channels = channels;
 
-- 
1.7.10.4



