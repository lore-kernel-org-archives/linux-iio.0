Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	sachin.kamat@linaro.org
Subject: [PATCH 03/10] staging: iio: ad2s1200: Use dev_err instead of pr_err
Date: Wed, 11 Sep 2013 15:25:18 +0530
Message-Id: <1378893325-31764-3-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1378893325-31764-1-git-send-email-sachin.kamat@linaro.org>
References: <1378893325-31764-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

dev_err is preferred over pr_err.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/staging/iio/resolver/ad2s1200.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
index 76f6d65..62d3017 100644
--- a/drivers/staging/iio/resolver/ad2s1200.c
+++ b/drivers/staging/iio/resolver/ad2s1200.c
@@ -110,8 +110,8 @@ static int ad2s1200_probe(struct spi_device *spi)
 		ret = devm_gpio_request_one(&spi->dev, pins[pn], GPIOF_DIR_OUT,
 					    DRV_NAME);
 		if (ret) {
-			pr_err("%s: request gpio pin %d failed\n",
-						DRV_NAME, pins[pn]);
+			dev_err(&spi->dev, "request gpio pin %d failed\n",
+							pins[pn]);
 			return ret;
 		}
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
-- 
1.7.9.5
