Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
To: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 2/2] iio: mxs-lradc: Add MODULE_ALIAS
Date: Sun, 8 Sep 2013 18:11:49 +0200
Cc: Fabio Estevam <festevam@gmail.com>,
 Jonathan Cameron <jic23@cam.ac.uk>,
 linux-iio@vger.kernel.org,
 Fabio Estevam <fabio.estevam@freescale.com>
References: <1378169292-29899-1-git-send-email-festevam@gmail.com> <201309081700.17212.marex@denx.de> <1f25c7ea-016a-4501-a58c-f89813040185@email.android.com>
In-Reply-To: <1f25c7ea-016a-4501-a58c-f89813040185@email.android.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201309081811.49663.marex@denx.de>
List-ID: <linux-iio@vger.kernel.org>

Dear Jonathan Cameron,

> Marek Vasut <marex@denx.de> wrote:
> >Dear Fabio Estevam,
> >
> >> Hi Jonathan/Marek,
> >> 
> >> On Sun, Sep 8, 2013 at 11:31 AM, Jonathan Cameron <jic23@kernel.org>
> >
> >wrote:
> >> > On 09/03/13 01:59, Marek Vasut wrote:
> >> >> Dear Fabio Estevam,
> >> >> 
> >> >>> From: Fabio Estevam <fabio.estevam@freescale.com>
> >> >>> 
> >> >>> Add MODULE_ALIAS, so that auto module loading can work.
> >> >>> 
> >> >>> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> >> >> 
> >> >> Acked-by: Marek Vasut <marex@denx.de>
> >> > 
> >> > Applied to the togreg branch of iio.git
> >> > 
> >> > Anyone fancy getting this driver into a clean form and proposing
> >
> >taking
> >
> >> > it out of staging?
> >> 
> >> Does anyone know what still needs to be done in order to take it out
> >
> >of
> >
> >> staging?
> >
> >I think it should have been taken out of staging for a while now ;-)
> 
> Post a patch moving it with full code (turn off the move stuff in git
> format patch) and see what reviews you get.
> 
> Obviously best if someone who knows the driver does an initial pass for any
> cleanups code simplifications and stuff like missing docs.

Will it not be better to get Jurgens' patches in first ?

Best regards,
Marek Vasut
