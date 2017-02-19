Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37171 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751734AbdBSLVe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Feb 2017 06:21:34 -0500
Subject: Re: [PATCH v2 1/2] staging: iio: isl29028: change sampling
 frequencies available to use decimals
To: Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
References: <20170212105534.5648-1-masneyb@onstation.org>
 <20170212105534.5648-2-masneyb@onstation.org>
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, ldewangan@nvidia.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <fa9a667e-28b1-6f91-297c-81fc3d10ef42@kernel.org>
Date: Sun, 19 Feb 2017 11:21:26 +0000
MIME-Version: 1.0
In-Reply-To: <20170212105534.5648-2-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/02/17 10:55, Brian Masney wrote:
> The sysfs attribute in_proximity_sampling_frequency_available currently
> shows the values 1 3 5 10 13 20 83 100. These values are supposed to
> correspond to the sleep values 800 400 200 100 75 50 12 0 (all in ms).
> When passing in a sampling frequency of 3, it actually uses a sleep
> time of 200ms instead of the expected 400ms value. This patch changes
> the value shown by this sysfs attribute to use decimal numbers so
> that the correct sampling frequency is shown to the user. Only the
> integer portion is actually passed to isl29028_set_proxim_sampling(),
> but that is ok since the correct sleep time will still be selected.
I'm a little bothered by this because the behaviour is not consistent if we
feed it various values around 2.5 for example.
2.0-2.9999 all get rounded to 2.5 where as 3 gets round to 5.
We need something more logical.

As a side note, 1000/12.5 = 80 not 83.3333 which looks like a bug to me.

All these frequencies are wrong anyway as they are based on the assumption
that all the time is spent in the inter sample sleeps.  I think
the datasheet puts this at 0.54 msecs so doesn't make much difference ;)

I'm not 100% sure if running proximity and ambient light sensing at the same
time changes the frequency or not.

So I'd like to see it do one of two things, reject any value not matching
what is exposed in the _available attribute, or round up on the basis
if we select the sampling frequency we'll typically set it to the lowest
value that meets our requirements.  (I debated rounding to nearest, but
I think for sampling frequency it should be round up).  We should probably
document that as well in the ABI docs as it will be non obvious which one
makes sense for different parameters!

Jonathan
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
>  drivers/staging/iio/light/isl29028.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
> index 5375e7a..c1d6540 100644
> --- a/drivers/staging/iio/light/isl29028.c
> +++ b/drivers/staging/iio/light/isl29028.c
> @@ -472,7 +472,7 @@ static int isl29028_read_raw(struct iio_dev *indio_dev,
>  }
>  
>  static IIO_CONST_ATTR(in_proximity_sampling_frequency_available,
> -				"1 3 5 10 13 20 83 100");
> +				"1.25 2.5 5 10 13.3 20 83.3 100");
>  static IIO_CONST_ATTR(in_illuminance_scale_available, "125 2000");
>  
>  #define ISL29028_CONST_ATTR(name) (&iio_const_attr_##name.dev_attr.attr)
> 

