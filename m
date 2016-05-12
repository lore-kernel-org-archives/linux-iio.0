Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:34954 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717AbcELEry (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 12 May 2016 00:47:54 -0400
Received: by mail-pa0-f65.google.com with SMTP id zy2so6037997pac.2
        for <linux-iio@vger.kernel.org>; Wed, 11 May 2016 21:47:53 -0700 (PDT)
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH] iio: potentiometer: tpl0102: remove unneeded i2c check functionality test
Date: Wed, 11 May 2016 21:47:48 -0700
Message-Id: <1463028468-13880-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Actually I2C_FUNC_SMBUS_WORD_DATA isn't need for this device, and regmap
handles all single byte reads transparently.

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 drivers/iio/potentiometer/tpl0102.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iio/potentiometer/tpl0102.c b/drivers/iio/potentiometer/tpl0102.c
index 5c304d4..7b6b545 100644
--- a/drivers/iio/potentiometer/tpl0102.c
+++ b/drivers/iio/potentiometer/tpl0102.c
@@ -116,10 +116,6 @@ static int tpl0102_probe(struct i2c_client *client,
 	struct tpl0102_data *data;
 	struct iio_dev *indio_dev;
 
-	if (!i2c_check_functionality(client->adapter,
-				     I2C_FUNC_SMBUS_WORD_DATA))
-		return -EOPNOTSUPP;
-
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
-- 
2.7.4

