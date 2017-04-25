Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from goliath.siemens.de ([192.35.17.28]:38825 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S980425AbdDYFvT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Apr 2017 01:51:19 -0400
Subject: Re: [PATCH] iio: adc: Add support for TI ADC1x8s102
To: Andy Shevchenko <andy.shevchenko@gmail.com>
References: <6e0f0b52-27a1-0ce5-c217-3aa941babe63@siemens.com>
 <1493064330.24567.180.camel@linux.intel.com>
 <dcba0513-e3c2-33f2-6cc9-c23d05a7e6ba@siemens.com>
 <CAHp75VfzH922Z5FfGQ7gS-+FLR7H_Q3mKm_58xmchZn5KEjiqQ@mail.gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sascha Weisenberger <sascha.weisenberger@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <38f562f3-69d2-67d0-ecc2-4b44d67286e2@siemens.com>
Date: Tue, 25 Apr 2017 07:44:21 +0200
MIME-Version: 1.0
In-Reply-To: <CAHp75VfzH922Z5FfGQ7gS-+FLR7H_Q3mKm_58xmchZn5KEjiqQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2017-04-24 23:25, Andy Shevchenko wrote:
> On Mon, Apr 24, 2017 at 11:32 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>> On 2017-04-24 22:05, Andy Shevchenko wrote:
>>> On Mon, 2017-04-24 at 21:28 +0200, Jan Kiszka wrote:
>>>> This is an upstream port of an IIO driver for the TI ADC108S102 and
>>>> ADC128S102. The former can be found on the Intel Galileo Gen2 and the
>>>> Siemens SIMATIC IOT2000. For those boards, ACPI-based enumeration is
>>>> included.
> 
>>>> +#ifdef CONFIG_ACPI
>>>> +typedef int (*acpi_setup_handler)(struct spi_device *,
>>>> +                              const struct
>>>> adc1x8s102_platform_data **);
>>>> +
>>>> +static const struct adc1x8s102_platform_data int3495_platform_data =
>>>> {
>>>> +    .ext_vin = 5000,        /* 5 V */
>>>> +};
>>>> +
>>>
>>>> +/* Galileo Gen 2 SPI setup */
>>>> +static int
>>>> +adc1x8s102_setup_int3495(struct spi_device *spi,
>>>> +                     const struct adc1x8s102_platform_data
>>>> **pdata)
>>>> +{
>>>
>>>> +    struct pxa2xx_spi_chip *chip_data;
>>>
>>> This one is too big to waste memory on one member.
>>>
>>>> +
>>>> +    chip_data = devm_kzalloc(&spi->dev, sizeof(*chip_data),
>>>> GFP_KERNEL);
>>>> +    if (!chip_data)
>>>> +            return -ENOMEM;
>>>> +
>>>> +    chip_data->gpio_cs = ADC1x8S102_GALILEO2_CS;
>>>> +    spi->controller_data = chip_data;
>>>> +    dev_info(&spi->dev, "setting GPIO CS value to %d\n",
>>>> +             chip_data->gpio_cs);
>>>> +    spi_setup(spi);
>>>> +
>>>> +    *pdata = &int3495_platform_data;
>>>> +
>>>> +    return 0;
>>>> +}
>>>
>>> This is weird approach.
>>
>> Let me dig deeper if are allowed to pass a static struct here as well.
>> But the struct is driver-defined.
> 
> We have _DSD for ACPI, that's why I sent another email where I was
> asking for DSDT excerpt and if it's already in the wild.

I don't find any traces of "_DSD" in those DSDTs.

> 
>>
>>> Moreover, please do not use platform data at all.
>>
>> That is just following pre-existing pattern, just look around in the
>> iio/adc folder, not to speak of others. But I'm open to learn about any
>> newer pattern there is.
> 
> Unified Device Properties API is your friend. It makes driver to
> consume resources in agnostic way.

Is that ACPI-only or a generic solution? Where is a good example? Sorry,
I still don't see how to make code out of your comments.

> 
>>>> +static const struct acpi_device_id adc1x8s102_acpi_ids[] = {
>>>> +    { "INT3495",  (kernel_ulong_t)&adc1x8s102_setup_int3495 },
>>>> +    { }
>>>> +};
>>>> +MODULE_DEVICE_TABLE(acpi, adc1x8s102_acpi_ids);
>>>> +#endif
>>>> +
>>>> +static int adc1x8s102_probe(struct spi_device *spi)
>>>> +{
>>>> +    const struct adc1x8s102_platform_data *pdata = spi-
>>>>> dev.platform_data;
>>>> +    struct adc1x8s102_state *st;
>>>> +    struct iio_dev *indio_dev;
>>>> +    int ret;
>>>> +
>>>
>>>> +#ifdef CONFIG_ACPI
>>>
>>> No.
>>
>> ...because?
> 
> Because in correctly written ->probe() all ACPI functions have stubs
> for !CONFIG_ACPI case. Just no need.

OK, will give that a try. I just don't want to leave much dead code
behind for !CONFIG_ACPI.

> 
>>>> +            setup_handler = (acpi_setup_handler)id->driver_data;
>>>> +            if (setup_handler) {
>>>> +                    ret = setup_handler(spi, &pdata);
>>>> +                    if (ret)
>>>> +                            return ret;
>>>> +            }
>>>
>>> No way.
>>
>> Constructive feedback, please.
> 
> See above. We have nowadays mechanisms to provide device properties natively.
> Without seeing DSDT I can't tell more.

You've seen it, please tell me more now.

> 
>>>> +++ b/include/linux/platform_data/adc1x8s102.h
>>>
>>> It must be no such file at all!
>>> Please, remove it completely.
>>
>> Not without explaining what the new style is. As I said, the existing
>> driver use that as well.
> 
> See above.
> 
>> The fact that there is no OF binding yet
>> exploiting this should be no excuse IMHO.
> 
> ...and I'm not talking about it at all.
> 

But I am: ACPI is not the center of the world (luckily), and this driver
shall not be designed to only work with that way of defining resources.
Therefore, I'm trying to follow driver which include OF support.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
