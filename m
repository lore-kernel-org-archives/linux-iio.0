Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491BF86329;
	Mon, 29 Jun 2026 23:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782776306; cv=none; b=oKWJXif7ZDD2cZeRGkJRg1qurukVWm23KkVPizcEG/I7+P7WR8wlV5ERDoEq2duvT6Y39ogQrGWosi5k8K0B1n14JHr2d+mbc0XWZQYFqGHAs719EI3S6qYNRYI5lcTxxpBDRlkZppk16FMu7BjYywp4OGCP6EPcfG5VS3Nomi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782776306; c=relaxed/simple;
	bh=PwI+aPvuoruHcUMHzILq46ZyzXIfIq+mXC6iYEaY2SQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oEISDtirWFRsBUQZN6NS2EN4m8vdxwhFx4UmrIwPpMAgqe9SHe02BpTF21ATZge7lkzF8zKHdlqDusQv4iLKM7ARuOKpUZjODGDUCwzfI5x+vR4yCf225P0xexqNLECa44wGvS2PbDynhbn+r1kpFRPUVjcrHySl3DI0MMIAsNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pap7AHEE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pap7AHEE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5873A1F000E9;
	Mon, 29 Jun 2026 23:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782776304;
	bh=sG4xinHvB/NIYL5C4QDciARVziCppV1KFjGbEXYkF5E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Pap7AHEEdstJCEDvQ7WoQAslrMwVpg0hzTyNAnWpGyl2VfUoMRB0P/SguGi11xZhE
	 SnB1sykxrmb5DckLtH4ebbV67GoVhCbG8kA0sWYDqGhIW2NunijSpbClkTkLAPcr9Q
	 E0ua5oiUXY0qasBpqq6vLF0pzNTOAeUmjObUeYs8MXMqNhQNftpAs/QT5yG15un0+K
	 4PEQmrrSrIqSyJ/tmS+iznvq2lV8nv6D/KmnkwMppAzv389fGL7O4DVYwmOb6MHLAX
	 /pl/Mbnk3yY9LDrWIcvz91/0BIWaENDCNNV/0wkHkwqdKK+W4frTwH5FRNO+uwdErX
	 ctfMGFeCxNfxw==
Date: Tue, 30 Jun 2026 00:38:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, Michael Auchter <michael.auchter@ni.com>,
 linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook
 <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v5 11/12] iio: dac: ad5686: add triggered buffer support
Message-ID: <20260630003819.3798ae27@jic23-huawei>
In-Reply-To: <20260628-ad5686-new-features-v5-11-577caadbf7c0@analog.com>
References: <20260628-ad5686-new-features-v5-0-577caadbf7c0@analog.com>
	<20260628-ad5686-new-features-v5-11-577caadbf7c0@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Jun 2026 15:08:18 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Implement trigger handler by leveraging the LDAC gpio to update all DAC
> channels at once when it is available. Also, the multiple channel writes
> can be flushed at once with the sync() operation.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
I may well have forgotten an earlier discussion about this (assuming Sashiko
found it before now) but the masking of the stuff from the ring buffer
does look necessary to me (at first glance anyway!)

> diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> index db175e77b0b7..3120e6983d9e 100644
> --- a/drivers/iio/dac/ad5686.c
> +++ b/drivers/iio/dac/ad5686.c

>  };
>  EXPORT_SYMBOL_NS_GPL(ad5679r_chip_info, "IIO_AD5686");
>  
> +static void do_ad5686_trigger_handler(struct iio_dev *indio_dev)
> +{
> +	struct iio_buffer *buffer = indio_dev->buffer;
> +	struct ad5686_state *st = iio_priv(indio_dev);
> +	u16 val[AD5686_MAX_CHANNELS] = { };
> +	unsigned int scan_count, ch, i;
> +	bool async_update;
> +	u8 cmd;
> +
> +	if (iio_pop_from_buffer(buffer, val))

The Sashiko comment is that the data in val is controlled by
userspace so might include stuff in the bits where the
_CMD() macros are placing the cmd.  I think we need masking
somewhere and I think it should be in the ad5686_write()
rather than here as that is where the per device macros
are applied.

> +		return;
> +
> +	guard(mutex)(&st->lock);
> +
> +	scan_count = bitmap_weight(indio_dev->active_scan_mask,
> +				   iio_get_masklength(indio_dev));
> +	async_update = st->ldac_gpio && scan_count > 1;
> +	if (async_update) {
> +		/* use LDAC to update all channels simultaneously */
> +		cmd = AD5686_CMD_WRITE_INPUT_N;
> +		gpiod_set_value_cansleep(st->ldac_gpio, 0);
> +	} else {
> +		cmd = AD5686_CMD_WRITE_INPUT_N_UPDATE_N;
> +	}
> +
> +	i = 0;
> +	iio_for_each_active_channel(indio_dev, ch) {
> +		if (st->ops->write(st, cmd, indio_dev->channels[ch].address, val[i++]))
> +			break;
> +	}


