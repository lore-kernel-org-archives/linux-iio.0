Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751679AbdFKOJE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Jun 2017 10:09:04 -0400
Date: Sun, 11 Jun 2017 15:08:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rick Altherr <raltherr@google.com>
Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: Aspeed ADC - Handle return value of
 clk_prepare_enable
Message-ID: <20170611150859.5072bc9a@kernel.org>
In-Reply-To: <CAPLgG=ntKrR=fvQKa=Z+CE0Ey3ELnGckfyWm4z_UpVN3h=dvcw@mail.gmail.com>
References: <4d7cbfdca6b7e89a312a08dad6c49b3289299bd8.1496041572.git.arvind.yadav.cs@gmail.com>
        <20170603095018.0d0f680b@kernel.org>
        <CAPLgG=ntKrR=fvQKa=Z+CE0Ey3ELnGckfyWm4z_UpVN3h=dvcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 5 Jun 2017 09:56:25 -0700
Rick Altherr <raltherr@google.com> wrote:

> Reviewed-by: Rick Altherr <raltherr@google.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> 
> On Sat, Jun 3, 2017 at 1:50 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Mon, 29 May 2017 13:12:12 +0530
> > Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:
> >  
> > > clk_prepare_enable() can fail here and we must check its return value.
> > >
> > > Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>  
> > Please make sure to cc the driver author.  This is a fairly new
> > driver, so chances are Rick will still be answering this email
> > address.
> >
> > Patch looks fine to me, but I would like to give Rick the opportunity
> > to respond.
> >
> > Jonathan  
> > > ---
> > >  drivers/iio/adc/aspeed_adc.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
> > > index 62670cb..e0ea411 100644
> > > --- a/drivers/iio/adc/aspeed_adc.c
> > > +++ b/drivers/iio/adc/aspeed_adc.c
> > > @@ -212,7 +212,10 @@ static int aspeed_adc_probe(struct platform_device  
> > *pdev)  
> > >       }
> > >
> > >       /* Start all channels in normal mode. */
> > > -     clk_prepare_enable(data->clk_scaler->clk);
> > > +     ret = clk_prepare_enable(data->clk_scaler->clk);
> > > +     if (ret)
> > > +             goto clk_enable_error;
> > > +
> > >       adc_engine_control_reg_val = GENMASK(31, 16) |
> > >               ASPEED_OPERATION_MODE_NORMAL | ASPEED_ENGINE_ENABLE;
> > >       writel(adc_engine_control_reg_val,
> > > @@ -236,6 +239,7 @@ static int aspeed_adc_probe(struct platform_device  
> > *pdev)  
> > >       writel(ASPEED_OPERATION_MODE_POWER_DOWN,
> > >               data->base + ASPEED_REG_ENGINE_CONTROL);
> > >       clk_disable_unprepare(data->clk_scaler->clk);
> > > +clk_enable_error:
> > >       clk_hw_unregister_divider(data->clk_scaler);
> > >
> > >  scaler_error:  
> >
> >  

