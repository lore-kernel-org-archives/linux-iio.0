Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F50E33F370;
	Fri, 27 Mar 2026 07:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774596727; cv=none; b=ZBTNR8jNvPc1TCUTGBTi2auMFTts7yOlVDdZj6HxXM2qWyMwR/QS7XRivgffzMpHzC38t7o4cHbsuaDhn7z/Sta/StZIUkpotUpy5rtr58aZnZ3cCEJcN4DVEixPMfUYQANQKMKcigtZC/HFJ/f1xfozIZ5fdE6C071eBHeNNoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774596727; c=relaxed/simple;
	bh=GeBT6djR/ClbrgoJCp3/fuDsfH9914bLOaKQxO/qaH0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c8cd+cquF0zQuDzvL2hr3887guRxwgplXlZi7dgaEeuiQ2OPpXuyuly7ubYaeOEnGh4kelsOeLRwml21nEmbB27r4pyZ3UMiKsEWf0kSegrrnV/QREsV8b1828XXOa/zMqS2RgsCnGWg5beluWBa93TJ+1Jrasrs/WQ4naTugXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rt4yttCi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rt4yttCi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01629C19423;
	Fri, 27 Mar 2026 07:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774596726;
	bh=GeBT6djR/ClbrgoJCp3/fuDsfH9914bLOaKQxO/qaH0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rt4yttCi3REQT3LvGj53cA/qUujkSL86hpxHOsdjf8uM6o9XCAEb0ICc0yKWLFdeb
	 2985c4A3PNzcTwCRascZSprQDHxm3NkKKJqyhAXoScY5HxTeMQ+zU6/BMUkUf80duy
	 K1tronAn/L9SzKKJ1e0Of/1qeTqT8c3oDlC3MX0WDYLQzNwPkYs4v3vWHy/FBcIAWV
	 oimqgmnGrpxC+P69yN2bzC2etlg/D3ZBslXTg9nW9UJ3IeERfDI7oR95hPsUWLu+MQ
	 cWh9Niw0bmKAxiiYHsFQZ5CR/nFLF/0AHmgV/uLcSbazqL/cTxV2Jg9kh4cUTQijhj
	 fvM68h0xTsKDA==
Date: Fri, 27 Mar 2026 07:31:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Ammar Mustafa <ammarmustafa34@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Alisa-Dariana Roman
 <alisa.roman@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Docs: iio: ad7191 Correct clock configuration
Message-ID: <20260327073156.522120fc@jic23-huawei>
In-Reply-To: <acWthfEL_HGtVykN@TARS>
References: <aaHrsTS9iG-PEfue@ammar-VM2>
	<aaLIhgJjrNlp3oTy@ashevche-desk.local>
	<20260322121314.0143bda3@jic23-huawei>
	<acWthfEL_HGtVykN@TARS>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Mar 2026 18:04:53 -0400
Ammar Mustafa <ammarmustafa34@gmail.com> wrote:

> On Sun, Mar 22, 2026 at 12:13:14PM +0000, Jonathan Cameron wrote:
> > On Sat, 28 Feb 2026 12:50:46 +0200
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> >   
> > > On Fri, Feb 27, 2026 at 02:08:33PM -0500, Ammar Mustafa wrote:  
> > > > Correct the ad7191 documentation to match the datasheet:
> > > > - Fix inverted CLKSEL pin logic: device uses external clock when pin is
> > > >   inactive, and internal CMOS/crystal when high.    
> > > 
> > > high --> active
> > > 
> > > Thanks, this part looks good in the below documentation update.
> > >   
> > > > - Correct CMOS-compatible clock pin from MCLK2 to MCLK1.    
> > > 
> > > I haven't checked driver yet, but is it only for a single component?
> > > Can you double check that _all_ supported by the driver have the same
> > > in their datasheet(s)?
> > > 
> > > ...  
> > 
> > Hi Ammar,
> > 
> > Just a quick note to say I'm going to mark this one in patchwork
> > as needing a new version given Andy's questions have been here a while.
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> > >   
> > > > +- When CLKSEL pin is ACTIVE: Uses internal 4.92MHz clock (no clock property
> > > >    needed)
> > > > -- When CLKSEL pin is tied HIGH: Requires external clock source
> > > > +- When CLKSEL pin is INACTIVE: Requires external clock source
> > > >    - Can be a crystal between MCLK1 and MCLK2 pins
> > > > -  - Or a CMOS-compatible clock driving MCLK2 pin
> > > > +  - Or a CMOS-compatible clock driving MCLK1 pin and MCLK2 left unconnected
> > > >    - Must specify the "clocks" property in device tree when using external clock    
> > >   
> >   
> 
> Hi Jonathon, 
> 
> I replied to Andy's questionm not sure if I can attach it in mutt for you,
> but we found that this driver only supports the AD7191 so no other 
> documentation needs to be updated or check for this issue. 
> Let me know if I need to do anything else to have this patch merged.
> 
Given it's docs, I'll a sneak it in (not so worried if this one gets
build time in linux-next).  Applied.

Thanks,

Jonathan

> Thank you,
> 
> Ammar Mustafa

