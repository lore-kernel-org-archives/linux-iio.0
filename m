Return-Path: <k.kozlowski@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Message-id: <1424941884.27971.4.camel@AMDC1943>
Subject: Re: [PATCH 1/2] staging:iio:hmc5843: Constify register tables and
 struct regmap_config
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald <pmeerw@pmeerw.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Date: Thu, 26 Feb 2015 10:11:24 +0100
In-reply-to: <54EDB7E5.2050809@kernel.org>
References: <1424770909-7360-1-git-send-email-k.kozlowski@samsung.com>
 <54EDB7E5.2050809@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On śro, 2015-02-25 at 11:54 +0000, Jonathan Cameron wrote:
> On 24/02/15 09:41, Krzysztof Kozlowski wrote:
> > The regmap_access_table and regmap_config structures may be const
> > because they are not modified by the driver and regmap_init() accepts
> > pointer to const.
> > 
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Applied to the togreg branch of iio.git. Note I ended up hand applying
> this due to DOS line endings and some fuzz.

Thanks! I rebased the patchsed on next-20150224 so I did not expect any
fuzz.

Best regards,
Krzysztof

> 
> Jonathan
> > ---
> >  drivers/staging/iio/magnetometer/hmc5843_i2c.c | 8 ++++----
> >  drivers/staging/iio/magnetometer/hmc5843_spi.c | 8 ++++----
> >  2 files changed, 8 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/magnetometer/hmc5843_i2c.c b/drivers/staging/iio/magnetometer/hmc5843_i2c.c
> > index 6acd614cdbc6..8346cf81fc2e 100644
> > --- a/drivers/staging/iio/magnetometer/hmc5843_i2c.c
> > +++ b/drivers/staging/iio/magnetometer/hmc5843_i2c.c
> > @@ -22,7 +22,7 @@ static const struct regmap_range hmc5843_readable_ranges[] = {
> >  		regmap_reg_range(0, HMC5843_ID_END),
> >  };
> >  
> > -static struct regmap_access_table hmc5843_readable_table = {
> > +static const struct regmap_access_table hmc5843_readable_table = {
> >  		.yes_ranges = hmc5843_readable_ranges,
> >  		.n_yes_ranges = ARRAY_SIZE(hmc5843_readable_ranges),
> >  };
> > @@ -31,7 +31,7 @@ static const struct regmap_range hmc5843_writable_ranges[] = {
> >  		regmap_reg_range(0, HMC5843_MODE_REG),
> >  };
> >  
> > -static struct regmap_access_table hmc5843_writable_table = {
> > +static const struct regmap_access_table hmc5843_writable_table = {
> >  		.yes_ranges = hmc5843_writable_ranges,
> >  		.n_yes_ranges = ARRAY_SIZE(hmc5843_writable_ranges),
> >  };
> > @@ -40,12 +40,12 @@ static const struct regmap_range hmc5843_volatile_ranges[] = {
> >  		regmap_reg_range(HMC5843_DATA_OUT_MSB_REGS, HMC5843_STATUS_REG),
> >  };
> >  
> > -static struct regmap_access_table hmc5843_volatile_table = {
> > +static const struct regmap_access_table hmc5843_volatile_table = {
> >  		.yes_ranges = hmc5843_volatile_ranges,
> >  		.n_yes_ranges = ARRAY_SIZE(hmc5843_volatile_ranges),
> >  };
> >  
> > -static struct regmap_config hmc5843_i2c_regmap_config = {
> > +static const struct regmap_config hmc5843_i2c_regmap_config = {
> >  		.reg_bits = 8,
> >  		.val_bits = 8,
> >  
> > diff --git a/drivers/staging/iio/magnetometer/hmc5843_spi.c b/drivers/staging/iio/magnetometer/hmc5843_spi.c
> > index 98c4b57101c9..8e658f736e1f 100644
> > --- a/drivers/staging/iio/magnetometer/hmc5843_spi.c
> > +++ b/drivers/staging/iio/magnetometer/hmc5843_spi.c
> > @@ -19,7 +19,7 @@ static const struct regmap_range hmc5843_readable_ranges[] = {
> >  		regmap_reg_range(0, HMC5843_ID_END),
> >  };
> >  
> > -static struct regmap_access_table hmc5843_readable_table = {
> > +static const struct regmap_access_table hmc5843_readable_table = {
> >  		.yes_ranges = hmc5843_readable_ranges,
> >  		.n_yes_ranges = ARRAY_SIZE(hmc5843_readable_ranges),
> >  };
> > @@ -28,7 +28,7 @@ static const struct regmap_range hmc5843_writable_ranges[] = {
> >  		regmap_reg_range(0, HMC5843_MODE_REG),
> >  };
> >  
> > -static struct regmap_access_table hmc5843_writable_table = {
> > +static const struct regmap_access_table hmc5843_writable_table = {
> >  		.yes_ranges = hmc5843_writable_ranges,
> >  		.n_yes_ranges = ARRAY_SIZE(hmc5843_writable_ranges),
> >  };
> > @@ -37,12 +37,12 @@ static const struct regmap_range hmc5843_volatile_ranges[] = {
> >  		regmap_reg_range(HMC5843_DATA_OUT_MSB_REGS, HMC5843_STATUS_REG),
> >  };
> >  
> > -static struct regmap_access_table hmc5843_volatile_table = {
> > +static const struct regmap_access_table hmc5843_volatile_table = {
> >  		.yes_ranges = hmc5843_volatile_ranges,
> >  		.n_yes_ranges = ARRAY_SIZE(hmc5843_volatile_ranges),
> >  };
> >  
> > -static struct regmap_config hmc5843_spi_regmap_config = {
> > +static const struct regmap_config hmc5843_spi_regmap_config = {
> >  		.reg_bits = 8,
> >  		.val_bits = 8,
> >  
> > 
