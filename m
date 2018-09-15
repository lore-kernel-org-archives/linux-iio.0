Return-Path: <SRS0=T+HA=L5=huawei.com=yuehaibing@kernel.org>
From: YueHaibing <yuehaibing@huawei.com>
To: <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
	<pmeerw@pmeerw.net>
CC: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>, YueHaibing
	<yuehaibing@huawei.com>
Subject: [PATCH -next] iio: potentiometer: max5481: merge calls to of_match_device and of_device_get_match_data
Date: Sat, 15 Sep 2018 18:50:33 +0800
Message-ID: <20180915105033.5928-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Drop call to of_match_device, which is subsumed by the subsequent
call to of_device_get_match_data.  The code becomes simpler, and a
temporary variable can be dropped.

Found by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/iio/potentiometer/max5481.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/potentiometer/max5481.c b/drivers/iio/potentiometer/max5481.c
index ffe2761..6d2f13f 100644
--- a/drivers/iio/potentiometer/max5481.c
+++ b/drivers/iio/potentiometer/max5481.c
@@ -137,7 +137,6 @@ static int max5481_probe(struct spi_device *spi)
 	struct iio_dev *indio_dev;
 	struct max5481_data *data;
 	const struct spi_device_id *id = spi_get_device_id(spi);
-	const struct of_device_id *match;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*data));
@@ -149,10 +148,8 @@ static int max5481_probe(struct spi_device *spi)
 
 	data->spi = spi;
 
-	match = of_match_device(of_match_ptr(max5481_match), &spi->dev);
-	if (match)
-		data->cfg = of_device_get_match_data(&spi->dev);
-	else
+	data->cfg = of_device_get_match_data(&spi->dev);
+	if (!data->cfg)
 		data->cfg = &max5481_cfg[id->driver_data];
 
 	indio_dev->name = id->name;
-- 
1.8.3.1
