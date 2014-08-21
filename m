Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-we0-f180.google.com ([74.125.82.180]:55619 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754810AbaHUWQH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 21 Aug 2014 18:16:07 -0400
Received: by mail-we0-f180.google.com with SMTP id w61so9877656wes.25
        for <linux-iio@vger.kernel.org>; Thu, 21 Aug 2014 15:16:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CA+BWVUSZDb_+gtLY5JeryMMfYRrQCkdYBUfG9m3rzL1P9wawYg@mail.gmail.com>
References: <CAN0s7yTK1_1u65nodysfiGxYbgKTeDS0Vf_+14KQJS92_Di1vg@mail.gmail.com>
 <CAN0s7yRwXGgPLhyucnR+=EybQFjunt66MKYvQuZnR_PSdgjS1Q@mail.gmail.com>
 <CA+BWVUSSO0kA1mW6BJ9F5VrZErK1D7YDOrA-gtuW5ZF3wNNZXA@mail.gmail.com>
 <CAN0s7yTYwEsu2uJ3kUjW-SsvoyqSXebNT3=1D1oNfdJwi=Q5Qw@mail.gmail.com> <CA+BWVUSZDb_+gtLY5JeryMMfYRrQCkdYBUfG9m3rzL1P9wawYg@mail.gmail.com>
From: Reyad Attiyat <reyad.attiyat@gmail.com>
Date: Thu, 21 Aug 2014 17:15:45 -0500
Message-ID: <CA+BWVUSvm54_xLeXGf0d5oo1-1DH_z=K1TFsrFLQHMBV_gA7gA@mail.gmail.com>
Subject: Re: Resource Temporarily Unavailable error when trying to read from
 the accelerator on a ThinkPad twist
To: Elad Alfassa <elad@fedoraproject.org>
Cc: linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

I made a mistake in the modprobe configuration file. It should read:

options hid_sensor_accel_3d dyndbg=+pmfl
options hid_sensor_iio_common dyndbg=+pmfl
options hid_sensor_hub dyndbg=+pmfl

I used dashes instead of commas for the modules names, which I don't
think works.

On Thu, Aug 21, 2014 at 1:27 PM, Reyad Attiyat <reyad.attiyat@gmail.com> wrote:
> Hello Elad,
>
> In order to confirm this is a bug against the newest kernel it is best
> to have steps to reproduce the issue. I understand that
> iio-sensor-proxy fails to read the iio accelerometer. This could be an
> issue with the kernel or with the application's uses of the
> sysfs/device driver interface.
>
> Documentation on the iio subsystem sysfs interface can be found here:
> https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-bus-iio
>
> The basic idea is store an iio device driver interface in the folder
> /sys/bus/iio/devices Each device will have a folder iio:deviceX. In
> each iio device directory there should be a "name" file, and a
> "buffer" and "scanning_elements" folder. The "name" file is simply the
> device driver name, for the accelerometer it should be called
> "accel-3d".
>
> To Test this driver you must enable the scanning elements, in this
> cases the axises (x, y, z), and then enable the buffer. To enable the
> scanning x axis element just write "1" into the file "in_accel_x".
> Example:
> # echo -n 1 > /sys/.../iio:deviceX/scan_elements/in_accel_x_en
> # echo -n 1 > /sys/.../iio:deviceX/scan_elements/in_accel_y_en
> # echo -n 1 > /sys/.../iio:deviceX/scan_elements/in_accel_z_en
>
> Now that  we have setup the data we wish to read, we can enable the
> internal iio scan buffer. This is done in a similar way, the iio sysfs
> folder "buffer" contains a file "enable" that we set to 1. Example:
> # echo -n 1 > /sys/bus/iio/devices/iio:deviceX/buffer/enable
>
> To read data from the buffer you must read the character device found
> at /dev/iio:deviceX, where X matches the same number for the syfs
> folder we were modifying. Example:
>
> #cat /dev/iio:deviceX
>
> The above is how the iio-sensor-proxy reads data. You should be aware
> that the charecter device (/dev/iio:deviceX) can only be read once, if
> some other app is already reading from this device it will return
> busy/resource unavailable. Therefore you must ensure nothing is
> reading from it already and that iio-sensor-proxy is disabled. This
> can be checked with command lsof. Example:
> # lsof | grep /dev/iio:deviceX
>
> From the steps above hopefully you can reproduce the same error, of
> not being able to read from the char device on the newest kernel. If
> the above commands all work correctly and data is returned it is
> mostly likely a bug in iio-sensor-proxy or some other part of the
> kernel that that application uses.
>
> To debug this iio device problem further it helps to enable extra
> debugging information. Dynamic debugging allows the user to enable
> switches to give extra information when the kernel prints debugging
> information. Documentation for dynamic debugging can be found here:
>
> https://www.kernel.org/doc/Documentation/dynamic-debug-howto.txt
>
> You can turn on dynamic debugging after boot by writing to the dynamic
> debugging file found in the debugfs interface. It is easier for me to
> enable the feature at boot. This is done by adding a line to the
> modprobe config. This can be found in /etc/modprobe.d/iio.conf. In
> this file add a line that enables dynamic debugging for modules
> hid-sensor-accel-3d and hid-sensor-hub. The lines should be:
>
>    options hid-sensor-accel-3d dyndbg=+pflt
>    options hid-sensor-hub dyndbg=+pflt
>
> This features needs debugging support in the kernel so it is best to
> build the newest kernel 3.17-rc1 with debugging to get the most output
> in dmesg.
>
> To access the devices usb hid report you can print this from the
> debugfs interface. You sent me "Bus 002 Device 003: ID 0483:91d1
> STMicroelectronics" from lsusb output. This means the usb device is
> found on bus 2 and is device 3. The usb hid id is 0483:91d1. The first
> half is the vendor id (STMicroelectronics) and the second half is the
> product id. The report information for this device will be found at:
> /sys/kernel/debug/hid/0483:91d1.X/rdesc
>
> Where X is the interface number if your device has more than one.
>
> I hope this information helps you and is all correct.
> If you need any more help please let me know,
> Reyad Attiyat
>
> On Tue, Aug 19, 2014 at 11:51 AM, Elad Alfassa <elad@fedoraproject.org> wrote:
>> Hey.
>>
>> can you instruct me on:
>>
>> 1) how to turn on this dynamic debugging thing?
>> 2) How do I know which directory in /sys/kernel/debug/hid/ is the one
>> for the accelerometer?
>>
>> The USB device ID is Bus 002 Device 003: ID 0483:91d1 STMicroelectronics
>>
>> The weird thing is that after suspend & resume, iio-sensor-proxy can
>> suddenly read the values from the sensor, but it still doesn't rotate
>> the screen.
>>
>>
>>
>> On Tue, Aug 12, 2014 at 7:42 PM, Reyad Attiyat <reyad.attiyat@gmail.com> wrote:
>>> Hello Elad Alfassa,
>>>
>>> I'm not too sure exactly what has caused such a regression but I will
>>> try and help. There was very little added to the accelerometer driver
>>> in between those releases only, some slight power modifications and
>>> raw read support.
>>>
>>> Have you tried using the sysfs interface for the IIO accelerometer.
>>> Should be located in /sys/bus/iio/devices/iio:devicex/
>>> In that directory, on the newest kernel, there should be a
>>> in_accel_x_raw file, can you read new data from this?
>>>
>>> Can you provide more detail about the error. Turn on dynamic debugging
>>> for hid-sensor-hub  and hid-sensor-accel-3d modules. Then try enabling
>>> the scan elements and the buffer with the sysfs interface and post the
>>> full dmesg output. Also print the HID report description found on
>>> debugfs usually somewhere like
>>> (/sys/kernel/debug/hid/xxxx:xxxx:/rdesc) Maybe with this extra
>>> information the problem will be more clear.
>>>
>>> For a possible fix you can try adding the devices USB HID ID's, for
>>> the sensor hub, to the hid-sensor-hub driver hid_device_id struct.
>>> This will allow adding a quirk for your device and should setup the
>>> power state and enable the sensor hub correctly.
>>>
>>> Good luck,
>>> Reyad Attiyat
>>>
>>> On Mon, Aug 11, 2014 at 8:51 AM, Elad Alfassa <elad@fedoraproject.org> wrote:
>>>> On Mon, Aug 11, 2014 at 3:16 PM, Elad Alfassa <elad@fedoraproject.org> wrote:
>>>>> Hi.
>>>>>
>>>>> I have a Thinkpad Twist, this is a Windows 8 certified machine from
>>>>> around 2012, and it has an accelerometer.
>>>>> Running kernel 3.16.0-1.fc22.x86_64, I'm getting "Resource Temporarily
>>>>> Unavailable" when trying to read from the accelerometer.
>>>>>
>>>>> Tiny bit more details:
>>>>> https://github.com/hadess/iio-sensor-proxy/issues/1
>>>>> https://sysdev.microsoft.com/en-us/hardware/LPL/ProductDetails.aspx?ProductID=98463&OrganizationID=4733
>>>>>
>>>>> Is this a known issue? Can I help debug this in any way?
>>>>>
>>>>>
>>>>> Thanks.
>>>>>
>>>>> --
>>>>> -Elad Alfassa.
>>>>
>>>> Hi.
>>>> Turns out this is a regression - it works well with kernel
>>>> 3.15.8-200.fc20.x86_64
>>>> I tried reporting this in the kernel bugzilla, but I couldn't find the
>>>> right component for the bug, so I filed it in RHBZ for now.
>>>> https://bugzilla.redhat.com/show_bug.cgi?id=1128760
>>>>
>>>>
>>>> --
>>>> -Elad Alfassa.
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>> --
>> -Elad Alfassa.
