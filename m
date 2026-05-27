Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DE63939B2
	for <linux-iio@vger.kernel.org>; Wed, 27 May 2026 11:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779879806; cv=none; b=NJrR2C3TbWl3wtxsqYAeGAiBu7Y1iy0o5+2NhN+GZ2keq3sKEmSEaGRn+Jw0rBgtNuB0ITT2gpHX41A70mJZQU7apMqCg5N4HPV8t3/wDu1TYkyrfL/g34NOIsykzwwz1xE4F4kii4QJ8W91f0jDaYW2Q6mYCa1TAe+rHoaYOq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779879806; c=relaxed/simple;
	bh=fEwbA6/g0lwGdaCfj955R1JwMVJvCdLGBf+cx0sn6zw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WayMuu6S5yHOzTH0jgi9p6izPfCnOBOAxfCM2o0Fgtq5Y7ozNTruWe6OcTNxlgOM0vr1yaC0wZpUpJblBQdRN1tMUkTn1v91Wl+AIAG9ZGEnTZjnKR4V2AWgomcnPyiShBttKuLVbh4sv7ehx0o0fUaKANhDhQ5JrmN9jKZsYmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ew5Tja7A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ew5Tja7A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390571F000E9;
	Wed, 27 May 2026 11:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779879804;
	bh=O1WFwnnIrV9sWSxWg8y1k9XvOcaZr2voP+dbxpN0uk4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ew5Tja7AgdVM8mC8+QC07sYTGdnK0fwRVfkeyxnPks8svIkgvVJAGy9SaJ2LAot9p
	 M3Zk4Mf5B3DiLgnKFGIX1ivdXAswwPPjoiC7iuyG05DMmQbKMkjvuB4eJlLC7Wqt99
	 Qr7N3CFrrWJFiNzjJawR7HGe1lSN3JigZnR7bSz3lJmTNaD62vSzgZqGhYCpthowiY
	 o+NipuW8FmA8ZUwPZ4Id7kcoaBr6ZsWma4xoQCsvdX4ewpeXsewejAbQ3AJvTWgNVx
	 65v1Nkdcbx5GrxGI5/orRKFiOi5W3q9SJb6RZvFUEaKRb09VZYwSwIafQIX8LmzSne
	 9LrAuJU1DywqA==
Date: Wed, 27 May 2026 12:03:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Louis Adamian <adamianlouis@gmail.com>
Cc: linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com
Subject: Re: [RFC PATCH 2/2] iio: pressure: ms5637: Add variant specific
 temperature compensation
Message-ID: <20260527120317.2632f44a@jic23-huawei>
In-Reply-To: <20260526185612.35048-4-adamianlouis@gmail.com>
References: <20260526185612.35048-2-adamianlouis@gmail.com>
	<20260526185612.35048-4-adamianlouis@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 May 2026 14:40:31 -0400
Louis Adamian <adamianlouis@gmail.com> wrote:

> Add correct temperature compensation for ms5637-30BA, MS5803-01BA,02BA,
> 05BA,14BA,30BA, MS5837-30BA. The temperature compensation formula is
> shared across these sensors but with different constants. Add
> ms_tp_comp_consts to capture these per-device differences. Add pressure
> variant specific pressure scale variable.
> 
> Signed-off-by: Louis Adamian <adamianlouis@gmail.com>
Hi Louis

https://sashiko.dev/#/patchset/20260526185612.35048-2-adamianlouis%40gmail.com
Has some feedback. I've not replicated it here but if you disagree with any of
it then reply to the original patch to say that.

The calculations need some datasheet references. Make sure to reference
both a doc and a named section to make them stable to updates etc (hopefully!)

A few other minor things from me inline. Mostly formatting related.

Welcome to IIO btw. Let this sit on the mailing list for at least 1 week before
doing a v2. That will allow other reviewers time to look and so hopefully 
reduce the number of revisions.  If you have any time to spare, look to review
other peoples' submissions on the list.  No problem if you don't have time
though!

Thanks,

Jonathan


> ---
>  .../iio/common/ms_sensors/ms_sensors_i2c.c    |  81 +++---
>  .../iio/common/ms_sensors/ms_sensors_i2c.h    |  47 +++
>  drivers/iio/pressure/ms5637.c                 | 273 ++++++++++++++++--
>  3 files changed, 351 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
> index 1960a2ce82a8..0798e7c9e0e8 100644
> --- a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
> +++ b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
> @@ -604,6 +604,39 @@ int ms_sensors_tp_read_prom(struct ms_tp_dev *dev_data)
>  }
>  EXPORT_SYMBOL_NS(ms_sensors_tp_read_prom, "IIO_MEAS_SPEC_SENSORS");
>  
> +/* apply second order temperature compensation */
> +static void ms_tp_compensate(const struct ms_tp_comp_consts *comp_consts,
> +			     s32 temp, s32 dt, s64 *t2, s64 *off2, s64 *sens2)
> +{
> +	if (temp < 2000) {
> +		s64 tmp = (s64)temp - 2000;

Blank line between declarations and rest of code.

> +		*t2 = (comp_consts->low_t2_multiplier * ((s64)dt * (s64)dt)) >>
> +		      comp_consts->low_t2_shift;
> +		*off2 = (comp_consts->low_off2_multiplier * tmp * tmp) >>
> +			comp_consts->low_off2_shift;
> +		*sens2 = (comp_consts->low_sens2_multiplier * tmp * tmp) >>
> +			 comp_consts->low_sens2_shift;
> +
> +		if (temp < -1500) {
> +			s64 tmp = (s64)temp + 1500;
> +			*off2 += comp_consts->vlow_off2_multiplier * tmp * tmp;
> +			*sens2 +=
> +				comp_consts->vlow_sens2_multiplier * tmp * tmp;
> +		}
> +	} else {
> +		if (comp_consts->has_vhigh_temp && temp > 4500) {
> +			*sens2 -= (((s64)temp - 4500) * ((s64)temp - 4500)) >>
> +				  3;
One thing I will point out that overlaps with sashiko.
sens2 is calculated here then 
> +		}
> +		*t2 = (comp_consts->high_t2_multiplier * ((s64)dt * (s64)dt)) >>
> +		      comp_consts->high_t2_shift;
> +		*off2 = (comp_consts->high_off2_multiplier *
> +			 ((s64)temp - 2000) * ((s64)temp - 2000)) >>
> +			comp_consts->high_off2_shift;
> +		*sens2 = 0;

zeroed here which implies something is wrong with the maths.

> +	}
> +}
> +
>  /**
>   * ms_sensors_read_temp_and_pressure() - read temp and pressure
>   * @dev_data:	pointer to temperature/pressure device data
> @@ -629,22 +662,18 @@ int ms_sensors_read_temp_and_pressure(struct ms_tp_dev *dev_data,
>  	delay = ms_sensors_tp_conversion_time[dev_data->res_index];
>  
>  	ret = ms_sensors_convert_and_read(
> -					dev_data->client,
> -					MS_SENSORS_TP_T_CONVERSION_START +
> -						dev_data->res_index * 2,
> -					MS_SENSORS_TP_ADC_READ,
> -					delay, &t_adc);
> +		dev_data->client,
> +		MS_SENSORS_TP_T_CONVERSION_START + dev_data->res_index * 2,
> +		MS_SENSORS_TP_ADC_READ, delay, &t_adc);
As below.

>  	if (ret) {
>  		mutex_unlock(&dev_data->lock);
>  		return ret;
>  	}
>  
>  	ret = ms_sensors_convert_and_read(
> -					dev_data->client,
> -					MS_SENSORS_TP_P_CONVERSION_START +
> -						dev_data->res_index * 2,
> -					MS_SENSORS_TP_ADC_READ,
> -					delay, &p_adc);
> +		dev_data->client,
> +		MS_SENSORS_TP_P_CONVERSION_START + dev_data->res_index * 2,
> +		MS_SENSORS_TP_ADC_READ, delay, &p_adc);


Don't reformat existing code in a patch that does anything else.
Makes it hard to see if anything changed when reviewing!
If you want to do such a reformat then it needs to be a separate patch
that doesn't do anything else.


>  	mutex_unlock(&dev_data->lock);
>  	if (ret)
>  		return ret;
> @@ -654,38 +683,24 @@ int ms_sensors_read_temp_and_pressure(struct ms_tp_dev *dev_data,
>  	/* Actual temperature = 2000 + dT * TEMPSENS */
>  	temp = 2000 + (((s64)dt * prom[6]) >> 23);
>  
> -	/* Second order temperature compensation */
> -	if (temp < 2000) {
> -		s64 tmp = (s64)temp - 2000;
> -
> -		t2 = (3 * ((s64)dt * (s64)dt)) >> 33;
> -		off2 = (61 * tmp * tmp) >> 4;
> -		sens2 = (29 * tmp * tmp) >> 4;
> -
> -		if (temp < -1500) {
> -			s64 tmp = (s64)temp + 1500;
> -
> -			off2 += 17 * tmp * tmp;
> -			sens2 += 9 * tmp * tmp;
> -		}
> -	} else {
> -		t2 = (5 * ((s64)dt * (s64)dt)) >> 38;
> -		off2 = 0;
> -		sens2 = 0;
> -	}
> +	ms_tp_compensate(dev_data->comp_consts, temp, dt, &t2, &off2, &sens2);
There is a lot of data_dev->comp_consts in here I'd be tempted to have
a much shorter named local variable. Perhaps even c
making this ms_tp_compensate(c, temp, dt, ...

That will help reduce line lengths in the maths that follows.

>  
>  	/* OFF = OFF_T1 + TCO * dT */
> -	off = (((s64)prom[2]) << 17) + ((((s64)prom[4]) * (s64)dt) >> 6);
> +	off = (((s64)prom[2]) << dev_data->comp_consts->off_t1_shift) +
> +	      ((((s64)prom[4]) * (s64)dt) >> dev_data->comp_consts->off_shift);
>  	off -= off2;
>  
>  	/* Sensitivity at actual temperature = SENS_T1 + TCS * dT */
> -	sens = (((s64)prom[1]) << 16) + (((s64)prom[3] * dt) >> 7);
> +	sens = (((s64)prom[1]) << dev_data->comp_consts->sens_t1_shift) +
> +	       (((s64)prom[3] * dt) >> dev_data->comp_consts->sens_shift);
>  	sens -= sens2;
>  
>  	/* Temperature compensated pressure = D1 * SENS - OFF */
>  	*temperature = (temp - t2) * 10;
> -	*pressure = (u32)(((((s64)p_adc * sens) >> 21) - off) >> 15);
> -
> +	*pressure = (u32)(((((s64)p_adc * sens) >>
> +			    dev_data->comp_consts->press_sens_shift) -
> +			   off) >>
> +			  dev_data->comp_consts->press_shift);
Where it helps readability it is fine to go a little long (just stay under 100 chars)


>  	return 0;
>  }
>  EXPORT_SYMBOL_NS(ms_sensors_read_temp_and_pressure, "IIO_MEAS_SPEC_SENSORS");


> diff --git a/drivers/iio/pressure/ms5637.c b/drivers/iio/pressure/ms5637.c
> index 59705a666979..b9a0be9b53cb 100644
> --- a/drivers/iio/pressure/ms5637.c
> +++ b/drivers/iio/pressure/ms5637.c
> @@ -33,11 +33,13 @@
>  struct ms_tp_data {
>  	const char *name;
>  	const struct ms_tp_hw_data *hw;
> +	const struct ms_tp_comp_consts *comp_consts;
>  };
>  
>  static const int ms5637_samp_freq[6] = { 960, 480, 240, 120, 60, 30 };
>  
> -static ssize_t ms5637_show_samp_freq(struct device *dev, struct device_attribute *attr, char *buf)
> +static ssize_t ms5637_show_samp_freq(struct device *dev,
> +				     struct device_attribute *attr, char *buf)

Don't rewrap code you aren't otherwise changing.  It might be a reasonable
change to make but not in code that does anything else as it just adds noise
to that patch.
	

>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ms_tp_dev *dev_data = iio_priv(indio_dev);
> @@ -73,8 +75,10 @@ static int ms5637_read_raw(struct iio_dev *indio_dev,
>  
>  			return IIO_VAL_INT;
>  		case IIO_PRESSURE:	/* in kPa */
> -			*val = pressure / 1000;
> -			*val2 = (pressure % 1000) * 1000;
> +			*val = pressure / dev_data->comp_consts->press_scale;
> +			*val2 = (pressure %
> +				 dev_data->comp_consts->press_scale) *
> +				dev_data->comp_consts->press_scale;
>  
>  			return IIO_VAL_INT_PLUS_MICRO;
>  		default:
> @@ -171,7 +175,7 @@ static int ms5637_probe(struct i2c_client *client)
>  	dev_data->res_index = data->hw->max_res_index;
>  	dev_data->hw = data->hw;
>  	mutex_init(&dev_data->lock);
> -
> +	dev_data->comp_consts = data->comp_consts;

I'd keep a blank line between code filling elements of dev_data and that
filling the indio_dev. So blank line here.


>  	indio_dev->info = &ms5637_info;
>  	indio_dev->name = data->name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> @@ -191,43 +195,278 @@ static int ms5637_probe(struct i2c_client *client)
>  	return devm_iio_device_register(&client->dev, indio_dev);
>  }
>  
> -static const struct ms_tp_hw_data ms5637_hw_data  = {
> -	.prom_len = 7,
> -	.max_res_index = 5
> +static const struct ms_tp_hw_data ms5637_hw_data = { .prom_len = 7,
> +						     .max_res_index = 5 };
> +
> +static const struct ms_tp_hw_data ms5803_hw_data = { .prom_len = 8,
> +						     .max_res_index = 4 };
> +
> +static const struct ms_tp_comp_consts ms5637_consts = {
> +	.high_t2_multiplier = 5,
> +	.high_t2_shift = 38,
> +	.high_off2_multiplier = 0,
> +	.high_off2_shift = 0,
> +	.low_t2_multiplier = 3,
> +	.low_t2_shift = 33,
> +	.low_off2_multiplier = 61,
> +	.low_off2_shift = 4,
> +	.low_sens2_multiplier = 29,
> +	.low_sens2_shift = 4,
> +	.vlow_off2_multiplier = 17,
> +	.vlow_sens2_multiplier = 9,
> +	.has_vhigh_temp = false,
> +	.off_t1_shift = 17,
> +	.off_shift = 6,
> +	.sens_t1_shift = 16,
> +	.sens_shift = 7,
> +	.press_sens_shift = 21,
> +	.press_shift = 15,
> +	.press_scale = 1000
> +};
> +
> +static const struct ms_tp_data ms5637_data = { .name = "ms5637",
> +					       .hw = &ms5637_hw_data,
> +					       .comp_consts = &ms5637_consts };
> +
> +static const struct ms_tp_comp_consts ms5637_30_consts = {
> +	.high_t2_multiplier = 2,
> +	.high_t2_shift = 37,
> +	.high_off2_multiplier = 1,
> +	.high_off2_shift = 4,
> +	.low_t2_multiplier = 3,
> +	.low_t2_shift = 33,
> +	.low_off2_multiplier = 3,
> +	.low_off2_shift = 1,
> +	.low_sens2_multiplier = 5,
> +	.low_sens2_shift = 3,
> +	.vlow_off2_multiplier = 7,
> +	.vlow_sens2_multiplier = 4,
> +	.has_vhigh_temp = false,
> +	.off_t1_shift = 16,
> +	.off_shift = 7,
> +	.sens_t1_shift = 15,
> +	.sens_shift = 8,
> +	.press_sens_shift = 21,
> +	.press_shift = 13,
> +	.press_scale = 100
>  };
>  
> -static const struct ms_tp_hw_data ms5803_hw_data  = {
> -	.prom_len = 8,
> -	.max_res_index = 4
> +static const struct ms_tp_data ms5637_30_data = { .name = "ms5637-30ba",
> +						  .hw = &ms5637_hw_data,
> +						  .comp_consts =
> +							  &ms5637_30_consts };
> +
> +static const struct ms_tp_data ms5803_data = { .name = "ms5803",
> +					       .hw = &ms5803_hw_data,
> +					       .comp_consts = &ms5637_consts };
> +
> +static const struct ms_tp_data ms5805_data = { .name = "ms5805",
> +					       .hw = &ms5637_hw_data,
> +					       .comp_consts = &ms5637_consts };
> +
> +static const struct ms_tp_data ms5837_data = { .name = "ms5837",
> +					       .hw = &ms5637_hw_data,
> +					       .comp_consts = &ms5637_consts };
> +
> +static const struct ms_tp_data ms8607_data = { .name = "ms8607-temppressure",
> +					       .hw = &ms5637_hw_data,
> +					       .comp_consts = &ms5637_consts };
> +
> +static const struct ms_tp_comp_consts ms5803_01_consts = {
> +	.high_t2_multiplier = 0,
> +	.high_t2_shift = 0,
> +	.high_off2_multiplier = 0,
> +	.high_off2_shift = 0,
> +	.low_t2_multiplier = 1,
> +	.low_t2_shift = 31,
> +	.low_off2_multiplier = 3,
> +	.low_off2_shift = 0,
> +	.low_sens2_multiplier = 7,
> +	.low_sens2_shift = 3,
> +	.vlow_off2_multiplier = 0,
> +	.vlow_sens2_multiplier = 2,
> +	.has_vhigh_temp = true,
> +	.off_t1_shift = 16,
> +	.off_shift = 7,
> +	.sens_t1_shift = 15,
> +	.sens_shift = 8,
> +	.press_sens_shift = 21,
> +	.press_shift = 15,
> +	.press_scale = 1000
>  };
>  
> -static const struct ms_tp_data ms5637_data = { .name = "ms5637", .hw = &ms5637_hw_data };
> +static const struct ms_tp_data ms5803_01_data = { .name = "ms5803-01ba",
> +						  .hw = &ms5803_hw_data,
> +						  .comp_consts =
> +							  &ms5803_01_consts };
> +
> +static const struct ms_tp_comp_consts ms5803_02_consts = {
> +	.high_t2_multiplier = 0,
> +	.high_t2_shift = 0,
> +	.high_off2_multiplier = 0,
> +	.high_off2_shift = 0,
> +	.low_t2_multiplier = 1,
> +	.low_t2_shift = 31,
> +	.low_off2_multiplier = 61,
> +	.low_off2_shift = 4,
> +	.low_sens2_multiplier = 2,
> +	.low_sens2_shift = 0,
> +	.vlow_off2_multiplier = 20,
> +	.vlow_sens2_multiplier = 12,
> +	.has_vhigh_temp = false,
> +	.off_t1_shift = 17,
> +	.off_shift = 6,
> +	.sens_t1_shift = 16,
> +	.sens_shift = 7,
> +	.press_sens_shift = 21,
> +	.press_shift = 15,
> +	.press_scale = 1000
> +};
>  
> -static const struct ms_tp_data ms5803_data = { .name = "ms5803", .hw = &ms5803_hw_data };
> +static const struct ms_tp_data ms5803_02_data = { .name = "ms5803-02ba",
> +						  .hw = &ms5803_hw_data,
> +						  .comp_consts =
> +							  &ms5803_02_consts };
> +
> +static const struct ms_tp_comp_consts ms5803_05_consts = {
> +	.high_t2_multiplier = 0,
> +	.high_t2_shift = 0,
> +	.high_off2_multiplier = 0,
> +	.high_off2_shift = 0,
> +	.low_t2_multiplier = 3,
> +	.low_t2_shift = 33,
> +	.low_off2_multiplier = 3,
> +	.low_off2_shift = 3,
> +	.low_sens2_multiplier = 7,
> +	.low_sens2_shift = 3,
> +	.vlow_off2_multiplier = 0,
> +	.vlow_sens2_multiplier = 3,
> +	.has_vhigh_temp = false,
> +	.off_t1_shift = 18,
> +	.off_shift = 5,
> +	.sens_t1_shift = 17,
> +	.sens_shift = 7,
> +	.press_sens_shift = 21,
> +	.press_shift = 15,
> +	.press_scale = 1000
> +};
>  
> -static const struct ms_tp_data ms5805_data = { .name = "ms5805", .hw = &ms5637_hw_data };
> +static const struct ms_tp_data ms5803_05_data = { .name = "ms5803-05ba",
> +						  .hw = &ms5803_hw_data,
> +						  .comp_consts =
> +							  &ms5803_05_consts };
> +
> +static const struct ms_tp_comp_consts ms5803_14_consts = {
> +	.high_t2_multiplier = 7,
> +	.high_t2_shift = 37,
> +	.high_off2_multiplier = 1,
> +	.high_off2_shift = 4,
> +	.low_t2_multiplier = 3,
> +	.low_t2_shift = 33,
> +	.low_off2_multiplier = 3,
> +	.low_off2_shift = 1,
> +	.low_sens2_multiplier = 5,
> +	.low_sens2_shift = 3,
> +	.vlow_off2_multiplier = 7,
> +	.vlow_sens2_multiplier = 4,
> +	.has_vhigh_temp = false,
> +	.off_t1_shift = 16,
> +	.off_shift = 7,
> +	.sens_t1_shift = 15,
> +	.sens_shift = 8,
> +	.press_sens_shift = 21,
> +	.press_shift = 15,
> +	.press_scale = 100
> +};
>  
> -static const struct ms_tp_data ms5837_data = { .name = "ms5837", .hw = &ms5637_hw_data };
> +static const struct ms_tp_data ms5803_14_data = { .name = "ms5803-14ba",
> +						  .hw = &ms5803_hw_data,
> +						  .comp_consts =
> +							  &ms5803_14_consts };
> +
> +static const struct ms_tp_comp_consts ms5803_30_consts = {
> +	.high_t2_multiplier = 7,
> +	.high_t2_shift = 37,
> +	.high_off2_multiplier = 1,
> +	.high_off2_shift = 4,
> +	.low_t2_multiplier = 3,
> +	.low_t2_shift = 33,
> +	.low_off2_multiplier = 3,
> +	.low_off2_shift = 1,
> +	.low_sens2_multiplier = 5,
> +	.low_sens2_shift = 3,
> +	.vlow_off2_multiplier = 7,
> +	.vlow_sens2_multiplier = 4,
> +	.has_vhigh_temp = false,
> +	.off_t1_shift = 16,
> +	.off_shift = 7,
> +	.sens_t1_shift = 15,
> +	.sens_shift = 8,
> +	.press_sens_shift = 21,
> +	.press_shift = 13,
> +	.press_scale = 100
> +};
>  
> -static const struct ms_tp_data ms8607_data = {
> -	.name = "ms8607-temppressure",
> -	.hw = &ms5637_hw_data,
> +static const struct ms_tp_data ms5803_30_data = { .name = "ms5803-30ba",
> +						  .hw = &ms5803_hw_data,
> +						  .comp_consts =
> +							  &ms5803_30_consts };
> +
> +static const struct ms_tp_comp_consts ms5837_30_consts = {
> +	.high_t2_multiplier = 7,
> +	.high_t2_shift = 37,
> +	.high_off2_multiplier = 1,
> +	.high_off2_shift = 4,
> +	.low_t2_multiplier = 3,
> +	.low_t2_shift = 33,
> +	.low_off2_multiplier = 3,
> +	.low_off2_shift = 1,
> +	.low_sens2_multiplier = 5,
> +	.low_sens2_shift = 3,
> +	.vlow_off2_multiplier = 7,
> +	.vlow_sens2_multiplier = 4,
> +	.has_vhigh_temp = false,
> +	.off_t1_shift = 16,
> +	.off_shift = 7,
> +	.sens_t1_shift = 15,
> +	.sens_shift = 8,
> +	.press_sens_shift = 21,
> +	.press_shift = 13,
> +	.press_scale = 100
>  };
>  
> +static const struct ms_tp_data ms5837_30_data = { .name = "ms5837-30ba",
> +						  .hw = &ms5803_hw_data,
> +						  .comp_consts =
> +							  &ms5837_30_consts };

Formatting is rather ugly. I'd do it as:
static const struct ms_tp_data ms5837_30_data = {
	.name = "ms5837-30ba",
	.hw = &ms5803_hw_data,
	.comp_consts = &ms5837_30_consts,
};

Similar for all the other cases above.


>  static const struct i2c_device_id ms5637_id[] = {
>  	{"ms5637", (kernel_ulong_t)&ms5637_data },
>  	{"ms5805", (kernel_ulong_t)&ms5805_data },
>  	{"ms5837", (kernel_ulong_t)&ms5837_data },
>  	{"ms8607-temppressure", (kernel_ulong_t)&ms8607_data },
> +	{"ms5803", (kernel_ulong_t)&ms5803_01_data },

Alphabetical order. 
Also this got refactored to use named initializers in a patch I took last week.
To make my life easy when I pick this up please base your next version on
the togreg branch of iio.git on kernel.org.  Note I don't normally ask
for this so only do it when specifically asked to.  Otherwise use rc1 of
the current cycle or last release kernel.

> +	{"ms5803-01ba", (kernel_ulong_t)&ms5803_01_data },
> +	{"ms5803-02ba", (kernel_ulong_t)&ms5803_02_data },
> +	{"ms5803-05ba", (kernel_ulong_t)&ms5803_05_data },
> +	{"ms5803-14ba", (kernel_ulong_t)&ms5803_14_data },
> +	{"ms5803-30ba", (kernel_ulong_t)&ms5803_30_data },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, ms5637_id);
>  
>  static const struct of_device_id ms5637_of_match[] = {
>  	{ .compatible = "meas,ms5637", .data = &ms5637_data },
> +	{ .compatible = "meas,ms5637-30ba", .data = &ms5637_30_data },
>  	{ .compatible = "meas,ms5803", .data = &ms5803_data },
> +	{ .compatible = "meas,ms5803-01ba", .data = &ms5803_01_data },
> +	{ .compatible = "meas,ms5803-02ba", .data = &ms5803_02_data },
> +	{ .compatible = "meas,ms5803-05ba", .data = &ms5803_05_data },
> +	{ .compatible = "meas,ms5803-14ba", .data = &ms5803_14_data },
> +	{ .compatible = "meas,ms5803-30ba", .data = &ms5803_30_data },
>  	{ .compatible = "meas,ms5805", .data = &ms5805_data },
>  	{ .compatible = "meas,ms5837", .data = &ms5837_data },
> +	{ .compatible = "meas,ms5837-30ba", .data = &ms5837_30_data },
>  	{ .compatible = "meas,ms8607-temppressure", .data = &ms8607_data },
>  	{ }
>  };

