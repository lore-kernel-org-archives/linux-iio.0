Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:56530 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753605Ab2F0MG7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 27 Jun 2012 08:06:59 -0400
Message-ID: <4FEAF75E.5090505@cam.ac.uk>
Date: Wed, 27 Jun 2012 13:06:54 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Marek Vasut <marex@denx.de>
CC: Juergen Beisert <jbe@pengutronix.de>, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: i.MX28 die temperature
References: <330B740BA662BF4E8386F534DF556ED819731A@AEDCEXC09.aei.com> <201206262102.15698.marek.vasut@gmail.com> <4FEAB48B.4010108@cam.ac.uk> <201206271400.11727.marex@denx.de>
In-Reply-To: <201206271400.11727.marex@denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 6/27/2012 1:00 PM, Marek Vasut wrote:
> Dear Jonathan Cameron,
>
>> On 6/26/2012 8:02 PM, Marek Vasut wrote:
>>> Dear Juergen Beisert,
>>>
>>>> Hi Marek,
>>>>
>>>> Marek Vasut wrote:
>>>>> [...]
>>>>>
>>>>>>> Take a look at: http://www.spinics.net/lists/linux-iio/msg04345.html
>>>>>>
>>>>>> Any progress here with inclusion in some git tree?
>>>>>
>>>>> Well ... I recently raised from the dead. It's on the schedule,
>>>>> obviously help is welcome.
>>>>
>>>> I tried a little bit with your driver. The disadvantage I see is, its
>>>> claims all the free AD channels. But a few of them can also act as a
>>>> touchscreen controller. Shouldn't be the driver handle the channel usage
>>>> dynamically?
>>>
>>> I wonder, I'd rather see this driver behave as a composite driver, what
>>> do you think?
>>
>> Alternative (though it's still in development) would be to use IIO
>> as the ADC layer and sit the other parts on top.
>
> I think you need to adjust a few bits there and there in the hardware to behave
> as a touchscreen. Will IIO be able to handle that somehow ?
No means of doing it yet.  I'm not entirely sure this can be done 
generically. I'm not really familiar enough with touchscreen adcs as 
none of my boards have one.  At worst I'm sure we can put some
hooks in to get hold of the underlying device if necessary.

>
>> die temp and basic
>> adc are fine but no one has taken on a touchscreen controller via that
>> approach yet.
>
> Is there any example of these basic things already?
Saddly only patches posted on the list for the interrupt driven side of 
things. I have an updated version (that acutally works reasonably well) 
but haven't posted as yet as want to take another look at some of the
error cases when switching buffers in and out (all about rolling back
sucessfully to a valid configuration when an invalid one has failed).

The hwmon stuff is in tree though as drivers/staging/iio/iio_hwmon.c   I 
really ought to get round to posting that one for inclusion under 
drivers/hmwon. Guenter was reasonably happy with the version that is
there so shouldn't be too much trouble.

>
>> They tend to have a nasty large number of extremely
>> special purpose bits.  I've certainly not thought through how to handle
>> those yet.
>>
>>>> Also this AD module on the SoC can measure the die
>>>> temperature, battery voltage and some other power supplies.
>>>> I see more than one framework this driver should connect to: simple ADC
>>>> (IIO), touchscreen controller (INPUT), die temp (POWER?), various
>>>> voltages (POWER? REGULATOR?). Should it be a multi function device?
>>>
>>> Correct, making it a MFD device with common channel-management logic is
>>> the way to go. And it's gonna be a few resends of this driver, that's
>>> for certain. I'm not confident I'll be able to make it right at the
>>> first try ;-)
>>>
>>> INPUT -- touchscreen
>>> IIO -- die temp and LRADC (maybe random voltages?)
>>
>> Mapping the die temp onto hwmon as obviously thats where it ultimately
>> should appear.
>
> Ah correct.
>
>>> POWER -- battery
>>>
>>> But all this MFD goo is quite simple, the hard part is the channel
>>> management logic. From the top of my head, there're 16 channels, 8 can
>>> be sampled at the same time and there are 4 configuration triggers.
>>> Making it one hell of a complex hardware.
>>
>> It is indeed a nasty beast. Good luck ;)
>
> Mmm ... sounds more like "condolences" :-D
:)
>
>>> I'll fix the remnants of SPI and start on this beast tonight or tomorrow.
>>> Since there was some progress in the IIO, I believe I'll have to rework
>>> it a bit.
>>>
>>>> Juergen
>>>
>>> Best regards,
>>> Marek Vasut
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> Best regards,
> Marek Vasut
>


