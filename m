Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Date: Mon, 7 Feb 2011 10:25:01 +0000
Subject: RE: [RFC PATCH 0/5] Add kfifo based buffer implementation
Message-ID: <544AC56F16B56944AEC3BD4E3D591771324C1BA7CE@LIMKCMBX1.ad.analog.com>
References: <1292790825-19156-1-git-send-email-jic23@cam.ac.uk>
 <4D4DA97C.7000409@cam.ac.uk>
In-Reply-To: <4D4DA97C.7000409@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2011-02-05:
> On 12/19/10 20:33, Jonathan Cameron wrote:
>> This set is an update of the proof of concept I wrote a while back.
>> This time around I've simply used a byte stream buffer rather than
>> variable record sizes.  The first patch pushes some of the exiting
>> buffer code down into the ring_sw implementation to make it simpler to
>> provide other implementations.
>>
>> What you gain by picking kfifo:
>> * Clean fast code for the underlying buffer.
>>
>> What you loose:
>> * Events - userspace has to 'know' how often to read the buffer
>>   so as to not loose data.
>> Obvious difference is it is a fifo rather than a ring buffer.
>>
>> This buffer should also lend itself to a simple implementation of a
>> store_n function which should be useful for devices with a hardware
>> ring which we then want to feed into a software one.
>
> If anyone has time to take a look at this, it would be great to get
> some feedback. If not I propose merging it anyway soon.
> There is still work to be done to get this to an optimal state, but
> right now it works so might as well make it available.

A while ago I applied and tested this patch.
I looked and seemed to work fine. I have to admit I didn't do
extensive testing with it.

-Michael


> I fear my sw_ring implementation is one of the main blockers to moving
> IIO out of staging so would like to show how easy it is to use
> alternatives.  On that note we should probably have some documentation
> to provide a clear explanation of when to pick one buffer over another.
>
> The 'What option should a distro use?' question Greg raised the other
> day will here be controlled by driver writers setting a suitable
> default buffer choice if they implement multiple options.
>>
>> Jonathan Cameron (5):
>>   staging:iio:buffering  move the copy to user on rip down into
>>     implementations
>>   staging:iio:kfifo buffer implementation
>>   staging:iio:lis3l02dq allow buffer implementation selection
>>   staging:iio: update example to handle case with no ring events
>>   staging:iio: buffer example - add lots more runtime parameters
>>  drivers/staging/iio/Documentation/generic_buffer.c |   63 +++++--
>>  drivers/staging/iio/Kconfig                        |    6 +
>>  drivers/staging/iio/Makefile                       |    1 +
>>  drivers/staging/iio/accel/Kconfig                  |   23 +++-
>>  drivers/staging/iio/accel/lis3l02dq.h              |   10 +
>>  drivers/staging/iio/accel/lis3l02dq_ring.c         |    9 +-
>>  drivers/staging/iio/industrialio-ring.c            |   23 +--
>>  drivers/staging/iio/kfifo_buf.c                    |  196
>>  ++++++++++++++++++++ drivers/staging/iio/kfifo_buf.h
>>   |   56 ++++++ drivers/staging/iio/ring_generic.h                 |
>>  2 +- drivers/staging/iio/ring_sw.c                      |   29 ++-
>>  drivers/staging/iio/ring_sw.h                      |    4 +- 12 files
>>  changed, 363 insertions(+), 59 deletions(-)  create mode
>> 100644 drivers/staging/iio/kfifo_buf.c  create mode 100644
>> drivers/staging/iio/kfifo_buf.h
>>
>

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368; Gesch=
aeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret=
 Seif
