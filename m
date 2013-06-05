Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-243.synserver.de ([212.40.185.243]:1041 "EHLO
	smtp-out-243.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753657Ab3FESHg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 5 Jun 2013 14:07:36 -0400
Message-ID: <51AF7E60.50007@metafoo.de>
Date: Wed, 05 Jun 2013 20:07:28 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
	michael.hennerich@analog.com, linux-iio@vger.kernel.org,
	Lars-Peter.Clausen@analog.com, dan.carpenter@oracle.com
Subject: Re: [PATCH RESEND V2 3/4] iio: frequency: adf4350: Add support for
 clock consumer framework
References: <1370266249-26338-1-git-send-email-michael.hennerich@analog.com> <1370266249-26338-3-git-send-email-michael.hennerich@analog.com> <51AE277B.1070302@kernel.org> <51AEE974.3030000@analog.com> <51AF4A51.5090609@metafoo.de> <51AF5880.30008@jic23.retrosnub.co.uk> <51AF7694.9060604@metafoo.de> <51AF78B5.5000206@kernel.org>
In-Reply-To: <51AF78B5.5000206@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/05/2013 07:43 PM, Jonathan Cameron wrote:
> On 06/05/2013 06:34 PM, Lars-Peter Clausen wrote:
>> On 06/05/2013 05:25 PM, Jonathan Cameron wrote:
>>> On 05/06/13 15:25, Lars-Peter Clausen wrote:
>>>> On 06/05/2013 09:32 AM, Michael Hennerich wrote:
>>>>> On 06/04/2013 07:44 PM, Jonathan Cameron wrote:
>>>>>> On 06/03/2013 02:30 PM, michael.hennerich@analog.com wrote:
>>>>>>> From: Michael Hennerich <michael.hennerich@analog.com>
>>>>>>>
>>>>>>> Preferably get clkin (PLL reference clock) from clock framework
>>>>>>>
>>>>>>> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
>>>>>> ERROR: "clk_round_rate" [drivers/iio/frequency/adf4350.ko] undefined!
>>>>>> make[1]: *** [__modpost] Error 1
>>>>>>
>>>>>> on my arm test build. Sorry, I was being lazy before and hadn't done
>>>>>> any test builds till I tried merging it.  Backed out the merge of this
>>>>>> patch for now.
>>>>>>
>>>>>> clk.h does say that api is optional for machine classes.  No idea what you
>>>>>> want to
>>>>>> do about this.
>>>>>
>>>>> The CLK API is optional in the driver - so I prefer to keep it like that and
>>>>> don't make
>>>>> the driver depend on COMMON_CLK.
>>>>>
>>>>> The simplest and probably the best workaround is to guard the CLK Round/Set
>>>>> code with
>>>>> #if defined(CONFIG_COMMON_CLK).
>>>>>
>>>>> Thoughts?
>>>>>
>>>>
>>>> This is not a bug in the driver. If the clk API is not implemented it is
>>>> stubbed out. It looks as if Jonathan is testing on a platform which
>>>> implements the clk API but not clk_round_rate() (None of the other clk_*
>>>> symbols are undefined).
>>>>
>>>> Jonathan on which platform are you testing this?
>>> arm specifically pxa27x eabi
>>>>
>>
>> No clk_round_rate() in arch/arm/mach-pxa/clock.c
> Hmm.. Indeed.  So what does one do if one wants to use those functions?

I think the pxa implementation of the clk API is just broken in this regard.
The clk API requires you to implement all the functions declared in
include/linux/clk.h

- Lars
