Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35786 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750964AbdBXJJ0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Feb 2017 04:09:26 -0500
Date: Fri, 24 Feb 2017 17:06:13 +0800
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
Subject: Re: [PATCH v3 3/4] iio: accel: adxl345: Split driver into core and
 I2C
Message-ID: <20170224090611.GB5012@Socrates-UM>
References: <cover.1487757223.git.eraretuya@gmail.com>
 <68ce56410416b439bd59a8e2f4fe294a48cb5fad.1487757223.git.eraretuya@gmail.com>
 <CAHp75VcWethtVW4Q6Q7Y+E9b6s32mf9YFT8wecXV7dDUS3asLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHp75VcWethtVW4Q6Q7Y+E9b6s32mf9YFT8wecXV7dDUS3asLQ@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Feb 23, 2017 at 06:36:42PM +0200, Andy Shevchenko wrote:
> On Wed, Feb 22, 2017 at 12:23 PM, Eva Rachel Retuya <eraretuya@gmail.com> wrote:
> > Move I2C-specific code into its own file and rely on regmap to access
> > registers. The core code provides access to x, y, z and scale readings.
> 
> Like Lars already pointed to possibility of use of this in ACPI based
> platforms, I would add a reference to
> commit 01427fe7c4b9 ("Input: adxl34x - make it enumerable in ACPI environment").
> 
> Please fix your patches accordingly.
> 

Ack. Thank you for pointing this out. I'm not aware of the said commit.

Eva

> 
> > +static const struct i2c_device_id adxl345_i2c_id[] = {
> > +       { "adxl345", 0 },
> > +       { }
> > +};
> > +
> > +MODULE_DEVICE_TABLE(i2c, adxl345_i2c_id);
> > +
> > +#ifdef CONFIG_OF
> > +static const struct of_device_id adxl345_of_match[] = {
> > +       { .compatible = "adi,adxl345" },
> > +       { },
> > +};
> > +
> > +MODULE_DEVICE_TABLE(of, adxl345_of_match);
> > +#endif
> > +
> > +static struct i2c_driver adxl345_i2c_driver = {
> > +       .driver = {
> > +               .name   = "adxl345_i2c",
> > +               .of_match_table = of_match_ptr(adxl345_of_match),
> > +       },
> > +       .probe          = adxl345_i2c_probe,
> > +       .remove         = adxl345_i2c_remove,
> > +       .id_table       = adxl345_i2c_id,
> > +};
> > +
> > +module_i2c_driver(adxl345_i2c_driver);
> > +
> > +MODULE_AUTHOR("Eva Rachel Retuya <eraretuya@gmail.com>");
> > +MODULE_DESCRIPTION("ADXL345 3-Axis Digital Accelerometer I2C driver");
> > +MODULE_LICENSE("GPL v2");
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
