Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35028 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751115AbdBXJCx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Feb 2017 04:02:53 -0500
Date: Fri, 24 Feb 2017 17:02:08 +0800
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        daniel.baluta@gmail.com, amsfield22@gmail.com,
        Florian Vaussard <florian.vaussard@heig-vd.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 2/4] iio: accel: adxl345: Use I2C regmap instead of
 direct I2C access
Message-ID: <20170224090206.GA5012@Socrates-UM>
References: <cover.1487757223.git.eraretuya@gmail.com>
 <b477e7142cb39b5bb86670191f41dcc031e80569.1487757223.git.eraretuya@gmail.com>
 <CAHp75Vca29-H050MgCvdo986+QA5odJmAF3_AwQURMYZOb=wUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHp75Vca29-H050MgCvdo986+QA5odJmAF3_AwQURMYZOb=wUA@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Feb 23, 2017 at 06:27:52PM +0200, Andy Shevchenko wrote:
> On Wed, Feb 22, 2017 at 12:22 PM, Eva Rachel Retuya <eraretuya@gmail.com> wrote:
> > Convert the driver to use regmap instead of I2C-specific functions.
> > Also, introduce the header file "adxl345.h" and export the probe and
> > remove functions. This is done in preparation for splitting this driver
> > into core and I2C-specific code as well as introduction of SPI driver.
> >
> > Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
> 
> Is it possible to use device just after this very patch?
> For me it seems there is bisectability issue.
> 

Hello Andy,

Most likely no because of excessive deletion. Sorry for the mistake, I'll
submit another version that hopefully won't cause this issue.

Thanks,
Eva

> > -static const struct i2c_device_id adxl345_i2c_id[] = {
> > -       { "adxl345", 0 },
> > -       { }
> > -};
> > -
> > -MODULE_DEVICE_TABLE(i2c, adxl345_i2c_id);
> > -
> > -static struct i2c_driver adxl345_driver = {
> > -       .driver = {
> > -               .name   = "adxl345",
> > -       },
> > -       .probe          = adxl345_probe,
> > -       .remove         = adxl345_remove,
> > -       .id_table       = adxl345_i2c_id,
> > -};
> > -
> > -module_i2c_driver(adxl345_driver);
> > +EXPORT_SYMBOL_GPL(adxl345_common_remove);
> 
> -- 
> With Best Regards,
> Andy Shevchenko
