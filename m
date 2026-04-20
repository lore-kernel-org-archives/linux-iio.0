Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E3B3AC0D9;
	Mon, 20 Apr 2026 14:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776695516; cv=none; b=GZciynPf59PDQMjwZ7mPvQyL1A/A33i9Tsj7RfdrnsEk/Nue3bpQGbhf15n3lvVavNAziRlbNoJczT7ol9NGuOxBwUHgXBDVFhjkReNpbKBCwAnFN/gU7svd5UnbiaJJvXYx1KfndUBncmxhlDxxWLyeuS7xMg5Nl6PB2LUA0Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776695516; c=relaxed/simple;
	bh=CwODMEkN9Bzfva2zJeTevsnirAhkvHuaNhf85XtHjSM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VB0hQZ/RTk8GdF1k4bePTIhYV+FrFS2sC5Gdg+l616J7errxCLRIIf5LBfqRUA7Usv+cXFtMauInzxepZyCEUpz4LRMx7DTRMyhivsHt8/I2bRb+i5GDrVgvlBh4kRut8t9WGzL1STo7RKuE23IbtRABnxtjSinrXa7dyvSrKYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mkqVt17R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mkqVt17R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2394C19425;
	Mon, 20 Apr 2026 14:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776695516;
	bh=CwODMEkN9Bzfva2zJeTevsnirAhkvHuaNhf85XtHjSM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mkqVt17RhDm/iCH6OQKApKWjXqw37ZuQjdqrBocdmfdLu1lLUrXUJhW0SJ6TFYrBO
	 pN2gMWobVoC+wp8ofnOi7NzQFyrxvrvJlBWXSQgKY7bp4ZKkiu7og7TvpBlHqA5zW+
	 6ULxaXCjBCgiRim0IPFDTNaazYu7VCDahog0a9fJdiLD29Tft2r13RPrdR6HwSBsOW
	 +RfjCEGQ1FKKqExXUdYbjb4uIjOHc66skvoxD1cUOciDDqqTjZsLLdu7xJe4O+ER6b
	 al+917G6Poi/npkXUt8UOjnBp/w0ij5WMRRQgIW/9kHYZLK3liTAPbgDHLKONFJaiU
	 VW3lQC9BxOIXw==
Date: Mon, 20 Apr 2026 15:31:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Tomasz Duszynski <tomasz.duszynski@octakon.com>, Lars-Peter Clausen
 <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: chemical: scd30: fix division by zero in write_raw
Message-ID: <20260420153148.1c69ff09@jic23-huawei>
In-Reply-To: <20260401110830.7694-1-antoniu.miclaus@analog.com>
References: <20260401110830.7694-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 1 Apr 2026 14:08:29 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add a zero check for val2 before using it as a divisor when setting the
> sampling frequency. A user writing a zero fractional part to the
> sampling_frequency sysfs attribute triggers a division by zero in the
> kernel.
> 
> Fixes: 64b3d8b1b0f5 ("iio: chemical: scd30: add core driver")
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Applied to fixes-togreg and marked for stable.

Thanks,

J
> ---
>  drivers/iio/chemical/scd30_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
> index a665fcb78806..11d6bc1b63e6 100644
> --- a/drivers/iio/chemical/scd30_core.c
> +++ b/drivers/iio/chemical/scd30_core.c
> @@ -256,7 +256,7 @@ static int scd30_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const
>  	guard(mutex)(&state->lock);
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> -		if (val)
> +		if (val || !val2)
>  			return -EINVAL;
>  
>  		val = 1000000000 / val2;

