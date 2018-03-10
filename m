Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932075AbeCJO2D (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 10 Mar 2018 09:28:03 -0500
Date: Sat, 10 Mar 2018 14:27:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        Jon.Brenner@ams.com
Subject: Re: [PATCH 02/12] staging: iio: tsl2x7x: add common function for
 clearing interrupts
Message-ID: <20180310142757.1716947b@archlinux>
In-Reply-To: <20180304014942.18727-3-masneyb@onstation.org>
References: <20180304014942.18727-1-masneyb@onstation.org>
        <20180304014942.18727-3-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat,  3 Mar 2018 20:49:32 -0500
Brian Masney <masneyb@onstation.org> wrote:

> There were three places where the same chunk of code was used to clear
> interrupts. This patch creates a common function
> tsl2x7x_clear_interrupts() to reduce duplicate code.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Hmm. This one wasn't immediately clear to me but having looked at the datasheet
I see the logic in combining these into one function so fair enough.

The odd addresses being set as bits within a register had me confused.

Applied

Thanks,

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 52 +++++++++++++++++--------------------
>  1 file changed, 24 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index b7e3f966c3a6..c02db03ef369 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -279,6 +279,20 @@ static const u8 device_channel_config[] = {
>  	ALSPRX2
>  };
>  
> +static int tsl2x7x_clear_interrupts(struct tsl2X7X_chip *chip, int reg)
> +{
> +	int ret;
> +
> +	ret = i2c_smbus_write_byte(chip->client,
> +				   TSL2X7X_CMD_REG | TSL2X7X_CMD_SPL_FN | reg);
> +	if (ret < 0)
> +		dev_err(&chip->client->dev,
> +			"%s: failed to clear interrupt status %x: %d\n",
> +			__func__, reg, ret);
> +
> +	return ret;
> +}
> +
>  /**
>   * tsl2x7x_get_lux() - Reads and calculates current lux value.
>   * @indio_dev:	pointer to IIO device
> @@ -346,16 +360,9 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
>  		buf[i] = ret;
>  	}
>  
> -	/* clear any existing interrupt status */
> -	ret = i2c_smbus_write_byte(chip->client,
> -				   TSL2X7X_CMD_REG |
> -				   TSL2X7X_CMD_SPL_FN |
> -				   TSL2X7X_CMD_ALS_INT_CLR);
> -	if (ret < 0) {
> -		dev_err(&chip->client->dev,
> -			"i2c_write_command failed - err = %d\n", ret);
> -		goto out_unlock; /* have no data, so return failure */
> -	}
> +	ret = tsl2x7x_clear_interrupts(chip, TSL2X7X_CMD_ALS_INT_CLR);
> +	if (ret < 0)
> +		goto out_unlock;
>  
>  	/* extract ALS/lux data */
>  	ch0 = le16_to_cpup((const __le16 *)&buf[0]);
> @@ -706,17 +713,10 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
>  				"%s: failed in tsl2x7x_IOCTL_INT_SET.\n",
>  				__func__);
>  
> -		/* Clear out any initial interrupts  */
> -		ret = i2c_smbus_write_byte(chip->client,
> -					   TSL2X7X_CMD_REG |
> -					   TSL2X7X_CMD_SPL_FN |
> -					   TSL2X7X_CMD_PROXALS_INT_CLR);
> -		if (ret < 0) {
> -			dev_err(&chip->client->dev,
> -				"%s: Failed to clear Int status\n",
> -				__func__);
> -		return ret;
> -		}
> +		ret = tsl2x7x_clear_interrupts(chip,
> +					       TSL2X7X_CMD_PROXALS_INT_CLR);
> +		if (ret < 0)
> +			return ret;
>  	}
>  
>  	return ret;
> @@ -1421,14 +1421,10 @@ static irqreturn_t tsl2x7x_event_handler(int irq, void *private)
>  						    IIO_EV_DIR_EITHER),
>  			       timestamp);
>  	}
> -	/* Clear interrupt now that we have handled it. */
> -	ret = i2c_smbus_write_byte(chip->client,
> -				   TSL2X7X_CMD_REG | TSL2X7X_CMD_SPL_FN |
> -				   TSL2X7X_CMD_PROXALS_INT_CLR);
> +
> +	ret = tsl2x7x_clear_interrupts(chip, TSL2X7X_CMD_PROXALS_INT_CLR);
>  	if (ret < 0)
> -		dev_err(&chip->client->dev,
> -			"Failed to clear irq from event handler. err = %d\n",
> -			ret);
> +		return ret;
>  
>  	return IRQ_HANDLED;
>  }

