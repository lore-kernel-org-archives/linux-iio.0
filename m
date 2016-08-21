Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53247 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753318AbcHUTnG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 Aug 2016 15:43:06 -0400
Subject: Re: [PATCH 02/17] iio: accel: kxsd9: Fix raw read return
To: Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org
References: <1471354423-19186-1-git-send-email-linus.walleij@linaro.org>
 <1471354423-19186-3-git-send-email-linus.walleij@linaro.org>
Cc: stable@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <0290b880-20db-690d-93aa-ca3c6bf5d189@kernel.org>
Date: Sun, 21 Aug 2016 20:43:04 +0100
MIME-Version: 1.0
In-Reply-To: <1471354423-19186-3-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/08/16 14:33, Linus Walleij wrote:
> Any readings from the raw interface of the KXSD9 driver will
> return an empty string, because it does not return
> IIO_VAL_INT but rather some random value from the accelerometer
> to the caller.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan
> ---
>  drivers/iio/accel/kxsd9.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
> index 3a9f106787d2..da5fb67ecb34 100644
> --- a/drivers/iio/accel/kxsd9.c
> +++ b/drivers/iio/accel/kxsd9.c
> @@ -160,6 +160,7 @@ static int kxsd9_read_raw(struct iio_dev *indio_dev,
>  		if (ret < 0)
>  			goto error_ret;
>  		*val = ret;
> +		ret = IIO_VAL_INT;
>  		break;
>  	case IIO_CHAN_INFO_SCALE:
>  		ret = spi_w8r8(st->us, KXSD9_READ(KXSD9_REG_CTRL_C));
> 

