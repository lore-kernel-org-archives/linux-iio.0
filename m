Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35549 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751955AbcENQwn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 14 May 2016 12:52:43 -0400
Subject: Re: [PATCH 2/2 v6] iio: st_sensors: read surplus samples in trigger
To: Linus Walleij <linus.walleij@linaro.org>,
	Crestez Dan Leonard <leonard.crestez@intel.com>
References: <1462870813-24700-1-git-send-email-linus.walleij@linaro.org>
 <1462870813-24700-2-git-send-email-linus.walleij@linaro.org>
 <90802d98-c7bc-bc14-214c-0d1c3bf19b14@intel.com>
 <CACRpkda+MWGoO0OGzmk93B2JE97rbBvSF5yAy7pTPvTBCjFYug@mail.gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <3fcf8da4-da5b-f5ff-cb84-6fb0feddba34@kernel.org>
Date: Sat, 14 May 2016 17:52:40 +0100
MIME-Version: 1.0
In-Reply-To: <CACRpkda+MWGoO0OGzmk93B2JE97rbBvSF5yAy7pTPvTBCjFYug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/05/16 07:01, Linus Walleij wrote:
> On Tue, May 10, 2016 at 6:40 PM, Crestez Dan Leonard
> <leonard.crestez@intel.com> wrote:
>> [Me]
>>> ChangeLog v5->v6:
>>> - Add a loop counter to the threaded value poll function: let's
>>>   just loop here for at maximum 10 loops before we exit and
>>>   let the thread re-trigger if more interrupts arrived.
>>
>> This only serves to hide the problem.
> 
> Not really. The system can preempt after exiting the thread but
> before processing the next set of samples.
> 
>> Version 5 seems preferable. Or
>> even just adding msleep(10) in that infinite loop.
> 
> That provides a preemption point I guess but usleep_range()
> is usually preferrable for such cases. 10ms is way to long
> time to wait, because the max sample frequency will be
> 1/10ms = 100Hz and some ST sensors I have support
> 1kHz updates even. The usleep range would need to be
> very short.
These devices are getting slower in their old age - the venerable lis3l02dq
supports 4.48 kHz.

See the thread in response to Leonard's patch.  I 'fear' we may need a combination
of the two approaches.  Perhaps one of the ST guys can confirm these devices
really are doing level interrupts in all cases as it gets even more complex
if only some devices are...

> 
> Yours,
> Linus Walleij
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

