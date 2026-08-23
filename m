Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387D0493654;
	Sun, 23 Aug 2026 00:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787446267; cv=none; b=DqGYmHAnWVX9pDwandzdD7sGm5+iO7uDQbPejYE6ibNr8azkWdewufRIuH5UvB3IS9eEhnVXgHfP72F2Y0hcuu/UEeHgE6XYYvI32mFqD0z4eiuw68V5jlXs0cGy4juLlitJQrB36DfckknPeYwCvxPGM2AusMSUxWF15K6+KzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787446267; c=relaxed/simple;
	bh=+QlTFb8cMfc/OK5Z4qCUYQr5XCWnEkEPKqH8+KBsNpY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RKSDPY2X9KObCmkI2KmImFvfJSGn9k5cJkUYZK4iFbeRu0w1FjOWC69qB/YKL8e/oZwkD49aym0WuqtYzbKPdLcFMYmTa3mZ+igcF9C/tuzyRNtDnqR4qGObaHXpkOIa+g6OUGLXByDDataKJRxP12tJyysWVV1R3Csz89n14xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKWM+uH6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKWM+uH6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CADF1F000E9;
	Sun, 23 Aug 2026 00:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787446265;
	bh=va1x5CTVjllfWhBzZzKLjqK8OdH8fsdFKbjrDXWyuP0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NKWM+uH6OOJEOHO87p7rzj2x1GC+z3bYbd3a16Gcy4k6c1789W73s1BBErlYTsx2Y
	 FXR9qj87xCpnfSRbHELg3pSGRW0aVSiLJc6kc6ZLU7zBzZFbJowWyVp7yotOsLzw6u
	 mbJ0JEth3kkpj06MZ/6SvT4ob+gRIulWuoGbQ7vtm5YIN1S+aYr3Cj4JjrkPUMuLEO
	 U33kimAL/mrWt2i9qzCKtabE3pd6KeMX3Hn+I00MWwU9PDlw1mXEb+RMX8wdBn+yqU
	 0remvZmp1V383+5qg7/A3Yg2lj/TPVTiH8djfTbYpcit2jcj3ST2dUxMVsiPBzlP3q
	 Rbg5Hg2uOgYcQ==
Date: Sun, 23 Aug 2026 01:51:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Ariana Lazar <ariana.lazar@microchip.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/9] iio: dac: mcp47feb02: initialize dac_data field
 in channel data struct at probe
Message-ID: <20260823015100.74b6f615@jic23-huawei>
In-Reply-To: <aoW657jDvmMiOsaX@ashevche-desk.local>
References: <20260819-mcp47feb02_refactor-v4-0-beb2aa3bfd09@microchip.com>
	<20260819-mcp47feb02_refactor-v4-1-beb2aa3bfd09@microchip.com>
	<aoW657jDvmMiOsaX@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Aug 2026 17:17:11 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Aug 19, 2026 at 03:41:05PM +0300, Ariana Lazar wrote:
> > Read DAC value register to initialize corresponding field in channel_data
> > struct when the module is inserted.  
> 
> Since we have a cache enabled for regmap, can we rather read back initial HW
> values at the probe time for all non-volatile or precise registers?
> 

That should indeed be explored.  This is also missing any description of 'why'
this needs to be read and cached at all.

Jonathan
