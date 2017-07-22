Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750864AbdGVR5S (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Jul 2017 13:57:18 -0400
Date: Sat, 22 Jul 2017 18:57:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@st.com
Subject: Re: [PATCH v2 01/10] iio: humidity: hts221: refactor
 write_with_mask code
Message-ID: <20170722185713.664334ea@kernel.org>
In-Reply-To: <20170717173905.8209-2-lorenzo.bianconi@st.com>
References: <20170717173905.8209-1-lorenzo.bianconi@st.com>
        <20170717173905.8209-2-lorenzo.bianconi@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 17 Jul 2017 19:38:56 +0200
Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:

> Move bit-shift in hts221_write_with_mask() instead of coding
> the shift depth in the configured value. That change will be necessary
> to fix an issue in device power-down procedure.
> Simplify hts221_avg_list table management
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
Applied to the togreg branch of iio.git.  Whilst this is
associated with a fix, the series to that point is really
too invasive to be material suitable for heading mainline
except during a merge window.

Pushed out as testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/humidity/hts221.h      |  6 ---
>  drivers/iio/humidity/hts221_core.c | 94 +++++++++++++++++---------------------
>  2 files changed, 42 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/iio/humidity/hts221.h b/drivers/iio/humidity/hts221.h
> index 94510266e0a5..bf33d8f6396c 100644
> --- a/drivers/iio/humidity/hts221.h
> +++ b/drivers/iio/humidity/hts221.h
> @@ -30,12 +30,6 @@ struct hts221_transfer_function {
>  	int (*write)(struct device *dev, u8 addr, int len, u8 *data);
>  };
>  
> -#define HTS221_AVG_DEPTH	8
> -struct hts221_avg_avl {
> -	u16 avg;
> -	u8 val;
> -};
> -
>  enum hts221_sensor_type {
>  	HTS221_SENSOR_H,
>  	HTS221_SENSOR_T,
> diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
> index a56da3999e00..d2f59626b040 100644
> --- a/drivers/iio/humidity/hts221_core.c
> +++ b/drivers/iio/humidity/hts221_core.c
> @@ -32,30 +32,12 @@
>  #define HTS221_HUMIDITY_AVG_MASK	0x07
>  #define HTS221_TEMP_AVG_MASK		0x38
>  
> -#define HTS221_ODR_MASK			0x87
> +#define HTS221_ODR_MASK			0x03
>  #define HTS221_BDU_MASK			BIT(2)
> +#define HTS221_ENABLE_MASK		BIT(7)
>  
>  #define HTS221_DRDY_MASK		BIT(2)
>  
> -#define HTS221_ENABLE_SENSOR		BIT(7)
> -
> -#define HTS221_HUMIDITY_AVG_4		0x00 /* 0.4 %RH */
> -#define HTS221_HUMIDITY_AVG_8		0x01 /* 0.3 %RH */
> -#define HTS221_HUMIDITY_AVG_16		0x02 /* 0.2 %RH */
> -#define HTS221_HUMIDITY_AVG_32		0x03 /* 0.15 %RH */
> -#define HTS221_HUMIDITY_AVG_64		0x04 /* 0.1 %RH */
> -#define HTS221_HUMIDITY_AVG_128		0x05 /* 0.07 %RH */
> -#define HTS221_HUMIDITY_AVG_256		0x06 /* 0.05 %RH */
> -#define HTS221_HUMIDITY_AVG_512		0x07 /* 0.03 %RH */
> -
> -#define HTS221_TEMP_AVG_2		0x00 /* 0.08 degC */
> -#define HTS221_TEMP_AVG_4		0x08 /* 0.05 degC */
> -#define HTS221_TEMP_AVG_8		0x10 /* 0.04 degC */
> -#define HTS221_TEMP_AVG_16		0x18 /* 0.03 degC */
> -#define HTS221_TEMP_AVG_32		0x20 /* 0.02 degC */
> -#define HTS221_TEMP_AVG_64		0x28 /* 0.015 degC */
> -#define HTS221_TEMP_AVG_128		0x30 /* 0.01 degC */
> -#define HTS221_TEMP_AVG_256		0x38 /* 0.007 degC */
>  
>  /* calibration registers */
>  #define HTS221_REG_0RH_CAL_X_H		0x36
> @@ -73,10 +55,11 @@ struct hts221_odr {
>  	u8 val;
>  };
>  
> +#define HTS221_AVG_DEPTH		8
>  struct hts221_avg {
>  	u8 addr;
>  	u8 mask;
> -	struct hts221_avg_avl avg_avl[HTS221_AVG_DEPTH];
> +	u16 avg_avl[HTS221_AVG_DEPTH];
>  };
>  
>  static const struct hts221_odr hts221_odr_table[] = {
> @@ -90,28 +73,28 @@ static const struct hts221_avg hts221_avg_list[] = {
>  		.addr = HTS221_REG_AVG_ADDR,
>  		.mask = HTS221_HUMIDITY_AVG_MASK,
>  		.avg_avl = {
> -			{ 4, HTS221_HUMIDITY_AVG_4 },
> -			{ 8, HTS221_HUMIDITY_AVG_8 },
> -			{ 16, HTS221_HUMIDITY_AVG_16 },
> -			{ 32, HTS221_HUMIDITY_AVG_32 },
> -			{ 64, HTS221_HUMIDITY_AVG_64 },
> -			{ 128, HTS221_HUMIDITY_AVG_128 },
> -			{ 256, HTS221_HUMIDITY_AVG_256 },
> -			{ 512, HTS221_HUMIDITY_AVG_512 },
> +			4, /* 0.4 %RH */
> +			8, /* 0.3 %RH */
> +			16, /* 0.2 %RH */
> +			32, /* 0.15 %RH */
> +			64, /* 0.1 %RH */
> +			128, /* 0.07 %RH */
> +			256, /* 0.05 %RH */
> +			512, /* 0.03 %RH */
>  		},
>  	},
>  	{
>  		.addr = HTS221_REG_AVG_ADDR,
>  		.mask = HTS221_TEMP_AVG_MASK,
>  		.avg_avl = {
> -			{ 2, HTS221_TEMP_AVG_2 },
> -			{ 4, HTS221_TEMP_AVG_4 },
> -			{ 8, HTS221_TEMP_AVG_8 },
> -			{ 16, HTS221_TEMP_AVG_16 },
> -			{ 32, HTS221_TEMP_AVG_32 },
> -			{ 64, HTS221_TEMP_AVG_64 },
> -			{ 128, HTS221_TEMP_AVG_128 },
> -			{ 256, HTS221_TEMP_AVG_256 },
> +			2, /* 0.08 degC */
> +			4, /* 0.05 degC */
> +			8, /* 0.04 degC */
> +			16, /* 0.03 degC */
> +			32, /* 0.02 degC */
> +			64, /* 0.015 degC */
> +			128, /* 0.01 degC */
> +			256, /* 0.007 degC */
>  		},
>  	},
>  };
> @@ -166,7 +149,7 @@ static int hts221_write_with_mask(struct hts221_hw *hw, u8 addr, u8 mask,
>  		goto unlock;
>  	}
>  
> -	data = (data & ~mask) | (val & mask);
> +	data = (data & ~mask) | ((val << __ffs(mask)) & mask);
>  
>  	err = hw->tf->write(hw->dev, addr, sizeof(data), &data);
>  	if (err < 0)
> @@ -201,11 +184,10 @@ static int hts221_check_whoami(struct hts221_hw *hw)
>  
>  int hts221_config_drdy(struct hts221_hw *hw, bool enable)
>  {
> -	u8 val = enable ? BIT(2) : 0;
>  	int err;
>  
>  	err = hts221_write_with_mask(hw, HTS221_REG_CNTRL3_ADDR,
> -				     HTS221_DRDY_MASK, val);
> +				     HTS221_DRDY_MASK, enable);
>  
>  	return err < 0 ? err : 0;
>  }
> @@ -213,7 +195,6 @@ int hts221_config_drdy(struct hts221_hw *hw, bool enable)
>  static int hts221_update_odr(struct hts221_hw *hw, u8 odr)
>  {
>  	int i, err;
> -	u8 val;
>  
>  	for (i = 0; i < ARRAY_SIZE(hts221_odr_table); i++)
>  		if (hts221_odr_table[i].hz == odr)
> @@ -222,9 +203,19 @@ static int hts221_update_odr(struct hts221_hw *hw, u8 odr)
>  	if (i == ARRAY_SIZE(hts221_odr_table))
>  		return -EINVAL;
>  
> -	val = HTS221_ENABLE_SENSOR | HTS221_BDU_MASK | hts221_odr_table[i].val;
> +	/* enable Block Data Update */
> +	err = hts221_write_with_mask(hw, HTS221_REG_CNTRL1_ADDR,
> +				     HTS221_BDU_MASK, 1);
> +	if (err < 0)
> +		return err;
> +
> +	err = hts221_write_with_mask(hw, HTS221_REG_CNTRL1_ADDR,
> +				     HTS221_ODR_MASK, hts221_odr_table[i].val);
> +	if (err < 0)
> +		return err;
> +
>  	err = hts221_write_with_mask(hw, HTS221_REG_CNTRL1_ADDR,
> -				     HTS221_ODR_MASK, val);
> +				     HTS221_ENABLE_MASK, 1);
>  	if (err < 0)
>  		return err;
>  
> @@ -241,14 +232,13 @@ static int hts221_update_avg(struct hts221_hw *hw,
>  	const struct hts221_avg *avg = &hts221_avg_list[type];
>  
>  	for (i = 0; i < HTS221_AVG_DEPTH; i++)
> -		if (avg->avg_avl[i].avg == val)
> +		if (avg->avg_avl[i] == val)
>  			break;
>  
>  	if (i == HTS221_AVG_DEPTH)
>  		return -EINVAL;
>  
> -	err = hts221_write_with_mask(hw, avg->addr, avg->mask,
> -				     avg->avg_avl[i].val);
> +	err = hts221_write_with_mask(hw, avg->addr, avg->mask, i);
>  	if (err < 0)
>  		return err;
>  
> @@ -283,7 +273,7 @@ hts221_sysfs_rh_oversampling_avail(struct device *dev,
>  
>  	for (i = 0; i < ARRAY_SIZE(avg->avg_avl); i++)
>  		len += scnprintf(buf + len, PAGE_SIZE - len, "%d ",
> -				 avg->avg_avl[i].avg);
> +				 avg->avg_avl[i]);
>  	buf[len - 1] = '\n';
>  
>  	return len;
> @@ -300,7 +290,7 @@ hts221_sysfs_temp_oversampling_avail(struct device *dev,
>  
>  	for (i = 0; i < ARRAY_SIZE(avg->avg_avl); i++)
>  		len += scnprintf(buf + len, PAGE_SIZE - len, "%d ",
> -				 avg->avg_avl[i].avg);
> +				 avg->avg_avl[i]);
>  	buf[len - 1] = '\n';
>  
>  	return len;
> @@ -534,13 +524,13 @@ static int hts221_read_raw(struct iio_dev *iio_dev,
>  		case IIO_HUMIDITYRELATIVE:
>  			avg = &hts221_avg_list[HTS221_SENSOR_H];
>  			idx = hw->sensors[HTS221_SENSOR_H].cur_avg_idx;
> -			*val = avg->avg_avl[idx].avg;
> +			*val = avg->avg_avl[idx];
>  			ret = IIO_VAL_INT;
>  			break;
>  		case IIO_TEMP:
>  			avg = &hts221_avg_list[HTS221_SENSOR_T];
>  			idx = hw->sensors[HTS221_SENSOR_T].cur_avg_idx;
> -			*val = avg->avg_avl[idx].avg;
> +			*val = avg->avg_avl[idx];
>  			ret = IIO_VAL_INT;
>  			break;
>  		default:
> @@ -661,7 +651,7 @@ int hts221_probe(struct iio_dev *iio_dev)
>  		return err;
>  	}
>  
> -	data = hts221_avg_list[HTS221_SENSOR_H].avg_avl[3].avg;
> +	data = hts221_avg_list[HTS221_SENSOR_H].avg_avl[3];
>  	err = hts221_update_avg(hw, HTS221_SENSOR_H, data);
>  	if (err < 0) {
>  		dev_err(hw->dev, "failed to set rh oversampling ratio\n");
> @@ -676,7 +666,7 @@ int hts221_probe(struct iio_dev *iio_dev)
>  		return err;
>  	}
>  
> -	data = hts221_avg_list[HTS221_SENSOR_T].avg_avl[3].avg;
> +	data = hts221_avg_list[HTS221_SENSOR_T].avg_avl[3];
>  	err = hts221_update_avg(hw, HTS221_SENSOR_T, data);
>  	if (err < 0) {
>  		dev_err(hw->dev,

