Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:38226 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753078Ab2F0HVv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 27 Jun 2012 03:21:51 -0400
Message-ID: <4FEAB48B.4010108@cam.ac.uk>
Date: Wed, 27 Jun 2012 08:21:47 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Marek Vasut <marek.vasut@gmail.com>
CC: Juergen Beisert <jbe@pengutronix.de>, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: i.MX28 die temperature
References: <330B740BA662BF4E8386F534DF556ED819731A@AEDCEXC09.aei.com> <201206221919.57485.marek.vasut@gmail.com> <201206261012.13620.jbe@pengutronix.de> <201206262102.15698.marek.vasut@gmail.com>
In-Reply-To: <201206262102.15698.marek.vasut@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 6/26/2012 8:02 PM, Marek Vasut wrote:
> Dear Juergen Beisert,
>
>> Hi Marek,
>>
>> Marek Vasut wrote:
>>> [...]
>>>
>>>>> Take a look at: http://www.spinics.net/lists/linux-iio/msg04345.html
>>>>
>>>> Any progress here with inclusion in some git tree?
>>>
>>> Well ... I recently raised from the dead. It's on the schedule, obviously
>>> help is welcome.
>>
>> I tried a little bit with your driver. The disadvantage I see is, its
>> claims all the free AD channels. But a few of them can also act as a
>> touchscreen controller. Shouldn't be the driver handle the channel usage
>> dynamically?
>
> I wonder, I'd rather see this driver behave as a composite driver, what do you
> think?
Alternative (though it's still in development) would be to use IIO
as the ADC layer and sit the other parts on top.  die temp and basic
adc are fine but no one has taken on a touchscreen controller via that
approach yet.  They tend to have a nasty large number of extremely 
special purpose bits.  I've certainly not thought through how to handle
those yet.
>
>> Also this AD module on the SoC can measure the die
>> temperature, battery voltage and some other power supplies.
>> I see more than one framework this driver should connect to: simple ADC
>> (IIO), touchscreen controller (INPUT), die temp (POWER?), various voltages
>> (POWER? REGULATOR?). Should it be a multi function device?
>
> Correct, making it a MFD device with common channel-management logic is the way
> to go. And it's gonna be a few resends of this driver, that's for certain. I'm
> not confident I'll be able to make it right at the first try ;-)
>
> INPUT -- touchscreen
> IIO -- die temp and LRADC (maybe random voltages?)
Mapping the die temp onto hwmon as obviously thats where it ultimately 
should appear.
> POWER -- battery
>
> But all this MFD goo is quite simple, the hard part is the channel management
> logic. From the top of my head, there're 16 channels, 8 can be sampled at the
> same time and there are 4 configuration triggers. Making it one hell of a
> complex hardware.
It is indeed a nasty beast. Good luck ;)
>
> I'll fix the remnants of SPI and start on this beast tonight or tomorrow. Since
> there was some progress in the IIO, I believe I'll have to rework it a bit.
>
>> Juergen
>
> Best regards,
> Marek Vasut
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


