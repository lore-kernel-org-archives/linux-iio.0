Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/4] iio: mxs: Implement support for touchscreen
Date: Tue, 11 Dec 2012 00:22:43 +0100
Cc: Jonathan Cameron <jic23@kernel.org>,
 linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Fabio Estevam <fabio.estevam@freescale.com>,
 Shawn Guo <shawn.guo@linaro.org>,
 "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
References: <1354893893-26338-1-git-send-email-marex@denx.de> <50C312D8.4050405@kernel.org> <20121210222437.GA19008@core.coreip.homeip.net>
In-Reply-To: <20121210222437.GA19008@core.coreip.homeip.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201212110022.44181.marex@denx.de>
List-ID: <linux-iio@vger.kernel.org>

Dear Dmitry Torokhov,

> Hi Marek, Jonathan,
> 
> On Sat, Dec 08, 2012 at 10:13:44AM +0000, Jonathan Cameron wrote:
> > On 12/07/2012 03:24 PM, Marek Vasut wrote:
> > > This patch implements support for sampling of a touchscreen into
> > > the MXS LRADC driver. The LRADC block allows configuring some of
> > > it's channels into special mode where they either output the drive
> > > voltage or sample it, allowing it to operate a 4-wire or 5-wire
> > > resistive touchscreen.
[...]

All of these are nice catches, thanks!

Best regards,
Marek Vasut
