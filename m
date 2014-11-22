Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40383 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878AbaKVMF4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 22 Nov 2014 07:05:56 -0500
Message-ID: <54707C21.70400@kernel.org>
Date: Sat, 22 Nov 2014 12:05:53 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Vlad Dogaru <vlad.dogaru@intel.com>, linux-iio@vger.kernel.org,
	knaack.h@gmx.de
Subject: Re: [PATCH] iio: bmp280: refactor compensation code
References: <20141117151621.GF6904@vdogaru> <1416484848-21889-1-git-send-email-vlad.dogaru@intel.com>
In-Reply-To: <1416484848-21889-1-git-send-email-vlad.dogaru@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/11/14 12:00, Vlad Dogaru wrote:
> This version of the code avoids extra memory copy operations and is
> somewhat smaller in code size.
> 
> Signed-off-by: Vlad Dogaru <vlad.dogaru@intel.com>
Thanks for doing this - I'm happy with the result, but would like to 
let Hartmut have a few days to take a look if he wants to so will
let it sit on the list for now.

Thanks,

Jonathan
> ---
>  drivers/iio/pressure/bmp280.c | 140 ++++++++++++++++--------------------------
>  1 file changed, 52 insertions(+), 88 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280.c b/drivers/iio/pressure/bmp280.c
> index 75038da..47dfd34 100644
> --- a/drivers/iio/pressure/bmp280.c
> +++ b/drivers/iio/pressure/bmp280.c
> @@ -80,16 +80,12 @@ struct bmp280_data {
>  	s32 t_fine;
>  };
>  
> -/* Compensation parameters. */
> -struct bmp280_comp_temp {
> -	u16 dig_t1;
> -	s16 dig_t2, dig_t3;
> -};
> -
> -struct bmp280_comp_press {
> -	u16 dig_p1;
> -	s16 dig_p2, dig_p3, dig_p4, dig_p5, dig_p6, dig_p7, dig_p8, dig_p9;
> -};
> +/*
> + * These enums are used for indexing into the array of compensation
> + * parameters.
> + */
> +enum { T1, T2, T3 };
> +enum { P1, P2, P3, P4, P5, P6, P7, P8, P9 };
>  
>  static const struct iio_chan_spec bmp280_channels[] = {
>  	{
> @@ -141,54 +137,6 @@ static const struct regmap_config bmp280_regmap_config = {
>  	.volatile_reg = bmp280_is_volatile_reg,
>  };
>  
> -static int bmp280_read_compensation_temp(struct bmp280_data *data,
> -					 struct bmp280_comp_temp *comp)
> -{
> -	int ret;
> -	__le16 buf[BMP280_COMP_TEMP_REG_COUNT / 2];
> -
> -	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_TEMP_START,
> -			       buf, BMP280_COMP_TEMP_REG_COUNT);
> -	if (ret < 0) {
> -		dev_err(&data->client->dev,
> -			"failed to read temperature calibration parameters\n");
> -		return ret;
> -	}
> -
> -	comp->dig_t1 = (u16) le16_to_cpu(buf[0]);
> -	comp->dig_t2 = (s16) le16_to_cpu(buf[1]);
> -	comp->dig_t3 = (s16) le16_to_cpu(buf[2]);
> -
> -	return 0;
> -}
> -
> -static int bmp280_read_compensation_press(struct bmp280_data *data,
> -					  struct bmp280_comp_press *comp)
> -{
> -	int ret;
> -	__le16 buf[BMP280_COMP_PRESS_REG_COUNT / 2];
> -
> -	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_PRESS_START,
> -			       buf, BMP280_COMP_PRESS_REG_COUNT);
> -	if (ret < 0) {
> -		dev_err(&data->client->dev,
> -			"failed to read pressure calibration parameters\n");
> -		return ret;
> -	}
> -
> -	comp->dig_p1 = (u16) le16_to_cpu(buf[0]);
> -	comp->dig_p2 = (s16) le16_to_cpu(buf[1]);
> -	comp->dig_p3 = (s16) le16_to_cpu(buf[2]);
> -	comp->dig_p4 = (s16) le16_to_cpu(buf[3]);
> -	comp->dig_p5 = (s16) le16_to_cpu(buf[4]);
> -	comp->dig_p6 = (s16) le16_to_cpu(buf[5]);
> -	comp->dig_p7 = (s16) le16_to_cpu(buf[6]);
> -	comp->dig_p8 = (s16) le16_to_cpu(buf[7]);
> -	comp->dig_p9 = (s16) le16_to_cpu(buf[8]);
> -
> -	return 0;
> -}
> -
>  /*
>   * Returns temperature in DegC, resolution is 0.01 DegC.  Output value of
>   * "5123" equals 51.23 DegC.  t_fine carries fine temperature as global
> @@ -197,16 +145,33 @@ static int bmp280_read_compensation_press(struct bmp280_data *data,
>   * Taken from datasheet, Section 3.11.3, "Compensation formula".
>   */
>  static s32 bmp280_compensate_temp(struct bmp280_data *data,
> -				  struct bmp280_comp_temp *comp,
>  				  s32 adc_temp)
>  {
> +	int ret;
>  	s32 var1, var2, t;
> +	__le16 buf[BMP280_COMP_TEMP_REG_COUNT / 2];
> +
> +	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_TEMP_START,
> +			       buf, BMP280_COMP_TEMP_REG_COUNT);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev,
> +			"failed to read temperature calibration parameters\n");
> +		return ret;
> +	}
>  
> -	var1 = (((adc_temp >> 3) - ((s32) comp->dig_t1 << 1)) *
> -		((s32) comp->dig_t2)) >> 11;
> -	var2 = (((((adc_temp >> 4) - ((s32) comp->dig_t1)) *
> -		  ((adc_temp >> 4) - ((s32) comp->dig_t1))) >> 12) *
> -		((s32) comp->dig_t3)) >> 14;
> +	/*
> +	 * The double casts are necessary because le16_to_cpu returns an
> +	 * unsigned 16-bit value.  Casting that value directly to a
> +	 * signed 32-bit will not do proper sign extension.
> +	 *
> +	 * Conversely, T1 and P1 are unsigned values, so they can be
> +	 * cast straight to the larger type.
> +	 */
> +	var1 = (((adc_temp >> 3) - ((s32)le16_to_cpu(buf[T1]) << 1)) *
> +		((s32)(s16)le16_to_cpu(buf[T2]))) >> 11;
> +	var2 = (((((adc_temp >> 4) - ((s32)le16_to_cpu(buf[T1]))) *
> +		  ((adc_temp >> 4) - ((s32)le16_to_cpu(buf[T1])))) >> 12) *
> +		((s32)(s16)le16_to_cpu(buf[T3]))) >> 14;
>  
>  	data->t_fine = var1 + var2;
>  	t = (data->t_fine * 5 + 128) >> 8;
> @@ -222,27 +187,36 @@ static s32 bmp280_compensate_temp(struct bmp280_data *data,
>   * Taken from datasheet, Section 3.11.3, "Compensation formula".
>   */
>  static u32 bmp280_compensate_press(struct bmp280_data *data,
> -				   struct bmp280_comp_press *comp,
>  				   s32 adc_press)
>  {
> +	int ret;
>  	s64 var1, var2, p;
> +	__le16 buf[BMP280_COMP_PRESS_REG_COUNT / 2];
> +
> +	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_PRESS_START,
> +			       buf, BMP280_COMP_PRESS_REG_COUNT);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev,
> +			"failed to read pressure calibration parameters\n");
> +		return ret;
> +	}
>  
> -	var1 = ((s64) data->t_fine) - 128000;
> -	var2 = var1 * var1 * (s64) comp->dig_p6;
> -	var2 = var2 + ((var1 * (s64) comp->dig_p5) << 17);
> -	var2 = var2 + (((s64) comp->dig_p4) << 35);
> -	var1 = ((var1 * var1 * (s64) comp->dig_p3) >> 8) +
> -		((var1 * (s64) comp->dig_p2) << 12);
> -	var1 = (((((s64) 1) << 47) + var1)) * ((s64) comp->dig_p1) >> 33;
> +	var1 = ((s64)data->t_fine) - 128000;
> +	var2 = var1 * var1 * (s64)(s16)le16_to_cpu(buf[P6]);
> +	var2 = var2 + ((var1 * (s64)(s16)le16_to_cpu(buf[P5])) << 17);
> +	var2 = var2 + (((s64)(s16)le16_to_cpu(buf[P4])) << 35);
> +	var1 = ((var1 * var1 * (s64)(s16)le16_to_cpu(buf[P3])) >> 8) +
> +		((var1 * (s64)(s16)le16_to_cpu(buf[P2])) << 12);
> +	var1 = ((((s64)1) << 47) + var1) * ((s64)le16_to_cpu(buf[P1])) >> 33;
>  
>  	if (var1 == 0)
>  		return 0;
>  
> -	p = ((((s64) 1048576 - adc_press) << 31) - var2) * 3125;
> +	p = ((((s64)1048576 - adc_press) << 31) - var2) * 3125;
>  	p = div64_s64(p, var1);
> -	var1 = (((s64) comp->dig_p9) * (p >> 13) * (p >> 13)) >> 25;
> -	var2 = (((s64) comp->dig_p8) * p) >> 19;
> -	p = ((p + var1 + var2) >> 8) + (((s64) comp->dig_p7) << 4);
> +	var1 = (((s64)(s16)le16_to_cpu(buf[P9])) * (p >> 13) * (p >> 13)) >> 25;
> +	var2 = (((s64)(s16)le16_to_cpu(buf[P8])) * p) >> 19;
> +	p = ((p + var1 + var2) >> 8) + (((s64)(s16)le16_to_cpu(buf[P7])) << 4);
>  
>  	return (u32) p;
>  }
> @@ -253,11 +227,6 @@ static int bmp280_read_temp(struct bmp280_data *data,
>  	int ret;
>  	__be32 tmp = 0;
>  	s32 adc_temp, comp_temp;
> -	struct bmp280_comp_temp comp;
> -
> -	ret = bmp280_read_compensation_temp(data, &comp);
> -	if (ret < 0)
> -		return ret;
>  
>  	ret = regmap_bulk_read(data->regmap, BMP280_REG_TEMP_MSB,
>  			       (u8 *) &tmp, 3);
> @@ -267,7 +236,7 @@ static int bmp280_read_temp(struct bmp280_data *data,
>  	}
>  
>  	adc_temp = be32_to_cpu(tmp) >> 12;
> -	comp_temp = bmp280_compensate_temp(data, &comp, adc_temp);
> +	comp_temp = bmp280_compensate_temp(data, adc_temp);
>  
>  	/*
>  	 * val might be NULL if we're called by the read_press routine,
> @@ -288,11 +257,6 @@ static int bmp280_read_press(struct bmp280_data *data,
>  	__be32 tmp = 0;
>  	s32 adc_press;
>  	u32 comp_press;
> -	struct bmp280_comp_press comp;
> -
> -	ret = bmp280_read_compensation_press(data, &comp);
> -	if (ret < 0)
> -		return ret;
>  
>  	/* Read and compensate temperature so we get a reading of t_fine. */
>  	ret = bmp280_read_temp(data, NULL);
> @@ -307,7 +271,7 @@ static int bmp280_read_press(struct bmp280_data *data,
>  	}
>  
>  	adc_press = be32_to_cpu(tmp) >> 12;
> -	comp_press = bmp280_compensate_press(data, &comp, adc_press);
> +	comp_press = bmp280_compensate_press(data, adc_press);
>  
>  	*val = comp_press;
>  	*val2 = 256000;
> 

