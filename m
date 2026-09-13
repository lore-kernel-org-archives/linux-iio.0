Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E5F385D99;
	Sun, 13 Sep 2026 21:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789333989; cv=none; b=cObdVMDkd8ogNYrqN7+pDfg403vhLgzngvmeJnB5yDQAPMEu3hsKAKfzkvma0bvMkBUx0UrpCZG8DQzptahJjd3lqA0dJdBTRI4fhiUlxD4O38g1AMAEpKW8mfuizm9lazwygBuPHLtI6R0TS/edIf0nFAHk0Hp8dIIF3AZdU9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789333989; c=relaxed/simple;
	bh=+d/lh5DJv6MPiuKXlkq2cmrtVHlLE/IKuohjiN3wfUg=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=NkXdUag64ePK5QAwrOFLO7gWUb+QrTrh1oFDp6wQbWN0prWqoVufnIasWaeKKx5gVzY9I2bGG2KuHHlAu2hrIEXIqQDNSQB9KLdU4iYeZbsX8ukRbrDf4k1GzMHLAGv/9g2Rfoq37VwXBUgKQ5rG3mBel9iVm+2hWtuXP5vnQGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbObMo4M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbObMo4M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 715901F0089C;
	Sun, 13 Sep 2026 21:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789333988;
	bh=fNU6spacZC9x2DSiVNulGkZIv+BkR2lK54dDzHNZwo0=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=bbObMo4MjPXMkWowtU0MPQrZX4XoHLFOs3+di4TG0F7KTk7oNjQcgd1jzxiyzmxlb
	 D4Tz0fj5iigh+/sA/yjMxCxBUPn8jvMkgRA9EecreJVWK1Dv9emK2WjBUhRVZ2XheH
	 bMSIGT3eNvNKKw9fayb1weS50IkB7JWVn4FmwXzp9FI+DpsHvYfTGKWXN3BiRsk8Tv
	 A5jDljstQYS3wUPrk7Hbcxz0VBT8t6EZX/DTSJpbPh6Qbba9iBrdQ7YxQ3UV059nIf
	 qXE6tK0iElNuG/z5eLY2ddwIgmXPFMTIqoa08GElOrym4eFkh3CjIVp2ZMp1o9isYm
	 rg+l2Ssg1+jjA==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 5/9] iio: adc: rzt2h: implement DMA buffer support
From: Jonathan Cameron <jic23@kernel.org>
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260910085430.3173166-6-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260910085430.3173166-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20260910085430.3173166-6-cosmin-gabriel.tanislav.xa@renesas.com>
Date: Sun, 13 Sep 2026 22:12:40 +0100
Message-Id: <178933396020.413489.10390213220170464845.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5661;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=+d/lh5DJv6MPiuKXlkq2cmrtVHlLE/IKuohjiN3wfUg=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqpxHhHgdV+PPZf8PIaC3OyS2g+7MVA6SYBD76K
 dGtllT12+mJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCaqcR4REcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiG1nD/sFyWcdlXRn42KOXx+305NVPHgk6u4TMF167O3BCVjRmU4
 wiIDLwmYJ+OWSi0Msq8Gp6qKy7yF8exj9GVQGkBCIJyLIK5trTHuPkG8Uz/AXRS2ADa70bOrrpz
 CvAjr2xi0R+4W+fzu29v2gI1IWTAP1E9e73vlHuB2TEEqb3GWtIofCeAlxOF+p8inIGzE2wDixe
 AGTS5+IEP0DHQq0E+Evp2MXKy1FtnUK4qWGmI+deyGQY/+UbE+s4AV9K3ADjmoBoK/c+y0EV9gR
 dTcOn6aKMy53Oi5k7bLlpIZ40CoVzOBxHGRgNWoOqnjyCbBgZGcarVXfeTJesUcTuNDrCiLDmTx
 G5XPOSHEzALb9ut0S9jGU3sE19KbFOJSA28TaJhYO95uVBaM5Cm+urMnYtvVghcnUkCGbkzlEXu
 iuXpRuF1AvQZX5lHZrZajkZ28e08u68rI8YIF5XOfL0vZgYEcYTtGekVvBWvWr5zELhM4B5TTTc
 R+7K7y0kD/ZtogeAO/iMGMp2PqcGthR8D5piD8OaV2xmu7QFHHdgFxNMZsB6crjP0m90QB1ffDs
 lDutkqJJSvMRksMoRHm+sdiXhtBmbvDeo5KFqF69b9qq9DW4YpGtIu9/dfboe1vwZ05/RmekhY0
 bSXeh4lOXAsA4tRizIXaxDIuCwpf6s94E5m7jNw==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> Implement buffered capture using a cyclic DMA transfer into a kfifo
> buffer to support continuous high-rate sampling.
> 
> On buffer enable, switch the ADC to continuous conversion mode and start
> a cyclic DMA transfer over the active channels.
> 
> Because the DMA controller does not support native scatter-gather, and
> because of the cyclic DMA setup, transfers must be done in widths
> covering all the enabled channels.
> 
> Since DMA transfer width must be a power of two and aligned to its size,
> cover the smallest power-of-two-aligned group of channel registers
> spanning the enabled channels.
> 
> Split the cyclic buffer into fixed-size periods. On each period
> completion, bump a pending counter and wake a consumer kthread from the
> DMA callback.
> 
> For every completed period, gather the enabled channels out of the DMA
> layout into the scan layout the IIO core expects and push each scan
> with iio_push_to_buffers().
> 
> If the consumer kthread falls behind by a full buffer, drop the oldest
> periods.
> 
> Because the DMA transfer must cover all channels between the first and
> last enabled ones, skip disabled channels while compacting.
> 
> Also, the DMA controller transfers data in 32-bit words, but the ADC's
> data registers are 16-bit wide, causing adjacent channel data to be
> swapped. Swap consecutive channels while compacting to account for this.
> 
> Allocate the DMA buffer via dma_alloc_noncoherent() and synchronise it
> per period to allow it to be cached by the CPU while compacting.
> 
> Disable the completion IRQ for the duration of the DMA transfer, as the
> ICU does not mask this event from reaching the GIC even if it is being
> used to drive the DMA capture.
> 
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>


Hi Cosmin.

A couple of comments inline but so far nothing to stop me applying
this series and one of them is random musings :)

Jonathan


> diff --git a/drivers/iio/adc/rzt2h_adc.c b/drivers/iio/adc/rzt2h_adc.c
> index 95bcebdc02cb..0460dffe189e 100644
> --- a/drivers/iio/adc/rzt2h_adc.c

> +static void rzt2h_adc_dma_calc_layout(struct iio_dev *indio_dev)
> +{
> +	struct rzt2h_adc *adc = iio_priv(indio_dev);
> +	unsigned int hi = 0, lo = RZT2H_ADC_MAX_CHANNELS - 1;
> +	const struct iio_chan_spec *chan;
> +	unsigned int sample_chans;
> +	unsigned int first_chan;
> +	unsigned int scan_index;
> +	unsigned int swap;
> +	unsigned int idx;
> +
> +	/* Find the lowest and highest enabled channel. */
> +	iio_for_each_active_channel(indio_dev, scan_index) {
> +		chan = &indio_dev->channels[scan_index];
> +
> +		lo = min_t(unsigned int, lo, chan->channel);
> +		hi = max_t(unsigned int, hi, chan->channel);

I'd normally be fussy about use of max_t etc but here it is
highlighting something that came up in another review - why is
channel an signed?  We use negative in the scan index but
I don't think we ever do for channel.  Anyhow, unrelated to this
series other than we might be able to tidy this up shortly if
I get round to checking if we can just make chan->channel unsigned.

> +	}
> +
> +	/*
> +	 * The DMA has no scatter-gather and transfers must have a power-of-two
> +	 * width, so pick the smallest power-of-two-aligned block of channels
> +	 * that covers all enabled channels.
> +	 */
> +	for (sample_chans = 1; sample_chans < RZT2H_ADC_MAX_CHANNELS; sample_chans <<= 1) {
> +		first_chan = round_down(lo, sample_chans);
> +
> +		if (first_chan + sample_chans > hi)
> +			break;
> +	}
> +
> +	/*
> +	 * Build a table to map each enabled channel to its position in the
> +	 * transferred block, it will be used later to extract only the enabled
> +	 * channels out of it.
> +	 * The DMA moves data in 32-bit words, which swaps each pair of adjacent
> +	 * 16-bit channels. Undo it.
> +	 */
> +	adc->dma.gather_len = 0;
> +	swap = sample_chans > 1;
> +	iio_for_each_active_channel(indio_dev, scan_index) {
> +		chan = &indio_dev->channels[scan_index];
> +		idx = chan->channel - first_chan;
> +
> +		adc->dma.gather[adc->dma.gather_len++] = idx ^ swap;
> +	}
> +
> +	adc->dma.first_chan = first_chan;
> +	adc->dma.sample_chans = sample_chans;
> +	adc->dma.period_bytes = RZT2H_ADC_DMA_PERIOD_SAMPLES * sample_chans *
> +				RZT2H_ADC_CHANNEL_BYTES;
> +}
> +
> +static int rzt2h_adc_start_dma(struct iio_dev *indio_dev)
> +{
> +	struct rzt2h_adc *adc = iio_priv(indio_dev);
> +	struct dma_async_tx_descriptor *desc;
> +	struct dma_slave_config config;
> +	unsigned int buffer_bytes;
> +	dma_cookie_t cookie;
> +	int ret;
> +
> +	rzt2h_adc_dma_calc_layout(indio_dev);
> +
> +	config = (struct dma_slave_config) {
> +		.src_addr = adc->phys_base + RZT2H_ADDR_REG(adc->dma.first_chan),
> +		.src_addr_width = adc->dma.sample_chans * RZT2H_ADC_CHANNEL_BYTES,
> +	};
> +
> +	buffer_bytes = RZT2H_ADC_DMA_PERIODS * adc->dma.period_bytes;
> +
> +	ret = dmaengine_slave_config(adc->dma.chan, &config);
> +	if (ret)
> +		return ret;
> +
> +	desc = dmaengine_prep_dma_cyclic(adc->dma.chan, adc->dma.addr,
> +					 buffer_bytes, adc->dma.period_bytes,
> +					 DMA_DEV_TO_MEM, DMA_PREP_INTERRUPT);
> +	if (!desc)
> +		return -EBUSY;
> +
> +	desc->callback = rzt2h_adc_dma_callback;
> +	desc->callback_param = indio_dev;
> +
> +	cookie = dmaengine_submit(desc);
> +	ret = dma_submit_error(cookie);

It is fairly common to combine these
	ret = dma_submit_error(dmaengine_submit(desc))

If you happen to respin for other reasons consider doing this

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
