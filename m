Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:55483 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965036AbeGBKOE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Jul 2018 06:14:04 -0400
From: Colin King <colin.king@canonical.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Silvan Murer <silvan.murer@gmail.com>,
        linux-iio@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: dac: remove redundant pointer chip_info and spi_dev_id
Date: Mon,  2 Jul 2018 11:13:59 +0100
Message-Id: <20180702101359.16461-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointers chip_info and spi_dev_id are being assigned but are never used
hence they are redundant and can be removed.

Cleans up clang warning:
warning: variable 'chip_info' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/iio/dac/ltc2632.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/iio/dac/ltc2632.c b/drivers/iio/dac/ltc2632.c
index cca278eaa138..28e9b7656b20 100644
--- a/drivers/iio/dac/ltc2632.c
+++ b/drivers/iio/dac/ltc2632.c
@@ -87,12 +87,7 @@ static int ltc2632_read_raw(struct iio_dev *indio_dev,
 			    int *val2,
 			    long m)
 {
-	struct ltc2632_chip_info *chip_info;
-
 	const struct ltc2632_state *st = iio_priv(indio_dev);
-	const struct spi_device_id *spi_dev_id = spi_get_device_id(st->spi_dev);
-
-	chip_info = (struct ltc2632_chip_info *)spi_dev_id->driver_data;
 
 	switch (m) {
 	case IIO_CHAN_INFO_SCALE:
-- 
2.17.1

