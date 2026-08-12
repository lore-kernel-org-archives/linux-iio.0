Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAF13921DD;
	Wed, 12 Aug 2026 04:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786509014; cv=none; b=H6MKKDy/GqHZia3bMjPH1mAVACRNxMh0NaFbnvXPfu7Bf1XWx2EvE8Vxx2B7vGEiT3W+3e3n0Hj/+5wf4WyJod2mB8ODzxxer6oHsTRmOfbR4Bki2LrOFIBpTMCzPd5pa8zTQ3l+4nMk4lM89JevLtsI+sON2/DsTFHcWdqUm9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786509014; c=relaxed/simple;
	bh=O4EtqRYbCQjY6IHMoN/Vwk+rPflDGGJxpyfaQu5mYoU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S68/O9UyGwpGdnS9e8kM6k2eZJ3eP8f3W4OP4M0WnI3Yc4KtxjJODlrHI/E95MgTDqH921UkviEaYfYlFZktbDgOV5IYv2KY8H5vzAaO8H49S9ZEPUbwjyhwv++7ctplBEO9cxrg8bQXLo+yhVJqg6ko/H+F1skq8hwYpzEPJAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/RItS/E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/RItS/E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 210821F000E9;
	Wed, 12 Aug 2026 04:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786509012;
	bh=L5OtuDhsDHjTkkU2kU6uxOAMxC30Ppxoxyh1k5859dY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=n/RItS/EQYd8rUO+W3zuZgr4BRFsl/5kwTlpS6BSMUttiZQ9Si+e3zBQg4S40E8gg
	 Lmid2R4aKDOR90N+xPel2YUb2qeTh+L1UInA+WJvMM8SFZG1ojr+VpQNaMHjeOUiWT
	 dBSMucQ1o30zkUePYhMnahFSi6GaP2nRLE2tpcRvmspeLkAY3zJlOwVTVPTvzbcAc/
	 j5c1ld2qFCS15+pKcbw+8MycpXGyZHcIIi8x1g3qgf95Mi1+UdzujulkY340vNJGs9
	 yDUQkcCm60dAaiz0ECr9eN6kIZ42gbnzHP/m0upL+OS2sJpBBjnP6drC0JfWL/SZEV
	 e4u3Yrj6JTvKw==
Date: Wed, 12 Aug 2026 05:29:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kyle Hsieh <kylehsieh1995@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: adc: ti-ads112c04: Add support for TI
 ADS112C04
Message-ID: <20260812052958.4fa61ad9@jic23-huawei>
In-Reply-To: <20260811-ti-ads112c04-driver-v4-2-ae704ac17241@gmail.com>
References: <20260811-ti-ads112c04-driver-v4-0-ae704ac17241@gmail.com>
	<20260811-ti-ads112c04-driver-v4-2-ae704ac17241@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Aug 2026 10:48:38 +0800
Kyle Hsieh <kylehsieh1995@gmail.com> wrote:

> Add IIO driver support for the Texas Instruments ADS112C04 (16-bit)
> delta-sigma ADCs.
> 
> The driver implements:
> - Single-shot conversions using the IIO raw read interface.
> - Dynamic parsing of single-ended and differential channels from
>   device tree child nodes.
> - Hardware interrupt support via the DRDY pin, falling back to
>   software polling if no IRQ is provided.
> - Scale calculation based on the internal 2.048V reference.
> - Reference voltage scaling via the regulator subsystem (refp-supply),
>   falling back to the internal 2.048V reference if not specified.
>   refn-supply is not yet supported.
> - Hardware reset fallback using GPIO.
> 
> Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
Hi Kyle,

Clearly you got plenty of good feedback already from Andy and David.
As such (and given I have 400 IIO messages unread right now :()
I only took a quick look and called out a few things that perhaps others have not
already raised.

Jonathan

> +
> +#define ADS112C04_VREF_INTERNAL_MV	2048

Probably better up top with the other defines.

> +
> +static int ads112c04_probe(struct i2c_client *client)
> +{

...

> +
> +	/* Bypass PGA for now to allow full-scale single-ended measurements */
Given there are several fields in each of these registers, it would be
nicer to fully fill it here (even though they all end up as zeros)

	st->config0 = ADS112C04_CONFIG0_PGA_BYPASS |
		      FIELD_PUT(ADS112C04_CONFIG0_GAIN, ADS112C04_CONFIG0_GAIN_X1) |
		      FIELD_PUT(ADS112C04_CONFIG0_MUX, ADS112C04_CONFIG0_MUX_AIN0_AIN1);

	st->config1 = FIELD_PUT(ADIS112C04_CONFIG1_TEMP_EN, 0) |
		...
		      FIELD_PUT(ADIS112C04_CONFIG1_CONVMODE, ADIS112C04_CONFIG1_CONVMODE_SINGLE)
etc
Long lines so maybe shorten CONFIG to CONF or CFG to help with that.

The aim of this explicit form is to make it obvious what the defaults actually mean.
That is lost if you write a 0 as done to config1.

> +	st->config0 = ADS112C04_CONFIG0_PGA_BYPASS;
> +	ret = ads112c04_write_reg(client, ADS112C04_REG_CONFIG0, st->config0);
> +	if (ret)
> +		return ret;
> +
> +	ret = ads112c04_write_reg(client, ADS112C04_REG_CONFIG1, st->config1);
> +	if (ret)
> +		return ret;
