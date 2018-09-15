Return-Path: <SRS0=T+HA=L5=huawei.com=yuehaibing@kernel.org>
From: YueHaibing <yuehaibing@huawei.com>
To: <peda@axentia.se>, <jic23@kernel.org>, <knaack.h@gmx.de>,
	<lars@metafoo.de>, <pmeerw@pmeerw.net>
CC: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>, YueHaibing
	<yuehaibing@huawei.com>
Subject: [PATCH -next] iio: potentiometer: mcp4531: merge calls to of_match_device and of_device_get_match_data
Date: Sat, 15 Sep 2018 18:54:30 +0800
Message-ID: <20180915105430.24052-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Drop call to of_match_device, which is subsumed by the subsequent
call to of_device_get_match_data.  The code becomes simpler, and a
temporary variable can be dropped.

Found by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/iio/potentiometer/mcp4531.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/potentiometer/mcp4531.c b/drivers/iio/potentiometer/mcp4531.c
index df894af..d87ca85 100644
--- a/drivers/iio/potentiometer/mcp4531.c
+++ b/drivers/iio/potentiometer/mcp4531.c
@@ -360,7 +360,6 @@ static int mcp4531_probe(struct i2c_client *client)
 	struct device *dev = &client->dev;
 	struct mcp4531_data *data;
 	struct iio_dev *indio_dev;
-	const struct of_device_id *match;
 
 	if (!i2c_check_functionality(client->adapter,
 				     I2C_FUNC_SMBUS_WORD_DATA)) {
@@ -375,10 +374,8 @@ static int mcp4531_probe(struct i2c_client *client)
 	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
 
-	match = of_match_device(of_match_ptr(mcp4531_of_match), dev);
-	if (match)
-		data->cfg = of_device_get_match_data(dev);
-	else
+	data->cfg = of_device_get_match_data(dev);
+	if (!data->cfg)
 		data->cfg = &mcp4531_cfg[i2c_match_id(mcp4531_id, client)->driver_data];
 
 	indio_dev->dev.parent = dev;
-- 
1.8.3.1
