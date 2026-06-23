Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35CA3090E8;
	Tue, 23 Jun 2026 15:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782230208; cv=none; b=lBTwLouxgdn9V42C1rmBZkFaH0yMe737UQdFw3DUBCtmU7uF3WsBzeszeWwG4YNT/h4aiEfGp1aKTKupCPGVz0zJP+cb6LxoELvSL2tkcRWg101iy+C7z5COSaRb0H+rtoRVkf6HJZIJBMlZrQeGhgYF7929gsVK4EbXm6gkS0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782230208; c=relaxed/simple;
	bh=MOPMmBvmvgH/fPeu1s8s0Wbs9rYPlq8jdiHdrLvfqdk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nShBpzTi/rgpAQ9KlV6adHiSGAWDmOO4TgxeZ+XUotewN3hi5VX3BAS3Po27DlTMGow/SiYd4Rq7xRxvPtpd9Pbc3G8CjJ5G6qD5Dh+KB4futJwYSbfkOpVkPRQQe+gMgcuX6hHB5xQO88mfNan4hvy0xqPY2u54Xz9UNfY8Qvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QsYuTChn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QsYuTChn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 210321F000E9;
	Tue, 23 Jun 2026 15:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782230207;
	bh=nLEYLjeqn7OPYoPLTEzHxuJ3J+jRv39rXz92UC3ebe0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QsYuTChn82Ii6KiDakW1WTeR12iY9RX74Ck3wCkkhUKTbwKgxy7+VxrJx0PJmPdqF
	 FfvuoLWVXeBAdAcc7OzCZIUXhikibBRphzt5JrwBegtP9hl8iymvrWx6+iUxLTtSXI
	 KnqliXVBVzUVr2Z0+yXhlNSChuBtyBrTroyZtUJpuRNBoq+z87umGQ2REuFLq4IJNk
	 wufpWj+h+YSHuHjs/nxHZIB9ownHaEoq7xkgJiEWa7gsu990FXm2BMKlCxqJDq4JYN
	 /CAJBm6xYwsL3NVoNOzAKD6uFaWmTzCdonc9xtA1xrK8c8oNU4PnrU8Mt6PNlJluVR
	 gN/hzIgaET5Tg==
Date: Tue, 23 Jun 2026 16:56:35 +0100
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
Subject: Re: [PATCH v4 11/12] iio: dac: ad5686: add triggered buffer support
Message-ID: <20260623165635.5997d049@jic23-huawei>
In-Reply-To: <20260623-ad5686-new-features-v4-11-28962a57db0f@analog.com>
References: <20260623-ad5686-new-features-v4-0-28962a57db0f@analog.com>
	<20260623-ad5686-new-features-v4-11-28962a57db0f@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jun 2026 11:55:51 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Implement trigger handler by leveraging the LDAC gpio to update all DAC
> channels at once when it is available. Also, the multiple channel writes
> can be flushed at once with the sync() operation.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
Hi Rodrigo

A follow up on the rework you did for this version,

Thanks,

Jonathan

> diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> index db175e77b0b7..4dc681eb077d 100644
> --- a/drivers/iio/dac/ad5686.c
> +++ b/drivers/iio/dac/ad5686.c

> @@ -467,6 +472,60 @@ const struct ad5686_chip_info ad5679r_chip_info = {
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
> +	unsigned int scan_count, ch, i;
> +	bool async_update;
> +	int ret;
> +	u8 cmd;
> +
> +	ret = iio_pop_from_buffer(buffer, val);
> +	if (ret) {
> +		iio_trigger_notify_done(indio_dev->trig);

I think I'd prefer a wrapper to this if we are going to always say
it is IRQ_HANDLED (which is reasonable here I think)
Something like the following (unfortunately I only just read the
previous version thread so didn't head off the approach you have here.


static void do_ad5686_trigger_handler(struct iio_dev *indio_dev)
{
	struct iio_buffer *buffer = indio_dev->buffer;
	struct ad5686_state *st = iio_priv(indio_dev);
	u16 val[AD5686_MAX_CHANNELS] = { };
	int ret;

	ret = iio_pop_from_buffer(buffer, val);
	if (ret) {
		iio_trigger_notify_done(indio_dev->trig);

	guard(mutex)(&st->lock);

	guts of current function
}

static irqreturn_t ad5686_trigger_handler(int irq, void *p)
{
	struct iio_poll_func *pf = p;
	struct iio_dev *indio_dev = pf->indio_dev;

	do_ad5686_trigger_handler(indio_dev);
	iio_trigger_notify_done(indio_dev->trig);
	return IRQ_HANDLED;
}



> +		return IRQ_HANDLED;
> +	}
> +
> +	guard(mutex)(&st->lock);
> +
> +	scan_count = bitmap_weight(indio_dev->active_scan_mask,
> +				   iio_get_masklength(indio_dev));
> +	async_update = st->ldac_gpio && scan_count > 1;
> +	if (async_update) {
> +		/* use LDAC to update all channels simultaneously */
> +		cmd = AD5686_CMD_WRITE_INPUT_N;
> +		gpiod_set_value_cansleep(st->ldac_gpio, 0);
> +	} else {
> +		cmd = AD5686_CMD_WRITE_INPUT_N_UPDATE_N;
> +	}
> +
> +	i = 0;
> +	iio_for_each_active_channel(indio_dev, ch) {
> +		ret = st->ops->write(st, cmd, indio_dev->channels[ch].address, val[i++]);
> +		if (ret)
> +			break;
> +	}
> +
> +	/*
> +	 * If sync() is available, it is called here regardless of write
> +	 * failure to allow bus implementation to reset. In that case, partial
> +	 * writes are unlikely as the write operations would just queue up
> +	 * the transfers.
> +	 */
> +	if (st->ops->sync)
> +		st->ops->sync(st);
> +
> +	if (async_update)
> +		gpiod_set_value_cansleep(st->ldac_gpio, 1);
> +
> +	iio_trigger_notify_done(indio_dev->trig);
> +	return IRQ_HANDLED;
> +}

