Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D78D32C937;
	Thu,  5 Feb 2026 20:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770324073; cv=none; b=MAnnnXhs9cjCJ8SfyvNmWsIRBGDL2vURH9Xz0mr1EBsQko3nGg1q8OTijCJtUR4te2ysTWChyVP08AB7q7vuF0NURFrWqNenTpwQPDJ5Ekh33V5cpPIuavauhWnygSj2IETRBnQOwaeqM7dAIObrVKoU2IYEPYanucVNYlClukg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770324073; c=relaxed/simple;
	bh=8wVmY5K+FtcMPjdF91QO7zDnPoy9UNfR01TexseUwwg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RreYUzTeRSRpA+KOUNLLYNz8+msDLVGtvW2flRKTmEQzMUih2h1VukssF9OGNYEysTyO4zWYiDuLpFKmqGuBc86Aq7R4lW3BoNr3VqGf674pYOtjUhYb3MWOFRRO4nkZqsGknn4VdQWToLY06Zg3fmsdR3nnr++ZIq3+ElAGo5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOxOpJ5h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOxOpJ5h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4777C4CEF7;
	Thu,  5 Feb 2026 20:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770324072;
	bh=8wVmY5K+FtcMPjdF91QO7zDnPoy9UNfR01TexseUwwg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eOxOpJ5hVKpWrdstZl6/3u55viRwNOlTK8XXTFgoi6w11gwfIi18vBFOzsaiHx8vI
	 YvQefTDpXfPqYtxBdCWfCpRr9T0JJzdg46VM0qF0hhU0Z/ZFK3xg98/Xx1FCctz+m+
	 rqVmL13PSw+vkMtqLtjgREkWmuQjNCDXT5b6umidNAlg0blSxMDbajL/mNzTY6khKN
	 lNDPpwCx84rCzkXM5al+F6+UYpwTsblM3UyLX0Rg2V7ciH3js6uAXI2dG+hSsUMd7d
	 Cs3f2KTuDQ2i0eyoaGtLKsPHTPiEmeDoxSFZVKxIMq5A8iqI1cF5WQGnZV0sTf4tqP
	 vlYDYVeYUkMLg==
Date: Thu, 5 Feb 2026 20:41:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 kernel@pengutronix.de, David Jander <david@protonic.nl>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH v4 01/13] iio: dac: ds4424: reject -128 RAW value
Message-ID: <20260205204101.5f84e150@jic23-huawei>
In-Reply-To: <aYHhm03Jsv0zsyZ0@smile.fi.intel.com>
References: <20260203093434.2548978-1-o.rempel@pengutronix.de>
	<20260203093434.2548978-2-o.rempel@pengutronix.de>
	<aYHF29ZR9mdi6Pqx@smile.fi.intel.com>
	<aYHN3YfKCgEnAfD5@pengutronix.de>
	<aYHhm03Jsv0zsyZ0@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Feb 2026 13:52:59 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Feb 03, 2026 at 11:28:45AM +0100, Oleksij Rempel wrote:
> > On Tue, Feb 03, 2026 at 11:54:35AM +0200, Andy Shevchenko wrote:  
> > > On Tue, Feb 03, 2026 at 10:34:21AM +0100, Oleksij Rempel wrote:  
> 
> ...
> 
> > > >  	case IIO_CHAN_INFO_RAW:
> > > > -		if (val < S8_MIN || val > S8_MAX)
> > > > +		if (val <= S8_MIN || val > S8_MAX)
> > > >  			return -EINVAL;  
> > > 
> > > I still consider using -127, 127 is better than type _MIN/_MAX.
> > > This is all due to '='.  
> > 
> > The use of S8_MIN here is intentional to satisfy the requirement for a minimal
> > stable backport, as requested by Jonathan:
> > https://lore.kernel.org/all/20260201144226.218a43cb@jic23-huawei/
> > 
> > This patch: Strict "Fix only" for stable. Uses minimal logic changes (<=
> > S8_MIN) to avoid introducing new bugs during backporting.
> > 
> > N++ patch: Full refactoring.
> > 
> > Can we accept this temporary state to facilitate the stable process?  
> 
> Ah, if it's request by the maintainer, I can't and won't overrule it.

FWIW I didn't really feel strongly about the -127 vs <= S8_MIN
was more after a trivial backportable fix.  

Meh, it's temporary state for upstream (if not stable). Let's not worry about it.

Thanks

Jonathan

> 

