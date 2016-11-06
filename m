Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55446 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751673AbcKFLfU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Nov 2016 06:35:20 -0500
Subject: Re: [PATCH 1/9] staging: iio: tsl2583: i2c_smbus_write_byte() /
 i2c_smbus_read_byte() migration
To: Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
References: <1478177780-28699-1-git-send-email-masneyb@onstation.org>
 <1478177780-28699-2-git-send-email-masneyb@onstation.org>
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com,
        Julia Lawall <julia.lawall@lip6.fr>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <1bbde6f6-7c35-e0c2-aeb6-49bd0a303fa5@kernel.org>
Date: Sun, 6 Nov 2016 11:35:18 +0000
MIME-Version: 1.0
In-Reply-To: <1478177780-28699-2-git-send-email-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/11/16 12:56, Brian Masney wrote:
> There were several places where the driver would first call
> i2c_smbus_write_byte() to select the register on the device, and then
> call i2c_smbus_read_byte() to get the contents of that register. The
> code would look roughly like:
> 
> /* Select register */
> i2c_smbus_write_byte(client, REGISTER);
> 
> /* Read the the last register that was written to */
> int data = i2c_smbus_read_byte(client);
> 
> Rewrite this to use i2c_smbus_read_byte_data() to combine the two
> calls into one:
> 
> int data = i2c_smbus_read_byte_data(chip->client, REGISTER);
> 
> Verified that the driver still functions correctly using a TSL2581
> hooked up to a Raspberry Pi 2.
> 
> This fixes the following warnings that were found by the
> kbuild test robot that were introduced by commit 8ba355cce3c6 ("staging:
> iio: tsl2583: check for error code from i2c_smbus_read_byte()").
> 
> drivers/staging/iio/light/tsl2583.c:365:5-12: WARNING: Unsigned
> expression compared with zero: reg_val < 0
> 
> drivers/staging/iio/light/tsl2583.c:388:5-12: WARNING: Unsigned
> expression compared with zero: reg_val < 0
> 
> This also removes the need for the taos_i2c_read() function since all
> callers were only calling the function with a length of 1.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> Cc: Julia Lawall <julia.lawall@lip6.fr>
Forgot to say - applied to the togreg branch of iio.git and pushed
out as testing to see what we've missed!

Jonathan
> ---
>  drivers/staging/iio/light/tsl2583.c | 85 +++++++------------------------------
>  1 file changed, 16 insertions(+), 69 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
> index 49b19f5..a3a9095 100644
> --- a/drivers/staging/iio/light/tsl2583.c
> +++ b/drivers/staging/iio/light/tsl2583.c
> @@ -155,39 +155,6 @@ static void taos_defaults(struct tsl2583_chip *chip)
>  }
>  
>  /*
> - * Read a number of bytes starting at register (reg) location.
> - * Return 0, or i2c_smbus_write_byte ERROR code.
> - */
> -static int
> -taos_i2c_read(struct i2c_client *client, u8 reg, u8 *val, unsigned int len)
> -{
> -	int i, ret;
> -
> -	for (i = 0; i < len; i++) {
> -		/* select register to write */
> -		ret = i2c_smbus_write_byte(client, (TSL258X_CMD_REG | reg));
> -		if (ret < 0) {
> -			dev_err(&client->dev,
> -				"taos_i2c_read failed to write register %x\n",
> -				reg);
> -			return ret;
> -		}
> -		/* read the data */
> -		ret = i2c_smbus_read_byte(client);
> -		if (ret < 0) {
> -			dev_err(&client->dev,
> -				"%s failed to read byte after writing to register %x\n",
> -				__func__, reg);
> -			return ret;
> -		}
> -		*val = ret;
> -		val++;
> -		reg++;
> -	}
> -	return 0;
> -}
> -
> -/*
>   * Reads and calculates current lux value.
>   * The raw ch0 and ch1 values of the ambient light sensed in the last
>   * integration cycle are read from the device.
> @@ -220,13 +187,14 @@ static int taos_get_lux(struct iio_dev *indio_dev)
>  		goto done;
>  	}
>  
> -	ret = taos_i2c_read(chip->client, (TSL258X_CMD_REG), &buf[0], 1);
> +	ret = i2c_smbus_read_byte_data(chip->client, TSL258X_CMD_REG);
>  	if (ret < 0) {
>  		dev_err(&chip->client->dev, "taos_get_lux failed to read CMD_REG\n");
>  		goto done;
>  	}
> +
>  	/* is data new & valid */
> -	if (!(buf[0] & TSL258X_STA_ADC_INTR)) {
> +	if (!(ret & TSL258X_STA_ADC_INTR)) {
>  		dev_err(&chip->client->dev, "taos_get_lux data not valid\n");
>  		ret = chip->als_cur_info.lux; /* return LAST VALUE */
>  		goto done;
> @@ -235,13 +203,14 @@ static int taos_get_lux(struct iio_dev *indio_dev)
>  	for (i = 0; i < 4; i++) {
>  		int reg = TSL258X_CMD_REG | (TSL258X_ALS_CHAN0LO + i);
>  
> -		ret = taos_i2c_read(chip->client, reg, &buf[i], 1);
> +		ret = i2c_smbus_read_byte_data(chip->client, reg);
>  		if (ret < 0) {
>  			dev_err(&chip->client->dev,
>  				"taos_get_lux failed to read register %x\n",
>  				reg);
>  			goto done;
>  		}
> +		buf[i] = ret;
>  	}
>  
>  	/*
> @@ -343,52 +312,36 @@ static int taos_get_lux(struct iio_dev *indio_dev)
>  static int taos_als_calibrate(struct iio_dev *indio_dev)
>  {
>  	struct tsl2583_chip *chip = iio_priv(indio_dev);
> -	u8 reg_val;
>  	unsigned int gain_trim_val;
>  	int ret;
>  	int lux_val;
>  
> -	ret = i2c_smbus_write_byte(chip->client,
> -				   (TSL258X_CMD_REG | TSL258X_CNTRL));
> +	ret = i2c_smbus_read_byte_data(chip->client,
> +				       TSL258X_CMD_REG | TSL258X_CNTRL);
>  	if (ret < 0) {
>  		dev_err(&chip->client->dev,
> -			"taos_als_calibrate failed to reach the CNTRL register, ret=%d\n",
> -			ret);
> -		return ret;
> -	}
> -
> -	reg_val = i2c_smbus_read_byte(chip->client);
> -	if (reg_val < 0) {
> -		dev_err(&chip->client->dev,
> -			"%s failed to read after writing to the CNTRL register\n",
> +			"%s failed to read from the CNTRL register\n",
>  			__func__);
>  		return ret;
>  	}
>  
> -	if ((reg_val & (TSL258X_CNTL_ADC_ENBL | TSL258X_CNTL_PWR_ON))
> +	if ((ret & (TSL258X_CNTL_ADC_ENBL | TSL258X_CNTL_PWR_ON))
>  			!= (TSL258X_CNTL_ADC_ENBL | TSL258X_CNTL_PWR_ON)) {
>  		dev_err(&chip->client->dev,
>  			"taos_als_calibrate failed: device not powered on with ADC enabled\n");
>  		return -EINVAL;
>  	}
>  
> -	ret = i2c_smbus_write_byte(chip->client,
> -				   (TSL258X_CMD_REG | TSL258X_CNTRL));
> +	ret = i2c_smbus_read_byte_data(chip->client,
> +				       TSL258X_CMD_REG | TSL258X_CNTRL);
>  	if (ret < 0) {
>  		dev_err(&chip->client->dev,
> -			"taos_als_calibrate failed to reach the STATUS register, ret=%d\n",
> -			ret);
> -		return ret;
> -	}
> -	reg_val = i2c_smbus_read_byte(chip->client);
> -	if (reg_val < 0) {
> -		dev_err(&chip->client->dev,
> -			"%s failed to read after writing to the STATUS register\n",
> +			"%s failed to read from the CNTRL register\n",
>  			__func__);
>  		return ret;
>  	}
>  
> -	if ((reg_val & TSL258X_STA_ADC_VALID) != TSL258X_STA_ADC_VALID) {
> +	if ((ret & TSL258X_STA_ADC_VALID) != TSL258X_STA_ADC_VALID) {
>  		dev_err(&chip->client->dev,
>  			"taos_als_calibrate failed: STATUS - ADC not valid.\n");
>  		return -ENODATA;
> @@ -847,15 +800,9 @@ static int taos_probe(struct i2c_client *clientp,
>  	memcpy(chip->taos_config, taos_config, sizeof(chip->taos_config));
>  
>  	for (i = 0; i < TSL258X_MAX_DEVICE_REGS; i++) {
> -		ret = i2c_smbus_write_byte(clientp,
> -				(TSL258X_CMD_REG | (TSL258X_CNTRL + i)));
> -		if (ret < 0) {
> -			dev_err(&clientp->dev,
> -				"i2c_smbus_write_byte to cmd reg failed in taos_probe(), err = %d\n",
> -				ret);
> -			return ret;
> -		}
> -		ret = i2c_smbus_read_byte(clientp);
> +		ret = i2c_smbus_read_byte_data(clientp,
> +					       (TSL258X_CMD_REG |
> +						(TSL258X_CNTRL + i)));
>  		if (ret < 0) {
>  			dev_err(&clientp->dev,
>  				"i2c_smbus_read_byte from reg failed in taos_probe(), err = %d\n",
> 

