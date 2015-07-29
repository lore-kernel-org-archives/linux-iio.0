Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58616 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752590AbbG2NrK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 29 Jul 2015 09:47:10 -0400
From: Markus Pargmann <mpa@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH 4/7] iio: bmg160: Use generic dev_drvdata
Date: Wed, 29 Jul 2015 15:46:06 +0200
Message-Id: <1438177569-18772-5-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1438177569-18772-1-git-send-email-mpa@pengutronix.de>
References: <1438177569-18772-1-git-send-email-mpa@pengutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

i2c_get_clientdata() is specifically for i2c. Replace it with the
generic dev_get/set_drvdata() to support different protocols.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/iio/gyro/bmg160.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/gyro/bmg160.c b/drivers/iio/gyro/bmg160.c
index 71c605ea85ad..b47b7af19e32 100644
--- a/drivers/iio/gyro/bmg160.c
+++ b/drivers/iio/gyro/bmg160.c
@@ -1022,7 +1022,7 @@ static int bmg160_probe(struct i2c_client *client,
 		return -ENOMEM;
 
 	data = iio_priv(indio_dev);
-	i2c_set_clientdata(client, indio_dev);
+	dev_set_drvdata(&client->dev, indio_dev);
 	data->dev = &client->dev;
 
 	ret = bmg160_chip_init(data);
@@ -1156,7 +1156,7 @@ static int bmg160_remove(struct i2c_client *client)
 #ifdef CONFIG_PM_SLEEP
 static int bmg160_suspend(struct device *dev)
 {
-	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct bmg160_data *data = iio_priv(indio_dev);
 
 	mutex_lock(&data->mutex);
@@ -1168,7 +1168,7 @@ static int bmg160_suspend(struct device *dev)
 
 static int bmg160_resume(struct device *dev)
 {
-	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct bmg160_data *data = iio_priv(indio_dev);
 
 	mutex_lock(&data->mutex);
@@ -1184,7 +1184,7 @@ static int bmg160_resume(struct device *dev)
 #ifdef CONFIG_PM
 static int bmg160_runtime_suspend(struct device *dev)
 {
-	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct bmg160_data *data = iio_priv(indio_dev);
 	int ret;
 
@@ -1199,7 +1199,7 @@ static int bmg160_runtime_suspend(struct device *dev)
 
 static int bmg160_runtime_resume(struct device *dev)
 {
-	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct bmg160_data *data = iio_priv(indio_dev);
 	int ret;
 
-- 
2.1.4

