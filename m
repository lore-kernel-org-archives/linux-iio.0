Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2D43B5841
	for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 10:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777284352; cv=none; b=Wxm4cmV+0Gq8MjbDctoaZQWk7OaczlaSETNjgfPsBfsMexRAA9tMxhWKG9P0rZFU11SxRuMkPEY5XhmzVXDT61J4H+y83MSEG4boVWTBLn3oGYxi0g/JiEwmK/tHE1shoK/59GyM1c4NZupFPQF1slYYPxyXcrkQRbSZ4FmO+wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777284352; c=relaxed/simple;
	bh=iN3RRfDRMGCCfBob1PEuXCevWsmAld3vlfxzFx505ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WVicMItFy6WmY4UTbIXavTXhPxx7KzKJZOTfOOiGUoVv/3kBFX1SYlterHSX20YOFq03xkc+1csMf22pjONCLAejvkxVFxSiRSfjM7W/eica1UMz7NF95SPQvnE2ftXX2Vk43AZ+w5+A3JPYxMDYU+myWSn4t+47bzWMWTpmFQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pJHgM31x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pJHgM31x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E57C2BCB4;
	Mon, 27 Apr 2026 10:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777284352;
	bh=iN3RRfDRMGCCfBob1PEuXCevWsmAld3vlfxzFx505ZA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pJHgM31xuoP6R8KfaT8wg7EUB42bfO1I6+x8uTP9GyF6tnua1kODX5VH0s42RUMhC
	 sVDD7A5M2Y4Pxc6BMrXeC0j3gpac3nGtbSmTk3Ny1Ui1nMCUzLYJs02hF2CJ6OJCl8
	 HzT+mFm3QZSOVNEZY9Awu3qng4hlZ6/Ahzq5Prq2Ej7R0/VgLOXVDi61VLzJJ1HSX3
	 dSnVumV16H/+oslJTsDU4lujHKmbhLcWJ/KD0W0aiOWTiAupFMXbuThgJy8++X1sxZ
	 lV45EEy4Jjhc9MyMTzwczk0shyuERypSahKWq9aAYtRmitp+1OvuxyyXSzTDmSFEQK
	 8BdT2lPLLPjJQ==
Date: Mon, 27 Apr 2026 11:05:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Caio Morais <caiomorais@usp.br>, andy@kernel.org, dlechner@baylibre.com,
 michal.simek@amd.com, nuno.sa@analog.com,
 linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: adc: xilinx-xadc: remove unnecessary includes
 and add missing ones
Message-ID: <20260427110542.1dd0b855@jic23-huawei>
In-Reply-To: <CALoEA-zz-2cG7SJr1iKNQ0H81TVMXLQh3omkxJc9YRW673Kqqw@mail.gmail.com>
References: <20260426211834.3318306-1-caiomorais@usp.br>
	<20260426211834.3318306-2-caiomorais@usp.br>
	<CALoEA-zz-2cG7SJr1iKNQ0H81TVMXLQh3omkxJc9YRW673Kqqw@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Apr 2026 08:42:55 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Sun, 26 Apr 2026 at 23:20, Caio Morais <caiomorais@usp.br> wrote:
> >
> > From: Caio Morais <caiomorais@usp.br>
> >
> > Signed-off-by: Caio Morais <caiomorais@usp.br>
> > ---  
> 
> You're missing the commit message body. While it's understandable
> what changes you've done in this patch, it's good to expand the idea
> further (what you did, how you did it, why you did it). This goes for all
> of the patches in your series.

Also, why only this file of the several that make up that driver?
Looks like kernel.h is included in xilinx-xadc-core.c as well.

I'd talk about kernel.h specifically in the patch description and
why stopping including that is seen as a nice to have.

> 
> > +#include <linux/bitmap.h>
> > +#include <linux/errno.h>
> > +#include <linux/mutex.h>
> > +#include <linux/types.h>
> > +
> >  #include <linux/iio/events.h>
> >  #include <linux/iio/iio.h>
> > -#include <linux/kernel.h>
> >
> >  #include "xilinx-xadc.h"
> >
> > --
> > 2.54.0
> >
> >  

