Return-Path: <SRS0=NZ1f=H2=metafoo.de=lars@kernel.org>
Subject: Re: [PATCH] iio: potentiometer: add driver for Maxim Integrated
 DS1807
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
References: <1525613447-32734-1-git-send-email-michael@amarulasolutions.com>
 <20180506183745.325e67b8@archlinux>
 <96251f75-6a0b-9668-b103-8d2453bf8bba@metafoo.de>
Message-ID: <c9d22ad5-ba57-486a-fad9-7e1260dc2b62@metafoo.de>
Date: Mon, 7 May 2018 18:55:16 +0200
MIME-Version: 1.0
In-Reply-To: <96251f75-6a0b-9668-b103-8d2453bf8bba@metafoo.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 05/07/2018 06:44 PM, Lars-Peter Clausen wrote:
> On 05/06/2018 07:37 PM, Jonathan Cameron wrote:
>> On Sun,  6 May 2018 15:30:47 +0200
>> Michael Trimarchi <michael@amarulasolutions.com> wrote:
>>
>>> The following functions are supported:
>>> - write, read potentiometer value
>>>
>>> Value are exported in DBm because it's used as an audio
>>> attenuator
>>
>> This is interesting.  The problem is that there is no way for
>> userspace to know that it is reporting in DBm rather than
>> reporting a linear gain or a straight forward resistance.
>>
>> This is rather closer in operation to the analog front end
>> driver I took the other day than to the other potentiometers
>> we have drivers for.
>>
>> Anyhow, how to solve this?  Two options come to mind.
>> 1) Look up table mapping to linear gain as per current ABI
>> 2) Add a new channel type to represent the fact we are
>> looking at a logarithmic value, letting us handle it as DB.
> 
> Yeah, I guess it is a bit difficult. I don't think this should be a separate
> type since we are still describing the same thing, just the scale is
> logarithmic rather than linear. Translation table doesn't work either since
> your values would get ridiculous small/large. We could add a db suffix to
> the type, but that's just terrible. I guess the best we can do is have a
> scale attribute that says 1dB.

The other problem of course is that dB is a relative unit. The ratio of one
value to another. Whereas our normal scale refers to an absolute value.
