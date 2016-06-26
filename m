Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47870 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554AbcFZQvJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jun 2016 12:51:09 -0400
Subject: Re: [PATCH v5 2/2] iio: ad5755: Add DT binding documentation
To: =?UTF-8?Q?Sean_Nyekj=c3=a6r?= <sean.nyekjaer@prevas.dk>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <1457705561-12253-1-git-send-email-sean.nyekjaer@prevas.dk>
 <1457705561-12253-2-git-send-email-sean.nyekjaer@prevas.dk>
 <56E3E121.9030400@kernel.org> <56F94A21.6070804@kernel.org>
 <8a7b1dcb-205a-8801-737f-6aa1c39f6605@prevas.dk>
 <8e62350f-ec4c-cba4-fa46-95549a89e720@kernel.org>
 <574AF8EB.9060609@metafoo.de>
 <b55cee8b-2966-d14f-3943-4a848876b43f@kernel.org>
 <851f081c-9a0a-eaa1-4d61-21e4e8d4c692@prevas.dk>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <2e2f572c-4560-fc8d-d92c-edb7ca2f620e@kernel.org>
Date: Sun, 26 Jun 2016 17:51:07 +0100
MIME-Version: 1.0
In-Reply-To: <851f081c-9a0a-eaa1-4d61-21e4e8d4c692@prevas.dk>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/06/16 06:04, Sean Nyekjær wrote:
> 
> 
> On 2016-06-11 19:26, Jonathan Cameron wrote:
>> On 29/05/16 15:12, Lars-Peter Clausen wrote:
>>> On 05/29/2016 03:57 PM, Jonathan Cameron wrote:
>>>> On 09/05/16 09:16, Sean Nyekjær wrote:
>>>>>
>>>>> On 2016-03-28 17:13, Jonathan Cameron wrote:
>>>>>> On 12/03/16 09:28, Jonathan Cameron wrote:
>>>>>>> On 11/03/16 14:12, Sean Nyekjaer wrote:
>>>>>>>> Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
>>>>>>> Looks much better to me.
>>>>>>>
>>>>>>> Looking for Acks from Lars and a device tree binding maintainer
>>>>>>> on this one though.
>>>>>>> (added CCs)
>>>>>> Lars?
>>>>> No response...
>>>>> Is there anything wrong with this?
>>>> Given we are early in cycle there is no real rush for this...
>>>>
>>>> Lars, let me know if you are going to a while getting to this / any other
>>>> patches I want responses on from you.
>>> I don't think this solution is the correct approach, but since I'm not able
>>> to provide an alternative and everybody else is OK with it, I'm not going to
>>> block it either. So go ahead and apply it.
>> Hmm. I've applied this now.  Perhaps we will revisit in the future and
>> eventually deprecate this binding in favour of something more generic.
>>
>> Thanks for your hard work on this Sean. It certainly wasn't a case
>> with obvious 'right' answers!
>>
>> Jonathan
> Hi Jonathan
> 
> Where is this applied, i can't seen to find it? :-)
> If it failed some test, please let me know...
Sorry should have said. Applied to the togreg branch of iio.git on
kernel.org, but... That gets initially pushed out as testing
for the autobuilders to play with it.

Basically it gives me a window with it as an 'unofficial' branch
so I can fix up an dumb stuff the autobuilders find.  There
is rather less of that these days as the autobuilders try patches
off the list.

Jonathan
> 
> /Sean

