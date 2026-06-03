Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1FA30FF08;
	Wed,  3 Jun 2026 12:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780490524; cv=none; b=JFVFAehOYow5nNdLtDsw1Pa3s6X3bpAwiD39rm2usW86S3wadFnWKK0rWM9lPpse8q8GE4He28e1zmYpdAV5rN3gnXWuA5/pPeJuOxgSyqPe7+S9UKBnmuGDJEqKUy8h58C4XkHbPbH+OvchrAeD0eIa/pAO+C7AIRwsp6+TLTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780490524; c=relaxed/simple;
	bh=dWwGk9rQfTnjchtezlSWjb+t1YEjffClPqKEsjmAgZA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sADotwpGLPubRdtJujTSNp/zMdo6jABwmG5kcq3v5pkjED/TkK2tmfb8ukhNeqRJcVdkMTcNa8hNxIZ5+QJvmFM/J2U/rPAlVuYJ+mJQMilMSDLlHytm080sq5kkbzQO/g/G8NMciwW7ogbHydc6ppALLGZZdy7jJSEpO7kcDPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aeil1ksO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aeil1ksO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C021F00893;
	Wed,  3 Jun 2026 12:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780490523;
	bh=G8yheY5+6eUkXr3fPaoHOlmsKDT+Lz00pXPX5Sex3X8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Aeil1ksOTAsuqE72xZUS5FbFWWbX8seUrg32UHwTUpr1sOm+iTHTUJt1W/RFlPcEv
	 uBv4MTbQa/YaGHCWajre1k4IPvhmyRsCr7pUuY+0q2Iab4Mowuc7iA4JBF2DsJSAk+
	 3Vwr3WdH41x9hNdBEJjr2gAEmZrKpZQHig9tI4Ck/X/rJnmPH8OJCpxZSV35KwE1vK
	 fNyqiQCegm0CcrxgMUJZzzigpFV5dV8Ia5PYWfIZPcfCi53w+9rn/mcBGhWbuYp30Y
	 ScFPsqr8JCw0UkziI7XxEP2WYAbaTOZ3AUrsTYCdJP5sZ1m1m8/P2eFzHTEb9CJJo1
	 YVTkNEJ5hXtiA==
Date: Wed, 3 Jun 2026 13:41:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, Michael Auchter <michael.auchter@ni.com>,
 linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook
 <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH 10/12] iio: dac: ad5686: add triggered buffer support
Message-ID: <20260603134151.7cf1654b@jic23-huawei>
In-Reply-To: <20260602-ad5686-new-features-v1-10-691e01883d27@analog.com>
References: <20260602-ad5686-new-features-v1-0-691e01883d27@analog.com>
	<20260602-ad5686-new-features-v1-10-691e01883d27@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 02 Jun 2026 17:33:57 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Implement trigger handler by leveraging the LDAC gpio to update all DAC
> channels at once when it is available. Also, the multiple channel writes
> can be flushed at once with the sync() operation.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
One passing comment inline. + some musings... I'd love to avoid
the need for lots of drivers to call iio_trigger_notify_done() manually
as it always results in ugly code paths.  
> ---
>  drivers/iio/dac/Kconfig  |  2 ++
>  drivers/iio/dac/ad5686.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 61 insertions(+)
> 
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index 657c68e75542..5f14fcd780e2 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -240,6 +240,8 @@ config LTC2688
>  
>  config AD5686
>  	tristate
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
>  
>  config AD5686_SPI
>  	tristate "Analog Devices AD5686 and similar multi-channel DACs (SPI)"
> diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> index a4cc0f86ea54..5052df44ab1c 100644
> --- a/drivers/iio/dac/ad5686.c
> +++ b/drivers/iio/dac/ad5686.c
> @@ -19,7 +19,11 @@
>  #include <linux/sysfs.h>
>  #include <linux/wordpart.h>
>  
> +#include <linux/iio/buffer.h>
>  #include <linux/iio/iio.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
>  
>  #include "ad5686.h"
>  
> @@ -245,6 +249,7 @@ static const struct iio_chan_spec_ext_info ad5686_ext_info[] = {
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),\
>  		.address = addr,				\
> +		.scan_index = chan,				\
>  		.scan_type = {					\
>  			.sign = 'u',				\
>  			.realbits = (bits),			\
> @@ -469,6 +474,53 @@ const struct ad5686_chip_info ad5679r_chip_info = {
>  };
>  EXPORT_SYMBOL_NS_GPL(ad5679r_chip_info, "IIO_AD5686");
>  
> +static irqreturn_t ad5686_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct iio_buffer *buffer = indio_dev->buffer;
> +	struct ad5686_state *st = iio_priv(indio_dev);
> +	u16 val[AD5686_MAX_CHANNELS] = { };
> +	int ret, ch, i = 0;
> +	bool async_update;
> +	u8 cmd;
> +
> +	ret = iio_pop_from_buffer(buffer, val);
> +	if (ret)
> +		goto out;
> +
> +	mutex_lock(&st->lock);
> +
> +	async_update = st->ldac_gpio && bitmap_weight(indio_dev->active_scan_mask,
> +						      iio_get_masklength(indio_dev)) > 1;
> +	if (async_update) {
> +		/* use ldac to update all channels simultaneously */
> +		cmd = AD5686_CMD_WRITE_INPUT_N;
> +		gpiod_set_value_cansleep(st->ldac_gpio, 0);
> +	} else {
> +		cmd = AD5686_CMD_WRITE_INPUT_N_UPDATE_N;
> +	}
> +
> +	iio_for_each_active_channel(indio_dev, ch) {
> +		ret = st->ops->write(st, cmd, indio_dev->channels[ch].address, val[i++]);
> +		if (ret)
> +			goto cleanup;
> +	}
> +
> +	if (st->ops->sync)
> +		ret = st->ops->sync(st); /* flush all pending transfers */
> +
> +cleanup:
> +	if (async_update)

Error paths are always fun.  Do we care about setting ldac_gpio to 1 if
we failed to write the channel values?  That will set any that did successfully
update, but not all of them.  Note I'm not sure on the right answer for this.
There may not be one!


> +		gpiod_set_value_cansleep(st->ldac_gpio, 1);
> +
> +	mutex_unlock(&st->lock);
> +out:
> +	iio_trigger_notify_done(indio_dev->trig);
We get this pattern so often (though not always).  Feels like maybe
we should put some effort into a generic opt in solution for this.

A job for another day but options that come to mind.
1) (hideous) a flag
2) Maybe an alternative callback. thread_always_complete or
   something like that.  Pain to wire through all the calls though
   and injecting the necessary wrapper isn't great either.
   Implementation wise would be a case of popping in a wrapper function
   in iio_trigger_attach_poll() call to request_threaded_irq().
3) Maybe a helper macro?  Bit ugly as we'd need one to generate
   the wrapper function and another to use the same name for
   the registration function.

Hmm. Those are all ugly (maybe 2 is ok ish).  Suggestions welcome!


> +
> +	return IRQ_HANDLED;
> +}
> +
>  int ad5686_probe(struct device *dev,
>  		 const struct ad5686_chip_info *chip_info,
>  		 const char *name, const struct ad5686_bus_ops *ops,
> @@ -569,6 +621,13 @@ int ad5686_probe(struct device *dev,
>  		return -EINVAL;
>  	}
>  
> +	ret = devm_iio_triggered_buffer_setup_ext(dev, indio_dev, NULL,
> +						  &ad5686_trigger_handler,
> +						  IIO_BUFFER_DIRECTION_OUT,
> +						  NULL, NULL);
> +	if (ret)
> +		return ret;
> +
>  	return devm_iio_device_register(dev, indio_dev);
>  }
>  EXPORT_SYMBOL_NS_GPL(ad5686_probe, "IIO_AD5686");
> 

