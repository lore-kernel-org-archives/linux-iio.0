Return-Path: <SRS0=Z8nW=MA=gmail.com=decatf@kernel.org>
Date: Mon, 17 Sep 2018 21:57:33 -0400
From: r yang <decatf@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: light: bh1750: Add device tree support
Message-ID: <20180918015733.GA19976@r>
References: <c414a26cdc176d9982f3c609fa39cf245ac939be.1537033044.git.decatf@gmail.com>
 <387c145949692c0318f90d98426be95c82ea2e58.1537033044.git.decatf@gmail.com>
 <20180916104526.2c386591@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180916104526.2c386591@archlinux>
List-ID: <linux-iio@vger.kernel.org>

On Sun, Sep 16, 2018 at 10:45:26AM +0100, Jonathan Cameron wrote:
> On Sat, 15 Sep 2018 13:42:14 -0400
> ryang <decatf@gmail.com> wrote:
> 
> > Add device tree support for ROHM BH1750 series ambient light sensors.
> > 
> > Signed-off-by: ryang <decatf@gmail.com>
> Just to check, how is it picking up on the enum value which is provided
> in the i2c_device_id entries?
> 
> i.e. What is setting id->driver_data in the probe?
> There may be something in the i2c core that I'm missing that will do the
> association but I don't remember anything trying to do this.
> 
> Jonathan
>

I've looked through it and it is indeed in the i2c core.
The i2c core probe function picks the id entry based on the i2c client
name.

The i2c client name is assigned based on the device tree compatible
string.

  of_i2c_register_device()
    of_i2c_get_board_info()
      of_modalias_node()

During probe the i2c_device_id is picked by matching the i2c
client->name to i2c_device_id->name in the i2c_match_id() function.

  i2c_device_probe()
    driver->probe(client, i2c_match_id(driver->id_table, client));

I've tested this on device. It's Samsung Galaxy Tab 10.1. It has a
BH1721.

> > ---
> >  drivers/iio/light/bh1750.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/drivers/iio/light/bh1750.c b/drivers/iio/light/bh1750.c
> > index a814828e69f5..50b599abb383 100644
> > --- a/drivers/iio/light/bh1750.c
> > +++ b/drivers/iio/light/bh1750.c
> > @@ -315,9 +315,19 @@ static const struct i2c_device_id bh1750_id[] = {
> >  };
> >  MODULE_DEVICE_TABLE(i2c, bh1750_id);
> >  
> > +static const struct of_device_id bh1750_of_match[] = {
> > +	{ .compatible = "rohm,bh1710", },
> > +	{ .compatible = "rohm,bh1715", },
> > +	{ .compatible = "rohm,bh1721", },
> > +	{ .compatible = "rohm,bh1750", },
> > +	{ .compatible = "rohm,bh1751", },
> > +	{ }
> > +};
> > +
> >  static struct i2c_driver bh1750_driver = {
> >  	.driver = {
> >  		.name = "bh1750",
> > +		.of_match_table = of_match_ptr(bh1750_of_match),
> >  		.pm = BH1750_PM_OPS,
> >  	},
> >  	.probe = bh1750_probe,
> 
