Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:36537 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752561Ab3IRVrg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 18 Sep 2013 17:47:36 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 1/4] iio: Fix tmp006 dev-to-indio_dev conversion in suspend/resume
Date: Wed, 18 Sep 2013 23:47:30 +0200
Message-Id: <1379540853-15189-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

dev_to_iio_dev() is a false friend

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/temperature/tmp006.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/temperature/tmp006.c b/drivers/iio/temperature/tmp006.c
index 4e95097..84a0789 100644
--- a/drivers/iio/temperature/tmp006.c
+++ b/drivers/iio/temperature/tmp006.c
@@ -252,12 +252,14 @@ static int tmp006_remove(struct i2c_client *client)
 #ifdef CONFIG_PM_SLEEP
 static int tmp006_suspend(struct device *dev)
 {
-	return tmp006_powerdown(iio_priv(dev_to_iio_dev(dev)));
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	return tmp006_powerdown(iio_priv(indio_dev));
 }
 
 static int tmp006_resume(struct device *dev)
 {
-	struct tmp006_data *data = iio_priv(dev_to_iio_dev(dev));
+	struct tmp006_data *data = iio_priv(i2c_get_clientdata(
+		to_i2c_client(dev)));
 	return i2c_smbus_write_word_swapped(data->client, TMP006_CONFIG,
 		data->config | TMP006_CONFIG_MOD_MASK);
 }
-- 
1.8.4

