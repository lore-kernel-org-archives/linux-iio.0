Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35277 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750800AbdAUOmB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Jan 2017 09:42:01 -0500
Subject: Re: [PATCH v2 05/15] staging: iio: isl29028: remove unused define
 ISL29028_DEV_ATTR
To: Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
References: <20170117092502.6951-1-masneyb@onstation.org>
 <20170117092502.6951-6-masneyb@onstation.org>
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, ldewangan@nvidia.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <d2dfa7d0-c016-183b-4a42-912ae0196216@kernel.org>
Date: Sat, 21 Jan 2017 14:41:59 +0000
MIME-Version: 1.0
In-Reply-To: <20170117092502.6951-6-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/01/17 09:24, Brian Masney wrote:
> The #define ISL29028_DEV_ATTR was not used so this patch removes the
> unnecessary code.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied.
> ---
>  drivers/staging/iio/light/isl29028.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
> index d05d761..7074e62 100644
> --- a/drivers/staging/iio/light/isl29028.c
> +++ b/drivers/staging/iio/light/isl29028.c
> @@ -391,7 +391,6 @@ static IIO_CONST_ATTR(in_proximity_sampling_frequency_available,
>  				"1 3 5 10 13 20 83 100");
>  static IIO_CONST_ATTR(in_illuminance_scale_available, "125 2000");
>  
> -#define ISL29028_DEV_ATTR(name) (&iio_dev_attr_##name.dev_attr.attr)
>  #define ISL29028_CONST_ATTR(name) (&iio_const_attr_##name.dev_attr.attr)
>  static struct attribute *isl29028_attributes[] = {
>  	ISL29028_CONST_ATTR(in_proximity_sampling_frequency_available),
> 

