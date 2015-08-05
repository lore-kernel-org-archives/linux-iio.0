Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:35172 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752200AbbHEJ2W (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 5 Aug 2015 05:28:22 -0400
Received: by lbbpo9 with SMTP id po9so21049921lbb.2
        for <linux-iio@vger.kernel.org>; Wed, 05 Aug 2015 02:28:21 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH] iio: st_common: use standard trigger suffix
Date: Wed,  5 Aug 2015 11:28:15 +0200
Message-Id: <1438766895-15824-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The triggers from ST sensors are named <iio_device_name>-trigger
instead of the standard <iio_device_name>-dev<iio_dev_id> as
used by most and also in the iio-tools. Change this to match
the norm.

After this I can do tests with generic_buffer -n <dev_name>
without having to manually specify the trigger with the -t
option.

Cc: Denis Ciocca <denis.ciocca@st.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/common/st_sensors/st_sensors_trigger.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
index 3e907040c2c7..3c0aa17d753f 100644
--- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
+++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
@@ -24,7 +24,8 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
 	int err;
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
 
-	sdata->trig = iio_trigger_alloc("%s-trigger", indio_dev->name);
+	sdata->trig = iio_trigger_alloc("%s-dev%d",
+					indio_dev->name, indio_dev->id);
 	if (sdata->trig == NULL) {
 		err = -ENOMEM;
 		dev_err(&indio_dev->dev, "failed to allocate iio trigger.\n");
-- 
2.4.3

