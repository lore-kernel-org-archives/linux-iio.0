Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752185AbdLJSYq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Dec 2017 13:24:46 -0500
Date: Sun, 10 Dec 2017 18:24:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, daniel.baluta@gmail.com,
        mranostay@gmail.com
Subject: Re: [PATCH] iio: chemical: ccs811: Fix output of IIO_CONCENTRATION
 channels
Message-ID: <20171210182441.5882c372@archlinux>
In-Reply-To: <1512579478-24601-1-git-send-email-narcisaanamaria12@gmail.com>
References: <1512579478-24601-1-git-send-email-narcisaanamaria12@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed,  6 Dec 2017 18:57:58 +0200
Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com> wrote:
+CC Matt
> in_concentration_raw should report, according to sysfs-bus-iio documentation,
> a "Raw (unscaled no offset etc.) percentage reading of a substance."
> 
> Modify scale to convert from ppm/ppb to percentage:
> 1 ppm = 0.0001%
> 1 ppb = 0.0000001%
> 
> There is no offset needed to convert the ppm/ppb to percentage,
> so remove offset from IIO_CONCENTRATION (IIO_MOD_CO2) channel.
> 
> Signed-off-by: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
> ---
> Details:
> The sensors reports data in parts per million for CO2 and parts per
> billion for VOC. The current scaling and offset values were meant to
> convert the ppm/ppb value into a percentage value with respect to
> the sensor's measurement range:
> For example:
>     For eCO2, possible raw values range from 400ppm to 8192ppm.
>     If the value reported is, let's say 500ppm, then, after scaling and
>     offset are applied, the percentage, with reference to the interval
>     [400, 8192] is 1.28%, using this interval mapping formula:
>     (500 - 400) * (100 - 0) / (8192 - 400) + 0. Instead, the value should
>     be 500 * 0.0001 = 0.05% (from ppm to percentage).
> 
> Note:
> In the docs, the in_concentration_raw value is said to be a
> "raw percentage reading of a substance". The raw value from the sensor
> is a ppm/ppb value, not a percentage value. It becomes a percentage value
> after applying a scale. Is this the correct behaviour (after applying scale,
> a percentage value is obtained) or did I misunderstood the docs?

I 'think' you are right on this, but would like some input from
someone more familiar with chemical sensors in general.

Matt, any comment on this?

Thanks,

Jonathan
> 
>  drivers/iio/chemical/ccs811.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/chemical/ccs811.c b/drivers/iio/chemical/ccs811.c
> index 97bce83..fbe2431 100644
> --- a/drivers/iio/chemical/ccs811.c
> +++ b/drivers/iio/chemical/ccs811.c
> @@ -96,7 +96,6 @@ struct ccs811_data {
>  		.channel2 = IIO_MOD_CO2,
>  		.modified = 1,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> -				      BIT(IIO_CHAN_INFO_OFFSET) |
>  				      BIT(IIO_CHAN_INFO_SCALE),
>  		.scan_index = 0,
>  		.scan_type = {
> @@ -255,24 +254,18 @@ static int ccs811_read_raw(struct iio_dev *indio_dev,
>  			switch (chan->channel2) {
>  			case IIO_MOD_CO2:
>  				*val = 0;
> -				*val2 = 12834;
> +				*val2 = 100;
>  				return IIO_VAL_INT_PLUS_MICRO;
>  			case IIO_MOD_VOC:
>  				*val = 0;
> -				*val2 = 84246;
> -				return IIO_VAL_INT_PLUS_MICRO;
> +				*val2 = 100;
> +				return IIO_VAL_INT_PLUS_NANO;
>  			default:
>  				return -EINVAL;
>  			}
>  		default:
>  			return -EINVAL;
>  		}
> -	case IIO_CHAN_INFO_OFFSET:
> -		if (!(chan->type == IIO_CONCENTRATION &&
> -		      chan->channel2 == IIO_MOD_CO2))
> -			return -EINVAL;
> -		*val = -400;
> -		return IIO_VAL_INT;
>  	default:
>  		return -EINVAL;
>  	}
> --
> 1.9.1
> 

