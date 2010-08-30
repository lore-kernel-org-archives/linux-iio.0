Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-31.csi.cam.ac.uk ([131.111.8.131]:44581 "EHLO
	ppsw-31.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753638Ab0H3OoK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 30 Aug 2010 10:44:10 -0400
Message-ID: <4C7BC4DC.50900@cam.ac.uk>
Date: Mon, 30 Aug 2010 15:49:00 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] staging:iio update documentation
References: <1283165728-2231-2-git-send-email-manuel.stahl@iis.fraunhofer.de> <1283177032-7014-1-git-send-email-manuel.stahl@iis.fraunhofer.de> <4C7BBEE2.4070007@cam.ac.uk> <4C7BBF16.1060502@iis.fraunhofer.de>
In-Reply-To: <4C7BBF16.1060502@iis.fraunhofer.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Manel
>>>
>>> +What:        /sys/.../device[n]/buffer/scan_elements
>> Is this not /sys/.../device[n]/buffer[m]/scan_elements? I think we allow
>> for multiple buffers per device.
>>> +KernelVersion:    2.6.37
>>> +Contact:    linux-iio@vger.kernel.org
>>> +Description:
>>> +        Directory containing interfaces for elements that will be captured
>>> +        for a single triggered sample set in the buffer.
>>> +
>>> +What:        /sys/.../device[n]/buffer/scan_elements/[m]_accel_x0_en
>> This needs some brackets... [_x0]
> 
> Depends on what we accord for the next version, there should be a patch removing the [m] and creating all the new files.

As I said in the other discussion.  That m (or direct equivalent) is vital.  Otherwise userspace has no way of knowing
the parameter ordering in what comes out of the buffer.  As things stand I haven't yet seen
any reason (beyond ls putting them in a nice order) for changing that element of the interface.

The brackets issue here is completely separate.  We have always allowed single dimension accelerometers
to not specify a direction.  And there are dual parallel accelerometer chips out there hence the need for
the optional number. 
> 
>>> +KernelVersion:    2.6.37
>>> +Contact:    linux-iio@vger.kernel.org
>>> +Description:
>>> +        Scan element control for triggered data capture. m implies the
>>> +        ordering within the buffer. Next the type is specified with
>>> +        modifier and channel number as per the sysfs single channel
>>> +        access above.
>>> +
>> Obviously the next two will get eaten up by your suggestion of 'type' the other
>> day, but best to keep the documentation matching what is actually in place so
>> I'm glad to see you updated them.
>>> +What:        /sys/.../device[n]/buffer/scan_elements/accel[_x0]_precision
>>> +KernelVersion:    2.6.37
>>> +Contact:    linux-iio@vger.kernel.org
>>> +Description:
>>> +        Scan element precision within the buffer. Note that the
>>> +        data alignment must restrictions must be read from within
>>> +        buffer to work out full data alignment for data read
>>> +        via buffer_access chrdev. _x0 dropped if shared across all
>>> +        acceleration channels.
>>> +
>>> +What:        /sys/.../device[n]/buffer/scan_elements/accel[_x0]_shift
>>> +KernelVersion:    2.6.37
>>> +Contact:    linux-iio@vger.kernel.org
>>> +Description:
>>> +        A bit shift (to right) that must be applied prior to
>>> +        extracting the bits specified by accel[_x0]_precision.
>>> +
>>> diff --git a/drivers/staging/iio/Documentation/userspace.txt b/drivers/staging/iio/Documentation/userspace.txt
>>> index 4838818..8bba2fa 100644
>>> --- a/drivers/staging/iio/Documentation/userspace.txt
>>> +++ b/drivers/staging/iio/Documentation/userspace.txt
>>> @@ -7,17 +7,14 @@ Typical sysfs entries (pruned for clarity)
>>>   /sys/class/iio
>>>     device0 - iio_dev related elements
>>>       name - driver specific identifier (here lis3l02dq)
>>> -    accel_x - polled (or from ring) raw readout of acceleration
>>> -    accel_x_gain - hardware gain (calibration)
>>> -    accel_x_offset - hardware offset (calibration)
>>> -    available_sampling_frequency
>>> +    accel_x_raw - polled (or from ring) raw readout of acceleration
>>> +    accel_x_offset - offset to be applied to the raw reading
>>> +    accel_x_scale - scale to be applied to the raw reading and offset
>>> +    accel_x_calibbias - hardware offset (calibration)
>>> +    accel_x_calibscale - hardware gain (calibration)
>> youch, Hadn't realised how out of date some of this has gotten.
>>
>> Actually we can probably drop most of this file.  It just replicates
>> the abi documentation (and predates it). Shall I do that once
>> your changes have merged, or do you want to loose everything down
>> to the Udev will create line?  Perhaps add something saying the sysfs
>> stuff is documented in the abi file?
> 
> Would be great if you do another docu review patch afterwards.

Cool, will do.  Then send this patch on as is with my 

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>

Perhaps naming it staging:iio partial documentation update

just to stop anyone pointing out that the documentation isn't perfect
after your patch!

Jonathan
