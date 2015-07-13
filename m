Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34160 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753063AbbGMUua (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 13 Jul 2015 16:50:30 -0400
Message-ID: <55A42493.2040003@kernel.org>
Date: Mon, 13 Jul 2015 21:50:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Matt Ranostay <mranostay@gmail.com>
CC: =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: Multiple IIO_THRESHOLD events
References: <CAKzfze8sGEyU9DgDR4y2p3=5d+9024WgqgVw5fsv4b2XY1HH1g@mail.gmail.com>	<55A1594F.1060204@kernel.org> <CAKzfze-xEaRc5HWRCsZYS2+XVuZDtOs7-m_VsNpoeXbteL=NRQ@mail.gmail.com>
In-Reply-To: <CAKzfze-xEaRc5HWRCsZYS2+XVuZDtOs7-m_VsNpoeXbteL=NRQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/07/15 18:29, Matt Ranostay wrote:
> On Sat, Jul 11, 2015 at 10:58 AM, Jonathan Cameron <jic23@kernel.org> wrote:
>> On 09/07/15 18:23, Matt Ranostay wrote:
>>> Hello Jonathan,
>>>
>>> I am currently working on temperature sensor that has multiple trip
>>> points, and was wondering what would be the correct way to tie this to
>>> one channel if several events may have the same IIO_EV_DIR_*
>>> direction.
>>>
>>> low temp trippoint - > IIO_EV_DIR_FALLING
>>> high temp trippoint -> IIO_EV_DIR_RISING
>>> critical temp trippoint ->  ?
>>>
>>> Would it make sensor to add functionality to allow iio_event_spec to
>>> have an .index field so multiple IIO_EV_DIR_RISING could be parsed
>>> into sysfs entries?
>>>
>>>
>>> Thanks,
>>>
>>> Matt
>>>
>> Hi Matt,
>>
>> The few times this has come up before, the conclusion has been that
>> the device was actually more suited to have a hwmon driver than an IIO one.
>> We have had event units capable of being configured for this sort of operation
>> but have never actually implemented it.
> 
> Ok seems I could just mask that threshold since it is kinda redundant
> and would be more useful for a microcontroller using it.
> 
> However the other issue is there is a way of marking when entering a
> threshold and when exiting it.. I suppose that is again and event code
> change... This device triggers an interrupt when it enters and exits a
> threshold, and it would seem wrong to poll and report threshold events
> till it exited...
> 
> I suppose the following would be too crude to add the ABI?
Normally threshold interrupts are assumed to be edge triggered, hence
report a rising edge in one direction and a falling one in the other?

Though then we are back to having multiple thresholds on a channel.
Looks increasingly like we need to add support for this!

(increased cc list to get some more opinions on this).
> 
> IIO_EV_ENTER_THRESHOLD = 0,
> IIO_EV_EXIT_THRESHOLD,
> 
>>
>> You are quite correct in that we don't have a current way to support
>> it.  An index field and appropriate extension of the abi is fine.  However
>> you've also got to find somewhere in the event code to place it.
>> That's nastier from an ABI change point of view.
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

