Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753812AbeCYRT4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 25 Mar 2018 13:19:56 -0400
Date: Sun, 25 Mar 2018 18:19:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        Jon.Brenner@ams.com
Subject: Re: [PATCH 3/4] staging: iio: tsl2x7x: use either direction for
 IIO_EV_INFO_{ENABLE,PERIOD}
Message-ID: <20180325181951.2af8567a@archlinux>
In-Reply-To: <20180324200555.1403-4-masneyb@onstation.org>
References: <20180324200555.1403-1-masneyb@onstation.org>
        <20180324200555.1403-4-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 24 Mar 2018 16:05:54 -0400
Brian Masney <masneyb@onstation.org> wrote:

> The events IIO_EV_INFO_VALUE and IIO_EV_INFO_ENABLE currently have a
> falling and rising direction configured. There does not need to be a
> separate distinction so this patch changes these to use the
> either direction. Directory listing of event sysfs attributes for a
> TSL2772 with this patch applied:
> 
> in_intensity0_thresh_either_en
> in_intensity0_thresh_either_period
> in_intensity0_thresh_falling_value
> in_intensity0_thresh_rising_value
> in_proximity0_thresh_either_en
> in_proximity0_thresh_either_period
> in_proximity0_thresh_falling_value
> in_proximity0_thresh_rising_value
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
This one is fine and reasonably clear of patch 2 so I can still apply it.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index d5a237fb0a0b..940bea2378a9 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -1469,17 +1469,16 @@ static const struct iio_event_spec tsl2x7x_events[] = {
>  	{
>  		.type = IIO_EV_TYPE_THRESH,
>  		.dir = IIO_EV_DIR_RISING,
> -		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
> -			BIT(IIO_EV_INFO_ENABLE),
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE),
>  	}, {
>  		.type = IIO_EV_TYPE_THRESH,
>  		.dir = IIO_EV_DIR_FALLING,
> -		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
> -			BIT(IIO_EV_INFO_ENABLE),
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE),
>  	}, {
>  		.type = IIO_EV_TYPE_THRESH,
>  		.dir = IIO_EV_DIR_EITHER,
> -		.mask_separate = BIT(IIO_EV_INFO_PERIOD),
> +		.mask_separate = BIT(IIO_EV_INFO_PERIOD) |
> +			BIT(IIO_EV_INFO_ENABLE),
>  	},
>  };
>  

