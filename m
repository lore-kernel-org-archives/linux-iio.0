Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ua0-f195.google.com ([209.85.217.195]:32902 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbeHBV0s (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Aug 2018 17:26:48 -0400
MIME-Version: 1.0
In-Reply-To: <20180802182729.2061830-2-pn@denx.de>
References: <20180802182729.2061830-1-pn@denx.de> <20180802182729.2061830-2-pn@denx.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 2 Aug 2018 22:34:14 +0300
Message-ID: <CAHp75VcR7aaUkNJdARMvnkuzxfODwVhHFH0Hm94hsENbShtO3A@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] iio: light: Add support for vishay vcnl4035
To: Parthiban Nallathambi <pn@denx.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>, wd@denx.de,
        sbabic@denx.de, Heiko Schocher <hs@denx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Aug 2, 2018 at 9:27 PM, Parthiban Nallathambi <pn@denx.de> wrote:
> Add support for VCNL4035, which is capable of Ambient light
> sensing (ALS) and proximity function. This patch adds support
> only for ALS function

> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/bitops.h>
> +#include <linux/regmap.h>
> +#include <linux/pm_runtime.h>

Sort?

> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>

Ditto.

> +       if (reg & (VCNL4035_INT_ALS_IF_H_MASK | VCNL4035_INT_ALS_IF_L_MASK))
> +               return true;
> +       else
> +               return false;

return !!(reg & ...); ?

> +static irqreturn_t vcnl4035_drdy_irq_thread(int irq, void *private)
> +{
> +       struct iio_dev *indio_dev = private;
> +       struct vcnl4035_data *data = iio_priv(indio_dev);
> +

> +       if (vcnl4035_is_triggered(data)) {

Here is negative conditional suits.

> +#ifndef CONFIG_PM

Why?

> +       ret = vcnl4035_set_als_power_state(data, VCNL4035_MODE_ALS_ENABLE);
> +       if (ret < 0)
> +               return ret;
> +#endif

> +               pr_err("regmap_write default THDH returned %d\n", ret);

dev_err()

> +               pr_err("regmap_write default THDL returned %d\n", ret);

Ditto.


> +       ret = pm_runtime_set_active(&client->dev);
> +       if (ret < 0)
> +               goto fail_poweroff;
> +
> +       pm_runtime_enable(&client->dev);
> +       pm_runtime_set_autosuspend_delay(&client->dev, VCNL4035_SLEEP_DELAY_MS);
> +       pm_runtime_use_autosuspend(&client->dev);

Usually we do this after we probed the device.

> +       if (client->irq) {

First of all, it can be negative.
Second, care to factor out this rather long branch to a separate function?

> +               if (ret < 0) {
> +                       dev_err(&client->dev, "request irq %d for trigger0 failed\n",
> +                               client->irq);
> +                       goto fail_buffer_clean;
> +                       }

Indentation.

> +       }

So, do I understand correctly that IRQ is optional for this device?



> +#ifdef CONFIG_PM
> +static int vcnl4035_runtime_suspend(struct device *dev)

Perhaps __maybe_unused

> +static int vcnl4035_runtime_resume(struct device *dev)

Ditto.

> +{
> +       struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +       struct vcnl4035_data *data = iio_priv(indio_dev);
> +       int ret;
> +
> +       regcache_sync(data->regmap);
> +       ret = vcnl4035_set_als_power_state(data, VCNL4035_MODE_ALS_ENABLE);
> +       if (ret < 0)
> +               return ret;

+ blank line

> +       /* wait for 1 ALS integration cycle */
> +       msleep(data->als_it_val * 100);
> +
> +       return 0;
> +}
> +#endif

> +static const struct of_device_id vcnl4035_of_match[] = {
> +       { .compatible = "vishay,vcnl4035", },
> +       { },

Better w/o comma.

> +};
> +MODULE_DEVICE_TABLE(of, vcnl4035_of_match);

> +
> +static const struct i2c_device_id vcnl4035_id[] = {
> +       { "vcnl4035", 0 },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(i2c, vcnl4035_id);

Are you expecting legacy code to use this? I would rather switch to
->probe_new() and also remove this.

-- 
With Best Regards,
Andy Shevchenko
