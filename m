Return-Path: <SRS0=wlz8=3L=axentia.se=peda@kernel.org>
From: Peter Rosin <peda@axentia.se>
To: <linux-kernel@vger.kernel.org>
CC: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, Peter
 Korsgaard <peter.korsgaard@barco.com>, Guenter Roeck <linux@roeck-us.net>,
	Linus Walleij <linus.walleij@linaro.org>, Jonathan Cameron
	<jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen
	<lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Mauro Carvalho
 Chehab <mchehab@kernel.org>, <linux-i2c@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <linux-media@vger.kernel.org>
Subject: [PATCH 4/9] i2c: mux: pca9541: stop double error reporting
Date: Mon, 3 Apr 2017 10:38:33 +0200
Message-ID: <1491208718-32068-5-git-send-email-peda@axentia.se>
In-Reply-To: <1491208718-32068-1-git-send-email-peda@axentia.se>
References: <1491208718-32068-1-git-send-email-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

i2c_mux_add_adapter already logs a message on failure.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/muxes/i2c-mux-pca9541.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c b/drivers/i2c/muxes/i2c-mux-pca9541.c
index 77840f7845a1..9e318c9516c7 100644
--- a/drivers/i2c/muxes/i2c-mux-pca9541.c
+++ b/drivers/i2c/muxes/i2c-mux-pca9541.c
@@ -369,10 +369,8 @@ static int pca9541_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, muxc);
 
 	ret = i2c_mux_add_adapter(muxc, force, 0, 0);
-	if (ret) {
-		dev_err(&client->dev, "failed to register master selector\n");
+	if (ret)
 		return ret;
-	}
 
 	dev_info(&client->dev, "registered master selector for I2C %s\n",
 		 client->name);
-- 
2.1.4
