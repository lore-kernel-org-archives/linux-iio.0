Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:36425 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751593AbdECInj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 3 May 2017 04:43:39 -0400
MIME-Version: 1.0
In-Reply-To: <395643b8-c5cc-6a50-f424-98b4c5ec339b@siemens.com>
References: <c0fa84e3-1016-212f-280c-40bb83706895@siemens.com>
 <CAHp75VcG4qQktEOCXKc2saTNzpWo2sjneA4Afb7rHoEqkP8FtQ@mail.gmail.com>
 <8e6a0016-175a-8374-76f9-8bef1815f66f@siemens.com> <CAHp75VeyQ=uU=X3DxcNtVKDqkQV=9wK42nDaxs4ztDBU5iKTRw@mail.gmail.com>
 <395643b8-c5cc-6a50-f424-98b4c5ec339b@siemens.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 3 May 2017 11:43:38 +0300
Message-ID: <CAHp75VeBa8wUX6U+S=QmrLmqrwdMuFg3TCw3nyY62NraZaDrNg@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: Add support for TI ADC1x8s102
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
        linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sascha Weisenberger <sascha.weisenberger@siemens.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, May 3, 2017 at 11:24 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> On 2017-05-03 10:06, Andy Shevchenko wrote:
>> On Wed, May 3, 2017 at 8:35 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>> On 2017-05-02 22:53, Andy Shevchenko wrote:

>>>>> +       ret = device_property_read_u32(&spi->dev, "ext-vin-microvolt", &val);
>>>>
>>>> Why not to read u16 here?
>>>>
>>>
>>> Can I read a property with arbitrary width? Then this would simplify
>>> things.
>>
>> device_property_read_u16();
>
> By now I found out that ACPI does not care about the property type
> width, only DT does. So reading it as u16 under ACPI would be fine. But
> with DT, we will need a correctly sized property as well - default is u32.

I'm a bit lost here. ACPI cares and DT cares about property size. You
need to agreed what to use with DT people I think based on two
aspects:
- what existing property is using, if any
- what is preferable size to use

API allows to read any size. If you stick with u32 then perhaps better
to change internal variable to be u32 as well.

>>> Or do I have to follow how it was defined in the ACPI or device
>>> tree world?
>>
>> For property by the way you have to either follow existing one (by
>> name and meaning), or you
>> you need get an Ack from DT people (Rob, for example) to introduce such.
>>
>> Existing one is called "vref-external". So, definitely you need to
>> figure out this with DT people.
>
> Good point... @Rob, @Jonathon, to avoid a different naming between the
> now to be introduced ACPI usage and a potential DT binding later on,
> really better define a DT one now? Which name to use for such an
> external vref, the one above used by spear-adc already?

I forgot to mention you also need to add a binding documentation for
this driver.

>>>>> +               .owner  = THIS_MODULE,
>>>>
>>>> This is redundant I'm pretty sure.
>>>
>>> Even in 2017, drivers keep being added that carry such assignments. Can
>>> you explain when it is needed and when not? Otherwise, I will leave it in.
>>
>> The above I'm 100% sure is not needed. It's needed only in cases when
>> framework / device core doesn't do this for ya.
>>
>> In the above case IIRC device core does it once for all.

> Then this is not consistently filtered out in new driver reviews. I can
> remove it, of course.

Please, remove.

I guess many of new drivers just lack of proper review :-(

-- 
With Best Regards,
Andy Shevchenko
