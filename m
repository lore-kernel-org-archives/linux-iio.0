Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E132175A95;
	Sat, 25 Jul 2026 22:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785019606; cv=none; b=bEVfhUemvCAvpN5Xhqhzal9Z8vBpBjiaoRVRctdUB2HoWuHKk2ub1D95TJoxviXY1rLhhX4uYT4w9TerYubK1C/qCarl9VX/4FpmlTu39vfJXN9axzU1COZXZBaw6qhUkTJ3QtwA0/qZ1jdtu7znb5DIb/CCFSxPB/UXn+4oT78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785019606; c=relaxed/simple;
	bh=gj1Ub5SNsXSE0BZBHDQEyBYNVhJNP1yfrzTDvIIR2tw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KCfvSVA2p0VcbkL+3+1wFSmn4BTCt0WPJquIsr4GTyeqbJmSQsM9ZE/br0qlzzuV/tw+jrfuQHBV/4j7HnQDVECO3IGuvh6+cGinz8rQ33rChK+sgkhDx1EHNETM5U6q7yezWBEyEsagc6gjY2bOCNm09nZghK2Rk0S2vwqddfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNLSHwmv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNLSHwmv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C0BE1F000E9;
	Sat, 25 Jul 2026 22:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785019605;
	bh=TAMunMrpAubw8V4mXg6Of5X2Q35Lhj9nxNh5rmYsjIk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LNLSHwmvSFDkXzC/YJuQBgccWOpsSekPgRUxweD+31XYauztaUF8ZYHkm5JIX7NbG
	 M5INAzLQsD/X+ZQkxYM9WwswZ9uUFWdtN+H7EZYgImU/4lObxCmDzUuEgejC+kv5qm
	 T7UOwwRwQQznJNGzmfmuQ3vCrMCF6/ZRbz9qGyR9CAzhNGDmXm2c7I9z5c7F93USLF
	 c5x0bk8XhY2b+5ii0nb8UJCrrsQtGhaZhx1rek5yrXqAz8Xb9+MOT4wdYHpajQ8Sck
	 ElXQ4lQA0OADxXTGOxUOQjfDPykwAUjnvZnjPQOvOjYPnxgdJokb+BVceiJSIdWUOg
	 Q/OHQmW5jcaiA==
Date: Sat, 25 Jul 2026 23:46:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, "Gustavo A.
 R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v9 13/17] iio: frequency: ad9910: add RAM mode support
Message-ID: <20260725234637.4ee42657@jic23-huawei>
In-Reply-To: <20260722-ad9910-iio-driver-v9-13-459d1df5ac56@analog.com>
References: <20260722-ad9910-iio-driver-v9-0-459d1df5ac56@analog.com>
	<20260722-ad9910-iio-driver-v9-13-459d1df5ac56@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Jul 2026 16:50:22 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Add RAM control channel, which includes:
> - RAM data loading via firmware upload interface;
> - Per-profile configuration and DDS core parameter destination as firmware
>   metadata;
> - Profile switching relying on profile channels;
> - Sampling frequency control of the active profile;
> - ram-enable-aware read/write paths that redirect single tone
>   frequency/phase/amplitude access through reg_profile cache when RAM is
>   active;
> 
> When RAM is enabled, the DDS profile parameters (frequency, phase,
> amplitude) for the single tone mode are sourced from a shadow register
> cache (reg_profile[]) since the profile registers are repurposed for RAM
> control.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
As mentioned in reply to an earlier patch, I haven't looked in detail
at the firmware cancel path stuff sashiko is unhappy with.  Whilst
it looks like the sort of esoteric path where maybe it is fine to fail
good to take one more look.

One other thing Sashiko commented on inline. I think that is either right
or a bit more detail is needed in the comment.

Thanks,

Jonathan


> diff --git a/drivers/iio/frequency/ad9910.c b/drivers/iio/frequency/ad9910.c
> index 6c794e1b4b1c..844cc0cc8f3e 100644
> --- a/drivers/iio/frequency/ad9910.c
> +++ b/drivers/iio/frequency/ad9910.c
...

> @@ -1119,7 +1220,7 @@ static int ad9910_write_raw(struct iio_dev *indio_dev,
>  	struct ad9910_state *st = iio_priv(indio_dev);
>  	u64 tmp64;
>  	u32 tmp32;
> -	int ret;
> +	int ret, i;
>  
>  	guard(mutex)(&st->lock);
>  
> @@ -1156,6 +1257,41 @@ static int ad9910_write_raw(struct iio_dev *indio_dev,
>  						   AD9910_CFR2_DRG_DEST_MSK |
>  						   AD9910_CFR2_DRG_ENABLE_MSK,
>  						   tmp32, true);
> +		case AD9910_CHANNEL_RAM:
> +			if (AD9910_RAM_ENABLED(st) == !!val)
> +				return 0;
> +
> +			/* swap profile configs */
> +			for (i = 0; i < AD9910_NUM_PROFILES; i++) {
> +				tmp64 = st->reg[AD9910_REG_PROFILE(i)].val64;
> +				ret = ad9910_reg64_write(st,
> +							 AD9910_REG_PROFILE(i),
> +							 st->reg_profile[i],
> +							 false);
> +				if (ret)
> +					break;
> +				st->reg_profile[i] = tmp64;
> +			}
> +
> +			if (ret) {
> +				/*
> +				 * After the write failure, profiles 0..i-1 were
> +				 * already swapped in SW, but Hw registers are
> +				 * still pending an IO update, so swap them back
> +				 * in SW to keep the state consistent.

Sashiko's follow up question about whether a subsequent use of IO update might
end up with these stale values seems like a reasonable one. Perhaps a little
more detail on why that doesn't matter is needed here?

> +				 */
> +				while (i--) {
> +					tmp64 = st->reg[AD9910_REG_PROFILE(i)].val64;
> +					st->reg[AD9910_REG_PROFILE(i)].val64 = st->reg_profile[i];
> +					st->reg_profile[i] = tmp64;
> +				}
> +				return ret;
> +			}
> +
> +			tmp32 = FIELD_PREP(AD9910_CFR1_RAM_ENABLE_MSK, !!val);
> +			return ad9910_reg32_update(st, AD9910_REG_CFR1,
> +						   AD9910_CFR1_RAM_ENABLE_MSK,
> +						   tmp32, true);
>  		default:
>  			return -EINVAL;
>  		}

