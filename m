Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A89362154;
	Sun, 12 Apr 2026 17:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776015865; cv=none; b=fEc1mmIx2fZx1ydjRDE3rIPSWLKASPG9GEOPx1K83oWc0LyLqdP6CwmJaPZPjX2N+JqmRcGooaV9EwNXfWkLX5cGRQ93K40hL75bSaJjaXN0AyaD+p9o+b9F8v2kuV9Knuun+kVg/TXuHPASv3Df3v7AXo1Ha2ljOQYNub1Ft6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776015865; c=relaxed/simple;
	bh=LkZdh5t8539kH5FBQoKL774209JqHK+ZPCWbdv9GgZI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RE8GEZIzRZRT/46PBH0T+dWGVzNXiuaoLoUbsuNaUEY9gDSX/MUJf+kswaFtbuKiHzkcBbjaJEx0gVjPOzR2QMFtREceFUUDzPNdYhvYLu/foCRbHWzZaF/dArGw7W08Lhf7PPFL5Uhm1fbrB+ZIX59lSC3/WmWTgnZShahINHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dEZpsM6e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEZpsM6e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D7F4C19424;
	Sun, 12 Apr 2026 17:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776015865;
	bh=LkZdh5t8539kH5FBQoKL774209JqHK+ZPCWbdv9GgZI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dEZpsM6eBY393c0cwPBqpy/agCPk3tRbYsfY4X6SRnUPVXg5qyhusmDbG6Xk3M+hw
	 pKMj+aoGGdY75WVCebVkXVjphXP8GLLMjckn0TvpDQrErTwLc7eTnRQaVbbag0KqaW
	 Y497AJusu7VaDVEeJnOoCYqhUWxRsDAJGTrcbITicef53gShbJgxVPwxqG4DunZ1rK
	 SOlpz6clhcRKCBdiPgSfzmFvlLO26LII3JLWxxg7kNFOYisWhcFsfRO5JtCvpARLhy
	 z5olYQtxAe01+HEJK2u9BjS+ouy3QyCZ8u3+4fKHd4cKziyiFsRfI7iOSOiNaWOg/q
	 fWXE0oxhQLYmg==
Date: Sun, 12 Apr 2026 18:44:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <ukleinek@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>, Bartosz
 Golaszewski <brgl@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 3/6] iio: adc: ad4691: add triggered buffer support
Message-ID: <20260412184411.724a54bc@jic23-huawei>
In-Reply-To: <20260412184301.05544396@jic23-huawei>
References: <20260409-ad4692-multichannel-sar-adc-driver-v7-0-be375d4df2c5@analog.com>
	<20260409-ad4692-multichannel-sar-adc-driver-v7-3-be375d4df2c5@analog.com>
	<0f05add7-96c0-4eee-b396-d6e1be904c09@baylibre.com>
	<20260412184301.05544396@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 12 Apr 2026 18:43:01 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 10 Apr 2026 15:46:36 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
> > On 4/9/26 10:28 AM, Radu Sabau via B4 Relay wrote:  
> > > From: Radu Sabau <radu.sabau@analog.com>
> > > 
> > > Add buffered capture support using the IIO triggered buffer framework.
> > >     
> > 
> > ...
> >   
> > > @@ -201,8 +245,45 @@ struct ad4691_state {
> > >  	 * atomicity of consecutive SPI operations.
> > >  	 */
> > >  	struct mutex lock;
> > > +	/*
> > > +	 * Per-buffer-enable lifetime resources:
> > > +	 * Manual Mode - a pre-built SPI message that clocks out N+1
> > > +	 *		 transfers in one go.
> > > +	 * CNV Burst Mode - a pre-built SPI message that clocks out 2*N
> > > +	 *		    transfers in one go.
> > > +	 */
> > > +	struct spi_message scan_msg;
> > > +	/* max 16 + 1 NOOP (manual) or 2*16 + 2 (CNV burst). */
> > > +	struct spi_transfer scan_xfers[34];
> > > +	/*
> > > +	 * CNV burst: 16 AVG_IN addresses + state-reset address + state-reset
> > > +	 * value = 18.  Manual: 16 channel cmds + 1 NOOP = 17.
> > > +	 */
> > > +	__be16 scan_tx[18];    
> > 
> > Needs __aligned(IIO_DMA_MINALIGN) since it is used with SPI.  
> As below.
> >   
> > > +	/* Scan buffer: one BE16 slot per channel (rx'd directly), plus timestamp */
> > > +	struct {
> > > +		__be16 vals[16];
> > > +		aligned_s64 ts;
> > > +	} scan;    
> > 
> > Unless it is required that all channels are always enabled:
> > 
> > 	IIO_DECLARE_BUFFER_WITH_TS(__be16, scan_rx, 16);
> > 
> > In any case, needs to be DMA-safe for SPI.  
> Custom regmap that uses spi_write_then_read() for all cases so it
> should be bounced anyway.
> 
> Perhaps a comment to that affect would be useful.
> 
Ignore that.  It's an optimized spi message. oops.

> J
> 

