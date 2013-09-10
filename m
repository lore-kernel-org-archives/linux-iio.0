Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ee0-f50.google.com ([74.125.83.50]:50760 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752402Ab3IJMuI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 10 Sep 2013 08:50:08 -0400
Received: by mail-ee0-f50.google.com with SMTP id d51so3817214eek.23
        for <linux-iio@vger.kernel.org>; Tue, 10 Sep 2013 05:50:07 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	jic23@cam.ac.uk
Cc: arnd@arndb.de, linus.walleij@linaro.org, denis.ciocca@st.com,
	linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 20/38] iio: sensors-core: st: Clean-up error handling in st_sensors_init_sensor()
Date: Tue, 10 Sep 2013 13:49:21 +0100
Message-Id: <1378817379-8238-21-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
References: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Strip out all those unnecessary gotos and just return the error right away.

Aids to simplicity and reduces code.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/common/st_sensors/st_sensors_core.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index b86cad2..8c4c54c 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -208,8 +208,7 @@ int st_sensors_set_drdy_int_pin(struct iio_dev *indio_dev,
 		if (sdata->sensor->drdy_irq.mask_int1 == 0) {
 			dev_err(&indio_dev->dev,
 					"DRDY on INT1 not available.\n");
-			err = -EINVAL;
-			goto init_error;
+			return -EINVAL;
 		}
 		sdata->drdy_int_pin = 1;
 		break;
@@ -217,15 +216,13 @@ int st_sensors_set_drdy_int_pin(struct iio_dev *indio_dev,
 		if (sdata->sensor->drdy_irq.mask_int2 == 0) {
 			dev_err(&indio_dev->dev,
 					"DRDY on INT2 not available.\n");
-			err = -EINVAL;
-			goto init_error;
+			return -EINVAL;
 		}
 		sdata->drdy_int_pin = 2;
 		break;
 	default:
 		dev_err(&indio_dev->dev, "DRDY on pdata not valid.\n");
-		err = -EINVAL;
-		goto init_error;
+		return -EINVAL;
 	}
 
 	return 0;
@@ -244,29 +241,28 @@ int st_sensors_init_sensor(struct iio_dev *indio_dev,
 
 	err = st_sensors_set_enable(indio_dev, false);
 	if (err < 0)
-		goto init_error;
+		return err;
 
 	if (sdata->current_fullscale) {
 		err = st_sensors_set_fullscale(indio_dev,
 					       sdata->current_fullscale->num);
 		if (err < 0)
-			goto init_error;
+			return err;
 	} else
 		dev_info(&indio_dev->dev, "Full-scale not possible\n");
 
 	err = st_sensors_set_odr(indio_dev, sdata->odr);
 	if (err < 0)
-		goto init_error;
+		return err;
 
 	/* set BDU */
 	err = st_sensors_write_data_with_mask(indio_dev,
 			sdata->sensor->bdu.addr, sdata->sensor->bdu.mask, true);
 	if (err < 0)
-		goto init_error;
+		return err;
 
 	err = st_sensors_set_axis_enable(indio_dev, ST_SENSORS_ENABLE_ALL_AXIS);
 
-init_error:
 	return err;
 }
 EXPORT_SYMBOL(st_sensors_init_sensor);
-- 
1.8.1.2

