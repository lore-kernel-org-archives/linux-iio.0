Return-Path: <SRS0=i6q/=ZY=gmail.com=vilhelm.gray@kernel.org>
Date: Sat, 11 Feb 2017 07:58:33 -0500
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Matt Ranostay <matt.ranostay@konsulko.com>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/8] iio: stx104: Set parent device
Message-ID: <20170211125833.GA31343@sophia>
References: <1486816461-28618-1-git-send-email-lars@metafoo.de>
 <1486816461-28618-2-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1486816461-28618-2-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

On Sat, Feb 11, 2017 at 01:34:14PM +0100, Lars-Peter Clausen wrote:
>Initialize the parent of the IIO device to the device that registered it.
>This makes sure that the IIO device appears the right level in the device
>hierarchy.
>
>Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>---
> drivers/iio/adc/stx104.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/drivers/iio/adc/stx104.c b/drivers/iio/adc/stx104.c
>index be2de48..2df84fa5 100644
>--- a/drivers/iio/adc/stx104.c
>+++ b/drivers/iio/adc/stx104.c
>@@ -318,6 +318,7 @@ static int stx104_probe(struct device *dev, unsigned int id)
> 	}
> 
> 	indio_dev->name = dev_name(dev);
>+	indio_dev->dev.parent = dev;
> 
> 	priv = iio_priv(indio_dev);
> 	priv->base = base[id];
>-- 
>2.1.4
>

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com
