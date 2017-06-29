Return-Path: <SRS0=b2ZH=6C=linaro.org=linus.walleij@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170623230404.2283-1-Ismail.Kose@maximintegrated.com>
References: <20170623230404.2283-1-Ismail.Kose@maximintegrated.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 29 Jun 2017 14:47:06 +0200
Message-ID: <CACRpkdbNz9HSBWjQrntMpJDOaaEYKaNgrm6=qzdhiH8rfv+F1g@mail.gmail.com>
Subject: Re: [PATCH] iio: dac: DS4424: add Maxim DS4422/DS4424 DAC driver support
To: Ismail Kose <Ismail.Kose@maximintegrated.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, William Breathitt Gray <vilhelm.gray@gmail.com>,
	Jean-Francois Dagenais <jeff.dagenais@gmail.com>, Fabrice Gasnier <fabrice.gasnier@st.com>,
	gwenhael.goavec-merou@trabucayre.com, Peter Rosin <peda@axentia.se>,
	maxime.roussinbelanger@gmail.com, ihkose@gmail.com,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Sat, Jun 24, 2017 at 1:04 AM, Ismail Kose
<Ismail.Kose@maximintegrated.com> wrote:

> +Optional properties:
> +       - vcc-supply: Power supply us optional. If not defined, driver will ignore it.

*is* optional I guess.

No need to mention the driver.

> +#include <linux/regulator/consumer.h>
(...)
> +       struct regulator *vcc_reg;
> +       const char *vcc_reg_name;
> +       bool regulator_state;

Why do you do this funky stuff?

> +int ds4424_regulator_onoff(struct iio_dev *indio_dev, bool enable)
> +{
> +       struct ds4424_data *data = iio_priv(indio_dev);
> +       int ret = 0;
> +
> +       if (data->vcc_reg == NULL)
> +               return ret;

This should not happen.

You get dummy regulators or stubs if the regulator is not there
and that works just fine.

> +
> +       if (data->regulator_state == PWR_OFF && enable == PWR_ON) {
> +               ret = regulator_enable(data->vcc_reg);
> +               if (ret) {
> +                       pr_err("%s - enable vcc_reg failed, ret=%d\n",
> +                               __func__, ret);
> +                       goto done;
> +               }
> +       } else if (data->regulator_state == PWR_ON && enable == PWR_OFF) {
> +               ret = regulator_disable(data->vcc_reg);
> +               if (ret) {
> +                       pr_err("%s - disable vcc_reg failed, ret=%d\n",
> +                               __func__, ret);
> +                       goto done;
> +               }
> +       }
> +
> +       data->regulator_state = enable;
> +done:
> +       return ret;
> +}

The regulator already has a state and knows if it is on or
off. Why do you insist on having a "regulator state" reinventing
the wheel in the driver?

> +       ret = of_property_read_string(node, "vcc-supply", &data->vcc_reg_name);
> +       if (ret < 0) {
> +               pr_info("DAC vcc-supply is not available in dts\n");
> +               data->vcc_reg_name = NULL;
> +       }

Don't do this. Just try to get the regulator by name and do not try
to be clever about this, the regulator core will give you a dummy supply
if the regulator is not there.

> +       if (data->vcc_reg_name) {

Just skip this check.

> +               data->vcc_reg = devm_regulator_get(&client->dev,
> +                       data->vcc_reg_name);

Just

data->vcc_reg = devm_regulator_get(&client->dev, "vcc");


> +               if (IS_ERR(data->vcc_reg)) {
> +                       ret = PTR_ERR(data->vcc_reg);
> +                       dev_err(&client->dev,
> +                               "Failed to get vcc_reg regulator: %d\n", ret);
> +                       return ret;
> +               }

And keep this.

You will get a dummy or stub working just fine if the regulator is not there.

> +       ret = ds4424_regulator_onoff(indio_dev, PWR_ON);
> +       if (ret < 0) {
> +               pr_err("Unable to turn on the regulator. %s:%d, ret: %d\n",
> +                       __func__, __LINE__, ret);
> +               return ret;
> +       }

I don't think this helper is even needed. Just enable it here.

Disable it on the other paths.

Problem solved.

Yours,
Linus Walleij
