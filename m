Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50002 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751916AbdJYR3A (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 25 Oct 2017 13:29:00 -0400
Subject: Re: iio/accel/bmc150: Improve unlocking of a mutex in two functions
To: SF Markus Elfring <elfring@users.sourceforge.net>,
        linux-iio@vger.kernel.org
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <66d582a4-a77e-cd78-4215-49587ec2259e@users.sourceforge.net>
 <fb223eb2-ddab-396e-372e-e9496be8bf0f@redhat.com>
 <c32ea2ea-5961-6589-6b51-1184d9565a38@users.sourceforge.net>
 <6a2c614a-4d0d-f2d2-1689-4c67a2fc3eea@redhat.com>
 <7a76d804-797c-8a7f-a755-9e42f9157287@users.sourceforge.net>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <26467a3c-00e7-7358-5087-bf35469feb06@redhat.com>
Date: Wed, 25 Oct 2017 19:28:57 +0200
MIME-Version: 1.0
In-Reply-To: <7a76d804-797c-8a7f-a755-9e42f9157287@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

On 25-10-17 18:58, SF Markus Elfring wrote:
>> If that is the only unlock in the function, then it is probably
>> best to keep things as is. In general gotos are considered
>> better then multiple unlocks, but not having either is
>> even better.
> 
> Thanks for your quick feedback.
> 
> 
>>> How do you think about to use the following code variant then?
>>>
>>>      if (!ret)
>>>          ret = IIO_VAL_INT;
>>
>>
>> I believe the goto unlock variant and setting ret = IIO_VAL_INT;
>> directly above the unlock label variant is better,
> 
> I would prefer the approach above so that an extra goto statement
> could also be avoided before.

Usually code in a function follows a pattern of:

	err = step1()
	if (err)
		handle-err


	err = step2()
	if (err)
		handle-err


	err = step3()
	if (err)
		handle-err

What you are suggesting breaks this pattern (not
using a goto in the last if (err) case) which makes
the code harder to read and makes things harder
(and potentially leads to introducing bugs) when
a step4() gets added.

>> because that way the error handling is consistent between all steps
>> and if another step is later added at the end, the last step will
>> not require modification.
> 
> Do any more contributors insist on such a code layout?

There definitely is some personal preference involved here,
but I do believe that consistency is more important then
saving a goto here.

>>> How long should I wait for corresponding feedback before another small
>>> source code adjustment will be appropriate?
>>
>> That is hard to say.
> 
> I am just curious on how we can achieve progress here.
> 
> 
>> I usually just do a new version when I've time,
> 
> This is generally fine.
> 
> 
>> seldomly someone complains I should have waited longer for feedback
>> (when I'm quite quick) but usually sending out a new version as soon
>> as you've time to work on a new version is best, since if you wait
>> you may then not have time for the entire next week or so, at least
>> that is my experience :)  There is really no clear rule here.
> 
> I asked also because other well-known contributors showed strong
> reactions for this change pattern (with the help of a script
> for the semantic patch language).
> Would you care for similar updates in source files like the following?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/iio/accel/kxcjk-1013.c?id=1540d0106bcbc4e52013d759a0a0752ae7b4a09d#n760

So I just checked this one, this one is tricky because the
lock is taking inside a switch-case and doing gotos inside
the case is not pretty. If I were to refactor this, I would
add an "if (mask == IIO_CHAN_INFO_SCALE) {}" block to
handle the unlocked scale case and then take the lock around
the entire switch-case, using breaks on error to jump to
the unlock after the switch-case without needing gotos.

To me this seems the right thing here, since the scale is
special here in that it does not need locking. Or optionally
one can just take the lock for scale regardless, it won't
hurt (much).

Basically I believe there is no one-size fits all solution
here and refactoring like this may introduce bugs, so one
needs to weight the amount of work + regression risk vs
the benefits of the code being cleaner going forward.

Regards,

Hans



> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/iio/accel/stk8312.c?id=36ef71cae353f88fd6e095e2aaa3e5953af1685d#n432
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/iio/adc/palmas_gpadc.c?id=36ef71cae353f88fd6e095e2aaa3e5953af1685d#n304
> 
> Regards,
> Markus
> 
