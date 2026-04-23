Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F68642AA6;
	Thu, 23 Apr 2026 18:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776967394; cv=none; b=oFrbYc0pxiaZjgVvaJnKwgLyW1Ji8gQhlExnd54qRl4598pGBcryKsPZLeZTP23TXWWhKbQMO4VYtzuohf+YArukNVvhhNCOkoAZJIPCJy5i8K/KUsaiya0z/srMa4l/31fm4ZIhbZS03avlpv85AheZPpWH2aNbw8gC2RBWn+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776967394; c=relaxed/simple;
	bh=EHpWjMAwCtqlswKrTVZYZTYG/QQCfwOqSJOsa6+21OA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Axd9mnrCpcKSB6eeZ8EfHCTEvxr5ExeAdYq+KzGffss3G/fGDeWTi5uSNYtvnCPFIy9l38n1wLQsGntSGvj1UiDqiiCRi/gOluW+T0KZlaFamK5ERXbYygwg1t0r8CZOG5zVjn1dcDme/ow7STg4/0Sxw1LF+S022xmo69qMeRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MvSRYz7X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MvSRYz7X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C56AC2BCAF;
	Thu, 23 Apr 2026 18:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776967394;
	bh=EHpWjMAwCtqlswKrTVZYZTYG/QQCfwOqSJOsa6+21OA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MvSRYz7X8GKaO059s0KYld760Ux6kXUjq7D6qr9G9qe1TNIBoUN1beuePVYfzhDi5
	 yrnGDBmxyQg8GDoebISFifYpTmOcFMuZQSFsBsJtysKDria3PPHuolKpf11+/Qr/tm
	 SuINKg6QDtEzXjunUi8/XC/0HNA0GX36Dqhv6Ga1WavNqil2YUTRhD+0pN81/TjbJT
	 s+WbM0qhkollvop2EbC0rYfj8NjeMN5HX4W3Jphyn8w5seuiMeGds5m0hSWUTXSOk3
	 oUvyE2YiQyTgG5Ea92kqzcke2EgSmU6P4DYBPqv/xqCk/G1+o+UDbkJnpTFnEVa21F
	 l2AiixKobgDSQ==
Date: Thu, 23 Apr 2026 19:03:02 +0100
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
Subject: Re: [PATCH 13/22] iio: dac: ad5686: fix input raw value check
Message-ID: <20260423190302.338ecdbe@jic23-huawei>
In-Reply-To: <20260422-ad5313r-iio-support-v1-13-ed7dca001d1b@analog.com>
References: <20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com>
	<20260422-ad5313r-iio-support-v1-13-ed7dca001d1b@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Apr 2026 15:45:47 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Use in_range() to fix range check for input raw value, which is off by
> one, i.e., for a 10-bit DAC the max valid value is 1023, but 1 << 10
> equals 1024, which passes the previous check, allowing an out-of-range
> write.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
>  drivers/iio/dac/ad5686.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> index 19d791c655b7..07a944311f0e 100644
> --- a/drivers/iio/dac/ad5686.c
> +++ b/drivers/iio/dac/ad5686.c
> @@ -185,7 +185,7 @@ static int ad5686_write_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		if (val > (1 << chan->scan_type.realbits) || val < 0)
> +		if (!in_range(val, 0, 1 << chan->scan_type.realbits))

Might just be me, but I do find in range a bit weird when the offset is 0.

I'd be tempted to just make the check >=
 
>  			return -EINVAL;
>  
>  		mutex_lock(&st->lock);
> 

