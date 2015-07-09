Return-Path: <knaack.h@gmx.de>
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Tiberiu Breana <tiberiu.a.breana@intel.com>
Subject: [PATCH v2 5/5] iio:light:stk3310: adjust indentation
Date: Thu,  9 Jul 2015 23:51:33 +0200
Message-Id: <6c7e6efa93f5b6df5097b0548549e4043a8d68c0.1436398691.git.knaack.h@gmx.de>
In-Reply-To: <cover.1436398691.git.knaack.h@gmx.de>
References: <cover.1436398691.git.knaack.h@gmx.de>
In-Reply-To: <cover.1436398691.git.knaack.h@gmx.de>
References: <cover.1436398691.git.knaack.h@gmx.de>
List-ID: <linux-iio@vger.kernel.org>

Adjust some indentation issues as spotted by checkpatch.pl --strict

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
Reviewed-by: Tiberiu Breana <tiberiu.a.breana@intel.com>
---
 drivers/iio/light/stk3310.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index 0056f4870357..e73f6f27cc56 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -385,7 +385,7 @@ static int stk3310_write_raw(struct iio_dev *indio_dev,
 			ret = regmap_field_write(data->reg_ps_it, index);
 		if (ret < 0)
 			dev_err(&data->client->dev,
-					"sensor configuration failed\n");
+				"sensor configuration failed\n");
 		mutex_unlock(&data->lock);
 		return ret;
 
@@ -402,7 +402,7 @@ static int stk3310_write_raw(struct iio_dev *indio_dev,
 			ret = regmap_field_write(data->reg_ps_gain, index);
 		if (ret < 0)
 			dev_err(&data->client->dev,
-					"sensor configuration failed\n");
+				"sensor configuration failed\n");
 		mutex_unlock(&data->lock);
 		return ret;
 	}
@@ -645,7 +645,7 @@ static int stk3310_probe(struct i2c_client *client,
 						STK3310_EVENT, indio_dev);
 		if (ret < 0) {
 			dev_err(&client->dev, "request irq %d failed\n",
-					client->irq);
+				client->irq);
 			goto err_standby;
 		}
 	}
-- 
2.4.3
