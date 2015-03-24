Return-Path: <lars@metafoo.de>
Message-ID: <551168F0.1090901@metafoo.de>
Date: Tue, 24 Mar 2015 14:38:56 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Robert Dolca <robert.dolca@gmail.com>
CC: Robert Dolca <robert.dolca@intel.com>, linux-iio@vger.kernel.org,
 Jonathan Cameron <jic23@kernel.org>,
 linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
 Peter Meerwald <pmeerw@pmeerw.net>,
 Linus Walleij <linus.walleij@linaro.org>,
 Denis CIOCCA <denis.ciocca@st.com>
Subject: Re: [PATCH] IIO: Adds ACPI support for ST gyroscopes
References: <1427118025-4380-1-git-send-email-robert.dolca@intel.com> <551155C3.2030403@metafoo.de> <CAFPB+YdwrPoob1CPdUfSt2uBJWPi=6_0-d0NChj2agD6-z-8qw@mail.gmail.com>
In-Reply-To: <CAFPB+YdwrPoob1CPdUfSt2uBJWPi=6_0-d0NChj2agD6-z-8qw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 03/24/2015 02:26 PM, Robert Dolca wrote:
> On Tue, Mar 24, 2015 at 2:17 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>> [...]
>>>
>>> +int st_sensors_acpi_i2c_probe(struct i2c_client *client,
>>> +                              const struct acpi_device_id *match)
>>> +{
>>> +       const struct acpi_device_id *id;
>>> +       struct gpio_desc *gpiod_irq;
>>> +       int ret;
>>> +
>>> +       id = acpi_match_device(match, &client->dev);
>>> +       if (!id)
>>> +               return -ENODEV;
>>> +
>>> +       /* Get IRQ GPIO */
>>> +       gpiod_irq = devm_gpiod_get_index(&client->dev, 0, 0);
>>> +       if (IS_ERR(gpiod_irq))
>>> +               return -ENODEV;
>>> +
>>> +       /* Configure IRQ GPIO */
>>> +       ret = gpiod_direction_input(gpiod_irq);
>>> +       if (ret)
>>> +               return ret;
>>
>>
>> How exactly does this whole GPIO IRQ thing work with ACPI. Does the ACPI
>> description just specify the GPIOs and the driver needs to know which GPIO
>> is the is used for the IRQ or does the description indicate that a certain
>> GPIO should be used as a IRQ. The reason why I'm asking is that same code
>> pops up in pretty much every ACPI I2C sensor driver now. Which suggests that
>> this should be factored out into common infrastructure.
>>
>> And especially the requesting and the setting of the direction of the GPIO
>> should not be necessary if the GPIO controller implements interrupt handling
>> correctly as this is something that is, as far as I understand, taken care
>> of by the GPIO framework when the IRQ is requested.
>
> Hi Lars,
>
> In the ACPI description you specify one or more IRQ GPIO pins. In the
> driver you request the GPIO pin using the index. In the ACPI 5.1
> specification you can use named GPIOs instead of index.

But is there a way to distinguish between IRQ GPIOs and non IRQ GPIOs? If it 
is clear that a certain GPIO is the IRQ for the device the I2C framework 
should take care of assigning the client->irq field, instead of doing it 
manually in each and every device driver.

> As far as I know you can not specify the direction in the ACPI
> description and I am not sure if we can rely on the fact that the GPIO
> pins are in input mode by default.

The GPIO driver is responsible for configuring the pin accordingly so that 
it works in interrupt mode, when the IRQ that belongs to the pin is 
requested. So you don't have to rely on the default being input. No 
additional configuration on the GPIO should be necessary.

>
>>
>>> +
>>> +       /* Map the pin to an IRQ */
>>> +       client->irq = gpiod_to_irq(gpiod_irq);
>>> +
>>> +       /* The name from the ACPI match takes precedence if present */
>>> +       memset(client->name, 0, sizeof(client->name));
>>> +       strncpy(client->name, (char *) id->driver_data,
>>> +               min(sizeof(client->name), strlen((char *)
>>> id->driver_data)));
>>
>>
>> Both client->irq and client->name should not be modified by the driver,
>> these are only supposed to be set by the I2C framework. Modifying them in
>> the driver can result in undefined behavior.
>
> I understand that modifying the name is not a good approach. Doing it
> for device tree and not for ACPI can also result in a unknown
> behavior. Seems like the best approach here is to remove that name
> overwriting from both device tree and acpi probe after becomes clear
> why was it there in the 1st place.

Yes.
