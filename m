Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33954 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952AbcCEGza (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Mar 2016 01:55:30 -0500
Received: by mail-pa0-f45.google.com with SMTP id fy10so47029575pac.1
        for <linux-iio@vger.kernel.org>; Fri, 04 Mar 2016 22:55:30 -0800 (PST)
From: Matt Ranostay <mranostay@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH] iio: potentiometer: tpl0102: change i2c functionality return code
Date: Fri,  4 Mar 2016 22:55:25 -0800
Message-Id: <1457160925-20254-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Change i2c_check_functionality condition check return from ENOTSUPP to
EOPNOTSUPP which is now the standard return code.

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 drivers/iio/potentiometer/tpl0102.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/potentiometer/tpl0102.c b/drivers/iio/potentiometer/tpl0102.c
index 313124b..5c304d4 100644
--- a/drivers/iio/potentiometer/tpl0102.c
+++ b/drivers/iio/potentiometer/tpl0102.c
@@ -118,7 +118,7 @@ static int tpl0102_probe(struct i2c_client *client,
 
 	if (!i2c_check_functionality(client->adapter,
 				     I2C_FUNC_SMBUS_WORD_DATA))
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
-- 
2.7.0

