Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:36839 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756710AbbIVC5P (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 21 Sep 2015 22:57:15 -0400
Received: by obbmp4 with SMTP id mp4so63309963obb.3
        for <linux-iio@vger.kernel.org>; Mon, 21 Sep 2015 19:57:14 -0700 (PDT)
In-Reply-To: <5600B726.2010900@roeck-us.net>
References: <20150921220648.GA12569@deathstar> <5600A924.1090303@roeck-us.net> <20150922012707.GA20799@deathstar> <5600B726.2010900@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: ADS1018 ADC driver
From: mwelling@ieee.org
Date: Mon, 21 Sep 2015 21:57:48 -0500
To: Guenter Roeck <linux@roeck-us.net>
CC: lm-sensors@lm-sensors.org, linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>
Message-ID: <2A0E464E-DAA5-4326-8E94-78F17913AD51@ieee.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On September 21, 2015 9:04:22 PM CDT, Guenter Roeck <linux@roeck-us.net> wrote:
>Michael,
>
>On 09/21/2015 06:27 PM, Michael Welling wrote:
>> On Mon, Sep 21, 2015 at 06:04:36PM -0700, Guenter Roeck wrote:
>>> Hi Michael,
>>>
>>> On 09/21/2015 03:06 PM, Michael Welling wrote:
>>>> I am in the process of starting a new device driver for the ADS1018
>ADC.
>>>> Before starting I did some research as whether similar drivers
>exist in the kernel.
>>>>
>>>> It appears that ADC drivers are in both hwmon and iio/adc. The
>closest drivers to
>>>> the device mentioned are in hwmon.
>>>>
>>>> Where is the best place for this new ADC driver?
>>>
>>> Your call. You could add support for the chip to hwmon/ads1015.c, or
>you could write
>>> a new driver in iio/adc. If you do the latter, maybe you can also
>include support
>>> for ads1015 and ads1115, so we can ultimately remove the ads1015
>driver from hwmon.
>>
>> Guenter,
>>
>> Though the iio route may be more work I have a feeling the
>> driver will be better off there. The use of regmap support
>> should allow for both the SPI and I2C version to coexist.
>>
>Sorry, you lost me. There is no correlation between iio/hwmon and
>regmap.
>regmap can be (and is) used with both subsystems. Please clarify.
>

I was thinking regmap could abstract the differences between the I2C and SPI devices simplifying the combination of the drivers into a single driver.

Looking at the datasheets this would not be as easy as thought. We will see when I get into the coding.

>> I will try my best to implement the driver in a way that
>> can cover these other I2C devices mentioned.
>>
>>>
>>>> Shouldn't ADCs all be in the same subsystem?
>>>> Has there been any effort to unify or distiguish where drivers
>should go?
>>>>
>>> In general, ADCs primarily used for the purpose of ADC measurements
>would go
>>> into iio, and ADCs used primarily for hardware monitoring would go
>into hwmon.
>>>
>>> There are no strict rules, though, and this is not always
>black-and-white.
>>> I am sure there are some drivers in hwmon which would be better
>suited for iio.
>>> Primarily that would be the case because the iio subsystem is
>relatively new,
>>> and such drivers did not have a home other than hwmon until a couple
>of years ago.
>>> If you find any drivers in hwmon which you think should be moved,
>please feel free
>>> to do the conversion.
>>
>> Has anyone considered an alternative implementation for generic ADCs?
>>
>> I was thinking about an implementation similar to gpiolib whereas
>ADCs can be
>> resources for other drivers.
>>
>> For instance, ADC lines could be registered to a joystick driver and
>used to provide
>> analog stick or pressure sensitive button. Another example could be
>registering analog
>> lines for an analog accelerometer driver.
>>
>> Is this a bad idea?
>>
>I am quite sure that is possible. If it isn't currently supported, it
>waits for someone
>with a use case to implement it.

Okay. Well if more interest is expressed I might look into implementing it.

>
>Guenter

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
