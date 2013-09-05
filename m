Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
To: Fabio Estevam <festevam@gmail.com>
Subject: Re: [patch] iio: mxs-lradc: use helper functions to simplify the code
Date: Thu, 5 Sep 2013 22:29:54 +0200
Cc: Dan Carpenter <dan.carpenter@oracle.com>,
 Jonathan Cameron <jic23@cam.ac.uk>,
 =?iso-8859-1?q?J=FCrgen_Beisert?= <jbe@pengutronix.de>,
 devel@driverdev.osuosl.org,
 Fabio Estevam <fabio.estevam@freescale.com>,
 linux-iio@vger.kernel.org,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 Rob Herring <rob.herring@calxeda.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
References: <201309051216.18305.jbe@pengutronix.de> <20130905181639.GA19090@elgon.mountain> <CAOMZO5BmeG3X+cyNcwg0B7hsaqTY5hxjfNiWbxMivinhcZZp7g@mail.gmail.com>
In-Reply-To: <CAOMZO5BmeG3X+cyNcwg0B7hsaqTY5hxjfNiWbxMivinhcZZp7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201309052229.55139.marex@denx.de>
List-ID: <linux-iio@vger.kernel.org>

Dear Fabio Estevam,

> On Thu, Sep 5, 2013 at 3:16 PM, Dan Carpenter <dan.carpenter@oracle.com> 
wrote:
> > I have introduced lradc_reg_set() and lradc_reg_clear().  It simplifies
> > the callers and makes the lines shorter.
> 
> Looks good, just one minor suggestion:
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > 
> > diff --git a/drivers/staging/iio/adc/mxs-lradc.c
> > b/drivers/staging/iio/adc/mxs-lradc.c index a08c173..da5d04b 100644
> > --- a/drivers/staging/iio/adc/mxs-lradc.c
> > +++ b/drivers/staging/iio/adc/mxs-lradc.c
> > @@ -228,6 +228,16 @@ struct mxs_lradc {
> > 
> >  #define LRADC_RESOLUTION                       12
> >  #define LRADC_SINGLE_SAMPLE_MASK               ((1 << LRADC_RESOLUTION)
> >  - 1)
> > 
> > +static void lradc_reg_set(struct mxs_lradc *lradc, u32 val, size_t chan)
> > +{
> > +       writel(val, lradc->base + chan + STMP_OFFSET_REG_SET);
> > +}
> > +
> > +static void lradc_reg_clear(struct mxs_lradc *lradc, u32 val, size_t
> > chan) +{
> > +       writel(val, lradc->base + chan + STMP_OFFSET_REG_CLR);
> > +}
> 
> Maybe 'static inline' ?

static only, the inline is meaningless, GCC will handle that.

Best regards,
Marek Vasut
