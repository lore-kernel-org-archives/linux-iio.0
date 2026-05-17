Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED98329C57;
	Sun, 17 May 2026 15:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779030539; cv=none; b=LkGAGZNiR6be3tcLYechfUtu1dGlTfuWBmVKgziW5rS/XN1WNrWe6w90pnSS8wLbc0UM8rYTRWeaGjxUgyoMFkLz6vJoJorshHpPAVsVFpl5pTNQAOMu07g85LM365uqikxswGnOr3wOd54s4rrLF9nr6J/ZEXbgi0ExQob0gAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779030539; c=relaxed/simple;
	bh=BrhS1N/4y6jBZDBzGcN0Xsxp0bQJYW6UXQ5HCG2yTzw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EXmXCIc8jOVxixGc9oKXtDehDCNu8M9DDpf2bSeHbZzE2lk52Nd+1FaPkY1NxktL+S2Jo9RbciKpI6KaiTVPRL6/dgWG/YFxdkVcGumg6Djr6r8Do3rfInVfsYpL8LxJAVJd8N9jDsiCGv+5Ta9WRm+loLAUuXwrNcR7J9e5duQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pyrY/a0X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pyrY/a0X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844BCC2BCB0;
	Sun, 17 May 2026 15:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779030539;
	bh=BrhS1N/4y6jBZDBzGcN0Xsxp0bQJYW6UXQ5HCG2yTzw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pyrY/a0XjQ3GHY4BZFM6plIuW2sSNRDbl+xuN6SMWkXWz0wAqpNbVdf5c6Tc8fElm
	 IMdblB0dK4I3tWVwSbkt3erH72FtaSQRJ0kdC3fk20QBEGJwWh8obVeIzOUH4imNw2
	 7sUCj8qtVUp1kKEtZj/aWyiQ7rhR2Utvm0DsAGq9wRnHY8ESKgsQaQ7HnvP06lrDc+
	 rSyyPFag+wwIp44Y84dwWoxVnjKewHnt5cF/M44HWD70wFsunlLPk87/YZxHwrlfO/
	 XQ1SpFCtIbr8L2sPVDDq1SB42g5wc4N8oaKvKuUrAcRxNlA6zLwEoa0xRnA7MjVLb4
	 OnWMST71KXkvw==
Date: Sun, 17 May 2026 16:08:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, "Gustavo A.
 R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH RFC v4 07/10] iio: frequency: ad9910: add output shift
 keying support
Message-ID: <20260517160852.7aee43e9@jic23-huawei>
In-Reply-To: <20260508-ad9910-iio-driver-v4-7-d26bfd20ee3d@analog.com>
References: <20260508-ad9910-iio-driver-v4-0-d26bfd20ee3d@analog.com>
	<20260508-ad9910-iio-driver-v4-7-d26bfd20ee3d@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 08 May 2026 18:00:23 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Add OSK channel with amplitude envelope control capabilities:
> - OSK enable/disable via IIO_CHAN_INFO_ENABLE;
> - Amplitude ramp rate control via IIO_CHAN_INFO_SAMP_FREQ;
> - Amplitude scale readback via IIO_CHAN_INFO_SCALE (ASF register);
> - Automatic OSK step size configurable througth the scale_roc extended
>   attribute, which allows for selectable step sizes in nano-units:
> 	- 0: no step, means manual mode (NOT pin controlled)
> 	- 61035: 1/2^14 step, automatic mode (pin controlled)
> 	- 122070: 2/2^14 step, automatic mode (pin controlled)
> 	- 244141: 4/2^14 step, automatic mode (pin controlled)
> 	- 488281: 8/2^14 step, automatic mode (pin controlled)
> 	- 1000000000: 1.0 step, manual mode (pin controlled)
> 
> The ASF register is initialized with a default amplitude ramp rate during
> device setup to ensure valid readback.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>


>  
> +#define AD9910_OSK_EXT_INFO(_name, _ident) \
> +	AD9910_EXT_INFO_TMPL(_name, _ident, IIO_SEPARATE, osk_attrs)
> +
>  static const struct iio_chan_spec_ext_info ad9910_phy_ext_info[] = {
>  	AD9910_EXT_INFO("powerdown", AD9910_POWERDOWN, IIO_SEPARATE),
>  	{ }
> @@ -1018,6 +1154,12 @@ static const struct iio_chan_spec_ext_info ad9910_drg_ramp_ext_info[] = {
>  	{ }
>  };
>  
> +static const struct iio_chan_spec_ext_info ad9910_osk_ext_info[] = {
> +	AD9910_OSK_EXT_INFO("scale_roc", AD9910_OSK_AUTO_ROC),
> +	AD9910_OSK_EXT_INFO("scale_roc_available", AD9910_OSK_AUTO_ROC_AVAIL),
same questions about whether we can transform these to voltages and hence
not scale (though arguably the main unit of an altvoltage channel is a scale
of a 1V peak amplitude sine wave but meh).

> +	{ }
> +};
