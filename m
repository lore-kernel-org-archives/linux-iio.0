Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Drivers
	<Drivers@analog.com>
Date: Tue, 5 Oct 2010 09:32:51 +0100
Subject: RE: [PATCH] staging: iio: adc: Enable driver support for ad799x AD
 converters
Message-ID: <544AC56F16B56944AEC3BD4E3D5917712F0DB8ABBD@LIMKCMBX1.ad.analog.com>
References: <1285926110-6678-1-git-send-email-michael.hennerich@analog.com>
 <1285926110-6678-2-git-send-email-michael.hennerich@analog.com>
 <4CA5CF74.6030606@cam.ac.uk>
 <544AC56F16B56944AEC3BD4E3D5917712F0DB8A636@LIMKCMBX1.ad.analog.com>
 <4CA60343.9050106@cam.ac.uk>
 <544AC56F16B56944AEC3BD4E3D5917712F0DB8A799@LIMKCMBX1.ad.analog.com>
 <4CA9A4DC.3020609@cam.ac.uk>
In-Reply-To: <4CA9A4DC.3020609@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2010-10-04:
> ...
>>>> Hi Jonathan,
>>>>
>>>> We have a few more iio drivers in our repository. Over the next
>>>> couple of weeks I'm trying to get them out. Excellent.
>>>>
>>>>> because I would like it to go in before the event clean up series
>>>>> currently sat in my tree. That way I can update this one at the
>>>>> same time.
>>>>
>>>> Oops - this patch was already against your tree:
>>>> http://git.kernel.org/?p=3Dlinux/kernel/git/jic23/iio_temp.git
>>>>
>>>> Need to check if it works on Greg's staging.
>>> Ah. Shouldn't be too bad.  That's what I get for putting temporary
>>> trees up - that one only exists for testing the adis16260 and
>>> adis16350 driver changes.
>>
>> Well - it looks bad. It basically errors on everything I changed in
>> order to make it work on your temp tree. I'll send Greg my original
>> version...
> Are you sure this was against staging-next branch of the staging-next
> tree? (which is where Greg will merge this)  Far as I can see all the
> changes since that in my temp tree are to do with the event code
> cleanups and I don't think that would generate most of these.  The
> index an type changes + the rearrangement of the buffer code has been
> merged for a while.
>
>
> It applies and builds as is.  git's am checking throws up
> /home/jic23/src/kernel/staging-next-2.6/.git/rebase-apply/patch:610:
> trailing whitespace.
>                                 i & 0x1 ?
> and sparse gives drivers/staging/iio/adc/ad799x_core.c: In function
> 'ad799x_interrupt_bh': drivers/staging/iio/adc/ad799x_core.c:391:
> warning: suggest parentheses around + or - inside shift
> drivers/staging/iio/adc/ad799x_core.c:392: warning: right shift count
>> =3D width of type
> drivers/staging/iio/adc/ad799x_core.c:392: warning: suggest
> parentheses around + or - inside shift
>
> both of which are probably worth fixing.

Hmm - I don't see this warning.
What version of sparse are you using - and do you pass any extra arguments =
to sparse?

  CHECK   drivers/staging/iio/adc/ad799x_core.c
  CC      drivers/staging/iio/adc/ad799x_core.o
  LD      drivers/staging/iio/adc/ad799x.o


Greetings,
Michael

Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft Muenchen, Registergericht Muenchen HRB 4036 Geschaeft=
sfuehrer Thomas Wessel, William A. Martin, Margaret Seif
