Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751145AbeCJOer (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 10 Mar 2018 09:34:47 -0500
Date: Sat, 10 Mar 2018 14:34:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        Jon.Brenner@ams.com
Subject: Re: [PATCH 03/12] staging: iio: tsl2x7x: add common function for
 reading chip status
Message-ID: <20180310143442.7d9974f2@archlinux>
In-Reply-To: <20180304014942.18727-4-masneyb@onstation.org>
References: <20180304014942.18727-1-masneyb@onstation.org>
        <20180304014942.18727-4-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat,  3 Mar 2018 20:49:33 -0500
Brian Masney <masneyb@onstation.org> wrote:

> There were three places where the same chunk of code was used to read
> the chip status. This patch creates a common function
> tsl2x7x_read_status() to reduce duplicate code. This patch also corrects
> tsl2x7x_event_handler() to properly check for an error after reading the
> chip status.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied.
> ---
>  drivers/staging/iio/light/tsl2x7x.c | 40 ++++++++++++++++++++++---------------
>  1 file changed, 24 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index c02db03ef369..6bb622816660 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -293,6 +293,20 @@ static int tsl2x7x_clear_interrupts(struct tsl2X7X_chip *chip, int reg)
>  	return ret;
>  }
>  
> +static int tsl2x7x_read_status(struct tsl2X7X_chip *chip)
> +{
> +	int ret;
> +
> +	ret = i2c_smbus_read_byte_data(chip->client,
> +				       TSL2X7X_CMD_REG | TSL2X7X_STATUS);
> +	if (ret < 0)
> +		dev_err(&chip->client->dev,
> +			"%s: failed to read STATUS register: %d\n", __func__,
> +			ret);
> +
> +	return ret;
> +}
> +
>  /**
>   * tsl2x7x_get_lux() - Reads and calculates current lux value.
>   * @indio_dev:	pointer to IIO device
> @@ -332,13 +346,10 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
>  		goto out_unlock;
>  	}
>  
> -	ret = i2c_smbus_read_byte_data(chip->client,
> -				       TSL2X7X_CMD_REG | TSL2X7X_STATUS);
> -	if (ret < 0) {
> -		dev_err(&chip->client->dev,
> -			"%s: Failed to read STATUS Reg\n", __func__);
> +	ret = tsl2x7x_read_status(chip);
> +	if (ret < 0)
>  		goto out_unlock;
> -	}
> +
>  	/* is data new & valid */
>  	if (!(ret & TSL2X7X_STA_ADC_VALID)) {
>  		dev_err(&chip->client->dev,
> @@ -458,12 +469,9 @@ static int tsl2x7x_get_prox(struct iio_dev *indio_dev)
>  		return -EBUSY;
>  	}
>  
> -	ret = i2c_smbus_read_byte_data(chip->client,
> -				       TSL2X7X_CMD_REG | TSL2X7X_STATUS);
> -	if (ret < 0) {
> -		dev_err(&chip->client->dev, "i2c err=%d\n", ret);
> +	ret = tsl2x7x_read_status(chip);
> +	if (ret < 0)
>  		goto prox_poll_err;
> -	}
>  
>  	switch (chip->id) {
>  	case tsl2571:
> @@ -1396,13 +1404,13 @@ static irqreturn_t tsl2x7x_event_handler(int irq, void *private)
>  	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
>  	s64 timestamp = iio_get_time_ns(indio_dev);
>  	int ret;
> -	u8 value;
>  
> -	value = i2c_smbus_read_byte_data(chip->client,
> -					 TSL2X7X_CMD_REG | TSL2X7X_STATUS);
> +	ret = tsl2x7x_read_status(chip);
> +	if (ret < 0)
> +		return ret;
>  
>  	/* What type of interrupt do we need to process */
> -	if (value & TSL2X7X_STA_PRX_INTR) {
> +	if (ret & TSL2X7X_STA_PRX_INTR) {
>  		tsl2x7x_get_prox(indio_dev); /* freshen data for ABI */
>  		iio_push_event(indio_dev,
>  			       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY,
> @@ -1412,7 +1420,7 @@ static irqreturn_t tsl2x7x_event_handler(int irq, void *private)
>  						    timestamp);
>  	}
>  
> -	if (value & TSL2X7X_STA_ALS_INTR) {
> +	if (ret & TSL2X7X_STA_ALS_INTR) {
>  		tsl2x7x_get_lux(indio_dev); /* freshen data for ABI */
>  		iio_push_event(indio_dev,
>  			       IIO_UNMOD_EVENT_CODE(IIO_LIGHT,

