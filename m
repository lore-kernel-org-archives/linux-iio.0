Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
To: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH] iio: mxs-lradc: Fix misuse of iio->trig
Date: Wed, 3 Jul 2013 23:47:55 +0200
Cc: linux-iio@vger.kernel.org,
 otavio@ossystems.com.br,
 Fabio Estevam <fabio.estevam@freescale.com>,
 Shawn Guo <shawn.guo@linaro.org>
References: <1372540813-12540-1-git-send-email-marex@denx.de> <51D48096.5000206@kernel.org>
In-Reply-To: <51D48096.5000206@kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201307032347.55808.marex@denx.de>
List-ID: <linux-iio@vger.kernel.org>

Hello Jonathan,

> On 06/29/2013 10:20 PM, Marek Vasut wrote:
> > The struct iio_dev .trig field is to be used only by the IIO core,
> > the driver shall not fill this field. This fixes ugly crash when
> > the driver is compiled as a module and the module is rmmod'd.
> > 
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > Cc: Fabio Estevam <fabio.estevam@freescale.com>
> > Cc: Jonathan Cameron <jic23@kernel.org>
> > Cc: Shawn Guo <shawn.guo@linaro.org>
> 
> I've applied this to the fixes-togreg branch of iio.git but had a bit
> of fuzz, could you just santiy check that nothing went wrong please.
> 
> https://git.kernel.org/cgit/linux/kernel/git/jic23/iio.git/log/?h=fixes-tog
> reg
> 
> Thanks

All OK, it must be my -next tree, sorry for the trouble.

Best regards,
Marek Vasut
