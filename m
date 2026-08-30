Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D95145A1F;
	Sun, 30 Aug 2026 01:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788053786; cv=none; b=AFVyTQDf3HGtS9LyLKFJbQ48ZN0yV0McrB/TDneJ9ULGzt6oOMtjpmKW7MnrBvZGVEVtFIGEr+YGL+M1DkNwfMytgUwTxo6++Qsk1q8lKUHwk+F6Vnc5R1SUBjcWTc2QbEvQHr2FVj540C+puT0ImW6yJIIDIyrRpqIgAim17Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788053786; c=relaxed/simple;
	bh=Vv5i4jqd6MRM17DD001GHFOxW0HC9j2oP47qPtvKzqs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k7gSP41bmruORh6peMZ7epOlFaT+8VddwDIjiqd2+fcBqFzAvn1PFCFwkqkyTxQlMwzSIkAntIhMTZiCow7YZWrCpL+F+xZbxZyhmde10jemzdaUs/n/lpZ+rutbNRn+UUZjsNsjhEPMNMz3AnDk6dSqkqEbkKe/TnFbV6eJrF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ajeeDKkF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajeeDKkF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E621F000E9;
	Sun, 30 Aug 2026 01:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788053785;
	bh=UdmgjnbDZPNvfBySictjfkzf6a9ms2p598rmvEHmvDI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ajeeDKkFTHUkYeU6OUd2Y/Bsb8ZguFW2xSfmR0ZW0QsQM6JuCly6ue7X0nCi4l/FF
	 ZEspahW+S4hrguSsm/BJ9fFvMVjaawYRXsaX/2vSk3sL9P7IDv0SgQ1bv1GMfYhxOV
	 yhxaFQDGSjxJUjcSty3xQIMqNnuRDk4QvRjrK6zWDtn+xQQ446YGNE378rZkPqQdry
	 bdnuazHauQRhJWdHE0Qszdz3arw4bW8OEQ+5Stht1NZApC/vZoxTxUMk8CSAh6TEEz
	 P1tp7MT2qyeeQEhlSJxOeoREE02QaHPT/HVuFGzZKHyimFw+5Yjw9sb7c3oD+suLFJ
	 TLd7lru748j4g==
Date: Sun, 30 Aug 2026 02:36:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kurt Borja <kuurtb@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 04/10] iio: adc: ti-ads1262: support per-channel
 sampling frequency
Message-ID: <20260830023619.654d1bbe@jic23-huawei>
In-Reply-To: <20260828-ads126x-v4-4-1dc27e9c0260@gmail.com>
References: <20260828-ads126x-v4-0-1dc27e9c0260@gmail.com>
	<20260828-ads126x-v4-4-1dc27e9c0260@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Aug 2026 01:38:19 -0500
Kurt Borja <kuurtb@gmail.com> wrote:

> Add per-channel sampling frequency support. The "available" attribute is
> assigned per-channel too, in order to eventually support per-filter
> availability.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
A build issue below.

>  };
>  
> +static const struct ads1262_channel ads1262_default_channel = {
> +	.data_rate = ADS1262_DR_20_SPS,
> +	.filter = ADS1262_FILTER_FIR,
> +};

See below - this probably wants to be a slightly more complex define.



> @@ -763,8 +970,15 @@ static int ads1262_parse_channels(struct iio_dev *indio_dev)
>  	if (!chan_specs)
>  		return -ENOMEM;
>  
> +	st->num_channels = num_fw_channels + ADS1262_MON_CHANNEL_COUNT;
> +	st->channels = devm_kcalloc(dev, st->num_channels, sizeof(*st->channels),
> +				    GFP_KERNEL);
> +	if (!st->channels)
> +		return -ENOMEM;
> +
>  	device_for_each_named_child_node_scoped(dev, node, "channel") {
>  		struct iio_chan_spec *spec = &chan_specs[i];
> +		struct ads1262_channel *chan = &st->channels[i];
>  
>  		ret = fwnode_property_read_u32(node, "reg", &reg);
>  		if (ret)
> @@ -772,6 +986,8 @@ static int ads1262_parse_channels(struct iio_dev *indio_dev)
>  		if (reg >= ADS1262_MONITOR_ADDR_OFFSET)
>  			return dev_err_probe(dev, -EINVAL, "%pfwP: reg out of range\n", node);
>  
> +		*chan = (struct ads1262_channel)ads1262_default_channel;

This is giving me a build warning:

drivers/iio/adc/ti-ads1262.c:1913:26: warning: cast to non-scalar
drivers/iio/adc/ti-ads1262.c:1913:26: warning: cast from non-scalar

So we can't do this... Hmm. It's pretty simply. Use a define for
the default channel with the (struct adds1262_channel)
and that should work for us.

> +
>  		ret = ads1262_parse_channel_node(st, spec, node);
>  		if (ret)
>  			return ret;
> @@ -786,7 +1002,9 @@ static int ads1262_parse_channels(struct iio_dev *indio_dev)
>  			.storagebits = 32,
>  			.endianness = IIO_BE,
>  		};
> -		spec->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
> +		spec->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +					   BIT(IIO_CHAN_INFO_SAMP_FREQ);
> +		spec->info_mask_separate_available = BIT(IIO_CHAN_INFO_SAMP_FREQ);
>  
>  		i++;
>  	}
> @@ -795,6 +1013,7 @@ static int ads1262_parse_channels(struct iio_dev *indio_dev)
>  	       sizeof(ads1262_monitor_chan_specs));
>  
>  	for (unsigned int mon = 0; mon < ADS1262_MON_CHANNEL_COUNT; mon++) {
> +		st->channels[i] = (struct ads1262_channel)ads1262_default_channel;
Same here - a define would allow this to work rather than giving build
problems as it currently does.

>  		chan_specs[i].scan_index = i;
>  		i++;
>  	}
> @@ -890,6 +1109,10 @@ static int ads1262_spi_probe(struct spi_device *spi)
>  
>  	indio_dev->name = ads1262_device_id_to_name[st->dev_id];
>  
> +	ret = ads1262_populate_tables(indio_dev);
> +	if (ret)
> +		return ret;
> +
>  	/*
>  	 * REVISIT: This chip has software polling capabilities, which could be
>  	 * used to stop depending on the DRDY signal.
> 

