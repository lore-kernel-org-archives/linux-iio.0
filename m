Return-Path: <SRS0=+lUA=ZY=metafoo.de=lars@kernel.org>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	William Breathitt Gray <vilhelm.gray@gmail.com>,
	Matt Ranostay <matt.ranostay@konsulko.com>,
	linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/8] iio: stx104: Set parent device
Date: Sat, 11 Feb 2017 13:34:14 +0100
Message-Id: <1486816461-28618-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1486816461-28618-1-git-send-email-lars@metafoo.de>
References: <1486816461-28618-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Initialize the parent of the IIO device to the device that registered it.
This makes sure that the IIO device appears the right level in the device
hierarchy.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/stx104.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/stx104.c b/drivers/iio/adc/stx104.c
index be2de48..2df84fa5 100644
--- a/drivers/iio/adc/stx104.c
+++ b/drivers/iio/adc/stx104.c
@@ -318,6 +318,7 @@ static int stx104_probe(struct device *dev, unsigned int id)
 	}
 
 	indio_dev->name = dev_name(dev);
+	indio_dev->dev.parent = dev;
 
 	priv = iio_priv(indio_dev);
 	priv->base = base[id];
-- 
2.1.4
