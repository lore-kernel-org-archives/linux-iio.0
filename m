Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58069 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753377AbdCOVlZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Mar 2017 17:41:25 -0400
Subject: Re: [PATCH 2/4] iio: accel: adxl345_core: Introduce set_mode, drdy &
 get_triple functions
To: Eva Rachel Retuya <eraretuya@gmail.com>, linux-iio@vger.kernel.org
References: <1489403497-27849-1-git-send-email-eraretuya@gmail.com>
 <1489403497-27849-3-git-send-email-eraretuya@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        dmitry.torokhov@gmail.com, michael.hennerich@analog.com,
        daniel.baluta@gmail.com, amsfield22@gmail.com,
        florian.vaussard@heig-vd.ch, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <2ec21062-9623-88a3-ba75-73122597fab9@kernel.org>
Date: Wed, 15 Mar 2017 21:41:22 +0000
MIME-Version: 1.0
In-Reply-To: <1489403497-27849-3-git-send-email-eraretuya@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/03/17 11:11, Eva Rachel Retuya wrote:
> Move code that enables measurement/standby mode into its own function
> and call that function when appropriate. Previously, we set the sensor
> to measurement in probe and back to standby during remove. Change it
> here to only enter measurement mode when request for data is initiated.
> 
> The DATA_READY bit is always set if the corresponding event occurs.
> Introduce the drdy function that monitors the INT_SOURCE register of
> this bit. This is done to ensure consistent readings.
> 
> Make use of drdy in read_raw and also refactor the read to perform an
> all-axes read instead through get_triple. This function will come in
> handy when buffered reading is introduced.
> 
> Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
A few bits from me to add to Andy's review.
> ---
>  drivers/iio/accel/adxl345_core.c | 116 +++++++++++++++++++++++++++++----------
>  1 file changed, 88 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index 9ccb582..7eee31d 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -8,6 +8,7 @@
>   * directory of this archive for more details.
>   */
>  
> +#include <linux/delay.h>
>  #include <linux/module.h>
>  #include <linux/regmap.h>
>  
> @@ -17,6 +18,7 @@
>  
>  #define ADXL345_REG_DEVID		0x00
>  #define ADXL345_REG_POWER_CTL		0x2D
> +#define ADXL345_REG_INT_SOURCE		0x30
>  #define ADXL345_REG_DATA_FORMAT		0x31
>  #define ADXL345_REG_DATAX0		0x32
>  #define ADXL345_REG_DATAY0		0x34
> @@ -25,6 +27,10 @@
>  #define ADXL345_POWER_CTL_MEASURE	BIT(3)
>  #define ADXL345_POWER_CTL_STANDBY	0x00
>  
> +/* INT_ENABLE/INT_MAP/INT_SOURCE bits */
> +#define ADXL345_INT_DATA_READY		BIT(7)
> +#define ADXL345_INT_OVERRUN		0
> +
>  #define ADXL345_DATA_FORMAT_FULL_RES	BIT(3) /* Up to 13-bits resolution */
>  #define ADXL345_DATA_FORMAT_2G		0
>  #define ADXL345_DATA_FORMAT_4G		1
> @@ -47,6 +53,58 @@ struct adxl345_data {
>  	u8 data_range;
>  };
>  
> +static int adxl345_set_mode(struct adxl345_data *data, u8 mode)
> +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int ret;
> +
> +	ret = regmap_write(data->regmap, ADXL345_REG_POWER_CTL, mode);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to set power mode, %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int adxl345_get_triple(struct adxl345_data *data, void *buf)
> +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int ret;
> +
> +	ret = regmap_bulk_read(data->regmap, ADXL345_REG_DATAX0, buf,
> +			       sizeof(__le16) * 3);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to read the data registers, %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int adxl345_drdy(struct adxl345_data *data)
> +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int tries = 5;
> +	u32 regval;
> +	int ret;
> +
> +	while (tries--) {
> +		ret = regmap_read(data->regmap, ADXL345_REG_INT_SOURCE,
> +				  &regval);
> +		if (ret < 0)
> +			return ret;
> +		if ((regval & ADXL345_INT_DATA_READY) ==
> +		    ADXL345_INT_DATA_READY)
> +			return 0;
> +
> +		msleep(20);
> +	}
> +	dev_err(dev, "Data is not yet ready\n");
> +
Hmm. Does it definitely indicate a hardware failure?  If so fair enough with
EIO. However, the message should perhaps say this.  Sounds like an EBUSY
from that error message.
> +	return -EIO;
> +}
> +
>  #define ADXL345_CHANNEL(reg, axis) {					\
>  	.type = IIO_ACCEL,						\
>  	.modified = 1,							\
> @@ -67,22 +125,37 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
>  			    int *val, int *val2, long mask)
>  {
>  	struct adxl345_data *data = iio_priv(indio_dev);
> -	__le16 regval;
> +	s16 regval[3];
>  	int ret;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		/*
> -		 * Data is stored in adjacent registers:
> -		 * ADXL345_REG_DATA(X0/Y0/Z0) contain the least significant byte
> -		 * and ADXL345_REG_DATA(X0/Y0/Z0) + 1 the most significant byte
> -		 */
> -		ret = regmap_bulk_read(data->regmap, chan->address, &regval,
> -				       sizeof(regval));
> +		ret = adxl345_set_mode(data, ADXL345_POWER_CTL_MEASURE);
> +		if (ret < 0)
> +			return ret;
> +		ret = adxl345_drdy(data);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = adxl345_get_triple(data, &regval);
>  		if (ret < 0)
>  			return ret;
>  
> -		*val = sign_extend32(le16_to_cpu(regval), 12);
This function should as Andy pointed out still be returning in
cpu endianness.  So you can't just drop it like this.
> +		switch (chan->address) {
> +		case ADXL345_REG_DATAX0:
> +			*val = regval[0];
> +			break;
> +		case ADXL345_REG_DATAY0:
> +			*val = regval[1];
> +			break;
> +		case ADXL345_REG_DATAZ0:
> +			*val = regval[2];
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		adxl345_set_mode(data, ADXL345_POWER_CTL_STANDBY);
> +
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
>  		*val = 0;
> @@ -126,9 +199,12 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  	data = iio_priv(indio_dev);
>  	dev_set_drvdata(dev, indio_dev);
>  	data->regmap = regmap;
> +	/* Make sure sensor is in standby mode before configuring registers */
> +	ret = adxl345_set_mode(data, ADXL345_POWER_CTL_STANDBY);
> +	if (ret < 0)
> +		return ret;
Is this one specific to the buffered support?  If not, please break it out
as a precursor patch.
>  	/* Enable full-resolution mode */
>  	data->data_range = ADXL345_DATA_FORMAT_FULL_RES;
Should be seeing random white space changes in a patch doing other things.
> -
>  	ret = regmap_write(data->regmap, ADXL345_REG_DATA_FORMAT,
>  			   data->data_range);
>  	if (ret < 0) {
> @@ -143,22 +219,7 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  	indio_dev->channels = adxl345_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(adxl345_channels);
>  
> -	/* Enable measurement mode */
> -	ret = regmap_write(data->regmap, ADXL345_REG_POWER_CTL,
> -			   ADXL345_POWER_CTL_MEASURE);
> -	if (ret < 0) {
> -		dev_err(dev, "Failed to enable measurement mode: %d\n", ret);
> -		return ret;
> -	}
> -
> -	ret = iio_device_register(indio_dev);
> -	if (ret < 0) {
> -		dev_err(dev, "iio_device_register failed: %d\n", ret);
> -		regmap_write(data->regmap, ADXL345_REG_POWER_CTL,
> -			     ADXL345_POWER_CTL_STANDBY);
> -	}
> -
> -	return ret;
> +	return iio_device_register(indio_dev);
>  }
>  EXPORT_SYMBOL_GPL(adxl345_core_probe);
>  
> @@ -169,8 +230,7 @@ int adxl345_core_remove(struct device *dev)
>  
>  	iio_device_unregister(indio_dev);
>  
> -	return regmap_write(data->regmap, ADXL345_REG_POWER_CTL,
> -			    ADXL345_POWER_CTL_STANDBY);
> +	return adxl345_set_mode(data, ADXL345_POWER_CTL_STANDBY);
>  }
>  EXPORT_SYMBOL_GPL(adxl345_core_remove);
>  
> 

