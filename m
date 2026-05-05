Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1B631F987;
	Tue,  5 May 2026 11:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777979824; cv=none; b=VmO/Q7D4eevvmcsQzaaJhIp9KedQeuBVW2tJWBvNcB3Ll7WYbBj5M1vdgmdOCdUxxch+kVsDgLmK5F1gioiXTHa1/yhNlz6VWQHldEZLMZ8oov78WhRL/2I4ckgGRRCNj9J5Tm6Tb9jtnHAmsKVMRZEOecSHoiyIDlkS9bBZv/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777979824; c=relaxed/simple;
	bh=1sAV/zJ8eDOdQg0Nm0ltSwEgeutC52DlYk0oCKWSsAs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mJbe8ulmzXSHYhPUGqHw9ESy31SA7V3EErcYEyfoaViv3YyMlOLqkdUB3/RpAT12u5zxOrevTKsivvS7LcOnp5wJiDs5BeX18PAfzkC8PAPU3qETErtxyAeGnRfJ3ocJbQ+OjescFOPgfz8MZFxrSeHfXYbmUnYYKONwopb7dMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDE8jTxS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDE8jTxS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C9DEC2BCB4;
	Tue,  5 May 2026 11:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777979823;
	bh=1sAV/zJ8eDOdQg0Nm0ltSwEgeutC52DlYk0oCKWSsAs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HDE8jTxSUl/J4/wWKXNZ2XOd8V05FiOlilhbjCZry60/3pzsewav/QX23DR71IOVE
	 wbTe6UTVTF75FUmcIhseYYsirGd1S1OtcM3tboK8MAMw6gP8Fl+dlSJVkveC0eIxeD
	 5H5RK73HaiNKj9p82zvttfXON3RERVz/cUtTe93tg1JVV3xAGtTRuKX5jpa25XSrFI
	 nk3V2ZDLXbOHSFzH71gsi6LkawKM3izB/vkBfyXBX3IgKAKD3p6E1HdW7kegBHP6Kq
	 exniMutwOLePqDxHCM1N2ThDXiH7SYwnM+L0AmdZM/48wq/PRcx2QI0n9gucgMD1s1
	 YdTMWZaUlYOeQ==
Date: Tue, 5 May 2026 12:16:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Stefan Popa <stefan.popa@analog.com>,
 Jonathan Cameron <jic23@cam.ac.uk>, Greg Kroah-Hartman <gregkh@suse.de>,
 Michael Auchter <michael.auchter@ni.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v5 04/12] iio: dac: ad5686: fix powerdown control on
 dual-channel devices
Message-ID: <20260505121652.5f7ac73d@jic23-huawei>
In-Reply-To: <20260501-ad5686-fixes-v5-4-0b2f45488418@analog.com>
References: <20260501-ad5686-fixes-v5-0-0b2f45488418@analog.com>
	<20260501-ad5686-fixes-v5-4-0b2f45488418@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 01 May 2026 10:14:57 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Fix powerdown control by using a proper bit shift for the powerdown mask
> values. During initialization, powerdown bits are initialized so that
> unused bits are set to 1 and the correct bit shift is used. Dual-channel
> devices use one-hot encoding in the address and that reflects on the
> position of the powerdown bits, which are not channel-index based
> for that case. Quad-channel devices also use one-hot encoding for the
> channel address but the result of log2(address) coincides with the channel
> index value. The issue was introduced when first adding support for
> dual-channel devices, which overlooked powerdown control differences.
> 
> Fixes: 7dc8faeab3e3 ("iio: dac: ad5686: add support for AD5338R")
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>

Just for reference I think the sashiko bug report on this one is spurious
due to -fwrapv (signed integer overflow being defined for kernel).

It is non obvious though!  So this one is fine but the guard() I'm suggesting
in the previous patch review to protect get_powerdown_mode() against races
would add some mess to this one so I won't apply it until that's addressed
(or argued against!)
> ---
>  drivers/iio/dac/ad5686.c | 40 ++++++++++++++++++++++++++++++----------
>  1 file changed, 30 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> index 69358dd66cbc..c607251b82a0 100644
> --- a/drivers/iio/dac/ad5686.c
> +++ b/drivers/iio/dac/ad5686.c
> @@ -25,24 +25,35 @@ static const char * const ad5686_powerdown_modes[] = {
>  	"three_state"
>  };
>  
> +static inline unsigned int ad5686_pd_mask_shift(const struct iio_chan_spec *chan)
> +{
> +	if (chan->channel == chan->address)
> +		return chan->channel * 2;
> +
> +	/* one-hot encoding is used in dual/quad channel devices */
> +	return __ffs(chan->address) * 2;
> +}
> +
>  static int ad5686_get_powerdown_mode(struct iio_dev *indio_dev,
>  				     const struct iio_chan_spec *chan)
>  {
> +	unsigned int shift = ad5686_pd_mask_shift(chan);
>  	struct ad5686_state *st = iio_priv(indio_dev);
>  
> -	return ((st->pwr_down_mode >> (chan->channel * 2)) & 0x3) - 1;
> +	return ((st->pwr_down_mode >> shift) & 0x3) - 1;
>  }
>  
>  static int ad5686_set_powerdown_mode(struct iio_dev *indio_dev,
>  				     const struct iio_chan_spec *chan,
>  				     unsigned int mode)
>  {
> +	unsigned int shift = ad5686_pd_mask_shift(chan);
>  	struct ad5686_state *st = iio_priv(indio_dev);
>  
>  	guard(mutex)(&st->lock);
>  
> -	st->pwr_down_mode &= ~(0x3 << (chan->channel * 2));
> -	st->pwr_down_mode |= ((mode + 1) << (chan->channel * 2));
> +	st->pwr_down_mode &= ~(0x3 << shift);
The bug reported is that 0x3 is singed and shift can be 30 which
would overflow. However that should be fine in the kernel.
Bit odd though so maybe force that 0x3 to be unsigned.


> +	st->pwr_down_mode |= (mode + 1) << shift;
>  
>  	return 0;
>  }


