Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:47597 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751669AbdEVFho (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 22 May 2017 01:37:44 -0400
Subject: Re: spear_adc driver help needed ?
To: Jonathan Cameron <jic23@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
References: <20170518094146.6504821a@free-electrons.com>
 <73991880-8585-95a3-3d67-6544717c1264@kernel.org>
Cc: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>
From: Stefan Roese <sr@denx.de>
Message-ID: <47f2b9d4-ed21-2e4a-b637-9ad46b8e89c4@denx.de>
Date: Mon, 22 May 2017 07:37:40 +0200
MIME-Version: 1.0
In-Reply-To: <73991880-8585-95a3-3d67-6544717c1264@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21.05.2017 16:33, Jonathan Cameron wrote:
> On 18/05/17 08:41, Thomas Petazzoni wrote:
>> Hello Jonathan,
>>
>> I've been working on a SPEAr600 platform recently, which uses the
>> spear_adc driver, and was about to start working on moving the driver
>> out of staging... only to discover in 4.12-rc1 that you already moved
>> it out of staging.
> Yeah, this one hit the question of:
> Is it is good enough to move it or should we bin it as no improvements are
> really happening and no one seems to have one?
>
> I went with the it's good enough option being an optimist.
>>
>> In the commit log that moves it out of staging, you're saying:
>>
>>      There are some unanswered questions due to disagreements between
>> the code
>>      and various datasheets (including between different datasheets
>> for the same
>>      part).
>>           I don't think that is necessarily a reason to keep it in
>> staging however.
>>      I'm partly posting this patch inorder to reignite debate and with
>> a bit
>>      of luck find someone who has one of these to test!
>>
>> What are the unanswered questions you are talking about?
> These all came up in the previous attempt to move the driver out of staging
> back in 2014
>
> http://www.spinics.net/lists/linux-iio/msg12443.html
> In particular the results of Harmut tracking down a datahsheet and going
> through some elements of it in detail.
>>
>> Also, I am currently using the driver on a SPEAr600 device, so I can do
>> some testing.
> Cool.
>>
>> The driver has support for the SPEAr3xx, but it isn't used anywhere:
>> there is no compatible string for it, and nowhere is old-style probing
>> used for "spear-adc".
> Stefan (cc'd) might know who is likely to be using it...
>
> However after a bit of digging in the history, his original patch said
> that it was untested and proper support might eventually be added.

This is also my understanding (that's so looong ago, sorry). Somebody
suggested / requested to add support support for SPEAr3xx to this
driver as well. I definitely never tested it on this platform and don't
remember anybody who did.

>>
>> So I'm thinking of:
>>
>>   - Dropping SPEAr3xx support, because it's unused. This will also
>>     remove the ugly checks done on the compatible string all over the
>>     place.
> I agree.
>>
>>   - Moving to a "base + offset" style of register accesses, rather than
>>     the struct-based accesses.
> Yeah, with the 3xx stuff gone that would tidy things up further.
>
> Only exception would be if someone rapidly jumps up and down and says
> they use the 3xx support as is or have working patches they were aiming to
> submit to make it work.
>
> Thanks for working on this.  I'd forgotten that stuff was even in there!
>>
>> What do you think ?
> Would be great to tidy this up, particularly as it sounds like there
> are actually users.   Sometimes I wonder on some of the stuff I've
> lifted out of staging over the years ;)

 From the history above, its quite likely that this driver has never
been tested / used on SPEAr3xx. So I vote for dropping this support.

Thanks,
Stefan
