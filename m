Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:36540 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753034Ab3IRVrg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 18 Sep 2013 17:47:36 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 4/4] iio: Fix tcs3472 dev-to-indio_dev conversion in suspend/resume
Date: Wed, 18 Sep 2013 23:47:33 +0200
Message-Id: <1379540853-15189-4-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1379540853-15189-1-git-send-email-pmeerw@pmeerw.net>
References: <1379540853-15189-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

dev_to_iio_dev() is a false friend

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/light/tcs3472.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
index 7bf2969..0b4ed57 100644
--- a/drivers/iio/light/tcs3472.c
+++ b/drivers/iio/light/tcs3472.c
@@ -330,12 +330,15 @@ static int tcs3472_remove(struct i2c_client *client)
 #ifdef CONFIG_PM_SLEEP
 static int tcs3472_suspend(struct device *dev)
 {
-	return tcs3472_powerdown(iio_priv(dev_to_iio_dev(dev)));
+	struct tcs3472_data *data = iio_priv(i2c_get_clientdata(
+		to_i2c_client(dev)));
+	return tcs3472_powerdown(data);
 }
 
 static int tcs3472_resume(struct device *dev)
 {
-	struct tcs3472_data *data = iio_priv(dev_to_iio_dev(dev));
+	struct tcs3472_data *data = iio_priv(i2c_get_clientdata(
+		to_i2c_client(dev)));
 	return i2c_smbus_write_byte_data(data->client, TCS3472_ENABLE,
 		data->enable | (TCS3472_ENABLE_AEN | TCS3472_ENABLE_PON));
 }
-- 
1.8.4

