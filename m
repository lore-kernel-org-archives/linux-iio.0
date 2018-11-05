Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43215 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387441AbeKFEh1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Nov 2018 23:37:27 -0500
Date: Mon, 5 Nov 2018 17:16:14 -0200
From: Renato Lui Geh <renatogeh@gmail.com>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        giuliano.belinassi@usp.br
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v4 2/2] staging: iio: ad7780: remove unnecessary stashed
 voltage value
Message-ID: <3920d49d888f63b600a4d2f2600921ed2900a470.1541444377.git.renatogeh@gmail.com>
References: <cover.1541444377.git.renatogeh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
In-Reply-To: <cover.1541444377.git.renatogeh@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch removes the unnecessary field int_vref_mv in ad7780_state
referring to the device's voltage.

Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
---
Changes in v3:
	- removed unnecessary int_vref_mv from ad7780_state
Changes in v4:
	- removed voltage reading on probe

 drivers/staging/iio/adc/ad7780.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index c7cb05cedbbc..52a914360574 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -42,7 +42,6 @@ struct ad7780_state {
 	struct regulator		*reg;
 	struct gpio_desc		*powerdown_gpio;
 	unsigned int	gain;
-	u16				int_vref_mv;
 
 	struct ad_sigma_delta sd;
 };
@@ -165,7 +164,7 @@ static int ad7780_probe(struct spi_device *spi)
 {
 	struct ad7780_state *st;
 	struct iio_dev *indio_dev;
-	int ret, voltage_uv = 0;
+	int ret;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (!indio_dev)
@@ -185,16 +184,10 @@ static int ad7780_probe(struct spi_device *spi)
 		dev_err(&spi->dev, "Failed to enable specified AVdd supply\n");
 		return ret;
 	}
-	voltage_uv = regulator_get_voltage(st->reg);
 
 	st->chip_info =
 		&ad7780_chip_info_tbl[spi_get_device_id(spi)->driver_data];
 
-	if (voltage_uv)
-		st->int_vref_mv = voltage_uv / 1000;
-	else
-		dev_warn(&spi->dev, "Reference voltage unspecified\n");
-
 	spi_set_drvdata(spi, indio_dev);
 
 	indio_dev->dev.parent = &spi->dev;
-- 
2.19.1
