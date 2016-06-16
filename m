Return-Path: <mranostay@gmail.com>
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH] iio: proximity: as3935: remove redundant zeroing of tune_cap
Date: Wed, 15 Jun 2016 18:47:02 -0700
Message-Id: <1466041622-1236-1-git-send-email-mranostay@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 drivers/iio/proximity/as3935.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
index 9aa2ce551ba8..692e9cda8ae0 100644
--- a/drivers/iio/proximity/as3935.c
+++ b/drivers/iio/proximity/as3935.c
@@ -346,7 +346,6 @@ static int as3935_probe(struct spi_device *spi)
 
 	st = iio_priv(indio_dev);
 	st->spi = spi;
-	st->tune_cap = 0;
 
 	spi_set_drvdata(spi, indio_dev);
 	mutex_init(&st->lock);
-- 
2.7.4
