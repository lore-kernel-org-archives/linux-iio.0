Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878EB396D2E;
	Fri, 24 Jul 2026 23:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784934863; cv=none; b=FhgAY89HXMRUlgp5LdLLbcfmT5RyNngPc3w/bJtkI9/7uWvQ2s/auca4R2Lyybsdsd2UGJM9/WmOeGJqu/78pmJaUTVtCzra82yRaxS6NprH0bGinXRALvC9BO1Yk+kPD0LOxwE/L+PvxJyVTHM2akiCsrdkUYu1FuTTh/GmcCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784934863; c=relaxed/simple;
	bh=jpDGtDnRPaMMnPDSnfxEHiO0PBGIiudwaMIsPeGw/aQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OuASRICwE4YwDnTHqZR445dcFraChgtknHdikIvwcxkKT4AkQMmzDSRuHZH2O2Fm+mxLI5XrMNMK6AnWqATpi3CW15hOuOilx/BZTYOscV70q23yPT6Ux/3so4Ag66sbN3l8KhLxuEiFC1++PMCjfixwvbAM1OZwP9wTTIiBEeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvogha9Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvogha9Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF4B31F000E9;
	Fri, 24 Jul 2026 23:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784934862;
	bh=eDBxGFi10DQ8GvAbeqF5XURIexdwkwtlbC0hkdJxXb0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lvogha9Q2jHjXGerDa7FnFjnhWHfmmCggY7uq3nCzUjuJv9IUBDzSIBf8PdjPYqY1
	 1aQIKXEGCjLutW3ncn56pkP5vpJ7VmNWKAcbDU3M2iWoZBQM0c7kxw0fpnVAxMZ6hx
	 4ZIAch8PwOsXSTT3V0htdEak1I8RbhKvtQpf2aRILwPeFL5Z8BUfw34uEjzODTH6Qo
	 HhyAbFB9nWD6BtrItIBej30R5cC6CA4PXMx08+Efo0DuQmSMgt4dKScj4hJ8iPk4lw
	 HHCECeJ54rne+MUDh+ZdaoDBNUmO3b98BRN0bwAUfc8VyQB/zgXSUntMMd0MoHxIjl
	 M2+c13u0S+KtQ==
Date: Sat, 25 Jul 2026 00:14:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: dac: mcp47a1: add support for new device
Message-ID: <20260725001417.159653b8@jic23-huawei>
In-Reply-To: <20260721-mcp47a1-add-support-v1-2-da045a2567e3@gmail.com>
References: <20260721-mcp47a1-add-support-v1-0-da045a2567e3@gmail.com>
	<20260721-mcp47a1-add-support-v1-2-da045a2567e3@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Jul 2026 20:24:39 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> The Microchip MCP47A1 is a 6-bit volatile Digital-to-Analog converted
> which communicates via I2C.
> 
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>

A few really small comments inline.  Nice little driver.

Given the really small number of registers, regmap does seem like
it might be overkill

> diff --git a/drivers/iio/dac/mcp47a1.c b/drivers/iio/dac/mcp47a1.c
> new file mode 100644
> index 000000000000..251c2281634f
> --- /dev/null
> +++ b/drivers/iio/dac/mcp47a1.c
> @@ -0,0 +1,193 @@

...


> +static int mcp47a1_probe(struct i2c_client *client)
> +{

...

> +	/*
> +	 * This is a volatile DAC which doesn't have an ID register, instead
> +	 * the value register is set to 0x20 every Power-on-Reset (table 4-1).
> +	 * Any other read value at startup could indicate that the device is
> +	 * damaged etc.

or some earlier software wrote it and the all the regulators are stubs
provided as they can't be turned off by software.

I'd drop this test - it is a bit too flakey as a way to tell the chip
is there and working. 

> +	 */
> +	ret = regmap_read(data->regmap, MCP47A1_CMD_CODE, &reg_val);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to read register on startup\n");
> +
> +	if (reg_val != 0x20)
> +		dev_info(dev, "Read value 0x%02x at startup\n", reg_val);
> +
> +	indio_dev->name = "mcp47a1";
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &mcp47a1_info;
> +	indio_dev->channels = mcp47a1_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(mcp47a1_channels);
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
