Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kapsi.fi ([217.30.184.167]:43621 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751188AbdEELU5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 5 May 2017 07:20:57 -0400
From: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
To: jic23@kernel.org
Cc: pmeerw@pmeerw.net, knaack.h@gmx.de, lars@metafoo.de,
        Daniel Baluta <daniel.baluta@intel.com>,
        linux-iio@vger.kernel.org,
        Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
Subject: [PATCH v3 2/9] iio: light: rpr0521 poweroff for probe fails
Date: Fri,  5 May 2017 14:19:46 +0300
Message-Id: <1493983193-8753-2-git-send-email-mikko.koivunen@fi.rohmeurope.com>
In-Reply-To: <1493983193-8753-1-git-send-email-mikko.koivunen@fi.rohmeurope.com>
References: <1493983193-8753-1-git-send-email-mikko.koivunen@fi.rohmeurope.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Set sensor measurement off after probe fail in pm_runtime_set_active() or
iio_device_register(). Without this change sensor measurement stays on
even though probe fails on these calls.

This is maybe rare case, but causes constant power drain without any
benefits when it happens. Power drain is 20-500uA, typically 180uA.

Signed-off-by: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
---
Sensor measurement is turned on rpr0521_init() so in probe it should be
turned off in error cases after that. With CONFIG_PM it's probably
unnecessary for iio_device_register()-fail, but without CONFIG_PM it is
needed. Writing power off twice when CONFIG_PM enabled is ok.

 drivers/iio/light/rpr0521.c |   17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
index 03504f6..5d077f4 100644
--- a/drivers/iio/light/rpr0521.c
+++ b/drivers/iio/light/rpr0521.c
@@ -516,13 +516,26 @@ static int rpr0521_probe(struct i2c_client *client,
 
 	ret = pm_runtime_set_active(&client->dev);
 	if (ret < 0)
-		return ret;
+		goto err_poweroff;
 
 	pm_runtime_enable(&client->dev);
 	pm_runtime_set_autosuspend_delay(&client->dev, RPR0521_SLEEP_DELAY_MS);
 	pm_runtime_use_autosuspend(&client->dev);
 
-	return iio_device_register(indio_dev);
+	ret = iio_device_register(indio_dev);
+	if (ret)
+		goto err_pm_disable;
+
+	return 0;
+
+err_pm_disable:
+	pm_runtime_disable(&client->dev);
+	pm_runtime_set_suspended(&client->dev);
+	pm_runtime_put_noidle(&client->dev);
+err_poweroff:
+	(void) rpr0521_poweroff(data);
+
+	return ret;
 }
 
 static int rpr0521_remove(struct i2c_client *client)
-- 
1.7.9.5

