Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39469 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752372AbeCRNem (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Mar 2018 09:34:42 -0400
Received: by mail-wm0-f66.google.com with SMTP id f125so2414228wme.4
        for <linux-iio@vger.kernel.org>; Sun, 18 Mar 2018 06:34:42 -0700 (PDT)
Date: Sun, 18 Mar 2018 14:34:38 +0100
From: David Veenstra <davidjulianveenstra@gmail.com>
To: lars@metafoo.de, jic23@kernel.org
Cc: Michael.Hennerich@analog.com, knaack.h@gmx.de,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH 02/11] staging: iio: ad2s1200: Reverse Christmas tree order
Message-ID: <ad6bd34a8cfc4594b9d3415e28c416931bf03899.1521379685.git.davidjulianveenstra@gmail.com>
References: <cover.1521379685.git.davidjulianveenstra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1521379685.git.davidjulianveenstra@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Reorders the variable declarations to prefer a reverse Christmas tree
order to improve readability.

Signed-off-by: David Veenstra <davidjulianveenstra@gmail.com>
---
 drivers/staging/iio/resolver/ad2s1200.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
index 7a5b2d1927d6..94d0a66532fd 100644
--- a/drivers/staging/iio/resolver/ad2s1200.c
+++ b/drivers/staging/iio/resolver/ad2s1200.c
@@ -47,9 +47,9 @@ static int ad2s1200_read_raw(struct iio_dev *indio_dev,
 			     int *val2,
 			     long m)
 {
+	struct ad2s1200_state *st = iio_priv(indio_dev);
 	int ret = 0;
 	s16 vel;
-	struct ad2s1200_state *st = iio_priv(indio_dev);
 
 	mutex_lock(&st->lock);
 	gpio_set_value(st->sample, 0);
@@ -102,10 +102,10 @@ static const struct iio_info ad2s1200_info = {
 
 static int ad2s1200_probe(struct spi_device *spi)
 {
+	unsigned short *pins = spi->dev.platform_data;
 	struct ad2s1200_state *st;
 	struct iio_dev *indio_dev;
 	int pn, ret = 0;
-	unsigned short *pins = spi->dev.platform_data;
 
 	for (pn = 0; pn < AD2S1200_PN; pn++) {
 		ret = devm_gpio_request_one(&spi->dev, pins[pn], GPIOF_DIR_OUT,
-- 
2.16.2

