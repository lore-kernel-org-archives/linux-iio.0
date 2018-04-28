Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757745AbeD1Rh2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Apr 2018 13:37:28 -0400
Date: Sat, 28 Apr 2018 18:37:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Veenstra <davidjulianveenstra@gmail.com>
Cc: lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        Michael.Hennerich@analog.com, knaack.h@gmx.de,
        linux-iio@vger.kernel.org, daniel.baluta@nxp.com,
        devel@driverdev.osuosl.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 8/9] staging: iio: ad2s1200: Add scaling factor for
 angle channel
Message-ID: <20180428183722.489e2a71@archlinux>
In-Reply-To: <c29c928e1473a68fc57dc0ce7a60cf38273d5287.1524432236.git.davidjulianveenstra@gmail.com>
References: <cover.1524432236.git.davidjulianveenstra@gmail.com>
        <c29c928e1473a68fc57dc0ce7a60cf38273d5287.1524432236.git.davidjulianveenstra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 23 Apr 2018 00:04:24 +0200
David Veenstra <davidjulianveenstra@gmail.com> wrote:

> A scaling factor of approximately 2 * Pi / (2^12 -1) is added,
> to scale the 12-bits angular position to radians.
> 
> A return type of IIO_VAL_INT_PLUS_NANO is used, so that the scale of
> both the angle channel and angular velocity channel has 7 significant
> digits.
> 
> Signed-off-by: David Veenstra <davidjulianveenstra@gmail.com>
Good, will pick up with the precursors in v4.

Thanks,

Jonathan

> ---
> Changes in v3:
>  - A decimal approximation of the scale is used, instead
>    of a fractional approximation.
>  - Remove unneeded explanation of iio_convert_raw_to_processed.
> 
>  drivers/staging/iio/resolver/ad2s1200.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
> index 3e1696e52c38..d2b62308b31d 100644
> --- a/drivers/staging/iio/resolver/ad2s1200.c
> +++ b/drivers/staging/iio/resolver/ad2s1200.c
> @@ -60,6 +60,11 @@ static int ad2s1200_read_raw(struct iio_dev *indio_dev,
>  	switch (m) {
>  	case IIO_CHAN_INFO_SCALE:
>  		switch (chan->type) {
> +		case IIO_ANGL:
> +			/* 2 * Pi / (2^12 - 1) ~= 0.001534355 */
> +			*val = 0;
> +			*val2 = 1534355;
> +			return IIO_VAL_INT_PLUS_NANO;
>  		case IIO_ANGL_VEL:
>  			/* 2 * Pi ~= 6.283185 */
>  			*val = 6;
> @@ -114,6 +119,7 @@ static const struct iio_chan_spec ad2s1200_channels[] = {
>  		.indexed = 1,
>  		.channel = 0,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
>  	}, {
>  		.type = IIO_ANGL_VEL,
>  		.indexed = 1,

