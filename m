Return-Path: <lars@metafoo.de>
Message-ID: <505829A6.7090709@metafoo.de>
Date: Tue, 18 Sep 2012 09:58:30 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
 drivers@analog.com
Subject: Re: [PATCH 4/4] iio: ad7476: Add support for the ad7091r
References: <1347884808-26833-1-git-send-email-lars@metafoo.de> <1347884808-26833-4-git-send-email-lars@metafoo.de> <505792D0.2060307@kernel.org>
In-Reply-To: <505792D0.2060307@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

erOn 09/17/2012 11:14 PM, Jonathan Cameron wrote:
> On 09/17/2012 01:26 PM, Lars-Peter Clausen wrote:
>> Add support for the ad7091r 12 bit ADC to the ad7476 driver. Although the
>> ad7091r is not really related to any of the other devices supported by this
>> driver, luckily for us there are not so many ways (which are not totally insane)
>> how sampling a single channel ADC via SPI can be implemented and support for the
>> ad7091r can be added to the driver with just a few adjustments.
> Yup, eveything is nice and simple when there is only one channel ;)
>>
>> The ad7091r requires an external "conversion start" pulse to start a sample
>> conversion. After the conversion has finished the result can be read via SPI. We
>> depend on a IIO trigger to generate this signal, as a result only sampling in
>> buffered mode and not in manual mode is available.
> This is a little restrictive given we could wire up some magic with a gpio to
> do this, but I guess things like that can be added as and when people care.
> We may need some way of 'knowing' whether a more general trigger has done
> the start pulse or not... Something for another day.

Yes, I think this will eventually require a new class of devices, maybe a
trigger subclass. We can also generate a single pulse using the bfin timer.
But there is no interface to communicate this to trigger from the driver.
There are also some other ADC driver in staging/iio/adc which have a similar
convst signal and they indeed use a GPIO to generate the signal. But the
problem is that using a GPIO and a timer to generate the trigger pulse leads
on one hand to a lot less uniform and inaccurate waveform and thus decreases
the quality of the sampled data. On the other hand it increases the system
load. So I'm probably going to switch them over to something similar as in
this driver before moving them out of staging.

My short term goal is to retire the bfintmr trigger and replace it with a
more generic trigger which uses the PWM framework. But this requires some
infrastructure work on the PWM framework itself first.

The long term goal should be to extend the IIO trigger framework to better
integrate these kind of devices. In my opinion we can at least differentiate
between three different classes of triggers:

* Hardware triggers: Hardware triggers usually are hardwired on the board
  and can't be switched at runtime.
* Software triggers: Software triggers are as the name suggest triggered by
  software events and cause the sample to be read, e.g. by issuing a SPI
  read. Software triggers can be re-assigned at runtime.
* Built-in triggers: These are built into the sampling device and thus can
  be sort of seen as hardware triggers, but only the itself is able to use
  the trigger.

And not all devices support all kinds of triggers. Some may be able to
support multiple kinds, but need to change the device configuration to
switch between them. So the device needs to know which kind of trigger it is
currently used with.

> merged to togreg branch of iio.git

Thanks.

- Lars
