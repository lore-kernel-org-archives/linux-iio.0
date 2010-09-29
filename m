Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:44634 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019Ab0I2Nwi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 29 Sep 2010 09:52:38 -0400
Message-ID: <4CA344A5.80205@cam.ac.uk>
Date: Wed, 29 Sep 2010 14:52:37 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: matthias <mensch0815@googlemail.com>
CC: linux-iio@vger.kernel.org, drivers@analog.com,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	David Brownell <dbrownell@users.sourceforge.net>,
	Grant Likely <grant.likely@secretlab.ca>,
	spi-devel-general@lists.sourceforge.net
Subject: Re: [PATCH 0/2 V2] Adding support for adis16250/5 to adis16260 driver.
References: <1283786178-6466-1-git-send-email-jic23@cam.ac.uk>	<4C94B4A6.2060001@cam.ac.uk>	<AANLkTinQ04UmbBvakGQBeSap0PCh3VrWmhhobLh0u9Qj@mail.gmail.com>	<4CA0C7AB.8060905@cam.ac.uk> <AANLkTikXMycs_eaRGA4Va=uaBo_qyx3S3m0Y43Gt+qAz@mail.gmail.com>
In-Reply-To: <AANLkTikXMycs_eaRGA4Va=uaBo_qyx3S3m0Y43Gt+qAz@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Matthias

Lots of additional cc's as I think I know what the problem is and I
think it's an spi issue rather than an IIO one.

> 
> after a long stuggle, I got a working kernel version for my board
> running as I need it.
> I tried both the staging/adis16255 and the staging/iio/gyro driver.
> 
> The latter doesn't work.
> "adis16260 spi1.1: problem when reading 16 bit register 0x34
> iio device0: disable irq failed"
That is the first actual comms with the chip, so it is likely to be a
general issue rather than due to that particular call.
> 
> A quick look in the code of staging/adis16255 and the data sheet tells
> me, that you have to read from the higher register address but we read
> from the lower one.
> So I changed the value to 0x35, but it doesn't work either.
Quoting from the data sheet (it is present on the sheets for both chips).

"Each register has two addresses (upper, lower), but either one can be used
to access its entire 16 bits of data."

It could be there is something special about that register I'm not seeing
though...
> 
> Well in the end I copied "my" read version from staging/adis16255 and
> put a read call in the probe function (because it is the easiest way
> to get spi_device structure).
> Then it seems to work, with higher and lower byte.
Ok, that gives us something to work against which is very helpful!
> So my conclusion is, that something went wrong when you casacade and
> discascade (sorry for the poor english), from spi_device through
> adis16260_state to device.
> Sounds stange to me, as it works with the adis16260 chip, right?
As far as I know. It's possible something strange happened in a merge
at some point though.
> So maybe it's because I use avr32 architecture?

Having done a bit of digging and made sure that (up to the fact I don't
have the part) everything runs normally on my board, I'm beginning to
suspect you are correct. There are some subtle differences in the setup
between your code and Barry's.

Looking about, the avr32's seem to use the atmel_spi driver?

Ah got it (I think)...

In drivers/spi/atmel_spi.c atmel_spi_transfer we have:

		/* FIXME implement these protocol options!! */
		if (xfer->bits_per_word || xfer->speed_hz) {
			dev_dbg(&spi->dev, "no protocol options yet\n");
			return -ENOPROTOOPT;
		}

Personally I'd have at least sanity checked if the parameters were trying
to change anything before dumping out.  Also, surely that's a case for
something screaming a little louder given it is an out and out device
killing problem? I think the default is 8 bit?  I think the reason it
is in Barry's driver is a legacy issue to do with the fact that these
are actually 16bit transfers pretending to be 8 bits ones...  Actually
now I look at it, I'm not sure why he didn't use 16 bit ones in that
function in the first place!

Not sure we need it in our drivers, but I'm guessing there may be some
spi master driver out there somewhere that defaults to something other than
8 bit? (have vague recollection of seeing an email about this... perhaps
someone who plays more with spi bus drivers?)

> 
> So I don't know if we should dig deeper. The problem is, that I don't
> have too much time to do it...
Sorry it is proving such a pain for you to test!
> What do you think?
I have cc'd spi people and the atmel_spi maintainer to see what we think
is the correct fix for this. For the purposes of this discussion
(though it's isn't quite what Matthias is working with) the driver in
question is drivers/staging/iio/gyro/adis16260_core.c


Thanks again for testing.

Jonathan

> Regards,
> Matthias
> 
> 2010/9/27 Jonathan Cameron <jic23@cam.ac.uk>:
>> On 09/18/10 16:48, matthias wrote:
>>> Hi Jonathan,
>>>
>>> sorry for not answering yet. I was on vacation and next week I won't
>>> be able to test the driver. Will try to do it asap....
>>>
>>> Matthias
>>
>> Hi Matthias,
>>
>> I'm afraid quite a bit has changed over the last few weeks. Feel free to test
>> this patch set.  The changes since then are merely renames of a couple of
>> attributes and a lot of stuff for event handling that doesn't effect this
>> driver.
>>
>> If not, I'm hosting a *temporary* git tree with all my various queued up changes
>> at:
>>
>> http://git.kernel.org/?p=linux/kernel/git/jic23/iio_temp.git
>>
>> Seems excessive to post this set again until I hear back from you!
>>
>> Thanks,
>>
>> Jonathan
>>
>> p.s. Switched to drivers@analog.com address as that now seems to work.
>>
>>>
>>> 2010/9/18 Jonathan Cameron <jic23@cam.ac.uk>:
>>>> On 09/06/10 16:16, Jonathan Cameron wrote:
>>>>> Mainly a rebase, but a couple of attribute naming fixes as well.
>>>>>
>>>>> Note I don't have one of these so if anyone could test that would
>>>>> be great!
>>>>>
>>>>> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
>>>>>
>>>>> Jonathan Cameron (2):
>>>>>   staging:iio:adis16260 add id table support
>>>>>   staging:iio:adis16260 add suppport for adis16255 and adis16250.
>>>>>
>>>>>  drivers/staging/iio/gyro/Kconfig                   |    8 +-
>>>>>  drivers/staging/iio/gyro/adis16260.h               |    3 +
>>>>>  drivers/staging/iio/gyro/adis16260_core.c          |  139 ++++++++++++++------
>>>>>  drivers/staging/iio/gyro/adis16260_platform_data.h |   19 +++
>>>>>  drivers/staging/iio/gyro/gyro.h                    |    9 ++
>>>>>  5 files changed, 136 insertions(+), 42 deletions(-)
>>>>>  create mode 100644 drivers/staging/iio/gyro/adis16260_platform_data.h
>>>>>
>>>>>
>>>> Whilst I haven't tested these (don't have the hardware) I don't think there
>>>> is anything controversial, so my intent is to push these to Greg before the
>>>> next merge window.  This is primarily to remove the duplication we currently
>>>> have with two drivers that effectively cover the same parts.
>>>>
>>>> Thanks,
>>>>
>>>> Jonathan
>>>>
>>>
>>>
>>>
>>
>>
> 
> 
> 

