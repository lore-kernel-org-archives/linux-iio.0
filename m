Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750895AbeETLKO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 20 May 2018 07:10:14 -0400
Date: Sun, 20 May 2018 12:10:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Veenstra <davidjulianveenstra@gmail.com>
Cc: lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        Michael.Hennerich@analog.com, knaack.h@gmx.de,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 10/12] staging: iio: ad2s1200: Add scaling factor for
 angle channel
Message-ID: <20180520121008.5680ffc7@archlinux>
In-Reply-To: <559356a5b2467bd871e12460faa4edb3c80980ec.1526667118.git.davidjulianveenstra@gmail.com>
References: <cover.1526667118.git.davidjulianveenstra@gmail.com>
        <559356a5b2467bd871e12460faa4edb3c80980ec.1526667118.git.davidjulianveenstra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 18 May 2018 20:23:14 +0200
David Veenstra <davidjulianveenstra@gmail.com> wrote:

> A scaling factor of approximately 2 * Pi / (2^12 -1) is added,
> to scale the 12-bits angular position to radians.
> 
> A return type of IIO_VAL_INT_PLUS_NANO is used, so that the scale of
> both the angle channel and angular velocity channel has 7 significant
> digits.
> 
> Signed-off-by: David Veenstra <davidjulianveenstra@gmail.com>
Applied

Thanks,

Jonathan
> ---
>  drivers/staging/iio/resolver/ad2s1200.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
> index 7b8af558e921..10d6d79dce79 100644
> --- a/drivers/staging/iio/resolver/ad2s1200.c
> +++ b/drivers/staging/iio/resolver/ad2s1200.c
> @@ -58,6 +58,11 @@ static int ad2s1200_read_raw(struct iio_dev *indio_dev,
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
> @@ -112,6 +117,7 @@ static const struct iio_chan_spec ad2s1200_channels[] = {
>  		.indexed = 1,
>  		.channel = 0,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
>  	}, {
>  		.type = IIO_ANGL_VEL,
>  		.indexed = 1,

