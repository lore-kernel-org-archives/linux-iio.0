Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Manuel Stahl
	<manuel.stahl@iis.fraunhofer.de>, Lars-Peter Clausen <lars@metafoo.de>
Date: Mon, 21 Nov 2011 09:05:36 +0000
Subject: RE: RFC usecases for simultaneous buffered / sysfs access to data
Message-ID: <544AC56F16B56944AEC3BD4E3D5917714872FF312B@LIMKCMBX1.ad.analog.com>
References: <4EC8F518.6010102@cam.ac.uk> <4ECA07DA.2070605@metafoo.de>
In-Reply-To: <4ECA07DA.2070605@metafoo.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Lars-Peter Clausen wrote on 2011-11-21:
> On 11/20/2011 01:39 PM, Jonathan Cameron wrote:
>> Hi All,
>>
>> One nasty issue is kicking around in how to handle in kernel interfaces.
>>
>> It comes down to what happens when a sysfs read is performed on a
>> device doing buffered capture.  Right now some drivers will look into
>> the buffer, see if the relevant channel is there, and then pull out the
>> latest reading.
>>
>> Now, with in kernel push interfaces (buffer_cb etc) things are more
>> complex as we have several 'buffers' and it may be that none of them
>> is the traditional IIO buffer.  Thus working out whether the data is
>> available anywhere is a pain.
>>
>> Clearly the same issue effects other in kernel 'pull' users (which
>> make direct calls to read_raw).  Now in these cases they have
>> specifically requested a set of channels.  Given we have a tightly
>> defined subset of channels we can add another 'buffer' that caches
>> the latest value and the demux code can handle this fine. It's costly
>> in terms of bus transactions, but probably the only way we can keep
>> things consistent and predictable.
>>
>> This approach doesn't work for the IIO sysfs accesses though as these
>> frequently involve incompatible sets of channel reads (differential and
>> non differential on a typical adc for example).  We simply can't do
>> buffered capture of these in a single pass on some devices (max1363 for
>> example).  If there is a really strong use case some sort of fallback
>> to a faked 'scan' might be possible but is going to be very fiddly and
>> in my view doesn't want to be in drivers unless there is a user.
>>
>>
>> Hence this question comes down to what we do for iio sysfs interfaces
>> and that is dependent on why people actually use the sysfs interfaces.
>>
>> 1) Drop the reading from the buffer (to output via sysfs) across all
>> drivers that do it. (does this hurt any one?  I wrote the first driver
>> that does this and it doesn't effect any use case I have!)
>>
>> 2) Implement something like in0_reserve to allow us to specify which
>> channels should still be available for sysfs reads when buffered
>> reading is going on.
>>
>> 3) Add an iio on iio driver that uses the mapping infrastructure to
>> allow it to pretend to be like the other in kernel users described
>> above.
>>
>>
>>
>> So my thoughts are that 1) is the best plan unless someone has a real
>> pressing use case that requires us to read from the buffer.
>
> I agree. The usecases for simultaneously doing a buffer and sysfs read
> are rather limited. On the other hand it complicates the design and
> implementation.
>
> - Lars

Agreed.


Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Mar=
garet Seif
