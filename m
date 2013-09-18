Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:36538 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752870Ab3IRVrg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 18 Sep 2013 17:47:36 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>,
	Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
Subject: [PATCH 2/4] iio: Fix bma180 dev-to-indio_dev conversion in suspend/resume
Date: Wed, 18 Sep 2013 23:47:31 +0200
Message-Id: <1379540853-15189-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1379540853-15189-1-git-send-email-pmeerw@pmeerw.net>
References: <1379540853-15189-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

dev_to_iio_dev() is a false friend

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
---
 drivers/iio/accel/bma180.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index 3eff246..9b0ad23 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -620,7 +620,7 @@ static int bma180_remove(struct i2c_client *client)
 #ifdef CONFIG_PM_SLEEP
 static int bma180_suspend(struct device *dev)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct bma180_data *data = iio_priv(indio_dev);
 	int ret;
 
@@ -633,7 +633,7 @@ static int bma180_suspend(struct device *dev)
 
 static int bma180_resume(struct device *dev)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct bma180_data *data = iio_priv(indio_dev);
 	int ret;
 
-- 
1.8.4

