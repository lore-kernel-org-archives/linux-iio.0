Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F313E377548;
	Fri, 23 Jan 2026 09:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769162066; cv=none; b=MbAze+gDOY34zmmcJrsoXfBzuAdB82zfeLDOawyh8H8OdS+UrV/RRlZrXrh4N7hlLSMCZMBdVzvSPBcd/qBtkbrE1xAUUzpdBFgMA07hnnyml2vIcam7zDkSeNNJY+GhX6UOE75lip3KxRFwozJrW6KPENlhGbn9HxW1ms7LNcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769162066; c=relaxed/simple;
	bh=hQ42YQXlRjBm2q+Rwa6DwFdNP/5P5yvUR1oHsaIIcd0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KUxmhve0cWFiUF5CpW7zanhX6ucDdfW7/IkqpUdeYFEVE2Ia6CWb3wfO6QSecjiBWDzQ7XXeUU7f4QRWg0oKi9KtWgvRgVJAnWHhTidn2unj61r7OBh35I8Fg/1ltwmx72NtM5jRj3KzCEGreqkb9x/YtorwdF/7Wjw2PQVMQPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQOdij/1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQOdij/1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5917BC19423;
	Fri, 23 Jan 2026 09:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769162065;
	bh=hQ42YQXlRjBm2q+Rwa6DwFdNP/5P5yvUR1oHsaIIcd0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IQOdij/1ibnZrfu+Njc/1bJ4GlfgPLXC8YOOqopZJqskTutNvL2xgdA3Y5BifZgVL
	 4VN01cXURdMmQ4eOowA7lP6cFIxQq5AH/ny/9q/zN6p+rM4D5uTctPvYeL/g4vV5+i
	 QGnGAydwaWyMgOeDGyoM6YfdxZ8FV0hZUJIh4Mm8KnSv+N0kc2H4yYH80zYnJddUDd
	 FM217ad2ZqQptllqEAK8DoJE1FHzn+7LZxi+rAcVpwDOYVj8yEqAaF8stmAEHdyPai
	 kHaY9qCTpC0G0pZ9CUB0vd0yAyDyR/htgRoUN2FjoKVmAbA9GWyER2UHcvcNNoLMeq
	 n7Hkau9M7ENbw==
Date: Fri, 23 Jan 2026 09:54:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Francesco Lavra <flavra@baylibre.com>, Ramona Gradinariu
 <ramona.gradinariu@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: accel: adxl380: Optimize reading of FIFO
 entries in interrupt handler
Message-ID: <20260123095417.31b11fd6@jic23-huawei>
In-Reply-To: <aXMtnCnTXq96efmH@smile.fi.intel.com>
References: <20260119102317.1565417-1-flavra@baylibre.com>
	<20260119102317.1565417-3-flavra@baylibre.com>
	<20260122195313.53fde73c@jic23-huawei>
	<aXMtnCnTXq96efmH@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Jan 2026 10:13:16 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Jan 22, 2026 at 07:53:13PM +0000, Jonathan Cameron wrote:
> > On Mon, 19 Jan 2026 11:23:17 +0100
> > Francesco Lavra <flavra@baylibre.com> wrote:
> >   
> > > In order to minimize the time required for transferring FIFO data from the
> > > sensor to the host machine, perform the read from the FIFO in a single call
> > > to regmap_bulk_read().  
> 
> > It's a call to regmap_noinc_read()  not regmap_bulk_read()
> > I'll fix it.  
> 
> This is interesting, does it mean the patch was never tested on the real HW?
> Or maybe noninc is intentional?
> 
It's absolutely intentional.  The device presents a single register address
that has the fifo behind it (which is what we added noinc for years ago).
So patch should definitely work.  Goes from reading that register N times in
each call within a loop of M to reading it N x M.

If regcache is in use this makes a difference as avoids corrupting registers
after this point as the address increment expected in the hardware for
a bulk read doesn't happen.  Without regcache it's just "documentation" as
at least for protocols used here its the same as a bulk read on the bus.

So patch is fine, it just mentioned the wrong call in the description
I'd guess this is because someone is working with a tree that has the wrong call in
it but might be wrong.

Jonathan


