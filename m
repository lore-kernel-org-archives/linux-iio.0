Return-Path: <linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/2] iio: bh1780: dereference the client properly
Date: Wed, 25 May 2016 09:40:26 +0200
Message-Id: <1464162027-24612-1-git-send-email-linus.walleij@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

The code in runtime_[suspend|resume] was assuming that the
i2c client data was the bh1780 state container, but it contains
the IIO device. So first dereference the IIO device from the
i2c client, then get the state container using the iio_priv()
call.

Fixes: 1f0477f18306 ("iio: light: new driver for the ROHM BH1780")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
I have no idea how this screwed up in the submission, but I
guess I managed to test it with CONFIG_PM disabled or something.
Sorry!
---
 drivers/iio/light/bh1780.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/bh1780.c b/drivers/iio/light/bh1780.c
index f83595334ff1..5fd432df2c8f 100644
--- a/drivers/iio/light/bh1780.c
+++ b/drivers/iio/light/bh1780.c
@@ -226,7 +226,8 @@ static int bh1780_remove(struct i2c_client *client)
 static int bh1780_runtime_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	struct bh1780_data *bh1780 = i2c_get_clientdata(client);
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct bh1780_data *bh1780 = iio_priv(indio_dev);
 	int ret;
 
 	ret = bh1780_write(bh1780, BH1780_REG_CONTROL, BH1780_POFF);
@@ -241,7 +242,8 @@ static int bh1780_runtime_suspend(struct device *dev)
 static int bh1780_runtime_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	struct bh1780_data *bh1780 = i2c_get_clientdata(client);
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct bh1780_data *bh1780 = iio_priv(indio_dev);
 	int ret;
 
 	ret = bh1780_write(bh1780, BH1780_REG_CONTROL, BH1780_PON);
-- 
2.4.11
