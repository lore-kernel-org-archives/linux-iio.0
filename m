Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676AA2BF3F3;
	Sat,  5 Sep 2026 00:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788568647; cv=none; b=u1fVoBwuG5K2rpN8dvyiI0/7KfP3QHczd8o/hO4IX5I48B8nlc6tFwX51tapOYR5pzhrl7c+8UrUHrM8PkC8G4aFeO+FadCjd+Z6hz4oVuvsgrNaqwu5plUxupZ44B9DipCgEvw5ba8+LdZnoPRAtUj7xM5NW2bXwY33xSEgDaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788568647; c=relaxed/simple;
	bh=rP5XYW671OA2+XshADuIxpHnyz115Q+XW0gMeibjV7E=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=SHNGJWxR2Aa5birQYRx4hB6DkHy+2tCLEACmv6szguUx1FkgrJh0iUFfC8h2qrUOYvCcEXYc66hM8ry7+FzzKJDahdjawVUQV3yzgz967LQMBH9d1UH3pvtuXgC+gopT0d2ONk5QPtGJGBYbEjmUf/D2GdDHjfusLJDS8D1CU7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QEPw9S7M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QEPw9S7M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 437731F00A3D;
	Sat,  5 Sep 2026 00:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788568645;
	bh=knWGRjrNEV1pqUIsPMbxi299kkGTxQObAxOaMnBNIlQ=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=QEPw9S7MJMNe8Et2N6b8Q6FJ+blCnp5MekTW/Ygorg8MFFDSmL5uWMAKVbQTRDJBy
	 NSP31vlamMhnm+EsYxBcrl0AxBqKVDtsCT4n2KHxKHgO2k7vToRk3PZLZPzwzGGyfQ
	 7lDWzKjXzHvTkjBblbbmy1BJkYvcM2DZF4ovM9sZ11hzfSZh1Bm5wvCn2GlcU2eh8H
	 3RKS1VlZjPZPRKMBErpCVbB4DqNJmTJg/xJEz54piuXbRCC6D6OZBQU5z3Ubk3xHeh
	 ZvHCt/L6dRkUMdH4WXunRtzsNMUSj0GeOwBRoO7v6sQVsrP3+HJA9c21ZMSJzpkkD4
	 2gzIJVlOjEBBw==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 3/3] iio: adc: ti-ads112c14: add continuous mode
 support
From: Jonathan Cameron <jic23@kernel.org>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Chris Hall <c-hall@ti.com>, 
 Patrick Edwards <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260831-iio-adc-ti-ads112c14-continuous-mode-v5-3-76f80a04b94f@baylibre.com>
References: <20260831-iio-adc-ti-ads112c14-continuous-mode-v5-0-76f80a04b94f@baylibre.com>
 <20260831-iio-adc-ti-ads112c14-continuous-mode-v5-3-76f80a04b94f@baylibre.com>
Date: Sat, 05 Sep 2026 01:37:00 +0100
Message-Id: <178856862063.3402141.10770364495792875215.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9475;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=rP5XYW671OA2+XshADuIxpHnyz115Q+XW0gMeibjV7E=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqm2Qv4m8D9QM4wV+CdlXcwl652+u3M5XcuOhyn
 PI0s4I5ipGJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCaptkLxEcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiPkhEAC8yMOU/XDv/shJB3a94RR0yR5aqxh2byrFddVWb3bpZ7b
 De03nLAlX7rIpNoB9IhDnyTmYOypXzZW3BXcA7gOt8yeHdr5JMCRqj+GJgNpsvayYp8oJ0aYoTu
 p4fKLic3amYG5r0/9KhtY0NeSHD/3f0OZ/xBWopkaf57FQn87kRgf9WHP19jj/Y3QV3kRKiTO2H
 oNw1jh7S6VEt6yVADKNsc5GLEneqVkxILtevav9025IbRRMQ8I4pwtIKh27r+e4oIGixyWj/ngc
 7XsJyap8bZN/X4F7akA8DdTPnfMp+2h69vFPDuMGTyJ6+S6Mdd70gK4O+zQBn3bhrwWJ2tHx4Rp
 4QQJ3GqQfipDpjtoqpmSkzi9UKuYT3M0FB8dN/82X31fJ92mEjqttss8pGAyXw2Xb1xcxARRFOP
 OmSe96B7gNpOv8jY2ADy/84W9gmHZKff1FNYZzJCFwr9DWFwpQU/5NhG43+4mUEGcvxN9FLfMlC
 q3bQlcIUIhyvTHEuZizoMeMiWz3fl+O2NWJRC7b1i3VHoelm94IWmbPY+xHGJZIIx0XALxmwVuz
 bwLgK87zABEZttmPSrQqJnhmIrcdy4erk09R9yKHXVmdQQqFBWjg3+IXxP05UfpPAmdHnbrzxei
 mVkz8jwSvcaMxqBrIpJlhTnOFokrJcEuNKsjTyg==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> Add support for continuous mode in the TI ADS112C14 ADC driver. In this
> mode the ADC itself is starting each conversion, so we add a trigger
> based on the DRDY interrupt to read each sample. This mode is also
> limited in that only one channel can be enabled at a time since the
> chip does not have a sequencer or simultaneous sampling capability.
> Continuous mode will only be used when this new trigger is the current
> trigger.
> 
> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>

Hi David,

One valid looking sashiko comment that I think justifies a
registration ordering change and some musings from me.

>
> diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
> index 23f15be303fb..06b962fbde5e 100644
> --- a/drivers/iio/adc/ti-ads112c14.c
> +++ b/drivers/iio/adc/ti-ads112c14.c
> @@ -9,6 +9,7 @@
>   */
>  
>  #include <linux/bitfield.h>
> +#include <linux/bitmap.h>
>  #include <linux/cleanup.h>
>  #include <linux/completion.h>
>  #include <linux/crc8.h>
> @@ -18,6 +19,7 @@
>  #include <linux/i2c.h>
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/iio.h>
> +#include <linux/iio/trigger.h>
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/triggered_buffer.h>
>  #include <linux/interrupt.h>
> @@ -257,10 +259,12 @@ struct ads112c14_measurement {
>  struct ads112c14_data {
>  	const struct ads112c14_chip_info *chip_info;
>  	struct regmap *regmap;
> +	struct iio_trigger *drdy_trig;
>  	/* Synchronizes access to register value fields. */
>  	struct mutex lock;
>  	int drdy_irq;
>  	struct completion drdy_completion;
> +	bool continuous_mode;
>  	bool i2c_crc_enabled;
>  	u32 avdd_uV;
>  	u32 ext_ref_uV;
> @@ -280,11 +284,18 @@ static irqreturn_t ads112c14_drdy_irq_handler(int irq, void *private)
>  	struct iio_dev *indio_dev = private;
>  	struct ads112c14_data *data = iio_priv(indio_dev);
>  
> -	complete(&data->drdy_completion);
> +	if (READ_ONCE(data->continuous_mode))
> +		iio_trigger_poll(data->drdy_trig);

Sashiko (combined with more below)
[Severity: High]
If the IRQ handler is executed after the trigger has been freed during driver
teardown, could this result in a use-after-free on data->drdy_trig?

> +	else
> +		complete(&data->drdy_completion);
>  
>  	return IRQ_HANDLED;
>  }
>  
> +static const struct iio_trigger_ops ads112c14_trigger_ops = {
> +	.validate_device = iio_trigger_validate_own_device,
> +};
> +
>  static bool ads112c14_writeable_reg(struct device *dev, unsigned int reg)
>  {
>  	switch (reg) {
> @@ -695,6 +706,13 @@ static int ads112c14_single_conversion(struct ads112c14_data *data,
>  					data->i2c_crc_enabled);
>  }
>  
> +static bool ads112c14_using_drdy_trigger(struct iio_dev *indio_dev)
> +{
> +	struct ads112c14_data *data = iio_priv(indio_dev);
> +
> +	return data->drdy_trig && indio_dev->trig == data->drdy_trig;
> +}
> +
>  static int ads112c14_read_raw(struct iio_dev *indio_dev,
>  			      struct iio_chan_spec const *chan,
>  			      int *val, int *val2, long mask)
> @@ -898,6 +916,19 @@ static int ads112c14_write_raw_get_fmt(struct iio_dev *indio_dev,
>  	}
>  }
>  
> +static int ads112c14_update_scan_mode(struct iio_dev *indio_dev,
> +				      const unsigned long *scan_mask)
> +{
> +	/* Only continuous mode is limited to a single channel. */
> +	if (!ads112c14_using_drdy_trigger(indio_dev))
> +		return 0;
> +
> +	if (!iio_validate_scan_mask_onehot(indio_dev, scan_mask))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>  static int ads112c14_debugfs_reg_access(struct iio_dev *indio_dev,
>  					unsigned int reg,
>  					unsigned int writeval,
> @@ -952,6 +983,19 @@ static int ads112c14_read_label(struct iio_dev *indio_dev,
>  	return sysfs_emit(label, "%s\n", label_source);
>  }
>  
> +static const struct iio_chan_spec *
> +ads112c14_first_active_channel(struct iio_dev *indio_dev)
> +{
> +	unsigned int scan_mask_len = iio_get_masklength(indio_dev);
> +	unsigned int i;
> +
> +	i = find_first_bit(indio_dev->active_scan_mask, scan_mask_len);
> +	if (i == scan_mask_len)
> +		return NULL;
> +
> +	return &indio_dev->channels[i];
> +}
> +
>  static irqreturn_t ads112c14_trigger_handler(int irq, void *private)
>  {
>  	struct iio_poll_func *pf = private;
> @@ -961,6 +1005,26 @@ static irqreturn_t ads112c14_trigger_handler(int irq, void *private)
>  	u32 i;
>  	int ret;
>  
> +	if (ads112c14_using_drdy_trigger(indio_dev)) {
> +		const struct iio_chan_spec *chan;
> +
> +		chan = ads112c14_first_active_channel(indio_dev);
> +		if (!chan)
> +			goto out;
> +
> +		ret = ads112c14_scan_read(data, (u8 *)&data->scan[0]);
> +		if (ret) {
> +			dev_err_once(indio_dev->dev.parent,
> +				     "failed to read channel %d: %pe; additional errors will be suppressed\n",
> +				     chan->channel, ERR_PTR(ret));
> +			goto out;
> +		}
> +
> +		iio_push_to_buffers_with_ts(indio_dev, data->scan,
> +					    sizeof(data->scan), pf->timestamp);
> +		goto out;
> +	}
> +
>  	iio_for_each_active_channel(indio_dev, i) {
>  		const struct iio_chan_spec *chan = &indio_dev->channels[i];
>  
> @@ -988,10 +1052,81 @@ static const struct iio_info ads112c14_info = {
>  	.read_avail = ads112c14_read_avail,
>  	.write_raw = ads112c14_write_raw,
>  	.write_raw_get_fmt = ads112c14_write_raw_get_fmt,
> +	.update_scan_mode = ads112c14_update_scan_mode,
>  	.debugfs_reg_access = ads112c14_debugfs_reg_access,
>  	.read_label = ads112c14_read_label,
>  };
>  
> +static int ads112c14_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct ads112c14_data *data = iio_priv(indio_dev);
> +	const struct iio_chan_spec *chan;
> +	int ret;
> +
> +	if (!ads112c14_using_drdy_trigger(indio_dev))
> +		return 0;
> +
> +	chan = ads112c14_first_active_channel(indio_dev);
> +	if (!chan)
> +		return -EINVAL;
> +
> +	guard(mutex)(&data->lock);
> +
> +	ret = ads112c14_prepare_channel(data, chan);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(data->regmap, ADS112C14_REG_DEVICE_CFG,
> +				 ADS112C14_DEVICE_CFG_CONV_MODE,
> +				 FIELD_PREP(ADS112C14_DEVICE_CFG_CONV_MODE,
> +					    ADS112C14_DEVICE_CFG_CONV_MODE_CONTINUOUS));
> +	if (ret)
> +		return ret;
> +
> +	WRITE_ONCE(data->continuous_mode, true);
> +
> +	ret = regmap_write(data->regmap, ADS112C14_REG_CONVERSION_CTRL,
> +			   ADS112C14_CONVERSION_CTRL_START);
> +	if (ret) {
> +		WRITE_ONCE(data->continuous_mode, false);

This write then reset both under WRITE_ONCE() means that the interrupt
controller could race against this. However this is all in a path
where I don't think that can happen in practice.

> +		regmap_update_bits(data->regmap, ADS112C14_REG_DEVICE_CFG,
> +				   ADS112C14_DEVICE_CFG_CONV_MODE,
> +				   FIELD_PREP(ADS112C14_DEVICE_CFG_CONV_MODE,
> +					      ADS112C14_DEVICE_CFG_CONV_MODE_SINGLE_SHOT));
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ads112c14_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	struct ads112c14_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (!ads112c14_using_drdy_trigger(indio_dev))
> +		return 0;
> +
> +	guard(mutex)(&data->lock);
> +
> +	WRITE_ONCE(data->continuous_mode, false);
> +
> +	ret = regmap_write(data->regmap, ADS112C14_REG_CONVERSION_CTRL,
> +			   ADS112C14_CONVERSION_CTRL_STOP);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_update_bits(data->regmap, ADS112C14_REG_DEVICE_CFG,
> +				  ADS112C14_DEVICE_CFG_CONV_MODE,
> +				  FIELD_PREP(ADS112C14_DEVICE_CFG_CONV_MODE,
> +					     ADS112C14_DEVICE_CFG_CONV_MODE_SINGLE_SHOT));
> +}
> +
> +static const struct iio_buffer_setup_ops ads112c14_buffer_setup_ops = {
> +	.postenable = ads112c14_buffer_postenable,
> +	.predisable = ads112c14_buffer_predisable,
> +};
> +
>  static int ads112c14_populate_idac_mag(u32 current_nA, u8 *idac_mag)
>  {
>  	u32 current_uA = current_nA / (NANO / MICRO);
> @@ -1480,6 +1615,19 @@ static int ads112c14_probe(struct i2c_client *client)
>  				       0, dev_name(dev), indio_dev);
>  		if (ret)
>  			return ret;
> +
> +		data->drdy_trig = devm_iio_trigger_alloc(dev, "%s-dev%d-drdy",
> +							 info->name,
> +							 iio_device_id(indio_dev));

Sashiko:
[Severity: High]
Does the devres initialization order here create a race condition during
driver unbinding?

Because devm_request_irq() is called before devm_iio_trigger_alloc(), devres
LIFO teardown will free the trigger before disabling the IRQ. If the device
is unbound while an active IIO buffer is running, the interrupt could fire
after the trigger is freed. 

When ads112c14_drdy_irq_handler() runs, it will read continuous_mode as true
and dereference the freed pointer in iio_trigger_poll(data->drdy_trig).

Should the IRQ request happen after the trigger is allocated and registered
to ensure the IRQ is safely disabled before the trigger memory is
freed?
-

Seems valid to me.  Ensure that that the irq is disabled before
the trigger is freed.  The slight disadvantage is that in theory
we could have a race with someone using the trigger before
the interrupt is registered but that doesn't apply here because
you only let this trigger be used with this device and that only
has a current_trigger a few lines later after devm_iio_device_register()

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
