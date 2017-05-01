Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34624 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S378465AbdEALVE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 May 2017 07:21:04 -0400
MIME-Version: 1.0
In-Reply-To: <96d20633a6ff9792f7be642a590669fc07d9ad63.1493450577.git.eraretuya@gmail.com>
References: <cover.1493450577.git.eraretuya@gmail.com> <96d20633a6ff9792f7be642a590669fc07d9ad63.1493450577.git.eraretuya@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 1 May 2017 14:21:02 +0300
Message-ID: <CAHp75VcOqrQ8QKiSLoS4gkREvm8voDsw22EnxRPwtWLJFkQu4g@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] iio: accel: adxl345_core: Introduce set_mode and
 data_ready functions
To: Eva Rachel Retuya <eraretuya@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        Alison Schofield <amsfield22@gmail.com>,
        Florian Vaussard <florian.vaussard@heig-vd.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Apr 29, 2017 at 10:48 AM, Eva Rachel Retuya <eraretuya@gmail.com> wrote:
> Move code that enables measurement/standby mode into its own function
> and call that function when appropriate. Previously, we set the sensor
> to measurement in probe and back to standby during remove. Change it
> here to only enter measurement mode when request for data is initiated.
>
> The DATA_READY bit is always set if the corresponding event occurs.
> Introduce the data_ready function that monitors the INT_SOURCE register
> of this bit. This is done to ensure consistent readings.

Couple of minors below.
Otherwise, FWIW:
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> +static int adxl345_data_ready(struct adxl345_data *data)
> +{
> +       struct device *dev = regmap_get_device(data->regmap);

> +       int tries = 5;

unsigned int tries = 5;

> +       u32 val;
> +       int ret;
> +
> +       do {

> +               /*
> +                * 1/ODR + 1.1ms; 11.1ms at ODR of 0.10 Hz
> +                * Sensor currently operates at default ODR of 100 Hz
> +                */
> +               usleep_range(1100, 11100);

>From the above comment I can't get why we sleep first then attempt to
read and not otherwise. Please, elaborate.

> +
> +               ret = regmap_read(data->regmap, ADXL345_REG_INT_SOURCE, &val);
> +               if (ret < 0)
> +                       return ret;
> +               if ((val & ADXL345_INT_DATA_READY) == ADXL345_INT_DATA_READY)
> +                       return 0;
> +       } while (--tries);
> +       dev_err(dev, "Data is not yet ready, try again.\n");
> +
> +       return -EAGAIN;
> +}

-- 
With Best Regards,
Andy Shevchenko
