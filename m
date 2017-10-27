Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.117]:45574 "EHLO vps.pmeerw.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752606AbdJ0TaE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 27 Oct 2017 15:30:04 -0400
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Matt Ranostay <matt@ranostay.consulting>
Subject: [PATCH 03/13] iio: health: max30102: Check retval of powermode function
Date: Fri, 27 Oct 2017 21:29:40 +0200
Message-Id: <1509132593-1815-6-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1509132593-1815-1-git-send-email-pmeerw@pmeerw.net>
References: <1509132593-1815-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Matt Ranostay <matt@ranostay.consulting>
---
 drivers/iio/health/max30102.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
index 6404ac1..20d23fa 100644
--- a/drivers/iio/health/max30102.c
+++ b/drivers/iio/health/max30102.c
@@ -423,7 +423,10 @@ static int max30102_probe(struct i2c_client *client,
 		dev_err(&client->dev, "regmap initialization failed.\n");
 		return PTR_ERR(data->regmap);
 	}
-	max30102_set_powermode(data, false);
+
+	ret = max30102_set_powermode(data, false);
+	if (ret)
+		return ret;
 
 	ret = max30102_chip_init(data);
 	if (ret)
-- 
2.7.4

