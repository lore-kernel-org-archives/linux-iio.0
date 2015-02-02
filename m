Return-Path: <lars@metafoo.de>
Message-ID: <54CF4CF9.1030708@metafoo.de>
Date: Mon, 02 Feb 2015 11:10:01 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Nicholas Mc Guire <der.herr@hofr.at>
CC: Nicholas Mc Guire <hofrat@osadl.org>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Peter Meerwald <pmeerw@pmeerw.net>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: ad_sigma_delta: cleanup wait_for_completion
 return handling
References: <1422866258-10517-1-git-send-email-hofrat@osadl.org> <54CF464F.9000306@metafoo.de> <20150202095002.GA28005@opentech.at>
In-Reply-To: <20150202095002.GA28005@opentech.at>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 02/02/2015 10:50 AM, Nicholas Mc Guire wrote:
> On Mon, 02 Feb 2015, Lars-Peter Clausen wrote:
>
>> On 02/02/2015 09:37 AM, Nicholas Mc Guire wrote:
>>> return type of wait_for_completion_timeout is unsigned long not int, rather
>>> than introducing a new variable the wait_for_completion_timeout is moved
>>> into the if condition as the return value is only used to detect timeout.
>>
>> But the return value is bound by the timeout parameter and we know that
>> fits into a int. And I really dont like moving the function call into the
>> if condition, so unless there is some additional explanation why this is
>> necessary and should be done I'm inclined to nack this.
>>
>
> well having correct types is important for all static code chekcers
> and I did not want to add a new variable just for this case
> simply because the result is only relevant in the == 0 case
> anyway.
>
> I do think that the types being assigned should correct with respect
> to the API definition even if it fits in this case.
>
>>>
>>> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
>>> ---
>>>
>>> Aside from the fixup of the wait_for_completion_timeout handling
>>> a minor coding style issue in the else branch was fixed - the {} is
>>> not needed for the one-line body.
>>
>> If one of the branches of a conditional statement has braces the other
>> branches should also have braces. This is documented in
>> Documentation/CodingStyle.
>
> my bad - it is not uncommon to be asymetric - but you are right that Chapter 3
> states it should not be asymetric in this case - will remove that.
>
> given the botched braces this needs to be redone - let me know if moving
> it into the condition is ok (its not uncommon) or if an additional variable
> of type unsigned long is the prefered solution.

I prefer the extra variable, but that's personal taste. And maybe add the 
stuff about the static code checker etc to the commit message.

Thanks,
- Lars
