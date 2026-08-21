Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEBC352027;
	Fri, 21 Aug 2026 01:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787276713; cv=none; b=TlZ4H5LlFR+f9x1SHEhwHYLwPMOu25ApMu7yyx7mpTgfjD4MFzBK7ZSCYNqgEwPfaHNYJ3fO1gm8ixhlrlxzUgQmPhhBbPF+MdmMwNjp9A4a8ZJhgJj49DM9wSZqSUnvJx8ckPCfojXEvVboHXnWcPzbRZoK/lpRlTNsvIlDT98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787276713; c=relaxed/simple;
	bh=PXiw9K4AFbnDESdurcXExOBFyKCXQyrWUDtldgXv7/w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oiHu6oapdtO4SLwkUe9YDS6r9amhf8FNVbg59cWKcqWYJrxTpBLZkAmoWKmohiS7h+uZcDQsqpLBWce+bFN7YJNrZCJW2mXFujLuSAPRLTmQobHc7jKtca/V9AKuA5afnmVb2Y8HfC2WywOUS4CkkjjbrgOPwsLwARfJO2k9a6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMcY7emr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMcY7emr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E931F000E9;
	Fri, 21 Aug 2026 01:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787276711;
	bh=EytWCRbUnZTggNNvhZbYX0Ci1gaj4r9l+nuPXwpNRxU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EMcY7emrBcx15ZBTZ9TyK2MNPtpanSb+MnUMIopeyZQcYhyTLsHpuigLAJUQwo7FM
	 F2qdP4ym5yj4H2OkwR74YGulydlBbmWsQbisAo1Lg073q9qvTFNJEuWkEd8sF6dRcI
	 aAbONeH74vvBPwUG9wQ35Hn9CASAEdCPaNeKDFK4ePSCHBpS1MIcBGXndg/5mFBzIp
	 Lw6phJWkQVCzV8Nju3i6P9k5kWuQSSDHOAO8iQ5IPyyldY5t5AyZsvsfZInb/YxX2T
	 8/athXNG1bCGTDhb5o6JEiYSli5CjGCrrwB5diUDx8ggSJbPvu7sFTTIyLQJ+1dnjZ
	 4HFIUzpC5lyVQ==
Date: Fri, 21 Aug 2026 02:45:03 +0100
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
 <marcus.folkesson@gmail.com>, Kent Gustavsson <kent@minoris.se>, Conor
 Dooley <conor.dooley@microchip.com>, Daire McNamara
 <daire.mcnamara@microchip.com>, Paul Walmsley <pjw@kernel.org>, "Palmer
 Dabbelt" <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 "Alexandre Ghiti" <alex@ghiti.fr>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, Janani Sunil <jan.sun97@gmail.com>,
 <linux-spi@vger.kernel.org>, Kent Gustavsson <nedo80@gmail.com>,
 <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v9 3/3] iio: dac: Add AD5529R DAC driver support
Message-ID: <20260821024503.592fabc1@jic23-huawei>
In-Reply-To: <20260820-ad5529r-driver-v9-3-ba62e0b2a816@analog.com>
References: <20260820-ad5529r-driver-v9-0-ba62e0b2a816@analog.com>
	<20260820-ad5529r-driver-v9-3-ba62e0b2a816@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Aug 2026 09:08:23 +0200
Janani Sunil <janani.sunil@analog.com> wrote:

> Add support for AD5529R 16-channel, 12/16 bit Digital to Analog Converter
> from Analog Devices.
> 
> The device communicates over SPI and supports per-channel output range
> configuration. An optional external 4.096V reference can be used in
> place of the internal reference.
> 
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
Sashiko calls out that dependency should be on CONFIG_SPI.

I didn't check it's reasoning but I believe the conclusion is correct.
If that's all that comes up, I can tweak whilst applying.

Looks good to me, but I'll leave it on list for a little longer
as we aren't in a rush and others may well want to review.

Thanks,

Jonathan

> ---
>  MAINTAINERS               |   1 +
>  drivers/iio/dac/Kconfig   |  16 ++
>  drivers/iio/dac/Makefile  |   1 +
>  drivers/iio/dac/ad5529r.c | 538 ++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 556 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 320e84765ce6..143714e27d51 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1513,6 +1513,7 @@ L:	linux-iio@vger.kernel.org
>  S:	Supported
>  W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/dac/adi,ad5529r.yaml
> +F:	drivers/iio/dac/ad5529r.c
>  
>  ANALOG DEVICES INC AD5706R DRIVER
>  M:	Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index 657c68e75542..6a7109f42f2a 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -134,6 +134,22 @@ config AD5449
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ad5449.
>  
> +config AD5529R
> +	tristate "Analog Devices AD5529R High Voltage DAC driver"
> +	depends on SPI_MASTER

depends on SPI

> +	select REGMAP_SPI
> +	help
> +	  Say yes here to build support for Analog Devices AD5529R 16-Channel,
> +	  12-Bit/16-Bit, 40V High Voltage Precision Digital to Analog Converter.
> +
> +	  The device features multiple output voltage ranges from -20V to +20V,
> +	  built-in 4.096V voltage reference, and digital functions including
> +	  toggle, dither, and ramp modes. Supports both 12-bit and 16-bit
> +	  resolution variants.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called ad5529r.
> +

