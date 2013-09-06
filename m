Return-Path: <linux+jic23=cam.ac.uk@arm.linux.org.uk>
Date: Fri, 6 Sep 2013 09:39:21 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Fabio Estevam <festevam@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Marek Vasut <marex@denx.de>,
	devel@driverdev.osuosl.org,
	Fabio Estevam <fabio.estevam@freescale.com>,
	linux-iio@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <rob.herring@calxeda.com>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [patch] iio: mxs-lradc: use helper functions to simplify the
	code
Message-ID: <20130906083920.GO6617@n2100.arm.linux.org.uk>
References: <201309051216.18305.jbe@pengutronix.de> <20130905181639.GA19090@elgon.mountain> <CAOMZO5BmeG3X+cyNcwg0B7hsaqTY5hxjfNiWbxMivinhcZZp7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAOMZO5BmeG3X+cyNcwg0B7hsaqTY5hxjfNiWbxMivinhcZZp7g@mail.gmail.com>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Sep 05, 2013 at 05:15:02PM -0300, Fabio Estevam wrote:
> Looks good, just one minor suggestion:
> 
> On Thu, Sep 5, 2013 at 3:16 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > +static void lradc_reg_set(struct mxs_lradc *lradc, u32 val, size_t chan)
> > +{
> > +       writel(val, lradc->base + chan + STMP_OFFSET_REG_SET);
> > +}
> > +
> > +static void lradc_reg_clear(struct mxs_lradc *lradc, u32 val, size_t chan)
> > +{
> > +       writel(val, lradc->base + chan + STMP_OFFSET_REG_CLR);
> > +}
> 
> Maybe 'static inline' ?

GCC will already inline these if it thinks they're appropriate for that
treatment.
