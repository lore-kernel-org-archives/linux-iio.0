Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D5E3A1A27;
	Sat, 17 Oct 2026 20:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792268443; cv=none; b=d/HAQCllMY3HFv/7BS6mVdkES2E2hKqI02mKXHt9uRaTIpMofEudypbrwN/sr/+AFdnrpDmeS7WQMRpeum0Vhv4j5NmoGvDg2BS6DAPJlgM0XWCPGeBy/5OWA5ESXDKUutSasi0r121mpxLcFR2ivoJeICxuugB2r4GbVmscTYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792268443; c=relaxed/simple;
	bh=+Bmv+bH7yjyeIXhfyEWyPPu/RUvgmWqi9SHc8L4waNk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FPKpEvOftmlSdnwGUhALRlwb2YE6ecYeX/8iI3+Fco4P2YlNDPlyClTwEaObKdaSFAmKGfefuhBh2weSBj5CALcUtS3Cz3jTy5V5ywnQ6dsOCkNazbOcXiJwVkgllbJ1CL/IlvRDiTzhb4akrXtfQ/lAEQ6KiM8mUI5q347CFZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqeMw+8q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqeMw+8q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC431F000C4;
	Sat, 17 Oct 2026 20:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792268441;
	bh=cNQChqGmZXKpRKoayySFzv5GpNlTaDfGUQ5ySRB3g6o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IqeMw+8qhlCohn/eWmjvWdSfyDwrl9JZA1MH7Pzm9zlMye/dBBkU+inV8cA0TsJE2
	 Lhd65wgSGiTT06SnjxQ4x7+rb5Qz5ocZMOdXjGNa9pcGXyQazGZ1tEAFjPAhUGumPs
	 //rT21DGjhIcYPkmnjqULbqyU5WBnCtEWsyPEnAlJl5ladqdmtFUkZMsJV6WmxKyts
	 s9oMCXg1W0Vk+GLeY4tzUZF5Cn0M0skIlJ4lpeauePCpRnI2MaZ4epS0YrlG/vXVuH
	 N2YPVQbkA3X2A2z6Y5vbJmgygL9GbpporEIdwZZG+z+EhIARXGQtLjJjHItKp9RkT+
	 645Xq/31hhdeQ==
Date: Sat, 17 Oct 2026 21:20:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Liu Yufei <lyf98405@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Joshua Crofts <joshua.crofts1@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v3 2/2] iio: proximity: Add driver for Vishay VCNL36829
Message-ID: <20261017212036.53e5a8c8@jic23-hlaptop>
In-Reply-To: <20261016012218.40223-3-lyf98405@gmail.com>
References: <20261006100943.78971-1-lyf98405@gmail.com>
	<20261016012218.40223-1-lyf98405@gmail.com>
	<20261016012218.40223-3-lyf98405@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Oct 2026 09:22:18 +0800
Liu Yufei <lyf98405@gmail.com> wrote:

> From: Liu Yufei <lyf98405@gmail.com>
> 
> Add an IIO driver for the Vishay VCNL36829 proximity sensor with
> integrated VCSEL, connected over I2C.
> 
> At probe the driver enables the vdd and vddio supplies, waits for the
> sensor to power up, checks the device ID, configures the VCSEL current
> and photodiodes, and turns the proximity engine on. The sensor is put
> back into shutdown when the device is removed.
> 
> The following attributes are exposed:
>   - in_proximity0_raw
>   - in_proximity_integration_time
>   - in_proximity_integration_time_available
> 
> Datasheet: https://www.vishay.com/docs/80580/vcnl36829um.pdf
> Assisted-by: LLM
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Liu Yufei <lyf98405@gmail.com>
> ---
> v3:
> - Use dev_info() instead of dev_warn() for an unknown device ID
>   (Joshua Crofts).
> - Wrap the write_raw() arguments on a logical boundary (Andy Shevchenko).
> v2:
> - Address review comments from Andy (see cover letter for details).
> 
Nice little driver. I'll tweak the first thing whilst applying.

Applied series to the testing branch of iio.git. That will be rebased on rc1
once available at which point I'll push it out for linux-next to pick up.

> diff --git a/drivers/iio/proximity/vcnl36829.c b/drivers/iio/proximity/vcnl36829.c
> new file mode 100644
> index 000000000..217a32aad
> --- /dev/null
> +++ b/drivers/iio/proximity/vcnl36829.c

> +
> +static const int vcnl36829_it_range[] = {0, 25, 0, 25, 0, 375};
Trivial but preferred style for IIO has { 0, ... 375 };
I'll tidy that up.


> +
> +static int vcnl36829_read_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int *val, int *val2, long mask)
> +{
> +	struct vcnl36829_data *data = iio_priv(indio_dev);
> +	struct device *dev = regmap_get_device(data->regmap);
> +	struct regmap *regmap = data->regmap;
> +	unsigned int reg;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = regmap_read(regmap, chan->address, &reg);
> +		if (ret) {
> +			dev_err(dev, "Data read failed: %d\n", ret);
> +			return ret;
> +		}
> +		*val = reg;
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_INT_TIME:
> +		ret = regmap_read(regmap, VCNL36829_PS_CONF2, &reg);
> +		if (ret) {
> +			dev_err(dev, "Data read failed: %d\n", ret);
> +			return ret;
> +		}
> +		/*
> +		 * PS_IT field 0 would mean 12.5us, which does not fit the
> +		 * 25us step used here. The driver never programs field 0:
> +		 * probe sets 25us and write_raw rejects anything below 25us,
> +		 * so the field is always >= 1 and val2 = field * 25 holds.

I suppose we can relax that later without it being a regression if
it turns out someone wants to use 12.5 usecs.

> +		 */
> +		*val = 0;
> +		*val2 = FIELD_GET(VCNL36829_PS_IT_MSK, reg) * 25;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}


> +static int vcnl36829_probe(struct i2c_client *client)
> +{

> +
> +	ret = regmap_read(regmap, VCNL36829_DEV_ID, &reg);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to read device ID\n");
> +	if ((reg & 0xFF) != VCNL36829_DEV_ID_VAL)

Not that important, but for consistency I'd have given that a field name,
despite it not having one on the datasheet..

> +		dev_info(dev, "Unknown device ID 0x%x\n", reg & 0xFF);
>

