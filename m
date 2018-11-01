Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45200 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728352AbeKAXrC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Nov 2018 19:47:02 -0400
Date: Thu, 1 Nov 2018 11:43:41 -0300
From: Renato Lui Geh <renatogeh@gmail.com>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        giuliano.belinassi@usp.br
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v3 3/3] staging: iio: ad7780: remove unnecessary stashed
 voltage value
Message-ID: <d6b6aeda46121f59a53b43599bf0200580d7a79d.1541082656.git.renatogeh@gmail.com>
References: <cover.1541082656.git.renatogeh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
In-Reply-To: <cover.1541082656.git.renatogeh@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch removes the unnecessary field int_vref_mv in ad7780_state
referring to the device's voltage.

Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
---
Changes in v3:
	- removed unnecessary int_vref_mv from ad7780_state

 drivers/staging/iio/adc/ad7780.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index f2a11e9424cd..f250370efcf7 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -42,7 +42,6 @@ struct ad7780_state {
 	struct regulator		*reg;
 	struct gpio_desc		*powerdown_gpio;
 	unsigned int	gain;
-	u16				int_vref_mv;
 
 	struct ad_sigma_delta sd;
 };
@@ -190,9 +189,7 @@ static int ad7780_probe(struct spi_device *spi)
 	st->chip_info =
 		&ad7780_chip_info_tbl[spi_get_device_id(spi)->driver_data];
 
-	if (voltage_uv)
-		st->int_vref_mv = voltage_uv / 1000;
-	else
+	if (!voltage_uv)
 		dev_warn(&spi->dev, "Reference voltage unspecified\n");
 
 	spi_set_drvdata(spi, indio_dev);
-- 
2.19.1
