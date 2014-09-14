Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:54592 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752513AbaINOMA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 14 Sep 2014 10:12:00 -0400
Message-ID: <5415A22E.2050802@kernel.org>
Date: Sun, 14 Sep 2014 15:11:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Bastien Nocera <hadess@hadess.net>,
	Daniel Baluta <daniel.baluta@intel.com>
CC: linux-iio@vger.kernel.org, srinivas.pandruvada@linux.intel.com
Subject: Re: [PATCH] iio:kxcjk-1013: Add support for SMO8500 device
References: <1410283148.4077.16.camel@hadess.net>		 <CAEnQRZD+cTqhBSfE2qeTHFh6zJ1a6L6Zrqt9YmTeGkQ9fAqbqg@mail.gmail.com>	 <1410459518.32328.24.camel@hadess.net> <5412E5FA.2070707@intel.com> <1410524654.32328.34.camel@hadess.net>
In-Reply-To: <1410524654.32328.34.camel@hadess.net>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/09/14 13:24, Bastien Nocera wrote:
> On Fri, 2014-09-12 at 15:24 +0300, Daniel Baluta wrote:
>> On 09/11/2014 09:18 PM, Bastien Nocera wrote:
>>> On Tue, 2014-09-09 at 21:53 +0300, Daniel Baluta wrote:
>>>> Hi Bastien,
>>>>
>>>> On Tue, Sep 9, 2014 at 8:19 PM, Bastien Nocera <hadess@hadess.net> wrote:
>>>>> The Onda v975w tablet contains an accelerometer that's advertised over
>>>>> ACPI as SMO8500. This device is however a KXCJ9 accelerometer as
>>>>> can be seen in the Windows driver's INF file.
>>>>> ---
>>>>>
>>>>> I tested the patch, and it works correctly in my testing. However,
>>>>> there's no GPIO pin for the "data ready" interrupt, and this throws an
>>>>> error that looks fatal in the logs (could this be downgraded?), and
>>>>> the name of the device doesn't match the hid-sensor-hub ones, making it
>>>>> hard for user-space to discover them.
>>>>> (https://github.com/hadess/iio-sensor-proxy is my attempt at something
>>>>>   that integrates with user-space and the IIO sensors)
>>>>>
>> How did you test it?
> 
> Cat on the /sys files for each of the axis. I can see the values of
> x/y/z changing depending on the position of the device.
> 
>>  There is no GpioInt associated with your device in 
>> the the .dsl file.
> 
> I know, that's because the GPIO (according to the driver) is only used
> to know when there's more data to be read. We just have to poll
> instead...
> 
>> What kind of error do you see in the logs?
> 
> The "acpi gpio get index failed" error when it fails to find a GPIO pin
> for the "data ready" interrupt. Except that it works just fine without
> such an interrupt.
> 
>>>> How does your ACPI .dsl file looks like?
>>>>
>>>>> It will also conflict with Daniel's patch here:
>>>>> http://www.spinics.net/lists/linux-iio/msg14438.html
>>>> It shouldn't. The patch is already in togreg branch of Jonathan's tree
>>>> [1]. Anyhow,
>>>> it will conflict with this one [2].
>>> Do you want me to rebase the patch on a particular tree? Do you need any
>>> particular changes done in my commit message or patch to get this
>>> merged?
>>>
>> I would suggest you wait until Jonathan merges this patch [1] in togreg 
>> branch [2].
>> Then rebase your patch on togreg branch and get feedback from Jonathan 
>> and Srinivas.
I've applied the patch [1] to my local copy and pushed out as testing.
Once the autobuilders come back to me in an hour or so, I'll push it out as
the togreg branch. I'm planning a pull request to Greg tonight at which point
it will head for linux-next.
> 
> OK, I'll have to monitor those.
> 
> Cheers
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
