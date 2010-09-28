Return-Path: <mensch0815@googlemail.com>
MIME-Version: 1.0
In-Reply-To: <4CA0C7AB.8060905@cam.ac.uk>
References: <1283786178-6466-1-git-send-email-jic23@cam.ac.uk>
	<4C94B4A6.2060001@cam.ac.uk>
	<AANLkTinQ04UmbBvakGQBeSap0PCh3VrWmhhobLh0u9Qj@mail.gmail.com>
	<4CA0C7AB.8060905@cam.ac.uk>
Date: Tue, 28 Sep 2010 22:56:42 +0200
Message-ID: <AANLkTikXMycs_eaRGA4Va=uaBo_qyx3S3m0Y43Gt+qAz@mail.gmail.com>
Subject: Re: [PATCH 0/2 V2] Adding support for adis16250/5 to adis16260 driver.
From: matthias <mensch0815@googlemail.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, drivers@analog.com
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

after a long stuggle, I got a working kernel version for my board
running as I need it.
I tried both the staging/adis16255 and the staging/iio/gyro driver.

The latter doesn't work.
"adis16260 spi1.1: problem when reading 16 bit register 0x34
iio device0: disable irq failed"

A quick look in the code of staging/adis16255 and the data sheet tells
me, that you have to read from the higher register address but we read
from the lower one.
So I changed the value to 0x35, but it doesn't work either.

Well in the end I copied "my" read version from staging/adis16255 and
put a read call in the probe function (because it is the easiest way
to get spi_device structure).
Then it seems to work, with higher and lower byte.
So my conclusion is, that something went wrong when you casacade and
discascade (sorry for the poor english), from spi_device through
adis16260_state to device.
Sounds stange to me, as it works with the adis16260 chip, right?
So maybe it's because I use avr32 architecture?

So I don't know if we should dig deeper. The problem is, that I don't
have too much time to do it...
What do you think?

Regards,
Matthias

2010/9/27 Jonathan Cameron <jic23@cam.ac.uk>:
> On 09/18/10 16:48, matthias wrote:
>> Hi Jonathan,
>>
>> sorry for not answering yet. I was on vacation and next week I won't
>> be able to test the driver. Will try to do it asap....
>>
>> Matthias
>
> Hi Matthias,
>
> I'm afraid quite a bit has changed over the last few weeks. Feel free to =
test
> this patch set. =C2=A0The changes since then are merely renames of a coup=
le of
> attributes and a lot of stuff for event handling that doesn't effect this
> driver.
>
> If not, I'm hosting a *temporary* git tree with all my various queued up =
changes
> at:
>
> http://git.kernel.org/?p=3Dlinux/kernel/git/jic23/iio_temp.git
>
> Seems excessive to post this set again until I hear back from you!
>
> Thanks,
>
> Jonathan
>
> p.s. Switched to drivers@analog.com address as that now seems to work.
>
>>
>> 2010/9/18 Jonathan Cameron <jic23@cam.ac.uk>:
>>> On 09/06/10 16:16, Jonathan Cameron wrote:
>>>> Mainly a rebase, but a couple of attribute naming fixes as well.
>>>>
>>>> Note I don't have one of these so if anyone could test that would
>>>> be great!
>>>>
>>>> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
>>>>
>>>> Jonathan Cameron (2):
>>>> =C2=A0 staging:iio:adis16260 add id table support
>>>> =C2=A0 staging:iio:adis16260 add suppport for adis16255 and adis16250.
>>>>
>>>> =C2=A0drivers/staging/iio/gyro/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A08 +-
>>>> =C2=A0drivers/staging/iio/gyro/adis16260.h =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A03 +
>>>> =C2=A0drivers/staging/iio/gyro/adis16260_core.c =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| =C2=A0139 ++++++++++++++------
>>>> =C2=A0drivers/staging/iio/gyro/adis16260_platform_data.h | =C2=A0 19 +=
++
>>>> =C2=A0drivers/staging/iio/gyro/gyro.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A09 ++
>>>> =C2=A05 files changed, 136 insertions(+), 42 deletions(-)
>>>> =C2=A0create mode 100644 drivers/staging/iio/gyro/adis16260_platform_d=
ata.h
>>>>
>>>>
>>> Whilst I haven't tested these (don't have the hardware) I don't think t=
here
>>> is anything controversial, so my intent is to push these to Greg before=
 the
>>> next merge window. =C2=A0This is primarily to remove the duplication we=
 currently
>>> have with two drivers that effectively cover the same parts.
>>>
>>> Thanks,
>>>
>>> Jonathan
>>>
>>
>>
>>
>
>



--=20
motzblog.wordpress.com
