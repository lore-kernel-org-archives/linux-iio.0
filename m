Return-Path: <SRS0=5Y02=2E=gmail.com=andy.shevchenko@kernel.org>
MIME-Version: 1.0
In-Reply-To: <b477e7142cb39b5bb86670191f41dcc031e80569.1487757223.git.eraretuya@gmail.com>
References: <cover.1487757223.git.eraretuya@gmail.com> <b477e7142cb39b5bb86670191f41dcc031e80569.1487757223.git.eraretuya@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 23 Feb 2017 18:27:52 +0200
Message-ID: <CAHp75Vca29-H050MgCvdo986+QA5odJmAF3_AwQURMYZOb=wUA@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] iio: accel: adxl345: Use I2C regmap instead of
 direct I2C access
To: Eva Rachel Retuya <eraretuya@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Michael Hennerich <michael.hennerich@analog.com>, daniel.baluta@gmail.com,
	amsfield22@gmail.com, Florian Vaussard <florian.vaussard@heig-vd.ch>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Wed, Feb 22, 2017 at 12:22 PM, Eva Rachel Retuya <eraretuya@gmail.com> wrote:
> Convert the driver to use regmap instead of I2C-specific functions.
> Also, introduce the header file "adxl345.h" and export the probe and
> remove functions. This is done in preparation for splitting this driver
> into core and I2C-specific code as well as introduction of SPI driver.
>
> Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>

Is it possible to use device just after this very patch?
For me it seems there is bisectability issue.

> -static const struct i2c_device_id adxl345_i2c_id[] = {
> -       { "adxl345", 0 },
> -       { }
> -};
> -
> -MODULE_DEVICE_TABLE(i2c, adxl345_i2c_id);
> -
> -static struct i2c_driver adxl345_driver = {
> -       .driver = {
> -               .name   = "adxl345",
> -       },
> -       .probe          = adxl345_probe,
> -       .remove         = adxl345_remove,
> -       .id_table       = adxl345_i2c_id,
> -};
> -
> -module_i2c_driver(adxl345_driver);
> +EXPORT_SYMBOL_GPL(adxl345_common_remove);

-- 
With Best Regards,
Andy Shevchenko
