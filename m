Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41874 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754020Ab3HaPq3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 31 Aug 2013 11:46:29 -0400
Message-ID: <52221DE8.5050804@kernel.org>
Date: Sat, 31 Aug 2013 17:46:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Angelo Compagnucci <angelo.compagnucci@gmail.com>
CC: linux-iio@vger.kernel.org
Subject: Re: Advice on mcp3422 driver
References: <CA+TH9Vk+Z_iWoouy78Kny7qhVrD+3Z=-4KPjeL_Ju67YwskabA@mail.gmail.com> <278a3118-da34-4ef8-a834-ff6f5ecb2d76@email.android.com> <CA+TH9V=+X7s9RcshQ2u5aZATXOWt+VdscYzN0XLHmBHRhR9pmw@mail.gmail.com>
In-Reply-To: <CA+TH9V=+X7s9RcshQ2u5aZATXOWt+VdscYzN0XLHmBHRhR9pmw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/29/13 13:35, Angelo Compagnucci wrote:
> Hi Jonathan,
> 
> Thank you for your reply.
> 
> Ok, I understand your points.
> 
> So in my case scaling is composed by rawvalue*rates_to_lsb/pga, rate
> is setted by writing sampling frequency, pga is setted writing
> in_voltage_scale.
Sorry, just reread this and saw that I'd missed the key point you were raising.
Pga is set by writing in_voltage_scale, but not with the pga value but rather
with the general scale as a result of both the sampling frequency and the chosen
pga scale at the current sampling frequency.

Thus if a value is written and accepted to a sysfs attribute, the same value is
read back.

These interlinked controls can be a pain as you are discovering.  The golden
rule is that userspace should always reread all control attributes after ever write
as anything could in theory of changed.
> 
> 2013/8/29 Jonathan Cameron <jic23@kernel.org>:
>> Firstly keep this sort Of question on the list as it acts as a reference for others.
>>
>> Angelo Compagnucci <angelo.compagnucci@gmail.com> wrote:
>>> Hi Jonathan,
>>>
>>> I carefully read your last email and I have some doubts that I want to
>>> share with you.
>>> I carefully read the documentation and I read the source code for the
>>> most
>>> other adc drivers, but really cannot understand how it works the
>>> raw/scale
>>> duo.
>>>
>> >From my understanding I have to read the raw vale, read the scale
>>> value,
>>> make some math and have a final value.
>> Yes. That is correct
>>>
>>> So for the mcp3422 I should use rates_to_lsb as base and pga as a
>>> multiplier.
>>> I can select rates_to_lsb via sampling rate (because they are coupled)
>>> and select pga via in_voltageX_scale read/write operations.
>>>
>>> So what I have now is wrong, because I'm applying math in scale read,
>>> instead that should be done from userspace.
>>
>> The point is that scale should only change as a result of user intervention and so is considered a slow interface. The raw readings are a the fast path hence we keep that to the minimum. Note your scale maths can be implemented as a const lookup table.
>> I would be tempted to do it that way both for speed (not crucial) and simplicity of code.
>> Putting a comment in to explain the maths would make it clear where the magic numbers come from.
>>
>> You are right in that it would be nice to do this in user space but it is very difficult to come up with a clean abi that works in all cases!
>>>
>>> Am I wrong?
>>>
>>> Can you point me to a documentation to understand better?
>> Err. Nope our documentation is awful unfortunately.
>>>
>>> Thank you!
>>
>> --
>> Sent from my Android phone with K-9 Mail. Please excuse my brevity.
> 
> 
> 
