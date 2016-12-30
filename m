Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52751 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753988AbcL3Sxk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Dec 2016 13:53:40 -0500
Subject: Re: [PATCHv4 7/8] Changed code to align with coding style of using
 octat
To: Scott Matheina <scott@matheina.com>, linux-kernel@vger.kernel.org
References: <1482696216-8013-1-git-send-email-scott@matheina.com>
 <1482696216-8013-8-git-send-email-scott@matheina.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <685ace8e-9e6c-7c26-9f8a-9610957fa0c9@kernel.org>
Date: Fri, 30 Dec 2016 18:53:38 +0000
MIME-Version: 1.0
In-Reply-To: <1482696216-8013-8-git-send-email-scott@matheina.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/12/16 19:56, Scott Matheina wrote:
> The permmission code was changed to reflect octat (0644/0444) for required permissions.
> 
> Signed-off-by: Scott Matheina <scott@matheina.com>
The particularly comment from Linus that lead to this 'rule' coming in recently was
fair enough, but the rule creates a lot of churn.  I have been applying them when
then form part of a larger set, so fair enough having it in here.

However, the ABI in this driver is so broken, I'd rather this sort of change got
left until after that is fixed ideally.  Most of these elements you are fixing will
go away as part of fixing that up.

Jonathan
> ---
>  drivers/staging/iio/addac/adt7316.c | 264 ++++++++++++++----------------------
>  1 file changed, 101 insertions(+), 163 deletions(-)
> 
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> index 91ac222..e8e58d5 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -267,10 +267,8 @@ static ssize_t adt7316_store_enabled(struct device *dev,
>  	return len;
>  }
>  
> -static IIO_DEVICE_ATTR(enabled, S_IRUGO | S_IWUSR,
> -		adt7316_show_enabled,
> -		adt7316_store_enabled,
> -		0);
> +static iio_device_attr(enabled, 0644, adt7316_show_enabled,
> +		       adt7316_store_enabled, 0);
>  
>  static ssize_t adt7316_show_select_ex_temp(struct device *dev,
>  		struct device_attribute *attr,
> @@ -311,10 +309,8 @@ static ssize_t adt7316_store_select_ex_temp(struct device *dev,
>  	return len;
>  }
>  
> -static IIO_DEVICE_ATTR(select_ex_temp, S_IRUGO | S_IWUSR,
> -		adt7316_show_select_ex_temp,
> -		adt7316_store_select_ex_temp,
> -		0);
> +static iio_device_attr(select_ex_temp, 0644, adt7316_show_select_ex_temp,
> +		       adt7316_store_select_ex_temp, 0);
>  
>  static ssize_t adt7316_show_mode(struct device *dev,
>  				 struct device_attribute *attr,
> @@ -352,10 +348,7 @@ static ssize_t adt7316_store_mode(struct device *dev,
>  	return len;
>  }
>  
> -static IIO_DEVICE_ATTR(mode, S_IRUGO | S_IWUSR,
> -		adt7316_show_mode,
> -		adt7316_store_mode,
> -		0);
> +static iio_device_attr(mode, 0644, adt7316_show_mode, adt7316_store_mode, 0);
>  
>  static ssize_t adt7316_show_all_modes(struct device *dev,
>  				      struct device_attribute *attr,
> @@ -364,7 +357,7 @@ static ssize_t adt7316_show_all_modes(struct device *dev,
>  	return sprintf(buf, "single_channel\nround_robin\n");
>  }
>  
> -static IIO_DEVICE_ATTR(all_modes, S_IRUGO, adt7316_show_all_modes, NULL, 0);
> +static iio_device_attr(all_modes, 0444, adt7316_show_all_modes, NULL, 0);
>  
>  static ssize_t adt7316_show_ad_channel(struct device *dev,
>  				       struct device_attribute *attr,
> @@ -445,10 +438,8 @@ static ssize_t adt7316_store_ad_channel(struct device *dev,
>  	return len;
>  }
>  
> -static IIO_DEVICE_ATTR(ad_channel, S_IRUGO | S_IWUSR,
> -		adt7316_show_ad_channel,
> -		adt7316_store_ad_channel,
> -		0);
> +static iio_device_attr(ad_channel, 0644, adt7316_show_ad_channel,
> +		       adt7316_store_ad_channel, 0);
>  
>  static ssize_t adt7316_show_all_ad_channels(struct device *dev,
>  					    struct device_attribute *attr,
> @@ -468,8 +459,8 @@ static ssize_t adt7316_show_all_ad_channels(struct device *dev,
>  			"2 - External Temperature\n");
>  }
>  
> -static IIO_DEVICE_ATTR(all_ad_channels, S_IRUGO,
> -		adt7316_show_all_ad_channels, NULL, 0);
> +static iio_device_attr(all_ad_channels, 0444, adt7316_show_all_ad_channels,
> +		       NULL, 0);
>  
>  static ssize_t adt7316_show_disable_averaging(struct device *dev,
>  					      struct device_attribute *attr,
> @@ -505,10 +496,8 @@ static ssize_t adt7316_store_disable_averaging(struct device *dev,
>  	return len;
>  }
>  
> -static IIO_DEVICE_ATTR(disable_averaging, S_IRUGO | S_IWUSR,
> -		adt7316_show_disable_averaging,
> -		adt7316_store_disable_averaging,
> -		0);
> +static iio_device_attr(disable_averaging, 0644, adt7316_show_disable_averaging,
> +		       adt7316_store_disable_averaging, 0);
>  
>  static ssize_t adt7316_show_enable_smbus_timeout(struct device *dev,
>  						 struct device_attribute *attr,
> @@ -544,10 +533,9 @@ static ssize_t adt7316_store_enable_smbus_timeout(struct device *dev,
>  	return len;
>  }
>  
> -static IIO_DEVICE_ATTR(enable_smbus_timeout, S_IRUGO | S_IWUSR,
> -		adt7316_show_enable_smbus_timeout,
> -		adt7316_store_enable_smbus_timeout,
> -		0);
> +static iio_device_attr(enable_smbus_timeout, 0644,
> +		       adt7316_show_enable_smbus_timeout,
> +		       adt7316_store_enable_smbus_timeout, 0);
>  
>  static ssize_t adt7316_show_powerdown(struct device *dev,
>  				      struct device_attribute *attr,
> @@ -582,10 +570,8 @@ static ssize_t adt7316_store_powerdown(struct device *dev,
>  	return len;
>  }
>  
> -static IIO_DEVICE_ATTR(powerdown, S_IRUGO | S_IWUSR,
> -		adt7316_show_powerdown,
> -		adt7316_store_powerdown,
> -		0);
> +static iio_device_attr(powerdown, 0644, adt7316_show_powerdown,
> +		       adt7316_store_powerdown, 0);
>  
>  static ssize_t adt7316_show_fast_ad_clock(struct device *dev,
>  					  struct device_attribute *attr,
> @@ -620,10 +606,8 @@ static ssize_t adt7316_store_fast_ad_clock(struct device *dev,
>  	return len;
>  }
>  
> -static IIO_DEVICE_ATTR(fast_ad_clock, S_IRUGO | S_IWUSR,
> -		adt7316_show_fast_ad_clock,
> -		adt7316_store_fast_ad_clock,
> -		0);
> +static iio_device_attr(fast_ad_clock, 0644, adt7316_show_fast_ad_clock,
> +		       adt7316_store_fast_ad_clock, 0);
>  
>  static ssize_t adt7316_show_da_high_resolution(struct device *dev,
>  		struct device_attribute *attr,
> @@ -673,10 +657,9 @@ static ssize_t adt7316_store_da_high_resolution(struct device *dev,
>  	return len;
>  }
>  
> -static IIO_DEVICE_ATTR(da_high_resolution, S_IRUGO | S_IWUSR,
> -		adt7316_show_da_high_resolution,
> -		adt7316_store_da_high_resolution,
> -		0);
> +static iio_device_attr(da_high_resolution, 0644,
> +		       adt7316_show_da_high_resolution,
> +		       adt7316_store_da_high_resolution, 0);
>  
>  static ssize_t adt7316_show_AIN_internal_Vref(struct device *dev,
>  		struct device_attribute *attr,
> @@ -719,10 +702,9 @@ static ssize_t adt7316_store_AIN_internal_Vref(struct device *dev,
>  	return len;
>  }
>  
> -static IIO_DEVICE_ATTR(AIN_internal_Vref, S_IRUGO | S_IWUSR,
> -		adt7316_show_AIN_internal_Vref,
> -		adt7316_store_AIN_internal_Vref,
> -		0);
> +static iio_device_attr(ain_internal_vref, 0644,
> +		       adt7316_show_ain_internal_vref,
> +		       adt7316_store_ain_internal_vref, 0);
>  
>  
>  static ssize_t adt7316_show_enable_prop_DACA(struct device *dev,
> @@ -759,10 +741,9 @@ static ssize_t adt7316_store_enable_prop_DACA(struct device *dev,
>  	return len;
>  }
>  
> -static IIO_DEVICE_ATTR(enable_proportion_DACA, S_IRUGO | S_IWUSR,
> -		adt7316_show_enable_prop_DACA,
> -		adt7316_store_enable_prop_DACA,
> -		0);
> +static iio_device_attr(enable_proportion_daca, 0644,
> +		       adt7316_show_enable_prop_daca,
> +		       adt7316_store_enable_prop_daca, 0);
>  
>  static ssize_t adt7316_show_enable_prop_DACB(struct device *dev,
>  		struct device_attribute *attr,
> @@ -798,10 +779,9 @@ static ssize_t adt7316_store_enable_prop_DACB(struct device *dev,
>  	return len;
>  }
>  
> -static IIO_DEVICE_ATTR(enable_proportion_DACB, S_IRUGO | S_IWUSR,
> -		adt7316_show_enable_prop_DACB,
> -		adt7316_store_enable_prop_DACB,
> -		0);
> +static iio_device_attr(enable_proportion_dacb, 0644,
> +		       adt7316_show_enable_prop_dacb,
> +		       adt7316_store_enable_prop_dacb, 0);
>  
>  static ssize_t adt7316_show_DAC_2Vref_ch_mask(struct device *dev,
>  		struct device_attribute *attr,
> @@ -841,10 +821,9 @@ static ssize_t adt7316_store_DAC_2Vref_ch_mask(struct device *dev,
>  	return len;
>  }
>  
> -static IIO_DEVICE_ATTR(DAC_2Vref_channels_mask, S_IRUGO | S_IWUSR,
> -		adt7316_show_DAC_2Vref_ch_mask,
> -		adt7316_store_DAC_2Vref_ch_mask,
> -		0);
> +static iio_device_attr(dac_2vref_channels_mask, 0644,
> +		       adt7316_show_dac_2vref_ch_mask,
> +		       adt7316_store_dac_2vref_ch_mask, 0);
>  
>  static ssize_t adt7316_show_DAC_update_mode(struct device *dev,
>  		struct device_attribute *attr,
> @@ -901,10 +880,8 @@ static ssize_t adt7316_store_DAC_update_mode(struct device *dev,
>  	return len;
>  }
>  
> -static IIO_DEVICE_ATTR(DAC_update_mode, S_IRUGO | S_IWUSR,
> -		adt7316_show_DAC_update_mode,
> -		adt7316_store_DAC_update_mode,
> -		0);
> +static iio_device_attr(DAC_update_mode, 0644, adt7316_show_dac_update_mode,
> +		       adt7316_store_dac_update_mode, 0);
>  
>  static ssize_t adt7316_show_all_DAC_update_modes(struct device *dev,
>  		struct device_attribute *attr,
> @@ -921,9 +898,8 @@ static ssize_t adt7316_show_all_DAC_update_modes(struct device *dev,
>  	return sprintf(buf, "manual\n");
>  }
>  
> -static IIO_DEVICE_ATTR(all_DAC_update_modes, S_IRUGO,
> -		adt7316_show_all_DAC_update_modes, NULL, 0);
> -
> +static iio_device_attr(all_dac_update_modes, 0444,
> +		       adt7316_show_all_dac_update_modes, NULL, 0);
>  
>  static ssize_t adt7316_store_update_DAC(struct device *dev,
>  		struct device_attribute *attr,
> @@ -960,10 +936,7 @@ static ssize_t adt7316_store_update_DAC(struct device *dev,
>  	return len;
>  }
>  
> -static IIO_DEVICE_ATTR(update_DAC, S_IRUGO | S_IWUSR,
> -		NULL,
> -		adt7316_store_update_DAC,
> -		0);
> +static iio_device_attr(update_dac, 0644, NULL, adt7316_store_update_dac, 0);
>  
>  static ssize_t adt7316_show_DA_AB_Vref_bypass(struct device *dev,
>  		struct device_attribute *attr,
> @@ -1005,10 +978,8 @@ static ssize_t adt7316_store_DA_AB_Vref_bypass(struct device *dev,
>  	return len;
>  }
>  
> -static IIO_DEVICE_ATTR(DA_AB_Vref_bypass, S_IRUGO | S_IWUSR,
> -		adt7316_show_DA_AB_Vref_bypass,
> -		adt7316_store_DA_AB_Vref_bypass,
> -		0);
> +static iio_device_attr(da_ab_vref_bypass, 0644, adt7316_show_da_ab_vref_bypass,
> +		       adt7316_store_da_ab_vref_bypass, 0);
>  
>  static ssize_t adt7316_show_DA_CD_Vref_bypass(struct device *dev,
>  		struct device_attribute *attr,
> @@ -1050,10 +1021,8 @@ static ssize_t adt7316_store_DA_CD_Vref_bypass(struct device *dev,
>  	return len;
>  }
>  
> -static IIO_DEVICE_ATTR(DA_CD_Vref_bypass, S_IRUGO | S_IWUSR,
> -		adt7316_show_DA_CD_Vref_bypass,
> -		adt7316_store_DA_CD_Vref_bypass,
> -		0);
> +static iio_device_attr(da_cd_vref_bypass, 0644, adt7316_show_da_cd_vref_bypass,
> +		       adt7316_store_da_cd_vref_bypass, 0);
>  
>  static ssize_t adt7316_show_DAC_internal_Vref(struct device *dev,
>  		struct device_attribute *attr,
> @@ -1111,10 +1080,8 @@ static ssize_t adt7316_store_DAC_internal_Vref(struct device *dev,
>  	return len;
>  }
>  
> -static IIO_DEVICE_ATTR(DAC_internal_Vref, S_IRUGO | S_IWUSR,
> -		adt7316_show_DAC_internal_Vref,
> -		adt7316_store_DAC_internal_Vref,
> -		0);
> +static iio_device_attr(dac_internal_vref, 0644, adt7316_show_dac_internal_vref,
> +		       adt7316_store_dac_internal_vref, 0);
>  
>  static ssize_t adt7316_show_ad(struct adt7316_chip_info *chip,
>  		int channel, char *buf)
> @@ -1200,7 +1167,8 @@ static ssize_t adt7316_show_VDD(struct device *dev,
>  
>  	return adt7316_show_ad(chip, ADT7316_AD_SINGLE_CH_VDD, buf);
>  }
> -static IIO_DEVICE_ATTR(VDD, S_IRUGO, adt7316_show_VDD, NULL, 0);
> +
> +static iio_device_attr(VDD, 0444, adt7316_show_VDD, NULL, 0);
>  
>  static ssize_t adt7316_show_in_temp(struct device *dev,
>  		struct device_attribute *attr,
> @@ -1212,7 +1180,7 @@ static ssize_t adt7316_show_in_temp(struct device *dev,
>  	return adt7316_show_ad(chip, ADT7316_AD_SINGLE_CH_IN, buf);
>  }
>  
> -static IIO_DEVICE_ATTR(in_temp, S_IRUGO, adt7316_show_in_temp, NULL, 0);
> +static iio_device_attr(in_temp, 0444, adt7316_show_in_temp, NULL, 0);
>  
>  static ssize_t adt7316_show_ex_temp_AIN1(struct device *dev,
>  		struct device_attribute *attr,
> @@ -1224,9 +1192,9 @@ static ssize_t adt7316_show_ex_temp_AIN1(struct device *dev,
>  	return adt7316_show_ad(chip, ADT7316_AD_SINGLE_CH_EX, buf);
>  }
>  
> -static IIO_DEVICE_ATTR(ex_temp_AIN1, S_IRUGO, adt7316_show_ex_temp_AIN1,
> -		NULL, 0);
> -static IIO_DEVICE_ATTR(ex_temp, S_IRUGO, adt7316_show_ex_temp_AIN1, NULL, 0);
> +static iio_device_attr(ex_temp_ain1, 0444, adt7316_show_ex_temp_ain1, NULL, 0);
> +
> +static iio_device_attr(ex_temp, 0444, adt7316_show_ex_temp_ain1, NULL, 0);
>  
>  static ssize_t adt7316_show_AIN2(struct device *dev,
>  		struct device_attribute *attr,
> @@ -1237,29 +1205,32 @@ static ssize_t adt7316_show_AIN2(struct device *dev,
>  
>  	return adt7316_show_ad(chip, ADT7516_AD_SINGLE_CH_AIN2, buf);
>  }
> -static IIO_DEVICE_ATTR(AIN2, S_IRUGO, adt7316_show_AIN2, NULL, 0);
>  
> -static ssize_t adt7316_show_AIN3(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +static iio_device_attr(ain2, 0444, adt7316_show_AIN2, NULL, 0);
> +
> +static ssize_t adt7316_show_ain3(struct device *dev,
> +				 struct device_attribute *attr,
> +				 char *buf)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
>  
>  	return adt7316_show_ad(chip, ADT7516_AD_SINGLE_CH_AIN3, buf);
>  }
> -static IIO_DEVICE_ATTR(AIN3, S_IRUGO, adt7316_show_AIN3, NULL, 0);
>  
> -static ssize_t adt7316_show_AIN4(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +static iio_device_attr(ain3, 0444, adt7316_show_ain3, NULL, 0);
> +
> +static ssize_t adt7316_show_ain4(struct device *dev,
> +				 struct device_attribute *attr,
> +				 char *buf)
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
>  
>  	return adt7316_show_ad(chip, ADT7516_AD_SINGLE_CH_AIN4, buf);
>  }
> -static IIO_DEVICE_ATTR(AIN4, S_IRUGO, adt7316_show_AIN4, NULL, 0);
> +
> +static iio_device_attr(ain4, 0444, adt7316_show_ain4, NULL, 0);
>  
>  static ssize_t adt7316_show_temp_offset(struct adt7316_chip_info *chip,
>  		int offset_addr, char *buf)
> @@ -1324,9 +1295,8 @@ static ssize_t adt7316_store_in_temp_offset(struct device *dev,
>  			len);
>  }
>  
> -static IIO_DEVICE_ATTR(in_temp_offset, S_IRUGO | S_IWUSR,
> -		adt7316_show_in_temp_offset,
> -		adt7316_store_in_temp_offset, 0);
> +static iio_device_attr(in_temp_offset, 0644, adt7316_show_in_temp_offset,
> +		       adt7316_store_in_temp_offset, 0);
>  
>  static ssize_t adt7316_show_ex_temp_offset(struct device *dev,
>  		struct device_attribute *attr,
> @@ -1404,7 +1374,7 @@ static ssize_t adt7316_store_ex_analog_temp_offset(struct device *dev,
>  			ADT7316_EX_ANALOG_TEMP_OFFSET, buf, len);
>  }
>  
> -static IIO_DEVICE_ATTR(ex_analog_temp_offset, S_IRUGO | S_IWUSR,
> +static iio_device_attr(ex_analog_temp_offset, 0644,
>  		adt7316_show_ex_analog_temp_offset,
>  		adt7316_store_ex_analog_temp_offset, 0);
>  
> @@ -1499,8 +1469,7 @@ static ssize_t adt7316_store_DAC_A(struct device *dev,
>  	return adt7316_store_dac(chip, 0, buf, len);
>  }
>  
> -static IIO_DEVICE_ATTR(DAC_A, S_IRUGO | S_IWUSR, adt7316_show_DAC_A,
> -		adt7316_store_DAC_A, 0);
> +static iio_device_attr(dac_a, 0644, adt7316_show_dac_a, adt7316_store_dac_a, 0);
>  
>  static ssize_t adt7316_show_DAC_B(struct device *dev,
>  		struct device_attribute *attr,
> @@ -1523,8 +1492,7 @@ static ssize_t adt7316_store_DAC_B(struct device *dev,
>  	return adt7316_store_dac(chip, 1, buf, len);
>  }
>  
> -static IIO_DEVICE_ATTR(DAC_B, S_IRUGO | S_IWUSR, adt7316_show_DAC_B,
> -		adt7316_store_DAC_B, 0);
> +static iio_device_attr(dac_b, 0644, adt7316_show_dac_b, adt7316_store_dac_b, 0);
>  
>  static ssize_t adt7316_show_DAC_C(struct device *dev,
>  		struct device_attribute *attr,
> @@ -1547,8 +1515,7 @@ static ssize_t adt7316_store_DAC_C(struct device *dev,
>  	return adt7316_store_dac(chip, 2, buf, len);
>  }
>  
> -static IIO_DEVICE_ATTR(DAC_C, S_IRUGO | S_IWUSR, adt7316_show_DAC_C,
> -		adt7316_store_DAC_C, 0);
> +static iio_device_attr(DAC_C, 0644, adt7316_show_dac_c, adt7316_store_dac_c, 0);
>  
>  static ssize_t adt7316_show_DAC_D(struct device *dev,
>  		struct device_attribute *attr,
> @@ -1571,8 +1538,7 @@ static ssize_t adt7316_store_DAC_D(struct device *dev,
>  	return adt7316_store_dac(chip, 3, buf, len);
>  }
>  
> -static IIO_DEVICE_ATTR(DAC_D, S_IRUGO | S_IWUSR, adt7316_show_DAC_D,
> -		adt7316_store_DAC_D, 0);
> +static iio_device_attr(DAC_D, 0644, adt7316_show_dac_d, adt7316_store_dac_d, 0);
>  
>  static ssize_t adt7316_show_device_id(struct device *dev,
>  		struct device_attribute *attr,
> @@ -1608,8 +1574,8 @@ static ssize_t adt7316_show_manufactorer_id(struct device *dev,
>  	return sprintf(buf, "%d\n", id);
>  }
>  
> -static IIO_DEVICE_ATTR(manufactorer_id, S_IRUGO,
> -		adt7316_show_manufactorer_id, NULL, 0);
> +static iio_device_attr(manufactorer_id, 0444, adt7316_show_manufactorer_id,
> +		       NULL, 0);
>  
>  static ssize_t adt7316_show_device_rev(struct device *dev,
>  		struct device_attribute *attr,
> @@ -1627,7 +1593,7 @@ static ssize_t adt7316_show_device_rev(struct device *dev,
>  	return sprintf(buf, "%d\n", rev);
>  }
>  
> -static IIO_DEVICE_ATTR(device_rev, S_IRUGO, adt7316_show_device_rev, NULL, 0);
> +static iio_device_attr(device_rev, 0444, adt7316_show_device_rev, NULL, 0);
>  
>  static ssize_t adt7316_show_bus_type(struct device *dev,
>  		struct device_attribute *attr,
> @@ -1648,7 +1614,7 @@ static ssize_t adt7316_show_bus_type(struct device *dev,
>  	return sprintf(buf, "i2c\n");
>  }
>  
> -static IIO_DEVICE_ATTR(bus_type, S_IRUGO, adt7316_show_bus_type, NULL, 0);
> +static iio_device_attr(bus_type, 0444, adt7316_show_bus_type, NULL, 0);
>  
>  static struct attribute *adt7316_attributes[] = {
>  	&iio_dev_attr_all_modes.dev_attr.attr,
> @@ -1970,63 +1936,35 @@ static ssize_t adt7316_set_int_enabled(struct device *dev,
>  	return len;
>  }
>  
> -static IIO_DEVICE_ATTR(int_mask,
> -		       S_IRUGO | S_IWUSR,
> -		       adt7316_show_int_mask, adt7316_set_int_mask,
> -		       0);
> -static IIO_DEVICE_ATTR(in_temp_high_value,
> -		       S_IRUGO | S_IWUSR,
> -		       adt7316_show_ad_bound, adt7316_set_ad_bound,
> -		       ADT7316_IN_TEMP_HIGH);
> -static IIO_DEVICE_ATTR(in_temp_low_value,
> -		       S_IRUGO | S_IWUSR,
> -		       adt7316_show_ad_bound, adt7316_set_ad_bound,
> -		       ADT7316_IN_TEMP_LOW);
> -static IIO_DEVICE_ATTR(ex_temp_high_value,
> -		       S_IRUGO | S_IWUSR,
> -		       adt7316_show_ad_bound, adt7316_set_ad_bound,
> -		       ADT7316_EX_TEMP_HIGH);
> -static IIO_DEVICE_ATTR(ex_temp_low_value,
> -		       S_IRUGO | S_IWUSR,
> -		       adt7316_show_ad_bound, adt7316_set_ad_bound,
> -		       ADT7316_EX_TEMP_LOW);
> +static iio_device_attr(int_mask, 0644, adt7316_show_int_mask,
> +		       adt7316_set_int_mask, 0);
> +static iio_device_attr(in_temp_high_value, 0644, adt7316_show_ad_bound,
> +		       adt7316_set_ad_bound, ADT7316_IN_TEMP_HIGH);
> +static iio_device_attr(in_temp_low_value, 0644, adt7316_show_ad_bound,
> +		       adt7316_set_ad_bound, ADT7316_IN_TEMP_LOW);
> +static iio_device_attr(ex_temp_high_value, 0644, adt7316_show_ad_bound,
> +		       adt7316_set_ad_bound, ADT7316_EX_TEMP_HIGH);
> +static iio_device_attr(ex_temp_low_value, 0644, adt7316_show_ad_bound,
> +		       adt7316_set_ad_bound, ADT7316_EX_TEMP_LOW);
>  
>  /* NASTY duplication to be fixed */
> -static IIO_DEVICE_ATTR(ex_temp_ain1_high_value,
> -		       S_IRUGO | S_IWUSR,
> -		       adt7316_show_ad_bound, adt7316_set_ad_bound,
> -		       ADT7316_EX_TEMP_HIGH);
> -static IIO_DEVICE_ATTR(ex_temp_ain1_low_value,
> -		       S_IRUGO | S_IWUSR,
> -		       adt7316_show_ad_bound, adt7316_set_ad_bound,
> -		       ADT7316_EX_TEMP_LOW);
> -static IIO_DEVICE_ATTR(ain2_high_value,
> -		       S_IRUGO | S_IWUSR,
> -		       adt7316_show_ad_bound, adt7316_set_ad_bound,
> -		       ADT7516_AIN2_HIGH);
> -static IIO_DEVICE_ATTR(ain2_low_value,
> -		       S_IRUGO | S_IWUSR,
> -		       adt7316_show_ad_bound, adt7316_set_ad_bound,
> -		       ADT7516_AIN2_LOW);
> -static IIO_DEVICE_ATTR(ain3_high_value,
> -		       S_IRUGO | S_IWUSR,
> -		       adt7316_show_ad_bound, adt7316_set_ad_bound,
> -		       ADT7516_AIN3_HIGH);
> -static IIO_DEVICE_ATTR(ain3_low_value,
> -		       S_IRUGO | S_IWUSR,
> -		       adt7316_show_ad_bound, adt7316_set_ad_bound,
> -		       ADT7516_AIN3_LOW);
> -static IIO_DEVICE_ATTR(ain4_high_value,
> -		       S_IRUGO | S_IWUSR,
> -		       adt7316_show_ad_bound, adt7316_set_ad_bound,
> -		       ADT7516_AIN4_HIGH);
> -static IIO_DEVICE_ATTR(ain4_low_value,
> -		       S_IRUGO | S_IWUSR,
> -		       adt7316_show_ad_bound, adt7316_set_ad_bound,
> -		       ADT7516_AIN4_LOW);
> -static IIO_DEVICE_ATTR(int_enabled,
> -		       S_IRUGO | S_IWUSR,
> -		       adt7316_show_int_enabled,
> +static iio_device_attr(ex_temp_ain1_high_value, 0644, adt7316_show_ad_bound,
> +		       adt7316_set_ad_bound, ADT7316_EX_TEMP_HIGH);
> +static iio_device_attr(ex_temp_ain1_low_value, 0644, adt7316_show_ad_bound,
> +		       adt7316_set_ad_bound, ADT7316_EX_TEMP_LOW);
> +static iio_device_attr(ain2_high_value, 0644, adt7316_show_ad_bound,
> +		       adt7316_set_ad_bound, ADT7516_AIN2_HIGH);
> +static iio_device_attr(ain2_low_value, 0644, adt7316_show_ad_bound,
> +		       adt7316_set_ad_bound, ADT7516_AIN2_LOW);
> +static iio_device_attr(ain3_high_value, 0644, adt7316_show_ad_bound,
> +		       adt7316_set_ad_bound, ADT7516_AIN3_HIGH);
> +static iio_device_attr(ain3_low_value, 0644, adt7316_show_ad_bound,
> +		       adt7316_set_ad_bound, ADT7516_AIN3_LOW);
> +static iio_device_attr(ain4_high_value, 0644, adt7316_show_ad_bound,
> +		       adt7316_set_ad_bound, ADT7516_AIN4_HIGH);
> +static iio_device_attr(ain4_low_value, 0644, adt7316_show_ad_bound,
> +		       adt7316_set_ad_bound, ADT7516_AIN4_LOW);
> +static iio_device_attr(int_enabled, 0644, adt7316_show_int_enabled,
>  		       adt7316_set_int_enabled, 0);
>  
>  static struct attribute *adt7316_event_attributes[] = {
> 

