Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932203AbeCJOhA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 10 Mar 2018 09:37:00 -0500
Date: Sat, 10 Mar 2018 14:36:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        Jon.Brenner@ams.com
Subject: Re: [PATCH 04/12] staging: iio: tsl2x7x: add common function for
 writing to the control register
Message-ID: <20180310143655.480655f5@archlinux>
In-Reply-To: <20180304014942.18727-5-masneyb@onstation.org>
References: <20180304014942.18727-1-masneyb@onstation.org>
        <20180304014942.18727-5-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat,  3 Mar 2018 20:49:34 -0500
Brian Masney <masneyb@onstation.org> wrote:

> There were four places where the same chunk of code was used to write
> to the control register. This patch creates a common function
> tsl2x7x_write_control_reg() to reduce duplicate code.
> 
> The function tsl2x7x_chip_off() did not correctly return an error
> code so this patch also corrects that issue.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Hmm. These are getting a bit marginal in benefit but this one just makes
it over the barrier.

The reduction in complexity is really very small...

Applied.

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 54 +++++++++++++++++--------------------
>  1 file changed, 25 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 6bb622816660..cf16dd206c0b 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -307,6 +307,21 @@ static int tsl2x7x_read_status(struct tsl2X7X_chip *chip)
>  	return ret;
>  }
>  
> +static int tsl2x7x_write_control_reg(struct tsl2X7X_chip *chip, u8 data)
> +{
> +	int ret;
> +
> +	ret = i2c_smbus_write_byte_data(chip->client,
> +					TSL2X7X_CMD_REG | TSL2X7X_CNTRL, data);
> +	if (ret < 0) {
> +		dev_err(&chip->client->dev,
> +			"%s: failed to write to control register %x: %d\n",
> +			__func__, data, ret);
> +	}
> +
> +	return ret;
> +}
> +
>  /**
>   * tsl2x7x_get_lux() - Reads and calculates current lux value.
>   * @indio_dev:	pointer to IIO device
> @@ -597,7 +612,6 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
>  	int i;
>  	int ret = 0;
>  	u8 *dev_reg;
> -	u8 utmp;
>  	int als_count;
>  	int als_time;
>  	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> @@ -659,14 +673,9 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
>  	 * TSL2X7X Specific power-on / adc enable sequence
>  	 * Power on the device 1st.
>  	 */
> -	utmp = TSL2X7X_CNTL_PWR_ON;
> -	ret = i2c_smbus_write_byte_data(chip->client,
> -					TSL2X7X_CMD_REG | TSL2X7X_CNTRL, utmp);
> -	if (ret < 0) {
> -		dev_err(&chip->client->dev,
> -			"%s: failed on CNTRL reg.\n", __func__);
> +	ret = tsl2x7x_write_control_reg(chip, TSL2X7X_CNTL_PWR_ON);
> +	if (ret < 0)
>  		return ret;
> -	}
>  
>  	/*
>  	 * Use the following shadow copy for our delay before enabling ADC.
> @@ -691,16 +700,12 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
>  	 * NOW enable the ADC
>  	 * initialize the desired mode of operation
>  	 */
> -	utmp = TSL2X7X_CNTL_PWR_ON |
> -			TSL2X7X_CNTL_ADC_ENBL |
> -			TSL2X7X_CNTL_PROX_DET_ENBL;
> -	ret = i2c_smbus_write_byte_data(chip->client,
> -					TSL2X7X_CMD_REG | TSL2X7X_CNTRL, utmp);
> -	if (ret < 0) {
> -		dev_err(&chip->client->dev,
> -			"%s: failed on 2nd CTRL reg.\n", __func__);
> +	ret = tsl2x7x_write_control_reg(chip,
> +					TSL2X7X_CNTL_PWR_ON |
> +					TSL2X7X_CNTL_ADC_ENBL |
> +					TSL2X7X_CNTL_PROX_DET_ENBL);
> +	if (ret < 0)
>  		return ret;
> -	}
>  
>  	chip->tsl2x7x_chip_status = TSL2X7X_CHIP_WORKING;
>  
> @@ -713,13 +718,9 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
>  			reg_val |= TSL2X7X_CNTL_PROX_DET_ENBL;
>  
>  		reg_val |= chip->settings.interrupts_en;
> -		ret = i2c_smbus_write_byte_data(chip->client,
> -						TSL2X7X_CMD_REG | TSL2X7X_CNTRL,
> -						reg_val);
> +		ret = tsl2x7x_write_control_reg(chip, reg_val);
>  		if (ret < 0)
> -			dev_err(&chip->client->dev,
> -				"%s: failed in tsl2x7x_IOCTL_INT_SET.\n",
> -				__func__);
> +			return ret;
>  
>  		ret = tsl2x7x_clear_interrupts(chip,
>  					       TSL2X7X_CMD_PROXALS_INT_CLR);
> @@ -732,16 +733,11 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
>  
>  static int tsl2x7x_chip_off(struct iio_dev *indio_dev)
>  {
> -	int ret;
>  	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
>  
>  	/* turn device off */
>  	chip->tsl2x7x_chip_status = TSL2X7X_CHIP_SUSPENDED;
> -
> -	ret = i2c_smbus_write_byte_data(chip->client,
> -					TSL2X7X_CMD_REG | TSL2X7X_CNTRL, 0x00);
> -
> -	return ret;
> +	return tsl2x7x_write_control_reg(chip, 0x00);
>  }
>  
>  /**

