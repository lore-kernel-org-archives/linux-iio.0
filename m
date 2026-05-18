Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EE93E3170
	for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 08:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779092709; cv=none; b=evYcL1td2zwT+hSUAipAM3zQ7GuTbfrgg1cbI5kVocB64S5StGOC1yT9njhSWAKDC+Qd+2iPFC9P4joeagmHPqZoo/Z7JzRuQ+ATelID1qJJN1agnLRSjWI0NcG5iupoBMjlPwHmmJ4+LuFaTTM+GO1Bp9brB8rVtR5vqWHJF44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779092709; c=relaxed/simple;
	bh=LXbSJpJCEmuktzcg2H+6aNf9mXGhoqyZcVQmxcxBurI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JvYFyzjlJuIMiBRlR/SG6mDLQFn92KtlwUAiJLcxeioAMWi++fgQ0MF1SuLgguz+66Of6PGRP/UH2Q8W2Ced9ub9teBaOwFsPwtzKUPVGudUf39LyuxNo4aV8lygW8GjpqlQW1aKkrICasvvMNvZnUF9/XWP7tA3K3FJ106b8dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G0+WbgK5; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0+WbgK5"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48d102471a4so15276755e9.2
        for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 01:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779092706; x=1779697506; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aYB1doPxRJ9mJUSEolqRQnRVr/I7xfiEOqE+cx3K3cE=;
        b=G0+WbgK5zbPPkWY/IK92ARaqvleSV1ba3zB/WWm4hrWSxNty/UAjqzyMXVSMIv1obo
         iFtGd3k109n6DfBVwejYWzf4UYWpJ1Gf9pue2H+1rmmXQZ6bv/jyifnz7uiYc+4UVQpz
         Q6QgH0QhZFazeLD9KrcwwpdbOD0Czc5p7zV1ow1Q5ajZpyKGzecYLEJCxkVAAy2ZZMCX
         xiYu/bvVeEZ5IQ1zuu3YYUUbxxvSS02wkM7baAGfcfWZOV6aDh/qVXMXMcT1BeNsUtRS
         0ONdLskNZjrNkwDO+OKit7PfKKcYRymmjCxpdMwUFy2IfpRZCxEiXn6WJ+XkU/H0qBEL
         WATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779092706; x=1779697506;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aYB1doPxRJ9mJUSEolqRQnRVr/I7xfiEOqE+cx3K3cE=;
        b=OMlOQH4tx/FqzoiShN8NXOjv/2wLsoB+CXoTQTDyMWGs7O2eGfE9vwR9VCsJq/6snt
         EVV9CUquVAS5MocLuh8mXqi87Y8PmFpx3fsam9mwZJpBZfhwtpYRcYE1pZWx5b050EpL
         hpSe71JO14YLCQNOEGn9RGxxXM5189PXxud8ZkYO+QJzLge9wQHSRHe28QmS/CNw9AUo
         vIuFeoSpx3BJRBj78tYFwMxK2BCr6vVJ5PZc1H6mg2G5daZIvJgOjC1yc8/eivbAxG3g
         vkjeL92BbbIoj1EQq8RltYo3Mn9aepBEFKRgjL1kqMyJ6seLOYdRQzP+AU+CaYl/ciw7
         qjQw==
X-Forwarded-Encrypted: i=1; AFNElJ+4Xqia3s7IHQPQE7VQJcntJhKtBWCe5X7MZ/pPLOaUmhCaRxHlxN1uoZy8cSsGQiE9lSFFpFNcs1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy77VwMt0oo6qDJRcoEpy3pb4X4zVKinliwlkYHlf+EfAO2W70j
	FpAvos/M/9R+FwSa/6lvAPvPYSWkOGE81ESXpd4iylbV+VDLE1P3rkS9
X-Gm-Gg: Acq92OGux1SN+/hZeSz5vbWO2JXiuq1xotU/9d6x9E1oHsSFWUbxSn30K2q9M4Dx8CN
	UmNuceF6Bvzm7epZO47/00mr6yIAjGqtvNR1813in/SkatgM/YhNqTKjfz3+q7WaKLwpxPn80PT
	nXOhv1kX+DSQ60id61jbBkUC/0enotQwNnJoVLbss+SH2GKHs/meg1hy+7xsMbh6ZedPPutSRiT
	ttZYTjpe/tYK6kXoJzhRod5YqSUJisJFxzBIeTm5M1V5bfTeArlNWPpM1D1QM78+dukRVFCzqv1
	ouIaAbBoj+nsLyXZliJ+wU6dueGFapb0v7eXqg5F4Oy/ZGX0fYnitslzcV/xCy876ZX1Kz3UI6Q
	ZsT95NcHiea/u30mYZufxS27nnh2FlTgtkDTeNmBhHs+x3ezZOVkiGWmSEMxmHL5xJu/W4x8+TV
	vvJwLQkO7dCzgrZg==
X-Received: by 2002:a05:600c:4e4e:b0:483:8062:b2f with SMTP id 5b1f17b1804b1-48fe5fd4747mr230559865e9.6.1779092706022;
        Mon, 18 May 2026 01:25:06 -0700 (PDT)
Received: from nsa ([185.128.9.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fffb9aac4sm222192145e9.9.2026.05.18.01.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 01:25:04 -0700 (PDT)
Date: Mon, 18 May 2026 09:26:00 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Felix Gu <ustc.gu@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: buffer: hw-consumer: free scan_mask on buffer
 release
Message-ID: <agrM1EMhiUJRc4Wg@nsa>
References: <20260427-iio_buf-v1-1-2bbdac844647@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260427-iio_buf-v1-1-2bbdac844647@gmail.com>

On Mon, Apr 27, 2026 at 07:11:39PM +0800, Felix Gu wrote:
> The scan_mask lifetime changed in commit 9a2e1233d38c ("iio: buffer:
> hw-consumer: remove redundant scan_mask flexible array").
> 
> Before that change, the scan mask storage was embedded in struct
> hw_consumer_buffer, so iio_hw_buf_release() could free the whole
> allocation with a single kfree(hw_buf).
> 
> That commit moved the scan mask to a separate bitmap_zalloc() allocation
> stored in buffer.scan_mask, but left iio_hw_buf_release() unchanged.
> 
> Free the scan mask in iio_hw_buf_release() before freeing the buffer
> wrapper.
> 
> Fixes: 9a2e1233d38c ("iio: buffer: hw-consumer: remove redundant scan_mask flexible array")
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> ---

For some reason this one did not get into my mailbox. Anyways, looks
good and in line with buffer-cb. Thanks for fixing this:

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

>  drivers/iio/buffer/industrialio-hw-consumer.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/buffer/industrialio-hw-consumer.c b/drivers/iio/buffer/industrialio-hw-consumer.c
> index 24d7df603760..d1ab2cbf8c88 100644
> --- a/drivers/iio/buffer/industrialio-hw-consumer.c
> +++ b/drivers/iio/buffer/industrialio-hw-consumer.c
> @@ -40,6 +40,8 @@ static void iio_hw_buf_release(struct iio_buffer *buffer)
>  {
>  	struct hw_consumer_buffer *hw_buf =
>  		iio_buffer_to_hw_consumer_buffer(buffer);
> +
> +	bitmap_free(buffer->scan_mask);
>  	kfree(hw_buf);
>  }
>  
> 
> ---
> base-commit: 7080e32d3f09d8688c4a87d81bdcc71f7f606b16
> change-id: 20260427-iio_buf-0459b3fa3de8
> 
> Best regards,
> -- 
> Felix Gu <ustc.gu@gmail.com>
> 
