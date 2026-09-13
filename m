Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A45233944;
	Sun, 13 Sep 2026 21:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789336512; cv=none; b=a64sljzinltU9VgfEmruz2Quoo5LaqdGRlFH2nLItM+o4dA4irgGVQRva6EFPxIlSrwvtE/Hy++ch4v8R+0u8a3K3OKDrxNYKcmS25qpE4Xv3VWLppZJd9PSJqkeJ9/1Fluc+lDJu3BqJm/8MPUekUkbbF+6rZR/kYIJGu49qAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789336512; c=relaxed/simple;
	bh=pLl1kec3onHIbnh7ZtqFoTAOK1Um/hnl20GtO+HqrAE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oK6UyUYVKiSmZy1FGbuMiGXcd4/2Ilx2ZsJY9I6mFdo8KqJ6IdiVII9kCcFklBES4KKB+wDDQQxgYhUt/6su7ncc+AzEf1tF+EXlk/HkaKUTUWdO9UY2ZDLEkrqM6Xvr4HByTDuunCQIk+zwnlgDegXROxKh/T4KH06yogx8KHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDkJXL65; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDkJXL65"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B16EB1F000FF;
	Sun, 13 Sep 2026 21:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789336510;
	bh=8x/1v1xwdnvrmJ+Fo6pE6519lTYSCW3AsKMs/o05oT0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fDkJXL65dgUS6GAJ0ESW14sOvRFqZt2yC/3vCLe9m3nEcSgX9dSaIgkze/pLaIdym
	 SPmGkIlmKC+ATXDIGTnz5GmJSZ+lt0vTtoIP+KDzpTOEO2yEJq3IGGCN4vZqNiORJa
	 esQNK7B5I0VPMJ0dogUg1wFBHHGrfOxVB+A57RWUc6UPqR6KF5Qmrtj2BqED41TRQa
	 H5kO1njVN7XrhyKJ3hawr2CcrLaKCBq0Gwayh08NJMBOJgaPC8XaqkZImTa0QPmXJ+
	 sCvLga9+SaPBITNOH0NzNIdWzsOJeginYCtGslmgRsaLT0Muk/tv97OkWTffN3I9BU
	 8ROpITGm7d0hw==
Date: Sun, 13 Sep 2026 22:55:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Ariana Lazar <ariana.lazar@microchip.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v5 00/10] Refactor Microchip MCP47FEB02 I2C driver in
 separate modules to add support for MCP48FEB02 SPI driver
Message-ID: <20260913225509.667cdd39@jic23-hlaptop>
In-Reply-To: <aqJLvet2-6YUDYDF@ashevche-desk.local>
References: <20260909-mcp47feb02_refactor-v5-0-8b67bcab93d1@microchip.com>
	<aqJLvet2-6YUDYDF@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Sep 2026 09:18:37 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Sep 09, 2026 at 05:18:43PM +0300, Ariana Lazar wrote:
> > Refactor I2C driver implementation into separate modules in order to add
> > support for SPI MCP48FxBy1/2/4/8 DAC family on top of the I2C implementation.
> > The I2C and SPI devices have the same memory map and supported
> > functionalities.  
> 
> > ---
> > Changes in v5:
> > - improve commit messages by justifying the changes made
> > - increase polling time for EEPROM writes
> > - delete unnecessary comments and extra blank line from header file
> > - Link to v4: https://lore.kernel.org/r/20260819-mcp47feb02_refactor-v4-0-beb2aa3bfd09@microchip.com  
> 
> I have a felling that the first few patches are actual fixes and they lack of
> Fixes tag (and possible Cc to stable@).
> 

Excellent point.  I nearly picked up the series (tweaking for
stuff Andy raised) but I would like those Fixes tags so Ariana, please send
a v6 with them an everything tidied up.  Rebase on 7.3-rc1 as well
please. The based-on tag in here is something I don't even have.

Thanks,

Jonathan
