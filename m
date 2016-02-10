Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37887 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107AbcBJWqn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 10 Feb 2016 17:46:43 -0500
In-Reply-To: <20160210212240.GA12207@sophia>
References: <20160208175034.GA14727@sophia> <56BA6A15.9000601@kernel.org> <20160210021904.GA13466@sophia> <56BB87B1.3030806@kernel.org> <20160210212240.GA12207@sophia>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH v2] iio: Add IIO support for the DAC on the Apex Embedded Systems STX104
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Wed, 10 Feb 2016 22:46:37 +0000
To: William Breathitt Gray <vilhelm.gray@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>
CC: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <8C561E22-2F34-40B1-8950-B313EFBE5BB4@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 10 February 2016 21:22:40 GMT+00:00, William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
>On Wed, Feb 10, 2016 at 06:55:45PM +0000, Jonathan Cameron wrote:
>>On 10/02/16 02:19, William Breathitt Gray wrote:
>>> On Tue, Feb 09, 2016 at 10:37:09PM +0000, Jonathan Cameron wrote:
>>>> My only real question is on the naming of the module parameter.
>>>> Is it the equivalent of the io address that a load of ISA
>>>> radio drivers seem to use?  (fed to me by grepping
>isa_register_driver)
>>>> If so perhaps that's the 'standard' name as much as one exists for
>this?
>>> 
>>> Yes, you noted correctly that the stx104_base module parameter
>fulfills
>>> the same function as the io module parameter used in many of the
>radio
>>> drivers: it's an array holding the io port address of each device.
>>> However, I find "io" to be a rather vague module parameter name, so
>I've
>>> decided to use the more apt "stx104_base" name for my array of base
>>> addresses.
>>> 
>>> As you've probably noticed, there are few ISA drivers existing in
>the
>>> kernel baseline currently, so not much of a standard is set yet. I'm
>all
>>> right with renaming the module parameter if you have a preference,
>just
>>> as long as the name is more informative than simply "io."
>>> 
>>> For what it's worth, this driver is part of a series of PC/104
>drivers
>>> I've been submitting to various subsystems (in the hopes of
>improving
>>> the lack of PC/104 support in the baseline Linux kernel); see
>>> drivers/gpio/gpio-104-idio-16.c and drivers/gpio/gpio-104-idi-48.c
>for
>>> example. I have thus far been following the convention of naming the
>>> base address module parameter as "modname_base," where "modname" is
>the
>>> respective module name.
>>I've been trying to work out if IO ports is a generic enough ISA term
>>to take the view that anyone using an ISA card should know about it...
>>I certainly know the I/O space approach to interacting with PCI cards
>is
>>well understood in people working with shall we say 'dumb' PCI
>hardware.
>>
>>I guess I don't really care all that much on this though - just nice
>to
>>be consistent / general when possible.
>
>I believe that port-mapped I/O is ubiquitous enough in the industry
>that
>anyone with an ISA card will understand the term; in fact, I can't
>recall any PC/104 card datasheet I've encountered without a chapter
>section devoted to "I/O port address" configuration.
>
>The ISA drivers in the sound subsystem use "port" as the module
>parameter name for the I/O port base address of the respective sound
>device. Notice also how there are module parameters such as "midi_port"
>which represent the I/O port address of various registers on the
>device.
>
>"I/O port address" does not necessarily mean the base address of the
>device, but simply a port address (typically pointing to a particular
>register). For this reason, I prefer the more specific name "base" to
>indicate the I/O port base address of the device from which to derive
>the register addresses.
>
>Thinking it over again, I want to submit a version 3 of this patch
>which
>will rename "stx104_base" to the more general "base" name; the
>"stx104_"
>prefix is overly verbose for a module parameter since the user should
>already know the module he/she is configuring. Hopefully, by using a
>more general name, there will also arise a more consistent way of
>configuring the I/O port base addresses among other PC/104 and ISA
>drivers via the "base" module parameter
Base sounds good and generic enough to me.
>
>Are there any other changes I should include in version 3?
Don't think so.
>
>On an unrelated note, I may write a patch in the future to add support
>for the 16-channel ADC on the STX104. Should this support be added into
>this existing iio/dac/stx104.c file, or into a new iio/adc/stx104.c
>file?
Probably just add it it to the existing driver unless there is a reason to separate
 them. May make sense to move the driver at that point though.
>
>William Breathitt Gray
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
