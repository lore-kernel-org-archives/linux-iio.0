Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:35822 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752071AbbCYNmj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 25 Mar 2015 09:42:39 -0400
MIME-Version: 1.0
In-Reply-To: <20150325132116.GY1878@lahna.fi.intel.com>
References: <1427118025-4380-1-git-send-email-robert.dolca@intel.com>
 <551155C3.2030403@metafoo.de> <CAFPB+YdwrPoob1CPdUfSt2uBJWPi=6_0-d0NChj2agD6-z-8qw@mail.gmail.com>
 <551168F0.1090901@metafoo.de> <CACRpkdaOQ-onkgQJSyoVEQNtkZ9nF_4z=9jNdU-tug-TwvAAkQ@mail.gmail.com>
 <20150324150630.GP1878@lahna.fi.intel.com> <CACRpkdYmN5YnH5rcA13NerPKdx62TpQVi5Hwr1vchu13QUcaOw@mail.gmail.com>
 <20150325094327.GW1878@lahna.fi.intel.com> <20150325122505.GX1878@lahna.fi.intel.com>
 <20150325132116.GY1878@lahna.fi.intel.com>
From: Robert Dolca <robert.dolca@gmail.com>
Date: Wed, 25 Mar 2015 15:42:17 +0200
Message-ID: <CAFPB+YeD2e2vLy-NWhZ4FkK+5vGWubGC4tUDhZQMBQV8Sx6ttw@mail.gmail.com>
Subject: Re: [PATCH] IIO: Adds ACPI support for ST gyroscopes
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Robert Dolca <robert.dolca@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Denis CIOCCA <denis.ciocca@st.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Mar 25, 2015 at 3:21 PM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> On Wed, Mar 25, 2015 at 02:25:05PM +0200, Mika Westerberg wrote:
>> I think we can do the same for ACPI GpioInts so that we introduce
>> acpi_gpio_irq_get() that translates from GpioInt to Linux IRQ
>> numberspace. Then we can do something like below in I2C core:
>>
>>       if (client->irq <= 0) {
>>               int irq = -ENOENT;
>>
>>                 if (dev->of_node)
>>                         irq = of_irq_get(dev->of_node, 0);
>>                 else if (ACPI_COMPANION(dev))
>>                         irq = acpi_gpio_irq_get(ACPI_COMPANION(dev), 0);
>>
>>               if (irq == -EPROBE_DEFER)
>>                         return irq;
>>                 if (irq < 0)
>>                         irq = 0;
>>
>>                 client->irq = irq;
>>       }
>>
>> Now it has the drawback that the first GpioInt will not be available to
>> the driver anymore (as a GPIO since it is locked) but if DT already does
>> the same we should be fine.
>
> Below patch should take care of this.
>
> Robert, can you try it out?
>
> If people think this is the right way to go forward, I'll make formal
> patches and submit them for review.
>
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index c0929d938ced..ed7c40c7b4ab 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -510,6 +510,36 @@ struct gpio_desc *acpi_get_gpiod_by_index(struct acpi_device *adev,
>         return lookup.desc ? lookup.desc : ERR_PTR(-ENOENT);
>  }
>
> +/**
> + * acpi_dev_gpio_irq_get() - Find GpioInt and translate it to Linux IRQ number
> + * @adev: pointer to a ACPI device to get IRQ from
> + * @index: index of GpioInt resource (starting from %0)
> + *
> + * If the device has one or more GpioInt resources, this function can be
> + * used to translate from the GPIO offset in the resource to the Linux IRQ
> + * number.
> + *
> + * Return: Linux IRQ number (>%0) on success, negative errno on failure.
> + */
> +int acpi_dev_gpio_irq_get(struct acpi_device *adev, int index)
> +{
> +       struct gpio_desc *desc;
> +       int i = 0;
> +
> +       do {
> +               struct acpi_gpio_info info;
> +
> +               desc = acpi_get_gpiod_by_index(adev, NULL, i, &info);
> +               if (!IS_ERR(desc)) {
> +                       if (info.gpioint && i++ == index)
> +                               return gpiod_to_irq(desc);
> +               }
> +       } while (!IS_ERR(desc));
> +
> +       return -ENOENT;
> +}
> +EXPORT_SYMBOL_GPL(acpi_dev_gpio_irq_get);
> +
>  static acpi_status
>  acpi_gpio_adr_space_handler(u32 function, acpi_physical_address address,
>                             u32 bits, u64 *value, void *handler_context,
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index edf274cabe81..c12a3f24ada4 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -629,8 +629,13 @@ static int i2c_device_probe(struct device *dev)
>         if (!client)
>                 return 0;
>
> -       if (!client->irq && dev->of_node) {
> -               int irq = of_irq_get(dev->of_node, 0);
> +       if (client->irq <= 0) {
> +               int irq = -ENOENT;
> +
> +               if (dev->of_node)
> +                       irq = of_irq_get(dev->of_node, 0);
> +               else if (ACPI_COMPANION(dev))
> +                       irq = acpi_dev_gpio_irq_get(ACPI_COMPANION(dev), 0);
>
>                 if (irq == -EPROBE_DEFER)
>                         return irq;
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 24c7aa8b1d20..826e214ab7d5 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -704,6 +704,8 @@ static inline void acpi_dev_remove_driver_gpios(struct acpi_device *adev)
>         if (adev)
>                 adev->driver_gpios = NULL;
>  }
> +
> +int acpi_dev_gpio_irq_get(struct acpi_device *adev, int index);
>  #else
>  static inline int acpi_dev_add_driver_gpios(struct acpi_device *adev,
>                               const struct acpi_gpio_mapping *gpios)
> @@ -711,6 +713,11 @@ static inline int acpi_dev_add_driver_gpios(struct acpi_device *adev,
>         return -ENXIO;
>  }
>  static inline void acpi_dev_remove_driver_gpios(struct acpi_device *adev) {}
> +
> +static inline int acpi_dev_gpio_irq_get(struct acpi_device *adev, int index)
> +{
> +       return -ENXIO;
> +}
>  #endif
>
>  /* Device properties */

Hi Mika,

I will try it and come back with more info.

Robert
