Return-Path: <SRS0=TLAE=JV=loewensteinmedical.de=nikolaus.voss@kernel.org>
Date: Thu, 5 Jul 2018 11:30:37 +0200 (CEST)
From: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
cc: "Voss, Dr. Nikolaus" <Nikolaus.Dr.Voss@loewensteinmedical.de>,
    Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
    Lars-Peter Clausen <lars@metafoo.de>,
    Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
    Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
    Linus Walleij <linus.walleij@linaro.org>,
    Xiongfeng Wang <xiongfeng.wang@linaro.org>,
    Javier Martinez Canillas <javier@dowhile0.org>,
    "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] IIO: st_accel_i2c.c: Simplify access to driver
 data
In-Reply-To: <CAHp75VfJOhX3+eL-ppvT7SPfDE_S7ht1drjobvFqmXPYApMETg@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1807051129060.21087@fox.voss.local>
References: <cover.1530710826.git.nikolaus.voss@loewensteinmedical.de> <e8cb86f843d6b524b671f8fd79fece02475a61c0.1530710826.git.nikolaus.voss@loewensteinmedical.de> <CAHp75VfJOhX3+eL-ppvT7SPfDE_S7ht1drjobvFqmXPYApMETg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On Wed, 4 Jul 2018, Andy Shevchenko wrote:
> On Tue, Jul 3, 2018 at 8:41 AM, Nikolaus Voss
> <nikolaus.voss@loewensteinmedical.de> wrote:
>> Use device_get_match_data API to simplify access to driver data.
>> Let acpi_device_id table entries point to the same driver data as
>> of_device_id table entries and uniquify access to driver data by using
>> device_get_match_data API. Remove unused i2c_device_id .driver_data
>> fields.
>>
>
> Couple of comments below, otherwise
>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>
>> Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
>> ---
>>  drivers/iio/accel/st_accel_i2c.c | 56 ++++++++++++++------------------
>>  1 file changed, 24 insertions(+), 32 deletions(-)
>>
>> diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
>> index 6bdec8c451e0..c6e08c834f11 100644
>> --- a/drivers/iio/accel/st_accel_i2c.c
>> +++ b/drivers/iio/accel/st_accel_i2c.c
>> @@ -14,8 +14,8 @@
>>  #include <linux/acpi.h>
>>  #include <linux/i2c.h>
>>  #include <linux/iio/iio.h>
>> +#include <linux/property.h>
>>
>> -#include <linux/iio/common/st_sensors.h>
>>  #include <linux/iio/common/st_sensors_i2c.h>
>>  #include "st_accel.h"
>>
>> @@ -107,7 +107,7 @@ MODULE_DEVICE_TABLE(of, st_accel_of_match);
>>
>>  #ifdef CONFIG_ACPI
>>  static const struct acpi_device_id st_accel_acpi_match[] = {
>> -       {"SMO8A90", LNG2DM},
>> +       {"SMO8A90", (kernel_ulong_t)LNG2DM_ACCEL_DEV_NAME},
>>         { },
>
> Is it done against iio-next?
>
> I see two records in this table.

No, I'll rebase onto linux-next and resend...

Niko

...
