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
Subject: [PATCH 7/9] i2c: mux: reg: stop double error reporting
Date: Mon, 3 Apr 2017 10:38:36 +0200
Message-ID: <1491208718-32068-8-git-send-email-peda@axentia.se>
In-Reply-To: <1491208718-32068-1-git-send-email-peda@axentia.se>
References: <1491208718-32068-1-git-send-email-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

i2c_mux_add_adapter already logs a message on failure.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/muxes/i2c-mux-reg.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-reg.c b/drivers/i2c/muxes/i2c-mux-reg.c
index c6a90b4a9c62..406d5059072c 100644
--- a/drivers/i2c/muxes/i2c-mux-reg.c
+++ b/drivers/i2c/muxes/i2c-mux-reg.c
@@ -222,10 +222,8 @@ static int i2c_mux_reg_probe(struct platform_device *pdev)
 		class = mux->data.classes ? mux->data.classes[i] : 0;
 
 		ret = i2c_mux_add_adapter(muxc, nr, mux->data.values[i], class);
-		if (ret) {
-			dev_err(&pdev->dev, "Failed to add adapter %d\n", i);
+		if (ret)
 			goto add_adapter_failed;
-		}
 	}
 
 	dev_dbg(&pdev->dev, "%d port mux on %s adapter\n",
-- 
2.1.4
