Return-Path: <SRS0=1Gah=5U=kapsi.fi=mikkoz@kernel.org>
From: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
To: jic23@kernel.org
Cc: pmeerw@pmeerw.net,
	knaack.h@gmx.de,
	lars@metafoo.de,
	Daniel Baluta <daniel.baluta@nxp.com>,
	linux-iio@vger.kernel.org,
	Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
Subject: [PATCH v6 10/10] iio: light: rpr0521 iio_device_register to devm_
Date: Thu, 15 Jun 2017 11:55:47 +0300
Message-Id: <1497516947-21482-1-git-send-email-mikko.koivunen@fi.rohmeurope.com>
List-ID: <linux-iio@vger.kernel.org>

Change iio_device_register to devm_

Signed-off-by: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
---

 drivers/iio/light/rpr0521.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
index ce576be..e00f427 100644
--- a/drivers/iio/light/rpr0521.c
+++ b/drivers/iio/light/rpr0521.c
@@ -1025,7 +1025,7 @@ static int rpr0521_probe(struct i2c_client *client,
 		}
 	}
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(indio_dev->dev.parent, indio_dev);
 	if (ret)
 		goto err_pm_disable;
 
@@ -1045,8 +1045,6 @@ static int rpr0521_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 
-	iio_device_unregister(indio_dev);
-
 	pm_runtime_disable(&client->dev);
 	pm_runtime_set_suspended(&client->dev);
 	pm_runtime_put_noidle(&client->dev);
-- 
1.7.9.5
