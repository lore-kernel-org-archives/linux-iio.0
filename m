Return-Path: <SRS0=P3QM=2M=gmail.com=andy.shevchenko@kernel.org>
MIME-Version: 1.0
In-Reply-To: <e40679afd338899c9f5d2c7581c3d89754d726ec.1488248485.git.eraretuya@gmail.com>
References: <cover.1488248485.git.eraretuya@gmail.com> <e40679afd338899c9f5d2c7581c3d89754d726ec.1488248485.git.eraretuya@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 3 Mar 2017 18:44:27 +0200
Message-ID: <CAHp75VduHU+q9B9LUMj1PoXFyTqZnuTtDboNyMvOmrOrRgBstw@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] iio: accel: adxl345: Use I2C regmap instead of
 direct I2C access
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
> Convert the driver to use regmap instead of I2C-specific functions. This
> is done in preparation for splitting this driver into core and
> I2C-specific code as well as introduction of SPI driver.
>
> Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Okay, my another set of comments.
> @@ -70,6 +76,7 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
>  {
>         struct adxl345_data *data = iio_priv(indio_dev);

>         int ret;
> +       __le16 regval;

Reverse tree order, please.

     __le16 regval;
     int ret;

> @@ -104,37 +112,50 @@ static int adxl345_probe(struct i2c_client *client,
>  {
>         struct adxl345_data *data;
>         struct iio_dev *indio_dev;
> +       struct device *dev;
> +       struct regmap *regmap;

>         int ret;
> +       u32 regval;

Ditto.

> +
> +       regmap = devm_regmap_init_i2c(client, &adxl345_regmap_config);
> +       if (IS_ERR(regmap)) {
> +               dev_err(&client->dev, "Error initializing regmap: %d\n",
> +                       (int)PTR_ERR(regmap));

I don't like explicit casting in such cases at all. Why not to use
%ld? Same for the similar places in the series.

> -       if (ret != ADXL345_DEVID) {
> -               dev_err(&client->dev, "Invalid device ID: %d\n", ret);
> +       if (regval != ADXL345_DEVID) {
> +               dev_err(dev, "Invalid device ID: %x, expected %x\n",
> +                       regval, ADXL345_DEVID);

So, originally it was in decimal form. Does hex looks better or what
is behind the change?

-- 
With Best Regards,
Andy Shevchenko
