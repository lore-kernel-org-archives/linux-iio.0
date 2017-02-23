Return-Path: <SRS0=5Y02=2E=gmail.com=andy.shevchenko@kernel.org>
MIME-Version: 1.0
In-Reply-To: <68ce56410416b439bd59a8e2f4fe294a48cb5fad.1487757223.git.eraretuya@gmail.com>
References: <cover.1487757223.git.eraretuya@gmail.com> <68ce56410416b439bd59a8e2f4fe294a48cb5fad.1487757223.git.eraretuya@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 23 Feb 2017 18:36:42 +0200
Message-ID: <CAHp75VcWethtVW4Q6Q7Y+E9b6s32mf9YFT8wecXV7dDUS3asLQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] iio: accel: adxl345: Split driver into core and I2C
To: Eva Rachel Retuya <eraretuya@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Michael Hennerich <michael.hennerich@analog.com>, Daniel Baluta <daniel.baluta@gmail.com>,
	Alison Schofield <amsfield22@gmail.com>, Florian Vaussard <florian.vaussard@heig-vd.ch>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Wed, Feb 22, 2017 at 12:23 PM, Eva Rachel Retuya <eraretuya@gmail.com> wrote:
> Move I2C-specific code into its own file and rely on regmap to access
> registers. The core code provides access to x, y, z and scale readings.

Like Lars already pointed to possibility of use of this in ACPI based
platforms, I would add a reference to
commit 01427fe7c4b9 ("Input: adxl34x - make it enumerable in ACPI environment").

Please fix your patches accordingly.


> +static const struct i2c_device_id adxl345_i2c_id[] = {
> +       { "adxl345", 0 },
> +       { }
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, adxl345_i2c_id);
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id adxl345_of_match[] = {
> +       { .compatible = "adi,adxl345" },
> +       { },
> +};
> +
> +MODULE_DEVICE_TABLE(of, adxl345_of_match);
> +#endif
> +
> +static struct i2c_driver adxl345_i2c_driver = {
> +       .driver = {
> +               .name   = "adxl345_i2c",
> +               .of_match_table = of_match_ptr(adxl345_of_match),
> +       },
> +       .probe          = adxl345_i2c_probe,
> +       .remove         = adxl345_i2c_remove,
> +       .id_table       = adxl345_i2c_id,
> +};
> +
> +module_i2c_driver(adxl345_i2c_driver);
> +
> +MODULE_AUTHOR("Eva Rachel Retuya <eraretuya@gmail.com>");
> +MODULE_DESCRIPTION("ADXL345 3-Axis Digital Accelerometer I2C driver");
> +MODULE_LICENSE("GPL v2");


-- 
With Best Regards,
Andy Shevchenko
