Return-Path: <SRS0=UY19=DZ=gmail.com=mastichi@kernel.org>
From: Dmitry Mastykin <mastichi@gmail.com>
To: 
Cc: Dmitry Mastykin <mastichi@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Jacopo Mondi <jacopo+renesas@jmondi.org>,
	Rob Herring <robh@kernel.org>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: max9611: fix module auto-loading
Date: Fri, 29 Dec 2017 10:14:27 +0300
Message-Id: <1514531684-3872-1-git-send-email-mastichi@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Module auto-load doesn't work because i2c table is not exported.

Signed-off-by: Dmitry Mastykin <mastichi@gmail.com>
---
 drivers/iio/adc/max9611.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
index b1dd17c..7924b5c 100644
--- a/drivers/iio/adc/max9611.c
+++ b/drivers/iio/adc/max9611.c
@@ -516,13 +516,20 @@ static int max9611_init(struct max9611_dev *max9611)
 	return 0;
 }
 
+static const struct i2c_device_id max9611_id[] = {
+	{ "max9611", 0 },
+	{ "max9612", 0 },
+	{ },
+ };
+MODULE_DEVICE_TABLE(i2c, max9611_id);
+
 static const struct of_device_id max9611_of_table[] = {
 	{.compatible = "maxim,max9611", .data = "max9611"},
 	{.compatible = "maxim,max9612", .data = "max9612"},
 	{ },
 };
-
 MODULE_DEVICE_TABLE(of, max9611_of_table);
+
 static int max9611_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
-- 
2.7.4
