Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:33128 "EHLO
	mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865AbcFXJMQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 24 Jun 2016 05:12:16 -0400
Received: by mail-lf0-f46.google.com with SMTP id f6so111668119lfg.0
        for <linux-iio@vger.kernel.org>; Fri, 24 Jun 2016 02:12:15 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Gregor Boirie <gregor.boirie@parrot.com>,
	Richard Leitner <dev@g0hl1n.net>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5/6 v2] iio: magn: ak8975: make sure to power down at remove()
Date: Fri, 24 Jun 2016 11:11:55 +0200
Message-Id: <1466759516-20586-6-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1466759516-20586-1-git-send-email-linus.walleij@linaro.org>
References: <1466759516-20586-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The code was not powering the magnetometer down properly at
remove(): just cutting the regulators without first setting the
device in power off mode. Fix this.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- New patch in the series after Ulf's review comment that this
  should be separate.
---
 drivers/iio/magnetometer/ak8975.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 2fcd52a49759..7fe92850f43c 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -986,6 +986,7 @@ static int ak8975_remove(struct i2c_client *client)
 
 	iio_device_unregister(indio_dev);
 	iio_triggered_buffer_cleanup(indio_dev);
+	ak8975_set_mode(data, POWER_DOWN);
 	ak8975_power_off(data);
 
 	return 0;
-- 
2.4.11

