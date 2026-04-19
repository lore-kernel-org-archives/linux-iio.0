Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D691D13D503;
	Sun, 19 Apr 2026 16:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776616925; cv=none; b=gJftfjjBem06nskx9EkLP/FeSWqBtKMuv4vr4yVG+xZP/bef9/SfJRmbWEuELpsuJpXxrqNneiqRFkULoyLWWS+Ejt1c201j1Blffb7bxYlG3ltuua2xVk5mKvoYXo5P/NPR75uA8oSPy7HpYkucSjCKBc9+fIq+Zr3u5hmM5x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776616925; c=relaxed/simple;
	bh=3vMDOsZ8iBfMgLnL1HSaOAfD6P/SZ/Z6a6f9MS0Ad9M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lDXKT/3TLUc+WbOr9+UWI4plhJgmN+oKbG8OKUQ8T9SEALf5AN/WV2jOuuNsTxoW419ele+r4mrV6LZIGr/4vYI0RWkcq8Mhn++tL3G8QMyqUhaNqJr0LOI089T5dixQZnTITycSPHdNHafJ1uKlqq319fqmaAPLRME+9hPR3Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uIM5ZK0C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uIM5ZK0C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3324FC2BCAF;
	Sun, 19 Apr 2026 16:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776616925;
	bh=3vMDOsZ8iBfMgLnL1HSaOAfD6P/SZ/Z6a6f9MS0Ad9M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uIM5ZK0CE/6WnubZRat37tGLAv9UGVQYfueyWdo0TKcWI6bzO0mN4f8q/9nlTyMmh
	 duMnrsMSwAN4ba1lxEYwiGaf+kZwCD/yEBG7elNDRmmZ8NQNSgS5PYrApSgori/1WM
	 Y5ZqAjYU/vXlHwr/cS06FYy+QdHovFTJmhY8jeCVqDKev0/gdMTmpWh841NZM4C0yj
	 97Z2x32f9F6w/Km7yTIwWDZ0Y8KQw5TAnVR7Bh4qWDpU3jFvbi74Vm9qhbDegw5q1X
	 qIz8/EL3L1NHDDaYO9a+KsF8KYM1Nxh80s77ujbLFz2Dzc+mnBKs39FhtAYLviketq
	 M102jv7WZ4Gjw==
Date: Sun, 19 Apr 2026 17:41:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>, Alexis Czezar Torreno
 <alexisczezar.torreno@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/2] iio: dac: ad5706r: Add support for AD5706R DAC
Message-ID: <20260419174155.312a8380@jic23-huawei>
In-Reply-To: <aeJ2clUsHk-VTr0F@ashevche-desk.local>
References: <20260417-dev_ad5706r-v8-0-ef87dff62b57@analog.com>
	<20260417-dev_ad5706r-v8-2-ef87dff62b57@analog.com>
	<aeHwwN2sFJBzQ21H@ashevche-desk.local>
	<20260417135624.000030e5@huawei.com>
	<aeJ2clUsHk-VTr0F@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Apr 2026 21:05:38 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Apr 17, 2026 at 01:56:24PM +0100, Jonathan Cameron wrote:
> > On Fri, 17 Apr 2026 11:35:12 +0300
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:  
> > > On Fri, Apr 17, 2026 at 04:27:16PM +0800, Alexis Czezar Torreno wrote:  
> 
> ...
> 
> > > > +#define AD5706R_DAC_RESOLUTION		16
> > > > +#define AD5706R_DAC_MAX_CODE		GENMASK(15, 0)    
> > > 
> > > I know Jonathan asked for this, hence it's comment for him.
> > > I think that BIT() notation in a form of (BIT(16) - 1) is
> > > also appropriate here as it gives the relationship to the
> > > resolution of the given register / bitfield in HW.
> > > 
> > > GENMASK() works for me, but it might require an additional
> > > operation to deduce the above.
> > > 
> > > (Note, there is no request to change or resend for you, Alexis. It's just
> > >  a remark to make Jonathan to think about which one suits better. He might
> > >  change that whilst applying.)
> > >  
> > I'm not against that form.  It was more being against bare BIT(16) as that was
> > 1 greater than the maximum value it can take.
> > However making the relationship explicit would be even better.
> > 
> > #define AD5705_DAC_MAX_CODE	(BIT(AD5706R_DAC_RESOLUTION) - 1)  
> 
> While that's technically correct, I would still prefer an explicit number

With the resolution stated on the line above I'd slightly prefer the explicit coupling
that is lost with the number being repeated.  Meh, I don't care that much.


> 
> #define AD5705_DAC_MAX_CODE	(BIT(16) - 1)
> 
> Note, GENMASK() is also fine with me, this is really a minor difference.
> 
> > I might tweak it when picking this up.  
> 

