Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43223 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbeKSQfQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Nov 2018 11:35:16 -0500
Received: by mail-pg1-f193.google.com with SMTP id v28so2845015pgk.10
        for <linux-iio@vger.kernel.org>; Sun, 18 Nov 2018 22:12:40 -0800 (PST)
From: Jian-Hong Pan <jian-hong@endlessm.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@endlessm.com, Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [PATCH] iio: st_sensors: Fix the sleep time for sampling
Date: Mon, 19 Nov 2018 14:12:19 +0800
Message-Id: <20181119061219.14238-1-jian-hong@endlessm.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

According to the description of st_sensor_settings and st_sensor_data
structures' comments:
- bootime: samples to discard when sensor passing from power-down to
power-up.
- odr: Output data rate of the sensor [Hz].

The sleep time should be
sdata->sensor_settings->bootime + 1000 / sdata->odr ms.

Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
---
 drivers/iio/common/st_sensors/st_sensors_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index 26fbd1bd9413..6b87ea657a92 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -594,7 +594,7 @@ int st_sensors_read_info_raw(struct iio_dev *indio_dev,
 		if (err < 0)
 			goto out;
 
-		msleep((sdata->sensor_settings->bootime * 1000) / sdata->odr);
+		msleep(sdata->sensor_settings->bootime + 1000 / sdata->odr);
 		err = st_sensors_read_axis_data(indio_dev, ch, val);
 		if (err < 0)
 			goto out;
-- 
2.11.0
