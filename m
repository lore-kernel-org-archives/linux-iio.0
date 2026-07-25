Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B540286425;
	Sat, 25 Jul 2026 22:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785020189; cv=none; b=GKC5Um314qPg3LLk4yw4IBNEeu+fZhKlutaI9KtyCsoPdHgSlTT23zVPYBA9L1BR29C2BUmo8FSaiPo716Wr6I1wDWkUo34e6bATcquukTkR+XA7n64TGl5MGTpagT25O3I4uOYnBARg/C5o6S7utfIkOMr0k/zeu434TrzEMNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785020189; c=relaxed/simple;
	bh=iDWpAqRkfZ35v8WKKY0xbWLOfcTI8IuQYHGt4m8Um1s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F6KNd1fzBIKgj7gp/51CmbRYDqKP77Fac+8l/ZyEBbmMUEIipfoZi3vDZ8coK4P9X2Yw4uVAlAF53BTNYwfQTaWmqBnimg96SQDoRxUZ1G4w/18hYy4wiD0j7ncI/Q9mTymoi6KLtlQCxU3MSpndWPIqJCFQCDSzTbO7d4c6tFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rq0kxMt2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rq0kxMt2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D228F1F000E9;
	Sat, 25 Jul 2026 22:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785020188;
	bh=oe/e1NIktgaY3sdLbPwFx54yVzEFlDJX9fTvKfXYWuw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Rq0kxMt26gE2Xqbm0ouVxEIwNxdbIX8x2dHFd9/IAqvcbkTQc+r81CZZDK+RS7nwA
	 KlWnqELmHO0+CcfdkuxjQq8woacKEzvpOiPxAF9zyIKH7gvhCjDzdspKqmf7juzPL+
	 663kPcfuCKfevDWT+KNOb0fLWcfsS8szPsQa4lsoeuisjP45W0RK2dd6hlsUUryzpy
	 O3OgmXOWAWcpWOtQCfN9ko8TtMc9E/OxlPFLmVe0APKEKJqbjqbkGGG424zwxTiV14
	 ihrWD3oF51Tbx3rc7jg9KkyO3X3/kl/RyxfbEYm/Nh03WgnZnFwwELxXZES59Z2TvG
	 MTMDeYaN3U82w==
Date: Sat, 25 Jul 2026 23:56:21 +0100
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
Subject: Re: [PATCH v9 15/17] iio: frequency: ad9910: show channel priority
 in debugfs
Message-ID: <20260725235621.6dd73e71@jic23-huawei>
In-Reply-To: <20260722-ad9910-iio-driver-v9-15-459d1df5ac56@analog.com>
References: <20260722-ad9910-iio-driver-v9-0-459d1df5ac56@analog.com>
	<20260722-ad9910-iio-driver-v9-15-459d1df5ac56@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Jul 2026 16:50:24 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Expose frequency_source, phase_source and amplitude_source attributes in
> debugfs. Those indicate from which channel the specific DDS parameter is
> being sourced by returning its label. The implementation follows the
> priority table found in the datasheet.
> 
For this one sashiko raised some questions and made me wonder how this
actually works given it is using active_scan_masks and so far we don't
have any buffered support in the driver.  My guess is you backported
this from on top of some other code that you haven't posted yet.

Please have another check that this all works with just the series
posted.

Note that you will need to claim buffer mode successfully to mess
around with that in paths that aren't inherently only used in buffered
mode.



> @@ -2078,6 +2092,171 @@ static int ad9910_setup(struct device *dev, struct ad9910_state *st,
>  	return ad9910_io_update(st);
>  }
>  
> +static inline const char *ad9910_frequency_source_get(struct iio_dev *indio_dev)
> +{
> +	struct ad9910_state *st = iio_priv(indio_dev);
> +	bool ram_en, mode_en;
> +
> +	guard(mutex)(&st->lock);
> +
> +	/* RAM enabled and data destination is frequency */
> +	ram_en = AD9910_RAM_ENABLED(st);
> +	if (ram_en && AD9910_DEST_FREQUENCY ==
> +		      FIELD_GET(AD9910_CFR1_RAM_PLAYBACK_DEST_MSK,
> +				st->reg[AD9910_REG_CFR1].val32))
> +		return ad9910_channel_str[AD9910_CHAN_IDX_RAM];
> +
> +	/* DRG enabled and data destination is frequency */
> +	mode_en = FIELD_GET(AD9910_CFR2_DRG_ENABLE_MSK,
> +			    st->reg[AD9910_REG_CFR2].val32);
> +	if (mode_en && AD9910_DEST_FREQUENCY ==
> +		       FIELD_GET(AD9910_CFR2_DRG_DEST_MSK,
> +				 st->reg[AD9910_REG_CFR2].val32))
> +		return ad9910_channel_str[AD9910_CHAN_IDX_DRG_FREQ];
> +
> +	/* Parallel data port enabled and data destination is frequency */
> +	mode_en = FIELD_GET(AD9910_CFR2_PARALLEL_DATA_PORT_EN_MSK,
> +			    st->reg[AD9910_REG_CFR2].val32);
> +	if (mode_en && indio_dev->active_scan_mask &&

active_scan_mask is only set on a call to iio_enable_buffers.
So what is this checking?  I guess today it will always fail as
active_scan_mask is NULL.  Once that is in use, it will be racy
however, so you'll need to claim buffered mode (or fail in which
case the null check isn't needed).  That claim will hold it
in a particular state - under the hood it is taking mlock
which is what sashiko suggests - that is just meant to be opaque
to drivers so do it with an explicit attempt to claim buffered mode.


> +	    test_bit(AD9910_SCAN_IDX_FREQ, indio_dev->active_scan_mask))
> +		return ad9910_channel_str[AD9910_CHAN_IDX_PARALLEL_FREQ];
> +
> +	/* FTW: RAM enabled and data destination is phase, amplitude, or polar */
> +	if (ram_en)
> +		return ad9910_channel_str[AD9910_CHAN_IDX_RAM];
> +
> +	/* single tone profiles */
> +	return ad9910_channel_str[AD9910_CHAN_IDX_PROFILE_0 + st->profile];
> +}
