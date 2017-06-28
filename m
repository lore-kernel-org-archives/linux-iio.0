Return-Path: <SRS0=ofG6=6B=gmail.com=angelo.compagnucci@kernel.org>
From: Angelo Compagnucci <angelo.compagnucci@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Angelo Compagnucci <angelo.compagnucci@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 1/3] iio: adc: mcp3422: Changing initial channel
Date: Wed, 28 Jun 2017 23:53:09 +0200
Message-Id: <1498687088-28529-1-git-send-email-angelo.compagnucci@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Initial channel should be the first available channel on
all configurations, so changing to channel 0 available on
all supported chips.

Signed-off-by: Angelo Compagnucci <angelo.compagnucci@gmail.com>
---
 drivers/iio/adc/mcp3422.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
index 254135e..6737df8 100644
--- a/drivers/iio/adc/mcp3422.c
+++ b/drivers/iio/adc/mcp3422.c
@@ -379,7 +379,7 @@ static int mcp3422_probe(struct i2c_client *client,
 
 	/* meaningful default configuration */
 	config = (MCP3422_CONT_SAMPLING
-		| MCP3422_CHANNEL_VALUE(1)
+		| MCP3422_CHANNEL_VALUE(0)
 		| MCP3422_PGA_VALUE(MCP3422_PGA_1)
 		| MCP3422_SAMPLE_RATE_VALUE(MCP3422_SRATE_240));
 	mcp3422_update_config(adc, config);
-- 
2.7.4
