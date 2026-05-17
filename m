Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20F435A393;
	Sun, 17 May 2026 11:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779018227; cv=none; b=ZpQcKofazmrmVVyKAIfickrhrGh0iJ/oGQMP7hvV+HIKtit8pdKCsnIVCM0TTDCP1yGbNdrjfrILIV68KJT4NMicCHHiGWg6676Vbfs5rVA+5lU3FKBgno//aJFHDMTK5IrAQckAPTAfRvFNSodGX2UpbgRcWjU5DAlmdbf7ukY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779018227; c=relaxed/simple;
	bh=S2hLW0ECNDf1VAnqrTJ4Mw0W1eh9WjufgWQJI7GfTws=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M42SqkxJGQ7YQCIWhPpoUzpcRBXTFRoJqMZ+UYe8fB7ewja0aOGfSRlU02v1oGqLw8QZ5aPDckdQvYvJn+DXzoZqkI/RJo7gv72eO8IN3tW7BW+uihtJ/LPFWDkrERMo4zmGIl57Fq7ZkdYsPneRRaUnxaIILuf0rV47AusP/oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fo7pCTs5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fo7pCTs5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EBCEC2BCB0;
	Sun, 17 May 2026 11:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779018226;
	bh=S2hLW0ECNDf1VAnqrTJ4Mw0W1eh9WjufgWQJI7GfTws=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fo7pCTs5v/OzRFKbx5k9YCj/rghUcBhldH+5CLLSwdZsLNoVl584fJVoCPPXI5U90
	 fw7YgLqxkcV9YolrACZb6plA1swzMCM7nC/gnktIikW1/jSSsFfRpVv9Bjb5ruIsXy
	 LnNIJVXTMTdlLZr81uPMpJSBh8f2gEeWf07Qkg/D9MGdVuCudTVQd18tjC/S99dMfj
	 ooSluCxCmFQtf+oBLjLfYa4vl/1/7N1xPq4vojDZ8hYeBSud2VPC2e/wzsQkIRvtrn
	 NJCUgziPa7K5+REs7TOAR+9jXJ0VCFsp5hb5KYKN/yIAjIy3pk4LnlGS7xHu/ShHpI
	 R0i09NBKSQn7A==
Date: Sun, 17 May 2026 12:43:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Greg Ungerer <gerg@linux-m68k.org>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Steven King <sfking@fdwdc.com>, Arnd Bergmann
 <arnd@arndb.de>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Greg Ungerer <gerg@uclinux.org>,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 03/11] m68k: mcf5441x: setup DAC clock name as per
 driver name
Message-ID: <20260517124336.242ffb6a@jic23-huawei>
In-Reply-To: <CALSJ-wAqFni+OwSUcQS+KESfe7SbWMxc0aCURHtTZ93Rx6GZhw@mail.gmail.com>
References: <CALSJ-wAqFni+OwSUcQS+KESfe7SbWMxc0aCURHtTZ93Rx6GZhw@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 May 2026 02:11:33 -0700
Angelo Dureghello <adureghello@baylibre.com> wrote:

> Hi Greg,
> 
> jfyi, for some reason i was not in to/cc, but i could grab the message
> in lore.
> 
> On Thu, May 14, 2026 at 10:54:32PM +1000, Greg Ungerer wrote:
> > Hi Angelo,
> >
> > On 14/5/26 17:05, Angelo Dureghello wrote:  
> > > Hi Greg,
> > >
> > > On 14.05.2026 11:27, Greg Ungerer wrote:  
> > > > Hi Angelo,
> > > >
> > > > On 13/5/26 19:14, Angelo Dureghello wrote:  
> > > > > From: Angelo Dureghello <adureghello@baylibre.com>
> > > > >
> > > > > Later in this patchset, the mcf54415 DAC driver is added.
> > > > > Considering some other different ColdFire cpu DACs exists, the DAC driver
> > > > > is named as "mcf54415_dac", related to the mcf5441x family SoCs with
> > > > > DACs (mcf54415/6/7/8).
> > > > >
> > > > > So updating DAC clock names to bind with proper driver name.  
> > > >
> > > > I am not sure I like naming the clocks here with a prefix for the
> > > > specific SoC part number this is in. It might be unlikely now, but
> > > > what if another ColdFire family SoC member uses this same hardware block?
> > > > That is very common amongst other hardware blocks within the ColdFire
> > > > family. Can we come up with a name more specific to just this type
> > > > of DAC hardware block?
> > > >  
> > >
> > > from a brief study, this 12bit DAC, and DAC module in general, is only on
> > > this mcf45441x family. There are some ColdFire with ADC only, as those
> > > mcf5249/53/82.
> > > The mcf51mm/ag/je are the opnly to have a 5bit dacs, but these are mcus.
> > > So, if i don't miss any existing model, the name may be correct,
> > > unless we want rename it to a more generic mcf_dac.  
> >
> > Yes, I would suggest just leaving it as is, "mcfdac".
> > That is not currently used by any other ColdFire variants supported by
> > the kernel.
> >  
> 
> Ok, will fix this in a v3, just asking confirmation on the name to
> Jonathan and all, since it involves iio too.
> 
> Chaches are:
> mcfdac
> mcf-dac  or mcf_dac (we have drivers as vf610_dac and cio-dac)

I'm a bit lost.  If we are talking about clocks that's fine as confusion is very
unlikely.  If we are talking driver naming - pick a part on which it exists and
name it after that.

Historically we made a few mistakes letting in very generic driver names
and it causes confusion when a non compatible part comes along.

If we know these have 'versions' of IP like the QC ones do, then we could name
them after generations but that is often not actually documented anywhere
so would need confirmation from Coldfire folk.

Jonathan

> 
> Regards,
> angelo
> 
> > Regards
> > Greg
> >
> >  
> 
> 
> 
> >  
> > > > Regards
> > > > Greg
> > > >
> > > >  
> > >
> > > Regards,
> > > angelo  
> > > >
> > > >  
> > > > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > > > > ---
> > > > >    arch/m68k/coldfire/m5441x.c | 8 ++++----
> > > > >    1 file changed, 4 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/arch/m68k/coldfire/m5441x.c b/arch/m68k/coldfire/m5441x.c
> > > > > index 5b5e09ecf487..b724d7fc1a08 100644
> > > > > --- a/arch/m68k/coldfire/m5441x.c
> > > > > +++ b/arch/m68k/coldfire/m5441x.c
> > > > > @@ -43,8 +43,8 @@ DEFINE_CLK(0, "mcfpit.2", 34, MCF_BUSCLK);
> > > > >    DEFINE_CLK(0, "mcfpit.3", 35, MCF_BUSCLK);
> > > > >    DEFINE_CLK(0, "mcfeport.0", 36, MCF_CLK);
> > > > >    DEFINE_CLK(0, "mcfadc.0", 37, MCF_CLK);
> > > > > -DEFINE_CLK(0, "mcfdac.0", 38, MCF_CLK);
> > > > > -DEFINE_CLK(0, "mcfdac.1", 39, MCF_CLK);
> > > > > +DEFINE_CLK(0, "mcf54415_dac.0", 38, MCF_CLK);
> > > > > +DEFINE_CLK(0, "mcf54415_dac.1", 39, MCF_CLK);
> > > > >    DEFINE_CLK(0, "mcfrtc.0", 42, MCF_CLK);
> > > > >    DEFINE_CLK(0, "mcfsim.0", 43, MCF_CLK);
> > > > >    DEFINE_CLK(0, "mcfusb-otg.0", 44, MCF_CLK);
> > > > > @@ -106,8 +106,8 @@ static struct clk_lookup m5411x_clk_lookup[] = {
> > > > >    	CLKDEV_INIT("mcfpit.3", NULL, &__clk_0_35),
> > > > >    	CLKDEV_INIT("mcfeport.0", NULL, &__clk_0_36),
> > > > >    	CLKDEV_INIT("mcfadc.0", NULL, &__clk_0_37),
> > > > > -	CLKDEV_INIT("mcfdac.0", NULL, &__clk_0_38),
> > > > > -	CLKDEV_INIT("mcfdac.1", NULL, &__clk_0_39),
> > > > > +	CLKDEV_INIT("mcf54415_dac.0", NULL, &__clk_0_38),
> > > > > +	CLKDEV_INIT("mcf54415_dac.1", NULL, &__clk_0_39),
> > > > >    	CLKDEV_INIT("mcfrtc.0", NULL, &__clk_0_42),
> > > > >    	CLKDEV_INIT("mcfsim.0", NULL, &__clk_0_43),
> > > > >    	CLKDEV_INIT("mcfusb-otg.0", NULL, &__clk_0_44),
> > > > >  
> > > >  
> >
> >  

