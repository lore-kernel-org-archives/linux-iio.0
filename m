Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <20150323151841.GA1878@lahna.fi.intel.com>
References: <1427118025-4380-1-git-send-email-robert.dolca@intel.com>
	<20150323151841.GA1878@lahna.fi.intel.com>
Date: Tue, 24 Mar 2015 13:51:08 +0200
Message-ID: <CAEnQRZCkb4o3VrmXHa+W6em+uggxEraOWtWP0yfO7CQ8Q0+KHw@mail.gmail.com>
Subject: Re: [PATCH] IIO: Adds ACPI support for ST gyroscopes
From: Daniel Baluta <daniel.baluta@intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Denis CIOCCA <denis.ciocca@st.com>
Cc: Robert Dolca <robert.dolca@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>,
	Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Mon, Mar 23, 2015 at 5:18 PM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> On Mon, Mar 23, 2015 at 03:40:24PM +0200, Robert Dolca wrote:
>> Signed-off-by: Robert Dolca <robert.dolca@intel.com>
>> ---
>>  drivers/iio/common/st_sensors/st_sensors_i2c.c | 35 +++++++++++++++++++=
+++++++
>>  drivers/iio/gyro/st_gyro_i2c.c                 | 29 +++++++++++++++++++=
+-
>>  include/linux/iio/common/st_sensors_i2c.h      |  3 +++
>>  3 files changed, 66 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/common/st_sensors/st_sensors_i2c.c b/drivers/ii=
o/common/st_sensors/st_sensors_i2c.c
>> index 98cfee29..2f612ec 100644
>> --- a/drivers/iio/common/st_sensors/st_sensors_i2c.c
>> +++ b/drivers/iio/common/st_sensors/st_sensors_i2c.c
>> @@ -13,6 +13,8 @@
>>  #include <linux/slab.h>
>>  #include <linux/iio/iio.h>
>>  #include <linux/of_device.h>
>> +#include <linux/acpi.h>
>> +#include <linux/gpio/consumer.h>
>>
>>  #include <linux/iio/common/st_sensors_i2c.h>
>>
>> @@ -107,6 +109,39 @@ void st_sensors_of_i2c_probe(struct i2c_client *cli=
ent,
>>  EXPORT_SYMBOL(st_sensors_of_i2c_probe);
>>  #endif
>>
>> +int st_sensors_acpi_i2c_probe(struct i2c_client *client,
>> +                            const struct acpi_device_id *match)
>> +{
>> +     const struct acpi_device_id *id;
>> +     struct gpio_desc *gpiod_irq;
>> +     int ret;
>> +
>> +     id =3D acpi_match_device(match, &client->dev);
>> +     if (!id)
>> +             return -ENODEV;
>> +
>> +     /* Get IRQ GPIO */
>> +     gpiod_irq =3D devm_gpiod_get_index(&client->dev, 0, 0);
>
> Please use plain devm_gpiod_get(&client->dev, NULL). That should work
> with DT and ACPI _DSD as well.
>
>> +     if (IS_ERR(gpiod_irq))
>> +             return -ENODEV;
>
> Why not return the original error here? Now you lose things like
> -EPROBE_DEFER.
>
>> +     /* Configure IRQ GPIO */
>> +     ret =3D gpiod_direction_input(gpiod_irq);
>> +     if (ret)
>> +             return ret;
>> +
>> +     /* Map the pin to an IRQ */
>> +     client->irq =3D gpiod_to_irq(gpiod_irq);
>> +
>> +     /* The name from the ACPI match takes precedence if present */
>> +     memset(client->name, 0, sizeof(client->name));
>> +     strncpy(client->name, (char *) id->driver_data,
>> +             min(sizeof(client->name), strlen((char *) id->driver_data)=
));
>
> Hmm, the above should not be required at all. If the device has an ACPI
> companion the I2C core will match first with that.
>
> Also you now modify the original i2c_client structure. Should you at
> least restore the original values when the driver is unbound?

Hi Mika,

This is similar with device tree  aproach. Looking at st_sensors_of_i2c_pro=
be,
we have:

=C2=BB       /* The name from the OF match takes precedence if present */
=C2=BB       strncpy(client->name, of_id->data, sizeof(client->name));
=C2=BB       client->name[sizeof(client->name) - 1] =3D '\0';

We want to keep the compatibility with the device tree implementation. Not
sure if the custom name is really required.

Denis, perhaps you can offer more info on this.

Daniel.
