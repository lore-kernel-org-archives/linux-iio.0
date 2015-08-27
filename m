Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42077 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752903AbbH0QMn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 27 Aug 2015 12:12:43 -0400
In-Reply-To: <1440686436.25403.13.camel@chaos.site>
References: <55D88078.5080006@kernel.org> <1440079909-1337-1-git-send-email-nicola@corna.info> <1440079909-1337-2-git-send-email-nicola@corna.info> <8bdb2c60fd1785b1d814277769881f08@rainloop.corna.info> <1440686436.25403.13.camel@chaos.site>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH 2/3] iio:humidity:si7020: added No Hold read mode
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Thu, 27 Aug 2015 17:12:17 +0100
To: Jean Delvare <jdelvare@suse.de>, Nicola Corna <nicola@corna.info>
CC: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	Wolfram Sang <wsa@the-dreams.de>
Message-ID: <1BD7B93D-C2D2-4C0C-BBFB-B68365B9596E@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 27 August 2015 15:40:36 BST, Jean Delvare <jdelvare@suse.de> wrote:
>Le Sunday 23 August 2015 à 09:50 +0000, Nicola Corna a écrit :
>> August 22 2015 4:00 PM, "Jonathan Cameron" <jic23@kernel.org> wrote:
>> > On 20/08/15 15:11, Nicola Corna wrote:
>> > 
>> >> The Si7013/20/21 modules support 2 read modes:
>> >> * Hold mode, where the device stretches the clock until the end of
>the
>> >> measurement
>> >> * No Hold mode, where the device replies NACK for every I2C call
>during
>> >> the measurement
>> >> Here the No Hold mode is implemented, selectable with the boolean
>> >> parameter holdmode=N. The No Hold mode is less efficient, since it
>> >> requires multiple calls to the device, but it can be used as a
>fallback if
>> >> the clock stretching is not supported.
>> > 
>> > Interesting. Strikes me as something that should really be handled
>via the i2c
>> > core (and device tree or similar bindings) rather than inside a
>driver as
>> > a module parameter. Perhaps info provided to the i2c client driver
>> > via a check on whether the device supports clock stretching?
>
>There currently is no way for bus drivers to report whether they
>support
>clock stretching or not. We could add a functionality flag for this,
>like:
>
>#define I2C_FUNC_NO_CLK_STRETCH          0x00000040 /* No check for SCL
>low */
>
>For example i2c-algo-bit would set this flag if no getscl callback is
>provided.
>
>> Reasonable, but we also have to consider that:
>>  * it can happen that the device supports clock stretching but it is
>bugged
>> (like the Raspberry Pi)
>
>I can't really see the difference between "supports clock stretching
>but
>it is bugged" and "does not support clock stretching.
>
>>  * with the clock stretching the i2c bus is completely locked until
>the end of
>> the measurement (which can take up to 22.8 ms), while with the No
>Hold mode the
>> bus is used every 2-6 ms for very short periods (with a i2c clock at
>100 KHz,
>> each call takes 0.1 ms)
>
>I2C puts no limit on clock stretching and SMBus allows for up to 50 ms,
>so hopefully 22.8 ms should be non-fatal in most cases. But I
>understand
>there may be latency concerns.
>
>> In some cases the No Hold mode is preferable, even if the clock
>stretching is
>> supported and working.
>
>Got it. But something like I2C_FUNC_NO_CLK_STRETCH would let drivers
>pick a sane default at least.
>
>> > I'd like input from Jean on this.
>
>In fact you wanted input from Wolfram (Cc'd) as the new (you know, like
>for 3 years now) maintainer of the i2c subsystem ;-)
Doh! Must have been half asleep... Sorry Jean and Wolfram!

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
