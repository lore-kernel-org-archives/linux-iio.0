Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2B717C211;
	Sun, 26 Apr 2026 12:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777205156; cv=none; b=auEMeg876Me4U+bMwhbbS6zl1FWgIeKb9kn5qlDiKvyR8zYneEpXpj/9oWxh1UY5XGQMitrZUNKybFdFaiZnJnitW+POyDJcdPoXT/eW9JdceVWNOUMdGZeT3HxyxiZ8Bu24govjdxBAu+4kPBor1MzdCx/bFUILVKjnxkCMA10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777205156; c=relaxed/simple;
	bh=6RGWV8X+Tq6jqY0rfKeXf3d4VcQzCvjBnncuYK1Vork=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X0CVj9dRZbivACnb5r/8VhcXkd2NLr8A0kfg1m4KY6ZvR89QBE3mHbWwb32YNcrCedJGJuJXI1jSvOv71cfJde+JE9bZK1oVpTmhFsi7lqkC9TfUMbc7lKQvzGcK48zb38AuyU2xjT/yCbaMqi6rvpuxMjpjyKg7WceurZvSoyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XbSaHAo4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XbSaHAo4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 714BCC2BCAF;
	Sun, 26 Apr 2026 12:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777205156;
	bh=6RGWV8X+Tq6jqY0rfKeXf3d4VcQzCvjBnncuYK1Vork=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XbSaHAo4DvsL4sZ9aNAy93D8F9tSTAdYnJ25QnuLLodUU9X11JRuI9C3DDhhRJ+sW
	 zyFJzqD+/F79MCryOrmmfYNyQaJzMAhTETCeMmOcncabKBv70Y42d6jgt3s0+Z8e3U
	 Y0Lswexjzmk2ttcfQYqZqm1PwiSzCF9OfMmdXF0cSZLnGhx2T4AOknuRImdSVV55AN
	 SYbcsYyGzh4TRW8hkS4NwhDdctD6ZLOS5kApj4jO1xilPGU52/8ZlINF56QxjJyLTI
	 SSUgFCVyqyNMzkLNXW5BS+DcZqIUh9TPH7tp8g/v4Rk22R7Von1rK9S3JhJjSZZpx7
	 s91ogXUw4tU0A==
Date: Sun, 26 Apr 2026 13:05:43 +0100
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
Subject: Re: [PATCH RFC v3 4/9] iio: frequency: ad9910: add digital ramp
 generator support
Message-ID: <20260426130543.6b1f91b6@jic23-huawei>
In-Reply-To: <20260417-ad9910-iio-driver-v3-4-29b93712a228@analog.com>
References: <20260417-ad9910-iio-driver-v3-0-29b93712a228@analog.com>
	<20260417-ad9910-iio-driver-v3-4-29b93712a228@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Apr 2026 09:17:33 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Add DRG channels with destination selection (frequency, phase, or

I'd spell out Digital Ramp Generator here as well rather than
just in the patch title.
 
I'll come back to the comment below (probably) when looking at the
ABI documentation.

> amplitude) based on attribute writes, dwell mode control,
> configurable upper/lower limits, increment/decrement step sizes, and
> step rate settings.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
>  drivers/iio/frequency/ad9910.c | 425 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 423 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/frequency/ad9910.c b/drivers/iio/frequency/ad9910.c
> index 5b4076028a29..c9ec677cd63a 100644
> --- a/drivers/iio/frequency/ad9910.c
> +++ b/drivers/iio/frequency/ad9910.c

>  
> +static const struct iio_chan_spec_ext_info ad9910_drg_ramp_ext_info[] = {
> +	AD9910_DRG_EXT_INFO("frequency_step", AD9910_DRG_FREQ_STEP),
> +	AD9910_DRG_EXT_INFO("phase_step", AD9910_DRG_PHASE_STEP),
> +	AD9910_DRG_EXT_INFO("scale_step", AD9910_DRG_AMP_STEP),

For things that are tidied to a clock rate we normally try to express
then in terms of time rather than ticks / steps as that's what the
user normally cares about.  Anyhow I'll come back to this with the
documentation patch review.

> +	{ }
> +};
