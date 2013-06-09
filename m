Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:54862 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732Ab3FISRt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 9 Jun 2013 14:17:49 -0400
Message-ID: <51B4C6CC.7070904@kernel.org>
Date: Sun, 09 Jun 2013 19:17:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
	michael.hennerich@analog.com, linux-iio@vger.kernel.org,
	Lars-Peter.Clausen@analog.com, dan.carpenter@oracle.com
Subject: Re: [PATCH RESEND V2 3/4] iio: frequency: adf4350: Add support for
 clock consumer framework
References: <1370266249-26338-1-git-send-email-michael.hennerich@analog.com> <1370266249-26338-3-git-send-email-michael.hennerich@analog.com> <51AE277B.1070302@kernel.org> <51AEE974.3030000@analog.com> <51AF4A51.5090609@metafoo.de> <51AF5880.30008@jic23.retrosnub.co.uk> <51AF7694.9060604@metafoo.de> <51AF78B5.5000206@kernel.org> <51AF7E60.50007@metafoo.de> <51AF9D2F.4000302@kernel.org> <51B09F92.3060201@metafoo.de> <51B2F24F.8080605@kernel.org>
In-Reply-To: <51B2F24F.8080605@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/08/2013 09:58 AM, Jonathan Cameron wrote:
> On 06/06/2013 03:41 PM, Lars-Peter Clausen wrote:
>> On 06/05/2013 10:18 PM, Jonathan Cameron wrote:
>>> On 06/05/2013 07:07 PM, Lars-Peter Clausen wrote:
>>>> On 06/05/2013 07:43 PM, Jonathan Cameron wrote:
>>>>> On 06/05/2013 06:34 PM, Lars-Peter Clausen wrote:
>>>>>> On 06/05/2013 05:25 PM, Jonathan Cameron wrote:
>>>>>>> On 05/06/13 15:25, Lars-Peter Clausen wrote:
>>>>>>>> On 06/05/2013 09:32 AM, Michael Hennerich wrote:
>>>>>>>>> On 06/04/2013 07:44 PM, Jonathan Cameron wrote:
>>>>>>>>>> On 06/03/2013 02:30 PM, michael.hennerich@analog.com wrote:
>>>>>>>>>>> From: Michael Hennerich <michael.hennerich@analog.com>
>>>>>>>>>>>
>>>>>>>>>>> Preferably get clkin (PLL reference clock) from clock framework
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
>>>>>>>>>> ERROR: "clk_round_rate" [drivers/iio/frequency/adf4350.ko] undefined!
>>>>>>>>>> make[1]: *** [__modpost] Error 1
>>>>>>>>>>
>>>>>>>>>> on my arm test build. Sorry, I was being lazy before and hadn't done
>>>>>>>>>> any test builds till I tried merging it.  Backed out the merge of this
>>>>>>>>>> patch for now.
>>>>>>>>>>
>>>>>>>>>> clk.h does say that api is optional for machine classes.  No idea what you
>>>>>>>>>> want to
>>>>>>>>>> do about this.
>>>>>>>>>
>>>>>>>>> The CLK API is optional in the driver - so I prefer to keep it like that and
>>>>>>>>> don't make
>>>>>>>>> the driver depend on COMMON_CLK.
>>>>>>>>>
>>>>>>>>> The simplest and probably the best workaround is to guard the CLK Round/Set
>>>>>>>>> code with
>>>>>>>>> #if defined(CONFIG_COMMON_CLK).
>>>>>>>>>
>>>>>>>>> Thoughts?
>>>>>>>>>
>>>>>>>>
>>>>>>>> This is not a bug in the driver. If the clk API is not implemented it is
>>>>>>>> stubbed out. It looks as if Jonathan is testing on a platform which
>>>>>>>> implements the clk API but not clk_round_rate() (None of the other clk_*
>>>>>>>> symbols are undefined).
>>>>>>>>
>>>>>>>> Jonathan on which platform are you testing this?
>>>>>>> arm specifically pxa27x eabi
>>>>>>>>
>>>>>>
>>>>>> No clk_round_rate() in arch/arm/mach-pxa/clock.c
>>>>> Hmm.. Indeed.  So what does one do if one wants to use those functions?
>>>>
>>>> I think the pxa implementation of the clk API is just broken in this regard.
>>>> The clk API requires you to implement all the functions declared in
>>>> include/linux/clk.h
>>> Not according to the header it doesn't.
>>>
>>> /*
>>>  * The remaining APIs are optional for machine class support.
>>>  */
>>>
>>> Just above clk_round_rate
>>>
>>> Odd situation admittedly but the header certainly implies that these do
>>> not 'need' to be implemented.
>>
>> It should at least be stubbed out, otherwise this doesn't make too much sense.
>>
>> - Lars
>>
> So as not to step on any toes I've raised the issue on lkml and the arm kernel
> list.
> 
> My personal feeling is that architectures should just implement a stub returning
> an error code to indicate it isn't available but we will see what
> others think.
> 
A fix is on its way for my test platform so given that everyone acknowledges that
these functions are no longer optional, I've applied this patch to the togreg
branch of iio.git.  Sorry for the delay.  Will be interesting to see if there
any other subarchs that are missing this.

Jonathan
> Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
