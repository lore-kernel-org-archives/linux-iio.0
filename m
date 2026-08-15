Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDC0301486;
	Sat, 15 Aug 2026 21:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786830837; cv=none; b=D64gyE6VNTwlc9U8sTk19ACwGLegYjegt4+yfKnjasTi3jGWx/v497UBqlKjgjdZR+4IaPcAbIvZlvxX4Qb6rcKh77wp3stDFNwuFYVNO/KIN18/iIyhCMFMXxLEyb/lO890rMvfLj8UB3raLU/9sOSs6mk75nCfS6URKLR6y9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786830837; c=relaxed/simple;
	bh=VXmq9K/HRCVD/gkYVmOmNvAEYGioPR9ndL6kBSh4Q1s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dLK9kY56DHP9kDkz7fXPV8ShQb2FUez2gOriKMPOVkc0vQRQjhMrfwEh5RplXvAIAkAnD+8HmOn9G7jYd67fXwwScjzvkJPHJZsAeAOZcZR31NA7tDjtCwaNyOB3ikvgIJKLXlhNrSECNBrigFDvJrW84Qpu5t025P37Z074KFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2YM3pUO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2YM3pUO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CCFD1F000E9;
	Sat, 15 Aug 2026 21:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786830836;
	bh=Mng5BWniPeM9reYy1Ta8r3Rg3KlW7xeXbQGcgXUrO34=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=P2YM3pUORIKpEYq4xfYIc2GwhcWeDZbxxcP4lsSSZX/EuKfkGIWFksrUm593hpj2V
	 QQPywa1gnaeYt6zSlInPsAX27cRe8s3RcSoAyIxeR6w8UaWMRtczvz/33lIgHFTDkV
	 CZWbqITuvZ9Z20aWtrPOtTot/pwF5WNkbuR7C5IPRM1mACFS+UKhF04YIcaSEpkFaj
	 AsBRHxRNvFa14B/+nZEevp/yHgMvu7ZdmFwijPehZABB8DJ4Ozke5BAzm8GXCwkphl
	 Ao0gYq+evbHOqdOXx9cBoRRFKCyhJcfkOx4HrsAH7Wmi5hrAY8u2p68T84DqkrKYJ1
	 F2EvcDDE3s9rw==
Date: Sat, 15 Aug 2026 22:53:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Mark Brown <broonie@kernel.org>, Marius Cristea
 <marius.cristea@microchip.com>, Marcus Folkesson
 <marcus.folkesson@gmail.com>, Kent Gustavsson <kent@minoris.se>, Conor
 Dooley <conor.dooley@microchip.com>, Daire McNamara
 <daire.mcnamara@microchip.com>, Paul Walmsley <pjw@kernel.org>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre
 Ghiti <alex@ghiti.fr>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, Janani Sunil <jan.sun97@gmail.com>,
 <linux-spi@vger.kernel.org>, Kent Gustavsson <nedo80@gmail.com>,
 <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v8 3/3] iio: dac: Add AD5529R DAC driver support
Message-ID: <20260815225348.7a3bef4d@jic23-huawei>
In-Reply-To: <20260805-ad5529r-driver-v8-3-b41781f5632a@analog.com>
References: <20260805-ad5529r-driver-v8-0-b41781f5632a@analog.com>
	<20260805-ad5529r-driver-v8-3-b41781f5632a@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Aug 2026 09:17:43 +0200
Janani Sunil <janani.sunil@analog.com> wrote:

> Add support for AD5529R 16-channel, 12/16 bit Digital to Analog Converter
> from Analog Devices.
> 
> The device communicates over SPI and supports per-channel output range
> configuration. An optional external 4.096V reference can be used in
> place of the internal reference.
> 
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> ---
>  MAINTAINERS               |   1 +
>  drivers/iio/dac/Kconfig   |  17 ++
>  drivers/iio/dac/Makefile  |   1 +
>  drivers/iio/dac/ad5529r.c | 530 ++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 549 insertions(+)
> 
>

...

> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index 657c68e75542..bb1d59889a2a 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -134,6 +134,23 @@ config AD5449
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ad5449.
>  
> +config AD5529R
> +	tristate "Analog Devices AD5529R High Voltage DAC driver"
> +	depends on SPI_MASTER
> +	select REGMAP_SPI
> +	help
> +	  Say yes here to build support for Analog Devices AD5529R
> +	  16-Channel, 12-Bit/16-Bit, 40V High Voltage Precision Digital to Analog

Trivial but this wrap is rather random. Please tidy it up to a consistent 80 chars

> +	  Converter.
> +
> +	  The device features multiple output voltage ranges from -20V to +20V,
> +	  built-in 4.096V voltage reference, and digital functions including
> +	  toggle, dither, and ramp modes. Supports both 12-bit and 16-bit
> +	  resolution variants.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called ad5529r.
> +
>  config AD5592R_BASE
>  	tristate

