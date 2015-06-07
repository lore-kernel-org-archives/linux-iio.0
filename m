Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47566 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734AbbFGPnE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 7 Jun 2015 11:43:04 -0400
Message-ID: <55746686.4090301@kernel.org>
Date: Sun, 07 Jun 2015 16:43:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Matt Ranostay <mranostay@gmail.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: IIO_GESTURE proposal
References: <CAKzfze8qX0WEKmHgBKKVvw-=mzFOUVSQnOXXxjUPdm=BafoYqA@mail.gmail.com>	<556DF5D8.9080000@kernel.org>	<CAKzfze82kYZi6jxiQV_b+=-rQJzbYbO8-kb=2gMEZr=3xeSVEA@mail.gmail.com> <CAKzfze_o+muj2KTF=9Hy3z7JTUN3Q-4_uw2jWmoTUDxKxFjQ+w@mail.gmail.com>
In-Reply-To: <CAKzfze_o+muj2KTF=9Hy3z7JTUN3Q-4_uw2jWmoTUDxKxFjQ+w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/06/15 17:44, Matt Ranostay wrote:
> Jonathan,
> 
> Doing some thinking over the last couple days, and need some additional input.
> 
> 1) Do IIO_MOD_DIRECTION{UP, DOWN, LEFT ,RIGHT} modifiers seem generic enough
Not convinced.
> 2) Now the gesture functionally for this APDS9960 part isn't something
> you can read_raw due to the fact reading the registers directly would
> empty the FIFO on-chip RAM. I don't see away of having an
> iio_chan_spec be blacklisted from in_*_raw sysfs entry? Which would be
> need to prevent side-effects.
Don't add the IIO_CHAN_INFO_RAW element to any of the infomasks.
(this is why we moved this into the info masks a long time back - before that
all channels had one IIRC)
> 3) Should gesture reporting be done with a triggered_buffer or would
> iio_push_event make more sense? I suspect the latter since you don't
> really care about data that you have missed and don't need it
> buffered.
If it was a single gesture it would make sense as an event, but that's
not what you are reporting.   What you have here is a event driven buffer
(same as for impact detectors for example). It may well make sense to 
have this as an additional buffer, which is done by registering an additional
IIO device currently.  Clearly this only matters if the other channels have
buffered access as well.  Note you don't have to have a triggered buffer.
It's fine to directly feed a buffer without a trigger if there is no
exposed point to get the trigger for individual readings (as there often
isn't when a hardware fifo is involved).  You could treat it as a hwfifo
if that makes more sense..  I've not read the datasheet closely enough
to make a decision on this.

> 
> 
> Thanks,
> 
> Matt
> 
> On Tue, Jun 2, 2015 at 10:20 PM, Matt Ranostay <mranostay@gmail.com> wrote:
>> On Tue, Jun 2, 2015 at 11:28 AM, Jonathan Cameron <jic23@kernel.org> wrote:
>>> On 02/06/15 05:35, Matt Ranostay wrote:
>>>> Jonathan,
>>>>
>>>> So I am currently planning on implementing a driver for the Avago
>>>> APDS-9960 that has the typical ALS, RGBC, and proximity sensor
>>>> components. But this part has a gesture function that uses 4 IR
>>>> photodiodes aligned in a grid of UP-DOWN-LEFT-RIGHT that detect IR
>>>> light reflection off an object, and in turn reports back the direction
>>>> a hand or similar would make over the sensor.
>>>>
>>>> Now the data that is reported back is the intensity of each of the 4
>>>> LEDs (UPLR) which then userspace can compute the velocity, and
>>>> direction of the gesture. My question should some thing like this be
>>>> using 4 IIO_INTENSITY channels or just one 32-bit value and new type
>>>> of IIO_GESTURE?
>>> Interesting device.
>>>
>>> Anyhow, my immediate reaction is that the single 32 bit value is effectively
>>> device specific whereas breaking it up into 4 values makes it more generic.
>>> (just wait for the predictable 8 led version to offer extra LEDs on the diagonals)
>>>
>>> The question that follows is how to make their relative positions / sensitive directions
>>> apparent to userspace?
>>>
>>> I'd go for sensitive direction as the optics of different sensors may give very different
>>> correspondences.
>>>
>>> So we 'could' do it with modifiers but how do we make them generic enough?
>>> How about a a sensitive_direction type infomask element that gives an approximate
>>> pointing vector? (using the read_raw_multi)
>>
>> The latter seems more sane and functional. Would this just tell
>> userspace the orientation that the sensor is mounted on a board? I
>> would assume so since the LEDs are integrated on the sensor IC.
>>
>>>
>>> Other suggestion welcome as I have only been considering this whilst navigating Dublin
>>> airport and a few beers waiting for the plane.
>>>
>>> Jonathan
>>>>
>>>> Datasheet -> https://cdn.sparkfun.com/datasheets/Sensors/Proximity/apds9960.pdf
>>>>
>>>>
>>>> Thanks,
>>>>
>>>> Matt Ranostay
>>>>
>>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

