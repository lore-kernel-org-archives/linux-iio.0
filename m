Return-Path: <knaack.h@gmx.de>
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Tiberiu Breana <tiberiu.a.breana@intel.com>
Subject: [PATCH 5/5] iio:light:stk3310: adjust indentation
Date: Sat,  4 Jul 2015 17:57:01 +0200
Message-Id: <4d3814bde208bce5f8257da0df7badc3787187ff.1436024257.git.knaack.h@gmx.de>
In-Reply-To: <cover.1436024257.git.knaack.h@gmx.de>
References: <cover.1436024257.git.knaack.h@gmx.de>
In-Reply-To: <cover.1436024257.git.knaack.h@gmx.de>
References: <cover.1436024257.git.knaack.h@gmx.de>
List-ID: <linux-iio@vger.kernel.org>

Adjust some indentation issues as spotted by checkpatch.pl --strict

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 drivers/iio/light/stk3310.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index be715c7..2760f67 100644
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
@@ -649,7 +649,7 @@ static int stk3310_probe(struct i2c_client *client,
 						STK3310_EVENT, indio_dev);
 		if (ret < 0) {
 			dev_err(&client->dev, "request irq %d failed\n",
-					client->irq);
+				client->irq);
 			goto err_unregister;
 		}
 	}
-- 
2.3.6
