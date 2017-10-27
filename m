Return-Path: <SRS0=wbiz=B2=pmeerw.net=pmeerw@kernel.org>
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Matt Ranostay <matt@ranostay.consulting>
Subject: [PATCH 04/13] iio: health: max30102: Remove inconsistent full stop in error message
Date: Fri, 27 Oct 2017 21:29:43 +0200
Message-Id: <1509132593-1815-9-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1509132593-1815-1-git-send-email-pmeerw@pmeerw.net>
References: <1509132593-1815-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Matt Ranostay <matt@ranostay.consulting>
---
 drivers/iio/health/max30102.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
index 20d23fa..58873b7 100644
--- a/drivers/iio/health/max30102.c
+++ b/drivers/iio/health/max30102.c
@@ -420,7 +420,7 @@ static int max30102_probe(struct i2c_client *client,
 
 	data->regmap = devm_regmap_init_i2c(client, &max30102_regmap_config);
 	if (IS_ERR(data->regmap)) {
-		dev_err(&client->dev, "regmap initialization failed.\n");
+		dev_err(&client->dev, "regmap initialization failed\n");
 		return PTR_ERR(data->regmap);
 	}
 
-- 
2.7.4
