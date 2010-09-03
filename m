Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45964 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753271Ab0ICKHd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 3 Sep 2010 06:07:33 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o83A7UYt008756
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-iio@vger.kernel.org>; Fri, 3 Sep 2010 05:07:32 -0500
From: Shubhrajyoti D <shubhrajyoti@ti.com>
To: linux-iio@vger.kernel.org
Cc: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH] iio: hmc5843 : trivial changes to the way scale is reported
Date: Fri,  3 Sep 2010 15:37:28 +0530
Message-Id: <1283508448-19664-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/staging/iio/magnetometer/hmc5843.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index 66aab5a..b35b443 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -465,7 +465,7 @@ static ssize_t show_scale(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct hmc5843_data *data = indio_dev->dev_data;
-	return strlen(strcpy(buf, regval_to_scale[data->range]));
+	return sprintf(buf, "%s\n", regval_to_scale[data->range]);
 }
 static IIO_DEVICE_ATTR(magn_scale,
 			S_IRUGO,
-- 
1.7.0.4

