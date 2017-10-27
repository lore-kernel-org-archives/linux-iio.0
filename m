Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.117]:46718 "EHLO vps.pmeerw.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932417AbdJ0Tpt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 27 Oct 2017 15:45:49 -0400
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH v2 03/13] iio: health: max30102: Remove inconsistent full stop in error message
Date: Fri, 27 Oct 2017 21:45:33 +0200
Message-Id: <1509133543-4597-4-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1509133543-4597-1-git-send-email-pmeerw@pmeerw.net>
References: <1509133543-4597-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/health/max30102.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
index 62b1b35..6ca6182 100644
--- a/drivers/iio/health/max30102.c
+++ b/drivers/iio/health/max30102.c
@@ -420,7 +420,7 @@ static int max30102_probe(struct i2c_client *client,
 
 	data->regmap = devm_regmap_init_i2c(client, &max30102_regmap_config);
 	if (IS_ERR(data->regmap)) {
-		dev_err(&client->dev, "regmap initialization failed.\n");
+		dev_err(&client->dev, "regmap initialization failed\n");
 		return PTR_ERR(data->regmap);
 	}
 	max30102_set_powermode(data, false);
-- 
2.7.4

