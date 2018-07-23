Return-Path: <SRS0=z8mR=KH=novotny.cz=tomas@kernel.org>
Date: Mon, 23 Jul 2018 18:57:31 +0200
From: Tomas Novotny <tomas@novotny.cz>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter
 Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v2 2/4] iio: vcnl4000: add VCNL4010 device id
Message-ID: <20180723185731.4f4641ac@tomas.local.tbs-biometrics.cz>
In-Reply-To: <20180721180537.0c33fc19@archlinux>
References: <20180717164655.27142-1-tomas@novotny.cz>
	<20180717164655.27142-3-tomas@novotny.cz>
	<20180721180537.0c33fc19@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

On Sat, 21 Jul 2018 18:05:37 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue, 17 Jul 2018 18:46:53 +0200
> Tomas Novotny <tomas@novotny.cz> wrote:
> 
> > The driver already supports VCNL4010/20 devices. The supported features
> > and detectable product id are the same, so add shared id for them.
> > 
> > Signed-off-by: Tomas Novotny <tomas@novotny.cz>  
> 
> I'm not totally getting why we need this...  See below.
> 
> > ---
> >  drivers/iio/light/vcnl4000.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> > index 32c0b531395f..0688214fc152 100644
> > --- a/drivers/iio/light/vcnl4000.c
> > +++ b/drivers/iio/light/vcnl4000.c
> > @@ -48,6 +48,7 @@
> >  
> >  enum vcnl4000_device_ids {
> >  	VCNL4000,
> > +	VCNL4010,
> >  };
> >  
> >  struct vcnl4000_data {
> > @@ -68,6 +69,7 @@ struct vcnl4000_chip_spec {
> >  
> >  static const struct i2c_device_id vcnl4000_id[] = {
> >  	{ "vcnl4000", VCNL4000 },
> > +	{ "vcnl4010", VCNL4010 },  
> 	{ "vcnl4010", VCLN4000 }, then rest of the patch has no purpose
> 
> Also, should list the vcnl4020 id with the same enum entry to
> explicitly support that one.

ok, I will add it.

> It would have made sense if we had split the ID checking to
> verify we had the one we thought we had...  Not sure it really
> matters if they are identical in all visible ways, but at least
> it would have pointed out you didn't have what you thought you had.

As you pointed out in the next patch, I should explain the reason of this
patch here. I will do it in v3.

Thanks,

Tomas

> Jonathan
> 
> 
> >  	{ }
> >  };
> >  MODULE_DEVICE_TABLE(i2c, vcnl4000_id);
> > @@ -157,6 +159,12 @@ static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
> >  		.measure_light = vcnl4000_measure_light,
> >  		.measure_proximity = vcnl4000_measure_proximity,
> >  	},
> > +	[VCNL4010] = {
> > +		.prod = "VCNL4010/4020",
> > +		.init = vcnl4000_init,
> > +		.measure_light = vcnl4000_measure_light,
> > +		.measure_proximity = vcnl4000_measure_proximity,
> > +	},
> >  };
> >  
> >  static const struct iio_chan_spec vcnl4000_channels[] = {  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
