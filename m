Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02F833D4E5;
	Sun, 22 Mar 2026 12:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774181808; cv=none; b=APxcaVrYNNhCkY2Z6pxDm3wp3fTmuA2JPEL+x0o5WTA3UTxRn4CyOwQHRWw+UyODSnF/mEnDsW+1hqWQ9D9gbjC/u3FU8yfVSp3STa1xJqCGIgXKqTFlIVpRXRbEASZ7mOws6cba58i6iBVxHvUFHkz5G4L2COvjKV5cYINfixw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774181808; c=relaxed/simple;
	bh=huaI7FAh00tWo0TVIWXc8kBgeiTKvULsRQhpuRFYIoo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PbI5WZ5vQh4qCJeoEBfgt3bKzs0VX8T0mHyPEzmqYRrPH/n7/0NHzknWoIZeY3WFuIqB1erqduvytH4EGC3oDSB1YQBgG+a/9eIYAhb0bHcNddsMbUUoFmhZShFoRY46Q55rpDfGAObQnLxhBiI1wV8unA1wr3qw3DhFj+CNPFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvN+JKH7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvN+JKH7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C10E2C19424;
	Sun, 22 Mar 2026 12:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774181808;
	bh=huaI7FAh00tWo0TVIWXc8kBgeiTKvULsRQhpuRFYIoo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fvN+JKH7M/q8q0ngZVzqVcfPKM5nH+rBmzVyk2NeqjBKgHiP+pb1ePuc9hWuBkUIj
	 92Cy6OmqQedOzSsXdgVIX9EXHi6YTUapMt5m0u2Zw5DkZP8Ai8M2nuQkRaK7osFbAc
	 IsjTsDqKQd1ilJEjeQrxfyJy+JmX9VJKcFMwku4z2DTZnc7lepbO/37xDPrnWNjjLu
	 KTXvdb7v5V7QdWRc1Oeig7en/IfuL90yc8f/IVzJ9KE99QrcgrGBbED5nAXJaJ9myl
	 DL6m2TAnRYkUMKJqxO+WZUd1WFbMGGT5sc/iKoQY0f8nPimriIcuIXxOkWUbvz+cZN
	 8k8LCAEHSYHwQ==
Date: Sun, 22 Mar 2026 12:16:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Felix Gu <ustc.gu@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Ciprian Costea
 <ciprianmarian.costea@nxp.com>, Alexandru-Catalin Ionita
 <alexandru-catalin.ionita@nxp.com>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, "Radu Pirea (NXP OSS)"
 <radu-nicolae.pirea@oss.nxp.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: nxp-sar-adc: Fix DMA channel leak in trigger
 mode
Message-ID: <20260322121639.6c7ae0d7@jic23-huawei>
In-Reply-To: <20260222160857.1e0368f0@jic23-huawei>
References: <20260222-nxp-sar-adc-1-v1-1-0ec0e00b25cb@gmail.com>
	<20260222160857.1e0368f0@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 22 Feb 2026 16:08:57 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sun, 22 Feb 2026 17:45:39 +0800
> Felix Gu <ustc.gu@gmail.com> wrote:
> 
> > The DMA channel was requested in nxp_sar_adc_buffer_postenable() but
> > was only released in nxp_sar_adc_buffer_software_do_predisable().
> > This caused a DMA channel resource leak when operating in trigger mode.
> > 
> > Fix this by moving dma_request_chan() from
> > nxp_sar_adc_buffer_postenable() into
> > nxp_sar_adc_buffer_software_do_postenable(), ensuring the DMA channel
> > is only requested in software mode.
> > 
> > Fixes: 4434072a893e ("iio: adc: Add the NXP SAR ADC support for the s32g2/3 platforms")
> > Signed-off-by: Felix Gu <ustc.gu@gmail.com>  
> 
> Hi Felix,
> 
> Just a trivial comment from me inline.  If that's all that comes up
> I can make that changes when I apply it.
> 
> I'm looking for Daniel and maybe one or two others to take a look
> at this before I pick it up.
> 
Long enough I think.

Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> Thanks,
> 
> Jonathan
> 
> 
> > ---
> >  drivers/iio/adc/nxp-sar-adc.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/nxp-sar-adc.c b/drivers/iio/adc/nxp-sar-adc.c
> > index 9efa883c277d..890c8ef3132f 100644
> > --- a/drivers/iio/adc/nxp-sar-adc.c
> > +++ b/drivers/iio/adc/nxp-sar-adc.c
> > @@ -718,6 +718,10 @@ static int nxp_sar_adc_buffer_software_do_postenable(struct iio_dev *indio_dev)
> >  	struct nxp_sar_adc *info = iio_priv(indio_dev);
> >  	int ret;
> >  
> > +	info->dma_chan = dma_request_chan(indio_dev->dev.parent, "rx");
> > +	if (IS_ERR(info->dma_chan))
> > +		return PTR_ERR(info->dma_chan);
> > +
> >  	nxp_sar_adc_dma_channels_enable(info, *indio_dev->active_scan_mask);
> >  
> >  	nxp_sar_adc_dma_cfg(info, true);
> > @@ -738,7 +742,7 @@ static int nxp_sar_adc_buffer_software_do_postenable(struct iio_dev *indio_dev)
> >  out_dma_channels_disable:
> >  	nxp_sar_adc_dma_cfg(info, false);
> >  	nxp_sar_adc_dma_channels_disable(info, *indio_dev->active_scan_mask);
> > -
> > +	dma_release_channel(info->dma_chan);  
> 
> Keep the blank line.  Having one just before a 'bare' return like this can help readability
> a little so is common practice.
> 
> >  	return ret;
> >  }
> >  
> > @@ -765,10 +769,6 @@ static int nxp_sar_adc_buffer_postenable(struct iio_dev *indio_dev)
> >  	unsigned long channel;
> >  	int ret;
> >  
> > -	info->dma_chan = dma_request_chan(indio_dev->dev.parent, "rx");
> > -	if (IS_ERR(info->dma_chan))
> > -		return PTR_ERR(info->dma_chan);
> > -
> >  	info->channels_used = 0;
> >  
> >  	/*
> > 
> > ---
> > base-commit: d4906ae14a5f136ceb671bb14cedbf13fa560da6
> > change-id: 20260222-nxp-sar-adc-1-bca71f089bc8
> > 
> > Best regards,  
> 
> 

