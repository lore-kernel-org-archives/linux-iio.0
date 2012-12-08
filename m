Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
To: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 3/4] iio: mxs: Implement support for touchscreen
Date: Sat, 8 Dec 2012 22:03:57 +0100
Cc: linux-iio@vger.kernel.org,
 Fabio Estevam <fabio.estevam@freescale.com>,
 Shawn Guo <shawn.guo@linaro.org>,
 Jonathan Cameron <jic23@kernel.org>,
 linux-arm-kernel@lists.infradead.org
References: <1354893893-26338-1-git-send-email-marex@denx.de> <1354893893-26338-3-git-send-email-marex@denx.de> <CAOMZO5B_Dx_+KRn6h+erCj+CY3zk06MXODX-Nm1tcpao9mL2zg@mail.gmail.com>
In-Reply-To: <CAOMZO5B_Dx_+KRn6h+erCj+CY3zk06MXODX-Nm1tcpao9mL2zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201212082203.57339.marex@denx.de>
List-ID: <linux-iio@vger.kernel.org>

Dear Fabio Estevam,

> On Fri, Dec 7, 2012 at 1:24 PM, Marek Vasut <marex@denx.de> wrote:
> > This patch implements support for sampling of a touchscreen into
> > the MXS LRADC driver. The LRADC block allows configuring some of
> > it's channels into special mode where they either output the drive
> > voltage or sample it, allowing it to operate a 4-wire or 5-wire
> > resistive touchscreen.
> > 
> > In case the touchscreen mode is enabled, the LRADC slot #7 is
> > reserved for touchscreen only, therefore it is not possible to
> > sample 8 LRADC channels at time, but only 7 channels.
> > 
> > The touchscreen controller is configured such that the PENDOWN event
> > disables touchscreen interrupts and triggers execution of worker
> > thread, which then polls the touchscreen controller for X, Y and
> > Pressure values. This reduces the overhead of interrupt-driven
> > operation. Upon the PENUP event, the worker thread re-enables the
> > PENDOWN detection interrupt and exits.
> > 
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > Cc: Fabio Estevam <fabio.estevam@freescale.com>
> > Cc: Jonathan Cameron <jic23@kernel.org>
> > Cc: Shawn Guo <shawn.guo@linaro.org>
> > ---
> > 
> >  .../bindings/staging/iio/adc/mxs-lradc.txt         |    6 +
> >  drivers/staging/iio/adc/mxs-lradc.c                |  435
> >  +++++++++++++++++++-
> 
> What about adding the touchscreen support into a separate file, so
> that users can select/deselect it via Kconfig option?

The touchscreen is way too intertwined with the LRADC, that's why I kept it in 
single file. Separating it away would only spawn third lradc.h header file with 
all the shared data etc.

I'll elaborate on it more in the other email.

> Not everyone using lradc would be necessarily interested in the
> touchscreen functionality, so better to let it optional.

You can actually disable it via device tree property (and it's disabled by 
default).

> Thanks,
> 
> Fabio Estevam

Best regards,
Marek Vasut
