Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0E23C07A;
	Sun, 23 Aug 2026 22:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787524698; cv=none; b=gWdnMWIL+STpUBNnY6ggbS7iP8jLFXa0/Ao1116kUlQYzlCU9+a1mBYAxQfixCZwEB0qJhsBqZwvLmoxrgWr7IAUfWomslLyNVg53P2CHjsqLYdpV201+NOZ2uKlS3HYtpk3HyvEJKnSpUH2ZsWwdhPnYG6SfpgUSR+eZImk3Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787524698; c=relaxed/simple;
	bh=4iJdtGeTKzSi1iaJSQndmR4ehd30j+BCXfR+WjC9SRk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UX3V8MMY4p1W9AlRcgirrAKSCL0gdq6NS2w4q9YhnW5XV9Z4FtzaWXypGpikRcebRxwL2XMoTnjsUz3xZiermH4ckQ+pjDgk5+4QBbJEkx1RN6xLgOoyYOK4p1fnmRT+fa6NioVnC1cENSJa0JNYzcRKvmYcagwlGcfu4fD0vqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VifTwhXI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VifTwhXI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E13821F000E9;
	Sun, 23 Aug 2026 22:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787524696;
	bh=H/zUHRp621DKo0XS5MQQU/rRKUCQe/DADgas00B/rRk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VifTwhXIR3n7Jci6mpVK8itOsIaiESbwCbO0nRNorpQeMsbVoGyu/xDHw1lv8dHpD
	 Nqznk32Jn8JGkrqMB+FBBIs4QwneUGSiCEzwc5qO4OXeR0T/JoOlviYS1VlG2u+PJH
	 r6R/PYghRVD4Q3CisbwHzXYXL3GSgkv4r6X0aO0gGpcQjEDQOFYuUs+Tsv2DWLPG3s
	 keRuiNibnN/dARtkDfnPXtMld16wzJdB0wJUNbghahqLxw89iiPKM8FRrmPted2G5u
	 DT3gKjhDtmZ5szfyASw68OVfEXrq2Pz0SGv6mUHwGFovDDMHYgDSvKU1u5ad6aD7oH
	 EpzBwpuh51MyQ==
Date: Sun, 23 Aug 2026 23:38:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, Matti Vaittinen
 <matti.vaittinen@linux.dev>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, Mehdi Djait
 <mehdi.djait.k@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kalle Niemi <kaleposti@gmail.com>, Topi
 =?UTF-8?B?U29ua2Fqw6Rydmk=?= <sonkajarvi@hotmail.com>
Subject: Re: [PATCH 07/12] iio: pressure: rohm-bm1390: Fix AVE_NUM
 initialization
Message-ID: <20260823233811.21757c87@jic23-huawei>
In-Reply-To: <339dbb07-1dc3-4cf6-8be2-ae8b84bde233@gmail.com>
References: <cover.1786347811.git.mazziesaccount@gmail.com>
	<7784e12793187a75dc10b0e84471f0cefe4d28b9.1786347811.git.mazziesaccount@gmail.com>
	<anovRGxtsyJZ8cO9@ashevche-desk.local>
	<247b0e35-f49e-4bec-abd4-4a2c3dd49a2d@gmail.com>
	<anr0jtvYorFKaEXY@ashevche-desk.local>
	<20260817021927.142ebca9@jic23-huawei>
	<339dbb07-1dc3-4cf6-8be2-ae8b84bde233@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Aug 2026 08:43:26 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 17/08/2026 04:19, Jonathan Cameron wrote:
> > On Tue, 11 Aug 2026 13:08:14 +0300
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> >   
> >> On Tue, Aug 11, 2026 at 12:05:47PM +0300, Matti Vaittinen wrote:  
> >>> On 10/08/2026 23:06, Andy Shevchenko wrote:  
> >>>> On Mon, Aug 10, 2026 at 10:53:07AM +0300, Matti Vaittinen wrote:  
> >>
> >> ...
> >>  
> >>>>> Use FIELD_PREP() to shift the intended AVE_NUM value to correct field.  
> >>>>
> >>>> Can it be FIELD_PREP_CONST()?  
> >>>
> >>> Can you please elaborate why it should in this case?  
> >>
> >> I'm not sure why it's not obvious, but the parameters are constants, why would
> >> we need an additional check or even checks?
> >>  
> > I'm not sure it is as obvious as the name would suggest.
> > FIELD_PREP() has a whole bunch of stuff that runs if it happens
> > to have a build time constant value +  FIELD_PREP_CONST() is
> > documented as primarily being there when the code requires a constant
> > to be correct.  
> 
> This is what I read. My first thought was that FIELD_PREP_CONST() is 
> useful when constant initializer is needed. So no, not obvious for me.
> 
Applied. It's in the testing branch, so I can rebase if this discussion
restarts, but it seems to have died out.

Jonathan

> Yours,
> 	-- Matti
> 

