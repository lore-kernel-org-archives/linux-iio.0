Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:54414 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbeHCNvz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Aug 2018 09:51:55 -0400
From: Colin King <colin.king@canonical.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        linux-iio@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][iio-next] iio: chemical: fix spelling mistake "failted" -> "failed"
Date: Fri,  3 Aug 2018 12:55:51 +0100
Message-Id: <20180803115551.18866-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

fix spelling mistake in dev_err error message text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/iio/chemical/bme680_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 7d9bb62baa3f..5de9e27c914a 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -577,7 +577,7 @@ static int bme680_gas_config(struct bme680_data *data)
 	/* set target heating duration */
 	ret = regmap_write(data->regmap, BME680_REG_GAS_WAIT_0, heatr_dur);
 	if (ret < 0) {
-		dev_err(dev, "failted to write gas_wait_0 register\n");
+		dev_err(dev, "failed to write gas_wait_0 register\n");
 		return ret;
 	}
 
-- 
2.17.1

