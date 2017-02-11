Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45143 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753395AbdBKKWm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Feb 2017 05:22:42 -0500
Subject: Re: [PATCH] Staging: iio: addac: adt7316.c - style fix, octal
 permission
To: Derek Robson <robsonde@gmail.com>, lars@metafoo.de,
        Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org
References: <20170206040127.27255-1-robsonde@gmail.com>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <1b32d593-44b7-2362-1cfe-0714a8769332@kernel.org>
Date: Sat, 11 Feb 2017 10:22:39 +0000
MIME-Version: 1.0
In-Reply-To: <20170206040127.27255-1-robsonde@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/02/17 04:01, Derek Robson wrote:
> Changed file permissions to octal.
> Found with checkpatch.
> 
> Signed-off-by: Derek Robson <robsonde@gmail.com>
Hi Derek,

Someone else got there first I'm afraid.  Already changed in the testing branch
of iio.git.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/addac/adt7316.c | 108 ++++++++++++++++++------------------
>  1 file changed, 54 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> index 6054c7298fce..aa251c245981 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -267,7 +267,7 @@ static ssize_t adt7316_store_enabled(struct device *dev,
>  	return len;
>  }
>  
> -static IIO_DEVICE_ATTR(enabled, S_IRUGO | S_IWUSR,
> +static IIO_DEVICE_ATTR(enabled, 0644,
>  		adt7316_show_enabled,
>  		adt7316_store_enabled,
>  		0);
> @@ -311,7 +311,7 @@ static ssize_t adt7316_store_select_ex_temp(struct device *dev,
>  	return len;
>  }
>  
> -static IIO_DEVICE_ATTR(select_ex_temp, S_IRUGO | S_IWUSR,
> +static IIO_DEVICE_ATTR(select_ex_temp, 0644,
>  		adt7316_show_select_ex_temp,
>  		adt7316_store_select_ex_temp,
>  		0);
> @@ -352,7 +352,7 @@ static ssize_t adt7316_store_mode(struct device *dev,
>  	return len;
>  }
>  
> -static IIO_DEVICE_ATTR(mode, S_IRUGO | S_IWUSR,
> +static IIO_DEVICE_ATTR(mode, 0644,
>  		adt7316_show_mode,
>  		adt7316_store_mode,
>  		0);
> @@ -364,7 +364,7 @@ static ssize_t adt7316_show_all_modes(struct device *dev,
>  	return sprintf(buf, "single_channel\nround_robin\n");
>  }
>  
> -static IIO_DEVICE_ATTR(all_modes, S_IRUGO, adt7316_show_all_modes, NULL, 0);
> +static IIO_DEVICE_ATTR(all_modes, 0444, adt7316_show_all_modes, NULL, 0);
>  
>  static ssize_t adt7316_show_ad_channel(struct device *dev,
>  		struct device_attribute *attr,
> @@ -446,7 +446,7 @@ static ssize_t adt7316_store_ad_channel(struct device *dev,
>  	return len;
>  }
>  
> -static IIO_DEVICE_ATTR(ad_channel, S_IRUGO | S_IWUSR,
> +static IIO_DEVICE_ATTR(ad_channel, 0644,
>  		adt7316_show_ad_channel,
>  		adt7316_store_ad_channel,
>  		0);
> @@ -469,7 +469,7 @@ static ssize_t adt7316_show_all_ad_channels(struct device *dev,
>  			"2 - External Temperature\n");
>  }
>  
> -static IIO_DEVICE_ATTR(all_ad_channels, S_IRUGO,
> +static IIO_DEVICE_ATTR(all_ad_channels, 0444,
>  		adt7316_show_all_ad_channels, NULL, 0);
>  
>  static ssize_t adt7316_show_disable_averaging(struct device *dev,
> @@ -506,7 +506,7 @@ static ssize_t adt7316_store_disable_averaging(struct device *dev,
>  	return len;
>  }
>  
> -static IIO_DEVICE_ATTR(disable_averaging, S_IRUGO | S_IWUSR,
> +static IIO_DEVICE_ATTR(disable_averaging, 0644,
>  		adt7316_show_disable_averaging,
>  		adt7316_store_disable_averaging,
>  		0);
> @@ -545,7 +545,7 @@ static ssize_t adt7316_store_enable_smbus_timeout(struct device *dev,
>  	return len;
>  }
>  
> -static IIO_DEVICE_ATTR(enable_smbus_timeout, S_IRUGO | S_IWUSR,
> +static IIO_DEVICE_ATTR(enable_smbus_timeout, 0644,
>  		adt7316_show_enable_smbus_timeout,
>  		adt7316_store_enable_smbus_timeout,
>  		0);
> @@ -583,7 +583,7 @@ static ssize_t adt7316_store_powerdown(struct device *dev,
>  	return len;
>  }
>  
> -static IIO_DEVICE_ATTR(powerdown, S_IRUGO | S_IWUSR,
> +static IIO_DEVICE_ATTR(powerdown, 0644,
>  		adt7316_show_powerdown,
>  		adt7316_store_powerdown,
>  		0);
> @@ -621,7 +621,7 @@ static ssize_t adt7316_store_fast_ad_clock(struct device *dev,
>  	return len;
>  }
>  
> -static IIO_DEVICE_ATTR(fast_ad_clock, S_IRUGO | S_IWUSR,
> +static IIO_DEVICE_ATTR(fast_ad_clock, 0644,
>  		adt7316_show_fast_ad_clock,
>  		adt7316_store_fast_ad_clock,
>  		0);
> @@ -674,7 +674,7 @@ static ssize_t adt7316_store_da_high_resolution(struct device *dev,
>  	return len;
>  }
>  
> -static IIO_DEVICE_ATTR(da_high_resolution, S_IRUGO | S_IWUSR,
> +static IIO_DEVICE_ATTR(da_high_resolution, 0644,
>  		adt7316_show_da_high_resolution,
>  		adt7316_store_da_high_resolution,
>  		0);
> @@ -720,7 +720,7 @@ static ssize_t adt7316_store_AIN_internal_Vref(struct device *dev,
>  	return len;
>  }
>  
> -static IIO_DEVICE_ATTR(AIN_internal_Vref, S_IRUGO | S_IWUSR,
> +static IIO_DEVICE_ATTR(AIN_internal_Vref, 0644,
>  		adt7316_show_AIN_internal_Vref,
>  		adt7316_store_AIN_internal_Vref,
>  		0);
> @@ -760,7 +760,7 @@ static ssize_t adt7316_store_enable_prop_DACA(struct device *dev,
>  	return len;
>  }
>  
> -static IIO_DEVICE_ATTR(enable_proportion_DACA, S_IRUGO | S_IWUSR,
> +static IIO_DEVICE_ATTR(enable_proportion_DACA, 0644,
>  		adt7316_show_enable_prop_DACA,
>  		adt7316_store_enable_prop_DACA,
>  		0);
> @@ -799,7 +799,7 @@ static ssize_t adt7316_store_enable_prop_DACB(struct device *dev,
>  	return len;
>  }
>  
> -static IIO_DEVICE_ATTR(enable_proportion_DACB, S_IRUGO | S_IWUSR,
> +static IIO_DEVICE_ATTR(enable_proportion_DACB, 0644,
>  		adt7316_show_enable_prop_DACB,
>  		adt7316_store_enable_prop_DACB,
>  		0);
> @@ -842,7 +842,7 @@ static ssize_t adt7316_store_DAC_2Vref_ch_mask(struct device *dev,
>  	return len;
>  }
>  
> -static IIO_DEVICE_ATTR(DAC_2Vref_channels_mask, S_IRUGO | S_IWUSR,
> +static IIO_DEVICE_ATTR(DAC_2Vref_channels_mask, 0644,
>  		adt7316_show_DAC_2Vref_ch_mask,
>  		adt7316_store_DAC_2Vref_ch_mask,
>  		0);
> @@ -902,7 +902,7 @@ static ssize_t adt7316_store_DAC_update_mode(struct device *dev,
>  	return len;
>  }
>  
> -static IIO_DEVICE_ATTR(DAC_update_mode, S_IRUGO | S_IWUSR,
> +static IIO_DEVICE_ATTR(DAC_update_mode, 0644,
>  		adt7316_show_DAC_update_mode,
>  		adt7316_store_DAC_update_mode,
>  		0);
> @@ -922,7 +922,7 @@ static ssize_t adt7316_show_all_DAC_update_modes(struct device *dev,
>  	return sprintf(buf, "manual\n");
>  }
>  
> -static IIO_DEVICE_ATTR(all_DAC_update_modes, S_IRUGO,
> +static IIO_DEVICE_ATTR(all_DAC_update_modes, 0444,
>  		adt7316_show_all_DAC_update_modes, NULL, 0);
>  
>  
> @@ -961,7 +961,7 @@ static ssize_t adt7316_store_update_DAC(struct device *dev,
>  	return len;
>  }
>  
> -static IIO_DEVICE_ATTR(update_DAC, S_IRUGO | S_IWUSR,
> +static IIO_DEVICE_ATTR(update_DAC, 0644,
>  		NULL,
>  		adt7316_store_update_DAC,
>  		0);
> @@ -1006,7 +1006,7 @@ static ssize_t adt7316_store_DA_AB_Vref_bypass(struct device *dev,
>  	return len;
>  }
>  
> -static IIO_DEVICE_ATTR(DA_AB_Vref_bypass, S_IRUGO | S_IWUSR,
> +static IIO_DEVICE_ATTR(DA_AB_Vref_bypass, 0644,
>  		adt7316_show_DA_AB_Vref_bypass,
>  		adt7316_store_DA_AB_Vref_bypass,
>  		0);
> @@ -1051,7 +1051,7 @@ static ssize_t adt7316_store_DA_CD_Vref_bypass(struct device *dev,
>  	return len;
>  }
>  
> -static IIO_DEVICE_ATTR(DA_CD_Vref_bypass, S_IRUGO | S_IWUSR,
> +static IIO_DEVICE_ATTR(DA_CD_Vref_bypass, 0644,
>  		adt7316_show_DA_CD_Vref_bypass,
>  		adt7316_store_DA_CD_Vref_bypass,
>  		0);
> @@ -1112,7 +1112,7 @@ static ssize_t adt7316_store_DAC_internal_Vref(struct device *dev,
>  	return len;
>  }
>  
> -static IIO_DEVICE_ATTR(DAC_internal_Vref, S_IRUGO | S_IWUSR,
> +static IIO_DEVICE_ATTR(DAC_internal_Vref, 0644,
>  		adt7316_show_DAC_internal_Vref,
>  		adt7316_store_DAC_internal_Vref,
>  		0);
> @@ -1201,7 +1201,7 @@ static ssize_t adt7316_show_VDD(struct device *dev,
>  
>  	return adt7316_show_ad(chip, ADT7316_AD_SINGLE_CH_VDD, buf);
>  }
> -static IIO_DEVICE_ATTR(VDD, S_IRUGO, adt7316_show_VDD, NULL, 0);
> +static IIO_DEVICE_ATTR(VDD, 0444, adt7316_show_VDD, NULL, 0);
>  
>  static ssize_t adt7316_show_in_temp(struct device *dev,
>  		struct device_attribute *attr,
> @@ -1213,7 +1213,7 @@ static ssize_t adt7316_show_in_temp(struct device *dev,
>  	return adt7316_show_ad(chip, ADT7316_AD_SINGLE_CH_IN, buf);
>  }
>  
> -static IIO_DEVICE_ATTR(in_temp, S_IRUGO, adt7316_show_in_temp, NULL, 0);
> +static IIO_DEVICE_ATTR(in_temp, 0444, adt7316_show_in_temp, NULL, 0);
>  
>  static ssize_t adt7316_show_ex_temp_AIN1(struct device *dev,
>  		struct device_attribute *attr,
> @@ -1225,9 +1225,9 @@ static ssize_t adt7316_show_ex_temp_AIN1(struct device *dev,
>  	return adt7316_show_ad(chip, ADT7316_AD_SINGLE_CH_EX, buf);
>  }
>  
> -static IIO_DEVICE_ATTR(ex_temp_AIN1, S_IRUGO, adt7316_show_ex_temp_AIN1,
> +static IIO_DEVICE_ATTR(ex_temp_AIN1, 0444, adt7316_show_ex_temp_AIN1,
>  		NULL, 0);
> -static IIO_DEVICE_ATTR(ex_temp, S_IRUGO, adt7316_show_ex_temp_AIN1, NULL, 0);
> +static IIO_DEVICE_ATTR(ex_temp, 0444, adt7316_show_ex_temp_AIN1, NULL, 0);
>  
>  static ssize_t adt7316_show_AIN2(struct device *dev,
>  		struct device_attribute *attr,
> @@ -1238,7 +1238,7 @@ static ssize_t adt7316_show_AIN2(struct device *dev,
>  
>  	return adt7316_show_ad(chip, ADT7516_AD_SINGLE_CH_AIN2, buf);
>  }
> -static IIO_DEVICE_ATTR(AIN2, S_IRUGO, adt7316_show_AIN2, NULL, 0);
> +static IIO_DEVICE_ATTR(AIN2, 0444, adt7316_show_AIN2, NULL, 0);
>  
>  static ssize_t adt7316_show_AIN3(struct device *dev,
>  		struct device_attribute *attr,
> @@ -1249,7 +1249,7 @@ static ssize_t adt7316_show_AIN3(struct device *dev,
>  
>  	return adt7316_show_ad(chip, ADT7516_AD_SINGLE_CH_AIN3, buf);
>  }
> -static IIO_DEVICE_ATTR(AIN3, S_IRUGO, adt7316_show_AIN3, NULL, 0);
> +static IIO_DEVICE_ATTR(AIN3, 0444, adt7316_show_AIN3, NULL, 0);
>  
>  static ssize_t adt7316_show_AIN4(struct device *dev,
>  		struct device_attribute *attr,
> @@ -1260,7 +1260,7 @@ static ssize_t adt7316_show_AIN4(struct device *dev,
>  
>  	return adt7316_show_ad(chip, ADT7516_AD_SINGLE_CH_AIN4, buf);
>  }
> -static IIO_DEVICE_ATTR(AIN4, S_IRUGO, adt7316_show_AIN4, NULL, 0);
> +static IIO_DEVICE_ATTR(AIN4, 0444, adt7316_show_AIN4, NULL, 0);
>  
>  static ssize_t adt7316_show_temp_offset(struct adt7316_chip_info *chip,
>  		int offset_addr, char *buf)
> @@ -1325,7 +1325,7 @@ static ssize_t adt7316_store_in_temp_offset(struct device *dev,
>  			len);
>  }
>  
> -static IIO_DEVICE_ATTR(in_temp_offset, S_IRUGO | S_IWUSR,
> +static IIO_DEVICE_ATTR(in_temp_offset, 0644,
>  		adt7316_show_in_temp_offset,
>  		adt7316_store_in_temp_offset, 0);
>  
> @@ -1351,7 +1351,7 @@ static ssize_t adt7316_store_ex_temp_offset(struct device *dev,
>  			len);
>  }
>  
> -static IIO_DEVICE_ATTR(ex_temp_offset, S_IRUGO | S_IWUSR,
> +static IIO_DEVICE_ATTR(ex_temp_offset, 0644,
>  		adt7316_show_ex_temp_offset,
>  		adt7316_store_ex_temp_offset, 0);
>  
> @@ -1378,7 +1378,7 @@ static ssize_t adt7316_store_in_analog_temp_offset(struct device *dev,
>  			ADT7316_IN_ANALOG_TEMP_OFFSET, buf, len);
>  }
>  
> -static IIO_DEVICE_ATTR(in_analog_temp_offset, S_IRUGO | S_IWUSR,
> +static IIO_DEVICE_ATTR(in_analog_temp_offset, 0644,
>  		adt7316_show_in_analog_temp_offset,
>  		adt7316_store_in_analog_temp_offset, 0);
>  
> @@ -1405,7 +1405,7 @@ static ssize_t adt7316_store_ex_analog_temp_offset(struct device *dev,
>  			ADT7316_EX_ANALOG_TEMP_OFFSET, buf, len);
>  }
>  
> -static IIO_DEVICE_ATTR(ex_analog_temp_offset, S_IRUGO | S_IWUSR,
> +static IIO_DEVICE_ATTR(ex_analog_temp_offset, 0644,
>  		adt7316_show_ex_analog_temp_offset,
>  		adt7316_store_ex_analog_temp_offset, 0);
>  
> @@ -1500,7 +1500,7 @@ static ssize_t adt7316_store_DAC_A(struct device *dev,
>  	return adt7316_store_DAC(chip, 0, buf, len);
>  }
>  
> -static IIO_DEVICE_ATTR(DAC_A, S_IRUGO | S_IWUSR, adt7316_show_DAC_A,
> +static IIO_DEVICE_ATTR(DAC_A, 0644, adt7316_show_DAC_A,
>  		adt7316_store_DAC_A, 0);
>  
>  static ssize_t adt7316_show_DAC_B(struct device *dev,
> @@ -1524,7 +1524,7 @@ static ssize_t adt7316_store_DAC_B(struct device *dev,
>  	return adt7316_store_DAC(chip, 1, buf, len);
>  }
>  
> -static IIO_DEVICE_ATTR(DAC_B, S_IRUGO | S_IWUSR, adt7316_show_DAC_B,
> +static IIO_DEVICE_ATTR(DAC_B, 0644, adt7316_show_DAC_B,
>  		adt7316_store_DAC_B, 0);
>  
>  static ssize_t adt7316_show_DAC_C(struct device *dev,
> @@ -1548,7 +1548,7 @@ static ssize_t adt7316_store_DAC_C(struct device *dev,
>  	return adt7316_store_DAC(chip, 2, buf, len);
>  }
>  
> -static IIO_DEVICE_ATTR(DAC_C, S_IRUGO | S_IWUSR, adt7316_show_DAC_C,
> +static IIO_DEVICE_ATTR(DAC_C, 0644, adt7316_show_DAC_C,
>  		adt7316_store_DAC_C, 0);
>  
>  static ssize_t adt7316_show_DAC_D(struct device *dev,
> @@ -1572,7 +1572,7 @@ static ssize_t adt7316_store_DAC_D(struct device *dev,
>  	return adt7316_store_DAC(chip, 3, buf, len);
>  }
>  
> -static IIO_DEVICE_ATTR(DAC_D, S_IRUGO | S_IWUSR, adt7316_show_DAC_D,
> +static IIO_DEVICE_ATTR(DAC_D, 0644, adt7316_show_DAC_D,
>  		adt7316_store_DAC_D, 0);
>  
>  static ssize_t adt7316_show_device_id(struct device *dev,
> @@ -1591,7 +1591,7 @@ static ssize_t adt7316_show_device_id(struct device *dev,
>  	return sprintf(buf, "%d\n", id);
>  }
>  
> -static IIO_DEVICE_ATTR(device_id, S_IRUGO, adt7316_show_device_id, NULL, 0);
> +static IIO_DEVICE_ATTR(device_id, 0444, adt7316_show_device_id, NULL, 0);
>  
>  static ssize_t adt7316_show_manufactorer_id(struct device *dev,
>  		struct device_attribute *attr,
> @@ -1609,7 +1609,7 @@ static ssize_t adt7316_show_manufactorer_id(struct device *dev,
>  	return sprintf(buf, "%d\n", id);
>  }
>  
> -static IIO_DEVICE_ATTR(manufactorer_id, S_IRUGO,
> +static IIO_DEVICE_ATTR(manufactorer_id, 0444,
>  		adt7316_show_manufactorer_id, NULL, 0);
>  
>  static ssize_t adt7316_show_device_rev(struct device *dev,
> @@ -1628,7 +1628,7 @@ static ssize_t adt7316_show_device_rev(struct device *dev,
>  	return sprintf(buf, "%d\n", rev);
>  }
>  
> -static IIO_DEVICE_ATTR(device_rev, S_IRUGO, adt7316_show_device_rev, NULL, 0);
> +static IIO_DEVICE_ATTR(device_rev, 0444, adt7316_show_device_rev, NULL, 0);
>  
>  static ssize_t adt7316_show_bus_type(struct device *dev,
>  		struct device_attribute *attr,
> @@ -1649,7 +1649,7 @@ static ssize_t adt7316_show_bus_type(struct device *dev,
>  	return sprintf(buf, "i2c\n");
>  }
>  
> -static IIO_DEVICE_ATTR(bus_type, S_IRUGO, adt7316_show_bus_type, NULL, 0);
> +static IIO_DEVICE_ATTR(bus_type, 0444, adt7316_show_bus_type, NULL, 0);
>  
>  static struct attribute *adt7316_attributes[] = {
>  	&iio_dev_attr_all_modes.dev_attr.attr,
> @@ -1972,61 +1972,61 @@ static ssize_t adt7316_set_int_enabled(struct device *dev,
>  }
>  
>  static IIO_DEVICE_ATTR(int_mask,
> -		       S_IRUGO | S_IWUSR,
> +		       0644,
>  		       adt7316_show_int_mask, adt7316_set_int_mask,
>  		       0);
>  static IIO_DEVICE_ATTR(in_temp_high_value,
> -		       S_IRUGO | S_IWUSR,
> +		       0644,
>  		       adt7316_show_ad_bound, adt7316_set_ad_bound,
>  		       ADT7316_IN_TEMP_HIGH);
>  static IIO_DEVICE_ATTR(in_temp_low_value,
> -		       S_IRUGO | S_IWUSR,
> +		       0644,
>  		       adt7316_show_ad_bound, adt7316_set_ad_bound,
>  		       ADT7316_IN_TEMP_LOW);
>  static IIO_DEVICE_ATTR(ex_temp_high_value,
> -		       S_IRUGO | S_IWUSR,
> +		       0644,
>  		       adt7316_show_ad_bound, adt7316_set_ad_bound,
>  		       ADT7316_EX_TEMP_HIGH);
>  static IIO_DEVICE_ATTR(ex_temp_low_value,
> -		       S_IRUGO | S_IWUSR,
> +		       0644,
>  		       adt7316_show_ad_bound, adt7316_set_ad_bound,
>  		       ADT7316_EX_TEMP_LOW);
>  
>  /* NASTY duplication to be fixed */
>  static IIO_DEVICE_ATTR(ex_temp_ain1_high_value,
> -		       S_IRUGO | S_IWUSR,
> +		       0644,
>  		       adt7316_show_ad_bound, adt7316_set_ad_bound,
>  		       ADT7316_EX_TEMP_HIGH);
>  static IIO_DEVICE_ATTR(ex_temp_ain1_low_value,
> -		       S_IRUGO | S_IWUSR,
> +		       0644,
>  		       adt7316_show_ad_bound, adt7316_set_ad_bound,
>  		       ADT7316_EX_TEMP_LOW);
>  static IIO_DEVICE_ATTR(ain2_high_value,
> -		       S_IRUGO | S_IWUSR,
> +		       0644,
>  		       adt7316_show_ad_bound, adt7316_set_ad_bound,
>  		       ADT7516_AIN2_HIGH);
>  static IIO_DEVICE_ATTR(ain2_low_value,
> -		       S_IRUGO | S_IWUSR,
> +		       0644,
>  		       adt7316_show_ad_bound, adt7316_set_ad_bound,
>  		       ADT7516_AIN2_LOW);
>  static IIO_DEVICE_ATTR(ain3_high_value,
> -		       S_IRUGO | S_IWUSR,
> +		       0644,
>  		       adt7316_show_ad_bound, adt7316_set_ad_bound,
>  		       ADT7516_AIN3_HIGH);
>  static IIO_DEVICE_ATTR(ain3_low_value,
> -		       S_IRUGO | S_IWUSR,
> +		       0644,
>  		       adt7316_show_ad_bound, adt7316_set_ad_bound,
>  		       ADT7516_AIN3_LOW);
>  static IIO_DEVICE_ATTR(ain4_high_value,
> -		       S_IRUGO | S_IWUSR,
> +		       0644,
>  		       adt7316_show_ad_bound, adt7316_set_ad_bound,
>  		       ADT7516_AIN4_HIGH);
>  static IIO_DEVICE_ATTR(ain4_low_value,
> -		       S_IRUGO | S_IWUSR,
> +		       0644,
>  		       adt7316_show_ad_bound, adt7316_set_ad_bound,
>  		       ADT7516_AIN4_LOW);
>  static IIO_DEVICE_ATTR(int_enabled,
> -		       S_IRUGO | S_IWUSR,
> +		       0644,
>  		       adt7316_show_int_enabled,
>  		       adt7316_set_int_enabled, 0);
>  
> 

