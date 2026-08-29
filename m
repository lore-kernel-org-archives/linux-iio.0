Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D47A1397;
	Sat, 29 Aug 2026 01:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787966477; cv=none; b=g6bW+ZoRpgNrO3FWF3IytrM59sOntTf5wlXgU3ha0FINnxwFyK4zIUkQGBmy9FLs8PKM4Q3RjJL0ZpEqRpjNHCnOFCB4RP472JFw3JA4nYkwQAjZse6f5RqQEJ8wKbIWmi/Blk+Y3KIQVaAveBqNO1qnYQkQelWFKT2Xtt+i+ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787966477; c=relaxed/simple;
	bh=BHczcMYLH2FaOIh7442KdCcEceFfFuznU28EWPfQkGo=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=HkXv+a7qcOyKFa3sNz+qSq56c0vtXt6hYDKyqY9Ji9ES4YWbTPnJHBaW1U2CoPtHq8XEZwMkFO6PUIOmH43nNlbLVxlRnSfrRIdDNeWsAweJq+EjisIqdfqiBTzNP7Ju2gSHxE0iXUwqY96i7Yrd3dvr5KnNH8qWXKXoi8vvTvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jyZXENAR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jyZXENAR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3F01F00A3D;
	Sat, 29 Aug 2026 01:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787966475;
	bh=qFVd0fYt5xknKtgO3d0FGJBSHTzFH99ew6geSwUPMRQ=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=jyZXENARAFO2WepPlm90htJJ37szv1ipryo/W1npPaUhWjTdhMm/Wp+0uC8or/+MY
	 hnIS2/15DUmrFoR5gjcbkuxQ40KGMHUtW77M2dItqQ0T7OMKf21c0Zt3hj2VxBR9Lz
	 wC/RPkbGzub4+Qwi0Ko9ONAiZH703MJmdWk50os5wzU3WIYF0U9X5+YbuBIXGLUMI8
	 G210KXgGmHM1K3afq6VHs+of9iA9ZYYOyjQshNPsJEEZ17agcNjV/cfUuCShZLB+sU
	 fCOWVALHeGZSIMrneV+0cgp7jTtTh0hoYi7IXQIaoOI3GhMQyT1mLRzBMhIqSCc9Z/
	 j9Tm1W4zRrYlA==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 5/9] iio: adc: rzt2h: implement DMA buffer support
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
In-Reply-To: <20260828145943.2077589-6-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260828145943.2077589-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20260828145943.2077589-6-cosmin-gabriel.tanislav.xa@renesas.com>
Date: Sat, 29 Aug 2026 02:20:43 +0100
Message-Id: <178796644341.2599003.10846523729399514118.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12699;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=BHczcMYLH2FaOIh7442KdCcEceFfFuznU28EWPfQkGo=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqkjPvCZt6yyGfZJF6OeDMnlT95uNoAA6U748hj
 FkP+OeW3+CJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCapIz7xEcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiClcD/9CCx3HewxtnN5kSVrjqx3YVU1K+f5UbFr4A7EPzVbgq7E
 I1yrh3HlosAcOmfjbhXZRKwDBn+dbwHMEnzoAlVw8hKv0n/1sFvRRYvwCSOYOzyx0cn1xv0DAQG
 0LUghkrwxAwst49sFOKyM3lErhV92mDOZTiJYJcep/bryLV/j5DXdcODCzot8NMKjcABJqw8DdW
 pAmrU3QELABxbrB2J1ZTdalcYm0p87LG9C2vuO2CR5hxGDOVdL0RBLI507qTvw+p6BtDEiERetB
 9fFSdK+I3JPvLL7xYyPgZvwneDLpVZ5bTtoszVkqWFSEIP3IH/xA9BdfEvolwqsHQNOZB3qeNCZ
 JhCaC/nvUUtPhU7lk6kzm5IoLrQ9kRVIG6gjWojSK/kradkKspBl8+ubRPP9k38597Dr33ruoWd
 Po7QHclYD7bJOtO3POsOWFdRtiXD/t3f6ujxZqXYd7enJfW+qYH2x5EFRfySwNCpQFPLWlpcCgS
 C70QEoNbLugd8uHp/iGwT69Gx/O8VaQ+kFQA/42jeDm2b5s8+aw5DhFHMeHLdZuEMDdnCde5Pu4
 sE2fI2mrAN8ho1fpoH7WdG6igy+LCa5+5s3o+6PjjuNC1VgDueMw3BSf9aQpyvoMYiF0O2V7Q2S
 8eARu+e3QM9QlEKXzUCY9I/36sfNqOmaETVmjFg==
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

Could you instead use the available_scan_masks infrastructure.  bit annoying
to specify the full list but isn't that long I think with 16 channels

16 x single
8 x double,
4 x quads
2 x octect
1 x all of them.

The the IIO demux in (sits behind the push_to_buffers path if
we have available_scan_masks set) will then deal with repacking
the data if necessary.

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

I'm messing around with b4 review tui and sashiko integration. I've
left the Sashiko comments in here as I'm out of time today to look
at them in detial.
>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 415e519ad4eb..6c7b30d2b6e7 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1551,6 +1551,8 @@ config RZT2H_ADC
>  	tristate "Renesas RZ/T2H / RZ/N2H ADC driver"
>  	depends on ARCH_RENESAS || COMPILE_TEST
>  	select IIO_ADC_HELPER
> +	select IIO_BUFFER
> +	select IIO_KFIFO_BUF
>  	help
>  	  Say yes here to build support for the ADC found in Renesas
>  	  RZ/T2H / RZ/N2H SoCs.
> diff --git a/drivers/iio/adc/rzt2h_adc.c b/drivers/iio/adc/rzt2h_adc.c
> index 95bcebdc02cb..d76226375f22 100644
> --- a/drivers/iio/adc/rzt2h_adc.c
> +++ b/drivers/iio/adc/rzt2h_adc.c
> @@ -4,11 +4,16 @@
>  #include <linux/cleanup.h>
>  #include <linux/completion.h>
>  #include <linux/delay.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dmaengine.h>
>  #include <linux/iio/adc-helpers.h>
> +#include <linux/iio/buffer.h>
>  #include <linux/iio/iio.h>
> +#include <linux/iio/kfifo_buf.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
> +#include <linux/kthread.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> @@ -18,6 +23,7 @@
>  #define RZT2H_ADCSR_ADIE_MASK		BIT(12)
>  #define RZT2H_ADCSR_ADCS_MASK		GENMASK(14, 13)
>  #define RZT2H_ADCSR_ADCS_SINGLE		0b00
> +#define RZT2H_ADCSR_ADCS_CONTINUOUS	0b10
>  #define RZT2H_ADCSR_ADST_MASK		BIT(15)
>  
>  #define RZT2H_ADANSA0_REG		0x04
> @@ -31,18 +37,47 @@
>  #define RZT2H_ADCALCTL_CAL_ERR_MASK	BIT(2)
>  
>  #define RZT2H_ADC_MAX_CHANNELS		16
> +#define RZT2H_ADC_CHANNEL_BYTES		sizeof(u16)
> +#define RZT2H_ADC_DMA_PERIOD_SAMPLES	128
> +#define RZT2H_ADC_DMA_PERIODS		64
> +#define RZT2H_ADC_DMA_BUFFER_SAMPLES	(RZT2H_ADC_DMA_PERIODS * \
> +					 RZT2H_ADC_DMA_PERIOD_SAMPLES)
> +#define RZT2H_ADC_DMA_BUFFER_SIZE	(RZT2H_ADC_DMA_BUFFER_SAMPLES * \
> +					 RZT2H_ADC_MAX_CHANNELS * \
> +					 RZT2H_ADC_CHANNEL_BYTES)
> +
> +struct rzt2h_adc_dma {
> +	struct dma_chan *chan;
> +	u16 *buf;
> +	dma_addr_t addr;
> +
> +	unsigned int period_index;
> +	unsigned int period_bytes;
> +	unsigned int first_chan;
> +	unsigned int sample_chans;
> +
> +	u8 gather[RZT2H_ADC_MAX_CHANNELS];
> +	unsigned int gather_len;
> +
> +	atomic_t pending_periods;
> +
> +	wait_queue_head_t wq;
> +	struct task_struct *thread;
> +};
>  
>  struct rzt2h_adc {
>  	void __iomem *base;
>  	struct device *dev;
>  
>  	phys_addr_t phys_base;
> +	struct rzt2h_adc_dma dma;
>  	struct completion completion;
>  	/* lock to protect against multiple access to the device */
>  	struct mutex lock;
>  
>  	const struct iio_chan_spec *channels;
>  	unsigned int num_channels;
> +	u16 buf[RZT2H_ADC_MAX_CHANNELS];
>  
>  	int irq;
>  };
> @@ -151,6 +186,253 @@ static int rzt2h_adc_calibrate(struct rzt2h_adc *adc)
>  	return 0;
>  }
>  
> +static void rzt2h_adc_push_period(struct iio_dev *indio_dev, u16 *period,
> +				  dma_addr_t addr)
> +{
> +	struct rzt2h_adc *adc = iio_priv(indio_dev);
> +	u16 *dst = adc->buf;
> +	u16 *src = period;
> +
> +	dma_sync_single_for_cpu(adc->dev, addr, adc->dma.period_bytes,
> +				DMA_FROM_DEVICE);
> +
> +	for (unsigned int sample = 0; sample < RZT2H_ADC_DMA_PERIOD_SAMPLES; sample++) {
> +		for (unsigned int i = 0; i < adc->dma.gather_len; i++)
> +			dst[i] = src[adc->dma.gather[i]];
> +
> +		src += adc->dma.sample_chans;
> +
> +		iio_push_to_buffers(indio_dev, adc->buf);
> +	}



> +}
> +
> +static void rzt2h_adc_advance_period_index(struct rzt2h_adc *adc, unsigned int i)
> +{
> +	adc->dma.period_index += i;
> +	adc->dma.period_index %= RZT2H_ADC_DMA_PERIODS;
> +}
> +
> +static void rzt2h_adc_dma_thread_loop(struct iio_dev *indio_dev)
> +{
> +	struct rzt2h_adc *adc = iio_priv(indio_dev);
> +	int pending, drop;
> +	dma_addr_t addr;
> +	u16 *period;
> +
> +	pending = atomic_xchg(&adc->dma.pending_periods, 0);
> +
> +	if (pending >= RZT2H_ADC_DMA_PERIODS) {

Add a comment here to say what is being dropped and why.

> +		drop = pending - RZT2H_ADC_DMA_PERIODS + 1;
> +
> +		rzt2h_adc_advance_period_index(adc, drop);
> +		pending -= drop;
> +	}
> +
> +	for (unsigned int i = 0; i < pending; i++) {
> +		unsigned int backlog = atomic_read(&adc->dma.pending_periods) +
> +				       pending - i;
> +
> +		/*
> +		 * Bail if enough new periods have completed since reading the
> +		 * pending_periods that the next period about to be read is at
> +		 * risk of being overwritten.
> +		 */
> +		if (backlog >= RZT2H_ADC_DMA_PERIODS)
> +			break;


> +
> +		period = adc->dma.buf + adc->dma.period_index *
> +			 RZT2H_ADC_DMA_PERIOD_SAMPLES * adc->dma.sample_chans;
> +		addr = adc->dma.addr + adc->dma.period_index *
> +		       adc->dma.period_bytes;
> +
> +		rzt2h_adc_push_period(indio_dev, period, addr);
> +		rzt2h_adc_advance_period_index(adc, 1);
> +	}
> +}
> +
> +static int rzt2h_adc_dma_thread(void *data)
> +{
> +	struct iio_dev *indio_dev = data;
> +	struct rzt2h_adc *adc = iio_priv(indio_dev);
> +
> +	while (!kthread_should_stop()) {
> +		wait_event_interruptible(adc->dma.wq,
> +					 atomic_read(&adc->dma.pending_periods) ||
> +					 kthread_should_stop());

I've not thought that much about the following but it seems plausible so please
take a look


> +
> +		if (kthread_should_stop())
> +			break;
> +
> +		rzt2h_adc_dma_thread_loop(indio_dev);
> +	}
> +
> +	return 0;
> +}
> +
> +static void rzt2h_adc_dma_callback(void *data)
> +{
> +	struct iio_dev *indio_dev = data;
> +	struct rzt2h_adc *adc = iio_priv(indio_dev);
> +
> +	atomic_inc(&adc->dma.pending_periods);
> +	wake_up(&adc->dma.wq);
> +}
> +
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

As mentioned at the top, I think you can probably avoid all this complexity.
Lots of devices have restrictions on combinations of channels that
are enabled together. For that we have available_scan_masks
and the demux stuff in the IIO core.

> +
> +	/* Find the lowest and highest enabled channel. */
> +	iio_for_each_active_channel(indio_dev, scan_index) {
> +		chan = &indio_dev->channels[scan_index];
> +
> +		lo = min_t(unsigned int, lo, chan->channel);
> +		hi = max_t(unsigned int, hi, chan->channel);
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
> +	struct dma_slave_config config = {};
> +	unsigned int buffer_bytes;
> +	dma_cookie_t cookie;
> +	int ret;
> +
> +	rzt2h_adc_dma_calc_layout(indio_dev);
> +
> +	config.src_addr = adc->phys_base + RZT2H_ADDR_REG(adc->dma.first_chan);
> +	config.src_addr_width = adc->dma.sample_chans * RZT2H_ADC_CHANNEL_BYTES;

	config = (struct dma_slave_config) {
		.src_addr = adc->phys_base + RZT2H_ADDR_REG(adc->dma.first_chan),
		.src_addr_width = adc->dma.sample_chans * RZT2H_ADC_CHANNEL_BYTES,
	};

	keeps all the filling in of info together and avoids need to do = { }
	above then overwrite some of the zeroed memory.

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
> +	if (ret) {
> +		dmaengine_terminate_sync(adc->dma.chan);
> +		return ret;
> +	}
> +
> +	adc->dma.thread = kthread_run(rzt2h_adc_dma_thread, indio_dev,
> +				      "rzt2h-adc-dma");
> +	if (IS_ERR(adc->dma.thread)) {
> +		dmaengine_terminate_sync(adc->dma.chan);
> +		return PTR_ERR(adc->dma.thread);
> +	}
> +
> +	disable_irq(adc->irq);
> +
> +	dma_async_issue_pending(adc->dma.chan);
> +
> +	return 0;
> +}
> +

> +static int rzt2h_adc_setup_dma(struct iio_dev *indio_dev)
> +{
> +	struct rzt2h_adc *adc = iio_priv(indio_dev);
> +	struct device *dev = adc->dev;
> +	int ret;
> +
> +	adc->dma.chan = devm_dma_request_chan(adc->dev, "rx");
> +	if (IS_ERR(adc->dma.chan)) {
> +		ret = PTR_ERR(adc->dma.chan);
> +		if (ret != -ENODEV)
> +			return dev_err_probe(adc->dev, ret, "DMA channel request failed\n");

You have dev that can be used here.

> +
> +		adc->dma.chan = NULL;
> +		return 0;
> +	}
> +
> +	adc->dma.buf = dma_alloc_noncoherent(adc->dev, RZT2H_ADC_DMA_BUFFER_SIZE,

Same here.

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
