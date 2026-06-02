Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339CA2C2363;
	Tue,  2 Jun 2026 10:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780396050; cv=none; b=aad3fToXeSHefmYh9EMwkgvtqm9QYlen6i0SukZl90G8Izxwn8LvviEUPC39q38YxU7vznRdfmMGYVUWcGf9xYG3jf6o47dkf1WGt3Z71t34llzJatdkUl4j5VeiUZ139b0AbdGiF/6k2+/PkKdlrkYKpBQbh3AbHhO75urwA2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780396050; c=relaxed/simple;
	bh=Nd3sbqqPNlvBdk1116WY/rAB3A+F7RuRk5ZUhoPTIbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vbhc/0ADlkoBo2H3LvK0VgCdrDwhbALTdqo47r0wNiLaiHiwjCVt/BrqekmPNHKyygNkHCR4l9+0TmNr2l7Z7/bWjk53CugEbjfCInUAQx6rE4oAdVwcD34GvHZdA9lXm9L5YPVTWno5mHY4AiosixlhR/Kuqu0t1EgKOAdWhPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gYgtQhWS; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gYgtQhWS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780396048; x=1811932048;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Nd3sbqqPNlvBdk1116WY/rAB3A+F7RuRk5ZUhoPTIbY=;
  b=gYgtQhWSpT/bnJeuT4QNFGedhXez6xKU2X9lfGDYXB9XVCMesx8kHcAr
   Al2WKhgdEQ6QQoekHyCkxG33McybNY7ihh+LzSQM5mOjGI5vv02eA2FpG
   tJBy9UM14WJSTDh71388LRph2gEswXJBrXa7EOYEXtj7YIfif6rAualPz
   f5LbBh4XzsfGE5G3HhiGIkDgMbFNzf3goJ/682Vn9MKFh2+WOntJ9tuIK
   VoVqVjgwNEv/XdHXOtyAyVEYoaw9nRhVBSfKTzz3JxF8rvS6c7mTuifDC
   Xaxi88TjfgaxvevvttpofuMSp0lzxa/G3lNT7UE/av2F5cyaKLlQgAfah
   w==;
X-CSE-ConnectionGUID: GHCR67hhSIqHjHoCM5zY5w==
X-CSE-MsgGUID: HI2mYz8dTdaxITF4rePpCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="81302525"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="81302525"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 03:27:27 -0700
X-CSE-ConnectionGUID: KUrzNGKEQ4OIpCuKxJ6Tgg==
X-CSE-MsgGUID: kuji5Xc5Q66p9XNzuENrBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="274133528"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.229])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 03:27:24 -0700
Date: Tue, 2 Jun 2026 13:27:21 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] iio: light: veml6031x00: add support for events
 and trigger
Message-ID: <ah6wCYjFatHpaSM5@ashevche-desk.local>
References: <20260531-veml6031x00-v4-0-e64f7fdce38d@gmail.com>
 <20260531-veml6031x00-v4-4-e64f7fdce38d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260531-veml6031x00-v4-4-e64f7fdce38d@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, May 31, 2026 at 09:58:24PM +0200, Javier Carrasco wrote:
> The device provides a shared interrupt line for to notify events and
> data ready, which can be used as a trigger. The interrupt line is not a
> requirement for the device to work. Implement variants for the cases
> whether the interrupt line is provided or not.

...

>  #include <linux/bitfield.h>
>  #include <linux/bits.h>
>  #include <linux/i2c.h>
> +#include <linux/interrupt.h>

Previous patch uses irqreturn_t already.

...

> +#define VEML6031X00_INT_MASK        (VEML6031X00_INT_TH_L | \
> +				     VEML6031X00_INT_TH_H | \
> +				     VEML6031X00_INT_DRDY)

Besides mixture of tabs and spaces (the indentation in the first line made only
using spaces) this is less readable than

#define VEML6031X00_INT_MASK						     \
	(VEML6031X00_INT_TH_L | VEML6031X00_INT_TH_H | VEML6031X00_INT_DRDY)

...

> +static int veml6031x00_read_period(struct iio_dev *iio, int *val)
> +{
> +	struct veml6031x00_data *data = iio_priv(iio);
> +	int ret, reg;
> +
> +	ret = regmap_field_read(data->rf.pers, &reg);
> +	if (ret)
> +		return ret;

> +	*val = 1 << reg;

UB for reg == 31. What's wrong with BIT() here?

> +	return IIO_VAL_INT;
> +}

...

> +static int veml6031x00_write_period(struct iio_dev *iio, int val)
> +{
> +	struct veml6031x00_data *data = iio_priv(iio);
> +
> +	if (val < 0 || val > 8 || hweight8(val) != 1)

This gives upper bits out of considerations, while...

> +		return -EINVAL;
> +
> +	return regmap_field_write(data->rf.pers, ffs(val) - 1);

...this one not. It's not a problem per se, but confusing for the reader, needs
more brain power to get it.

Instead I propose to make it clearer

	u8 period = val;
	...

Also, wouldn't __ffs() suffice instead of ffs() - 1? I don't remember, please
double check that.

> +}

...

> +static int veml6031x00_write_th(struct iio_dev *iio, int val, int val2, int dir)
> +{
> +	struct veml6031x00_data *data = iio_priv(iio);
> +	struct device *dev = data->dev;
> +	__le16 reg = cpu_to_le16(val);
> +	int ret;
> +
> +	if (val < 0 || val > U16_MAX || val2)
> +		return -EINVAL;
> +
> +	if (dir == IIO_EV_DIR_RISING) {
> +		ret = regmap_bulk_write(data->regmap, VEML6031X00_REG_WH_L,
> +					&reg, sizeof(reg));
> +		if (ret)
> +			dev_dbg(dev, "Failed to set high threshold %d\n", ret);
> +	} else {
> +		ret = regmap_bulk_write(data->regmap, VEML6031X00_REG_WL_L,
> +					&reg, sizeof(reg));
> +		if (ret)
> +			dev_dbg(dev, "Failed to set low threshold %d\n", ret);
> +	}

You can deduplicate the message by:

	bool rising = dir == IIO_EV_DIR_RISING;
	...
	if (rising)
		ret = regmap_bulk_write(data->regmap, VEML6031X00_REG_WH_L,
					&reg, sizeof(reg));
	else
		ret = regmap_bulk_write(data->regmap, VEML6031X00_REG_WL_L,
					&reg, sizeof(reg));
	if (ret)
		dev_dbg(dev, "Failed to set %s threshold %d\n", str_high_low(rising), ret);

Will require string_choices.h.

> +	return ret;
> +}

...

> +static int veml6031x00_set_interrupt(struct veml6031x00_data *data, bool state)
> +	__must_hold(&data->irq_lock)

This is an annotation for sparse. If you really want to make it sure...

> +{
> +	int ret;

...use lockdep annotation here (as well).

> +	if (state) {
> +		data->int_users++;
> +		if (data->int_users > 1)
> +			return 0;
> +	} else {
> +		data->int_users--;
> +		if (data->int_users > 0)
> +			return 0;
> +	}
> +
> +	ret = regmap_field_write(data->rf.int_en, state);
> +	if (ret) {
> +		if (state)
> +			data->int_users--;
> +		else
> +			data->int_users++;
> +	}
> +
> +	return ret;
> +}

...

> +static irqreturn_t veml6031x00_interrupt(int irq, void *private)
> +{
> +	struct iio_dev *iio = private;
> +	struct veml6031x00_data *data = iio_priv(iio);
> +	s64 timestamp;
> +	int ret, reg;
> +
> +	ret = regmap_read(data->regmap, VEML6031X00_REG_INT, &reg);
> +	if (ret) {
> +		dev_err(data->dev,
> +			"Failed to read interrupt register %d\n", ret);

It will flood the log very quickly under a heavy system load that may not
service interrupt in time. I'm actually not sure how useful this message
is (only for debug?).

> +		return IRQ_NONE;
> +	}
> +
> +	if (!(reg & VEML6031X00_INT_MASK))
> +		return IRQ_NONE;
> +
> +	guard(mutex)(&data->irq_lock);
> +
> +	if ((reg & (VEML6031X00_INT_TH_H | VEML6031X00_INT_TH_L)) && data->ev_en) {
> +		timestamp = iio_get_time_ns(iio);
> +
> +		if (reg & VEML6031X00_INT_TH_H)
> +			iio_push_event(iio, IIO_UNMOD_EVENT_CODE(IIO_LIGHT, 0,
> +								 IIO_EV_TYPE_THRESH,
> +								 IIO_EV_DIR_RISING),
> +				       timestamp);
> +		if (reg & VEML6031X00_INT_TH_L)
> +			iio_push_event(iio, IIO_UNMOD_EVENT_CODE(IIO_LIGHT, 0,
> +								 IIO_EV_TYPE_THRESH,
> +								 IIO_EV_DIR_FALLING),
> +				       timestamp);
> +	}
> +
> +	if ((reg & VEML6031X00_INT_DRDY) && data->trig_en) {
> +		iio_trigger_poll_nested(data->trig);
> +		ret = veml6031x00_set_af_trig(data, true);
> +		if (ret)
> +			dev_err(data->dev, "Failed to set trigger %d\n", ret);
> +	}
> +
> +	return IRQ_HANDLED;
> +}

...

> +static int veml6031x00_setup_irq(struct i2c_client *i2c, struct iio_dev *iio)
> +{
> +	struct veml6031x00_data *data = iio_priv(iio);
> +	struct device *dev = data->dev;
> +	int ret;
> +
> +	data->trig = devm_iio_trigger_alloc(dev, "%s-drdy%d", iio->name,
> +					    iio_device_id(iio));
> +	if (!data->trig)
> +		return -ENOMEM;
> +
> +	data->trig->ops = &veml6031x00_trigger_ops;
> +	iio_trigger_set_drvdata(data->trig, iio);
> +
> +	ret = devm_iio_trigger_register(dev, data->trig);
> +	if (ret)
> +		return ret;
> +
> +	iio->trig = iio_trigger_get(data->trig);
> +	ret = devm_request_threaded_irq(dev, i2c->irq, NULL,
> +					veml6031x00_interrupt,
> +					IRQF_ONESHOT,
> +					iio->name, iio);
> +	if (ret)

> +		return dev_err_probe(dev, ret, "Failed to request irq %d\n",
> +				     i2c->irq);

Dup message, please remove. return ret; will suffice.

>  	return 0;
>  }

-- 
With Best Regards,
Andy Shevchenko


