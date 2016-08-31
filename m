Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55422 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753104AbcHaTrf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 31 Aug 2016 15:47:35 -0400
Subject: Re: [PATCH 10/17] iio: accel: kxsd9: Fix scaling bug
To: Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org
References: <1471354423-19186-1-git-send-email-linus.walleij@linaro.org>
 <1471354423-19186-11-git-send-email-linus.walleij@linaro.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <6c8174d4-0e53-edb3-8c3b-7304bb77ca91@kernel.org>
Date: Wed, 31 Aug 2016 20:47:32 +0100
MIME-Version: 1.0
In-Reply-To: <1471354423-19186-11-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/08/16 14:33, Linus Walleij wrote:
> All the scaling of the KXSD9 involves multiplication with a
> fraction number < 1.
> 
> However the scaling value returned from IIO_INFO_SCALE was
> unpredictable as only the micros of the value was assigned, and
> not the integer part, resulting in scaling like this:
> 
> $cat in_accel_scale
> -1057462640.011978
> 
> Fix this by assigning zero to the integer part.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
I'll pick this up for stable.  If you want to reorder so it's at the top
of the series of the remaining patches that would be cool.
If not I'll wiggle it till it fits.

Tested-by: Jonathan Cameron <jic23@kernel.org>

oops.
> ---
>  drivers/iio/accel/kxsd9.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
> index a8ee041dd4e4..14d949a4caf9 100644
> --- a/drivers/iio/accel/kxsd9.c
> +++ b/drivers/iio/accel/kxsd9.c
> @@ -146,6 +146,7 @@ static int kxsd9_read_raw(struct iio_dev *indio_dev,
>  				  &regval);
>  		if (ret < 0)
>  			goto error_ret;
> +		*val = 0;
>  		*val2 = kxsd9_micro_scales[regval & KXSD9_FS_MASK];
>  		ret = IIO_VAL_INT_PLUS_MICRO;
>  		break;
> 

