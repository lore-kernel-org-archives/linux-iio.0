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
Subject: [PATCH 1/9] i2c: mux: provide more info on failure in i2c_mux_add_adapter
Date: Mon, 3 Apr 2017 10:38:30 +0200
Message-ID: <1491208718-32068-2-git-send-email-peda@axentia.se>
In-Reply-To: <1491208718-32068-1-git-send-email-peda@axentia.se>
References: <1491208718-32068-1-git-send-email-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

No callers then need to report any further info, thus reducing both the
amount of code and the log noise.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/i2c-mux.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 2178266bca79..26f7237558ba 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -395,13 +395,16 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
 	if (force_nr) {
 		priv->adap.nr = force_nr;
 		ret = i2c_add_numbered_adapter(&priv->adap);
+		dev_err(&parent->dev,
+			"failed to add mux-adapter %u as bus %u (error=%d)\n",
+			chan_id, force_nr, ret);
 	} else {
 		ret = i2c_add_adapter(&priv->adap);
+		dev_err(&parent->dev,
+			"failed to add mux-adapter %u (error=%d)\n",
+			chan_id, ret);
 	}
 	if (ret < 0) {
-		dev_err(&parent->dev,
-			"failed to add mux-adapter (error=%d)\n",
-			ret);
 		kfree(priv);
 		return ret;
 	}
-- 
2.1.4
