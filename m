Return-Path: <SRS0=lvGo=4D=gmail.com=weiyj.lk@kernel.org>
From: Wei Yongjun <weiyj.lk@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: Wei Yongjun <weiyongjun1@huawei.com>,
	linux-iio@vger.kernel.org
Subject: [PATCH -next] iio: adc: max9611: Fix return value check in max9611_probe()
Date: Thu, 27 Apr 2017 15:20:36 +0000
Message-Id: <20170427152036.30966-1-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

From: Wei Yongjun <weiyongjun1@huawei.com>

In case of error, the function devm_iio_device_alloc() returns
NULL pointer not ERR_PTR(). The IS_ERR() test in the return value
check should be replaced with NULL test.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/iio/adc/max9611.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
index ec82106..dc3869b 100644
--- a/drivers/iio/adc/max9611.c
+++ b/drivers/iio/adc/max9611.c
@@ -536,8 +536,8 @@ static int max9611_probe(struct i2c_client *client,
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*max9611));
-	if (IS_ERR(indio_dev))
-		return PTR_ERR(indio_dev);
+	if (!indio_dev)
+		return -ENOMEM;
 
 	i2c_set_clientdata(client, indio_dev);
