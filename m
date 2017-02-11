Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44933 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751794AbdBKJol (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Feb 2017 04:44:41 -0500
Subject: Re: [PATCH 3/7] staging: iio: isl29028: fix incorrect sampling
 frequency value
To: Brian Masney <masneyb@onstation.org>
References: <20170209015431.17380-1-masneyb@onstation.org>
 <20170209015431.17380-4-masneyb@onstation.org>
Cc: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        ldewangan@nvidia.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <75a21997-0a63-bff5-441c-838db3bce3b8@kernel.org>
Date: Sat, 11 Feb 2017 09:44:39 +0000
MIME-Version: 1.0
In-Reply-To: <20170209015431.17380-4-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/02/17 01:54, Brian Masney wrote:
> The sysfs attribute in_proximity_sampling_frequency_available currently
> shows the values 1 3 5 10 13 20 83 100. These values are supposed to
> correspond to the sleep values 800 400 200 100 75 50 12 0 (all in ms).
> When passing in a sampling frequency of 3, it actually uses a sleep
> time of 200ms instead of the expected 400ms value. This patch changes
> the 3 supported sampling frequency to 2 so that the proximity sleep
> time of 400ms can be used.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Given there is no real difficulty in supporting fixed point numbers, could
we move this over to:
1, 2.5, 5 etc

Will clearly require more changes than you have with the fixup here, but
would represent what is going on more accurately for minimal cost.

Jonathan
> ---
>  drivers/staging/iio/light/isl29028.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
> index 177dced..b63fdf70 100644
> --- a/drivers/staging/iio/light/isl29028.c
> +++ b/drivers/staging/iio/light/isl29028.c
> @@ -471,7 +471,7 @@ static int isl29028_read_raw(struct iio_dev *indio_dev,
>  }
>  
>  static IIO_CONST_ATTR(in_proximity_sampling_frequency_available,
> -				"1 3 5 10 13 20 83 100");
> +				"1 2 5 10 13 20 83 100");
>  static IIO_CONST_ATTR(in_illuminance_scale_available, "125 2000");
>  
>  #define ISL29028_CONST_ATTR(name) (&iio_const_attr_##name.dev_attr.attr)
> 

