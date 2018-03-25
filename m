Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753482AbeCYRJR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 25 Mar 2018 13:09:17 -0400
Date: Sun, 25 Mar 2018 18:09:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        Jon.Brenner@ams.com
Subject: Re: [PATCH 1/4] staging: iio: tsl2x7x: use auto increment I2C
 protocol
Message-ID: <20180325180911.58350c6c@archlinux>
In-Reply-To: <20180324200555.1403-2-masneyb@onstation.org>
References: <20180324200555.1403-1-masneyb@onstation.org>
        <20180324200555.1403-2-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 24 Mar 2018 16:05:52 -0400
Brian Masney <masneyb@onstation.org> wrote:

> The hardware supports 16-bit ALS and proximity readings, however the
> datasheet recommends using the I2C auto increment protocol so that the
> correct high and low bytes are read even if the integration cycle ends
> between reading the lower and upper registers. More information about
> this protocol can be found at https://www.i2c-bus.org/auto-increment/.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
This isn't what I'd normally expect to see when autoincrement is going on.
You normally have to keep the transfer from ending.
See below

However looking at the datasheet it seems to be doing exactly what
you have here so that wins the 'odd' award for the day.
Ah well. All I'm going to do is delete the reference to the standard
from this patch as it isn't complying with it...

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan


> ---
>  drivers/staging/iio/light/tsl2x7x.c | 100 ++++++++++++++++++++++++------------
>  1 file changed, 67 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 77a81d75af4f..8530bccdb317 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -80,6 +80,8 @@
>  /* tsl2X7X cmd reg masks */
>  #define TSL2X7X_CMD_REG			0x80
>  #define TSL2X7X_CMD_SPL_FN		0x60
> +#define TSL2X7X_CMD_REPEAT_PROTO	0x00
> +#define TSL2X7X_CMD_AUTOINC_PROTO	0x20
>  
>  #define TSL2X7X_CMD_PROX_INT_CLR	0X05
>  #define TSL2X7X_CMD_ALS_INT_CLR		0x06
> @@ -320,6 +322,55 @@ static int tsl2x7x_write_control_reg(struct tsl2X7X_chip *chip, u8 data)
>  	return ret;
>  }
>  
> +static int tsl2x7x_read_autoinc_regs(struct tsl2X7X_chip *chip, int lower_reg,
> +				     int upper_reg)
> +{
> +	u8 buf[2];
> +	int ret;
> +
> +	ret = i2c_smbus_write_byte(chip->client,
> +				   TSL2X7X_CMD_REG | TSL2X7X_CMD_AUTOINC_PROTO |
> +				   lower_reg);
> +	if (ret < 0) {
> +		dev_err(&chip->client->dev,
> +			"%s: failed to enable auto increment protocol: %d\n",
> +			__func__, ret);
> +		return ret;
> +	}
> +
> +	ret = i2c_smbus_read_byte_data(chip->client,
> +				       TSL2X7X_CMD_REG | lower_reg);
> +	if (ret < 0) {
> +		dev_err(&chip->client->dev,
> +			"%s: failed to read from register %x: %d\n", __func__,
> +			lower_reg, ret);
> +		return ret;
> +	}
> +	buf[0] = ret;
> +
The description you link to implies we can't hae a stop between these.
That would mean you need to do them in one go.
i2c_smbus_read_block_data would do that...

> +	ret = i2c_smbus_read_byte_data(chip->client,
> +				       TSL2X7X_CMD_REG | upper_reg);
> +	if (ret < 0) {
> +		dev_err(&chip->client->dev,
> +			"%s: failed to read from register %x: %d\n", __func__,
> +			upper_reg, ret);
> +		return ret;
> +	}
> +	buf[1] = ret;
> +
> +	ret = i2c_smbus_write_byte(chip->client,
> +				   TSL2X7X_CMD_REG | TSL2X7X_CMD_REPEAT_PROTO |
> +				   lower_reg);
> +	if (ret < 0) {
> +		dev_err(&chip->client->dev,
> +			"%s: failed to enable repeated byte protocol: %d\n",
> +			__func__, ret);
> +		return ret;
> +	}
> +
> +	return le16_to_cpup((const __le16 *)&buf[0]);
> +}
> +
>  /**
>   * tsl2x7x_get_lux() - Reads and calculates current lux value.
>   * @indio_dev:	pointer to IIO device
> @@ -340,9 +391,8 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
>  	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
>  	struct tsl2x7x_lux *p;
>  	u32 lux, ratio;
> -	int i, ret;
>  	u64 lux64;
> -	u8 buf[4];
> +	int ret;
>  
>  	mutex_lock(&chip->als_mutex);
>  
> @@ -366,23 +416,17 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
>  		goto out_unlock;
>  	}
>  
> -	for (i = 0; i < 4; i++) {
> -		int reg = TSL2X7X_CMD_REG | (TSL2X7X_ALS_CHAN0LO + i);
> -
> -		ret = i2c_smbus_read_byte_data(chip->client, reg);
> -		if (ret < 0) {
> -			dev_err(&chip->client->dev,
> -				"%s: failed to read from register %x: %d\n",
> -				__func__, reg, ret);
> -			goto out_unlock;
> -		}
> -
> -		buf[i] = ret;
> -	}
> +	ret = tsl2x7x_read_autoinc_regs(chip, TSL2X7X_ALS_CHAN0LO,
> +					TSL2X7X_ALS_CHAN0HI);
> +	if (ret < 0)
> +		goto out_unlock;
> +	chip->als_cur_info.als_ch0 = ret;
>  
> -	/* extract ALS/lux data */
> -	chip->als_cur_info.als_ch0 = le16_to_cpup((const __le16 *)&buf[0]);
> -	chip->als_cur_info.als_ch1 = le16_to_cpup((const __le16 *)&buf[2]);
> +	ret = tsl2x7x_read_autoinc_regs(chip, TSL2X7X_ALS_CHAN1LO,
> +					TSL2X7X_ALS_CHAN1HI);
> +	if (ret < 0)
> +		goto out_unlock;
> +	chip->als_cur_info.als_ch1 = ret;
>  
>  	if (chip->als_cur_info.als_ch0 >= chip->als_saturation ||
>  	    chip->als_cur_info.als_ch1 >= chip->als_saturation) {
> @@ -456,10 +500,8 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
>   */
>  static int tsl2x7x_get_prox(struct iio_dev *indio_dev)
>  {
> -	int i;
> -	int ret;
> -	u8 chdata[2];
>  	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> +	int ret;
>  
>  	mutex_lock(&chip->prox_mutex);
>  
> @@ -490,18 +532,10 @@ static int tsl2x7x_get_prox(struct iio_dev *indio_dev)
>  		break;
>  	}
>  
> -	for (i = 0; i < 2; i++) {
> -		int reg = TSL2X7X_CMD_REG | (TSL2X7X_PRX_LO + i);
> -
> -		ret = i2c_smbus_read_byte_data(chip->client, reg);
> -		if (ret < 0)
> -			goto prox_poll_err;
> -
> -		chdata[i] = ret;
> -	}
> -
> -	chip->prox_data = le16_to_cpup((const __le16 *)&chdata[0]);
> -	ret = chip->prox_data;
> +	ret = tsl2x7x_read_autoinc_regs(chip, TSL2X7X_PRX_LO, TSL2X7X_PRX_HI);
> +	if (ret < 0)
> +		goto prox_poll_err;
> +	chip->prox_data = ret;
>  
>  prox_poll_err:
>  	mutex_unlock(&chip->prox_mutex);

