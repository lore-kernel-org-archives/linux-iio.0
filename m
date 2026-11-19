Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795056714;
	b=kmQU24qSup66dw63napBUerCw765Dcy8nt/zDE/anMA20q64M/QDBUVSAaJYnXNn9pBL
	 M/A+W812O6UUX/CnCa5j20mMJsLaRtvVagbKsJjpfo6VkWPMne1VUe6qU5edXL9N35azy
	 60ABJ+0T8Vz5hBFHNbg27lbGZDugwMxukD3sYTXXGBj/FeWOMI06RIfVc7S5s/Eulh2f/
	 oFJwbRy7CJUBQP4d+chfWTGfN3pbPYbME/6c0JfD5Rqpe5pxy2qGUYYMaiPpSmSM4vfpY
	 kQaTbCtJEtthejanjyy9/t1/BhsQhgTazOUidTdbvbgscHAlRdbWS6Vi5ozmNaDn41Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795056714;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=bxJ1QsjcA84NtK8BZImOuMZQHPOD+tUwg5vhPEZiIYE=;
	b=EVBvxkyoCamyhEYT0qlYRrTh+HhC0Er8dGk14GdhJ+BH49WSMSq2e0UWCPoRLjUYSCZy
	 ncOluxgeoCa6SpHgyD+uPn3gLG1pHd638Ze3jpDVoJUzGr1EHxLLabcARcQmNr5QK/HAC
	 XwExmp6xJQ3KQ1PF/1FVgs7TTkaq4rZxLi0CLcWNAhAoAivHHvcOZH4BkOT4+hZBvEziU
	 W4rC3N5x1cIkLX8IVjp2WIgaPviCAq3h3vJHZBifLD9KeOa2r3oLW3t0kAJbWcJ7mD+TX
	 nsEgnFKdqSw+33zR1owKjOYH7TP6we8nfw1VKslpMRNpZnqbR78z6au7FIw2sb6PUoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E1GOoGlL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E55606A325;
	Thu, 19 Nov 2026 02:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E1GOoGlL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A0CC1F000C7;
	Thu, 19 Nov 2026 02:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795056714;
	bh=bxJ1QsjcA84NtK8BZImOuMZQHPOD+tUwg5vhPEZiIYE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=E1GOoGlLvVaDMM03XLMPFF+kvutUikvXUnFnWLzq2yTd0LxjZEyiB2YXUed2GHUTK
	 hkXj7Duwd2wLUm5PtD8U44ygnjANAnxXAA9mnu3P3azPAUhESJp/3/vCMtcF2vu1SW
	 clhxG+crZKNXnAL/jJbhW/fC+nE/8N9M3jO6ztOLp1y5RFJ+zoqH2ibh2SZnkSFA52
	 RzLSpbjIWU81IhspbK+mCFS39Y46/81nDxT6Ik1/AfWqyUY7H6vscksFrIEpu7k3H1
	 eBTAC4Obu/Ayp/2RK/T/wJljrZPbGzkfRmQMIgN3xLHjUBXHVU0fPPG/tlKrr7QiIe
	 UxkZcLCUDquaQ==
Date: Thu, 19 Nov 2026 02:51:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <matti.vaittinen@linux.dev>, Jakub Szczudlo
 <jakubszczudlo40@gmail.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, Joshua Crofts <joshua.crofts1@gmail.com>,
 Radu Sabau <radu.sabau@analog.com>, Janani Sunil <janani.sunil@analog.com>,
 Salih Erim <salih.erim@amd.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: rohm-bd79112: Support ROHM BD79111
Message-ID: <20261119025137.6bfc27c2@jic23-hlaptop>
In-Reply-To: <ab74e547e892ccabb763a06e8231e8ed44f4fefb.1795009599.git.mazziesaccount@gmail.com>
References: <cover.1795009599.git.mazziesaccount@gmail.com>
	<ab74e547e892ccabb763a06e8231e8ed44f4fefb.1795009599.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Nov 2026 16:19:35 +0200
Matti Vaittinen <matti.vaittinen@linux.dev> wrote:

> From: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> ROHM BD79111 is very similar to the BD79112. Both are ADC/GPIO devices,
> where pins can be configured to be either used as GPIO or ADC inputs.
> ADCs are 12-bit SAR ADCs and GPIOs support input/output but not being IRQ
> sources.
> 
> The main difference is amount of channels/GPIOs. The BD79112 has 32 pins
> for this use, the BD79111 has 16. Furthermore, the BD79111 data-sheet
> promises 0.5 MSPS sample rate with maximum of 10 MHz SPI clock,  whereas
> the BD79112 data-sheet mentioned 1MSPS rate with maximum of 20 MHz SPI
> clock.
> 
> NOTE: In order to achieve those speeds one needs to use more optimized
> protocol compared to the one implemented in this driver. This driver
> retrieves samples using two 16-bit SPI transactions. The first
> transaction writes the channel to be sampled, and ignores data on MISO.
> Then the next 16-bit transaction carries the data.
> 
> Achieving maximum sample-rate would require the driver to interpret the
> MISO data of each 16-bit transaction so, that when the
> channel-to-be-sampled was sent in transaction N, the data is read at
> transaction N+1 - which also already configures the channel to be
> sampled for transaction N+2. Supporting this would require the
> channel-to-be-read for the future read to be known when the current
> channel data is retrieved. For raw-reads this is not possible and for
> buffered reads it would make things a bit hairy.

FWIW there are quite a few drivers implementing that scheme for
buffered capture.  Look for drivers that preprepare an SPI transfer.
Absolutely fine to not support that optimization!

This seems like text that probably applies to both parts rather than
being directly relevant to what is added here?  If you did add that
support it would be in a different patch.  I'd cut most of that info
to keep the commit message focused.

> 
> So, here we aim for simplicity instead of the peak performance.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> ---
>  drivers/iio/adc/Kconfig        |   9 +--
>  drivers/iio/adc/rohm-bd79112.c | 113 +++++++++++++++++++++++++++------
>  2 files changed, 98 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index a802d8ee4dd9..db9e0a0713e1 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1516,14 +1516,15 @@ config RN5T618_ADC
>  	  will be called rn5t618-adc.
>  
>  config ROHM_BD79112
> -	tristate "Rohm BD79112 ADC driver"
> +	tristate "ROHM BD79112 and BD79111 ADC/GPIO driver"
>  	depends on SPI && GPIOLIB
>  	select REGMAP_SPI
>  	select IIO_ADC_HELPER
>  	help
> -	  Say yes here to build support for the ROHM BD79112 ADC. The
> -	  ROHM BD79112 is a 12-bit, 32-channel, SAR ADC. Analog inputs
> -	  can also be used for GPIO.
> +	  Say yes here to build support for the ROHM BD79112 and BD79111
> +	  ADCs. Both of the ICs are 12-bit SAR ADCs. The ROHM BD79112 has
> +	  32-channels, the BD79111 has 16. Analog inputs can also be used
> +	  for GPIO.

Given it now supports 2 parts and I'm guessing more may be along in the future
you might want to jump directly to the style we have in some other kconfig
entries of vague option text and then a bulleted list of stuff about
specific devices.  That way a new part just requires a new bullet point,
nothing else changes.

>  
>  config ROHM_BD79124
>  	tristate "Rohm BD79124 ADC driver"
> diff --git a/drivers/iio/adc/rohm-bd79112.c b/drivers/iio/adc/rohm-bd79112.c
> index 2506fec7be84..604c6ccafb4f 100644
> --- a/drivers/iio/adc/rohm-bd79112.c
> +++ b/drivers/iio/adc/rohm-bd79112.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * ROHM ADC driver for BD79112 signal monitoring hub.
> + * ROHM ADC driver for BD79111 and BD79112 signal monitoring hubs.

Similar on possibly going vague. The firmware tables make it clear
on what is being supported.

>   * Copyright (C) 2025, ROHM Semiconductor.
>   *
>   * SPI communication derived from ad7923.c and ti-ads7950.c
> @@ -26,7 +26,17 @@
>  
>  #define BD79112_MAX_NUM_CHANNELS 32
>  
> +struct bd79112_data;
> +
> +struct bd7911x_chip_data {
> +	const char *name;
> +	const char * const *chan_names;
> +	unsigned int num_channels;
> +	int (*init_disable_gpios)(struct bd79112_data *data);
> +};
> +
>  struct bd79112_data {
> +	const struct bd7911x_chip_data *cd;
>  	struct spi_device *spi;
>  	struct regmap *map;
>  	struct device *dev;
> @@ -369,7 +379,6 @@ static int bd79112_gpio_output(struct gpio_chip *gc, unsigned int offset,
>  }
>  
>  static const struct gpio_chip bd79112_gpio_chip = {
> -	.label			= "bd79112-gpio",
>  	.get_direction		= bd79112_gpio_dir_get,
>  	.direction_input	= bd79112_gpio_input,
>  	.direction_output	= bd79112_gpio_output,
> @@ -378,20 +387,20 @@ static const struct gpio_chip bd79112_gpio_chip = {
>  	.set_multiple		= bd79112_gpio_set_multiple,
>  	.init_valid_mask	= bd79112_gpio_init_valid_mask,
>  	.can_sleep		= true,
> -	.ngpio			= 32,
>  	.base			= -1,
>  };

There are only two parts, maybe it is simpler to have dual gpio_chip
instances pointed to by your chip_data? Keep the full state of each in
one place?  I don't mind much either way on this.

> +static int bd79112_disable_gpios(struct bd79112_data *data)
> +{
> +	unsigned int i;
> +	int ret;
> +
> +	for (i = 0; i < BD79112_NUM_GPIO_EN_REGS; i++) {

These days the kernel style allows

	for (unsigned int i = 0; i < BD79112_NUM_GPIO_EN_REGS; i++) {
Same in various other places. Saves us a few lines of scrolling
and keeps the scope tight.

> +		ret = regmap_write(data->map, BD79112_FIRST_GPIO_EN_REG + i, 0);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
>

...

> +
> +/* The BD79111 channel names as in the data-sheet */
> +static const char * const bd79111_chan_names[] = {
> +	"AGIO0", "AGIO1", "AGIO2", "AGIO3",		/* 0 - 3 */
> +	"AGIO4", "AGIO5", "AGIO6", "AGIO7",		/* 4 - 7 */
> +	"AGIO8", "AGIO9", "AGIO10", "AGIO11",		/* 8 - 11 */
> +	"AGIO12", "AGIO13", "AGIO14", "AGIO15",		/* 12 - 15 */
> +};
> +
> +static const struct bd7911x_chip_data bd79111_chip_data = {
> +	.name = "bd79111",
> +	.chan_names = bd79111_chan_names,
> +	.num_channels = 16,
> +	.init_disable_gpios = bd79111_disable_gpios,
> +};
Ordering seems a little strange with the bd79112_chan_names no
where near the ones for the 1111
> +
> +static const struct bd7911x_chip_data bd79112_chip_data = {
> +	.name = "bd79112",
> +	.chan_names = bd79112_chan_names,
> +	.num_channels = 32,
> +	.init_disable_gpios = bd79112_disable_gpios,
> +};

