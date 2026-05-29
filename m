Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F94305673;
	Fri, 29 May 2026 10:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780048937; cv=none; b=dIU28v+TSad7LQeGU+Bz1Jx19nUhpcOnVJoM8RQA1xnpjvbwpB4C2SDWdvosfn/NjroC+5FDm2eBncY9lFw+puYyzt3x8p0bzVnK3749lfR0WjMLFvfKJk8PtRtBrcYnui00DxDRFKGbRg/V+parJmMEJEb9J45l1HLpCf67qwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780048937; c=relaxed/simple;
	bh=3fCLL/8ALQkJnOOC9sUU5x3LkrQZe3tHishjf7bod4o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MrQmGJlQgobRBcluh9k994f8eP5jn+WGAjEvNKlLMYlPxXSTL8yQHi9/8+etVcYmcN+K3u6sUDw3DgCCLvLdG86159kWahPMCAn6GvGeVbGmWkBozBEoAH1M0su4FXZH0e2/QL9szyGwW+CrNxLndWRhn0p0rt8wOyylt5AO2xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rf+ep/1s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rf+ep/1s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 568FC1F00893;
	Fri, 29 May 2026 10:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780048936;
	bh=KP/dBa4vlaAwTlWv9+FCkj19C58IqLkr8C9/6n44Wb4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Rf+ep/1sYiUublsEiU93nSRDxCA49iG0IH2vPiMUJNouijMfS9h22s1mpGWWzeSzJ
	 m/4aaPNYsh+lI8tGIIBLHoFxERSC1alzhdhHL1RzHCBZnYgk16WzgukAV75dXFGP3P
	 9mVVcHqitQpcleBwdMQ07S5LYLVoZZJzaJI0U6haVf5EFYr4ohU6M/BGWM1FWNImM5
	 +jpv3h+4LgmpX/EJn2AM00wrJmOQDPVUTd5e7h6wewVG5e8lLQ6Pn/3DupKv7ZqFYd
	 0CltbdnGeK+Zd2esa5DCakB0jOrLvQhSmKMZ5ovcfOigPgyD9JteCkB7ISbybxqZEz
	 nxvR1aAlWJz0w==
Date: Fri, 29 May 2026 11:02:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nuno.sa@analog.com>,
 <Michael.Hennerich@analog.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <pop.ioan-daniel@analog.com>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v2 2/4] iio: adc: ltc2378: Add support for LTC2378-20
 and similar ADCs
Message-ID: <20260529110205.2f91a1ed@jic23-huawei>
In-Reply-To: <40e1108bc9eaeba486705b54c4c94004f0e7f369.1779976379.git.marcelo.schmitt@analog.com>
References: <cover.1779976379.git.marcelo.schmitt@analog.com>
	<40e1108bc9eaeba486705b54c4c94004f0e7f369.1779976379.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 May 2026 12:03:52 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> Support for LTC2378-20 and similar analog-to-digital converters.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

As normal, our friendly AI had something to say:
https://sashiko.dev/#/patchset/cover.1779976379.git.marcelo.schmitt%40analog.com


A few other things inline from a fresh read.

>  M:	Michael Hennerich <michael.hennerich@analog.com>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 8550917226a1..70fec8e3e891 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -939,6 +939,18 @@ config LTC2309
>  	  This driver can also be built as a module. If so, the module will
>  	  be called ltc2309.
>  
> +config LTC2378
> +	tristate "Analog Devices LTC2378 ADC driver"
> +	depends on SPI
> +	depends on GPIOLIB || PWM

Triggered sashiko:
https://sashiko.dev/#/patchset/cover.1779976379.git.marcelo.schmitt%40analog.com
This dependency is odd enough that I think I'd add a comment on why.
Also bring in the dependency on PWM in the patch that needs it not this one.

Will it build without gpiolib? If so I'd prefer that to be a || COMPILE_TEST
just to get a little more coverage.


> +	select IIO_BUFFER
This doesn't seem to be needed yet either.

> +	help
> +	  Say yes here to build support for Analog Devices LTC2378-20 and
> +	  similar analog to digital converters.
> +
> +	  This driver can also be built as a module. If so, the module will
> +	  be called ltc2378.
> +

> diff --git a/drivers/iio/adc/ltc2378.c b/drivers/iio/adc/ltc2378.c
> new file mode 100644
> index 000000000000..bdff98157979
> --- /dev/null
> +++ b/drivers/iio/adc/ltc2378.c
> @@ -0,0 +1,342 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Analog Devices LTC2378 ADC series driver
> + *
> + * Copyright (C) 2026 Analog Devices Inc.
> + * Author: Ioan-Daniel Pop <pop.ioan-daniel@analog.com>
> + * Author: Marcelo Schmitt <marcelo.schmitt@analog.com>
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/bits.h>
> +#include <linux/cleanup.h>
> +#include <linux/delay.h>

dev_prink.h missing for dev_err_probe()

> +#include <linux/err.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/types.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/types.h>
> +
> +#include "ltc2378.h"

> +static int ltc2378_convert_and_acquire(struct ltc2378_state *st)
> +{
> +	int ret;
> +
> +	/* Cause a rising edge of CNV to initiate a new ADC conversion */
> +	gpiod_set_value_cansleep(st->cnv_gpio, 1);

Should we check for errors on setting the gpio?

> +	fsleep(4);
> +	ret = spi_sync_transfer(st->spi, &st->xfer, 1);
> +	gpiod_set_value_cansleep(st->cnv_gpio, 0);
> +
> +	return ret;
> +}
> +
> +static int ltc2378_channel_single_read(const struct iio_chan_spec *chan,
> +				       struct ltc2378_state *st, int *val)
> +{
> +	const struct iio_scan_type *scan_type = &chan->scan_type;
> +	u32 sample;
> +	int ret;
> +
> +	ret = ltc2378_convert_and_acquire(st);
> +	if (ret)
> +		return ret;
> +
> +	if (scan_type->realbits > 16)
> +		sample = st->scan.data.sample_buf32;

Sashikio has an interesting theory here that you need a shift. I can't immediately
spot why it is wrong.  Given we are clocking in 32bits I assume the first
res_bits are valid then we get a bunch of garbage after that. Given it's MSB first
the SPI controller should put those in the top bits of the resulting u32 with the
garbage at the bottom. So shouldn't we shift them down by 32 - resolution or something
like that? + in buffered case provide the relevant shift value (in later patches)

> +	else
> +		sample = st->scan.data.sample_buf16;
> +
> +	if (scan_type->format == IIO_SCAN_FORMAT_SIGNED_INT)
> +		*val = sign_extend32(sample, scan_type->realbits - 1);
> +	else
> +		*val = sample;
> +
> +	return 0;
> +}
> +
> +static int ltc2378_read_raw(struct iio_dev *indio_dev,
> +			    const struct iio_chan_spec *chan,
> +			int *val, int *val2, long info)
> +{
> +	struct ltc2378_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW:

case IIO_CHAN_INFO_RAW: {

> +		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
> +		if (IIO_DEV_ACQUIRE_FAILED(claim))
> +			return -EBUSY;
> +
> +		ret = ltc2378_channel_single_read(chan, st, val);
> +		if (ret)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +
}

As that IIO_DEV_ACQUIRE_DIRECT_MODE() is declaring a local variable
so there is something go out of scope and result in cleanup.
LLVM moans about this, GCC just does the wrong thing which can in theory
at least result in an underflow.
You'll get build bot warnings on this - bug sashiko caught it.

> +	case IIO_CHAN_INFO_SCALE:
> +		*val = st->ref_uV / MILLI;
> +		/*
> +		 * For all LTC2378-like devices, the amount of bits that express
> +		 * voltage magnitude depend on the output code format:
> +		 * - straight binary: All precision/resolution bits are used.
> +		 * - 2's complement: One of the precision bits is used for sign.
> +		 */
> +		if (st->info->twos_comp)
> +			*val2 = st->info->resolution - 1;
> +		else
> +			*val2 = st->info->resolution;
> +
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}



> +
> +MODULE_AUTHOR("Ioan-Daniel Pop <pop.ioan-daniel@analog.com>");

I'm a bit curious on this - listing an module author but not tags?  Maybe
provide some context in the patch description or a tag if appropriate.

> +MODULE_AUTHOR("Marcelo Schmitt <marcelo.schmitt@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices LTC2378 ADC series driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/iio/adc/ltc2378.h b/drivers/iio/adc/ltc2378.h
> new file mode 100644
> index 000000000000..399e8f67cd0e
> --- /dev/null
> +++ b/drivers/iio/adc/ltc2378.h
> @@ -0,0 +1,47 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Analog Devices LTC2378 and similar ADCs common definitions and properties
> + * Copyright (C) 2026 Analog Devices, Inc.
> + * Author: Marcelo Schmitt <marcelo.schmitt@analog.com>
> + */
> +
> +#ifndef __DRIVERS_IIO_ADC_LTC2378_H__
> +#define __DRIVERS_IIO_ADC_LTC2378_H__
> +
> +#include <linux/iio/iio.h>
> +#include <linux/spi/spi.h>
> +#include <linux/types.h>
> +#include <linux/units.h>
> +
> +#define LTC2378_TDSDOBUSYL_NS		5
> +#define LTC2378_TBUSYLH_NS		13
> +#define LTC2378_TCNV_HIGH_NS		20
> +
> +struct ltc2378_chip_info {
> +	const char *name;
> +	int resolution;
> +	bool twos_comp; /* Output code is 2's complement or straight binary */

I think this would be more intuitive if was the terminology of the datasheet
so bipolar (vs unipolar).  Or is there a case where something more complex is
going on like offset binary rather than 2s comp?


> +};
> +
> +struct ltc2378_state {
> +	const struct ltc2378_chip_info *info;
> +	struct gpio_desc *cnv_gpio;
> +	struct spi_device *spi;
> +	struct spi_transfer xfer;
> +	struct iio_chan_spec chans[2]; /* 1 physical chan + 1 timestamp chan */
> +	int ref_uV;
> +
> +	/*
> +	 * DMA (thus cache coherency maintenance) requires the
> +	 * transfer buffers to live in their own cache lines.
> +	 */
> +	struct {
> +		union {
> +			u16 sample_buf16;
> +			u32 sample_buf32;
> +		} data;
> +		aligned_s64 timestamp;
> +	} scan __aligned(IIO_DMA_MINALIGN);
> +};
> +
> +#endif /* __DRIVERS_IIO_ADC_LTC2378_H__ */

