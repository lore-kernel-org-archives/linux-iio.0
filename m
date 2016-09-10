Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58310 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754237AbcIJO5U (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 10 Sep 2016 10:57:20 -0400
Subject: Re: [PATCH] iio: accel: sca3000_core: Fix superfluous indent white
 space
To: Ico Doornekamp <ico@pruts.nl>
References: <20160909174414.31002-1-ico@pruts.nl>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <95f27ba9-d54c-3dad-6b33-217010ce55bd@kernel.org>
Date: Sat, 10 Sep 2016 15:57:18 +0100
MIME-Version: 1.0
In-Reply-To: <20160909174414.31002-1-ico@pruts.nl>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/09/16 18:44, Ico Doornekamp wrote:
> Signed-off-by: Ico Doornekamp <ico@pruts.nl>
Hi

Clifton Barnes sent a patch for this a few weeks ago and
I have already applied that patch.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/accel/sca3000_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
> index b5625f5..61f3241 100644
> --- a/drivers/staging/iio/accel/sca3000_core.c
> +++ b/drivers/staging/iio/accel/sca3000_core.c
> @@ -412,7 +412,7 @@ static const struct iio_event_spec sca3000_event = {
>  		},						\
>  		.event_spec = &sca3000_event,			\
>  		.num_event_specs = 1,				\
> -	 }
> +	}
>  
>  static const struct iio_chan_spec sca3000_channels[] = {
>  	SCA3000_CHAN(0, IIO_MOD_X),
> 

