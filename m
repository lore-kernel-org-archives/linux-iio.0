Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FC44CF460;
	Sat, 17 Oct 2026 23:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792280527; cv=none; b=CBdfSwUm7dEpzOukiYaKpa5G7WoROfGOAJSHhfYjMiwHD41fclRxaKEO+/UvuYAcOjeZ6jF37btFRwaXi1NA0sE+wof3NywCZyIDFF+48JFNAYodDedzKUV7Nt7XhecXl9LR1cSj4Fp6snem6Yrvf5m7Krp6dCURnAkBycqplZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792280527; c=relaxed/simple;
	bh=uVl5t0hNdlTbZrRJf1kWWu3wPXHhVQCLSWs/mG2dF60=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SqeMpwADm5rrdp0mVsJSFH+UawISgIX5vAG9hQ1qPSSQE+cDpvD2SBkDJVoNzG8RsRwRSgpggRx45kvZOEcUmXAPM9UzWBH9qboKhPawp+5bJTDIRUuvJt6/oOtNGkflx4jJcYIRHVsgSHCWOpUAOfAkfePPcn2GbtbIThjHsRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkipT/Ir; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkipT/Ir"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA5561F000C4;
	Sat, 17 Oct 2026 23:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792280525;
	bh=evUXB6CDtFbOeT3FSRX1mbalYGQtmf06tYshnf8grqU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kkipT/Ir9XR4VUIWFnbPAkJh/SdNkXnNU1JMpC4UZz4APs93Yfh08RiDgXkK07xLb
	 muNWL9yKPrl0YiG1C3MesqGIDmx1MiwRY0qLqnWanJ/7zDUeSQ4n9gbQ+jV4cJd6s5
	 xJQUj3nUdz6GvaNF+N5fz5X33omfqNoGNV5fUDq9DTsxl8ENbYJ3l+k77vTPgSRRZt
	 8ouPIn/2N05uPBLedOEmH/ui67O1hC514cCHZsetZh7zLnf/RPHYwPulpLWkF43dnp
	 ecizAUkwwbLYHAqWverCGm5SUdA4eQPGpT3LhWjRo83owV1x7IMwt2UtjxIjWeWTmC
	 mzgHtLu6Uk8Iw==
Date: Sun, 18 Oct 2026 00:41:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>, Joshua Crofts
 <joshua.crofts1@gmail.com>, Radu Sabau <radu.sabau@analog.com>, Janani
 Sunil <janani.sunil@analog.com>, Salih Erim <salih.erim@amd.com>, Jishnu
 Prakash <jishnu.prakash@oss.qualcomm.com>, Jakub Szczudlo
 <jakubszczudlo40@gmail.com>, <linux@analog.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 3/4] iio: adc: ade9000: add support for ADE9039
Message-ID: <20261018004158.00c15871@jic23-hlaptop>
In-Reply-To: <20261012111342.48040-4-antoniu.miclaus@analog.com>
References: <20261012111342.48040-1-antoniu.miclaus@analog.com>
	<20261012111342.48040-4-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Oct 2026 14:13:39 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> The ADE9039 is a polyphase energy metering device that is register
> compatible with the ADE9000 for every register the driver touches. The
> differences relevant to the driver are that it shares the full-scale codes
> of the ADE9078 rather than those of the ADE9000, and that it has no total
> reactive power register: the register map has no AVAR at 0x211 and no
> AVAROS at 0x010, only the fundamental AFVAR and AFVAROS.
> 
> Add a chip_info for it and a channel table that keeps the dip/swell events
> of the ADE9000 but drops the three total reactive power channels. The
> fundamental reactive energy channels are unaffected, as AFVARHR is present.
> 
> No change is needed in the CALIBBIAS path: with no channel carrying the
> AVAR address, that case is simply never reached for this part.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  drivers/iio/adc/Kconfig   |  1 +
>  drivers/iio/adc/ade9000.c | 14 ++++++++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 02de4809ae31..3052a86c460f 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -603,6 +603,7 @@ config ADE9000
>  	    - ADE9000
>  	    - ADE9078
>  	    - ADE9430
> +	    - ADE9039
>  
>  	  The devices feature high-precision analog-to-digital converters
>  	  and digital signal processing to compute RMS values, power factor,
> diff --git a/drivers/iio/adc/ade9000.c b/drivers/iio/adc/ade9000.c
> index 03b69556b62f..e7f509bbac77 100644
> --- a/drivers/iio/adc/ade9000.c
> +++ b/drivers/iio/adc/ade9000.c
> @@ -683,6 +683,8 @@ ADE9000_DECLARE_CHANNELS(ade9000_channels, ADE9000_ALTVOLTAGE_RMS_CHANNEL,
>  			 ADE9000_POWER_REACTIVE_ENTRY);
>  ADE9000_DECLARE_CHANNELS(ade9078_channels, ADE9000_ALTVOLTAGE_RMS_CHANNEL_NO_EVENTS,
>  			 ADE9000_POWER_REACTIVE_ENTRY);
> +ADE9000_DECLARE_CHANNELS(ade9039_channels, ADE9000_ALTVOLTAGE_RMS_CHANNEL,
> +			 ADE9000_NO_POWER_REACTIVE_ENTRY);

Put this such that the various parts are in numeric order.

>  
>  /*
>   * Full-scale codes referred from the respective datasheets. These are the
> @@ -718,6 +720,16 @@ static const struct ade9000_chip_info ade9430_chip_info = {
>  	.has_digital_integrator = false, /* no on-chip digital integrator */
>  };
>  
> +static const struct ade9000_chip_info ade9039_chip_info = {
> +	.name = "ade9039",
> +	.channels = ade9039_channels,
> +	.num_channels = ARRAY_SIZE(ade9039_channels),
> +	.rms_full_scale_codes = 52866837,
> +	.watt_full_scale_codes = 20823646,
> +	.pcf_full_scale_codes = 74680000,
> +	.has_digital_integrator = true,
> +};

Put this in location that is appropriate for part number.

> +
>  static const struct reg_sequence ade9000_initialization_sequence[] = {
>  	{ ADE9000_REG_PGA_GAIN, ADE9000_PGA_GAIN },
>  	{ ADE9000_REG_CONFIG0, ADE9000_CONFIG0 },
> @@ -1883,6 +1895,7 @@ static const struct spi_device_id ade9000_id[] = {
>  	{ .name = "ade9000", .driver_data = (kernel_ulong_t)&ade9000_chip_info },
>  	{ .name = "ade9078", .driver_data = (kernel_ulong_t)&ade9078_chip_info },
>  	{ .name = "ade9430", .driver_data = (kernel_ulong_t)&ade9430_chip_info },
> +	{ .name = "ade9039", .driver_data = (kernel_ulong_t)&ade9039_chip_info },
numeric order here as well.
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(spi, ade9000_id);
> @@ -1891,6 +1904,7 @@ static const struct of_device_id ade9000_of_match[] = {
>  	{ .compatible = "adi,ade9000", .data = &ade9000_chip_info },
>  	{ .compatible = "adi,ade9078", .data = &ade9078_chip_info },
>  	{ .compatible = "adi,ade9430", .data = &ade9430_chip_info },
> +	{ .compatible = "adi,ade9039", .data = &ade9039_chip_info },
And here as well.

Otherwise LGTM.
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, ade9000_of_match);

