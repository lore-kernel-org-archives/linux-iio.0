Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC8E484232;
	Fri, 24 Jul 2026 23:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784937443; cv=none; b=XSMi1wz/TPPVfvJAW4h/FCIzy9y1CBjIeM+VM/Z6lmCuAvvaVf/6yHPXVbGIhTTYULhl47ihf/58WgznE+fPnAvSIjLsQa8f8mifwvS4TjYMY3kvPdRRSzIcuc73NQvZ8lwawTjrAUVcJyGXjhfdrRWj2HXcHjfB7zN68jlr8w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784937443; c=relaxed/simple;
	bh=VLFRgFB8k6jSFCc2/m122MOjG32aZgdusOd+F9kCF4A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ICWKk+E2aPMlhwK6oIGuy9X+3BjbW4NgHFck71l3UZ+7cWYXt65JDKNeOqMtduPEBfI7/gTdGk1sQQcs5ll9+F5JGBZ/hAoyaKmZg5kgp37a6rbvZzwi3JnlCZuAfArwN0KJrzepw9/sB9ocz09hWX3URz0FZQDrNOkmqM22h3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pq4tAO83; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pq4tAO83"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39A91F000E9;
	Fri, 24 Jul 2026 23:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784937441;
	bh=luou0a9E4J3Yzrp5vnno3ir/fWWZK4SMn+VFxGiw2ag=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Pq4tAO83vbZo0KJu2KtgxEOQTp7lUHBWgp2DiCrb7shKZku07bDJ+U0OoLVYJSaVH
	 7EARG4gkdsSBGgq3Z6xSRlJxwM5JKkkXCtyM6orTTGJUImFSOj+5IRUu9HVwmKfZib
	 WW4yh7KqrP5xQ7EFxKQD2P9ZzRMc2vreKWDQ7WNPCUNhta9kn2XBgjBetavjSnkS+o
	 peAlpKiWc12AXBRlg0cTpcRiM+v7m0muJCt/KCMEdYLXBJ2EjTURGpBeq5kWBeoM1X
	 VgtFG2EJ5dXZ9CAAxAPG7To9C7Y7pVEH6fLIw6Awsf5DJxHLZVQujMVcq2EISeE+Kr
	 q5R2F26JQByjg==
Date: Sat, 25 Jul 2026 00:57:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, "David Lechner" <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, "Jonathan Corbet" <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Marius
 Cristea <marius.cristea@microchip.com>, "Marcus Folkesson"
 <marcus.folkesson@gmail.com>, Kent Gustavsson <kent@minoris.se>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, Janani Sunil
 <jan.sun97@gmail.com>, <linux-spi@vger.kernel.org>, Kent Gustavsson
 <nedo80@gmail.com>
Subject: Re: [PATCH v7 7/7] iio: dac: Add AD5529R DAC driver support
Message-ID: <20260725005714.034b50bf@jic23-huawei>
In-Reply-To: <20260722-ad5529r-driver-v7-7-7781cd74ad75@analog.com>
References: <20260722-ad5529r-driver-v7-0-7781cd74ad75@analog.com>
	<20260722-ad5529r-driver-v7-7-7781cd74ad75@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Jul 2026 09:54:19 +0200
Janani Sunil <janani.sunil@analog.com> wrote:

> Add support for AD5529R 16-channel, 12/16 bit Digital to Analog Converter
> from Analog Devices.
> 
> The device communicates over SPI and supports per-channel output range
> configuration. An optional external 4.096V reference can be used in
> place of the internal reference.
> 
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>

Sashiko had one comment that I think deserves a tiny modification.

Otherwise looks good to me.

I would have just tweaked that and  the [] (and still may) bit giving time for that SPI
ack from Mark for the generic property before I pick this series up.

Feel free to send a new version if you prefer.

Thanks,

Jonathan


> diff --git a/drivers/iio/dac/ad5529r.c b/drivers/iio/dac/ad5529r.c
> new file mode 100644
> index 000000000000..2fd1dd053da5
> --- /dev/null
> +++ b/drivers/iio/dac/ad5529r.c

> +
> +static int ad5529r_parse_channel_ranges(struct device *dev,
> +					struct ad5529r_state *st)
> +{
> +	s32 vals[2];
> +	int ret, range_idx;
> +	u32 ch;
> +
> +	device_for_each_child_node_scoped(dev, child) {

As below, lets check we don't come in here once too many.
		if (st->num_channels == ARRAY_SIZE(st->channels))
			return dev_err_probe(dev, -EINVAL, "Too many channels\n");

> +		ret = fwnode_property_read_u32(child, "reg", &ch);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Missing reg property in channel node\n");
> +
> +		if (ch >= 16)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "Channel %u exceeds maximum 15\n",
> +					     ch);
> +
> +		if (fwnode_property_present(child, "output-range-microvolt")) {
> +			/*
> +			 * DT stores cells as raw 32-bit values; signed endpoints are
> +			 * encoded by dtc in two's-complement and then interpreted
> +			 * here as s32.
> +			 */
> +			ret = fwnode_property_read_u32_array(child,
> +							     "output-range-microvolt",
> +							     (u32 *)vals, ARRAY_SIZE(vals));
> +			if (ret < 0)
> +				return dev_err_probe(dev, ret,
> +						     "Failed to read range for ch %u\n",
> +						     ch);
> +
> +			range_idx = ad5529r_find_output_range(vals);
> +			if (range_idx < 0)
> +				return dev_err_probe(dev, range_idx,
> +						     "Invalid range [%d %d] for ch %u\n",
> +						     vals[0], vals[1], ch);
> +		} else {
> +			range_idx = AD5529R_RANGE_0V_5V;
> +		}
> +
> +		st->output_range_idx[ch] = range_idx;
> +		ret = regmap_write(st->regmap_16bit,
> +				   AD5529R_REG_OUT_RANGE(ch), range_idx);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to configure range for ch %u\n",
> +					     ch);
> +
> +		st->channels[st->num_channels++] = AD5529R_DAC_CHANNEL(ch);

Sashiko calls out that a malformed DT could have repeat entries and so overflow channels.
Given it is easy to harden against that, let us do so alongside that check on
if (ch < 16) above.

> +	}
> +
> +	return 0;
> +}
