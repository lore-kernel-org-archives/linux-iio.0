Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from thoth.sbs.de ([192.35.17.2]:41546 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1177304AbdDYKxe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 25 Apr 2017 06:53:34 -0400
Subject: Re: [PATCH] iio: adc: Add support for TI ADC1x8s102
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <6e0f0b52-27a1-0ce5-c217-3aa941babe63@siemens.com>
 <1493064330.24567.180.camel@linux.intel.com>
 <dcba0513-e3c2-33f2-6cc9-c23d05a7e6ba@siemens.com>
 <CAHp75VfzH922Z5FfGQ7gS-+FLR7H_Q3mKm_58xmchZn5KEjiqQ@mail.gmail.com>
 <38f562f3-69d2-67d0-ecc2-4b44d67286e2@siemens.com>
 <CAHp75Vf517+vfe7GiTH2Gb0WBDdqi4fcR5Z1O6ideJMpbDhysw@mail.gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sascha Weisenberger <sascha.weisenberger@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <08d40bf0-4e68-d763-af99-be1f60e369fc@siemens.com>
Date: Tue, 25 Apr 2017 12:53:25 +0200
MIME-Version: 1.0
In-Reply-To: <CAHp75Vf517+vfe7GiTH2Gb0WBDdqi4fcR5Z1O6ideJMpbDhysw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2017-04-25 11:42, Andy Shevchenko wrote:
> +Cc: Mika
> 
> On Tue, Apr 25, 2017 at 8:44 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>> On 2017-04-24 23:25, Andy Shevchenko wrote:
>>> On Mon, Apr 24, 2017 at 11:32 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>> On 2017-04-24 22:05, Andy Shevchenko wrote:
>>>>> On Mon, 2017-04-24 at 21:28 +0200, Jan Kiszka wrote:
>>>>>> This is an upstream port of an IIO driver for the TI ADC108S102 and
>>>>>> ADC128S102. The former can be found on the Intel Galileo Gen2 and the
>>>>>> Siemens SIMATIC IOT2000. For those boards, ACPI-based enumeration is
>>>>>> included.
> 
>>>>>> +    chip_data->gpio_cs = ADC1x8S102_GALILEO2_CS;
>>>>>> +    spi->controller_data = chip_data;
>>>>>> +    dev_info(&spi->dev, "setting GPIO CS value to %d\n",
>>>>>> +             chip_data->gpio_cs);
>>>>>> +    spi_setup(spi);
>>>>>> +
>>>>>> +    *pdata = &int3495_platform_data;
>>>>>> +
>>>>>> +    return 0;
>>>>>> +}
>>>>>
>>>>> This is weird approach.
>>>>
>>>> Let me dig deeper if are allowed to pass a static struct here as well.
>>>> But the struct is driver-defined.
>>>
>>> We have _DSD for ACPI, that's why I sent another email where I was
>>> asking for DSDT excerpt and if it's already in the wild.
>>
>> I don't find any traces of "_DSD" in those DSDTs.
> 
> Yes, and looking into the DSDT you don't need them.
> 
>>>>> Moreover, please do not use platform data at all.
>>>>
>>>> That is just following pre-existing pattern, just look around in the
>>>> iio/adc folder, not to speak of others. But I'm open to learn about any
>>>> newer pattern there is.
>>>
>>> Unified Device Properties API is your friend. It makes driver to
>>> consume resources in agnostic way.
>>
>> Is that ACPI-only or a generic solution?
> 
> It's generic as one may assume from the title.
> 
>> Where is a good example? Sorry,
>> I still don't see how to make code out of your comments.
> 
> Mostly remove those ugly hacks and start over.

Still not a constructive answer.

> 
>>> See above. We have nowadays mechanisms to provide device properties natively.
>>> Without seeing DSDT I can't tell more.
>>
>> You've seen it, please tell me more now.
> 
> DSDT is wrong. So, it's another bug in the table. If you able to fix
> it in your firmware, do it ASAP.

Well, fixing future versions is one thing, addressing existing hardware
another...

> 
> CS is a property of the host controller, not the slave devices.
> 
> Once I pointed to Mika's work for Galileo, perhaps you forgot. The
> below is an example how to fix ACPI table using
> 
> https://github.com/westeri/meta-acpi/blob/master/recipes-bsp/acpi-tables/samples/galileo/spi.asl
> 
> It's done for SPI1, but you easily can convert it to SPI0 and
> corresponding properties.

So that information would be picked up by the existing SPI host
controller driver, and we don't need anything beyond basic ACPI support
in this driver? That is indeed appealing. Maybe we can make the board
patch private then, until a firmware update is available. I'll split
that part off.

> 
> Btw, we welcome any contribution to meta-acpi repository!

Shipping own DSDTs is no long-term path: we would be forced to provide
separate images due to a single parameter being different in the DSDTs
of the 2020 and 2040. And you cannot provide any overlay to adjust the
table after boot, i.e. once we know on which board we are.

The dependency on meta-intel is also suboptimal (we will switch to a
long-term supported kernel source soon), but that would probably be fixable.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
