Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	sachin.kamat@linaro.org
Subject: [PATCH 3/9] iio: accel: kxsd9: Remove redundant variable
Date: Thu, 24 Oct 2013 17:23:29 +0530
Message-Id: <1382615615-20153-3-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1382615615-20153-1-git-send-email-sachin.kamat@linaro.org>
References: <1382615615-20153-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

Return directly thereby eliminating an intermediate variable.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/iio/accel/kxsd9.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index 709c132..d72118d 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -222,7 +222,6 @@ static int kxsd9_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
 	struct kxsd9_state *st;
-	int ret;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (!indio_dev)
@@ -244,11 +243,7 @@ static int kxsd9_probe(struct spi_device *spi)
 	spi_setup(spi);
 	kxsd9_power_up(st);
 
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		return ret;
-
-	return 0;
+	return iio_device_register(indio_dev);
 }
 
 static int kxsd9_remove(struct spi_device *spi)
-- 
1.7.9.5
