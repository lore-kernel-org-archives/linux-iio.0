Return-Path: <SRS0=IK89=JT=gmail.com=andy.shevchenko@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1212fde5edcf360231282c9d2487712fc5b4d6f8.1530599660.git.nikolaus.voss@loewensteinmedical.de>
References: <cover.1530599660.git.nikolaus.voss@loewensteinmedical.de> <1212fde5edcf360231282c9d2487712fc5b4d6f8.1530599660.git.nikolaus.voss@loewensteinmedical.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 4 Jul 2018 00:07:23 +0300
Message-ID: <CAHp75VfjHy9=4ZMJqb-2H5iXDjMpM=vm5kvz4PVA_jTUkoSJKA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] IIO: st_accel_i2c.c: Simplify access to driver data
To: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>, Linus Walleij <linus.walleij@linaro.org>,
	Xiongfeng Wang <xiongfeng.wang@linaro.org>, nv@vosn.de, linux-iio@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Tue, Jul 3, 2018 at 8:41 AM, Nikolaus Voss
<nikolaus.voss@loewensteinmedical.de> wrote:
> Use device_get_match_data API to simplify access to driver data.

..._data()

But. You actually don't use it below.

> Let acpi_device_id table entries point to the same driver data as
> of_device_id table entries and uniquify access to driver data by using
> device_get_match_data API.

>  #include <linux/acpi.h>
>  #include <linux/i2c.h>
>  #include <linux/iio/iio.h>

> +#include <linux/of_device.h>

(linux/property.h)

> +       match = of_device_get_match_data(&client->dev);
> +       if (!match)
> +               match = acpi_device_get_match_data(&client->dev);

What I meant is to simply call

match = device_get_match_data(...);

> +       if (match)
> +               strlcpy(client->name, match, sizeof(client->name));

-- 
With Best Regards,
Andy Shevchenko
