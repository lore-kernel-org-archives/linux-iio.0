Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC3226ED25;
	Fri, 22 May 2026 17:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779471094; cv=none; b=mEsp9qBVHPvg+TrGFL4R6GwQZ5psW7TtYf1FAnIfogh4kFtnNMKKULDd2FPhU6lfxsN28UwADguafj73yCaJRIjqVNLDyPy58DDUKUafKome1vU/mI5/jdrCZQ98YMxKW5FgtEhzwGkraqJKuVGJb1ean9DNXMLK0Zxzi1BFCNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779471094; c=relaxed/simple;
	bh=OmD2G3FJvsVokymyrjnhb6SR6iQPUVmSmUa9HI/1SNo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q1smvQrvSbKwYWhh3la7H5ZaeNmvcj5gXrN4+Z1+rvbBQh+tUklWV5ob9r1PVeLcqOSDpUwar3iqC/JBItlvx7Ia4dbx6a0QgpmENag3yge0kNshWg68JRDXV1hBOv0P0aBL+YkQGRqlRakF9Snp+J4yGW8gEFp+aDl2feCdklk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qzu5CwAY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qzu5CwAY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC1D1F000E9;
	Fri, 22 May 2026 17:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779471092;
	bh=EN2Tg9WWn1JKaggDfjPcWm+E4npboo7XezHRUdXnhDI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Qzu5CwAYUNm3FmfNlxhnMFRiIju1Dg0om09Cu0V7qiQhzgNxtSmA1gQZlWdLUApo3
	 Owdf4mWoXscZg/Vm6f7Ig+n3A9ZlfV7bQ/qJHMNqtmNe1GCBebCCNqJ5NQQ0ILW0+y
	 jM2wsreAMHC8jhVLtYUTMNb7ZUA/4IxEQicbKfhpmCrEXYCkHElfaDLUUKUHc435sR
	 7+3622bCy9x+cCEeeAD3+D5jA+KJzcLmkOi6htbFNgw+xBNunU3TgJmNwxCu95k8pF
	 aKneLQli/iom2cvC+EoUQgNlPipc28s/T6qO3u1Ekk3QyxaviIwwKZXfwDNiOYsdxI
	 fyPASGStYzDOg==
Date: Fri, 22 May 2026 18:31:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Stan, Liviu" <Liviu.Stan@analog.com>
Cc: David Lechner <dlechner@baylibre.com>, "Sa, Nuno" <Nuno.Sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, "Hennerich, Michael"
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>, Francesco Lavra
 <flavra@baylibre.com>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, linux <linux@analog.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 8/8] iio: temperature: ltc2983: Add support for
 ADT7604
Message-ID: <20260522183122.12191b61@jic23-huawei>
In-Reply-To: <LV9PR03MB8366C36D83A00FFCC166E333F60F2@LV9PR03MB8366.namprd03.prod.outlook.com>
References: <20260521164323.770626-1-liviu.stan@analog.com>
	<20260521164323.770626-9-liviu.stan@analog.com>
	<20260522143444.4582e370@jic23-huawei>
	<LV9PR03MB8366C36D83A00FFCC166E333F60F2@LV9PR03MB8366.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 May 2026 14:24:27 +0000
"Stan, Liviu" <Liviu.Stan@analog.com> wrote:

> On Fri, 22 May 2026 14:34:44 +0100 Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Thu, 21 May 2026 19:43:01 +0300
> > Liviu Stan <liviu.stan@analog.com> wrote:
> >   
> ...
> > 
> > The sashiko comment about the completion race looks real to me.
> > Can you take a look at that. Might be some odd reason why we can't
> > reinit_completion() before triggering the capture but that would
> > be very unusual.
> >   
> 
> I don't see any reason why we couldn't put it before the regmap_write,
> it has also already been done in ltc2983_eeprom_cmd(). So, I will change
> it in v4.
> 
> > Otherwise just two really small things I missed in earlier reviews.
> > If everything else was ready to go I'd have tweaked these whilst
> > applying but seems you'll be doing a v4 so over to you!  
> 
> Understood, will change them in v4!:) Thanks!
> 
> On Fri, 22 May 2026 09:09:33 -0500 David Lechner <dlechner@baylibre.com> wrote:
> 
> > On 5/22/26 8:23 AM, Liviu Stan wrote:  
> > > On Thu, 21 May 2026 19:18:28 +0000 sashiko-bot@kernel.org wrote:
> > >   
> > >> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:  
> ...
> > >> [Severity: High]
> > >> This is a pre-existing issue, but can this function experience spurious
> > >> read timeouts due to a race condition with the completion?
> > >>
> > >> Looking at the rest of this function:
> > >>
> > >>     ret = regmap_write(st->regmap, LTC2983_STATUS_REG, start_conversion);
> > >>     if (ret)
> > >>         return ret;
> > >>
> > >>     reinit_completion(&st->completion);
> > >>
> > >> If the hardware conversion finishes very quickly after regmap_write(),
> > >> could the interrupt fire and call complete() before the CPU executes
> > >> reinit_completion()? This would overwrite the completion event, causing the
> > >> subsequent wait_for_completion_timeout() to spuriously time out.
> > >>
> > >> Would it be safer to call reinit_completion() before initiating the hardware
> > >> action?  
> > > 
> > > This is theoretically valid but in practice, the conversion requires at minimum
> > > two 82ms cycles (167ms), so there is no realistic window for the interrupt to
> > > race with reinit_completion(). What do you guys think?  
> > 
> > I would still move it before the write so that it looks correct
> > and others can copy/paste the logic on other devices.  
> 
> That makes sense. Thanks!
> 
> Would this be considered a fix?
Yes, though not an urgent one given no particular reports of it being hit.
Just put it at the start of the series and I'll apply it with the rest.
Can get backported after next merge window.

Thanks,

Jonathan
> 
> Liviu

