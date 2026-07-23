Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172424908BB;
	Thu, 23 Jul 2026 23:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784847739; cv=none; b=av4wpCW/29mHgZuoD+10kkgKlB8KfivulfnAuSFzrgNjEAKoOeGDzQFPzP/u4b/LH19R6XCMjd/IKxMQqL7J027taYALzA+WM1qRjxSI8TG6OmAkOJfqtM88puCCevZYxKPLHB5qTil43Ut1JIMBzderBiOifpwIujSh3yN+NIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784847739; c=relaxed/simple;
	bh=nRF7+lQ36GB5xUC0+O913FCfHUvUIT4YIiWrtMx8jjw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nmPmOamM37Wzl2oHGky5bH+vI2TrQHTJ+vDsO5qhUmk+I1j95K7Q1dcD38OyevMQWXqvpgE46H7j85vJzKjMmWD8pjx9F5NZrjIEyXktQTMsKTT4FAS5F506KqbB4GvnxmdZexwDcgZ07nvG7YPxuT6Itvr6RuQY7qRpAvyPtfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/WC+S/L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/WC+S/L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B535E1F000E9;
	Thu, 23 Jul 2026 23:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784847738;
	bh=7UNqZ4A5NZ/sz3LYwH+ygbQXhe+aJgx7hitGbQj8Rz4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=h/WC+S/LvDz+scCgVsvtO5/mSBQF2MeVHHigum+eGlJc3lGXAGx7fXpbnBUHHJgmX
	 WGt+pdllFGvKcF64zqPuYQKhcP+fVqm+VMP/pQawx7FDN1sfffNBdNHMTTgye6e5j/
	 yls1q0mukcRbWwsMep7PLgJNjUNgie2xqYy2tdBZ4qt3M8Yu8YoqAVjccCDT7yFIqX
	 2y4V+MlxBXNQ5NO6Bt9FsgIe0AJp4d0ozOpw8pvvOcOGdnr/EX2Q6fSUxUmq3rOQN7
	 GgkbIuxrC7437cNL7tP2SXPo8gpvVTDLxUEYdvG0AEhYHcLZwDM2X6aOpHUA5qOg2Z
	 kBfjXraEkwjXg==
Date: Fri, 24 Jul 2026 00:02:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macromorgan@hotmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Chris Morgan
 <macroalpha82@gmail.com>, linux-iio@vger.kernel.org, andy@kernel.org,
 nuno.sa@analog.com, dlechner@baylibre.com, jean-baptiste.maneyrol@tdk.com,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 andriy.shevchenko@intel.com
Subject: Re: [PATCH v16 02/10] dt-bindings: iio: imu: icm42600: Remove
 interrupts from required
Message-ID: <20260724000212.775169c4@jic23-huawei>
In-Reply-To: <DS4PR19MB997335033645A4555221CC6006A5C32@DS4PR19MB997335.namprd19.prod.outlook.com>
References: <20260713215842.69097-1-macroalpha82@gmail.com>
	<20260713215842.69097-3-macroalpha82@gmail.com>
	<20260715-mottled-uncovered-mastodon-6c08be@quoll>
	<PH0PR19MB997338D80EB8ABB7C623850A23A5F82@PH0PR19MB997338.namprd19.prod.outlook.com>
	<82e3c736-f06f-484a-887c-9e156cb7cb44@kernel.org>
	<PH0PR19MB99733836951FBC9755A5361641A5F82@PH0PR19MB997338.namprd19.prod.outlook.com>
	<20260719001848.435886e0@jic23-huawei>
	<DS4PR19MB997335033645A4555221CC6006A5C32@DS4PR19MB997335.namprd19.prod.outlook.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Jul 2026 12:16:46 -0500
Chris Morgan <macromorgan@hotmail.com> wrote:

> On Sun, Jul 19, 2026 at 12:19:00AM +0100, Jonathan Cameron wrote:
> > On Wed, 15 Jul 2026 15:34:53 -0500
> > Chris Morgan <macromorgan@hotmail.com> wrote:
> >   
> > > On Wed, Jul 15, 2026 at 08:29:44PM +0200, Krzysztof Kozlowski wrote:  
> > > > On 15/07/2026 16:52, Chris Morgan wrote:    
> > > > > On Wed, Jul 15, 2026 at 07:52:52AM +0200, Krzysztof Kozlowski wrote:    
> > > > >> On Mon, Jul 13, 2026 at 04:58:32PM -0500, Chris Morgan wrote:    
> > > > >>> From: Chris Morgan <macromorgan@hotmail.com>
> > > > >>>
> > > > >>> Interrupts are almost never required for IIO devices per upstream
> > > > >>> maintainers. Remove interrupt as a required parameter for the
> > > > >>> devicetree binding.    
> > > > >>
> > > > >> That's an odd statement. We do require interrupts when the hardware
> > > > >> requires them. We do not require interrupts, not because we have such
> > > > >> policy, but because hardware does not require them.
> > > > >>
> > > > >> Plus, we do require interrupts when software implementing ABI requires
> > > > >> them.
> > > > >>
> > > > >> Above commit msg is simply inaccurate and misleading. Instead, please
> > > > >> use actual hardware arguments or how ABI is actually used. You must not
> > > > >> introduce changes to ABI just "because" while for example making that
> > > > >> ABI conflicting with existing implementation.    
> > > > > 
> > > > > I will defer then to Jonathan on the specifics of this, but from what I
> > > > > can tell:
> > > > > 
> > > > > 1) The icm42600 devices don't need an interrupt for operation other
> > > > > than for buffered mode or wake on movement. One-shot should work
> > > > > without it.
> > > > > 
> > > > > 2) The existing icm42600 driver does require an interrupt however, and
> > > > > refuses to bind without it. The driver could in theory be modified to
> > > > > not require an interrupt though and skip using buffered mode and WoM
> > > > > when no interrupt is present; however I don't plan on making these
> > > > > changes at this time.
> > > > > 
> > > > > 3) The new icm42607 driver I'm trying to upstream does not use an
> > > > > interrupt, because on my current test device it's not even wired up.
> > > > > On future devices that I have with this chip I may pursue using an
> > > > > interrupt, but it will never be required.
> > > > > 
> > > > > So should I go back to requiring the interrupt for all devices except
> > > > > for the new driver then?    
> > > > 
> > > > You mentioned two drivers, I don't know how does this relate to them. In
> > > > any case your commit msg is inaccurate and not a correct reason to make
> > > > a change.
> > > > 
> > > > Best regards,
> > > > Krzysztof    
> > > 
> > > I'm confused, so again should I just go back to the way things were?
> > > 
> > > This binding is to describe the hardware for devices using two distinct
> > > drivers, the inv_icm42600 and the new (that I am trying to finish)
> > > inv_icm42607 driver. The hardware requires an interrupt if you want to
> > > use features such as wake-on-motion or hardware buffers. The existing
> > > driver inv_icm42600 always assumes an interrupt is present and thus
> > > fails to probe if one is not (making it a "requirement"). The new
> > > driver I'm writing does not use the interrupt, because I don't have
> > > one.  
> > 
> > For dt-bindings, look at it from the question of 'is the hardware useful
> > without this interrupt?'  Answer is yes for vast majority of sensors as we
> > can either reduce features but still have some useful ones, or use another
> > approach such as polling a ready flag to replace doing it with an interrupt.
> > It is very common for boards to come out where none of the interrupts are
> > wired.
> > 
> > The only time I've seen that they are actually required for IIO stuff is
> > for very simple devices where the interrupt is the data - e.g. stand alone
> > threshold detectors with no ADC like functionality.
> > 
> > All this is independent of the driver working without the interrupt.
> > It is fully allowed to refuse to probe because it relies on something
> > optional in the DT-binding.
> > 
> > Jonathan
> >   
> 
> At this point (if it's okay with you) I'll just make sure the interrupt
> is not required for the new chips supported, as the distinction between
> whether the hardware needs it versus the driver is a bit lost on me;
> however for now the driver will fail on all the older chips if the
> interrupt isn't present.

Ok. We can leave relaxing the requirement for the older devices for now.

Jonathan

> 
> Thank you,
> Chris
> 
> >   
> > > 
> > > I'm thinking I'll just go back to the way it was previously, unless
> > > Jonathan disagrees. The interrupt will be listed as required for all
> > > devices using the inv_icm42600 driver, and not required for devices
> > > using the inv_icm42607 driver.
> > > 
> > > Thank you.
> > >   
> >   
> 

