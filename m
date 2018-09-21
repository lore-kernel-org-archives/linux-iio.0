Return-Path: <SRS0=cyBi=MD=gmail.com=tduszyns@kernel.org>
Date: Fri, 21 Sep 2018 17:34:21 +0200
From: Tomasz Duszynski <tduszyns@gmail.com>
To: r yang <decatf@gmail.com>
Cc: Tomasz Duszynski <tduszyns@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: light: bh1750: Add device tree support
Message-ID: <20180921153420.GA11850@arch>
References: <c414a26cdc176d9982f3c609fa39cf245ac939be.1537033044.git.decatf@gmail.com>
 <387c145949692c0318f90d98426be95c82ea2e58.1537033044.git.decatf@gmail.com>
 <20180919192238.GA19391@arch>
 <20180921013721.GA4268@r>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180921013721.GA4268@r>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Sep 20, 2018 at 09:37:21PM -0400, r yang wrote:
> On Wed, Sep 19, 2018 at 09:22:39PM +0200, Tomasz Duszynski wrote:
> > Comments inline.
> >
> > On Sat, Sep 15, 2018 at 01:42:14PM -0400, ryang wrote:
> > > Add device tree support for ROHM BH1750 series ambient light sensors.
> > >
> > > Signed-off-by: ryang <decatf@gmail.com>
> > > ---
> > >  drivers/iio/light/bh1750.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/drivers/iio/light/bh1750.c b/drivers/iio/light/bh1750.c
> > > index a814828e69f5..50b599abb383 100644
> > > --- a/drivers/iio/light/bh1750.c
> > > +++ b/drivers/iio/light/bh1750.c
> > > @@ -315,9 +315,19 @@ static const struct i2c_device_id bh1750_id[] = {
> > >  };
> > >  MODULE_DEVICE_TABLE(i2c, bh1750_id);
> > >
> > > +static const struct of_device_id bh1750_of_match[] = {
> > > +	{ .compatible = "rohm,bh1710", },
> > > +	{ .compatible = "rohm,bh1715", },
> > > +	{ .compatible = "rohm,bh1721", },
> > > +	{ .compatible = "rohm,bh1750", },
> > > +	{ .compatible = "rohm,bh1751", },
> > > +	{ }
> > > +};
> > > +
> >
> > Hmm, I believe this should be exported additionally using
> > MODULE_DEVICE_TABLE(of, bh1750_of_match). Otherwise module loading
> > will not work as expected.
> >
> > Moreover, we can do without DT and if you want to avoid
> > warning about unused variables you may consider enclosing everything
> > with:
> >
> > #ifdef CONFIG_OF
> > ...
> > #endif
>
> The reason for this DT patch is because I've ported the Samsung Galaxy
> Tab 10.1 to the mainline kernel. The device is working on the Tegra
> platform with the right DTS file. Some peripherals on this device have
> existing drivers such as this one which only need the DT bindings for
> it be usuable.
>

Adding support for DT is fine. Just pointed a figner at two things
that attracted my attention.

> >
> > >  static struct i2c_driver bh1750_driver = {
> > >  	.driver = {
> > >  		.name = "bh1750",
> > > +		.of_match_table = of_match_ptr(bh1750_of_match),
> > >  		.pm = BH1750_PM_OPS,
> >
> > I've recently simplified setting pm ops so this would not apply to
> > iio/togreg cleanly.
> >
>
> Does this mean I should wait until that is merged before submitting a V2
> patch?
>

No need to wait. I guess you should rebase your work on iio/togreg
branch and post v2.

> > >  	},
> > >  	.probe = bh1750_probe,
> > > --
> > > 2.17.1
> > >
