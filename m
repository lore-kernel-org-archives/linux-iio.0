Return-Path: <SRS0=dOAm=JU=gmail.com=andy.shevchenko@kernel.org>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1807040846060.6169@fox.voss.local>
References: <cover.1530599660.git.nikolaus.voss@loewensteinmedical.de>
 <1212fde5edcf360231282c9d2487712fc5b4d6f8.1530599660.git.nikolaus.voss@loewensteinmedical.de>
 <CAHp75VfjHy9=4ZMJqb-2H5iXDjMpM=vm5kvz4PVA_jTUkoSJKA@mail.gmail.com> <alpine.DEB.2.20.1807040846060.6169@fox.voss.local>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 4 Jul 2018 12:00:25 +0300
Message-ID: <CAHp75VfZt7jH+FDqWs8BAuEt3oT71RiVmWA04Vk9d_p1uNBDmg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] IIO: st_accel_i2c.c: Simplify access to driver data
To: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>, Linus Walleij <linus.walleij@linaro.org>,
	Xiongfeng Wang <xiongfeng.wang@linaro.org>, linux-iio@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Wed, Jul 4, 2018 at 9:56 AM, Nikolaus Voss
<nikolaus.voss@loewensteinmedical.de> wrote:
> On Wed, 4 Jul 2018, Andy Shevchenko wrote:
>>
>> On Tue, Jul 3, 2018 at 8:41 AM, Nikolaus Voss
>> <nikolaus.voss@loewensteinmedical.de> wrote:
>>>
>>> Use device_get_match_data API to simplify access to driver data.
>>
>>
>> ..._data()
>>
>> But. You actually don't use it below.

> It is used, see below.

I meant the API call you mentioned in the commit message is not used
in this version and below you agree to use it eventually.

>>> Let acpi_device_id table entries point to the same driver data as
>>> of_device_id table entries and uniquify access to driver data by using
>>> device_get_match_data API.
>>
>>
>>>  #include <linux/acpi.h>
>>>  #include <linux/i2c.h>
>>>  #include <linux/iio/iio.h>
>>
>>
>>> +#include <linux/of_device.h>
>>
>>
>> (linux/property.h)
>>
>>> +       match = of_device_get_match_data(&client->dev);
>>> +       if (!match)
>>> +               match = acpi_device_get_match_data(&client->dev);
>>
>>
>> What I meant is to simply call
>>
>> match = device_get_match_data(...);
>
>
> Ok, this works, thank you. I will prepare a new patch version.
>
> This is where the match data is used:
>
>>
>>> +       if (match)
>>> +               strlcpy(client->name, match, sizeof(client->name));

> In this driver, match data is used to map DT compatible strings/ ACPI CIDs
> to the key strings (.._ACCEL_DEV_NAME) which are used to identify the actual
> device (and are also used in i2c_device_id table).

-- 
With Best Regards,
Andy Shevchenko
