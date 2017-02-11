Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:57834 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932112AbdBKMen (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Feb 2017 07:34:43 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 8/8] iio: maxim_thermocouple: Set parent device
Date: Sat, 11 Feb 2017 13:34:21 +0100
Message-Id: <1486816461-28618-9-git-send-email-lars@metafoo.de>
In-Reply-To: <1486816461-28618-1-git-send-email-lars@metafoo.de>
References: <1486816461-28618-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Initialize the parent of the IIO device to the device that registered it.
This makes sure that the IIO device appears the right level in the device
hierarchy.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/temperature/maxim_thermocouple.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/temperature/maxim_thermocouple.c b/drivers/iio/temperature/maxim_thermocouple.c
index f962f31..5572142 100644
--- a/drivers/iio/temperature/maxim_thermocouple.c
+++ b/drivers/iio/temperature/maxim_thermocouple.c
@@ -231,6 +231,7 @@ static int maxim_thermocouple_probe(struct spi_device *spi)
 	indio_dev->available_scan_masks = chip->scan_masks;
 	indio_dev->num_channels = chip->num_channels;
 	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->dev.parent = &spi->dev;
 
 	data = iio_priv(indio_dev);
 	data->spi = spi;
-- 
2.1.4

