Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3915C15687D;
	Sat, 14 Feb 2026 19:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771097702; cv=none; b=J9vZqm+/IhGU7Lx01wDLQ1sYKthTGomrgY4dOuYymeIcCty1wZTEzRt0DMS7278T2JuLzvvlc7KNQ2XIVcEztZ3L2acue1z8L1YM9uJK3sIYjFF/h0CJVWG8F4WopMo7Pt2JjbDwPz8H8N8ksh5yWrY6zGvU+ATBYgrvElwrCZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771097702; c=relaxed/simple;
	bh=OXjBP34Sk+PTJvbWM5ydA3i6zAodEgMnSsDOlJPRf2w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AY4nEqI800xF0qXV6TQ2uDpEQkmNOIw3PJcC0OsWqyRN3w6dOv3hTMZn4kWZF1Je+lZdKeHxW7me4VtUOv10sQHppCB4vrJcUsJ5x4N11gLwlShUUE3klDM6OQBaKuoiMnyf1PFNZq39M5YFx6F6b3vJBu0i7nnJZl0ThgKL/lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NxsJsC8t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NxsJsC8t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ACEEC16AAE;
	Sat, 14 Feb 2026 19:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771097701;
	bh=OXjBP34Sk+PTJvbWM5ydA3i6zAodEgMnSsDOlJPRf2w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NxsJsC8t2NLZUk3wFSaid3tL+2Y4sa/Cyyj1GBEnXX3iSw+q+bsclVzsmJQKTyiOc
	 LwwLNAAqzGxZ1rSAHTaq8OLNwUAyl7v0A04qQX/xzplREPiDnNnTk0XM+Bs2T9Hd/0
	 OHhnsuRRXhU1VU5jlKA3MT+rXnQmfYeHWTOFQ2mkaYnthL3RmBIH5EjelDhysMEzHk
	 bNM/SRZtoOoNK2/Xh9rX1bwFJQWG5rBkS1byyf5ejmx9nMZrh8DTUHl1kSs7WTWJhh
	 DvzlZ2CpRmhzw1wjF9+JTHHA7Rct3kbcodIujxfdzYAEr8QQAyi4Ix0z3JzNjy4tw6
	 lpazMysPu0Qtw==
Date: Sat, 14 Feb 2026 19:34:52 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Marius Cristea <marius.cristea@microchip.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: pac1934: Return -ENOMEM on memory allocation
 failure
Message-ID: <20260214193452.6169704f@jic23-huawei>
In-Reply-To: <20260211171007.143527-1-antoniu.miclaus@analog.com>
References: <20260211171007.143527-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Feb 2026 19:10:05 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> devm_kzalloc() returns NULL on allocation failure. The appropriate error
> code for this condition is -ENOMEM, not -EINVAL.
> 
> Fixes: 0fb528c8255b ("iio: adc: adding support for PAC193x")

Given it's a small alloc and in practice those don't fail if you machine
is likely to boot and at worst you get a slightly misleading error code,
I don't think backports are appropriate, so I've applied this
dropping the fixes tag.


> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  drivers/iio/adc/pac1934.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/pac1934.c b/drivers/iio/adc/pac1934.c
> index ec96bb0f2ed6..b791ce23f3fd 100644
> --- a/drivers/iio/adc/pac1934.c
> +++ b/drivers/iio/adc/pac1934.c
> @@ -1351,7 +1351,7 @@ static int pac1934_prep_iio_channels(struct pac1934_chip_info *info, struct iio_
>  
>  	dyn_ch_struct = devm_kzalloc(dev, channel_size, GFP_KERNEL);
>  	if (!dyn_ch_struct)
> -		return -EINVAL;
> +		return -ENOMEM;
>  
>  	tmp_data = dyn_ch_struct;
>  

