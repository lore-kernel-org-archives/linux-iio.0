Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35903 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750721AbdCDG1b (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Mar 2017 01:27:31 -0500
Date: Sat, 4 Mar 2017 13:56:34 +0800
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
Subject: Re: [PATCH v5 3/4] iio: accel: adxl345: Split driver into core and
 I2C
Message-ID: <20170304055633.GB6948@Socrates-UM>
References: <cover.1488248485.git.eraretuya@gmail.com>
 <f15e3023ba4cabd1a236943378caa6ab6c1b4d85.1488248485.git.eraretuya@gmail.com>
 <CAHp75VdntzxWpQvnYe346yjJ4e2wwpfFizSxLuUanc7F_QAm+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHp75VdntzxWpQvnYe346yjJ4e2wwpfFizSxLuUanc7F_QAm+Q@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Mar 03, 2017 at 06:51:28PM +0200, Andy Shevchenko wrote:
> On Tue, Feb 28, 2017 at 4:37 AM, Eva Rachel Retuya <eraretuya@gmail.com> wrote:
> > Move I2C-specific code into its own file and rely on regmap to access
> > registers. The core code provides access to x, y, z and scale readings.
> 
> Portion of minor comments.
> 
> > +config ADXL345_I2C
> > +       tristate "Analog Devices ADXL345 3-Axis Digital Accelerometer I2C Driver"
> 
> >         depends on !(INPUT_ADXL34X=y || INPUT_ADXL34X=m)
> 
> I'm wondering if it works in a form of
> 
> depends on INPUT_ADXL34X=n
> 

Yes it works. Will change it into this form.

> > +int adxl345_common_probe(struct device *dev, struct regmap *regmap,
> > +                        const char *name);
> > +int adxl345_common_remove(struct device *dev);
> 
> I think a "common" word is redundant.
> 

OK. I will use "core" instead.

> > - * IIO driver for ADXL345
> > - * 7-bit I2C slave address: 0x1D (ALT ADDRESS pin tied to VDDIO) or
> > - * 0x53 (ALT ADDRESS pin grounded)
> 
> > + * IIO core driver for ADXL345
> 
> Should not it be at the beginning of header comment?
> 

Ack.

> > +static int adxl345_i2c_probe(struct i2c_client *client,
> > +                            const struct i2c_device_id *id)
> > +{
> 
> > +       struct regmap *regmap;
> > +       const char *name = NULL;
> 
> Reverse tree order, please.
> 
> > +
> > +       regmap = devm_regmap_init_i2c(client, &adxl345_i2c_regmap_config);
> > +       if (IS_ERR(regmap)) {
> > +               dev_err(&client->dev, "Error initializing i2c regmap: %d\n",
> > +                       (int)PTR_ERR(regmap));
> > +               return PTR_ERR(regmap);
> > +       }
> > +
> 
> > +       if (id)
> > +               name = id->name;
> > +
> > +       return adxl345_common_probe(&client->dev, regmap, name);
> 
> Do you need temporary variable?
> 
> return adxl345_probe(&client->dev, regmap, id ? id->name : NULL);
> 

Will remove it and use the form you suggest.

Thanks,
Eva

> -- 
> With Best Regards,
> Andy Shevchenko
