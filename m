Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60873 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751565AbcDRUGH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 Apr 2016 16:06:07 -0400
Subject: Re: Driver directory selection for Power Supply Status chip
To: tthayer@opensource.altera.com,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org, arnd@arndb.de,
	gregkh@linuxfoundation.org, Guenter Roeck <linux@roeck-us.net>,
	linux-pm <linux-pm@vger.kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Dmitry <dbaryshkov@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>
References: <571507DE.3080408@opensource.altera.com>
 <57150E47.4020503@metafoo.de> <571538D5.5020209@opensource.altera.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <57153E2A.7030207@kernel.org>
Date: Mon, 18 Apr 2016 21:06:02 +0100
MIME-Version: 1.0
In-Reply-To: <571538D5.5020209@opensource.altera.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/04/16 20:43, Thor Thayer wrote:
> 
> 
> On 04/18/2016 11:41 AM, Lars-Peter Clausen wrote:
>> On 04/18/2016 06:14 PM, Thor Thayer wrote:
>>> Hi,
>>>
>>> The Arria10 System Resource chip (A10SR) is a SPI based MFD implementing a
>>> GPIO expander, reset controller, and power supply monitoring. I'm not sure
>>> where the driver for the A10SR power monitoring driver should reside and I'm
>>> hoping someone can offer some advice.
>>>
>>> I'd originally submitted the RFC to the HWMON list but the maintainer
>>> pointed out that it wasn't a good fit because the A10SR only indicates
>>> boolean power supply status - not the voltage level as required by HWMON.
>>>
>>> I read that IIO acts as a bridge between IO and HWMON but I'm also not sure
>>> this fits those drivers (although I did find some power supply supervistors
>>> there). It isn't quite a power supply supervisor - the A10SR is a comparator
>>> instead of an Analog-to-Digital Converter.
>>>
>>> One additional thing, the A10SR also had a number of enable bits for
>>> enabling devices external to Altera's SoC (but still on the development
>>> board). These don't quite fit into the reset controller framework but would
>>> seem to fit a MISC directory driver better.
>>>
>>> If neither IIO or MISC is a good fit, can someone suggest a more appropriate
>>> place?
>>
>> How does the device work, does it generate an interrupt when the voltage
>> level goes below the threshold? I'd like to pass the ball back and say that
>> this sounds like something that should go into hwmon.
>>
> 
> Good question but no, there is no interrupt.
> 
> The chip is actually a power supply sequencer for bringing up the
> power supplies in the correct order. Since the sequence, timings, and
> thresholds are hard coded in the chip and can't be changed
> programatically, I assume it was decided that a power fail interrupt
> was not needed. However, the status of the power (OK/Fail) can be
> read from the chip.
> 
> I was directed to look at Documentation/hwmon/sysfs-interface which
> states the units are in millivolts and I didn't see any references to
> a boolean output so I'm leaning away from hwmon.
That's one impressively uninformative output...  Hmm.
Not obvious where to put it - it doesn't fit in IIO really either.

Could report as a power supply?  There is 'health' support in there.
See Documentation/power/power_supply_class.txt
and include/linux/power_supply.h
though I'm not sure which type a fail on this would count as...
perhaps UNSPEC_FAILURE.

It's intended for batteries really - not sure how far you can stretch
that.

Cc'd linux-pm and maintainers.  Perhaps they will have a better idea!
> 
> Thank you for your reply!
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

