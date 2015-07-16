Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:34993 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754643AbbGPCnS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 15 Jul 2015 22:43:18 -0400
Received: by igcqs7 with SMTP id qs7so3941180igc.0
        for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2015 19:43:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <55A42493.2040003@kernel.org>
References: <CAKzfze8sGEyU9DgDR4y2p3=5d+9024WgqgVw5fsv4b2XY1HH1g@mail.gmail.com>
	<55A1594F.1060204@kernel.org>
	<CAKzfze-xEaRc5HWRCsZYS2+XVuZDtOs7-m_VsNpoeXbteL=NRQ@mail.gmail.com>
	<55A42493.2040003@kernel.org>
Date: Wed, 15 Jul 2015 19:43:18 -0700
Message-ID: <CAKzfze8n+eNa2o7c3Bmd+rP7p_CPS90xicO0z2Wewsw9wGm_aw@mail.gmail.com>
Subject: Re: Multiple IIO_THRESHOLD events
From: Matt Ranostay <mranostay@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Would be reporting a IIO_EV_DIR_NONE a too crude way to say a
threshold is being exited for now?


Thanks,

Matt

On Mon, Jul 13, 2015 at 1:50 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 13/07/15 18:29, Matt Ranostay wrote:
>> On Sat, Jul 11, 2015 at 10:58 AM, Jonathan Cameron <jic23@kernel.org> wrote:
>>> On 09/07/15 18:23, Matt Ranostay wrote:
>>>> Hello Jonathan,
>>>>
>>>> I am currently working on temperature sensor that has multiple trip
>>>> points, and was wondering what would be the correct way to tie this to
>>>> one channel if several events may have the same IIO_EV_DIR_*
>>>> direction.
>>>>
>>>> low temp trippoint - > IIO_EV_DIR_FALLING
>>>> high temp trippoint -> IIO_EV_DIR_RISING
>>>> critical temp trippoint ->  ?
>>>>
>>>> Would it make sensor to add functionality to allow iio_event_spec to
>>>> have an .index field so multiple IIO_EV_DIR_RISING could be parsed
>>>> into sysfs entries?
>>>>
>>>>
>>>> Thanks,
>>>>
>>>> Matt
>>>>
>>> Hi Matt,
>>>
>>> The few times this has come up before, the conclusion has been that
>>> the device was actually more suited to have a hwmon driver than an IIO one.
>>> We have had event units capable of being configured for this sort of operation
>>> but have never actually implemented it.
>>
>> Ok seems I could just mask that threshold since it is kinda redundant
>> and would be more useful for a microcontroller using it.
>>
>> However the other issue is there is a way of marking when entering a
>> threshold and when exiting it.. I suppose that is again and event code
>> change... This device triggers an interrupt when it enters and exits a
>> threshold, and it would seem wrong to poll and report threshold events
>> till it exited...
>>
>> I suppose the following would be too crude to add the ABI?
> Normally threshold interrupts are assumed to be edge triggered, hence
> report a rising edge in one direction and a falling one in the other?
>
> Though then we are back to having multiple thresholds on a channel.
> Looks increasingly like we need to add support for this!
>
> (increased cc list to get some more opinions on this).
>>
>> IIO_EV_ENTER_THRESHOLD = 0,
>> IIO_EV_EXIT_THRESHOLD,
>>
>>>
>>> You are quite correct in that we don't have a current way to support
>>> it.  An index field and appropriate extension of the abi is fine.  However
>>> you've also got to find somewhere in the event code to place it.
>>> That's nastier from an ABI change point of view.
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
