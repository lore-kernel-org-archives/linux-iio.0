Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE1F349CC2;
	Wed,  1 Jul 2026 20:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782938571; cv=none; b=GgEKFlTweExKkHRCfQGTrhj2wwzMGp+54KBKhDA7cHm3QW2qBllvH97L7Ul2Gyu3m6SvDhK5472e9WiNKMSgDH8mYCwClaluP+lckY3Uu6TlfDG7OY3l1w04ZBbupLLutvPmonWTHis5fjb202BoiQFZ83pL3kcBYdw+EKYlJ6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782938571; c=relaxed/simple;
	bh=urKLDAIiFmKybLLi6yfD2LKhWVS2RzdByI5RSDlIzQE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kjbcj3BU8TECKH5OhQqa/PW/itx1LFJCkZB72DfQaq/MSb3rhXezfaNs46iYKnM8oUqZFoQZWhG6xuJ5NzCQcMZpUv14o2kbtX3mFzSJh+j/PR/3rDvANHcZKLgdNFgr0XkmR4hCAOFzhN0sOzbpZsPSjxAzj1rMrKZBsoX9AZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3UNtXuy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3UNtXuy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5AD11F000E9;
	Wed,  1 Jul 2026 20:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782938569;
	bh=y1BvtaSNIJnoBgAy+XG9PF2qiaRpH3VVwPbPhFni4UA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Q3UNtXuyhh19YJ5CdkMbps5+pZGhxVz58KgyDNYf3gIfZ+MjzyWrXIquW7G0MOwSY
	 0QRWBusxxDkmYMb9s74F+Q78j6j/N60TLaXEKsChd2WFRgIFoQKqCtzrBQwqiIu1Jn
	 UlgAiAOq+ONOEIqx0F5Y9ykfzdESSfh9icwpzQbL4V4Hdt1QX+lHQ9aiRfcJS9VrdP
	 B6TgOF8AO9CakLES5w4nM0VzeSRsX7bZALSvGlJJvwmtW46298sltyeAzEUQ2ZlgfS
	 6YZ/A8VhCYFTzCI9TQ0f4ZSNFXIasr3sWGWrzF6oW9QUFXFr1NqKJzWYjcp2aRCetM
	 adcIc9FGirCkg==
Date: Wed, 1 Jul 2026 21:42:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Batu Ada Tutkun <batuadatutkun@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: frequency: ad9834: use guard() for mutex
 locking
Message-ID: <20260701214244.11dc26f7@jic23-huawei>
In-Reply-To: <20260625120456.1267-1-batuadatutkun@gmail.com>
References: <20260625120456.1267-1-batuadatutkun@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jun 2026 15:04:55 +0300
Batu Ada Tutkun <batuadatutkun@gmail.com> wrote:

> Replace manual mutex_lock()/mutex_unlock() pairs with guard(mutex) in
> ad9834_write() and ad9834_store_wavetype(). The mutex is now released
> automatically when each function returns, removing the need for
> explicit unlock calls.
> 
> Signed-off-by: Batu Ada Tutkun <batuadatutkun@gmail.com>

Whilst we aren't taking this forwards, a few comments inline for future
reference.

> ---
>  drivers/staging/iio/frequency/ad9834.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
> index bdb2580e2..f15819eaf 100644
> --- a/drivers/staging/iio/frequency/ad9834.c
> +++ b/drivers/staging/iio/frequency/ad9834.c
> @@ -17,6 +17,7 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/err.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>

I'm guessing cleanup.h is missing as well. You should have both
when guard(mutex) is is in use.

>  #include <asm/div64.h>
>  
>  #include <linux/iio/iio.h>
> @@ -152,7 +153,7 @@ static ssize_t ad9834_write(struct device *dev,
>  	if (ret)
>  		return ret;
>  
> -	mutex_lock(&st->lock);
> +	guard(mutex)(&st->lock);
>  	switch ((u32)this_attr->address) {
>  	case AD9834_REG_FREQ0:
>  	case AD9834_REG_FREQ1:
> @@ -210,7 +211,6 @@ static ssize_t ad9834_write(struct device *dev,
>  	default:
>  		ret = -ENODEV;

The big advantage of using guard() is not removing mutex_unlock() but
instead that you can use simpler code flow.  Here you should return early.

There are a lot of error returns in this function and it may even
make sense to return len early if no error.

>  	}
> -	mutex_unlock(&st->lock);
>  
>  	return ret ? ret : len;
>  }
> @@ -226,7 +226,7 @@ static ssize_t ad9834_store_wavetype(struct device *dev,
>  	int ret = 0;
>  	bool is_ad9833_7 = (st->devid == ID_AD9833) || (st->devid == ID_AD9837);
>  
> -	mutex_lock(&st->lock);
> +	guard(mutex)(&st->lock);
>  
>  	switch ((u32)this_attr->address) {
>  	case 0:
> @@ -269,7 +269,6 @@ static ssize_t ad9834_store_wavetype(struct device *dev,
>  		st->data = cpu_to_be16(AD9834_REG_CMD | st->control);
>  		ret = spi_sync(st->spi, &st->msg);
>  	}
> -	mutex_unlock(&st->lock);
Similar applies in this function where there are a lot of paths
that can become early error returns if guard() is used.

Jonathan

>  
>  	return ret ? ret : len;
>  }

