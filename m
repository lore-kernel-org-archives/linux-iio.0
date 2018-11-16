Return-Path: <SRS0=kG2y=N3=poczta.fm=sst@kernel.org>
From: Slawomir Stepien <sst@poczta.fm>
To: lars@metafoo.de,
	jic23@kernel.org,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org
Subject: [PATCH 2/2] iio: potentiometer mcp4131: use spi_get_device_id() only when needed
Date: Fri, 16 Nov 2018 10:47:22 +0100
Message-Id: <20181116094722.1070-3-sst@poczta.fm>
In-Reply-To: <20181116094722.1070-1-sst@poczta.fm>
References: <20181116094722.1070-1-sst@poczta.fm>
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

There is no need to find the device id up front, since the
of_device_get_match_data() might return the correct data.

Signed-off-by: Slawomir Stepien <sst@poczta.fm>
---
 drivers/iio/potentiometer/mcp4131.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/potentiometer/mcp4131.c b/drivers/iio/potentiometer/mcp4131.c
index 55f526a59215..efe035ce010d 100644
--- a/drivers/iio/potentiometer/mcp4131.c
+++ b/drivers/iio/potentiometer/mcp4131.c
@@ -244,7 +244,7 @@ static int mcp4131_probe(struct spi_device *spi)
 {
 	int err;
 	struct device *dev = &spi->dev;
-	unsigned long devid = spi_get_device_id(spi)->driver_data;
+	unsigned long devid;
 	struct mcp4131_data *data;
 	struct iio_dev *indio_dev;
 
@@ -256,8 +256,10 @@ static int mcp4131_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, indio_dev);
 	data->spi = spi;
 	data->cfg = of_device_get_match_data(&spi->dev);
-	if (!data->cfg)
+	if (!data->cfg) {
+		devid = spi_get_device_id(spi)->driver_data;
 		data->cfg = &mcp4131_cfg[devid];
+	}
 
 	mutex_init(&data->lock);
 
-- 
2.19.1
