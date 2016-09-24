Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59612 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758168AbcIXQ1i (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 24 Sep 2016 12:27:38 -0400
Subject: Re: [PATCH v3 3/4] iio:max1027: Use iio_trigger_validate_own_device()
 helper
To: Lars-Peter Clausen <lars@metafoo.de>
References: <1474643984-14262-1-git-send-email-lars@metafoo.de>
 <1474643984-14262-3-git-send-email-lars@metafoo.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Philippe Reynes <tremyfr@yahoo.fr>,
        Martin Fuzzey <mfuzzey@parkeon.com>, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5b5f0c71-1411-d22e-87fe-8b4d41133363@kernel.org>
Date: Sat, 24 Sep 2016 17:27:36 +0100
MIME-Version: 1.0
In-Reply-To: <1474643984-14262-3-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/09/16 16:19, Lars-Peter Clausen wrote:
> Use the new iio_trigger_validate_own_device() to verify that the trigger
> can only be attached to the matching IIO device rather than using a custom
> variant.
> 
> While the implementation of iio_trigger_validate_own_device() and the
> custom variant and are not identical their behaviour is.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git - initially pushed out as testing
for the autobuilders to play with.

Thanks,

Jonathan
> ---
> New in v3
> ---
>  drivers/iio/adc/max1027.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
> index 712fbd2..8ea3271 100644
> --- a/drivers/iio/adc/max1027.c
> +++ b/drivers/iio/adc/max1027.c
> @@ -360,17 +360,6 @@ static int max1027_set_trigger_state(struct iio_trigger *trig, bool state)
>  	return 0;
>  }
>  
> -static int max1027_validate_device(struct iio_trigger *trig,
> -				   struct iio_dev *indio_dev)
> -{
> -	struct iio_dev *indio = iio_trigger_get_drvdata(trig);
> -
> -	if (indio != indio_dev)
> -		return -EINVAL;
> -
> -	return 0;
> -}
> -
>  static irqreturn_t max1027_trigger_handler(int irq, void *private)
>  {
>  	struct iio_poll_func *pf = (struct iio_poll_func *)private;
> @@ -391,7 +380,7 @@ static irqreturn_t max1027_trigger_handler(int irq, void *private)
>  
>  static const struct iio_trigger_ops max1027_trigger_ops = {
>  	.owner = THIS_MODULE,
> -	.validate_device = &max1027_validate_device,
> +	.validate_device = &iio_trigger_validate_own_device,
>  	.set_trigger_state = &max1027_set_trigger_state,
>  };
>  
> 

