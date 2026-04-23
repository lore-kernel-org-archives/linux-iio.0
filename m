Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBC536E46C;
	Thu, 23 Apr 2026 17:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776967174; cv=none; b=GDB3IiGU2kJ5hGMhz4ntAsnRHpsN9G68jT7FcByORZ0QcSrLe73s+bcWciIPFSvTCcEXwBxD3WLH4ZohsQ1gksTqv8/KoLvWaHsO3Gh8aHvvfZ/aiMyysldvhIYOiXkaudGPUjt1u8Qs79m/bB0HubGE2AZsqRKf5S0okKjKlSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776967174; c=relaxed/simple;
	bh=piCFcL2iIZKcQyjk2NcguxyqTnbHLrGuvcjbgiTr5Ao=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ap9giwUffP/GbUn7gXKDtDan50u/aTqXsZCla3ODy13SjO8hiXYvp1FExFXvlWrIFelu1xb8U7J06GxcaaRUmaco1F/4KGSvn+ZTTVxuZV0iO+hmZHZu4lQ8t2kP9yMwzSlCOhUn4P15K6bwsSeYzgTdwu0kNBY+ECOINKNxIAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDmkjeoc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDmkjeoc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 585F9C2BCAF;
	Thu, 23 Apr 2026 17:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776967174;
	bh=piCFcL2iIZKcQyjk2NcguxyqTnbHLrGuvcjbgiTr5Ao=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MDmkjeocIHOpDWrNaTDWPDUdnIzMPh4aXptVJxggJAO3M5r7+vMQXTrYu1fAeQDC2
	 w9xuxNytWbw6f1a+1L19X+6YY1z3crDkAs55yXr/Fougn5oQ43zlL+J78w5C6eIBHF
	 JuodWsNaCnTMEcizA0tt+gP3ObgyFfoOnzF0ppa7+HraQ0Qz/56usn2tLrPsoVriMy
	 kcXeuNFe3fBBD6bwhS39djo0cpgWnxmn92MDbi913zRAeG1RLqAYVlBxWP8HJA78io
	 5weT8VjSWZj+IOSFNTnFa8h1lFZVZRXsRd3Mr9RGJlcY3NWuMT8+N7W749K+PtMTLR
	 pcQ+BBVvtXsMg==
Date: Thu, 23 Apr 2026 18:59:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Auchter
 <michael.auchter@ni.com>, linux-hardening@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Kees
 Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 12/22] iio: dac: ad5686: fix powerdown control
Message-ID: <20260423185923.5f25da8d@jic23-huawei>
In-Reply-To: <20260422-ad5313r-iio-support-v1-12-ed7dca001d1b@analog.com>
References: <20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com>
	<20260422-ad5313r-iio-support-v1-12-ed7dca001d1b@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Apr 2026 15:45:46 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> This patch fixes powerdown control issues by protecting the cached
> powerdown states with mutex access, and by using a proper bit shift for
> the powerdown mask values. During initialization, powerdown bits are
> initialized so that unused bits are set to 1 and the correct bit shift is
> used.
> 

Mostly avoiding repeating stuff Andy raised already.

> Dual-channel devices use one-hot encondig in the address and that reflects

encoding.

> on the position of the powerdown bits, which are not channel-index based
> for that case. Quad-channel devices also use one-hot encondig for the
> channel address but the result of log2(address) coincides with the channel
> index value.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
>
>  static int ad5686_get_powerdown_mode(struct iio_dev *indio_dev,
>  				     const struct iio_chan_spec *chan)
>  {
>  	struct ad5686_state *st = iio_priv(indio_dev);
> +	int mode, shift = ad5686_pd_mask_shift(chan);
Split that into two lines.  
	int shift = ...
	int mode;

Having a mixture of initialized and not is not good for readability.

>  
> -	return ((st->pwr_down_mode >> (chan->channel * 2)) & 0x3) - 1;
> +	mutex_lock(&st->lock);
> +	mode = ((st->pwr_down_mode >> shift) & 0x3) - 1;
> +	mutex_unlock(&st->lock);
> +
> +	return mode;
...

