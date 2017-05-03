Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from goliath.siemens.de ([192.35.17.28]:37783 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753241AbdECRMB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 3 May 2017 13:12:01 -0400
Subject: Re: [PATCH v2] iio: adc: Add support for TI ADC1x8s102
To: Andy Shevchenko <andy.shevchenko@gmail.com>
References: <c0fa84e3-1016-212f-280c-40bb83706895@siemens.com>
 <CAHp75VcG4qQktEOCXKc2saTNzpWo2sjneA4Afb7rHoEqkP8FtQ@mail.gmail.com>
 <8e6a0016-175a-8374-76f9-8bef1815f66f@siemens.com>
 <CAHp75VeyQ=uU=X3DxcNtVKDqkQV=9wK42nDaxs4ztDBU5iKTRw@mail.gmail.com>
 <395643b8-c5cc-6a50-f424-98b4c5ec339b@siemens.com>
 <CAHp75VeBa8wUX6U+S=QmrLmqrwdMuFg3TCw3nyY62NraZaDrNg@mail.gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
        linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sascha Weisenberger <sascha.weisenberger@siemens.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <edfb6049-c2f5-93ab-6c74-10b00d0a5254@siemens.com>
Date: Wed, 3 May 2017 19:11:49 +0200
MIME-Version: 1.0
In-Reply-To: <CAHp75VeBa8wUX6U+S=QmrLmqrwdMuFg3TCw3nyY62NraZaDrNg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2017-05-03 10:43, Andy Shevchenko wrote:
> On Wed, May 3, 2017 at 11:24 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>> On 2017-05-03 10:06, Andy Shevchenko wrote:
>>> On Wed, May 3, 2017 at 8:35 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>> On 2017-05-02 22:53, Andy Shevchenko wrote:
> 
>>>>>> +       ret = device_property_read_u32(&spi->dev, "ext-vin-microvolt", &val);
>>>>>
>>>>> Why not to read u16 here?
>>>>>
>>>>
>>>> Can I read a property with arbitrary width? Then this would simplify
>>>> things.
>>>
>>> device_property_read_u16();
>>
>> By now I found out that ACPI does not care about the property type
>> width, only DT does. So reading it as u16 under ACPI would be fine. But
>> with DT, we will need a correctly sized property as well - default is u32.
> 
> I'm a bit lost here. ACPI cares and DT cares about property size.

ACPI_TYPE_INTEGER, used for properties, is always stored and read as
64-bit value and then casted to the requested type.

In contrast, if you restrict a DT property via "/bits/ XX", its storage
format changes, and you are better off using the correct access function
for it. That's what I mean.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
