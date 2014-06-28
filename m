Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:44407 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751200AbaF1QqN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 28 Jun 2014 12:46:13 -0400
Message-ID: <53AEF154.6010303@linux.intel.com>
Date: Sat, 28 Jun 2014 09:46:12 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] raw read performance improvement
References: <1403829626-17660-1-git-send-email-srinivas.pandruvada@linux.intel.com> <53AE8186.8040707@kernel.org> <53AEC02F.5040301@linux.intel.com> <53AECDC4.7070407@kernel.org>
In-Reply-To: <53AECDC4.7070407@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


On 06/28/2014 07:14 AM, Jonathan Cameron wrote:
> On 28/06/14 14:16, Srinivas Pandruvada wrote:
>>
>> On 06/28/2014 01:49 AM, Jonathan Cameron wrote:
>>> On 27/06/14 01:40, Srinivas Pandruvada wrote:
>>>> We see several performance issues reading individual axis, when
>>>> raw read is the only option. Since most of the time user space 
>>>> reads x, y
>>>> and z, one after other, this results in three sysfs reads, and 
>>>> based on
>>>> chipset we have to power up or set up measurement mode and wait for
>>>> response.
>>> That's probably a case for a change in the driver to schedule the power
>>> down for a little period after the read rather than immediately...
>> Agree, if we can do that. But some chips have a single measurement mode,
>> after measurement is done they go to sleep mode, like AK8975 (they
>> do have other modes with power penalty).
>>>> For example reading x,y and z takes 160ms for ak8975, it is true for
>>>> other too. But reading together takes only 80ms.
>>>>
>>>> IIO types already defined a modifier for X_AND_Y_AND_Z, which is used
>>>> by one driver to send event code. This modifier has no value assigned
>>>> so (null) appears in sysfs. If this is not correct then we may need
>>>> another modifier.
>>>>
>>>> Since we have now raw_read with capability to read multiple values,
>>>> we can use this callback to return values to iio core.
>>>>
>>> I've actually argued fairly strongly against this sort of multiple
>>> channel simply because it means there are multiple ways of 
>>> presenting the
>>> same data in the ABI. The big difference with the Quaternion case is 
>>> that
>>> the elements of that have no meaning whatsoever if you don't have them
>>> all.
>>>
>>> Previously any indication that people wanted higher performance reads
>>> would mean that I'd just tell them that is what the chardev interface
>>> is for.  Here a simple sysfs trigger and a couple of extra lines in the
>>> driver and you'd have what you want with considerably less overhead.
>> But using these I/F, you loose IIO ABI advantage for user space. This 
>> was
>> the model followed and still followed by, but requires special user 
>> space changes
>> for every sensor driver. With IIO model, we let vendors pick their 
>> components
>> as long as they have an IIO driver, with no change in user space.
> I'm unclear by why this needs special purpose userspace.
> Generally it's trivial to establish if a part supplies it's own
> trigger (data ready for example). If not then a sysfs trigger
> or similar is needed and can be instantiated just fine by
> generic userspace.
I misunderstood your comment. We always provide the buffer I/F, where we 
have
some data ready interrupts. In this case we are fine. We don't have 
sysfs triggers,
which, I should try to check how much time I can save.
>>>
>>> Hence my initial thought to this patch is that I'm not keen. However,
>>> lets let it sit for a while and see what other comments people have.
>>> Perhaps if there is enough demand I might rethink my position.
>>>
>> Let's see, I feel that it will help for phone/tablet like power 
>> sensitive devices but doemands performance.
> Sure - though you are never going to get significant performance through
> sysfs interfaces...  They just aren't intended for that purpose. Last
> thing we want to do is convert back and forwards from a string for 
> starters!
I am not talking about bandwidth limitation from user/kernel interface, 
which sysfs is not designed for.
We have better options than even char-dev for that purpose.

I understand your point of providing a single way to present data. This 
change breaks this assumption. If someone else needs,
we can discuss again.

Thanks,
Srinivas

>
> J
>>
>> Thanks,
>> Srinivas
>>
>>> Jonathan
>>>> Srinivas Pandruvada (2):
>>>>    iio: core: add xyz modifier value
>>>>    iio: magnetometer: ak8975: Improve performance of raw reads
>>>>
>>>>   drivers/iio/industrialio-core.c   |  1 +
>>>>   drivers/iio/magnetometer/ak8975.c | 58 
>>>> ++++++++++++++++++++++++++-------------
>>>>   2 files changed, 40 insertions(+), 19 deletions(-)
>>>>
>>>
>>>
>>
>
>

