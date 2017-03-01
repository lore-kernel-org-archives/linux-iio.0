Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33278 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753448AbdCAXpt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Mar 2017 18:45:49 -0500
Date: Wed, 1 Mar 2017 15:37:57 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: magnetometer: ak8974: remove incorrect __exit markups
Message-ID: <20170301233757.GA10606@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Even if bus is not hot-pluggable, devices can be unbound from the
driver via sysfs, so we should not be using __exit annotations on
remove() methods. The only exception is drivers registered with
platform_driver_probe() which specifically disables sysfs bind/unbind
attributes.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/iio/magnetometer/ak8974.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
index ce09d771c1fb..75f83424903b 100644
--- a/drivers/iio/magnetometer/ak8974.c
+++ b/drivers/iio/magnetometer/ak8974.c
@@ -767,7 +767,7 @@ static int ak8974_probe(struct i2c_client *i2c,
 	return ret;
 }
 
-static int __exit ak8974_remove(struct i2c_client *i2c)
+static int ak8974_remove(struct i2c_client *i2c)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(i2c);
 	struct ak8974 *ak8974 = iio_priv(indio_dev);
@@ -849,7 +849,7 @@ static struct i2c_driver ak8974_driver = {
 		.of_match_table = of_match_ptr(ak8974_of_match),
 	},
 	.probe	  = ak8974_probe,
-	.remove	  = __exit_p(ak8974_remove),
+	.remove	  = ak8974_remove,
 	.id_table = ak8974_id,
 };
 module_i2c_driver(ak8974_driver);
-- 
2.12.0.rc1.440.g5b76565f74-goog


-- 
Dmitry
