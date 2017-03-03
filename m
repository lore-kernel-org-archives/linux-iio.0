Return-Path: <SRS0=P3QM=2M=gmail.com=andy.shevchenko@kernel.org>
MIME-Version: 1.0
In-Reply-To: <f15e3023ba4cabd1a236943378caa6ab6c1b4d85.1488248485.git.eraretuya@gmail.com>
References: <cover.1488248485.git.eraretuya@gmail.com> <f15e3023ba4cabd1a236943378caa6ab6c1b4d85.1488248485.git.eraretuya@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 3 Mar 2017 18:51:28 +0200
Message-ID: <CAHp75VdntzxWpQvnYe346yjJ4e2wwpfFizSxLuUanc7F_QAm+Q@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] iio: accel: adxl345: Split driver into core and I2C
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

On Tue, Feb 28, 2017 at 4:37 AM, Eva Rachel Retuya <eraretuya@gmail.com> wrote:
> Move I2C-specific code into its own file and rely on regmap to access
> registers. The core code provides access to x, y, z and scale readings.

Portion of minor comments.

> +config ADXL345_I2C
> +       tristate "Analog Devices ADXL345 3-Axis Digital Accelerometer I2C Driver"

>         depends on !(INPUT_ADXL34X=y || INPUT_ADXL34X=m)

I'm wondering if it works in a form of

depends on INPUT_ADXL34X=n

> +int adxl345_common_probe(struct device *dev, struct regmap *regmap,
> +                        const char *name);
> +int adxl345_common_remove(struct device *dev);

I think a "common" word is redundant.

> - * IIO driver for ADXL345
> - * 7-bit I2C slave address: 0x1D (ALT ADDRESS pin tied to VDDIO) or
> - * 0x53 (ALT ADDRESS pin grounded)

> + * IIO core driver for ADXL345

Should not it be at the beginning of header comment?

> +static int adxl345_i2c_probe(struct i2c_client *client,
> +                            const struct i2c_device_id *id)
> +{

> +       struct regmap *regmap;
> +       const char *name = NULL;

Reverse tree order, please.

> +
> +       regmap = devm_regmap_init_i2c(client, &adxl345_i2c_regmap_config);
> +       if (IS_ERR(regmap)) {
> +               dev_err(&client->dev, "Error initializing i2c regmap: %d\n",
> +                       (int)PTR_ERR(regmap));
> +               return PTR_ERR(regmap);
> +       }
> +

> +       if (id)
> +               name = id->name;
> +
> +       return adxl345_common_probe(&client->dev, regmap, name);

Do you need temporary variable?

return adxl345_probe(&client->dev, regmap, id ? id->name : NULL);

-- 
With Best Regards,
Andy Shevchenko
