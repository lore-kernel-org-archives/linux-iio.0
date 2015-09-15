Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:36673 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614AbbIOHtv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 15 Sep 2015 03:49:51 -0400
Received: by lbcao8 with SMTP id ao8so79945966lbc.3
        for <linux-iio@vger.kernel.org>; Tue, 15 Sep 2015 00:49:49 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Denis Ciocca <denis.ciocca@st.com>
Subject: [RESEND PATCH 4/4] iio: st_common: use standard trigger suffix
Date: Tue, 15 Sep 2015 09:49:45 +0200
Message-Id: <1442303385-11905-1-git-send-email-linus.walleij@linaro.org>
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

