Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:59381 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848Ab1FGI3R (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 7 Jun 2011 04:29:17 -0400
Message-ID: <4DEDE33F.5020104@cam.ac.uk>
Date: Tue, 07 Jun 2011 09:37:19 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
CC: linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [lm-sensors] [RFC 5/5] hwmon: add support for Technologic Systems
 TS-5500 A-D converter
References: <1304115712-5299-1-git-send-email-vivien.didelot@savoirfairelinux.com>	<1304115712-5299-6-git-send-email-vivien.didelot@savoirfairelinux.com>	<20110430033938.GA14397@ericsson.com>	<1304434162-sup-3877@sfl>	<4DC1165C.4000103@cam.ac.uk> <20110606185658.73b29f39@v0nbox>
In-Reply-To: <20110606185658.73b29f39@v0nbox>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/06/11 23:56, Vivien Didelot wrote:
> Hi Jonathan,
> 
> On Wed, 04 May 2011 10:03:24 +0100,
> Jonathan Cameron <jic23@cam.ac.uk> wrote:
>>> Excerpts from Guenter Roeck's message of 2011-04-29 23:39:38 -0400:
>>>> Having said that, from reading the code it looks like the chip is
>>>> not really used for hardware monitoring, but for generic ADC
>>>> functionality. A quick look into the TS-5500 user manual confirms
>>>> this. So this should not be a hwmon driver in the first place, but
>>>> a generic ADC driver. Given the ADC conversion rate of the MAX197,
>>>> the hwmon ABI is not optimal anyway. You should move this driver
>>>> into the iio subsystem, probably to drivers/staging/iio/adc.
>>>> Copying the iio mailing list for input.
>>>>
>>>> Thanks,
>>>> Guenter
>>>
>>> I've took a closer look to the manual and that's right, in fact the
>>> driver doesn't talk to the MAX197 directly. The board uses a CPLD to
>>> abstract the interface to the MAX197. So all the MAX197 logic is
>>> hidden by the CPLD.  Therefore, the driver files should probably
>>> not have function and structure names with a "max197_" prefix. I'll
>>> make the code a bit clearer. What do you think?
>>>
>>> Ok for iio subsystem, several ADC drivers are in drivers/hwmon/ but
>>> drivers/staging/iio/adc seems to be the good place now.
>> Just as a heads up, beware there are a few abi changes (and a lot of
>> core ones) working their way through review /already in staging-next.
>> I only mention it because merges against that tree will go through
>> staging-next and as it's name suggests is sometimes a fast moving
>> target!
>>
>> Jonathan
> 
> For the moment I have a working driver for the TS-5500 A/D Converter in
> a arch/x86/platform/ts5500/ directory, but it is actually using the
> HWMON interface. I have to move it to the IIO subsystem as you
> suggested. Should it be in drivers/staging/iio/adc/ or can it stay in
> my platform directory, as it is a platform specific device?
Seeing the current effort going on to move drivers out of arch (first step
in all the Arm cleanups), I'd suggest we follow the herd.   Also, we are
still making a fair number of core changes and a lot of these change the
internal abis.  If it is elsewhere in the kernel, I for one am likely
to forget it exists, so I definitely want all drivers in drivers/staging/iio/adc

Also, you'd run into fun issues due to the fact we are in staging.  Nothing
outside of staging is supposed to depend on elements inside.

Jonathan
