Return-Path: <SRS0=i6q/=ZY=gmail.com=vilhelm.gray@kernel.org>
Date: Sat, 11 Feb 2017 07:59:50 -0500
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Matt Ranostay <matt.ranostay@konsulko.com>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/8] iio: cio-dac: Set parent device
Message-ID: <20170211125950.GC31343@sophia>
References: <1486816461-28618-1-git-send-email-lars@metafoo.de>
 <1486816461-28618-4-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1486816461-28618-4-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

On Sat, Feb 11, 2017 at 01:34:16PM +0100, Lars-Peter Clausen wrote:
>Initialize the parent of the IIO device to the device that registered it.
>This makes sure that the IIO device appears the right level in the device
>hierarchy.
>
>Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>---
> drivers/iio/dac/cio-dac.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/drivers/iio/dac/cio-dac.c b/drivers/iio/dac/cio-dac.c
>index 5a743e2..a046422 100644
>--- a/drivers/iio/dac/cio-dac.c
>+++ b/drivers/iio/dac/cio-dac.c
>@@ -119,6 +119,7 @@ static int cio_dac_probe(struct device *dev, unsigned int id)
> 	indio_dev->channels = cio_dac_channels;
> 	indio_dev->num_channels = CIO_DAC_NUM_CHAN;
> 	indio_dev->name = dev_name(dev);
>+	indio_dev->dev.parent = dev;
> 
> 	priv = iio_priv(indio_dev);
> 	priv->base = base[id];
>-- 
>2.1.4
>

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
