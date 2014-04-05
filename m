Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:58315 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752958AbaDEPRp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 5 Apr 2014 11:17:45 -0400
Message-ID: <53401E90.4080603@gmx.de>
Date: Sat, 05 Apr 2014 17:17:36 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>, Stefan Roese <sr@denx.de>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 4/4] iio:adc:spear_adc move out of staging
References: <1394895308-19154-1-git-send-email-jic23@kernel.org> <1394895308-19154-5-git-send-email-jic23@kernel.org> <5324EF60.6040003@gmx.de> <53387391.1000803@kernel.org> <5339159E.6000701@denx.de> <533FDF45.3010005@kernel.org>
In-Reply-To: <533FDF45.3010005@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Jonathan Cameron schrieb:
> On 31/03/14 08:13, Stefan Roese wrote:
>> On 30.03.2014 21:42, Jonathan Cameron wrote:
>>> On 16/03/14 00:25, Hartmut Knaack wrote:
>>>> Jonathan Cameron schrieb:
>>>>> This simple driver is ready to move out of staging.
>>>>>
>>>>> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
>>>>> Acked-by: Stefan Roese <sr@denx.de>
>>> Stefan, there are some 'what is going on?' questions in here you might
>>> want to answer!
>> I'll give it a try.
>>
>>>>> ---
>>>>>   drivers/iio/adc/Kconfig             |   8 +
>>>>>   drivers/iio/adc/Makefile            |   1 +
>>>>>   drivers/iio/adc/spear_adc.c         | 405
>>>>> ++++++++++++++++++++++++++++++++++++
>>>>>   drivers/staging/iio/adc/Kconfig     |   8 -
>>>>>   drivers/staging/iio/adc/Makefile    |   1 -
>>>>>   drivers/staging/iio/adc/spear_adc.c | 405
>>>>> ------------------------------------
>>>>>   6 files changed, 414 insertions(+), 414 deletions(-)
>>>>>
>>>>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>>>>> index 5553206..2e3e1b0 100644
>>>>> --- a/drivers/iio/adc/Kconfig
>>>>> +++ b/drivers/iio/adc/Kconfig
>>>>> @@ -164,6 +164,14 @@ config NAU7802
>>>>>         To compile this driver as a module, choose M here: the
>>> s>>         module will be called nau7802.
>>>>> +config SPEAR_ADC
>>>>> +    tristate "ST SPEAr ADC"
>>>>> +    depends on PLAT_SPEAR || COMPILE_TEST
>>>>> +    depends on HAS_IOMEM
>>>>> +    help
>>>>> +      Say yes here to build support for the integrated ADC inside the
>>>>> +      ST SPEAr SoC. Provides direct access via sysfs.
>>>>> +
>>>>>   config TI_ADC081C
>>>>>       tristate "Texas Instruments ADC081C021/027"
>>>>>       depends on I2C
>>>>> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
>>>>> index 89f1216..8378fb2 100644
>>>>> --- a/drivers/iio/adc/Makefile
>>>>> +++ b/drivers/iio/adc/Makefile
>>>>> @@ -18,6 +18,7 @@ obj-$(CONFIG_MAX1363) += max1363.o
>>>>>   obj-$(CONFIG_MCP320X) += mcp320x.o
>>>>>   obj-$(CONFIG_MCP3422) += mcp3422.o
>>>>>   obj-$(CONFIG_NAU7802) += nau7802.o
>>>>> +obj-$(CONFIG_SPEAR_ADC) += spear_adc.o
>>>>>   obj-$(CONFIG_TI_ADC081C) += ti-adc081c.o
>>>>>   obj-$(CONFIG_TI_AM335X_ADC) += ti_am335x_adc.o
>>>>>   obj-$(CONFIG_TWL6030_GPADC) += twl6030-gpadc.o
>>>>> diff --git a/drivers/iio/adc/spear_adc.c b/drivers/iio/adc/spear_adc.c
>>>>> new file mode 100644
>>>>> index 0000000..18a0a40
>>>>> --- /dev/null
>>>>> +++ b/drivers/iio/adc/spear_adc.c
>>>>> @@ -0,0 +1,405 @@
>>>>> +/*
>>>>> + * ST SPEAr ADC driver
>>>>> + *
>>>>> + * Copyright 2012 Stefan Roese <sr@denx.de>
>>>> I found a datasheet at
>>>> http://www.st.com/st-web-ui/static/active/en/resource/technical/document/reference_manual/DM00034813.pdf
>>>>
>>> THis is one of a number I think.. Not sure which parts will work out of
>>> the box
>>> with this driver though...  Stefan?  What was it written against?
>> I wrote and tested this driver for the SPEAr600 in 2011/2012. The manual mentioned above didn't exist at that time. I used one called "UM510_rev3.0.pdf" from Feb 2011. If interested I can send you the manual I used at that time.
>>
>> I don't have access to the SPEAr600 hardware anymore. I'm afraid but I can't be of much help here.
>>
> I'm tempted to say that, given it worked for stefan back then, we do what
> non functional clean ups make sense and push the driver out of staging whilst
> avoiding the issues highlighted by the 'interesting' datasheets.
>
> Either that, or if someone else wants to take on getting clarifications from
> ST on how it actually works, that is fine by me.
>
> J
I would agree to fix the issues which obviously violate the datasheet (get rid of SPEAR_ADC_CLK_MIN/MAX, rework calculation of count in spear_adc_set_clk and check boundaries of clk_low and clk_high, make spear_read_raw aware of the currently selected reference voltage), and just place comments about required set/cleared bits on top of those functions, where the datasheet is confusing (spear_adc_set_status, spear_adc_set_ctrl, spear_adc_get_average, spear_adc_set_scanrate).
Now, that I looked over it again, I would also propose to move the content of spear_adc_set_clk back into spear_write_raw, where it seems to have been located originally, and get rid of it afterwards (it doesn't do anything fancy, anyway). Sorry for bringing that up so late.
Btw: during the last weeks, I did some review of about 75% of the stable adc drivers and piled up about 50 cleanup-patches so far, that I would send out soon. I also plan to do the same on the staging adc drivers afterwards. So, if you can be patient, I might do already a lot of cleanup, that you don't like to waste your time on ;-)
Thanks,

Hartmut
>> Thanks,
>> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

