Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@cam.ac.uk,
	jic23@kernel.org,
	sachin.kamat@linaro.org,
	patches@linaro.org,
	Rhyland Klein <rklein@nvidia.com>
Subject: [PATCH 7/8] staging: iio: light: isl29018: Use devm_iio_device_alloc
Date: Mon, 22 Jul 2013 16:33:00 +0530
Message-Id: <1374490981-24373-8-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1374490981-24373-1-git-send-email-sachin.kamat@linaro.org>
References: <1374490981-24373-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

Using devm_iio_device_alloc makes code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Rhyland Klein <rklein@nvidia.com>
---
 drivers/staging/iio/light/isl29018.c |   16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
index 82478a5..351936c 100644
--- a/drivers/staging/iio/light/isl29018.c
+++ b/drivers/staging/iio/light/isl29018.c
@@ -550,11 +550,10 @@ static int isl29018_probe(struct i2c_client *client,
 	struct iio_dev *indio_dev;
 	int err;
 
-	indio_dev = iio_device_alloc(sizeof(*chip));
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
 	if (indio_dev == NULL) {
 		dev_err(&client->dev, "iio allocation fails\n");
-		err = -ENOMEM;
-		goto exit;
+		return -ENOMEM;
 	}
 	chip = iio_priv(indio_dev);
 
@@ -572,12 +571,12 @@ static int isl29018_probe(struct i2c_client *client,
 	if (IS_ERR(chip->regmap)) {
 		err = PTR_ERR(chip->regmap);
 		dev_err(chip->dev, "regmap initialization failed: %d\n", err);
-		goto exit;
+		return err;
 	}
 
 	err = isl29018_chip_init(chip);
 	if (err)
-		goto exit_iio_free;
+		return err;
 
 	indio_dev->info = &isl29108_info;
 	indio_dev->channels = isl29018_channels;
@@ -588,14 +587,10 @@ static int isl29018_probe(struct i2c_client *client,
 	err = iio_device_register(indio_dev);
 	if (err) {
 		dev_err(&client->dev, "iio registration fails\n");
-		goto exit_iio_free;
+		return err;
 	}
 
 	return 0;
-exit_iio_free:
-	iio_device_free(indio_dev);
-exit:
-	return err;
 }
 
 static int isl29018_remove(struct i2c_client *client)
@@ -604,7 +599,6 @@ static int isl29018_remove(struct i2c_client *client)
 
 	dev_dbg(&client->dev, "%s()\n", __func__);
 	iio_device_unregister(indio_dev);
-	iio_device_free(indio_dev);
 
 	return 0;
 }
-- 
1.7.9.5
