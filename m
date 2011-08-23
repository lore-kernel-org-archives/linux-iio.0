Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:52363 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754988Ab1HWNds (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 23 Aug 2011 09:33:48 -0400
Message-ID: <4E53AE25.4040609@cam.ac.uk>
Date: Tue, 23 Aug 2011 14:41:57 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: malas <malas@tcoe.iitm.ac.in>
CC: "Hennerich, Michael" <Michael.Hennerich@analog.com>,
	linux-iio@vger.kernel.org
Subject: Re: ad7793 iio-ring test read issue - Reg
References: <20110823080829.M36921@tcoe.iitm.ac.in> <4E538D35.7090508@cam.ac.uk> <20110823112234.M44553@tcoe.iitm.ac.in> <544AC56F16B56944AEC3BD4E3D59177146E6D069A2@LIMKCMBX1.ad.analog.com> <20110823121352.M43006@tcoe.iitm.ac.in> <4E539F70.3060209@cam.ac.uk> <20110823123747.M17135@tcoe.iitm.ac.in> <4E53A3FA.7020700@cam.ac.uk> <20110823131000.M76209@tcoe.iitm.ac.in>
In-Reply-To: <20110823131000.M76209@tcoe.iitm.ac.in>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/23/11 14:24, malas wrote:
> On Tue, 23 Aug 2011 13:58:34 +0100, Jonathan Cameron wrote
>> On 08/23/11 13:43, malas wrote:
>>> YES : Gregs updated kernel taken from link below:
>>>
>>> http://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging-2.6.git
>> Right now that's pretty much mainline.
>>
>> See comments below and please reply inline as it makes this sort
>> of discussion much easier to follow.
>>>
>>>
>>> On Tue, 23 Aug 2011 13:39:12 +0100, Jonathan Cameron wrote
>>>> On 08/23/11 13:17, malas wrote:
>>>>>
>>>>>
>>>>> Sorry, I did not explicitly mention that. I did use the new staging kernel referred by
>>>>> Michael Hennerich and integrated with 2010RC5 uclinux dist .
>>>>
>>>> Hmm. As in current contents of Greg KH's staging/staging-next?
>>>>
>>>> I'll assume so... See below.
>>>>
>>>>>
>>>>> On Tue, 23 Aug 2011 12:39:53 +0100, Hennerich, Michael wrote
>>>>>> malas wrote on 2011-08-23:
>>>>>>>
>>>>>>>
>>>>>>> Dear Jonathan Cameron,
>>>>>>>
>>>>>>> The kernel version I am using is :
>>>>>>
>>>>>> Didn't you say that you use the staging kernel?
>>>>>>
>>>>>>
>>>>>
>>>
> http://blackfin.uclinux.org/gf/project/uclinux-dist/forum/?_forum_action=MessageReply&message_id=102839&action=ForumBrowse
>>>>>>
>>>>>> Or copied drivers/staging/iio over to your Blackfin kernel tree?
>>>>>>
>>>>>>>
>>>>>>> ---------------------------------------------------------------------
>>>>>>> midas@ubuntu:~/Mala/Telemedicine/uclinux_source/uc2010_source/uclinux/2
>>>>>>> 010R1$ svn info Path: . URL:
>>>>>>> svn://blackfin.uclinux.org/uclinux-dist/branches/2010R1 Repository Root:
>>>>>>> svn://blackfin.uclinux.org/uclinux-dist Repository UUID:
>>>>>>> 3e2a5524-39e8-4cb9-84a9-c49da69cba3a Revision: 10161 Node Kind:
>>>>>>> directory Schedule: normal Last Changed Author: vapier Last Changed Rev:
>>>>>>> 10136 Last Changed Date: 2011-04-02 22:36:15 +0530 (Sat, 02 Apr 2011)
>>>>>>> ---------------------------------------------------------------------
>>>>>>>
>>>>>>> Regards
>>>>>>> Mala
>>>>>>>
>>>>>>> On Tue, 23 Aug 2011 12:21:25 +0100, Jonathan Cameron wrote
>>>>>>>> On 08/23/11 09:18, malas wrote:
>>>>>>>>>
>>>>>>>>> Dear Michael Hennerich,
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> I shall post iio quesris in this mail list as per your suggestions.
>>>>>>>>>
>>>>>>>>> AD7793 driver is built into kernel. The chip gets configured and am
>>>>>>>>> able to read data on continuous mode via spi interface using ad7793
>>>>>>>>> driver at kernel level.
>>>>>>>>>
>>>>>>>>> While testing userspace test iio-ring to read data from ring buffer,
>>>>>>>>> generic_buffer code was executed, it  proceeds till opening
>>>>>>>>> /sys/bus/iio/devices/device0:buffer0 and Read call fails.
>>>>>>>> Question 1: What's the kernel and where did you get it from?
>>>>>>>> (Interfaces are moving fast so it's plausible you've fallen in a hole
>>>>>>>> where userspace wasn't matching kernelspace).
>>>>>>>>>
>>>>>>>>> In fs I can list the iio device ad7793 with following properties
>>>>>>>>> get/set.
>>>>>>>>>
>>>>>>>>> root:/> ls /sys/bus/iio/devices/device0\:buffer0/
>>>>>>>>> bytes_per_datum  enable           power            subsystem
>>>>>>>>> dev              length           scan_elements    uevent
>>>>>>>>> root:/>
>>>>>>>>>
>>>>>>>>> I find access0 and event0 missing in this list. Is that the reason
>>>>>>> for read() fails.
>>>>>>>> Yes.  Question is why and without kernel version I don't know where to
>>>>>>>> look I'm afraid.
>>>> Ah, this does look like a missmatch in interfaces between userspace and kernel.
>>>>
>>>> At this point in time we have scrapped the event0 chrdev (done via polling on
>>>> the access one) and the access one has be flattened into device0\:buffer0/
>>>> (read dev).
>>>>
>>>> Looks like the generic_buffer.c example does line up though. Where did the
>>>> 'test iio-ring' come from? Is that one yours Michael? 
> 
> 
> iio-ring.c under uclinux2010/user/blkfin-test/iio-ring-test. The file is in the
> attached. I did not use that since i didn't find access0 or event0 files under
> /sys/bus/iio/devices/device0:buffer0.
> 
> I have tested with the generic_buffer.c example (under iio/documentaion folder) to get
> Ad7793 received samples to user space from ring buffer.
> The app opens: /dev/device0:buffer0 for poll and reading samples.
> Is the device name for the open() correct.
Yes - that should be right.


