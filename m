Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52682 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752475AbcL3SpW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Dec 2016 13:45:22 -0500
Subject: Re: [PATCHv4 3/8] Fix camel case issues
To: Scott Matheina <scott@matheina.com>, linux-kernel@vger.kernel.org
References: <1482696216-8013-1-git-send-email-scott@matheina.com>
 <1482696216-8013-4-git-send-email-scott@matheina.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <8d349688-4be7-01be-66b9-f2fdcbe301ce@kernel.org>
Date: Fri, 30 Dec 2016 18:45:19 +0000
MIME-Version: 1.0
In-Reply-To: <1482696216-8013-4-git-send-email-scott@matheina.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/12/16 19:56, Scott Matheina wrote:
> Cases of camel case were fixed by making variables lower case throughout
> the file.
> 
> Signed-off-by: Scott Matheina <scott@matheina.com>
So of these cases might arguably be worth doing, but extreme care is needed to ensure
that the code is not broken.

Also, you are modifiying userspace ABI here so another level of care is needed.
To approach this sort of change I would suggest an RFC for the proposed ABI
changes.

In this particular case the driver is so far from standard ABI that you would
likely get the response that it needs to conform to standard ABI rather than
fixing it's own random choices of what sysfs files should be called.

Jonathan
> ---
>  drivers/staging/iio/addac/adt7316.c | 82 ++++++++++++++++++-------------------
>  1 file changed, 41 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> index 13d9ed2..2b584a0 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -1485,7 +1485,7 @@ static ssize_t adt7316_show_DAC_A(struct device *dev,
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
>  
> -	return adt7316_show_DAC(chip, 0, buf);
> +	return adt7316_show_dac(chip, 0, buf);
>  }
>  
>  static ssize_t adt7316_store_DAC_A(struct device *dev,
> @@ -1496,7 +1496,7 @@ static ssize_t adt7316_store_DAC_A(struct device *dev,
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
>  
> -	return adt7316_store_DAC(chip, 0, buf, len);
> +	return adt7316_store_dac(chip, 0, buf, len);
>  }
>  
>  static IIO_DEVICE_ATTR(DAC_A, S_IRUGO | S_IWUSR, adt7316_show_DAC_A,
> @@ -1509,7 +1509,7 @@ static ssize_t adt7316_show_DAC_B(struct device *dev,
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
>  
> -	return adt7316_show_DAC(chip, 1, buf);
> +	return adt7316_show_dac(chip, 1, buf);
>  }
>  
>  static ssize_t adt7316_store_DAC_B(struct device *dev,
> @@ -1520,7 +1520,7 @@ static ssize_t adt7316_store_DAC_B(struct device *dev,
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
>  
> -	return adt7316_store_DAC(chip, 1, buf, len);
> +	return adt7316_store_dac(chip, 1, buf, len);
>  }
>  
>  static IIO_DEVICE_ATTR(DAC_B, S_IRUGO | S_IWUSR, adt7316_show_DAC_B,
> @@ -1533,7 +1533,7 @@ static ssize_t adt7316_show_DAC_C(struct device *dev,
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
>  
> -	return adt7316_show_DAC(chip, 2, buf);
> +	return adt7316_show_dac(chip, 2, buf);
>  }
>  
>  static ssize_t adt7316_store_DAC_C(struct device *dev,
> @@ -1544,7 +1544,7 @@ static ssize_t adt7316_store_DAC_C(struct device *dev,
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
>  
> -	return adt7316_store_DAC(chip, 2, buf, len);
> +	return adt7316_store_dac(chip, 2, buf, len);
>  }
>  
>  static IIO_DEVICE_ATTR(DAC_C, S_IRUGO | S_IWUSR, adt7316_show_DAC_C,
> @@ -1557,7 +1557,7 @@ static ssize_t adt7316_show_DAC_D(struct device *dev,
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
>  
> -	return adt7316_show_DAC(chip, 3, buf);
> +	return adt7316_show_dac(chip, 3, buf);
>  }
>  
>  static ssize_t adt7316_store_DAC_D(struct device *dev,
> @@ -1568,7 +1568,7 @@ static ssize_t adt7316_store_DAC_D(struct device *dev,
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
>  
> -	return adt7316_store_DAC(chip, 3, buf, len);
> +	return adt7316_store_dac(chip, 3, buf, len);
>  }
>  
>  static IIO_DEVICE_ATTR(DAC_D, S_IRUGO | S_IWUSR, adt7316_show_DAC_D,
> @@ -1661,26 +1661,26 @@ static struct attribute *adt7316_attributes[] = {
>  	&iio_dev_attr_powerdown.dev_attr.attr,
>  	&iio_dev_attr_fast_ad_clock.dev_attr.attr,
>  	&iio_dev_attr_da_high_resolution.dev_attr.attr,
> -	&iio_dev_attr_enable_proportion_DACA.dev_attr.attr,
> -	&iio_dev_attr_enable_proportion_DACB.dev_attr.attr,
> -	&iio_dev_attr_DAC_2Vref_channels_mask.dev_attr.attr,
> -	&iio_dev_attr_DAC_update_mode.dev_attr.attr,
> -	&iio_dev_attr_all_DAC_update_modes.dev_attr.attr,
> -	&iio_dev_attr_update_DAC.dev_attr.attr,
> -	&iio_dev_attr_DA_AB_Vref_bypass.dev_attr.attr,
> -	&iio_dev_attr_DA_CD_Vref_bypass.dev_attr.attr,
> -	&iio_dev_attr_DAC_internal_Vref.dev_attr.attr,
> -	&iio_dev_attr_VDD.dev_attr.attr,
> +	&iio_dev_attr_enable_proportion_daca.dev_attr.attr,
> +	&iio_dev_attr_enable_proportion_dacb.dev_attr.attr,
> +	&iio_dev_attr_dac_2vref_channels_mask.dev_attr.attr,
> +	&iio_dev_attr_dac_internal_vref.dev_attr.attr,
> +	&iio_dev_attr_all_dac_update_modes.dev_attr.attr,
> +	&iio_dev_attr_update_dac.dev_attr.attr,
> +	&iio_dev_attr_da_ab_vref_bypass.dev_attr.attr,
> +	&iio_dev_attr_da_cd_vref_bypass.dev_attr.attr,
> +	&iio_dev_attr_dac_internal_vref.dev_attr.attr,
> +	&iio_dev_attr_vdd.dev_attr.attr,
>  	&iio_dev_attr_in_temp.dev_attr.attr,
>  	&iio_dev_attr_ex_temp.dev_attr.attr,
>  	&iio_dev_attr_in_temp_offset.dev_attr.attr,
>  	&iio_dev_attr_ex_temp_offset.dev_attr.attr,
>  	&iio_dev_attr_in_analog_temp_offset.dev_attr.attr,
>  	&iio_dev_attr_ex_analog_temp_offset.dev_attr.attr,
> -	&iio_dev_attr_DAC_A.dev_attr.attr,
> -	&iio_dev_attr_DAC_B.dev_attr.attr,
> -	&iio_dev_attr_DAC_C.dev_attr.attr,
> -	&iio_dev_attr_DAC_D.dev_attr.attr,
> +	&iio_dev_attr_dac_a.dev_attr.attr,
> +	&iio_dev_attr_dac_b.dev_attr.attr,
> +	&iio_dev_attr_dac_c.dev_attr.attr,
> +	&iio_dev_attr_dac_d.dev_attr.attr,
>  	&iio_dev_attr_device_id.dev_attr.attr,
>  	&iio_dev_attr_manufactorer_id.dev_attr.attr,
>  	&iio_dev_attr_device_rev.dev_attr.attr,
> @@ -1703,31 +1703,31 @@ static struct attribute *adt7516_attributes[] = {
>  	&iio_dev_attr_enable_smbus_timeout.dev_attr.attr,
>  	&iio_dev_attr_powerdown.dev_attr.attr,
>  	&iio_dev_attr_fast_ad_clock.dev_attr.attr,
> -	&iio_dev_attr_AIN_internal_Vref.dev_attr.attr,
> +	&iio_dev_attr_ain_internal_vref.dev_attr.attr,
>  	&iio_dev_attr_da_high_resolution.dev_attr.attr,
> -	&iio_dev_attr_enable_proportion_DACA.dev_attr.attr,
> -	&iio_dev_attr_enable_proportion_DACB.dev_attr.attr,
> -	&iio_dev_attr_DAC_2Vref_channels_mask.dev_attr.attr,
> -	&iio_dev_attr_DAC_update_mode.dev_attr.attr,
> -	&iio_dev_attr_all_DAC_update_modes.dev_attr.attr,
> -	&iio_dev_attr_update_DAC.dev_attr.attr,
> -	&iio_dev_attr_DA_AB_Vref_bypass.dev_attr.attr,
> -	&iio_dev_attr_DA_CD_Vref_bypass.dev_attr.attr,
> -	&iio_dev_attr_DAC_internal_Vref.dev_attr.attr,
> -	&iio_dev_attr_VDD.dev_attr.attr,
> +	&iio_dev_attr_enable_proportion_daca.dev_attr.attr,
> +	&iio_dev_attr_enable_proportion_dacb.dev_attr.attr,
> +	&iio_dev_attr_dac_2vref_channels_mask.dev_attr.attr,
> +	&iio_dev_attr_dac_update_mode.dev_attr.attr,
> +	&iio_dev_attr_all_dac_update_modes.dev_attr.attr,
> +	&iio_dev_attr_update_dac.dev_attr.attr,
> +	&iio_dev_attr_da_ab_vref_bypass.dev_attr.attr,
> +	&iio_dev_attr_da_cd_vref_bypass.dev_attr.attr,
> +	&iio_dev_attr_dac_internal_vref.dev_attr.attr,
> +	&iio_dev_attr_vdd.dev_attr.attr,
>  	&iio_dev_attr_in_temp.dev_attr.attr,
> -	&iio_dev_attr_ex_temp_AIN1.dev_attr.attr,
> -	&iio_dev_attr_AIN2.dev_attr.attr,
> -	&iio_dev_attr_AIN3.dev_attr.attr,
> -	&iio_dev_attr_AIN4.dev_attr.attr,
> +	&iio_dev_attr_ex_temp_ain1.dev_attr.attr,
> +	&iio_dev_attr_ain2.dev_attr.attr,
> +	&iio_dev_attr_ain3.dev_attr.attr,
> +	&iio_dev_attr_ain4.dev_attr.attr,
>  	&iio_dev_attr_in_temp_offset.dev_attr.attr,
>  	&iio_dev_attr_ex_temp_offset.dev_attr.attr,
>  	&iio_dev_attr_in_analog_temp_offset.dev_attr.attr,
>  	&iio_dev_attr_ex_analog_temp_offset.dev_attr.attr,
> -	&iio_dev_attr_DAC_A.dev_attr.attr,
> -	&iio_dev_attr_DAC_B.dev_attr.attr,
> -	&iio_dev_attr_DAC_C.dev_attr.attr,
> -	&iio_dev_attr_DAC_D.dev_attr.attr,
> +	&iio_dev_attr_dac_a.dev_attr.attr,
> +	&iio_dev_attr_dac_b.dev_attr.attr,
> +	&iio_dev_attr_dac_c.dev_attr.attr,
> +	&iio_dev_attr_dac_d.dev_attr.attr,
>  	&iio_dev_attr_device_id.dev_attr.attr,
>  	&iio_dev_attr_manufactorer_id.dev_attr.attr,
>  	&iio_dev_attr_device_rev.dev_attr.attr,
> 

