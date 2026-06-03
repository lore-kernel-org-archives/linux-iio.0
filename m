Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851BD40910C
	for <linux-iio@vger.kernel.org>; Wed,  3 Jun 2026 12:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780489608; cv=none; b=klas9xmDcaZABx0n55fjTzsaKP160nLaEWPymr07EvJquunxx1d8DqdPrMfEDho8lUzRYiklQp6ltO6iY4E//c3F1wZtAaIyJLMx6HTZFl3eFFD3HBALEYG1ewo96hlDif+IVPtFQZWAQdk2TUi11ovpfHOC8oqj79kqR8HBiRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780489608; c=relaxed/simple;
	bh=3jIsHOEB2pBvR4m/btDNC659kkrYQVQgt5gTAuhCyB4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W6hSqVAv4CF5C2eGgoB8BfKqGXdhqye3gKGKeb3KXdecBBXm6EItmY5yqeDASuXEhKtswlY7ApdIB3AyGd2xIncJ0ecplVdqpq1boKJk+OSJIokD+wI9gu32jeDjn0bYbAWN0nPXn9ivUHFb2KHxeUowl8u2ulGFXm/nPwV2Th4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOf1qL4F; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOf1qL4F"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-68c19f1f3ceso8451515a12.2
        for <linux-iio@vger.kernel.org>; Wed, 03 Jun 2026 05:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780489606; x=1781094406; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s4aVZcTl8U1FLvESvygfBSaJHvnQyZU6dW/R+A9ZYVI=;
        b=AOf1qL4F14i/C+CIj8WK6zCxoJSA0DaWD7pTV+j0sYGso7YWdF0peZHioGyOEFdMDD
         z2X9bQzjaIpJcHvKHiddDzqye28tytsXsGw9Nq/pTgZ4EYmaAutHENR5/71+apibeg1x
         TLLRyd5A7PPqjocY/Uow2GxkwQXkeOa14v9zKAgYAYH+wvnC0lTJTFaCvGh1cGiFdD8C
         /in5lYM8aRX0YppJCYLQipNlua/eiGZbvZppoPqmF7iik34ZkEYVF63u4W9ki9w6RUGS
         /5VGK7Rvmk6rwkfQ3gOzJuUjBxcyLDCnayPwZzOni3FJE6LRIMorDB6bi9EH4ONYdMz/
         kljA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780489606; x=1781094406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s4aVZcTl8U1FLvESvygfBSaJHvnQyZU6dW/R+A9ZYVI=;
        b=IklPq7VBPxy9U7iVs6zxLgzuJS1ef2bhwOZO6mCdJ8PzFqi71OvqDochiN6HYeVHPM
         IJI4gcVMvB6yRpzzrihWG1BfwhYOSMqSpVbAq6/bMGSZWyAOanyifk06GFv2VJBk5yjd
         9A/uGdevxBApuuNZkBYqMSrMVB/dyXdukrbDkq1jqpbXJ57AbTT/qgOSce/e9WpGnbt+
         FqErDfa0I9USWFebQCr5CZSsdk/zxBDbfyPXnjFSRh37eWmfBjgHu8t8h9aJr0v0/XKZ
         jSwsutuhowrCK943E0bFzUjXJFQdAL/wJ9GBFmguAHAtD0AE7N6uorpPDOwwu8hl7pYE
         lElw==
X-Forwarded-Encrypted: i=1; AFNElJ8eit45z7XLggs29oOjK09I6gfeGBiBEhvOVSAkmL7fyqH3Q3T7j2osbMYSPyS5spPLnmrGldFA3oM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6OrWiCwlrS5AoLU89GOsrMIZBilxVSF4KA1KpovqHBXKfdjGh
	LNHq/1R92c8kupPekFDV7euvreeOZR86EZe7fKq3z4UDKAe2wbYFzIqc
X-Gm-Gg: Acq92OEOcA1zTyQ4/EdyQy4TjAxOBSGGUQjDxLnzPeke/5LncX1KkcG2JqEq2muusCb
	/iesyKnnAEOyDJRJgtqwM69bEMZDV6K8hVtKjQtQUTsC6ylw0JyCwL+ML9v4mGmMxoS35OEU1xO
	8bVhkBu390mId6WOm1+uH0r9ha+afv4nV1x1k9aKpxOlEu517beQwSMZnA/CVlfs2KGMWldMVuy
	uP6Yxf2TmAWZBZENwzKr3Ifn21CUhDnnhww6UFPG6q2e2MNdq0vRyTBBeZ5ir2mh17b0IAtqvPW
	PNK6yV4SPV6mDwuEuQRr9BIL8bNEj3/Slc6m99Sr1x2XesH30hY2lWDcD8Ce5C1bVdWUEobFiAV
	Qtwsy+Vpav1MthH7pgcA8959+5DN+STXCny2UQ+Z4Gvqgw0ZUNErZemwBJFtBuyyciIb7Xd+hvi
	vpSAjw7EFH9PWmKuogFRPxchdCVWsajs3D+G4HLonVZ+60yenGr4aMKHadVfFo8T5qGXXlIMaEg
	10x+rAV60Dd5U3RmOHFYVQJZVdjN9zT/clz7xwFUCSrLHTv1Q==
X-Received: by 2002:a17:907:1998:b0:beb:b53d:4839 with SMTP id a640c23a62f3a-bf0aea0a6femr173937066b.33.1780489605837;
        Wed, 03 Jun 2026 05:26:45 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf04e9e3847sm149542666b.0.2026.06.03.05.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 05:26:45 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Wed, 3 Jun 2026 13:26:43 +0100
To: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	rodrigo.alencar@analog.com
Cc: Michael Auchter <michael.auchter@ni.com>, linux@analog.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH 09/12] iio: dac: ad5686: implement new sync() op for the
 spi bus
Message-ID: <ylp2jf3wbojbwoozhow433vcvnz24ahvqlr35hhdoctm42rqqn@irrv3f76gr7k>
References: <20260602-ad5686-new-features-v1-0-691e01883d27@analog.com>
 <20260602-ad5686-new-features-v1-9-691e01883d27@analog.com>
 <ah8roqGqZ_VhAPaa@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah8roqGqZ_VhAPaa@ashevche-desk.local>

On 26/06/02 10:14PM, Andy Shevchenko wrote:
> On Tue, Jun 02, 2026 at 05:33:56PM +0100, Rodrigo Alencar via B4 Relay wrote:
> 
> > Use of local SPI bus data to manage a collection of SPI transfers and
> > flush them to the SPI platform driver with the sync() operation. This
> > allows for faster handling of multiple channel DAC writes, avoiding kernel
> > overhead per spi_sync() call, which will be helpful when enabling
> > triggered buffer support.
> 
> Why spi_message_alloc() can't be used instead of manual handling?
> (Seems no current users, so you even can modify it for your needs.)

I need to manually call spi_message_add_tail() to append messages.
I suppose that such function is a bit weird and no wonder why it
is not being used. struct spi_message_with_transfers might need
to be properly declared so that users can populate the transfer
array without manually moving pointers or having to redefine the type.
 
-- 
Kind regards,

Rodrigo Alencar
