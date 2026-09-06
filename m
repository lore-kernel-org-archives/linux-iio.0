Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A97E368941;
	Sun,  6 Sep 2026 03:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788666635; cv=none; b=ev28j46+YSQxX5u88rxOtndCPxVh0dbePlFX2jXOEXxUt+0HqnktjIk1ZXfl1AFNX0hnEiDsrH+IQanhgUwYTWgljWelzhaLZIB94vimv8h5+o+1KwI2OsaM3QSfp1plx1T7nwflo9Uj8ce996zdhU6T6C2Dz36SelNRHc+1BQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788666635; c=relaxed/simple;
	bh=i8EsotQFDgg/v3vE+MwLja/a69L/hcGIlR9vPWum/yM=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=Fh+ZxxCIccLqUJXDsQJGtUqR5w0vQZs509wb74FRAw7zOdJhqVzkMqa7P0nRHZ3gw44Mm17+cRE7Fdn60rW04vbQveshjTEwnIe/paIQmpHfZtGhDUpn/lMP/LLJNe6ugEqaYim0dL9nEtGsJCyVXmml4K3n31V3FYzJnJ4sNGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zm3mu7hn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zm3mu7hn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC8F1F01559;
	Sun,  6 Sep 2026 03:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788666631;
	bh=idDEx2S04DErklGsOzLVw41M84pMxosB3e4oGOdqHEc=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=Zm3mu7hnmJyC4lDYJcX4f6rxD5C71UHKvnS7R6JDCd8BroA1bqKcdDLZGbsF3pX1S
	 5AMzW6TAF9pozuqeyYojgQdCY2Eer3ygyglZRWvUPUUXf6xQi5ErjPGJbv4JmCTQC2
	 fJrKYaiMbFtnw7Ae3DStiJLMVvAakBQdGCIvfQXxJuQ4baCaYaZIoyO6Q9fxmul2vi
	 q+ZHhxNzLcpErdHfVlyH1yKQi3Qo6A+xWIsOGOMyG0X6lA7c/oKwx0hd7YGpuLKTGt
	 Q6Qq803Rlgx7yffaL9g6uWLyFmyr8gjEdTX50P6vO55IASRFKSrD4XnjGUk93cC1j3
	 gTelksxBtYqlw==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 13/17] iio: adc: ad7768: Add calibration controls
From: Jonathan Cameron <jic23@kernel.org>
To: Janani Sunil <janani.sunil@analog.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Michael Walle <mwalle@kernel.org>, 
 Randy Dunlap <rdunlap@infradead.org>, linux@analog.com, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-doc@vger.kernel.org, jananisunil.dev@gmail.com, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
In-Reply-To: <20260904-ad7768-driver-v6-13-e4378f946bfb@analog.com>
References: <20260904-ad7768-driver-v6-0-e4378f946bfb@analog.com>
 <20260904-ad7768-driver-v6-13-e4378f946bfb@analog.com>
Date: Sun, 06 Sep 2026 04:50:02 +0100
Message-Id: <178866660279.3402141.16223416861472758611.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6232;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=i8EsotQFDgg/v3vE+MwLja/a69L/hcGIlR9vPWum/yM=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqnOL+XdchchHHLKitix/bElAOGxRmDJmY30xxs
 aCNAUFlqGaJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCapzi/hEcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiAZwD/0WR/dmlKOfG/YCP9LgBCKj7DY+hbWL/8cQihh0dyf3pNr
 yjg5ocOtZV+/Do7bku2sK67nQAwwJNQdEoCYu7077lxKRdkEuKNzb4gimEeuEkEEZmUYAnf7q8f
 rNfb5PdK5k+PHKO/fcA2mWlGsoqqpoUgVKmA0+WJwqfrL41f0OkKv972UibJVvWX6Q2GW6WfL20
 u6kucYtPQ4HW1rqO/pQ+7+jsvoXi1uGNXuIAVQMNGX8GLW/62JyH1731ia13cVlKKJcKSYJ5Cfn
 aJE+Tr/p6UWo6oOGkqHCCxfbawCAYp75xct1lnnf7f+spJxkcYJNkFlOVaf3c7mpsX6T2GycBJ0
 QimyBSgqd0G7qgFohuvJPm4Q51F2xrzRicwnC8mWHhiSQOSz2FoRTQrgY59T5fndjwBiKpEIFzE
 zUNv8K0V6+NhInQr31SdEVtLleNjcdTzRkNH+uMGqlhpG41oj+L2zpkLfJoJYUPXldpLgXfMqWi
 MOajfKvqhheIphzR3oHSxCJfeKBAsIu44MwiDVL6ZLnJVAdPeNlkOzVRPe4IdqQoYq4F0XEYQqo
 k9RCqUXB2gHyFtCvfdeIbRa/Kz5zemfklNKsU2BFDcBDjJqKwD7FpH2AqMA0XzDkB5vGvkE4K8m
 AjJIrzXZs+lKJt3bA4pPWsv00dfZH7fPkX7SdFw==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> Expose the per-channel offset and gain calibration registers through the
> IIO calibbias and calibscale attributes.
> 
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>

Sashiko raises some more good points in here.

Honestly in a large complex driver like this, humans (well me
anyway) are getting burnt out by this point in a series
so this sort of things slips through us.
Good to have a bot help out!  Note this is also why best practice
is to start with a simpler driver and add features in follow up series
that remain more manageable.

>
> diff --git a/drivers/iio/adc/ad7768.c b/drivers/iio/adc/ad7768.c
> index f2c762688fb3..802666f7abd4 100644
> --- a/drivers/iio/adc/ad7768.c
> +++ b/drivers/iio/adc/ad7768.c
> @@ -27,6 +27,7 @@
>  #include <linux/spi/spi.h>
>  #include <linux/time.h>
>  #include <linux/types.h>
> +#include <linux/unaligned.h>
>  #include <linux/units.h>
>  
>  #include <linux/iio/backend.h>
> @@ -107,6 +108,7 @@
>  #define AD7768_MAX_FREQ_PER_MODE			6
>  #define AD7768_MAX_CHANNEL				8
>  #define AD7768_NUM_CHANNEL_MODES			2
> +#define AD7768_CALIB_REG_MSK				GENMASK(23, 0)
>  #define AD7768_WIDEBAND_SETTLING_SAMPLES		68
>  #define AD7768_SINC5_SETTLING_SAMPLES			7
>  
> @@ -232,6 +234,18 @@ static u8 ad7768_all_standby_mask(const struct ad7768_state *st)
>  	return GENMASK(st->chip_info->num_channels - 1, 0);
>  }
>  
> +static unsigned int ad7768_offset_reg(const struct ad7768_state *st,
> +				      unsigned int ch)
> +{
> +	return AD7768_REG_OFFSET(st->chip_info->chan_map[ch]);
> +}
> +
> +static unsigned int ad7768_gain_reg(const struct ad7768_state *st,
> +				    unsigned int ch)
> +{
> +	return AD7768_REG_GAIN(st->chip_info->chan_map[ch]);
> +}
> +
>  static u8 ad7768_precharge_buf1_mask(const struct ad7768_state *st, u16 val)
>  {
>  	return val & GENMASK(st->chip_info->prebuf_split - 1, 0);
> @@ -359,6 +373,59 @@ static const struct regmap_config ad7768_4_regmap_config = {
>  	.readable_reg = ad7768_4_readable_reg,
>  };
>  
> +static unsigned int ad7768_get_calib_reg_base(struct ad7768_state *st,
> +					      const struct iio_chan_spec *chan,
> +					      bool is_gain)
> +{
> +	if (is_gain)
> +		return ad7768_gain_reg(st, chan->channel);
> +
> +	return ad7768_offset_reg(st, chan->channel);
> +}
> +
> +static int ad7768_read_calib_value(struct ad7768_state *st,
> +				   unsigned int base_reg, unsigned int *val)
> +{
> +	u8 data[3];
> +	int ret;
> +
> +	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(regmap_get_device(st->regmap), pm);
> +	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	ret = regmap_bulk_read(st->regmap, base_reg, data, sizeof(data));
> +	if (ret)
> +		return ret;
> +
> +	*val = get_unaligned_be24(data);

So you'll need to know whether or not to sign extend.
I'd pass in a bool to provide that info so you can still share
the functions

> +
> +	return 0;
> +}
> +
> +static int ad7768_write_calib_value(struct ad7768_state *st,
> +				    unsigned int base_reg, unsigned int val)
> +{
> +	u8 data[3];
> +	int ret;
> +
> +	if (val > AD7768_CALIB_REG_MSK)
> +		return -EINVAL;

This will need adjusting to deal with 2s comp bias values.

> +
> +	put_unaligned_be24(val, data);
> +
> +	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(regmap_get_device(st->regmap), pm);
> +	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	return regmap_bulk_write(st->regmap, base_reg, data, sizeof(data));
> +}
> +
>  static int ad7768_reg_access(struct iio_dev *indio_dev,
>  			     unsigned int reg,
>  			     unsigned int writeval,
> @@ -798,6 +865,7 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
>  			   int *val, int *val2, long info)
>  {
>  	struct ad7768_state *st = iio_priv(indio_dev);
> +	int ret;
>  
>  	switch (info) {
>  	case IIO_CHAN_INFO_SCALE:
> @@ -808,6 +876,21 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
>  
>  		return IIO_VAL_INT;
>  	}
> +
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +	case IIO_CHAN_INFO_CALIBSCALE: {
> +		bool is_gain = info == IIO_CHAN_INFO_CALIBSCALE;
> +		unsigned int base_reg;
> +		unsigned int calib;
> +
> +		base_reg = ad7768_get_calib_reg_base(st, chan, is_gain);
> +		ret = ad7768_read_calib_value(st, base_reg, &calib);
> +		if (ret)
> +			return ret;
> +
> +		*val = calib;

Sashiko:

[Severity: High]
Does this assignment correctly handle negative two's complement offsets?

Since calib is an unsigned integer populated from a 24-bit register, reading
a negative offset directly assigns it without sign extension. Will this cause
userspace to see massive positive integers (e.g., 0xFFFFFF) instead of the
actual negative offset, violating the IIO ABI?

-
I would indeed expect a sign_extend32() to deal with the 24 bit 2s
comp value of calibbias. Given that doesn't apply to scale you may
have to split the two paths.

> +		return IIO_VAL_INT;
> +	}
>  	default:
>  		return -EINVAL;
>  	}

...

>  static int ad7768_write_raw(struct iio_dev *indio_dev,
>  			    struct iio_chan_spec const *chan,
>  			    int val, int val2, long info)
>  {
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +	unsigned int base_reg;
> +
>  	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
>  	if (IIO_DEV_ACQUIRE_FAILED(claim))
>  		return -EBUSY;
>  
> -	if (info == IIO_CHAN_INFO_SAMP_FREQ)
> +	switch (info) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
>  		return ad7768_set_sampling_freq(indio_dev, val, chan->channel);
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		if (val < 0 || val > AD7768_CALIB_REG_MSK)
> +			return -EINVAL;

Sashiko:
[Severity: High]
Is it expected to explicitly block negative values for the calibration bias?

By returning -EINVAL when val < 0, this rejects valid negative integer
offsets that users or auto-calibration scripts might attempt to write. Should
negative values be converted to their 24-bit two's complement representation
instead of being rejected?
-
The register is 2s comp so the comment seems to be correct.

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
