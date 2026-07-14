Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A7B367F4A;
	Tue, 14 Jul 2026 11:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784028050; cv=none; b=UaII+ALtGb/mzbcBCOFnMKgGJTFeDt/UHR8Z2s3dCUxA+ttvtraU6LwF+OOzKwzqy85Q9JdsQdTEKaZrqgZJl53cQgEOQ82TckcGKHPzpI5V6UVN2kJ+EBzSZkvRkEI0XhQkYmxO8RguoQP+XmN6ALXoBEZtZqbhbp5TGYA2twA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784028050; c=relaxed/simple;
	bh=9v0u859gKTDMwsrTcTlpmsV2knq/Ux1QRTk6GRNLP/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UwnRLb6Uci0oSLT5SStNTp2Ghi2Img2kiZj9uSrr0Op9ODW9nb9YWh8N7ZeZHBQAXqLn3Em4YWOHJQKgfiXlM7lyzi7UPuzvZ8/XWvjN83M1ZN+uecwpoM9gTiOsTH9IjHi2I6vTN03DNwCMtkAo1dnco1xJIj41hnzQcvscEJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YoRIV+rw; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YoRIV+rw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784028049; x=1815564049;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9v0u859gKTDMwsrTcTlpmsV2knq/Ux1QRTk6GRNLP/Y=;
  b=YoRIV+rwRVuUuW77oRfvBY9sO0xNpWKuuMJkjNQa3M7gus1bzc49YD27
   +WIsvLGaPG9y8/WRCSCvuP5ZR9551VQq8sKM9QLysksJ0FTEW+VF8eUTZ
   PpMSvtojnJ5OST5zJWGEzghMJTq6qGpoxvWqeHFJ3Rf/dhYhdTLFZ8gk1
   Pl/dx1RBydeSLTMCuiXk7VANhoHpN2R7YEolISljN1BbOk3ljhyd3LQUY
   XTwB02CeygxeLR4ycMlYJLDQwZIAH0QOwxxlUfXPpPEnFXRk7u3s9DuH1
   YZ4vpz5ueAQVCrfFfhX1vdablr5R7UQKYAiKRr+n04+WSY4ndNGjUZZZA
   A==;
X-CSE-ConnectionGUID: Tool9qOIQ+qEgtgE50C4pA==
X-CSE-MsgGUID: QrvuceX2RiG9d6Jssc41Zw==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="95293563"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="95293563"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 04:20:48 -0700
X-CSE-ConnectionGUID: 2cPIwIgPQ+6NuMrvIVeviQ==
X-CSE-MsgGUID: HCBcASgMSe+PI2JxmdSJYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="260719014"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.189])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 04:20:45 -0700
Date: Tue, 14 Jul 2026 14:20:43 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
	dlechner@baylibre.com, jic23@kernel.org,
	jean-baptiste.maneyrol@tdk.com, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH v16 07/10] iio: imu: inv_icm42607: Add Accelerometer for
 icm42607
Message-ID: <alYbi_Bp0wVOlJ1i@ashevche-desk.local>
References: <20260713215842.69097-1-macroalpha82@gmail.com>
 <20260713215842.69097-8-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713215842.69097-8-macroalpha82@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 13, 2026 at 04:58:37PM -0500, Chris Morgan wrote:

> Add icm42607 accelerometer sensor for icm42607.

...

> +#define INV_ICM42607_ACCEL_CHAN(_modifier, _index, _ext_info)			\

> +{										\

You can also make it a compound literal, so it will be possible to use in the
assignments at run-time (maybe not needed).

(struct iio_chan_spec) {

But again, it's up to you.

> +	.type = IIO_ACCEL,							\
> +	.modified = 1,								\
> +	.channel2 = _modifier,							\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),				\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),			\
> +	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE),		\
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
> +	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +	.scan_index = _index,							\
> +	.scan_type = {								\
> +		.sign = 's',							\
> +		.realbits = 16,							\
> +		.storagebits = 16,						\
> +		.endianness = IIO_BE,						\
> +	},									\
> +	.ext_info = _ext_info,							\
> +}

...

> +static int inv_icm42607_accel_write_scale(struct iio_dev *indio_dev,
> +					  int val, int val2)
> +{
> +	struct inv_icm42607_sensor_conf conf = INV_ICM42607_SENSOR_CONF_INIT;
> +	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
> +	size_t scales_len = ARRAY_SIZE(inv_icm42607_accel_scale_nano);
> +	struct device *dev = regmap_get_device(st->map);
> +	unsigned int idx;
> +	int ret;
> +
> +	for (idx = 0; idx < scales_len; idx++) {
> +		if (val == inv_icm42607_accel_scale_nano[idx][0] &&
> +		    val2 == inv_icm42607_accel_scale_nano[idx][1])
> +			break;
> +	}
> +	if (idx >= scales_len)

'==' should suffice, otherwise it will be an interesting case.

> +		return -EINVAL;
> +
> +	conf.fs = idx;
> +
> +	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
> +	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	return inv_icm42607_set_sensor_conf(st, &conf, IIO_ACCEL);
> +}

...

> +static int inv_icm42607_accel_read_odr(struct inv_icm42607_state *st,
> +				       int *val, int *val2)
> +{
> +	unsigned int odr;
> +	unsigned int i;
> +
> +	guard(mutex)(&st->lock);
> +
> +	odr = st->conf.accel.odr;
> +
> +	for (i = INV_ICM42607_ODR_1600HZ; i < ARRAY_SIZE(inv_icm42607_accel_odr); i++) {
> +		if (i == odr)
> +			break;
> +	}
> +	if (i >= ARRAY_SIZE(inv_icm42607_accel_odr))
> +		return -EINVAL;

Ditto. And so on.

> +	*val = inv_icm42607_accel_odr[i][0];
> +	*val2 = inv_icm42607_accel_odr[i][1];
> +
> +	return IIO_VAL_INT_PLUS_MICRO;
> +}

...

> +struct iio_dev *inv_icm42607_accel_init(struct inv_icm42607_state *st)
> +{
> +	struct device *dev = regmap_get_device(st->map);
> +	struct inv_icm42607_sensor_state *accel_st;
> +	struct iio_dev *indio_dev;
> +	const char *name;
> +	int ret;
> +
> +	name = devm_kasprintf(dev, GFP_KERNEL, "%s-accel", st->hw->name);
> +	if (!name)
> +		return ERR_PTR(-ENOMEM);
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*accel_st));
> +	if (!indio_dev)
> +		return ERR_PTR(-ENOMEM);

> +	accel_st = iio_priv(indio_dev);
> +

Move this blank line to be above on the previous assignment.

> +	accel_st->power_mode = INV_ICM42607_SENSOR_MODE_LOW_NOISE;
> +	accel_st->filter = INV_ICM42607_FILTER_BW_73HZ;

> +
> +	iio_device_set_drvdata(indio_dev, st);

And here I would rather move this line to be after the all assignments, so we
won't have the potential code that might use unfilled data in between.

> +	indio_dev->name = name;
> +	indio_dev->info = &inv_icm42607_accel_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = inv_icm42607_accel_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(inv_icm42607_accel_channels);
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	return indio_dev;
> +}

...

> +static void inv_icm42607_update_config(struct inv_icm42607_sensor_conf *conf,
> +				       struct inv_icm42607_sensor_conf *oldconf,
> +				       bool *config0, bool *config1)
> +{
> +	if (conf->mode < 0)
> +		conf->mode = oldconf->mode;
> +	if (conf->fs < 0)
> +		conf->fs = oldconf->fs;
> +	if (conf->odr < 0)
> +		conf->odr = oldconf->odr;
> +	if (conf->filter < 0)
> +		conf->filter = oldconf->filter;

> +	if (conf->fs != oldconf->fs || conf->odr != oldconf->odr)
> +		*config0 = true;
> +	else
> +		*config0 = false;

Can be simply

	*config0 = (conf->fs != oldconf->fs) || (conf->odr != oldconf->odr);

(I added parentheses for better reading of this expression to make it clear
 that the recipient is a boolean.)

> +	if (conf->filter != oldconf->filter)
> +		*config1 = true;
> +	else
> +		*config1 = false;

In the similar way.

> +}

...

> +int inv_icm42607_read_sensor(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     s16 *val)
> +{
> +	struct inv_icm42607_sensor_conf conf = INV_ICM42607_SENSOR_CONF_INIT;
> +	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
> +	struct inv_icm42607_sensor_state *sensor_st = iio_priv(indio_dev);
> +	struct device *dev = regmap_get_device(st->map);
> +	unsigned int reg;

> +	u8 data[2];

Define using the correct type. AFAICS it should be __be16 data;

> +	int ret;
> +
> +	if ((chan->type != IIO_ANGL_VEL) && (chan->type != IIO_ACCEL))
> +		return -EINVAL;
> +
> +	switch (chan->channel2) {
> +	case IIO_MOD_X:
> +		if (chan->type == IIO_ANGL_VEL)
> +			reg = INV_ICM42607_REG_GYRO_DATA_X1;
> +		else
> +			reg = INV_ICM42607_REG_ACCEL_DATA_X1;
> +		break;
> +	case IIO_MOD_Y:
> +		if (chan->type == IIO_ANGL_VEL)
> +			reg = INV_ICM42607_REG_GYRO_DATA_Y1;
> +		else
> +			reg = INV_ICM42607_REG_ACCEL_DATA_Y1;
> +		break;
> +	case IIO_MOD_Z:
> +		if (chan->type == IIO_ANGL_VEL)
> +			reg = INV_ICM42607_REG_GYRO_DATA_Z1;
> +		else
> +			reg = INV_ICM42607_REG_ACCEL_DATA_Z1;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
> +	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	/* enable sensor */
> +	conf.mode = sensor_st->power_mode;
> +	conf.filter = sensor_st->filter;
> +	ret = inv_icm42607_set_sensor_conf(st, &conf, chan->type);
> +	if (ret)
> +		return ret;
> +
> +	/* read sensor register data */
> +	ret = regmap_bulk_read(st->map, reg, data, sizeof(data));
> +	if (ret)
> +		return ret;
> +
> +	*val = get_unaligned_be16(data);
> +	if (*val == INV_ICM42607_DATA_INVALID)
> +		return -EINVAL;
> +
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko


