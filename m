Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45572 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754411AbcICRbg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 3 Sep 2016 13:31:36 -0400
Subject: Re: [PATCH 01/15 v2] iio: accel: kxsd9: Fix scaling bug
To: Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org
References: <1472723089-25113-1-git-send-email-linus.walleij@linaro.org>
Cc: stable@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <4b3d2f7d-e95b-32dd-3523-c7ceaeed5cb0@kernel.org>
Date: Sat, 3 Sep 2016 18:31:28 +0100
MIME-Version: 1.0
In-Reply-To: <1472723089-25113-1-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/09/16 10:44, Linus Walleij wrote:
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
> Cc: stable@vger.kernel.org
> Tested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan
> ---
> ChangeLog v1->v2:
> - Move this first in the series as Jonathan's request.
> ---
>  drivers/iio/accel/kxsd9.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
> index da5fb67ecb34..9d72d4bcf5e9 100644
> --- a/drivers/iio/accel/kxsd9.c
> +++ b/drivers/iio/accel/kxsd9.c
> @@ -166,6 +166,7 @@ static int kxsd9_read_raw(struct iio_dev *indio_dev,
>  		ret = spi_w8r8(st->us, KXSD9_READ(KXSD9_REG_CTRL_C));
>  		if (ret < 0)
>  			goto error_ret;
> +		*val = 0;
>  		*val2 = kxsd9_micro_scales[ret & KXSD9_FS_MASK];
>  		ret = IIO_VAL_INT_PLUS_MICRO;
>  		break;
> 

