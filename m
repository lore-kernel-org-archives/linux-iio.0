Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:57795 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932112AbdBKMee (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Feb 2017 07:34:34 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/8] iio: max30100: Set parent device
Date: Sat, 11 Feb 2017 13:34:17 +0100
Message-Id: <1486816461-28618-5-git-send-email-lars@metafoo.de>
In-Reply-To: <1486816461-28618-1-git-send-email-lars@metafoo.de>
References: <1486816461-28618-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Initialize the parent of the IIO device to the device that registered it.
This makes sure that the IIO device appears the right level in the device
hierarchy.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/health/max30100.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/health/max30100.c b/drivers/iio/health/max30100.c
index 9648c69..10b3e0d 100644
--- a/drivers/iio/health/max30100.c
+++ b/drivers/iio/health/max30100.c
@@ -449,6 +449,7 @@ static int max30100_probe(struct i2c_client *client,
 	indio_dev->available_scan_masks = max30100_scan_masks;
 	indio_dev->modes = (INDIO_BUFFER_SOFTWARE | INDIO_DIRECT_MODE);
 	indio_dev->setup_ops = &max30100_buffer_setup_ops;
+	indio_dev->dev.parent = &client->dev;
 
 	data = iio_priv(indio_dev);
 	data->indio_dev = indio_dev;
-- 
2.1.4

