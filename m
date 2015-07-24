Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-122.synserver.de ([212.40.185.122]:1084 "EHLO
	smtp-out-122.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752654AbbGXMwG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 24 Jul 2015 08:52:06 -0400
Message-ID: <55B234F2.1080200@metafoo.de>
Date: Fri, 24 Jul 2015 14:52:02 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>
Subject: Re: IIO : Clarifying review tags.
References: <55ABBFE8.4090108@kernel.org> <55AC0079.9060507@gmx.de> <2316DF05-CDDA-4911-B573-2599579211C4@jic23.retrosnub.co.uk>
In-Reply-To: <2316DF05-CDDA-4911-B573-2599579211C4@jic23.retrosnub.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/19/2015 11:23 PM, Jonathan Cameron wrote:
[...]
>>> (and it's this last bit that lets the Linux development
>>> process scale).  There is a pretty universal view that
>>> you don't bother with both signed-off-by and any other tag
>>> (though tested-by can be appropriate in my view).
>>>
>> <...>
>>
>> I'm fine with the Acked-by and Tested-by stuff.
>>
>>> Reviewed-by:
>>> 	Now this is the one that caused most discussion in the
>>> previously mentioned thread.  When is it appropriate?
>>>
>>> 1) When substantial work has been applied as part of a review.
>>>     This might be indicated by a series of suggested changes
>>>     or by detailed comments on what they think is good / bad
>>>     might be done differently.   In these cases the reviewer
>>>     may 'suggest' the tag themselves.
>>>
>>> 2) Where earlier versions of a patch have received substantial
>>>     review but the reviewer has not commented on the latest
>>>     version.  In this case some maintainers have been giving
>>>     'Reviewed-by' tags to people who haven't supplied them
>>>     on their own.  This is the change I would like to make to
>>>     how I have done things previously (where when I had time
>>>     I pestered people to give a reviewed-by).
>>>
>>>     A few of you delight in early stage reviews and I feel often
>>>     get little or no permanent credit for your hard work.
>>>     In particular there are some here who spend a lot of time
>>>     helping new submitters get large patches in order.  A job
>>>     that can take a huge amount of work on occasion!
>>>
>>>     So does anyone object if I sometimes add Reviewed-by tags
>>>     for them?  Obviously this is all going to be a little
>>>     arbitrary so do keep sending them directly (and authors
>>>     keep adding them to later versions of your patches!)
>>>
>>
>> I'm in favor of using the Reviewed-by tag rather restrictive.
>> IMHO it expresses that the reviewer was able to understand the
>> change in its full extend. This may include to check all
>> device specific parameters used against a data sheet (if the
>> data sheet is not available due to NDA, then I would not want
>> to give this tag), check each line of code, check fixes against
>> the source code block it applies to (or even parent level
>> blocks if required). As a result, it should indicate that the
>> patch has successfully passed certain quality checks of the
>> reviewer. This in turn gives appreciaction to the patch author.
>> The reviewers reputation however can suffer, if significant
>> bugs slipped through the review. That's why I don't feel too
>> comfortable if anyone else gives reviewed-by tags in my name.
>> Clearly, there is a gap in between the acked-by and reviewed-by
>> tags, something that would express your contribution in the
>> development process.
>
> Interesting to hear. I will refrain from adding such tags given both your
>   response and Dan's.  Dan suggested in the mega thread an explicit
>   acknowledgement of a bug sported in a review. This would be applies as a kind of
>   'thanks' from the author to later versions without carrying any weight wrt to the
>   rest of the patch being good.

Yeah, I understand your reasoning, but I too feel a bit uncomfortable having 
other people add tags for me in my name. It's a bit like telling somebody to 
sign something in your name and forge your signature.

I'm a bit more easy when it comes to giving Reviewed-by tags than Hartmut 
though. If the driver looks sane from a API/ABI point I'll be ok with it. It 
is the driver author's task of making sure that the driver writes the right 
bits to the right registers.

>
> I was kind of fishing for opinions with this email. Good to get some!
>>
>>> Anyhow, the thread that lead to this has yet again reminded
>>> me of how lucky I am and we all are in IIO wrt to the quality
>>> and quantity of reviewers who put huge amounts of time into
>>> improving all our code!
>>>
>>> I certainly know I would have burnt out long ago if it was
>>> just me against the mountain.
>>>
>>> I'm going to be on holiday week after next. Should get back
>>> to normal in early August.

Enjoy your well deserved vacation and don't read/write so many emails ;)

- Lars

