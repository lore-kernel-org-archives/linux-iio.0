Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:36288 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754256AbaFRTnv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 18 Jun 2014 15:43:51 -0400
Message-ID: <53A1EC6E.3010606@kernel.org>
Date: Wed, 18 Jun 2014 20:45:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>,
	Peter Meerwald <pmeerw@pmeerw.net>
CC: =?windows-1252?Q?Kristina_Mart=9Aenko?=
	<kristina.martsenko@gmail.com>, linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: IIO drivers left in drivers/staging/
References: <20140611013007.GA32756@kroah.com> <f0db211a-bf69-4a3e-beda-2101af74ae25@email.android.com> <53998D43.9020209@gmail.com> <53A1895A.4090209@gmail.com> <alpine.DEB.2.01.1406181445290.28014@pmeerw.net> <20140618174717.GC11977@kroah.com> <53A1D534.9090105@kernel.org>
In-Reply-To: <53A1D534.9090105@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/06/14 19:06, Jonathan Cameron wrote:
> On 18/06/14 18:47, Greg KH wrote:
>> On Wed, Jun 18, 2014 at 02:56:52PM +0200, Peter Meerwald wrote:
>>> Hello Kristina,
>>>
>>>>> Okay so right now I'm getting the following things I could work on:
>>>>>
>>>>> 1) prefixes on define constants for lpc32xx_ADC (then trying to move it
>>>>> out of staging and seeing what other issues people find?)
>>>>> 2) resolver/CDC ABI documentation cleanup
>>>>> 3) dummy driver fake event interrupt hack
>>>>> 4) Lars may have more ideas?
>>>>>
>>>>> The plan is for me to start working on this stuff full time next week,
>>>>> so if you think of anything more, please let me know!
>>>>
>>>> Haven't heard back from you about this. Have you found anything else
>>>> that needs to be done with staging IIO drivers before they can be moved out?
>>>
>>> IIO is a bit problematic since testing usually requires possessing the
>>> sensor chip
>>
>> Any specific chips / devices we should look into buying for these
>> drivers to help make it easier to do development?
On that note, perhaps ask for people to shout what they have access
to and we'll see what is left.

Of stuff still in staging I have:
* lis3l02dq (it's there because we probably want to add this part to the
   much more general st-sensors driver rather than moving it out as is).
* sca3000 (still there because we now have a better idea of how to handle
   chips with hardware buffers - route them through a software buffer,
   dropping the explicit trigger as done in the am35x driver last summer).

J

>>
>>> regarding staging/iio/magnetometer/hmc5843:
>>> the driver has one specific DEVICE_ATTR left (meas_conf), otherwise clean
>>> I think; so we could (a) document it as special ABI or (b) drop it
>>
>> Which is it?  It should be easy to delete a driver :)
> Drop the attribute, not the driver!
>>
>> thanks,
>>
>> greg k-h
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

