Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753308AbeDOPDY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Apr 2018 11:03:24 -0400
Date: Sun, 15 Apr 2018 16:03:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?SGVybsOhbg==?= Gonzalez <hernan@vanguardiasur.com.ar>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, Michael.Hennerich@analog.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/14] staging: iio: ad7746: Adjust arguments to
 match open parenthesis
Message-ID: <20180415160319.4f0d725c@archlinux>
In-Reply-To: <1523637411-8531-3-git-send-email-hernan@vanguardiasur.com.ar>
References: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
        <1523637411-8531-3-git-send-email-hernan@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 13 Apr 2018 13:36:39 -0300
Hernán Gonzalez <hernan@vanguardiasur.com.ar> wrote:

> Clear a couple more checkpatch.pl CHECKS.
> 
> Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/cdc/ad7746.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
> index 53e28ae..516aa93 100644
> --- a/drivers/staging/iio/cdc/ad7746.c
> +++ b/drivers/staging/iio/cdc/ad7746.c
> @@ -556,7 +556,8 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
>  		/* Now read the actual register */
>  
>  		ret = i2c_smbus_read_i2c_block_data(chip->client,
> -			chan->address >> 8, 3, &chip->data.d8[1]);
> +						    chan->address >> 8, 3,
> +						    &chip->data.d8[1]);
>  
>  		if (ret < 0)
>  			goto out;
> @@ -614,7 +615,7 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
>  		break;
>  	case IIO_CHAN_INFO_OFFSET:
>  		*val = AD7746_CAPDAC_DACP(chip->capdac[chan->channel]
> -			[chan->differential]) * 338646;
> +					  [chan->differential]) * 338646;
>  
>  		ret = IIO_VAL_INT;
>  		break;

