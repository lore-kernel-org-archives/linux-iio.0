Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9006399007;
	Thu,  4 Jun 2026 10:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780570272; cv=none; b=ptBKqRRkBmAs4YL8Z5R4cCC8ckDAeL4fXr1asU/Mk06l3tS9IckCI1Ipvvu79QP3W0MBI2K+l7bH5m0WtMxQUZq9EH0qcbO4IUNUKAhnUD2lXmRMDtTwGBf+Jf6LHgkTqE0MF7bDzKtJDdNmVqronsQ/aWuYtrHCy6ibc2G3dj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780570272; c=relaxed/simple;
	bh=GXk2WEtjn3FO5bPGLU/Hj8uDiRzs71MYrfXgvaC3TP0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LKjfIq1mxib/4bDXSHTtUGj9OTLN5ZqTXrXfyWFKN+foLZExxfgQmIzTNGodCcvwOd6MOJCBD6gOkLHFHrR2B7LS23DMEEz6j4FHz6/O61pw+rMT6q8RcJrxeUfi74nXW8vm+SFh8wthiZE48xnuD2qtKSaxgO/1mqyf1rMk+dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABwfpP2u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABwfpP2u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AEE21F00898;
	Thu,  4 Jun 2026 10:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780570271;
	bh=lPwdtqx9lUhJp4HCy2BVvI91g5kufkxT2nG6q8XgWhE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ABwfpP2u/YuJ+iKvflm9+sfYGUkr6Zy/vhQ7Cmd4SsEf+up4aNKPylLDsy7fc7UUH
	 x3RZwHQuf6lcXl5h+je1gGcYkG6HHEJZv/Jnrrs2rWN42yZlAlQdnrOysri8wRCMJY
	 5vWcBzL5LR6DK25pyKOA6fRAGoTDzx8brFnI8ZmEko13zwy2VgQH60Fj2J7TEZLpH5
	 xa1AAUeUlhygKgU8L1NNoSIQ0JsQ2AGdLU6YZdtLraC+IpbAOvdjAhhxvGfoShXRTb
	 jSW8G3Algf4L9r29BTq4XUsiZ4w5LfuT3eKaeQOsx9/EmwZMTH0Si/IkY7Ja8D4Kwf
	 otJ4J+XfJ8xkQ==
Date: Thu, 4 Jun 2026 11:51:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: <Ariana.Lazar@microchip.com>
Cc: <linux-iio@vger.kernel.org>, <nuno.sa@analog.com>,
 <dlechner@baylibre.com>, <linux-kernel@vger.kernel.org>, <andy@kernel.org>
Subject: Re: [PATCH v2] iio: dac: mcp47feb02: refactor MCP47FEB02 I2C driver
 into two modules
Message-ID: <20260604115104.0949b545@jic23-huawei>
In-Reply-To: <09f59aacb059342e2698b370af4536d4e7a90938.camel@microchip.com>
References: <20260527-mcp47feb02-fix2-v2-1-3e8946d7b3c4@microchip.com>
	<20260528125140.16a8f173@jic23-huawei>
	<09f59aacb059342e2698b370af4536d4e7a90938.camel@microchip.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Jun 2026 14:52:41 +0000
<Ariana.Lazar@microchip.com> wrote:

> Hi Jonathan,
> 
> Thank you for the review.
> 
> 
> > I don't mind reviewing this on it's own but won't merge it until
> > we have a reason (i.e. that SPI part)
> >   
> 
> In the first version of this patch series the SPI file was included
> too, but it was recommended not to for better clarity:
> https://lore.kernel.org/all/20260419171658.2dbb9884@jic23-huawei/
> 
> My understanding was to submit a driver refactoring (splitting the
> driver into core and I2C modules) and submit later another patch to add
> the SPI part (the SPI module and modified dt binding). Please tell me
> if this is alright or I should do it differently.
> 

Ah. I didn't explain that clearly sorry.

Same series, different patches.  So this is the first patch and
should result in no funcational changes (looks good)
I've kind of lost track but there may be some precursor cleanup /
improvements to make in additional patches before that one splitting
core and I2C apart.

The patch after this then adds the new device support over the SPI
bus.

Jonathan


> 
> > 
> > 
> > All of these belong in separate patches from the fundamental code
> > move. Probably before it given they seem like a good idea anyway..
> >   
> 
> After mcp47feb02 I2C driver was accepted in upstream I've submitted a
> new patch series for mcp48feb02 SPI driver. Changes I did among the
> refactor were from the review for that driver:
> https://lore.kernel.org/all/aY3m5V05FOH5sut6@smile.fi.intel.com/
> 
> I will remove the reference mismatch part, which is a fix for
> mcp47feb02, and I will submit it in v3 for the series:
> https://lore.kernel.org/all/20260414-mcp47feb02-fix4-v1-1-9d71badfd25e@microchip.com/
> in order to add the fixes from later reviews (even if those patches
> will not be continued).
> 
> Best regards,
> Ariana

