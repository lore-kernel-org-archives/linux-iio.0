Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1312E0B5C;
	Thu, 10 Sep 2026 03:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789011571; cv=none; b=c0cmynAzwUxBd+Gc4iniBh86Fv+qIt5PS6YEtejSg5Zh0K4JYwHaLkGoUb5kJurY/GEhe2AQWAj5QYRAr0is+GcBp8yQWR6D9Lh/BRq/awntbGCq/wg7l87dscMjfHOrvGdjom+GoaBwAdFmxu/Mo3BkQ+FXM5b5JIbWqp36fS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789011571; c=relaxed/simple;
	bh=9sS+RkuZwYwrv45uL15O3zgqX6YVjzII9MZXgo5icfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kd2PUIyeqpHn5PlvIOgY2XOrVOZuThuE9z3UgM5BG7Tnk5C6ezmGNjBdOZi75Dnfx9undYnhNMKC+kTJBpekl0x5oYNZvy9B9GGcpSyRoUGWl3qwtKETNTAslPsKNnHS4rWULbAnFtBwvGduWi3wF5E4W/8zCq2R8ovaJ9DLGlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EltruIxa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EltruIxa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E6E1F000FF;
	Thu, 10 Sep 2026 03:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789011570;
	bh=OQXcNL2WuFOESavtcYnK6tzeI/Boy4mudQ7/iDdUyVc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EltruIxaB2U22wpbXGpSN9RJtc0SzVxrCRFQiepqqj6euwNUjKzOgIxBC/AAdszsu
	 WP3ojTBp1l0Ce4WrjoW/EFhBsm6K30KHZss/MorAp2gzOsiYqSPtaCzRT3eIoYuyDx
	 7tHOFi8YyENW9VSFrWine+DuXZVyGCH0ISKPvmwV/bII1gu+f4i3je+79OjHbIJMn9
	 rjaJwKyElV1RNIP8S8hwL6V46ciV1qxatmjBHFxwrFkexnXzamkPmuqA/QUSH/pXzW
	 ODh8XQgq6cMZeZ5u2ZVaqU1eBc1HfDENN7FtjN2lSpWZL2gwgw+v7QkCrE5zYJRDcx
	 IcZQY0/hVCRkg==
Date: Thu, 10 Sep 2026 04:39:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Kim Seer Paller <kimseer.paller@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux@analog.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 0/4] Add support for AD5710R/AD5711R DAC
Message-ID: <20260910043925.543138d7@jic23-hlaptop>
In-Reply-To: <ap497BPHehKLEJGT@ashevche-desk.local>
References: <20260904-iio-ad5710r-upstream-v5-0-76f985b7d0ee@analog.com>
	<20260906190559.7ca260f9@jic23-huawei>
	<ap497BPHehKLEJGT@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Sep 2026 07:30:36 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sun, Sep 06, 2026 at 07:05:59PM +0100, Jonathan Cameron wrote:
> > On Fri, 4 Sep 2026 16:35:23 +0800
> > Kim Seer Paller <kimseer.paller@analog.com> wrote:
> >   
> > > The AD5710R (16-bit) and AD5711R (12-bit) are 8-channel, low-power,
> > > configurable current/voltage output DACs with an on-chip 2.5V reference.
> > > Each channel can be independently configured as a voltage output
> > > (0V to VREF or 0V to 2xVREF) or a current output (0mA to 50mA).  
> > Series applied to the testing branch of iio.git.  If that all looks
> > good I'll push out in a few days as togreg and linux-next will pick it
> > up.  
> 
> So, still time to pick-up tags!
Yup and done so.

Thanks,

J
> 

