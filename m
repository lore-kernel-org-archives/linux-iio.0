Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339243B995B;
	Sat, 17 Oct 2026 19:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792264419; cv=none; b=oPXmFK5NGgluwm9wS0I9YYzSjs8lYknZ3lKr+uWag/iDicARoN9oUBRoRnyZ/NzNYrp5veSNFhsUKj3MY5DQO7kwkjZLeydIsmS9BWnuKPGaDwTfu0UjfzhgZ3KsrfPE0NcFrXvqBBkuMs8/geFtAxV0OaXqSz3NJ3ykDXBNQ9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792264419; c=relaxed/simple;
	bh=ZWPwvp4yKc009tWAPvv+KysBtfFAvk1tlR+yG2D3R7M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YzWVR/J71rlIVzfsqVD5nQncVt3yyQR9e3WphGbjiMBbn6N93OR/Dzz68P8m+1G3/tzFvMzTpx6P2eRW4ysutEl9+TPUXH3egX/M+6xvGVBCGQkDy1ZoFr+vKUE47k43iRHI4SSmydDbzLR8ATp57xbSA36XD2uvXIPN8rQEnCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBP2OTAk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBP2OTAk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3278A1F000C4;
	Sat, 17 Oct 2026 19:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792264417;
	bh=ySB2z95OBV3amMWMDG5lzk6cX5XaLTz1FVqtPo+MV/s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lBP2OTAkUDm1vGNdPW6KZ4qB0dTxY9A8RQogBJzeAL88wjyRz5Zd7ZYneKTWzMXDJ
	 000KlHeWjyqrdecwzy2B4ytkD0j83LyIxFwB4PZ3RB+fEa64ZV2VfEqfVKR9zkcb3Q
	 DiRYaXagOFkjNxaQD1YAtun/+C224U0c5lOVJkQcjK8wdUHzqvFOJYmIQIjR2GI6hr
	 NpNX08TzNaXEX4v647ymJKEAPBaiXHF8C2sifjTMrgyZYOrNwbuvbS6LZQxVyc95uM
	 cOzb6fKhptzkDgro1Xb8JeQwSMgrh2mxggLoCjWp6cyMe5XFvmNF032f2o5pq5lLLx
	 pMnGQ4MoDiAbQ==
Date: Sat, 17 Oct 2026 20:13:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux@analog.com>, <nuno.sa@analog.com>,
 <dlechner@baylibre.com>, <andy@kernel.org>, <Michael.Hennerich@analog.com>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <corbet@lwn.net>, <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v5 03/15] iio: adc: ad4134: Apply reset recovery wait
 time
Message-ID: <20261017201331.5d835dc4@jic23-hlaptop>
In-Reply-To: <20261017075513.3a959a6a@systembl0wer>
References: <cover.1792200021.git.marcelo.schmitt@analog.com>
	<9f6d78d607b2f9a896513535fefa3329d52c4464.1792200021.git.marcelo.schmitt@analog.com>
	<20261017075513.3a959a6a@systembl0wer>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 17 Oct 2026 07:55:13 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Fri, 16 Oct 2026 22:57:08 -0300
> Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:
> 
> > Add a reset recovery wait time to avoid any SPI transfer from running too
> > soon during device probe.
> > 
> > Fixes: e0bc6d7e2584 ("iio: adc: Initial support for AD4134")
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > ---
> > New patch in v5.
> > 
> >  drivers/iio/adc/ad4134.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
> > index 40b27b01f126..d555874b4959 100644
> > --- a/drivers/iio/adc/ad4134.c
> > +++ b/drivers/iio/adc/ad4134.c
> > @@ -442,6 +442,7 @@ static int ad4134_probe(struct spi_device *spi)
> >  		return dev_err_probe(dev, PTR_ERR(rst),
> >  				     "failed to get and deassert reset\n");
> >  
> > +	fsleep(AD4134_RESET_TIME_US);

Sashiko calls out that this is currently 10 seconds, which seems unlikely!

> >  	crc8_populate_msb(ad4134_spi_crc_table, AD4134_SPI_CRC_POLYNOM);
> >  
> >  	st->regmap = devm_regmap_init(dev, NULL, st, &ad4134_regmap_config);  
> 
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> 

