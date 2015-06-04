Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:36007 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751632AbbFDQoS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 4 Jun 2015 12:44:18 -0400
Received: by ieclw1 with SMTP id lw1so40243913iec.3
        for <linux-iio@vger.kernel.org>; Thu, 04 Jun 2015 09:44:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKzfze82kYZi6jxiQV_b+=-rQJzbYbO8-kb=2gMEZr=3xeSVEA@mail.gmail.com>
References: <CAKzfze8qX0WEKmHgBKKVvw-=mzFOUVSQnOXXxjUPdm=BafoYqA@mail.gmail.com>
	<556DF5D8.9080000@kernel.org>
	<CAKzfze82kYZi6jxiQV_b+=-rQJzbYbO8-kb=2gMEZr=3xeSVEA@mail.gmail.com>
Date: Thu, 4 Jun 2015 09:44:18 -0700
Message-ID: <CAKzfze_o+muj2KTF=9Hy3z7JTUN3Q-4_uw2jWmoTUDxKxFjQ+w@mail.gmail.com>
Subject: Re: IIO_GESTURE proposal
From: Matt Ranostay <mranostay@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Jonathan,

Doing some thinking over the last couple days, and need some additional input.

1) Do IIO_MOD_DIRECTION{UP, DOWN, LEFT ,RIGHT} modifiers seem generic enough
2) Now the gesture functionally for this APDS9960 part isn't something
you can read_raw due to the fact reading the registers directly would
empty the FIFO on-chip RAM. I don't see away of having an
iio_chan_spec be blacklisted from in_*_raw sysfs entry? Which would be
need to prevent side-effects.
3) Should gesture reporting be done with a triggered_buffer or would
iio_push_event make more sense? I suspect the latter since you don't
really care about data that you have missed and don't need it
buffered.


Thanks,

Matt

On Tue, Jun 2, 2015 at 10:20 PM, Matt Ranostay <mranostay@gmail.com> wrote:
> On Tue, Jun 2, 2015 at 11:28 AM, Jonathan Cameron <jic23@kernel.org> wrote:
>> On 02/06/15 05:35, Matt Ranostay wrote:
>>> Jonathan,
>>>
>>> So I am currently planning on implementing a driver for the Avago
>>> APDS-9960 that has the typical ALS, RGBC, and proximity sensor
>>> components. But this part has a gesture function that uses 4 IR
>>> photodiodes aligned in a grid of UP-DOWN-LEFT-RIGHT that detect IR
>>> light reflection off an object, and in turn reports back the direction
>>> a hand or similar would make over the sensor.
>>>
>>> Now the data that is reported back is the intensity of each of the 4
>>> LEDs (UPLR) which then userspace can compute the velocity, and
>>> direction of the gesture. My question should some thing like this be
>>> using 4 IIO_INTENSITY channels or just one 32-bit value and new type
>>> of IIO_GESTURE?
>> Interesting device.
>>
>> Anyhow, my immediate reaction is that the single 32 bit value is effectively
>> device specific whereas breaking it up into 4 values makes it more generic.
>> (just wait for the predictable 8 led version to offer extra LEDs on the diagonals)
>>
>> The question that follows is how to make their relative positions / sensitive directions
>> apparent to userspace?
>>
>> I'd go for sensitive direction as the optics of different sensors may give very different
>> correspondences.
>>
>> So we 'could' do it with modifiers but how do we make them generic enough?
>> How about a a sensitive_direction type infomask element that gives an approximate
>> pointing vector? (using the read_raw_multi)
>
> The latter seems more sane and functional. Would this just tell
> userspace the orientation that the sensor is mounted on a board? I
> would assume so since the LEDs are integrated on the sensor IC.
>
>>
>> Other suggestion welcome as I have only been considering this whilst navigating Dublin
>> airport and a few beers waiting for the plane.
>>
>> Jonathan
>>>
>>> Datasheet -> https://cdn.sparkfun.com/datasheets/Sensors/Proximity/apds9960.pdf
>>>
>>>
>>> Thanks,
>>>
>>> Matt Ranostay
>>>
>>
