Return-Path: <jic23@cam.ac.uk>
Message-ID: <4EA15460.30405@cam.ac.uk>
Date: Fri, 21 Oct 2011 12:15:44 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 Michael.Hennerich@analog.com, device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH] staging:iio: header reorganization
References: <4EA13439.8060504@cam.ac.uk> <1319188148-32349-1-git-send-email-jic23@cam.ac.uk> <4EA14C87.2020606@metafoo.de> <4EA15092.1090408@cam.ac.uk>
In-Reply-To: <4EA15092.1090408@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 10/21/11 11:59, Jonathan Cameron wrote:
> On 10/21/11 11:42, Lars-Peter Clausen wrote:
>> On 10/21/2011 11:09 AM, Jonathan Cameron wrote:
>>> Issue brought up by Lars-Peter Clausen. This is a varient of what
>>> he suggested.
>>>
>>> io/iio.h for driver stuff (has to include types.h)
>>> 	Sub files for the bits drivers may or may not use
>>> 	iio/sysfs.h
>>> 	iio/buffer.h (contents of current buffer_generic.h)
>>> 	(obviously anything offering events will need events.h as well)
>>> iio/types.h for the enums that matter to both
>>> 	iio_chan_type, iio_modifier
>>> iio/events.h for the event code stuff
>>> 	IIO_EVENT_CODE and friends.  + everything in chrdev.h  So this
>>> 	is the stuff that userspace cares about.
>>> 	Also include iio_event_type, iio_event_direction
>>>
>>> Thus iio drivers include iio.h + as required
>>> events.h
>>> sysfs.h
>>> buffer.h
>>>
>>> in kernel users (once that interface is merged) will need inkern.h
>>> which will pull in types.h
>>>
>>> Userspace will need just events.h (which pulls in types.h) to get
>>> everything they need to know about.  Buffer userspace access doesn't
>>> currently need any core defines. All information about the data
>>> format is passed through sysfs.
>>
>> This seems to work nicely, thanks. There two minor issues left, but those
>> were also present before the restructuring, I'll send patches shortly.
>>
>> Another issue is that you can only open the iio character device if your
>> device has buffer support, so without buffer support no event support
>> either. Michael said that has been some discussion on this before, do you
>> remember the conclusions of that discussion?
> Drat. That isn't supposed to be the case.
> I guess my test parts almost all have buffers so I hadn't noticed this.
> We had a nasty reverse of this issue a while back which could cause
> segfaults so I slapped the protection in very quickly without thinking
> enough about it.
> 
> Check in iio_chrdev_buffer_open is clearly the problem. In case with no
> buffer should return 0 not -EINVAL.  That way the open will have done
> nothing.
> 
> Reads then return -ENODEV if there isn't a buffer or read isn't supplied
> if buffer support isn't there in the core.
> 
> It'll take me a few mins to test this. Given the tsl2563 just made my
> kernel dump in a random location. My favourite type of bug...
> 
Even better. It's a bug I'd actually fixed in the out of staging tree.
Gah. I really don't like this two tree thing. Way too confusing.
