Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35585 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750731AbdCDFxm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Mar 2017 00:53:42 -0500
Date: Sat, 4 Mar 2017 13:52:50 +0800
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        Alison Schofield <amsfield22@gmail.com>,
        Florian Vaussard <florian.vaussard@heig-vd.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 2/4] iio: accel: adxl345: Use I2C regmap instead of
 direct I2C access
Message-ID: <20170304055249.GA6948@Socrates-UM>
References: <cover.1488248485.git.eraretuya@gmail.com>
 <e40679afd338899c9f5d2c7581c3d89754d726ec.1488248485.git.eraretuya@gmail.com>
 <CAHp75VduHU+q9B9LUMj1PoXFyTqZnuTtDboNyMvOmrOrRgBstw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHp75VduHU+q9B9LUMj1PoXFyTqZnuTtDboNyMvOmrOrRgBstw@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Mar 03, 2017 at 06:44:27PM +0200, Andy Shevchenko wrote:
> On Tue, Feb 28, 2017 at 4:37 AM, Eva Rachel Retuya <eraretuya@gmail.com> wrote:
> > Convert the driver to use regmap instead of I2C-specific functions. This
> > is done in preparation for splitting this driver into core and
> > I2C-specific code as well as introduction of SPI driver.
> >
> > Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> Okay, my another set of comments.
> > @@ -70,6 +76,7 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
> >  {
> >         struct adxl345_data *data = iio_priv(indio_dev);
> 
> >         int ret;
> > +       __le16 regval;
> 
> Reverse tree order, please.
> 
>      __le16 regval;
>      int ret;
> 

Ack.

> > @@ -104,37 +112,50 @@ static int adxl345_probe(struct i2c_client *client,
> >  {
> >         struct adxl345_data *data;
> >         struct iio_dev *indio_dev;
> > +       struct device *dev;
> > +       struct regmap *regmap;
> 
> >         int ret;
> > +       u32 regval;
> 
> Ditto.
> 
> > +
> > +       regmap = devm_regmap_init_i2c(client, &adxl345_regmap_config);
> > +       if (IS_ERR(regmap)) {
> > +               dev_err(&client->dev, "Error initializing regmap: %d\n",
> > +                       (int)PTR_ERR(regmap));
> 
> I don't like explicit casting in such cases at all. Why not to use
> %ld? Same for the similar places in the series.
> 

OK. Will do that instead.

> > -       if (ret != ADXL345_DEVID) {
> > -               dev_err(&client->dev, "Invalid device ID: %d\n", ret);
> > +       if (regval != ADXL345_DEVID) {
> > +               dev_err(dev, "Invalid device ID: %x, expected %x\n",
> > +                       regval, ADXL345_DEVID);
> 
> So, originally it was in decimal form. Does hex looks better or what
> is behind the change?

Yes it looks better. I made the change to make it easily seen what it
read in hex compared to the known DEVID.

Thanks,
Eva

> 
> -- 
> With Best Regards,
> Andy Shevchenko
