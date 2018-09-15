Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from szxga07-in.huawei.com ([45.249.212.35]:57830 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726446AbeIOQLd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 15 Sep 2018 12:11:33 -0400
From: YueHaibing <yuehaibing@huawei.com>
To: <peda@axentia.se>, <jic23@kernel.org>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>
CC: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] iio: potentiometer: mcp4018: merge calls to of_match_device and of_device_get_match_data
Date: Sat, 15 Sep 2018 18:52:41 +0800
Message-ID: <20180915105241.22584-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Drop call to of_match_device, which is subsumed by the subsequent
call to of_device_get_match_data.  The code becomes simpler, and a
temporary variable can be dropped.

Found by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/iio/potentiometer/mcp4018.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/potentiometer/mcp4018.c b/drivers/iio/potentiometer/mcp4018.c
index 320a7c9..c051ee0 100644
--- a/drivers/iio/potentiometer/mcp4018.c
+++ b/drivers/iio/potentiometer/mcp4018.c
@@ -147,7 +147,6 @@ static int mcp4018_probe(struct i2c_client *client)
 	struct device *dev = &client->dev;
 	struct mcp4018_data *data;
 	struct iio_dev *indio_dev;
-	const struct of_device_id *match;
 
 	if (!i2c_check_functionality(client->adapter,
 				     I2C_FUNC_SMBUS_BYTE)) {
@@ -162,10 +161,8 @@ static int mcp4018_probe(struct i2c_client *client)
 	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
 
-	match = of_match_device(of_match_ptr(mcp4018_of_match), dev);
-	if (match)
-		data->cfg = of_device_get_match_data(dev);
-	else
+	data->cfg = of_device_get_match_data(dev);
+	if (!data->cfg)
 		data->cfg = &mcp4018_cfg[i2c_match_id(mcp4018_id, client)->driver_data];
 
 	indio_dev->dev.parent = dev;
-- 
1.8.3.1
