Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1E830F803;
	Sun,  2 Aug 2026 18:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785696464; cv=none; b=fhb9CaLJV37y1Xp/mCJW42W32G9uLp64VzPyL8yDkW/6kK0hSotaljefIYiCTfWsXlWdCqN90anJT+1DA9CGHL6WMYYscVVzLr69adNcxn2+h/PyakzLP7ZzcEZseir++bqlhieNaW9htZwxSgfix+akY6AVthOFPDBe/M/899A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785696464; c=relaxed/simple;
	bh=hjg58UYGY/TkTDjz2jwIAmpKTZXxBbuIoeN85Dht244=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SmpPiBsiTKMYoedkKF85K3Y962ryUeZewcjH0bAA8OtegrIwAM4uq7ij4B+scd1JxD8712norfpANDYkmdYE0e4agC+/grjvasXW+3uT92xOSB4EJ9t8n6aBYI6xeDWrKtRQ+2dQwLsR9gdiEbfzQkgb0uklyJ5KbwmUCTzO6Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U8x7MVS7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U8x7MVS7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4FC61F000E9;
	Sun,  2 Aug 2026 18:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785696462;
	bh=TvgyDk2HC89KcYNBNEsGQw6P/bZVUyMqtjZ5ahgyVhw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=U8x7MVS7QhkhXAoKznwL0UdXqLHko9btcbfYC4r/eQtMQKpMbNrACCvLNCIJkzDw3
	 A5UffDXBSNaVGmEnnk1lsrTolIOv5E3XnTLTLBKWLC9NJ/OW4kwUGXR84fUvsXaIAz
	 klGXANjn1bIcdTVhqM2cU1sM9wCMDDroZpbfrk2L6/EUWINVEwIqox9WJ706FxfKjC
	 b7pPVtz+STSnvAta8ZftdcfW/rYLAMs67PFC688Abzsyjs4x+DQEbMyQMoAUtnKjUa
	 El+FGpRqoY8W3accSc+9sidGjqDdLji+YzqYA2ouc7qECvW5PwhM9K4zSMb2zopf6R
	 BbUjhWClVj+eg==
Date: Sun, 2 Aug 2026 19:47:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>,
 nuno.sa@analog.com, Michael.Hennerich@analog.com,
 gregkh@linuxfoundation.org, andy@kernel.org, linux@analog.com,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: ad7816: avoid DMA from stack in spi_read
Message-ID: <20260802194738.034382ef@jic23-huawei>
In-Reply-To: <0bde2343-8a70-44d4-9b27-8ce42c099309@baylibre.com>
References: <20260802113840.17730-1-abdelnasserhussein11@gmail.com>
	<0bde2343-8a70-44d4-9b27-8ce42c099309@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 2 Aug 2026 10:31:29 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 8/2/26 6:38 AM, Abdelnasser Hussein wrote:
> > The SPI core may use DMA for transfers. Using a stack-allocated
> > buffer for DMA is unsafe and can trigger faults when VMAP_STACK is
> > enabled, since the stack is not guaranteed to be DMA-accessible.
> > 
> > Move the transfer buffer from the stack into the ad7816_chip_info
> > structure so it has a stable lifetime suitable for DMA transfers.
> > Mark the buffer with ____cacheline_aligned to ensure proper alignment
> > for DMA operations.  
> 
> Should also mention fixing the "wrong" sizeof() use in the spi_read()
> call. It was the correct size, but the wrong variable was referenced.
> 
> >   
> 
> Probably deserves a Fixes: tag.
> 
> > Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
> > ---
> >  drivers/staging/iio/adc/ad7816.c | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
> > index 0e32a2295990..fcaadebff0f4 100644
> > --- a/drivers/staging/iio/adc/ad7816.c
> > +++ b/drivers/staging/iio/adc/ad7816.c
> > @@ -50,6 +50,7 @@ struct ad7816_chip_info {
> >  	u8  oti_data[AD7816_CS_MAX + 1];
> >  	u8  channel_id;	/* 0 always be temperature */
> >  	u8  mode;
> > +	__be16 rx_buf ____cacheline_aligned;  
> 
> In IIO, we have a special macro for this instead of `____cacheline_aligned`. 

We've had a couple of these recently.  ____cacheline_aligned is simply
wrong and I'm curious where that is coming from?  That's the performance
hint cache line size, typically that of l1 and l2. In some systems other
caches before the incoherent SPI controllers have larger cacheline sizes
and we have to align to those.

The correct option if not using the IIO one is __aligned(ARCH_DMA_MINALIGN)

For historical reasons IIO has it's own version of that which predates
all architectures providing ARCH_DMA_MINALIGN.

> 
> __aligned(IIO_DMA_MINALIGN);
> 
> >  };
> >  
> >  enum ad7816_type {
> > @@ -65,7 +66,6 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
> >  {
> >  	struct spi_device *spi_dev = chip->spi_dev;
> >  	int ret;
> > -	__be16 buf;
> >  
> >  	gpiod_set_value(chip->rdwr_pin, 1);
> >  	gpiod_set_value(chip->rdwr_pin, 0);
> > @@ -91,14 +91,12 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
> >  
> >  	gpiod_set_value(chip->rdwr_pin, 0);
> >  	gpiod_set_value(chip->rdwr_pin, 1);
> > -	ret = spi_read(spi_dev, &buf, sizeof(*data));
> > +	ret = spi_read(spi_dev, &chip->rx_buf, sizeof(chip->rx_buf));
> >  	if (ret < 0) {
> >  		dev_err(&spi_dev->dev, "SPI data read error\n");
> >  		return ret;
> >  	}
> > -
> > -	*data = be16_to_cpu(buf);
> > -
> > +	*data = be16_to_cpu(chip->rx_buf);
> >  	return ret;
> >  }
> >    
> 
> 

