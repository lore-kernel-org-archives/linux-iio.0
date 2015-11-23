Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:32877 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752078AbbKWSH4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 23 Nov 2015 13:07:56 -0500
From: Nizam Haider <nizamhaider786@gmail.com>
To: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Nizam Haider <nizamhaider786@gmail.com>,
	Nizam Haider <nijamh@cdac.in>
Subject: [PATCH] Staging: iio: frequency: use dev_get_platdata()
Date: Mon, 23 Nov 2015 23:37:16 +0530
Message-Id: <1448302036-11363-1-git-send-email-nizamhaider786@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use the wrapper function for retrieving the platform data instead of
accessing dev->platform_data directly.

Signed-off-by: Nizam Haider <nijamh@cdac.in>
---
 drivers/staging/iio/frequency/ad9832.c | 2 +-
 drivers/staging/iio/frequency/ad9834.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 2b65faa..18b27a1 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -201,7 +201,7 @@ static const struct iio_info ad9832_info = {
 
 static int ad9832_probe(struct spi_device *spi)
 {
-	struct ad9832_platform_data *pdata = spi->dev.platform_data;
+	struct ad9832_platform_data *pdata = dev_get_platdata(&spi->dev);
 	struct iio_dev *indio_dev;
 	struct ad9832_state *st;
 	struct regulator *reg;
diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index 6464f2c..6366216 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -318,7 +318,7 @@ static const struct iio_info ad9833_info = {
 
 static int ad9834_probe(struct spi_device *spi)
 {
-	struct ad9834_platform_data *pdata = spi->dev.platform_data;
+	struct ad9834_platform_data *pdata = dev_get_platdata(&spi->dev);
 	struct ad9834_state *st;
 	struct iio_dev *indio_dev;
 	struct regulator *reg;
-- 
1.8.1.4

