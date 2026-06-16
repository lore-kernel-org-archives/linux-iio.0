Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31F740803D;
	Tue, 16 Jun 2026 07:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781595171; cv=none; b=rjJKSy18tSlehW0iKFIzU9l+KgFh9dAfQimHUxFGVxwA/Hd3stxjmy6szmC5NFUkBeU3zukvoOHCe7APLrGctzEzZ7OatjYxbGO7Hc12LmcD1heNCfxNeHruOyQeGZeYCxosh6I23dJX9cka8xzfweQB5WQwVwKtIO+T6SMonSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781595171; c=relaxed/simple;
	bh=chxCQhvOg6qyFjVgvl09HGWa2xN1R5saN06UoVKYeoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ivx1GQTiu+F9nq7D3Z7MtVRyxcWDkxV1HTBUm7HGXw9m64GXhxub5Y3YVky6r2uhFBRlkvBrW8cjcsH/F5L57L5f+b4BWv7Oara7ZTa88yI9fboc1Fiay89pufLpWtNozPjmq50qJQ6hrt/vIQSKtZ6dLo4baXyJPNzGCBYBs08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NFmg0wtt; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NFmg0wtt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781595170; x=1813131170;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=chxCQhvOg6qyFjVgvl09HGWa2xN1R5saN06UoVKYeoY=;
  b=NFmg0wttZsWerqzoBK/C73GJ7El0RF6borr3ayEf965OoRSEzwLDT+th
   lusRX5yQ4NA8iwOxbmO45cB5FE0u6i4KLeWjausBU/we7HlfnajJqdCAG
   trT91djua/9k+qnZHTgJV9PIB/HljbRBHkwX9AUQp3JYbjp8uYUqVTRxw
   LcJXxEqho1xhOPO2AvDxv8kHGDvZvPhIW2KdHbL/d0upVTIlP3nlkqOXe
   K2Yn+8NQNsGQ1d5nl6IRcywFikW586n7lXkzmwkFmN5IeKagkJTUGofKG
   GQdEt8567o9DJJ6jrRFt1OItT6ubSvmTsxmQiCozEmjepgexPM5dCHfVB
   Q==;
X-CSE-ConnectionGUID: +yvHnFZlTb+hs/aQ3NwboQ==
X-CSE-MsgGUID: Wd/VehhBRg6xPh/afvm29g==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="69896910"
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="69896910"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 00:32:48 -0700
X-CSE-ConnectionGUID: htkDtAbqQfi/RqAIBiQqjg==
X-CSE-MsgGUID: PDRBgJqjT++MNd88CVJ0Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="271414785"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.153])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 00:32:46 -0700
Date: Tue, 16 Jun 2026 10:32:43 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Kurt Borja <kuurtb@gmail.com>,
	Nguyen Minh Tien <zizuzacker@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: adc: add ti-ads112c14 driver
Message-ID: <ajD8Gxkp66kkDflE@ashevche-desk.local>
References: <20260615-iio-adc-ti-ads122c14-v1-0-e6bdadf7cb2b@baylibre.com>
 <20260615-iio-adc-ti-ads122c14-v1-2-e6bdadf7cb2b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260615-iio-adc-ti-ads122c14-v1-2-e6bdadf7cb2b@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 15, 2026 at 05:00:00PM -0500, David Lechner (TI) wrote:
> Add a new driver for the TI ADS112C14/ADS122C14 ADC chips.
> 
> This first step is adding a very basic driver that only supports power
> on/reset and reading the system monitor channels.
> 
> ADS112C14_SYS_MON_CHANNEL_SHORT is the last channel rather than being in
> logical order by address to keep the voltage channels together and in
> case we find we need to add variants of this channel with different
> voltage reference later.

...

> +#include <linux/bitfield.h>

+ bitops.h // BIT(), GENMASK(), sign_extend32()

> +#include <linux/delay.h>
> +#include <linux/dev_printk.h>
> +#include <linux/i2c.h>

> +#include <linux/iio/iio.h>
> +#include <linux/iio/types.h>

I believe we discussed that (with Jonathan) already and seems the trend is to
imply that iio/types.h is always included whenever iio/iio.h is included.

> +#include <linux/math64.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/sysfs.h>
> +#include <linux/time64.h>
> +#include <linux/types.h>
> +#include <linux/unaligned.h>
> +#include <linux/units.h>

...

> +/* Datasheet t_d(RST) - time to wait after reset before next I2C use. */
> +#define ADS112C14_DELAY_RESET_us 500

For µs (and second related units) we traditionally use _US suffix
(yeah, I know...). Of course, we can start a SI schema in new code
but it will look quite strange and probably more confusing.

...

> +struct ads112c14_data {
> +	const struct ads112c14_chip_info *chip_info;

> +	struct i2c_client *client;

No need to keep it, it's one time use and can be derived from regmap.

regmap --> dev --> i2c_client.

> +	struct regmap *regmap;
> +};

...

> +static int ads112c14_read_label(struct iio_dev *indio_dev,
> +				struct iio_chan_spec const *chan, char *label)
> +{
> +	const char *label_source;

I don't see the need of having this. Can't be returned directly?

> +	/* System monitor channels. */
> +	switch (chan->channel) {
> +	case ADS112C14_SYS_MON_CHANNEL_TEMP:
> +		label_source = "Internal temperature sensor";
> +		break;
> +	case ADS112C14_SYS_MON_CHANNEL_EXT_REF:
> +		label_source = "External reference";
> +		break;
> +	case ADS112C14_SYS_MON_CHANNEL_AVDD:
> +		label_source = "AVDD";
> +		break;
> +	case ADS112C14_SYS_MON_CHANNEL_DVDD:
> +		label_source = "DVDD";
> +		break;
> +	case ADS112C14_SYS_MON_CHANNEL_SHORT:
> +		label_source = "Internal short";
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return sysfs_emit(label, "%s\n", label_source);
> +}

...

> +static int ads112c14_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	const struct ads112c14_chip_info *info;
> +	struct iio_dev *indio_dev;
> +	struct ads112c14_data *data;
> +	u32 reg_val;
> +	int ret;
> +
> +	info = i2c_get_match_data(client);

NULL check (yeah) due to driver_override issue.

> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));

Here, and below, use 'dev'.

> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	data->chip_info = info;
> +	data->client = client;
> +
> +	ret = devm_regulator_get_enable(&client->dev, "dvdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to get dvdd regulator\n");
> +
> +	ret = devm_regulator_get_enable(&client->dev, "avdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to get avdd regulator\n");
> +
> +	data->regmap = devm_regmap_init_i2c(client, &ads112c14_regmap_config);
> +	if (IS_ERR(data->regmap))
> +		return dev_err_probe(dev, PTR_ERR(data->regmap),
> +				     "failed to init regmap\n");
> +
> +	/* Write magic reset value (0x16) to ensure known state.*/
> +	ret = regmap_write(data->regmap, ADS112C14_REG_CONVERSION_CTRL,
> +			   FIELD_PREP(ADS112C14_CONVERSION_CTRL_RESET, 0x16));
> +	/*
> +	 * The reset may cause an -EREMOTEIO error because of failing to get the
> +	 * I2C ACK at the end of the message. The device still gets reset.
> +	 */
> +	if (ret != -EREMOTEIO)
> +		return ret;

I would do it separately as

	if (ret == -EREMOTEIO)
		/* ...big comment here... */
		return 0;
	if (ret) // which is regular pattern and doesn't need any comment.
		return ret;

> +	fsleep(ADS112C14_DELAY_RESET_us);
> +
> +	ret = regmap_read(data->regmap, ADS112C14_REG_STATUS_MSB, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	if (FIELD_GET(ADS112C14_STATUS_MSB_RESETN, reg_val))
> +		return dev_err_probe(dev, -EIO, "reset failed\n");
> +
> +	/*
> +	 * Clear reset bit to prepare for next probe. And clear AVDD fault since
> +	 * that happens on every reset.
> +	 */
> +	ret = regmap_write(data->regmap, ADS112C14_REG_STATUS_MSB,
> +			   ADS112C14_STATUS_MSB_RESETN |
> +			   ADS112C14_STATUS_MSB_AVDD_UVN);
> +	if (ret)
> +		return ret;
> +
> +	/* Place in single-shot conversion mode to make ready for raw read. */
> +	ret = regmap_set_bits(data->regmap, ADS112C14_REG_DEVICE_CFG,
> +			      ADS112C14_DEVICE_CFG_CONV_MODE);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->name = info->name;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = ads112c14_sys_mon_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ads112c14_sys_mon_channels);
> +	indio_dev->info = &ads112c14_info;
> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}

-- 
With Best Regards,
Andy Shevchenko


