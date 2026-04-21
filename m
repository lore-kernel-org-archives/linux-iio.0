Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876BB2C187;
	Tue, 21 Apr 2026 15:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776784650; cv=none; b=DOJOMwP7GMOIV6bkOHhgjryftrM0KVv3gvfmEGmq/5VsR14oPPs6ZUlQ8bVSv1Xrq5rOfhMWEgCnkNdphbXrNS3amB0+jRaAzDz9+pOOuNG0sE4TTDI5eWFZiJZn+XBKypeLWhAc7ChTGK7z1xeKAkj6KrK+PhLZ2YfUQSfBTC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776784650; c=relaxed/simple;
	bh=d/1JZ54gtzvNdNgYBO7YYoNv00Q60YBfszmfvI/YAjs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lk2gTBibXi0/v9cdataiGY+7BVzaHv+N0Ogs/KsJez5hjEXS/6M8S8DGRWmBUZ7Z97LtU2xI916+wiW+DP2C76VNQ6vESaIXqqOfjSrF+Nqf4NvImxGNgOGO/rcMVVNaUeqgJdaCzs2JriUB39NW7oa1kG6KTdBrT54tOJ0zy7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPKp5/7S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPKp5/7S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA786C2BCB0;
	Tue, 21 Apr 2026 15:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776784650;
	bh=d/1JZ54gtzvNdNgYBO7YYoNv00Q60YBfszmfvI/YAjs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jPKp5/7S/VBfgolrkNzr3FfVONKSO3asPcoyJLtWmKpkO7IZvJKESONmxWe8Nc5Gi
	 IkdJpKy++sNPmMS5gfn/Fu0pCUCyzXQq75HTou6mp5yKFFcXoCtiEiPcn/XvsFSuo2
	 e/Ry4U2xaa/XomID2nvec1WTYRfaeKgx9GbN/UuOouzXREaYBHaPxFdK4ahv9BMNv6
	 NpboiIUxLHlJxepcLVK1HabznAZTB64CdTGRlHonB2lGo66AfBliEUFHKnKMvN/nwe
	 92+/ektnkuegdlRK5CZnW5VDt3uQmfjt3FfDc0UHRs3jFk/t4qFLx3Z2oUkFd8B8/O
	 VxBlHBNOVherw==
Date: Tue, 21 Apr 2026 16:17:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: ak@it-klinger.de, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: hx711: add support for HX710B
Message-ID: <20260421161720.43dd97a3@jic23-huawei>
In-Reply-To: <20260419174654.683692-3-piyushpatle228@gmail.com>
References: <20260419174654.683692-1-piyushpatle228@gmail.com>
	<20260419174654.683692-3-piyushpatle228@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 19 Apr 2026 23:16:40 +0530
Piyush Patle <piyushpatle228@gmail.com> wrote:

> The HX711 uses trailing SCK pulses after each 24-bit conversion to
> select the channel and gain for the next measurement: 1 pulse gives
> channel A at gain 128, 2 pulses give channel B at gain 32, and 3 pulses
> give channel A at gain 64.
> 
> The HX710B works differently: gain is fixed at 128 and the trailing
> pulses select only the channel. One trailing pulse selects the
> differential input (channel 0, 10 SPS) and two trailing pulses select
> the DVDD-AVDD supply monitor (channel 1, 40 SPS).
> 
> Refactor the driver around a per-chip hx711_chip_info structure so both
> variants can share the same core. Each chip provides its own
> iio_chan_spec array and iio_info pointer. The HX710B stores per-channel
> trailing pulse counts in chan->address (1 for channel 0, 2 for
> channel 1) instead of a separate array. A bool fixed_gain flag and
> fixed_gain_val field in hx711_chip_info distinguish the fixed-gain path
> from the HX711's user-selectable gain path without conflating unrelated
> properties. The HX710B differential input channel is described with
> .differential=1 and .channel2=1 as required by the IIO ABI.
> 
> Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>

I'm slowly incorporating looking at the feedback that the sashiko LLM based
code review is providing.  In amongst some stuff I'm fairly sure was
garbage it did raise some stuff that needs a closer look. See inline...

> @@ -246,27 +275,50 @@ static int hx711_set_gain_for_channel(struct hx711_data *hx711_data, int chan)
>  	return 0;
>  }
>  
> -static int hx711_reset_read(struct hx711_data *hx711_data, int chan)
> +/* Select HX710B channel for the next conversion. */
> +static int hx710b_set_channel(struct hx711_data *hx711_data,
> +			      const struct iio_chan_spec *chan)
>  {
>  	int ret;
> -	int val;
>  
> -	/*
> -	 * hx711_reset() must be called from here
> -	 * because it could be calling hx711_read() by itself
> -	 */
> +	if (hx711_data->channel_set == chan->channel)
> +		return 0;
> +
> +	hx711_data->channel_set = chan->channel;
Sashiko raises what sound like a plausible issue here.  If the read
that follows fails is the current channel updated?  I.e. should we
set this or not?
https://sashiko.dev/#/patchset/20260419174654.683692-1-piyushpatle228%40gmail.com
(be careful with these AI reviews. Some of the other things it says are - I think
not true!)

> +
> +	ret = hx711_read(hx711_data, chan->address);
> +	if (ret < 0)
> +		return ret;
> +
> +	return hx711_wait_for_ready(hx711_data);
> +}

>  static const struct iio_chan_spec hx711_chan_spec[] = {
>  	{
>  		.type = IIO_VOLTAGE,
> @@ -455,10 +516,69 @@ static const struct iio_chan_spec hx711_chan_spec[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(2),
>  };
>  
> +/*
> + * HX710B channels.
> + * Channel 0: differential input (IN+ vs IN-), 10 SPS, 1 trailing pulse.
> + * Channel 1: DVDD-AVDD supply monitor,         40 SPS, 2 trailing pulses.
This triggered a sashiko question...
https://sashiko.dev/#/patchset/20260419174654.683692-1-piyushpatle228%40gmail.com

Specifically if the fixed scale is correct for the supply monitor or not.
It seems unlikely we'd want a large gain on a supply monitor.


> + * .address holds the trailing pulse count used by hx710b_set_channel().
> + */
> +static const struct iio_chan_spec hx710b_chan_spec[] = {
> +	{
> +		.type = IIO_VOLTAGE,
> +		.differential = 1,
> +		.channel = 0,
> +		.channel2 = 1,
> +		.indexed = 1,
> +		.address = 1,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.scan_index = 0,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 24,
> +			.storagebits = 32,
> +			.endianness = IIO_CPU,
> +		},
> +	},
> +	{
> +		.type = IIO_VOLTAGE,
> +		.channel = 1,
> +		.indexed = 1,
> +		.address = 2,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.scan_index = 1,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 24,
> +			.storagebits = 32,
> +			.endianness = IIO_CPU,
> +		},
> +	},
> +	IIO_CHAN_SOFT_TIMESTAMP(2),
> +};
