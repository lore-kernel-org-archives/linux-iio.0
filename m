Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59599 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758168AbcIXQZj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 24 Sep 2016 12:25:39 -0400
Subject: Re: [PATCH v3 2/4] iio:mma8452: Use new
 iio_trigger_validate_own_device() helper
To: Lars-Peter Clausen <lars@metafoo.de>
References: <1474643984-14262-1-git-send-email-lars@metafoo.de>
 <1474643984-14262-2-git-send-email-lars@metafoo.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Philippe Reynes <tremyfr@yahoo.fr>,
        Martin Fuzzey <mfuzzey@parkeon.com>, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <d848e02c-c7f3-88c5-7d2b-f02e37d32491@kernel.org>
Date: Sat, 24 Sep 2016 17:25:37 +0100
MIME-Version: 1.0
In-Reply-To: <1474643984-14262-2-git-send-email-lars@metafoo.de>
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
I wonder if having iio_trigger_set_drvdata use the mma8452_data pointer
instead might not make more sense after this change?

Anyhow, this is good on it's own and that should be a follow up patch
so applied to the togreg branch of iio.git - initially pushed out
as testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
> New in v3
> ---
>  drivers/iio/accel/mma8452.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index d41e1b5..1c70515 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -1347,20 +1347,9 @@ static int mma8452_data_rdy_trigger_set_state(struct iio_trigger *trig,
>  	return mma8452_change_config(data, MMA8452_CTRL_REG4, reg);
>  }
>  
> -static int mma8452_validate_device(struct iio_trigger *trig,
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
>  static const struct iio_trigger_ops mma8452_trigger_ops = {
>  	.set_trigger_state = mma8452_data_rdy_trigger_set_state,
> -	.validate_device = mma8452_validate_device,
> +	.validate_device = iio_trigger_validate_own_device,
>  	.owner = THIS_MODULE,
>  };
>  
> 

