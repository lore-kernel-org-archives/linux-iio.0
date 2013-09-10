Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ee0-f41.google.com ([74.125.83.41]:61453 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752489Ab3IJMuK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 10 Sep 2013 08:50:10 -0400
Received: by mail-ee0-f41.google.com with SMTP id d17so3892961eek.0
        for <linux-iio@vger.kernel.org>; Tue, 10 Sep 2013 05:50:09 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	jic23@cam.ac.uk
Cc: arnd@arndb.de, linus.walleij@linaro.org, denis.ciocca@st.com,
	linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 22/38] iio: sensors-core: st: Clean-up error handling in st_sensors_read_info_raw()
Date: Tue, 10 Sep 2013 13:49:23 +0100
Message-Id: <1378817379-8238-23-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
References: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Saving a few lines of code.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/common/st_sensors/st_sensors_core.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index 148f0e5..25d4c7e 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -359,28 +359,25 @@ int st_sensors_read_info_raw(struct iio_dev *indio_dev,
 	mutex_lock(&indio_dev->mlock);
 	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
 		err = -EBUSY;
-		goto read_error;
+		goto out;
 	} else {
 		err = st_sensors_set_enable(indio_dev, true);
 		if (err < 0)
-			goto read_error;
+			goto out;
 
 		msleep((sdata->sensor->bootime * 1000) / sdata->odr);
 		err = st_sensors_read_axis_data(indio_dev, ch, val);
 		if (err < 0)
-			goto read_error;
+			goto out;
 
 		*val = *val >> ch->scan_type.shift;
 
 		err = st_sensors_set_enable(indio_dev, false);
 	}
+out:
 	mutex_unlock(&indio_dev->mlock);
 
 	return err;
-
-read_error:
-	mutex_unlock(&indio_dev->mlock);
-	return err;
 }
 EXPORT_SYMBOL(st_sensors_read_info_raw);
 
-- 
1.8.1.2

