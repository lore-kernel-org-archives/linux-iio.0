Return-Path: <lars@metafoo.de>
Message-ID: <51AF7694.9060604@metafoo.de>
Date: Wed, 05 Jun 2013 19:34:12 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
CC: michael.hennerich@analog.com, Jonathan Cameron <jic23@kernel.org>,
 linux-iio@vger.kernel.org, Lars-Peter.Clausen@analog.com,
 dan.carpenter@oracle.com
Subject: Re: [PATCH RESEND V2 3/4] iio: frequency: adf4350: Add support for
 clock consumer framework
References: <1370266249-26338-1-git-send-email-michael.hennerich@analog.com> <1370266249-26338-3-git-send-email-michael.hennerich@analog.com> <51AE277B.1070302@kernel.org> <51AEE974.3030000@analog.com> <51AF4A51.5090609@metafoo.de> <51AF5880.30008@jic23.retrosnub.co.uk>
In-Reply-To: <51AF5880.30008@jic23.retrosnub.co.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 06/05/2013 05:25 PM, Jonathan Cameron wrote:
> On 05/06/13 15:25, Lars-Peter Clausen wrote:
>> On 06/05/2013 09:32 AM, Michael Hennerich wrote:
>>> On 06/04/2013 07:44 PM, Jonathan Cameron wrote:
>>>> On 06/03/2013 02:30 PM, michael.hennerich@analog.com wrote:
>>>>> From: Michael Hennerich <michael.hennerich@analog.com>
>>>>>
>>>>> Preferably get clkin (PLL reference clock) from clock framework
>>>>>
>>>>> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
>>>> ERROR: "clk_round_rate" [drivers/iio/frequency/adf4350.ko] undefined!
>>>> make[1]: *** [__modpost] Error 1
>>>>
>>>> on my arm test build. Sorry, I was being lazy before and hadn't done
>>>> any test builds till I tried merging it.  Backed out the merge of this
>>>> patch for now.
>>>>
>>>> clk.h does say that api is optional for machine classes.  No idea what you
>>>> want to
>>>> do about this.
>>>
>>> The CLK API is optional in the driver - so I prefer to keep it like that and
>>> don't make
>>> the driver depend on COMMON_CLK.
>>>
>>> The simplest and probably the best workaround is to guard the CLK Round/Set
>>> code with
>>> #if defined(CONFIG_COMMON_CLK).
>>>
>>> Thoughts?
>>>
>>
>> This is not a bug in the driver. If the clk API is not implemented it is
>> stubbed out. It looks as if Jonathan is testing on a platform which
>> implements the clk API but not clk_round_rate() (None of the other clk_*
>> symbols are undefined).
>>
>> Jonathan on which platform are you testing this?
> arm specifically pxa27x eabi
>>

No clk_round_rate() in arch/arm/mach-pxa/clock.c

- Lars
