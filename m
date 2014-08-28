Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:41474 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751816AbaH1NOc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 28 Aug 2014 09:14:32 -0400
Received: by mail-ie0-f174.google.com with SMTP id at20so874816iec.5
        for <linux-iio@vger.kernel.org>; Thu, 28 Aug 2014 06:14:31 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Lee Jones <lee.jones@linaro.org>, jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH 01/11] iio: sensors-core: st: Check st_sensors_set_drdy_int_pin()'s return value
Date: Thu, 28 Aug 2014 14:14:07 +0100
Message-Id: <1409231657-18294-1-git-send-email-lee.jones@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Value from st_sensors_set_drdy_int_pin() is assigned to err here,
but that stored value is not used before it is overwritten.  To fix
this we're enforcing a check on st_sensors_set_drdy_int_pin()'s
return value and if it's an error, we're returning right away.

Cc: jic23@kernel.org
Cc: linux-iio@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/common/st_sensors/st_sensors_core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index 8a4ec00..24cfe4e 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -306,8 +306,11 @@ int st_sensors_init_sensor(struct iio_dev *indio_dev,
 	if (of_pdata)
 		pdata = of_pdata;
 
-	if (pdata)
+	if (pdata) {
 		err = st_sensors_set_drdy_int_pin(indio_dev, pdata);
+		if (err < 0)
+			return err;
+	}
 
 	err = st_sensors_set_enable(indio_dev, false);
 	if (err < 0)
-- 
1.9.1

