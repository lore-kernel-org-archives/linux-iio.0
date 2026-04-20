Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915002772D;
	Mon, 20 Apr 2026 18:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776708458; cv=none; b=GicDI+fKtUk1l+DLaVzFo0qFFBc9pi+zt9Bp3ui9xZzZZX02P5wXtlx8/L2/MEgifDXRQdLrZeeLQqK1M5e4hpYCe8jLFAHGggNi8M1E3q9QHqZ+JvojKDwGC3B1/MZWWkpu3l2VQLk1bSR7NlpmHCvbyxCzy7zJ8kKOFFn/Eto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776708458; c=relaxed/simple;
	bh=3rt/k7qepHzsDq/tWxANgKuz13QqJne5j6k9TZhky/A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qBbA9hccSvsKkNti5a69zppk1rqKeHQaYYFJXXntT08+W0pPBYD/sRNcEEA8VtkcgiDczhmykcEMXAKde3C5WnkIO3rzcbm3/z69ChLU26X5PVdvFwFn0tSyGsCtQ5lx0JHEXFZQHZadnfEG0ThXIxupeWo17E3aSvCJuBWKET0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3OVzRm3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3OVzRm3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D553C19425;
	Mon, 20 Apr 2026 18:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776708458;
	bh=3rt/k7qepHzsDq/tWxANgKuz13QqJne5j6k9TZhky/A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k3OVzRm3and3ukRjEIksRYcty9o9e2wg+TOvA5DyN+0jCO043txQ+GfgOtsilO9ZT
	 qWL+V7LqDtPwlY7FyNyzuI2FHt/5bAEa9DqBGDr+TfrhY8ztXlvNODTAnpoeIm25Yi
	 I7qJLG+MVZPsFUlTkxjzAR+kcM6lrK8wg3ghg/xmdW6TAaTzPHTodtQ4vBI6XhvO/5
	 zYSeM5DykZbO8Hk/ioYgGVmYLCmZnjEm5Uu0AdXt9agjOZKGQURbkeFD6/1j2XWIMt
	 mLa/L0SYrAw/Rsmrc1m5LN+rSHaMzJpo3LjEhLCyF5jIzZJHR9cIAeJozgu2OEBSrP
	 Aj0LlkDlqQOsg==
Date: Mon, 20 Apr 2026 19:07:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Shuvam Pandey <shuvampandey1@gmail.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: nxp-sar-adc: zero-initialize dma_slave_config
Message-ID: <20260420190730.439c304d@jic23-huawei>
In-Reply-To: <3c24723f-801c-46a5-9257-910f3c181235@baylibre.com>
References: <20260406095324.99671-1-shuvampandey1@gmail.com>
	<3c24723f-801c-46a5-9257-910f3c181235@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 Apr 2026 08:59:34 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 4/6/26 4:53 AM, Shuvam Pandey wrote:
> > nxp_sar_adc_start_cyclic_dma() only fills the RX-side members of
> > dma_slave_config before passing it to dmaengine_slave_config().
> > 
> > Zero-initialize the structure so unused members do not contain stack
> > garbage. Some DMA engines consult optional dma_slave_config fields, so
> > leaving them uninitialized can cause DMA setup failures.
> > 
> > Fixes: 4434072a893e ("iio: adc: Add the NXP SAR ADC support for the s32g2/3 platforms")
> > Signed-off-by: Shuvam Pandey <shuvampandey1@gmail.com>
> > ---
> >  drivers/iio/adc/nxp-sar-adc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/nxp-sar-adc.c b/drivers/iio/adc/nxp-sar-adc.c
> > index 9efa883c277d..7d7b5a580167 100644
> > --- a/drivers/iio/adc/nxp-sar-adc.c
> > +++ b/drivers/iio/adc/nxp-sar-adc.c
> > @@ -659,7 +659,7 @@ static void nxp_sar_adc_dma_cb(void *data)
> >  static int nxp_sar_adc_start_cyclic_dma(struct iio_dev *indio_dev)
> >  {
> >  	struct nxp_sar_adc *info = iio_priv(indio_dev);
> > -	struct dma_slave_config config;
> > +	struct dma_slave_config config = {};  
> 
> IIO style is to have space between braces.
> 
> Wait and see if Jonathan asks for a new version first though
> before sending one for trivial changes like that.
> 
> >  	struct dma_async_tx_descriptor *desc;
> >  	int ret;
> >    
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> 
Note I picked this up and tweaked as above, so the following is
just thoughts on how we might do similar in future. 

It is a bigger change but maybe it's worth 

	struct dma_slave_config config;

...

	config = (struct dma_slave_config) {
		.direction = DMA_DEV_TO_MEM,
		.src_addr_width = NXP_SAR_ADC_DMA_SAMPLE_SZ,
		.src_addr = NXP_SAR_ADC_CDR(info->regs_phys, info->buffered_chan[0]),
		.src_port_window_size = info->channels_used,
		.src_maxburst = info->channels_used,
	};
Which will ensure whole thing is set at the point of use rather than clear
and then fill stuff in later as this patch does.

Given this has been sat a while, lets go for good enough and it's a more
minimal patch which is always nice for a fix.

Applied to the fixes-togreg branch of iio.git and marked for
stable.

Thanks,

Jonathan

