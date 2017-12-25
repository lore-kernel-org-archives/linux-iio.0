Return-Path: <SRS0=4XYu=DV=nexb.com=pombredanne@kernel.org>
MIME-Version: 1.0
In-Reply-To: <6ac417c6-b9d6-8aa6-c998-5a729a512434@gmail.com>
References: <1513984753-3040-1-git-send-email-milan.o.stevanovic@gmail.com>
 <CAOFm3uFn+z+ouTNM5HOw3FEgBhW3T4WiPRwtPuwapq_m4wHWKQ@mail.gmail.com> <6ac417c6-b9d6-8aa6-c998-5a729a512434@gmail.com>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Mon, 25 Dec 2017 15:21:28 +0100
Message-ID: <CAOFm3uH+QCKMmkrRNYv0-8ibwPZ5Wobg9EK8dWW5ot0sU5j-7w@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: add driver for ti adc081s/adc101s/adc121s
To: Milan Stevanovic <milan.o.stevanovic@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Sun, Dec 24, 2017 at 8:02 PM, Milan Stevanovic
<milan.o.stevanovic@gmail.com> wrote:
> On 12/23/2017 03:13 PM, Philippe Ombredanne wrote:
>>
>> Milan,
>>
>> On Sat, Dec 23, 2017 at 12:19 AM, Milan Stevanovic
>> <milan.o.stevanovic@gmail.com> wrote:
>>>
>>> Signed-off-by: Milan Stevanovic <milan.o.stevanovic@gmail.com>
>>
>> <snip>
>>
>> May be it is just me, but you may be missing a commit message?
>>
>> <snip>
>
> Yes... Sorry I missed this
>>>
>>> --- /dev/null
>>> +++ b/drivers/iio/adc/ti-adc081s.c
>>> @@ -0,0 +1,239 @@
>>> +/*
>>> + * TI ADC081S/ADC101S/ADC121S 8/10/12-bit ADC driver
>>> + *
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License version 2 as
>>> + * published by the Free Software Foundation.
>>
>> Could you consider using an SPDX tag here as documented by Thomas in
>> this patch set [1] ?
>> This is the new thing for this end of of year and a must have for 2018!
>>
>> [1] https://lkml.org/lkml/2017/12/4/934
>
> Thanks for this... I added it...
>
> Best regards
> Milan
>
> From 039f53aa702bd524e53c61b0365d048e2624ef02 Mon Sep 17 00:00:00 2001
> From: Milan Stevanovic <milan.o.stevanovic@gmail.com>
> Date: Sat, 23 Dec 2017 00:06:32 +0100
> Subject: [PATCH v2] iio: adc: add driver for ti adc081s/adc101s/adc121s
>
> Linux device driver for single-channel CMOS
> 8/10/12-bit analog-to-digital converter with a
> high-speed serial interface.
>
> Signed-off-by: Milan Stevanovic <milan.o.stevanovic@gmail.com>
>
> Changes in v2:
>  - Add SPDX tag
>  - Add correct git commit message

<snip>

> --- /dev/null
> +++ b/drivers/iio/adc/ti-adc081s.c
> @@ -0,0 +1,242 @@
> +/*
> + * Released under the GPLv2 only.
> + * SPDX-License-Identifier: GPL-2.0
> + *

The SPDX tag should be on the first line using a C++ style comment
when in a .c file as explained in Thomas doc
And when using an SPDx id, do no repeat a license notice: this would
defeat the whole purpose of getting rid of boilerplate.

> +// SPDX-License-Identifier: GPL-2.0

-- 
Cordially
Philippe Ombredanne
