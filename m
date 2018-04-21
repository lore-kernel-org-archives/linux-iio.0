Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752948AbeDUQU0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Apr 2018 12:20:26 -0400
Date: Sat, 21 Apr 2018 17:20:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        Jon.Brenner@ams.com
Subject: Re: [PATCH 04/13] staging: iio: tsl2x7x: simplify
 tsl2x7x_clear_interrupts function
Message-ID: <20180421172019.450ec9c6@archlinux>
In-Reply-To: <20180421004153.19073-5-masneyb@onstation.org>
References: <20180421004153.19073-1-masneyb@onstation.org>
        <20180421004153.19073-5-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 20 Apr 2018 20:41:44 -0400
Brian Masney <masneyb@onstation.org> wrote:

> tsl2x7x_clear_interrupts() takes a reg argument but there are only
> two callers to this function and both callers pass the same value.
> Since this function was introduced, interrupts are now working
> properly for this driver, and several unnecessary calls to
> tsl2x7x_clear_interrupts() were removed. This patch removes the
> tsl2x7x_clear_interrupts() function and replaces the two callers
> with the i2c_smbus_write_byte() call instead.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied

Thanks,

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 32 +++++++++++++++-----------------
>  1 file changed, 15 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 95a00b965c5e..f37fc74b8fbc 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -271,20 +271,6 @@ static const u8 device_channel_config[] = {
>  	ALSPRX2
>  };
>  
> -static int tsl2x7x_clear_interrupts(struct tsl2X7X_chip *chip, int reg)
> -{
> -	int ret;
> -
> -	ret = i2c_smbus_write_byte(chip->client,
> -				   TSL2X7X_CMD_REG | TSL2X7X_CMD_SPL_FN | reg);
> -	if (ret < 0)
> -		dev_err(&chip->client->dev,
> -			"%s: failed to clear interrupt status %x: %d\n",
> -			__func__, reg, ret);
> -
> -	return ret;
> -}
> -
>  static int tsl2x7x_read_status(struct tsl2X7X_chip *chip)
>  {
>  	int ret;
> @@ -714,9 +700,15 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = tsl2x7x_clear_interrupts(chip, TSL2X7X_CMD_PROXALS_INT_CLR);
> -	if (ret < 0)
> +	ret = i2c_smbus_write_byte(chip->client,
> +				   TSL2X7X_CMD_REG | TSL2X7X_CMD_SPL_FN |
> +				   TSL2X7X_CMD_PROXALS_INT_CLR);
> +	if (ret < 0) {
> +		dev_err(&chip->client->dev,
> +			"%s: failed to clear interrupt status: %d\n",
> +			__func__, ret);
>  		return ret;
> +	}
>  
>  	chip->tsl2x7x_chip_status = TSL2X7X_CHIP_WORKING;
>  
> @@ -1341,7 +1333,13 @@ static irqreturn_t tsl2x7x_event_handler(int irq, void *private)
>  			       timestamp);
>  	}
>  
> -	tsl2x7x_clear_interrupts(chip, TSL2X7X_CMD_PROXALS_INT_CLR);
> +	ret = i2c_smbus_write_byte(chip->client,
> +				   TSL2X7X_CMD_REG | TSL2X7X_CMD_SPL_FN |
> +				   TSL2X7X_CMD_PROXALS_INT_CLR);
> +	if (ret < 0)
> +		dev_err(&chip->client->dev,
> +			"%s: failed to clear interrupt status: %d\n",
> +			__func__, ret);
>  
>  	return IRQ_HANDLED;
>  }

