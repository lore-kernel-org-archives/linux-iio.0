Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	sachin.kamat@linaro.org
Subject: [PATCH 6/9] iio: dac: ad5755: Remove redundant code
Date: Thu, 24 Oct 2013 17:23:32 +0530
Message-Id: <1382615615-20153-6-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1382615615-20153-1-git-send-email-sachin.kamat@linaro.org>
References: <1382615615-20153-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

The if check is redundant as the value obtained from
iio_device_register() is already in the required format.
Error messages are already printed by iio_device_register();
hence not needed.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/iio/dac/ad5755.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
index bd31dbc..9a78d5a 100644
--- a/drivers/iio/dac/ad5755.c
+++ b/drivers/iio/dac/ad5755.c
@@ -589,13 +589,7 @@ static int ad5755_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = iio_device_register(indio_dev);
-	if (ret) {
-		dev_err(&spi->dev, "Failed to register iio device: %d\n", ret);
-		return ret;
-	}
-
-	return 0;
+	return iio_device_register(indio_dev);
 }
 
 static int ad5755_remove(struct spi_device *spi)
-- 
1.7.9.5
