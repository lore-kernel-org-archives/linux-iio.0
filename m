Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43068 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080AbbDZTqI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 26 Apr 2015 15:46:08 -0400
Message-ID: <553D407D.5030904@kernel.org>
Date: Sun, 26 Apr 2015 20:46:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	linux-iio@vger.kernel.org
CC: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	daniel.baluta@intel.com
Subject: Re: [PATCH v2 1/3] staging: iio: light: isl29018: Remove non-standard
 sysfs attributes
References: <1429212059-13010-1-git-send-email-roberta.dobrescu@gmail.com> <1429212059-13010-2-git-send-email-roberta.dobrescu@gmail.com>
In-Reply-To: <1429212059-13010-2-git-send-email-roberta.dobrescu@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/04/15 20:20, Roberta Dobrescu wrote:
> This patch removes non-standard sysfs attributes range, range_available,
> adc_resolution and adc_resolution_available. It also removes the
> corresponding show and store functions.
> 
> This is in preparation for using standard IIO attributes in order to move
> the code out of staging.
> 
> Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
Applied to the togreg branch of iio.git.  Initially pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/light/isl29018.c | 94 ------------------------------------
>  1 file changed, 94 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
> index a348918..d3d0611 100644
> --- a/drivers/staging/iio/light/isl29018.c
> +++ b/drivers/staging/iio/light/isl29018.c
> @@ -230,87 +230,6 @@ static int isl29018_read_proximity_ir(struct isl29018_chip *chip, int scheme,
>  }
>  
>  /* Sysfs interface */
> -/* range */
> -static ssize_t show_range(struct device *dev,
> -			struct device_attribute *attr, char *buf)
> -{
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct isl29018_chip *chip = iio_priv(indio_dev);
> -
> -	return sprintf(buf, "%u\n", chip->range);
> -}
> -
> -static ssize_t store_range(struct device *dev,
> -		struct device_attribute *attr, const char *buf, size_t count)
> -{
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct isl29018_chip *chip = iio_priv(indio_dev);
> -	int status;
> -	unsigned long lval;
> -	unsigned int new_range;
> -
> -	if (kstrtoul(buf, 10, &lval))
> -		return -EINVAL;
> -
> -	if (!(lval == 1000UL || lval == 4000UL ||
> -			lval == 16000UL || lval == 64000UL)) {
> -		dev_err(dev, "The range is not supported\n");
> -		return -EINVAL;
> -	}
> -
> -	mutex_lock(&chip->lock);
> -	status = isl29018_set_range(chip, lval, &new_range);
> -	if (status < 0) {
> -		mutex_unlock(&chip->lock);
> -		dev_err(dev,
> -			"Error in setting max range with err %d\n", status);
> -		return status;
> -	}
> -	chip->range = new_range;
> -	mutex_unlock(&chip->lock);
> -
> -	return count;
> -}
> -
> -/* resolution */
> -static ssize_t show_resolution(struct device *dev,
> -			struct device_attribute *attr, char *buf)
> -{
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct isl29018_chip *chip = iio_priv(indio_dev);
> -
> -	return sprintf(buf, "%u\n", chip->adc_bit);
> -}
> -
> -static ssize_t store_resolution(struct device *dev,
> -		struct device_attribute *attr, const char *buf, size_t count)
> -{
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct isl29018_chip *chip = iio_priv(indio_dev);
> -	int status;
> -	unsigned int val;
> -	unsigned int new_adc_bit;
> -
> -	if (kstrtouint(buf, 10, &val))
> -		return -EINVAL;
> -	if (!(val == 4 || val == 8 || val == 12 || val == 16)) {
> -		dev_err(dev, "The resolution is not supported\n");
> -		return -EINVAL;
> -	}
> -
> -	mutex_lock(&chip->lock);
> -	status = isl29018_set_resolution(chip, val, &new_adc_bit);
> -	if (status < 0) {
> -		mutex_unlock(&chip->lock);
> -		dev_err(dev, "Error in setting resolution\n");
> -		return status;
> -	}
> -	chip->adc_bit = new_adc_bit;
> -	mutex_unlock(&chip->lock);
> -
> -	return count;
> -}
> -
>  /* proximity scheme */
>  static ssize_t show_prox_infrared_suppression(struct device *dev,
>  			struct device_attribute *attr, char *buf)
> @@ -447,11 +366,6 @@ static const struct iio_chan_spec isl29023_channels[] = {
>  	ISL29018_IR_CHANNEL,
>  };
>  
> -static IIO_DEVICE_ATTR(range, S_IRUGO | S_IWUSR, show_range, store_range, 0);
> -static IIO_CONST_ATTR(range_available, "1000 4000 16000 64000");
> -static IIO_CONST_ATTR(adc_resolution_available, "4 8 12 16");
> -static IIO_DEVICE_ATTR(adc_resolution, S_IRUGO | S_IWUSR,
> -					show_resolution, store_resolution, 0);
>  static IIO_DEVICE_ATTR(proximity_on_chip_ambient_infrared_suppression,
>  					S_IRUGO | S_IWUSR,
>  					show_prox_infrared_suppression,
> @@ -460,19 +374,11 @@ static IIO_DEVICE_ATTR(proximity_on_chip_ambient_infrared_suppression,
>  #define ISL29018_DEV_ATTR(name) (&iio_dev_attr_##name.dev_attr.attr)
>  #define ISL29018_CONST_ATTR(name) (&iio_const_attr_##name.dev_attr.attr)
>  static struct attribute *isl29018_attributes[] = {
> -	ISL29018_DEV_ATTR(range),
> -	ISL29018_CONST_ATTR(range_available),
> -	ISL29018_DEV_ATTR(adc_resolution),
> -	ISL29018_CONST_ATTR(adc_resolution_available),
>  	ISL29018_DEV_ATTR(proximity_on_chip_ambient_infrared_suppression),
>  	NULL
>  };
>  
>  static struct attribute *isl29023_attributes[] = {
> -	ISL29018_DEV_ATTR(range),
> -	ISL29018_CONST_ATTR(range_available),
> -	ISL29018_DEV_ATTR(adc_resolution),
> -	ISL29018_CONST_ATTR(adc_resolution_available),
>  	NULL
>  };
>  
> 

