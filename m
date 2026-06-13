Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91EC75801
	for <linux-iio@vger.kernel.org>; Sat, 13 Jun 2026 16:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781368421; cv=none; b=IXdfuZWhMzVd2Zowsu7Q7+pa8PC1avxt2uXNJTS04jr8fSHIe+un8ZpQjLLEdK/mY92Kjn/IySLHSWv2z3hC9vpWTbZwEcFItRckvto8oavPfcvgVDmud/BCzxiaytJT/IKS/qGpVD2QIwk3PCX64WNzorx2zcJxwtIdBoOpvLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781368421; c=relaxed/simple;
	bh=MPLOFBr/2KwiEqpaCx9nX9Dm8iUkBuRsJ20Kh4QMmaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CIN/gQFrieb8R6Pvvl0c5HsVUGLk8ztqZpUWfDcvb+H6qbQPoU/KWsexHHnX6ywuKHJmMze1uI9DHH3ACYx2j8MR8CiUQKiUDoZgrtW+DEXSP/5jLvJ583s+Du2MWTzhqMcjqNdbhZ44KSBNzvy/Uls05t9NQ6ctwZ45rBI/RX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=TLiGx76L; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="TLiGx76L"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-69e59978deeso811286eaf.0
        for <linux-iio@vger.kernel.org>; Sat, 13 Jun 2026 09:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781368417; x=1781973217; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/4bBkeBv5wlH08PUNFoaib/DPh50hQG+faChGUVK/W0=;
        b=TLiGx76L9E+/XSeuJ4PLB7NoJ6ctI/3O1ZpVebuWJk/tKYcSMSehugr5vZffXEWJd0
         93WwGQ8hZ6Zxke13nyQYMOTz4XT60bU9/1ENgLjpKl6hY19tK4n1dVHFVp+1VBPWlhGp
         R/xHFaJqwCfLN9hO4Wt5TWlw6gJLxEUcdWqOh/tGvCadldY+6dNz/gcsT/gEJihMk+F5
         B2Ke7Kfpn9VQpaSp3Vs3d50HRkZciOSA3+POaVSijbVynRjyzAIn4nnXNuidpogfws6G
         YwEGjTMk0mKQwi1gSX2aFR0GEnyn9f0Rw2R1KTlT3KskYHywgvWpnn1FE0mfZjS226I6
         5Row==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781368417; x=1781973217;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/4bBkeBv5wlH08PUNFoaib/DPh50hQG+faChGUVK/W0=;
        b=hIIbXsCZ2I42MQq19FDw0AsaNFpeq3V6+CxPrbcERB0Ab6tEyBnMMP+2RhshqrGHHW
         vdGdJYVqj8EtLlwzSb/lfy/o2xLjp37DAcrusCKJ2ZhUeN7FjfnJPCJin+Y8T5hhIl/3
         oDKj3tR1wkAHAX04Aa/3aC5DLcDbP/a573w/UNknp/R4loyTIh41oigRJWPotAeO+Qus
         N5M4KpCo9Z/eG0hugo/fikJw0c872IsB+xR/LuvLg9XlzMa2HPoH5eGBLJTe+q1+G3kh
         EfKEcl/wfvJ13rglYqJMqXfM0ofpEktmeAmdzNf3RFAdIaFSetWznICUmNEm7C92hSUH
         9DFg==
X-Forwarded-Encrypted: i=1; AFNElJ+gQKigrUrwjhkxYUxuviVLQn09rEDlMDlskpXc2yhCChPtxseAxXMbcNlWU3LUqpCNe5kgSTuzM/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBNxl1qLTY5TdwjpTF3+zBPXWkTQLbmka/pjihsbZjhU6n1y7w
	1G3M/HPLzzsKUc+PASH0p1COx4X6fsk/WYTuDAbIgl1AAVafc4lH3rWPd8xHBeD2xQ5paN25rLT
	yOmCuOBQ=
X-Gm-Gg: Acq92OGOnKTrJFuGBN6P6POPEWJvVo0BF/Ew+bXY4Nuwnr4xnBu8Qk941m+RbseDSJn
	S1Apx4JFPGzW8ALbBahXIme9uaFHw2bYMWuXZDIC0ApyKNrl61JiMpx+PbIXpERePRD+VEU9RUQ
	NyM1L7P2NX+EIYide4h/fMcMQ4Ogd+aQ+4rp2HtMpqhAKYzTsE1q3rWDiedRR8hHKjj5IiNyHKk
	L+V9YAasJIz1Fq1t9FGalnrZfGF0co9Mx7lqtZBx1GfytKUNvXexSvPJTShQb4B/GeHuPtRbXVN
	2USwOnB2S5bkDUiqTTvtLpjOxfYEvmfN0fZr2sl15/jHPAXwwKgH2IBTy928SlC1ps6xhAJ5cx4
	nwrtyefKyU5eM20kB9rXkV68evVD2dSmGFtGRgKjX6BE9wdvnA8XWW4JstSEE9XvwHvUZFDALFM
	QU0yy7TMtTdvLM8aHFQ6iDgHycrCZ28Ynv90aV5Vcko6VSf3FLAz6xMYoeo7uo8iSc5f1Uu0f61
	w==
X-Received: by 2002:a05:6820:220c:b0:69b:5486:e85 with SMTP id 006d021491bc7-69eec9d7ed3mr2177424eaf.36.1781368417531;
        Sat, 13 Jun 2026 09:33:37 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:cb9a:87cc:1314:fef5? ([2600:8803:e7e4:500:cb9a:87cc:1314:fef5])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69ed8574da5sm3694548eaf.13.2026.06.13.09.33.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jun 2026 09:33:36 -0700 (PDT)
Message-ID: <e05dddef-2ffc-4ab6-8ce7-f676b7801eff@baylibre.com>
Date: Sat, 13 Jun 2026 11:33:36 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: buffer-dmaengine: Add support for cyclic DMA
 transfers
To: nuno.sa@analog.com, linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
References: <20260611-iio-dma-cyclic-buffer-support-v1-1-bcf00e8d802c@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260611-iio-dma-cyclic-buffer-support-v1-1-bcf00e8d802c@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/11/26 10:28 AM, Nuno Sá via B4 Relay wrote:
> From: Nuno Sá <nuno.sa@analog.com>
> 
> Allow buffer blocks flagged as cyclic to be submitted as repeating DMA
> transfers. For cyclic blocks, use DMA_PREP_REPEAT so the engine keeps
> replaying the descriptor.

Is this for both directions (e.g ADCs and DACs) or only one?

> 
> Skip installing the completion callback for cyclic blocks. Since the
> transfer is continuously replayed, the callback would fire on every
> period, throwing off the block refcount.
> 
> Because nothing prevents a new cyclic transfer from replacing an
> already active cyclic one, always set DMA_PREP_LOAD_EOT so the engine
> correctly terminates the active transfer before loading the new
> descriptor.

Is there more to come after this to actually make use of it? Or is there
a way to use this with DMABUF from userspace already?

> 
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
> There's one subtle choice in here. Given that the termination callback
> is not set. We will never give the block refcount. That means cyclic
> blocks are only completely freed when we disable the buffer and
> iio_dmaengine_buffer_abort() get's called. So no leak, we just defer it
> as it makes it more simple to handle. I also think this a fair
> expectation from a cyclic transfer. We set it up and let it run until we
> disable the buffer.

Makes sense.

> 
> Alternatively, we can give in the refcount as soon as we give the block
> to the DMA layer with dma_async_issue_pending(). But we also need to
> make sure that the block is not added to the dmaengine_buffer->active list.
> As said, I feel that the current approach is just simpler.
> ---
>  drivers/iio/buffer/industrialio-buffer-dmaengine.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> index 98acce909854..4a78cd3e7c7d 100644
> --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> @@ -80,6 +80,8 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
>  		dma_dir = DMA_MEM_TO_DEV;
>  
>  	if (block->sg_table) {
> +		unsigned long flags;
> +
>  		sgl = block->sg_table->sgl;
>  		nents = sg_nents_for_len(sgl, block->bytes_used);
>  		if (nents < 0)
> @@ -99,9 +101,18 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
>  			sgl = sg_next(sgl);
>  		}
>  
> +		if (block->cyclic)
> +			flags = DMA_PREP_REPEAT;
> +		else
> +			flags = DMA_PREP_INTERRUPT;
> +
> +		/*
> +		 * There's nothing preventing a cyclic transfer to replace an active
> +		 * cyclic one. So always set the EOT flag.

What about the non-cyclic case?

> +		 */
>  		desc = dmaengine_prep_peripheral_dma_vec(dmaengine_buffer->chan,
>  							 vecs, nents, dma_dir,
> -							 DMA_PREP_INTERRUPT);
> +							 flags | DMA_PREP_LOAD_EOT);
>  		kfree(vecs);
>  	} else {
>  		max_size = min(block->size, dmaengine_buffer->max_size);
> @@ -122,8 +133,10 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
>  	if (!desc)
>  		return -ENOMEM;
>  
> -	desc->callback_result = iio_dmaengine_buffer_block_done;
> -	desc->callback_param = block;
> +	if (!block->cyclic) {
> +		desc->callback_result = iio_dmaengine_buffer_block_done;
> +		desc->callback_param = block;
> +	}
>  
>  	cookie = dmaengine_submit(desc);
>  	if (dma_submit_error(cookie))
> 
> ---
> base-commit: ae696dfa47c30016cd429b9db5e70b259b8f509e
> change-id: 20260609-iio-dma-cyclic-buffer-support-f18034f8f34c
> --
> 
> Thanks!
> - Nuno Sá
> 
> 

