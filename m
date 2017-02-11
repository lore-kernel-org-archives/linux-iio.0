Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:57793 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932110AbdBKMee (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Feb 2017 07:34:34 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/8] iio: cio-dac: Set parent device
Date: Sat, 11 Feb 2017 13:34:16 +0100
Message-Id: <1486816461-28618-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1486816461-28618-1-git-send-email-lars@metafoo.de>
References: <1486816461-28618-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Initialize the parent of the IIO device to the device that registered it.
This makes sure that the IIO device appears the right level in the device
hierarchy.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/dac/cio-dac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/dac/cio-dac.c b/drivers/iio/dac/cio-dac.c
index 5a743e2..a046422 100644
--- a/drivers/iio/dac/cio-dac.c
+++ b/drivers/iio/dac/cio-dac.c
@@ -119,6 +119,7 @@ static int cio_dac_probe(struct device *dev, unsigned int id)
 	indio_dev->channels = cio_dac_channels;
 	indio_dev->num_channels = CIO_DAC_NUM_CHAN;
 	indio_dev->name = dev_name(dev);
+	indio_dev->dev.parent = dev;
 
 	priv = iio_priv(indio_dev);
 	priv->base = base[id];
-- 
2.1.4

