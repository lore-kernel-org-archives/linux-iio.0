Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43554 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753299AbcJ3Sho (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Oct 2016 14:37:44 -0400
Subject: Re: [PATCH 07/10] staging: iio: tsl2583: convert
 illuminance0_calibscale sysfs attr to use iio_chan_spec
To: Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
References: <1477648821-3786-1-git-send-email-masneyb@onstation.org>
 <1477648821-3786-8-git-send-email-masneyb@onstation.org>
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, Mark.Rutland@arm.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <a0fc532f-f034-d817-00f6-a28ec60daf6a@kernel.org>
Date: Sun, 30 Oct 2016 18:37:40 +0000
MIME-Version: 1.0
In-Reply-To: <1477648821-3786-8-git-send-email-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/10/16 11:00, Brian Masney wrote:
> The illuminance0_calibscale sysfs attribute is not currently created by
> the IIO core. This patch adds the appropriate mask to iio_chan_spec,
> along with the appropriate data handling in the read_raw() and
> write_raw() functions, so that the sysfs attribute is created by the IIO
> core. With this change, this sysfs entry will have its prefix changed
> from illuminance0_ to in_illuminance_.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Hmm. Could probably have computed the mean on the fly but fine as is.

Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/light/tsl2583.c | 89 +++++++++++--------------------------
>  1 file changed, 25 insertions(+), 64 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
> index 6a61a86..bfff6ca 100644
> --- a/drivers/staging/iio/light/tsl2583.c
> +++ b/drivers/staging/iio/light/tsl2583.c
> @@ -124,14 +124,15 @@ static struct taos_lux taos_device_lux[11] = {
>  struct gainadj {
>  	s16 ch0;
>  	s16 ch1;
> +	s16 mean;
>  };
>  
>  /* Index = (0 - 3) Used to validate the gain selection index */
>  static const struct gainadj gainadj[] = {
> -	{ 1, 1 },
> -	{ 8, 8 },
> -	{ 16, 16 },
> -	{ 107, 115 }
> +	{ 1, 1, 1 },
> +	{ 8, 8, 8 },
> +	{ 16, 16, 16 },
> +	{ 107, 115, 111 }
>  };
>  
>  /*
> @@ -505,63 +506,6 @@ static int taos_chip_off(struct iio_dev *indio_dev)
>  
>  /* Sysfs Interface Functions */
>  
> -static ssize_t taos_gain_show(struct device *dev,
> -			      struct device_attribute *attr, char *buf)
> -{
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct tsl2583_chip *chip = iio_priv(indio_dev);
> -	char gain[4] = {0};
> -
> -	switch (chip->taos_settings.als_gain) {
> -	case 0:
> -		strcpy(gain, "001");
> -		break;
> -	case 1:
> -		strcpy(gain, "008");
> -		break;
> -	case 2:
> -		strcpy(gain, "016");
> -		break;
> -	case 3:
> -		strcpy(gain, "111");
> -		break;
> -	}
> -
> -	return sprintf(buf, "%s\n", gain);
> -}
> -
> -static ssize_t taos_gain_store(struct device *dev,
> -			       struct device_attribute *attr,
> -			       const char *buf, size_t len)
> -{
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct tsl2583_chip *chip = iio_priv(indio_dev);
> -	int value;
> -
> -	if (kstrtoint(buf, 0, &value))
> -		return -EINVAL;
> -
> -	switch (value) {
> -	case 1:
> -		chip->taos_settings.als_gain = 0;
> -		break;
> -	case 8:
> -		chip->taos_settings.als_gain = 1;
> -		break;
> -	case 16:
> -		chip->taos_settings.als_gain = 2;
> -		break;
> -	case 111:
> -		chip->taos_settings.als_gain = 3;
> -		break;
> -	default:
> -		dev_err(dev, "Invalid Gain Index (must be 1,8,16,111)\n");
> -		return -1;
> -	}
> -
> -	return len;
> -}
> -
>  static ssize_t taos_gain_available_show(struct device *dev,
>  					struct device_attribute *attr,
>  					char *buf)
> @@ -691,8 +635,6 @@ static ssize_t taos_luxtable_store(struct device *dev,
>  	return ret;
>  }
>  
> -static DEVICE_ATTR(illuminance0_calibscale, S_IRUGO | S_IWUSR,
> -		taos_gain_show, taos_gain_store);
>  static DEVICE_ATTR(illuminance0_calibscale_available, S_IRUGO,
>  		taos_gain_available_show, NULL);
>  
> @@ -707,7 +649,6 @@ static DEVICE_ATTR(illuminance0_lux_table, S_IRUGO | S_IWUSR,
>  		taos_luxtable_show, taos_luxtable_store);
>  
>  static struct attribute *sysfs_attrs_ctrl[] = {
> -	&dev_attr_illuminance0_calibscale.attr,			/* Gain  */
>  	&dev_attr_illuminance0_calibscale_available.attr,
>  	&dev_attr_illuminance0_integration_time_available.attr,
>  	&dev_attr_illuminance0_input_target.attr,
> @@ -743,6 +684,7 @@ static const struct iio_chan_spec tsl2583_channels[] = {
>  		.type = IIO_LIGHT,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
>  				      BIT(IIO_CHAN_INFO_CALIBBIAS) |
> +				      BIT(IIO_CHAN_INFO_CALIBSCALE) |
>  				      BIT(IIO_CHAN_INFO_INT_TIME),
>  	},
>  };
> @@ -801,6 +743,12 @@ static int tsl2583_read_raw(struct iio_dev *indio_dev,
>  			ret = IIO_VAL_INT;
>  		}
>  		break;
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		if (chan->type == IIO_LIGHT) {
> +			*val = gainadj[chip->taos_settings.als_gain].mean;
> +			ret = IIO_VAL_INT;
> +		}
> +		break;
>  	case IIO_CHAN_INFO_INT_TIME:
>  		if (chan->type == IIO_LIGHT) {
>  			*val = 0;
> @@ -839,6 +787,19 @@ static int tsl2583_write_raw(struct iio_dev *indio_dev,
>  			ret = 0;
>  		}
>  		break;
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		if (chan->type == IIO_LIGHT) {
> +			int i;
> +
> +			for (i = 0; i < ARRAY_SIZE(gainadj); i++) {
> +				if (gainadj[i].mean == val) {
> +					chip->taos_settings.als_gain = i;
> +					ret = 0;
> +					break;
> +				}
> +			}
> +		}
> +		break;
>  	case IIO_CHAN_INFO_INT_TIME:
>  		if (chan->type == IIO_LIGHT && !val && val2 >= 50 &&
>  		    val2 <= 650 && !(val2 % 50)) {
> 

