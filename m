Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698AF3D561;
	Sun, 22 Feb 2026 16:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771776546; cv=none; b=PwxeMl7mEKITWpMz7xrOTFLJiTxz0lbcovdF5kDyle+m7pRFJlwrSBdBD+pLscP1I33kBqm1LN5xw4rFQpamQP43ZJU4tWxKuJ/IN1vMHYzR+NTpydXlAtufR3Sij1YI1DvbBjLSOYZfxmi5VWCiBESBAhoB5zUV5us4whdCL/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771776546; c=relaxed/simple;
	bh=hEa0F63UXXrV9GhmxzVhsplup7OYdf7PzcwXYV+8GSY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Czg+X9VUqEzitl299hKxvP7eV+jii4PUskQDqPrSagxpYE9iH16qHik+bHatn7KyHFXHJMjerXwMJcE0d0Vg11cbRqpZG9ZogtKTjDnidljNgbLESxGgDM0Tp9hqrN7Fvs23y+QssH3Ur3Mmt9g/rs4G3oFMa/n2ZReVsg/F9Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aPa8hRhw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPa8hRhw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C84C116D0;
	Sun, 22 Feb 2026 16:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771776546;
	bh=hEa0F63UXXrV9GhmxzVhsplup7OYdf7PzcwXYV+8GSY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aPa8hRhwSNz9ANJDh7iRUHO8oLSEzfEYghAouGP3ydv4fpZJtaj5Fzw/b331kSZ7S
	 jwYGdEl/Z5HEribDiOxPc5ydpL2GP3qLMtK+8FbvZAKshCCSVZf+ZawnuUw5IXWY+z
	 AUAqWnf6l+/FUT2p+j2uRk+2dNBiS0jCL5STrhHUmhPxl+hBbMWlGzeTEVy/HYI89T
	 sIoiKbMJd2EnWQP8R9WEGXmojrr0rAUtYI/9G2hKLvD6gH+yQbFMftQ2UBcOsDufe9
	 FaAWWimTwOG7Y7vOWd+48wjAWiyRixVbT4kSKhuBgs8g8hCz4vY88VC8kQ8na2iNAL
	 DfWGwTp30L6Dw==
Date: Sun, 22 Feb 2026 16:08:57 +0000
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
Message-ID: <20260222160857.1e0368f0@jic23-huawei>
In-Reply-To: <20260222-nxp-sar-adc-1-v1-1-0ec0e00b25cb@gmail.com>
References: <20260222-nxp-sar-adc-1-v1-1-0ec0e00b25cb@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 22 Feb 2026 17:45:39 +0800
Felix Gu <ustc.gu@gmail.com> wrote:

> The DMA channel was requested in nxp_sar_adc_buffer_postenable() but
> was only released in nxp_sar_adc_buffer_software_do_predisable().
> This caused a DMA channel resource leak when operating in trigger mode.
> 
> Fix this by moving dma_request_chan() from
> nxp_sar_adc_buffer_postenable() into
> nxp_sar_adc_buffer_software_do_postenable(), ensuring the DMA channel
> is only requested in software mode.
> 
> Fixes: 4434072a893e ("iio: adc: Add the NXP SAR ADC support for the s32g2/3 platforms")
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>

Hi Felix,

Just a trivial comment from me inline.  If that's all that comes up
I can make that changes when I apply it.

I'm looking for Daniel and maybe one or two others to take a look
at this before I pick it up.

Thanks,

Jonathan


> ---
>  drivers/iio/adc/nxp-sar-adc.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/nxp-sar-adc.c b/drivers/iio/adc/nxp-sar-adc.c
> index 9efa883c277d..890c8ef3132f 100644
> --- a/drivers/iio/adc/nxp-sar-adc.c
> +++ b/drivers/iio/adc/nxp-sar-adc.c
> @@ -718,6 +718,10 @@ static int nxp_sar_adc_buffer_software_do_postenable(struct iio_dev *indio_dev)
>  	struct nxp_sar_adc *info = iio_priv(indio_dev);
>  	int ret;
>  
> +	info->dma_chan = dma_request_chan(indio_dev->dev.parent, "rx");
> +	if (IS_ERR(info->dma_chan))
> +		return PTR_ERR(info->dma_chan);
> +
>  	nxp_sar_adc_dma_channels_enable(info, *indio_dev->active_scan_mask);
>  
>  	nxp_sar_adc_dma_cfg(info, true);
> @@ -738,7 +742,7 @@ static int nxp_sar_adc_buffer_software_do_postenable(struct iio_dev *indio_dev)
>  out_dma_channels_disable:
>  	nxp_sar_adc_dma_cfg(info, false);
>  	nxp_sar_adc_dma_channels_disable(info, *indio_dev->active_scan_mask);
> -
> +	dma_release_channel(info->dma_chan);

Keep the blank line.  Having one just before a 'bare' return like this can help readability
a little so is common practice.

>  	return ret;
>  }
>  
> @@ -765,10 +769,6 @@ static int nxp_sar_adc_buffer_postenable(struct iio_dev *indio_dev)
>  	unsigned long channel;
>  	int ret;
>  
> -	info->dma_chan = dma_request_chan(indio_dev->dev.parent, "rx");
> -	if (IS_ERR(info->dma_chan))
> -		return PTR_ERR(info->dma_chan);
> -
>  	info->channels_used = 0;
>  
>  	/*
> 
> ---
> base-commit: d4906ae14a5f136ceb671bb14cedbf13fa560da6
> change-id: 20260222-nxp-sar-adc-1-bca71f089bc8
> 
> Best regards,

