Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <2532a6d4-f607-bfe9-dccf-2161aeb867a5@kernel.org>
References: <1472718439-16734-1-git-send-email-linus.walleij@linaro.org> <2532a6d4-f607-bfe9-dccf-2161aeb867a5@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 5 Sep 2016 14:41:35 +0200
Message-ID: <CACRpkdaMr9_h-hac25Bpe_gvVr_9P9hiogwWkpQ=R=UP6PzdWg@mail.gmail.com>
Subject: Re: [PATCH 1/3] iio: trigger: helpers to determine own trigger
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>, Crestez Dan Leonard <leonard.crestez@intel.com>,
	Gregor Boirie <gregor.boirie@parrot.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Sat, Sep 3, 2016 at 7:24 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 01/09/16 09:27, Linus Walleij wrote:
>> This adds a helper function to the IIO trigger framework:
>>
>> iio_trigger_using_own(): for an IIO device, this tells
>>   whether the device is using itself as a trigger.
>>   This is true if the indio device:
>>   (A) supplies a trigger and
>>   (B) has assigned its own buffer poll function to use this
>>       trigger.
>>
>> This helper function is good when constructing triggered,
>> buffered drivers that can either use its own hardware *OR*
>> an external trigger such as a HRTimer or even the trigger from
>> a totally different sensor.
>>
>> Under such circumstances it is important to know for example
>> if the timestamp from the same trigger hardware should be used
>> when populating the buffer: if iio_trigger_using_own() is true,
>> we can use this timestamp, else we need to pick a unique
>> timestamp directly in the trigger handler.
>>
>> For this to work of course IIO devices registering hardware
>> triggers must follow the convention to set the parent device
>> properly, as as well as setting the parent of the IIO device
>> itself.
>>
>> When a new poll function is attached, we check if the parent
>> device of the IIO of the poll function is the same as the
>> parent device of the trigger and in that case we conclude that
>> the hardware is using itself as trigger.
>>
>> Cc: Giuseppe Barba <giuseppe.barba@st.com>
>> Cc: Denis Ciocca <denis.ciocca@st.com>
>> Cc: Crestez Dan Leonard <leonard.crestez@intel.com>
>> Cc: Gregor Boirie <gregor.boirie@parrot.com>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> Looks good to me, but I'll hold back on this one until we
> have your driver in.
>
> Kick me if I forget about it.

It's fine to apply 1/3 and 2/3 already, it will improve the usecase
for the ST sensors. I will carry and/or squash 3/3 into the MPU-3050
driver in that case.

Yours,
Linus Walleij
