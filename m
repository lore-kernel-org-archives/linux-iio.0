Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792972140;
	b=04JsETalSd5blhZ82TpLG3Gu7CEjT7cw/rGHZLMPe8xrdvdWXyztFyszPgOEMtTRj6vG
	 znWtmy9xjhH+4re8DBpHXN0Lz4QINystXVD5XdDljIMMlfp9I21VR3BnR8mH7+o+4HF9o
	 NNUu4SC8F+0CvMtw05FmNH4Ow+aPmLTNvjmufBP5n9pdSiQXd5xS3Oz1Ie7zgokeWjfhY
	 QqhaQ57q6xQ/pCUvWuWlHo3pYvvce7oRY1+FZssaYbqFxgqZd2M3WrGBXnI9X1N8/kfMQ
	 u5ftt4BK7pTFdbx61tSgHdLxFSG0F3TBtZlEoX8HNVGEiyRvXSlME5niRp4/56NWu2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792972140;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=mezoK2VZHuQsu7p6myHJ5EdzM1VQCFQnX3rSyq9jwJw=;
	b=hLm8uLheWLNc/1P7HlVFtGsCZ2XZwI6E7oPP2utOq7+lg0y9BR7lp8RzCL19XZmPi5yU
	 erpe/MNoVCmVHevKrlkKjRdV93FjKkY0i30Om9haWLfhTI+5vSYNS3kssIJ6NHEydXorp
	 1OKXIwO8TNZ/chr0l8ZJBJX2zGgE5SSovbLOEGRlFcdqqDHRAr/+959sEErKEsXAuZPLN
	 eqcO/h8Yrfhe/HpfEfgl+RbXWJp+zolXHJQkLtKYVoS4y1WpfIneDTxiXnjPwQF93wxxI
	 FPP7TxWg3rTqZItlpkVSk+WWv+/XCVIxHnbiFd1EK+j5aTRA0ltkBojUGMg8qtW4mfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UcC6fvOA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66059606A31B;
	Sun, 25 Oct 2026 23:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UcC6fvOA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3934E1F01825;
	Sun, 25 Oct 2026 23:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792972140;
	bh=mezoK2VZHuQsu7p6myHJ5EdzM1VQCFQnX3rSyq9jwJw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UcC6fvOAeuddlpGwwm5HvyA0ve7BfGvTmFrXzAT4C5WxFJpGVIz3B021hWyrby6tp
	 L85l/hn0qFp1jD9XG3iguON0YmZO1g3uWocCLCzBpmT3cknt1vosg4T9LMKLJJpJQ/
	 Dt7EXHSkkLn6BRz5yGMiDw9NMh2LujLU/XdppFQhdt62nBM6qO2xccg/XQq+7pWgud
	 upvH847HUjEn/W9XbHZJU9gxaH11oJ1sq+jTUpk4rLrqqfuC1IkmH2FLvYpc2unCEi
	 Vd/d7JxZRNNk4lJE7JvZmuUvIVkUE7siywxv6ammW6TR3zendxtCD93Bddj58VygfK
	 GAwrtUJuLNE/w==
Date: Sun, 25 Oct 2026 23:48:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Prabhakar <prabhakar.csengg@gmail.com>, Cosmin Tanislav
 <cosmin-gabriel.tanislav.xa@renesas.com>, Andy Shevchenko
 <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Magnus Damm
 <magnus.damm@gmail.com>, linux-iio@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Prabhakar
 <prabhakar.csengg+renesas@gmail.com>, Biju Das
 <biju.das.jz@bp.renesas.com>, Fabrizio Castro
 <fabrizio.castro.jz@renesas.com>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v3 8/8] iio: adc: rzt2h: Add support for RZ/V2H(P) SoC
Message-ID: <20261025234850.41bc8f15@jic23-hlaptop>
In-Reply-To: <atyKo0pTYZyt5XJc@ashevche-desk.local>
References: <20261023175919.160103-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
	<20261023175919.160103-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
	<atyKo0pTYZyt5XJc@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 24 Oct 2026 13:38:27 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Oct 23, 2026 at 06:59:19PM +0100, Prabhakar wrote:
> 
> > Add support for the ADC found on the Renesas RZ/V2H(P) SoC, which shares
> > the RZ/T2H ADC IP but differs in channel count, sampling, calibration and
> > resolution support.
> > 
> > The RZ/V2H(P) ADC provides 8 channels, has a fixed conversion time of
> > 20 ADCLK cycles, does not support calibration, and supports selectable
> > 12-bit and 8-bit conversion resolution.
> > 
> > Expose the fixed sampling frequency as a read-only attribute and allow
> > the conversion resolution to be changed through the scale attribute.
> > Use extended scan types so the reported scan type follows the selected
> > resolution, and prevent resolution changes while buffered capture is
> > active.  
> 
> ...
> 
> > +static int rzt2h_adc_write_scale(struct iio_dev *indio_dev,
> > +				 struct iio_chan_spec const *chan,
> > +				 int val, int val2)
> > +{
> > +	struct rzt2h_adc *adc = iio_priv(indio_dev);
> > +	u64 req_scale, scale;
> > +	unsigned int i;
> > +
> > +	if (!(adc->chip_info->features & RZT2H_ADC_FEATURE_RES_SELECT))
> > +		return -EINVAL;
> > +
> > +	req_scale = mul_u32_u32(val, NANO) + val2;  
> 
> But what's wrong with the simple 1ULL * val * NANO?
> 
> > +	for (i = 0; i < chan->num_ext_scan_type; i++) {
> > +		scale = mul_u32_u32(RZT2H_ADC_VREF_mV, NANO) >>  
> 
> Similar Q.

Patch on top please - I might squash it with original.

Thanks,

Jonathan

> 
> > +			chan->ext_scan_type[i].realbits;
> > +		if (scale == req_scale)
> > +			break;
> > +	}
> > +	if (i == chan->num_ext_scan_type)
> > +		return -EINVAL;
> > +
> > +	/* The scan type changes with the resolution. */
> > +	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
> > +	if (IIO_DEV_ACQUIRE_FAILED(claim))
> > +		return -EBUSY;
> > +
> > +	adc->resolution = i;
> > +
> > +	return 0;
> > +}  
> 

