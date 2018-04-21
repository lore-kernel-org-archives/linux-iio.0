Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752947AbeDURK3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Apr 2018 13:10:29 -0400
Date: Sat, 21 Apr 2018 18:10:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Veenstra <davidjulianveenstra@gmail.com>
Cc: lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        Michael.Hennerich@analog.com, knaack.h@gmx.de,
        daniel.baluta@nxp.com, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 12/13] staging: iio: ad2s1200: Add scaling factor for
 angle channel
Message-ID: <20180421181023.3f6e0c8b@archlinux>
In-Reply-To: <9352ade3afee830795315b5931dfb316853dc094.1524247563.git.davidjulianveenstra@gmail.com>
References: <cover.1524247563.git.davidjulianveenstra@gmail.com>
        <9352ade3afee830795315b5931dfb316853dc094.1524247563.git.davidjulianveenstra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 20 Apr 2018 21:31:48 +0200
David Veenstra <davidjulianveenstra@gmail.com> wrote:

> A fractional scaling factor of approximately 2 * Pi / (2^12 -1) is added,
> to scale the 12-bits angular position to radians.
> 
> Signed-off-by: David Veenstra <davidjulianveenstra@gmail.com>
> ---
> Changes in v2:
>   - This patch replaces the patch that changed the
>     the channel for angular position to inclination
>     channel.
> 
>  drivers/staging/iio/resolver/ad2s1200.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
> index 6c56257be3b1..4f5dd28b174a 100644
> --- a/drivers/staging/iio/resolver/ad2s1200.c
> +++ b/drivers/staging/iio/resolver/ad2s1200.c
> @@ -71,6 +71,17 @@ static int ad2s1200_read_raw(struct iio_dev *indio_dev,
>  	switch (m) {
>  	case IIO_CHAN_INFO_SCALE:
>  		switch (chan->type) {
> +		case IIO_ANGL:
> +			/*
> +			 * 2 * Pi / (2^12 - 1) ~= 2 * 103993 / (33102 * 0xFFF)
> +			 *
> +			 * Since there only fit 3 whole radians in 360 degrees,
> +			 * usage of iio_convert_raw_to_processed for this
> +			 * channel will be highly inaccurate.
> +			 */
> +			*val = 103993;
> +			*val2 = 16551 * 0xFFF;
> +			return IIO_VAL_FRACTIONAL;
Again, use IIO_VAL_INT_PLUS_MICRO and specify it as a decimal.  There is
no need to jump through these hoops when we are unlikely to have any users
that need to keep to integer only maths.

Thanks,

Jonathan

>  		case IIO_ANGL_VEL:
>  			/*
>  			 * 2 * Pi ~= 2 * 103993 / 33102
> @@ -133,6 +144,7 @@ static const struct iio_chan_spec ad2s1200_channels[] = {
>  		.indexed = 1,
>  		.channel = 0,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
>  	}, {
>  		.type = IIO_ANGL_VEL,
>  		.indexed = 1,

