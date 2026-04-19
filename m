Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952C628002B;
	Sun, 19 Apr 2026 12:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776600491; cv=none; b=ZcOawNVsyovD3a59bCZMAY8AYNYJwKd2jTe2uDs864SgY9Kc4TRCLOsCNsMMgCeCN1RpiZqfRdQvHoRCZ1qUGgOqFKWMXHpzAr3X7LZVOWvHaPdmrgG9q1MS/BpTE5tmNLdU3hofE4vEZ8BvZINdYEOCOYL6VznoE2S0+HKAsUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776600491; c=relaxed/simple;
	bh=16hy5Qhxcwf4LDpVRBbajmfL6PmoPdCeSXpnmobQelE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tnrJ0oIRZ8wCmGoDez4FGuv50FikXkp3p2ZepupI10I+SKZGRefjFTliFuv34nDvNIxihZEW2zf+DB36jCuoFpRR9HIW5QAYn4F1sPc4QPMWKa4vIGLimXxCTaH6Sbc26q8uEWNQ9BiiEsPr/hHIxq0nhDACOsEHk0Vcz3N/rE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kx0cL2iJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kx0cL2iJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BECBEC2BCAF;
	Sun, 19 Apr 2026 12:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776600491;
	bh=16hy5Qhxcwf4LDpVRBbajmfL6PmoPdCeSXpnmobQelE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Kx0cL2iJgM9LV/foNywWRQWy6tmU5TU0CyoI9+ikbZlHDC4Osu2yKv2oX2KA97WVn
	 sUMKbSLCV1nP4N7i95LBx87AesF1IBn2SmivKR+3sIUbGU1HdJzaQMANqFpHAVda4Q
	 bkjXjw84sl3pGchNpkPHjg4GXufgCBt5K97SUK1n/IvyBcI5K6OURS64RhP+l5AjoD
	 WlUSChyIb/VdnrBT6t9gdhuJkheuNIa2xJonxjoLbz7C2bKpBUJIB7+Q86q9meYnTv
	 HjqVrrp1g40psofUjK7SNHZZPjWsuDB0wDDJTPkRQNGu51DmC2rbU5SBRARj3PMISN
	 CzNFdKVBhhcbQ==
Date: Sun, 19 Apr 2026 13:08:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: antoniu.miclaus@analog.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads7924: Use guard(mutex) for locking
Message-ID: <20260419130802.31621dcf@jic23-huawei>
In-Reply-To: <20260418144431.138815-2-giorgitchankvetadze1997@gmail.com>
References: <20260418144431.138815-2-giorgitchankvetadze1997@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 18 Apr 2026 18:44:32 +0400
Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com> wrote:

> Replace mutex_lock()/mutex_unlock() calls with guard(mutex)() to
> simplify locking and make cleanup automatic when the lock goes out
> of scope.
> 
> Signed-off-by: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Hi Giorgi.

This is a slightly odd case as this is the only use of the mutex,
so all it currently protects against is concurrent calls via this path.
That's valid, but it lets us think about neater solutions.

That made me wonder if this is the best level to do the locking at.
I think it would be neater to push the guard() down to the top
of ads7924_get_adc_result() rather than having any lock handling
in ads924_read_raw()

You won't need the extra scope defined here and it will make it easier
to see why the lock is held.

Despite the comment saying it's about concurrent reads, I think it
is really about queuing multiple reads up so the sleep isn't repeated
if they are racing.  The regmap internal lock would otherwise be sufficient.

Thanks

Jonathan

> ---
>  drivers/iio/adc/ti-ads7924.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads7924.c b/drivers/iio/adc/ti-ads7924.c
> index bbcc4fc22b6e..21bd5cb973f4 100644
> --- a/drivers/iio/adc/ti-ads7924.c
> +++ b/drivers/iio/adc/ti-ads7924.c
> @@ -12,6 +12,7 @@
>   */
>  
>  #include <linux/bitfield.h>
> +#include <linux/cleanup.h>
>  #include <linux/delay.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/init.h>
> @@ -226,14 +227,13 @@ static int ads7924_read_raw(struct iio_dev *indio_dev,
>  	struct ads7924_data *data = iio_priv(indio_dev);
>  
>  	switch (mask) {
> -	case IIO_CHAN_INFO_RAW:
> -		mutex_lock(&data->lock);
> +	case IIO_CHAN_INFO_RAW: {
> +		guard(mutex)(&data->lock);
>  		ret = ads7924_get_adc_result(data, chan, val);
> -		mutex_unlock(&data->lock);
>  		if (ret < 0)
>  			return ret;
> -
>  		return IIO_VAL_INT;
> +		}
>  	case IIO_CHAN_INFO_SCALE:
>  		vref_uv = regulator_get_voltage(data->vref_reg);
>  		if (vref_uv < 0)

