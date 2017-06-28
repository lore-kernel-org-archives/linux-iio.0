Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35290 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751699AbdF1V6v (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 28 Jun 2017 17:58:51 -0400
Received: by mail-wr0-f194.google.com with SMTP id z45so35484990wrb.2
        for <linux-iio@vger.kernel.org>; Wed, 28 Jun 2017 14:58:50 -0700 (PDT)
From: Angelo Compagnucci <angelo.compagnucci@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 2/3] iio: adc: mcp3422: Checking for error on probe
Date: Wed, 28 Jun 2017 23:53:10 +0200
Message-Id: <1498687088-28529-2-git-send-email-angelo.compagnucci@gmail.com>
In-Reply-To: <1498687088-28529-1-git-send-email-angelo.compagnucci@gmail.com>
References: <1498687088-28529-1-git-send-email-angelo.compagnucci@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Some part of the configuration are not touched after the probe
and if something goes wrong on writing the initial one,
the chip will misbehave.
Adding an error checking ensures that the inital configuration will
be written correctly. Moreover ensures that a sensible configuration
will be saved in driver data and used subsequently as intended.

Signed-off-by: Angelo Compagnucci <angelo.compagnucci@gmail.com>
---
 drivers/iio/adc/mcp3422.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
index 6737df8..63de705 100644
--- a/drivers/iio/adc/mcp3422.c
+++ b/drivers/iio/adc/mcp3422.c
@@ -382,7 +382,9 @@ static int mcp3422_probe(struct i2c_client *client,
 		| MCP3422_CHANNEL_VALUE(0)
 		| MCP3422_PGA_VALUE(MCP3422_PGA_1)
 		| MCP3422_SAMPLE_RATE_VALUE(MCP3422_SRATE_240));
-	mcp3422_update_config(adc, config);
+	err = mcp3422_update_config(adc, config);
+	if (err < 0)
+		return err;
 
 	err = devm_iio_device_register(&client->dev, indio_dev);
 	if (err < 0)
-- 
2.7.4

