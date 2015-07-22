Return-Path: <denis@eukrea.com>
From: Denis Carikli <denis@eukrea.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>
Cc: =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Denis Carikli <denis@eukrea.com>
Subject: [PATCH 1/4] iio: adc: mcp320x: Fix NULL pointer.
Date: Wed, 22 Jul 2015 18:04:21 +0200
Message-Id: <1437581064-9733-1-git-send-email-denis@eukrea.com>
List-ID: <linux-iio@vger.kernel.org>

Without that fix, adc->chip_info is NULL in mcp320x_read_raw

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
 drivers/iio/adc/mcp320x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
index 8d9c9b9..fccb2dc 100644
--- a/drivers/iio/adc/mcp320x.c
+++ b/drivers/iio/adc/mcp320x.c
@@ -299,6 +299,7 @@ static int mcp320x_probe(struct spi_device *spi)
 	indio_dev->channels = chip_info->channels;
 	indio_dev->num_channels = chip_info->num_channels;
 
+	adc->chip_info = chip_info;
 	adc->transfer[0].tx_buf = &adc->tx_buf;
 	adc->transfer[0].len = sizeof(adc->tx_buf);
 	adc->transfer[1].rx_buf = adc->rx_buf;
-- 
2.4.5
