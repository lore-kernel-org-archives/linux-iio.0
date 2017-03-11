Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37060 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754391AbdCKSgf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Mar 2017 13:36:35 -0500
Subject: Re: [PATCH v1 01/10] staging: iio: ad7192: Remove exceptional & on
 function name
To: simran singhal <singhalsimran0@gmail.com>, lars@metafoo.de
References: <1489242404-12352-1-git-send-email-singhalsimran0@gmail.com>
 <1489242404-12352-2-git-send-email-singhalsimran0@gmail.com>
Cc: Michael.Hennerich@analog.com, knaack.h@gmx.de,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <a23128c1-a303-4c2a-5440-01cf5e3e0913@kernel.org>
Date: Sat, 11 Mar 2017 18:36:32 +0000
MIME-Version: 1.0
In-Reply-To: <1489242404-12352-2-git-send-email-singhalsimran0@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/03/17 14:26, simran singhal wrote:
> Remove & from function pointers to conform to the style found elsewhere
> in the file.  Done using the following semantic patch
> 
> // <smpl>
> @r@
> identifier f;
> @@
> 
> f(...) { ... }
> @@
> identifier r.f;
> @@
> 
> - &f
> + f
> // </smpl>
> 
> Signed-off-by: simran singhal <singhalsimran0@gmail.com>
Applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/adc/ad7192.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> index 4fc8588..d11c6de 100644
> --- a/drivers/staging/iio/adc/ad7192.c
> +++ b/drivers/staging/iio/adc/ad7192.c
> @@ -564,18 +564,18 @@ static int ad7192_write_raw_get_fmt(struct iio_dev *indio_dev,
>  }
>  
>  static const struct iio_info ad7192_info = {
> -	.read_raw = &ad7192_read_raw,
> -	.write_raw = &ad7192_write_raw,
> -	.write_raw_get_fmt = &ad7192_write_raw_get_fmt,
> +	.read_raw = ad7192_read_raw,
> +	.write_raw = ad7192_write_raw,
> +	.write_raw_get_fmt = ad7192_write_raw_get_fmt,
>  	.attrs = &ad7192_attribute_group,
>  	.validate_trigger = ad_sd_validate_trigger,
>  	.driver_module = THIS_MODULE,
>  };
>  
>  static const struct iio_info ad7195_info = {
> -	.read_raw = &ad7192_read_raw,
> -	.write_raw = &ad7192_write_raw,
> -	.write_raw_get_fmt = &ad7192_write_raw_get_fmt,
> +	.read_raw = ad7192_read_raw,
> +	.write_raw = ad7192_write_raw,
> +	.write_raw_get_fmt = ad7192_write_raw_get_fmt,
>  	.attrs = &ad7195_attribute_group,
>  	.validate_trigger = ad_sd_validate_trigger,
>  	.driver_module = THIS_MODULE,
> 

