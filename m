Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41574 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932968AbcH2P3l (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Aug 2016 11:29:41 -0400
Subject: Re: [PATCH] staging: iio: accel: sca3000: remove extra space
To: Clifton Barnes <clifton.a.barnes@gmail.com>
References: <1471920305-9474-1-git-send-email-clifton.a.barnes@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <1a986128-9e8c-94cc-f3c7-c710e9e0bf94@kernel.org>
Date: Mon, 29 Aug 2016 16:29:39 +0100
MIME-Version: 1.0
In-Reply-To: <1471920305-9474-1-git-send-email-clifton.a.barnes@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/08/16 03:45, Clifton Barnes wrote:
> fix checkpatch.pl warning about 'Statements should start on a
> tabstop'
> 
> Signed-off-by: Clifton Barnes <clifton.a.barnes@gmail.com>
Applied to the togreg branch of iio.git. Will be initially 
pushed out as testing for the autobuilders to play with it.

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

