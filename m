Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from hosting.pavoucek.net ([46.28.107.168]:52803 "EHLO
        hosting.pavoucek.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965158AbeBMSNF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Feb 2018 13:13:05 -0500
Date: Tue, 13 Feb 2018 19:13:02 +0100
From: Tomas Novotny <tomas@novotny.cz>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/2] iio: vcnl4000: add support for VCNL4200
Message-ID: <20180213191302.0657f6d4@tomas.local.tbs-biometrics.cz>
In-Reply-To: <20180210151611.30c0934b@archlinux>
References: <20180205180424.30725-1-tomas@novotny.cz>
        <20180205180424.30725-3-tomas@novotny.cz>
        <alpine.DEB.2.21.1802052009180.23705@vps.pmeerw.net>
        <20180206144647.55a0de95@tomas.local.tbs-biometrics.cz>
        <20180210151611.30c0934b@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan,

On Sat, 10 Feb 2018 15:16:11 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue, 6 Feb 2018 14:46:47 +0100
> Tomas Novotny <tomas@novotny.cz> wrote:
> 
> > Hi Peter,
> > 
> > On Mon, 5 Feb 2018 20:55:30 +0100 (CET)
> > Peter Meerwald-Stadler <pmeerw@pmeerw.net> wrote:
> >   
> > > On Mon, 5 Feb 2018, Tomas Novotny wrote:
> > >     
> > > > VCNL4200 is an integrated long distance (up to 1500mm) proximity and
> > > > ambient light sensor.
> > > > 
> > > > The support is very basic. There is no configuration of proximity and
> > > > ambient light sensing yet. Only the reading of both measured values is
> > > > done.      
> > > 
> > > I think the main issue is the lack of a data ready flag; most drivers 
> > > return new samples (and wait for a new sample if necessary) -- the 
> > > VCNL4200 hardware does not seem to support that directly    
> > 
> > There are only integration times defined in the datasheet.
> >   
> > > one way would be to use a timer and wait the integration time if 
> > > necessary, not sure if this mandatory for IIO -- having both semantics in     
> > 
> > me neither... Would be enough just to export the integration time via channel
> > info?  
> 
> This is not an unheard of situation unfortunately. Right now I'm
> struggling to remember when we last hit this but has definitely come up before.
> 
> So I 'think' we are putting the sensor in a free running mode here
> and the issue Peter raises is that we can't tell if we have
> 'fresh' data or not.
> 
> For that you can take the approach taken in various sensors which
> are on demand triggered - but with a restriction in the minimum time between
> readings - this is common in humidity and gas sensors IIRC.
> 
> So what you do is record the time of a particular reading and then
> check if the new reading is 'too' close to the previous time.  If it is
> you sleep a bit.  This is only ever approximate though as with clock
> drifts you will eventually either miss a reading or get get a repeat
> (just not the vast majority of the time).
> Supporting both forms in driver is fine - semantically from a userspace
> point of view it won't be able to tell the difference.

Ok, I will sleep a bit in case of a too quick consumer.
 
> Exporting integration time (and being able to control it) is good
> but doesn't prevent userspace from ignoring it and getting invalid
> data.
>
> Looks like for the proximity we can run it in an ondemand mode
> but not the ALS..

Yes, right.

> Strange question though - what is the mysterious 'white' channel?
> (in the datasheet)

I cannot find more information. So I did a totally unprofessional measurement
with my cheap multicolour LED lamp. ALS and white channels (unscaled) are
compared on a few colours on three levels of intensity.

The results are:
- ALS and white channel "somehow" correlates
- I wasn't able to saturate white ch.; it is easy to saturate ALS
- ALS is smooth, white is noisy (depending on the colour)

Here are the numbers if you are curious:
Columns: colour, white, ALS

Low intensity:
white   3810    31994

red     1981     6483
orange  2747    17635
yellow  3216    34003
green   1613    48201
cyan    3495    45924
blue    2157    27083
magenta 3401    31453

Medium intesity:
white   9756    65535

red     6192    19647
orange  8097    49621
yellow  9589    65535
green   4966    65535
cyan    9104    65535
blue    5946    65535
magenta 8919    65535

High intensity:
white   14445   65535

red      9285   30276
orange  12623   65535
yellow  15026   65535
green    7166   65535
cyan    15265   65535
blue     9705   65535
magenta 14110   65535

And:
dark       1        3

I will send v2.

Thanks,

Tomas

> > > one driver may be confusing
> > >
> > > some more suggestions below
> > > 
> > > regards, p.
> > >     
> > > > Signed-off-by: Tomas Novotny <tomas@novotny.cz>
> > > > ---
> > > >  drivers/iio/light/Kconfig    |  5 +--
> > > >  drivers/iio/light/vcnl4000.c | 72 ++++++++++++++++++++++++++++++++++++++++++--
> > > >  2 files changed, 72 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> > > > index 2356ed9285df..cab222fa8d18 100644
> > > > --- a/drivers/iio/light/Kconfig
> > > > +++ b/drivers/iio/light/Kconfig
> > > > @@ -396,11 +396,12 @@ config US5182D
> > > >  	 will be called us5182d.
> > > >  
> > > >  config VCNL4000
> > > > -	tristate "VCNL4000/4010/4020 combined ALS and proximity sensor"
> > > > +	tristate "VCNL4000/4010/4020/4200 combined ALS and proximity sensor"
> > > >  	depends on I2C
> > > >  	help
> > > >  	 Say Y here if you want to build a driver for the Vishay VCNL4000,
> > > > -	 VCNL4010, VCNL4020 combined ambient light and proximity sensor.
> > > > +	 VCNL4010, VCNL4020, VCNL4200 combined ambient light and proximity
> > > > +	 sensor.
> > > >  
> > > >  	 To compile this driver as a module, choose M here: the
> > > >  	 module will be called vcnl4000.
> > > > diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> > > > index d7e43fd9333e..41f5fad50f63 100644
> > > > --- a/drivers/iio/light/vcnl4000.c
> > > > +++ b/drivers/iio/light/vcnl4000.c
> > > > @@ -1,5 +1,5 @@
> > > >  /*
> > > > - * vcnl4000.c - Support for Vishay VCNL4000/4010/4020 combined ambient
> > > > + * vcnl4000.c - Support for Vishay VCNL4000/4010/4020/4200 combined ambient
> > > >   * light and proximity sensor
> > > >   *
> > > >   * Copyright 2012 Peter Meerwald <pmeerw@pmeerw.net>
> > > > @@ -8,13 +8,15 @@
> > > >   * the GNU General Public License.  See the file COPYING in the main
> > > >   * directory of this archive for more details.
> > > >   *
> > > > - * IIO driver for VCNL4000 (7-bit I2C slave address 0x13)
> > > > + * IIO driver for:
> > > > + *   VCNL4000/10/20 (7-bit I2C slave address 0x13)
> > > > + *   VCNL4200 (7-bit I2C slave address 0x51)
> > > >   *
> > > >   * TODO:
> > > >   *   allow to adjust IR current
> > > >   *   proximity threshold and event handling
> > > >   *   periodic ALS/proximity measurement (VCNL4010/20)
> > > > - *   interrupts (VCNL4010/20)
> > > > + *   interrupts (VCNL4010/20/200)      
> > > 
> > > not sure if this notations is very clear; maybe better
> > > * interrupts (VCNL4010/20, VCNL4200)    
> > 
> > ok.
> >   
> > > >   */
> > > >  
> > > >  #include <linux/module.h>
> > > > @@ -28,6 +30,7 @@
> > > >  #define VCNL4000_DRV_NAME "vcnl4000"
> > > >  #define VCNL4000_PROD_ID	0x01
> > > >  #define VCNL4010_PROD_ID	0x02 /* for VCNL4020, VCNL4010 */
> > > > +#define VCNL4200_PROD_ID	0x58
> > > >  
> > > >  #define VCNL4000_COMMAND	0x80 /* Command register */
> > > >  #define VCNL4000_PROD_REV	0x81 /* Product ID and Revision ID */
> > > > @@ -40,6 +43,12 @@
> > > >  #define VCNL4000_PS_MEAS_FREQ	0x89 /* Proximity test signal frequency */
> > > >  #define VCNL4000_PS_MOD_ADJ	0x8a /* Proximity modulator timing adjustment */
> > > >  
> > > > +#define VCNL4200_AL_CONF	0x00 /* Ambient light configuration */
> > > > +#define VCNL4200_PS_CONF1	0x03 /* Proximity configuration */
> > > > +#define VCNL4200_PS_DATA	0x08 /* Proximity data */
> > > > +#define VCNL4200_AL_DATA	0x09 /* Ambient light data */
> > > > +#define VCNL4200_DEV_ID		0x0e /* Device ID, slave address and version */
> > > > +
> > > >  /* Bit masks for COMMAND register */
> > > >  #define VCNL4000_AL_RDY		BIT(6) /* ALS data ready? */
> > > >  #define VCNL4000_PS_RDY		BIT(5) /* proximity data ready? */
> > > > @@ -48,6 +57,7 @@
> > > >  
> > > >  enum vcnl4000_device_ids {
> > > >  	VCNL4000,
> > > > +	VCNL4200,
> > > >  };
> > > >  
> > > >  struct vcnl4000_data {
> > > > @@ -68,6 +78,7 @@ struct vcnl4000_chip_spec {
> > > >  
> > > >  static const struct i2c_device_id vcnl4000_id[] = {
> > > >  	{ "vcnl4000", VCNL4000 },
> > > > +	{ "vcnl4200", VCNL4200 },
> > > >  	{ }
> > > >  };
> > > >  MODULE_DEVICE_TABLE(i2c, vcnl4000_id);
> > > > @@ -92,6 +103,33 @@ static int vcnl4000_init(struct vcnl4000_data *data)
> > > >  	return 0;
> > > >  };
> > > >  
> > > > +static int vcnl4200_init(struct vcnl4000_data *data)
> > > > +{
> > > > +	int ret;
> > > > +
> > > > +	ret = i2c_smbus_read_word_data(data->client, VCNL4200_DEV_ID);
> > > > +	if (ret < 0)
> > > > +		return ret;
> > > > +
> > > > +	if ((ret & 0xff) != VCNL4200_PROD_ID)
> > > > +		return -ENODEV;
> > > > +
> > > > +	data->prod = "VCNL4200";
> > > > +	data->rev = ret >> 8 & 0xf;      
> > > 
> > > I'd add parenthesis for readability (and those who are not superfamiliar 
> > > with C operator precedence), i.e. (ret >> 8)    
> > 
> > I must admit that I was looking at C operator precedence manual to strip the
> > unnecessary parenthesis. I will add them back.
> >   
> > > > +
> > > > +	/* Set defaults and enable both sensors */      
> > > 
> > > maybe: both channels, instead of sensors?    
> > 
> > ok.
> >   
> > > > +	ret = i2c_smbus_write_byte_data(data->client, VCNL4200_AL_CONF, 0x00);
> > > > +	if (ret < 0)
> > > > +		return -EIO;      
> > > 
> > > why not simply return ret? an error value should in general not be 
> > > modified but returned as-is    
> > 
> > My mistake, I will fix it.
> > 
> > I will post v2.
> > 
> > Thanks for the review,
> > 
> > Tomas
> >   
> > > > +	ret = i2c_smbus_write_byte_data(data->client, VCNL4200_PS_CONF1, 0x00);
> > > > +	if (ret < 0)
> > > > +		return -EIO;
> > > > +
> > > > +	data->al_scale = 24000;
> > > > +
> > > > +	return 0;
> > > > +};
> > > > +
> > > >  static int vcnl4000_measure(struct vcnl4000_data *data, u8 req_mask,
> > > >  				u8 rdy_mask, u8 data_reg, int *val)
> > > >  {
> > > > @@ -138,6 +176,19 @@ static int vcnl4000_measure(struct vcnl4000_data *data, u8 req_mask,
> > > >  	return ret;
> > > >  }
> > > >  
> > > > +static int vcnl4200_measure(struct vcnl4000_data *data, u8 reg, int *val)
> > > > +{
> > > > +	int ret;
> > > > +
> > > > +	ret = i2c_smbus_read_word_data(data->client, reg);
> > > > +	if (ret < 0)
> > > > +		return ret;
> > > > +
> > > > +	*val = ret;
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > >  static int vcnl4000_measure_light(struct vcnl4000_data *data, int *val)
> > > >  {
> > > >  	return vcnl4000_measure(data,
> > > > @@ -145,6 +196,11 @@ static int vcnl4000_measure_light(struct vcnl4000_data *data, int *val)
> > > >  			VCNL4000_AL_RESULT_HI, val);
> > > >  }
> > > >  
> > > > +static int vcnl4200_measure_light(struct vcnl4000_data *data, int *val)
> > > > +{
> > > > +	return vcnl4200_measure(data, VCNL4200_AL_DATA, val);
> > > > +}
> > > > +
> > > >  static int vcnl4000_measure_proximity(struct vcnl4000_data *data, int *val)
> > > >  {
> > > >  	return vcnl4000_measure(data,
> > > > @@ -152,12 +208,22 @@ static int vcnl4000_measure_proximity(struct vcnl4000_data *data, int *val)
> > > >  			VCNL4000_PS_RESULT_HI, val);
> > > >  }
> > > >  
> > > > +static int vcnl4200_measure_proximity(struct vcnl4000_data *data, int *val)
> > > > +{
> > > > +	return vcnl4200_measure(data, VCNL4200_PS_DATA, val);
> > > > +}
> > > > +
> > > >  static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
> > > >  	[VCNL4000] = {
> > > >  		.init = vcnl4000_init,
> > > >  		.measure_light = vcnl4000_measure_light,
> > > >  		.measure_proximity = vcnl4000_measure_proximity,
> > > >  	},
> > > > +	[VCNL4200] = {
> > > > +		.init = vcnl4200_init,
> > > > +		.measure_light = vcnl4200_measure_light,
> > > > +		.measure_proximity = vcnl4200_measure_proximity,
> > > > +	},
> > > >  };
> > > >  
> > > >  static const struct iio_chan_spec vcnl4000_channels[] = {
> > > >       
> > >     
> 
