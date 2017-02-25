Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46063 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751285AbdBYPJs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Feb 2017 10:09:48 -0500
Subject: Re: [PATCH v3 4/4] iio: accel: adxl345: Add SPI support
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
        Eva Rachel Retuya <eraretuya@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <cover.1487757223.git.eraretuya@gmail.com>
 <515297e48abd139993cab56dbf980711400d6534.1487757223.git.eraretuya@gmail.com>
 <CAHp75VdmB1YqY4YyntbvHUaK_9yjY8wFeX6i9hmMDaScajKNOw@mail.gmail.com>
 <cb64adc9-f468-11f8-4a8a-fd3f5779fee0@metafoo.de>
 <CAHp75VfbfRB_7Y2CRrJRYHqnJNMYD1hKScGr0HLSpFSGgJtymA@mail.gmail.com>
 <20170224091231.GC5012@Socrates-UM>
 <13912e47-1e3e-e68e-1e91-4a174f33fda5@metafoo.de>
 <CAHp75VfnnCe40V9k9zqyt4rkUYHgTDjfJ-y2qNV7SCxpLqhOtg@mail.gmail.com>
 <20170224143033.GD5012@Socrates-UM>
 <EA621197-929A-43D7-8E77-21991975F75E@jic23.retrosnub.co.uk>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        Alison Schofield <amsfield22@gmail.com>,
        Florian Vaussard <florian.vaussard@heig-vd.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <668ecb12-2a95-4e9c-8eab-509739d52d8c@kernel.org>
Date: Sat, 25 Feb 2017 15:09:36 +0000
MIME-Version: 1.0
In-Reply-To: <EA621197-929A-43D7-8E77-21991975F75E@jic23.retrosnub.co.uk>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/02/17 19:46, Jonathan Cameron wrote:
> 
> 
> On 24 February 2017 14:30:35 GMT+00:00, Eva Rachel Retuya <eraretuya@gmail.com> wrote:
>> On Fri, Feb 24, 2017 at 01:48:39PM +0200, Andy Shevchenko wrote:
>>> On Fri, Feb 24, 2017 at 11:22 AM, Lars-Peter Clausen
>> <lars@metafoo.de> wrote:
>>>> On 02/24/2017 10:12 AM, Eva Rachel Retuya wrote:
>>>>> On Thu, Feb 23, 2017 at 06:58:12PM +0200, Andy Shevchenko wrote:
>>>>>> On Thu, Feb 23, 2017 at 6:47 PM, Lars-Peter Clausen
>> <lars@metafoo.de> wrote:
>>>>>>> On 02/23/2017 05:43 PM, Andy Shevchenko wrote:
>>>>>>>> On Wed, Feb 22, 2017 at 12:23 PM, Eva Rachel Retuya
>> <eraretuya@gmail.com> wrote:
>>>
>>>>> I'll revert to the explicit SPI/I2C pattern in order to give more
>>>>> freedom in configuring as per the scenarios previously stated.
>>>>
>>>> Please check with Jonathan before you do, in the end he'll have to
>> apply the
>>>> patch.
>>>
>>> +1. I will be fine with either just need to make sure maintainer
>>> understands pros and cons.
>>>
>>
>> OK.
>>
>> Jonathan, please let me know whether to continue with your preferred
>> configuration or go with the "explicit" pattern that was discussed
>> here.
>>
> Have lost track. Will catch up with thread tomorrow and get back to you.
> 
Ah, now I have caught up, I'll go with the same no strong opinions.
Looks like it is 2 to one in favour of the explicit i2c / spi bits so
lets go with the original form.

Sorry for wasting your time on this Eva!

Divide is always between simplifying configurability of the kernel
vs minimising the extra code built that isn't needed.  Never entirely
obvious where that boundary falls and it really doesn't make that
much difference on either side.

Anyhow, at least you know the options and arguments either way now
so not completely wasted time.

Thanks,

Jonathan
> J
>> Thanks,
>> Eva
>>
>>> -- 
>>> With Best Regards,
>>> Andy Shevchenko
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-iio"
>> in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

