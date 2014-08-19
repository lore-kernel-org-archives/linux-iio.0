Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-vc0-f175.google.com ([209.85.220.175]:33343 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753460AbaHSQv4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 19 Aug 2014 12:51:56 -0400
Received: by mail-vc0-f175.google.com with SMTP id ik5so7595409vcb.6
        for <linux-iio@vger.kernel.org>; Tue, 19 Aug 2014 09:51:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CA+BWVUSSO0kA1mW6BJ9F5VrZErK1D7YDOrA-gtuW5ZF3wNNZXA@mail.gmail.com>
References: <CAN0s7yTK1_1u65nodysfiGxYbgKTeDS0Vf_+14KQJS92_Di1vg@mail.gmail.com>
	<CAN0s7yRwXGgPLhyucnR+=EybQFjunt66MKYvQuZnR_PSdgjS1Q@mail.gmail.com>
	<CA+BWVUSSO0kA1mW6BJ9F5VrZErK1D7YDOrA-gtuW5ZF3wNNZXA@mail.gmail.com>
Date: Tue, 19 Aug 2014 19:51:55 +0300
Message-ID: <CAN0s7yTYwEsu2uJ3kUjW-SsvoyqSXebNT3=1D1oNfdJwi=Q5Qw@mail.gmail.com>
Subject: Re: Resource Temporarily Unavailable error when trying to read from
 the accelerator on a ThinkPad twist
From: Elad Alfassa <elad@fedoraproject.org>
To: Reyad Attiyat <reyad.attiyat@gmail.com>
Cc: linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hey.

can you instruct me on:

1) how to turn on this dynamic debugging thing?
2) How do I know which directory in /sys/kernel/debug/hid/ is the one
for the accelerometer?

The USB device ID is Bus 002 Device 003: ID 0483:91d1 STMicroelectronics

The weird thing is that after suspend & resume, iio-sensor-proxy can
suddenly read the values from the sensor, but it still doesn't rotate
the screen.



On Tue, Aug 12, 2014 at 7:42 PM, Reyad Attiyat <reyad.attiyat@gmail.com> wrote:
> Hello Elad Alfassa,
>
> I'm not too sure exactly what has caused such a regression but I will
> try and help. There was very little added to the accelerometer driver
> in between those releases only, some slight power modifications and
> raw read support.
>
> Have you tried using the sysfs interface for the IIO accelerometer.
> Should be located in /sys/bus/iio/devices/iio:devicex/
> In that directory, on the newest kernel, there should be a
> in_accel_x_raw file, can you read new data from this?
>
> Can you provide more detail about the error. Turn on dynamic debugging
> for hid-sensor-hub  and hid-sensor-accel-3d modules. Then try enabling
> the scan elements and the buffer with the sysfs interface and post the
> full dmesg output. Also print the HID report description found on
> debugfs usually somewhere like
> (/sys/kernel/debug/hid/xxxx:xxxx:/rdesc) Maybe with this extra
> information the problem will be more clear.
>
> For a possible fix you can try adding the devices USB HID ID's, for
> the sensor hub, to the hid-sensor-hub driver hid_device_id struct.
> This will allow adding a quirk for your device and should setup the
> power state and enable the sensor hub correctly.
>
> Good luck,
> Reyad Attiyat
>
> On Mon, Aug 11, 2014 at 8:51 AM, Elad Alfassa <elad@fedoraproject.org> wrote:
>> On Mon, Aug 11, 2014 at 3:16 PM, Elad Alfassa <elad@fedoraproject.org> wrote:
>>> Hi.
>>>
>>> I have a Thinkpad Twist, this is a Windows 8 certified machine from
>>> around 2012, and it has an accelerometer.
>>> Running kernel 3.16.0-1.fc22.x86_64, I'm getting "Resource Temporarily
>>> Unavailable" when trying to read from the accelerometer.
>>>
>>> Tiny bit more details:
>>> https://github.com/hadess/iio-sensor-proxy/issues/1
>>> https://sysdev.microsoft.com/en-us/hardware/LPL/ProductDetails.aspx?ProductID=98463&OrganizationID=4733
>>>
>>> Is this a known issue? Can I help debug this in any way?
>>>
>>>
>>> Thanks.
>>>
>>> --
>>> -Elad Alfassa.
>>
>> Hi.
>> Turns out this is a regression - it works well with kernel
>> 3.15.8-200.fc20.x86_64
>> I tried reporting this in the kernel bugzilla, but I couldn't find the
>> right component for the bug, so I filed it in RHBZ for now.
>> https://bugzilla.redhat.com/show_bug.cgi?id=1128760
>>
>>
>> --
>> -Elad Alfassa.
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
-Elad Alfassa.
