Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0E53AD510;
	Fri, 24 Apr 2026 12:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777033194; cv=none; b=SjDH3V89Bnk6ZnL7h5ZduGAINlDn7HPRkeoicEjiBl79wH7+3lIXRD9C1WPWLANA5dDlcY6ea2x5gdJA+hdNH2A4bTRCEasyCdAuu97siPYuCyzD9rRaKrs81O0zcMe6BOJanHV1ttg6yHt8AhSUNA1Eubb1pFTydOL9mFVg5hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777033194; c=relaxed/simple;
	bh=CsecgF1/GUFtSh1YUWC9TyARCKfxXXkkoRGFBnQyl5M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vpi2p02bm87GkUAv3scGGVbomoDHRqnotj4gU/O1056gGqb/jfwonP3yoTFW7fdo9rbKzfTKrOKGWF6zUYIQxx7TRjL7NAPrC5RWryF2uJYa7rgFFbtwuQpMZpgJeOek5JsC7Bx9LPi0zq5Z47YRiAcSuwiysvNPVBGE4U+z79c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SF+cSHli; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SF+cSHli"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B26F4C19425;
	Fri, 24 Apr 2026 12:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777033194;
	bh=CsecgF1/GUFtSh1YUWC9TyARCKfxXXkkoRGFBnQyl5M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SF+cSHliPB4SvfQjguZ43xEG+INGHvBi0zmQ2p7rQDSbZyi0q2++TzoYvU3lLu9xx
	 0Qc7Et5wUqL8g+7OkzYJOoQzeXXtaWOcc1T2EzrEkQbXferX/MKyl+bps3NYp1PQXn
	 6/pw/eoqN80x5U/3YTkccdVG0N7EOCrMs2JpOfayfeU1KkMXTQmlYdXIYQUyHiDced
	 0Q8Z3/fPgfhC8zVwaKfZPunL+skYhafXewmWJdPQGbfiUY/XryfBcoRgBELlqwh9bR
	 nzZsr80eFH+Oa9THBeYNZpcEPPnRUnClU8FJrLGVL5Lb+gFBTj9ad+1BeUAsZjgqpS
	 XVc32awPf6f2g==
Date: Fri, 24 Apr 2026 13:19:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: Andreas Klinger <ak@it-klinger.de>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] iio: adc: hx711: add support for HX710B
Message-ID: <20260424131948.178323be@jic23-huawei>
In-Reply-To: <20260422175910.1258579-4-piyushpatle228@gmail.com>
References: <20260422175910.1258579-1-piyushpatle228@gmail.com>
	<20260422175910.1258579-4-piyushpatle228@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Apr 2026 23:29:10 +0530
Piyush Patle <piyushpatle228@gmail.com> wrote:

> Add support for the AVIA HX710B ADC, which shares the HX711 GPIO
> interface but has a fixed gain of 128 and uses trailing PD_SCK pulses
> to select between the differential input and the DVDD-AVDD supply
> monitor.
> 
> Model the HX710B with its own channel specification and iio_info.
> Store the HX710B trailing pulse counts in chan->address and add
> fixed-gain handling so the HX711 selectable-gain path remains
> separate from the HX710B fixed-gain path.
> 
> The HX710B datasheet documents a single fixed PGA gain of 128 and
> does not provide configurable gain selection like the HX711.
> 
> Order hx711_chip_info as pointers first, then unsigned int fields, then
> bool. pahole then reports no internal holes in the structure; the
> remaining padding is tail padding from 8-byte alignment.
> 
> Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
> ---
> Changes in v3:
> - Add HX710B support on top of the separate hx711_chip_info refactor.
> - Update channel_set only after hx711_read() and hx711_wait_for_ready()
>   both succeed.
> - Keep a single HX710B fixed-gain scale based on the datasheet's fixed
>   PGA gain of 128; do not apply the HX711 channel-B gain of 32 to the
>   HX710B supply monitor path.

Just to confirm - you verified this?  It does seem very odd as that
might well take a large value.


> diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
> index a444a2872257..d7050bec53b4 100644
> --- a/drivers/iio/adc/hx711.c
> +++ b/drivers/iio/adc/hx711.c

> +static const struct iio_info hx710b_iio_info = {
> +	.read_raw		= hx711_read_raw,
> +};
> +
>  static const struct iio_chan_spec hx711_chan_spec[] = {
>  	{
>  		.type = IIO_VOLTAGE,
> @@ -474,6 +522,48 @@ static const struct iio_chan_spec hx711_chan_spec[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(2),
>  };
>  
> +/*
> + * HX710B channels.
> + * Channel 0: differential input (IN+ vs IN-), 10 SPS, 1 trailing pulse.
> + * Channel 1: DVDD-AVDD supply monitor,         40 SPS, 2 trailing pulses.
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
Sashiko is winning today.   See it's comment on the indexing wich is
spot on.

https://sashiko.dev/#/patchset/20260422175910.1258579-1-piyushpatle228%40gmail.com

This should be channel = 2 or given it's actually a differential measurement, maybe
invent channels 2 and 3 so you can represent it as that. If useful label
can be used to provide info on this magic channel to userspace.

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

...

> +
>  static int hx711_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -540,12 +639,16 @@ static int hx711_probe(struct platform_device *pdev)
>  	/* we need 10^-9 mV */
>  	ret *= 100;
>  
> -	for (i = 0; i < HX711_GAIN_MAX; i++)
> -		hx711_gain_to_scale[i].scale =
> -			ret / hx711_gain_to_scale[i].gain / 1678;
> +	if (chip_info->fixed_gain) {
> +		hx711_data->scale = ret / chip_info->fixed_gain_val / 1678;
> +	} else {
> +		for (i = 0; i < HX711_GAIN_MAX; i++)
> +			hx711_gain_to_scale[i].scale =
> +				ret / hx711_gain_to_scale[i].gain / 1678;

Just to point it out, this is the update of the global variable I mentioned
Sashiko spotting as broken in my reply to previous patch.

>  

