Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCD7377A80;
	Sat, 17 Oct 2026 19:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792266901; cv=none; b=MrFW8tQ39EMg6JIB0pxVsIYqfiOjXD0sPQEKaoygNjeKCBCbaUS9I/danbva9H/w1D9Uvz5KT201brct9CehGlSHYigZOgvUhc22kOKcHZB7iUaIBEGlntA2BL0OOP4fLAd4r5i+Ca+pkP6yYScVyJjn14sWLpdUudXobsjsQMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792266901; c=relaxed/simple;
	bh=0bT2+GHx7Y4WzsDkVAh94etRhRU792kGvbpMzUv9tEs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Al8QXayv214jlE04iMwmJYoNJQTYTwBTPVjj2m5ff6HwUOzKzxKJu9xF6uxOVHA1RE5K4AtrvSJyZIoldyj+34NyuxIhmE0tlbf036xh2nFWOn+f53rfnjc9UGlpH50YaKpU3ao8Vb+s+46pPB6c5n8xJM7MnJsgULkYOmVg23Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPonUEIK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPonUEIK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEAFE1F000C4;
	Sat, 17 Oct 2026 19:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792266900;
	bh=Xg+L2BjmZOn93PfKye6IFVgD9zpJXf084Rmymn+Z/fI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oPonUEIK5refiWO1fLpt8guJsLqepKATrVIK0eA6zuqG/GZ+gblH/sEQtGVwlkYFM
	 xiqerHPti+kq1aj7Pr5SL5HVZZwv7pjWByIUdFhgjPc6Sbgee8AIEzd7tufgvwEjZ3
	 yv+/oe9OxqN/FhmSvrFDIKjzYIJj1ZFcWxj+L2JgDOIXr1nkZe5D8JzFSC6e4aT2VY
	 AJSzoGFdJ74hm7nE6EsIybAV7hH5Z68f65VmZITzlX8iWuhTOr8MZe8HyObT5XH2Ug
	 pd0Y4HfvjrTxQHqBQjzgUdhyYTjOoOuCOH7emGWic/cLOKsAiRxRWDN1cQIJqnJlg2
	 USchpUyUaM0kw==
Date: Sat, 17 Oct 2026 20:54:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Amir Atef via B4 Relay
 <devnull+amiratefabdallah1122.gmail.com@kernel.org>
Cc: amiratefabdallah1122@gmail.com, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: iio: frequency: ad9834: use guard(mutex)
Message-ID: <20261017205454.0dda6c10@jic23-hlaptop>
In-Reply-To: <179219435216.322.13409717511306957730.20261017-ad9834-guard-mutex-v2@gmail.com>
References: <179219435216.322.13409717511306957730.20261017-ad9834-guard-mutex-v2@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 17 Oct 2026 02:45:52 +0300
Amir Atef via B4 Relay <devnull+amiratefabdallah1122.gmail.com@kernel.org> wrote:

> From: Amir Atef <amiratefabdallah1122@gmail.com>
> 
> Use guard(mutex) to manage the state lock in ad9834_write() and
> ad9834_store_wavetype(). This simplifies error handling by allowing
> early returns instead of setting the return code and breaking out of the
> switch statement to manually unlock the mutex.
> 
> Signed-off-by: Amir Atef <amiratefabdallah1122@gmail.com>
Hi Amir,

One small additional thing inline.

Thanks,

Jonathan

> ---
> Changes in v2:
> - Add blank line after guard(mutex) in ad9834_write().
> - Move 'int ret;' to the end of the variable declaration block in
>   ad9834_store_wavetype().
> - Drop redundant 'else' in ad9834_store_wavetype() case 1 by inverting
>   the condition (kept 'else' in ad9834_write() and case 0 where they are
>   part of if-else-if-else chains).
> - Replace ternary return with explicit 'if (ret) return ret;' in
>   ad9834_store_wavetype().
> - Link to v1: https://lore.kernel.org/r/179214943270.333.5921549521929682753.20261016-ad9834-guard-mutex@gmail.com
> 
>  drivers/staging/iio/frequency/ad9834.c | 50 ++++++++++++--------------
>  1 file changed, 22 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
> index 0d20f796e0f0..c45bb388c998 100644
> --- a/drivers/staging/iio/frequency/ad9834.c
> +++ b/drivers/staging/iio/frequency/ad9834.c
> @@ -6,6 +6,7 @@
>   */
>  
>  #include <linux/bits.h>
> +#include <linux/cleanup.h>
>  #include <linux/clk.h>
>  #include <linux/dev_printk.h>
>  #include <linux/err.h>
> @@ -154,7 +155,8 @@ static ssize_t ad9834_write(struct device *dev,
>  	if (ret)
>  		return ret;
>  
> -	mutex_lock(&st->lock);
> +	guard(mutex)(&st->lock);
> +
>  	switch ((u32)this_attr->address) {
>  	case AD9834_REG_FREQ0:
>  	case AD9834_REG_FREQ1:
> @@ -165,10 +167,8 @@ static ssize_t ad9834_write(struct device *dev,
>  		ret = ad9834_write_phase(st, this_attr->address, val);
>  		break;
>  	case AD9834_OPBITEN:
> -		if (st->control & AD9834_MODE) {
> -			ret = -EINVAL;  /* AD9834 reserved mode */
> -			break;
> -		}
> +		if (st->control & AD9834_MODE)
> +			return -EINVAL;  /* AD9834 reserved mode */
>  
>  		if (val)
>  			st->control |= AD9834_OPBITEN;
> @@ -194,8 +194,7 @@ static ssize_t ad9834_write(struct device *dev,
>  			st->control |= this_attr->address;
>  			st->control &= ~AD9834_PIN_SW;
>  		} else {
> -			ret = -EINVAL;
> -			break;
> +			return -EINVAL;
>  		}
>  		st->data = cpu_to_be16(AD9834_REG_CMD | st->control);
>  		ret = spi_sync(st->spi, &st->msg);
> @@ -210,9 +209,8 @@ static ssize_t ad9834_write(struct device *dev,
>  		ret = spi_sync(st->spi, &st->msg);

I'd rather see all error handled at point where they originate, rather
than only some (with special case for the last call) so here and similar places, do 
		if (ret)
			return ret;

		break;

Or you could even do a return len; here if you prefer.

>  		break;
>  	default:
> -		ret = -ENODEV;
> +		return -ENODEV;
>  	}
> -	mutex_unlock(&st->lock);
>  
>  	return ret ? ret : len;
>  }

