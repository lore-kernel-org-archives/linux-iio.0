Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:36504 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163AbbLQSjh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 17 Dec 2015 13:39:37 -0500
Received: by mail-lb0-f177.google.com with SMTP id yq9so31378674lbb.3
        for <linux-iio@vger.kernel.org>; Thu, 17 Dec 2015 10:39:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAOhV88P3wbf6Jhx+yyhbiWLKWYek8AzKuki-Smy9TX_XTfQYwQ@mail.gmail.com>
References: <CAOhV88NP+bpN6oVk3_DbszNqKAo4T9z-umfVQAcyS3QArwguTA@mail.gmail.com>
 <CAEnQRZACu89UR2w=rN3mve8DFniqdf2=Y69FuBnoyXUber=kZA@mail.gmail.com>
 <CAOhV88PGnVWbnCjTf3W-jD22rtQYSXDVWez+gFkrPYky9kkQnw@mail.gmail.com>
 <CAKv63uvEKOycY2pPCRwVXvYR1yj8SbBaPJyw41_7mc4Vnftkew@mail.gmail.com>
 <CAOhV88OJZO_zO7WJ4WAvToAJGzcXp+zZ6y8v_xMeRgbBbhYrkg@mail.gmail.com>
 <CAKv63uv5806-ecxGXK8HSOSnoHciXp8UHBcyvEqYk14BX1snVQ@mail.gmail.com>
 <CAOhV88MNVj9cs+VyjZGqW2T5-QTVFRJGj+VSHj-fuqXyQABsiA@mail.gmail.com>
 <CAOhV88NrU1cXiMXkCpuZbGGkFiOet_ZxotusdZD5rA+76cyspw@mail.gmail.com>
 <CAKv63ut15dRMLq4Te7i5ww7WyQD302oEiu+7EivsVSuBfxd2dA@mail.gmail.com>
 <CAOhV88Ot+--hsrZNuD2g8m_32YoaB2ZEyC7aHvOt_zd7JNOneQ@mail.gmail.com> <CAOhV88P3wbf6Jhx+yyhbiWLKWYek8AzKuki-Smy9TX_XTfQYwQ@mail.gmail.com>
From: Crt Mori <cmo@melexis.com>
Date: Thu, 17 Dec 2015 19:38:55 +0100
Message-ID: <CAKv63usQLowH_F4J7R551hdHGyu-ruHr7Fc9KLuLW921FOn65g@mail.gmail.com>
Subject: Re: Issues with Lenovo Yoga 900 IIO devices (accelerometer, etc.)
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17 December 2015 at 19:10, Nish Aravamudan <nish.aravamudan@gmail.com> wrote:
> On Thu, Dec 17, 2015 at 9:32 AM, Nish Aravamudan
> <nish.aravamudan@gmail.com> wrote:
>> On Thu, Dec 17, 2015 at 12:41 AM, Crt Mori <cmo@melexis.com> wrote:
>>> On 17 December 2015 at 06:27, Nish Aravamudan <nish.aravamudan@gmail.com> wrote:
>>>> On Wed, Dec 16, 2015 at 3:05 PM, Nish Aravamudan
>>>> <nish.aravamudan@gmail.com> wrote:
>>>>> On Wed, Dec 16, 2015 at 2:55 PM, Crt Mori <cmo@melexis.com> wrote:
>>>>>>
>>>>>> On Dec 16, 2015 11:37 PM, "Nish Aravamudan" <nish.aravamudan@gmail.com>
>>>>>> wrote:
>>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>> On Wed, Dec 16, 2015 at 2:22 PM, Crt Mori <cmo@melexis.com> wrote:
>>>>>>> > On 16 December 2015 at 22:41, Nish Aravamudan
>>>>>>> > <nish.aravamudan@gmail.com> wrote:
>>>>>>> >> Hi Daniel,
>>>>>>> >>
>>>>>>> >> On Wed, Dec 16, 2015 at 1:43 AM, Daniel Baluta
>>>>>>> >> <daniel.baluta@gmail.com> wrote:
>>>>>>> >>> On Tue, Dec 15, 2015 at 9:19 PM, Nish Aravamudan
>>>>>>> >>> <nish.aravamudan@gmail.com> wrote:
>>>>>>> >>>> So, I apologize in advance for this relatively vague report, but I'm
>>>>>>> >>>> fairly sure
>>>>>>> >>>> the Yoga 900 has an accelerometer amongst other sensors (ambient
>>>>>>> >>>> light?)
>>>>>>> >>>> exported over IIO.
>>>>>>> >>>>
>>>>>>> >>>> But, these sensors seem to not be updating at all with a 4.4-rc5+
>>>>>>> >>>> kernel (a
>>>>>>> >>>> set of patches from https://lkml.org/lkml/2015/11/30/441 applied to
>>>>>>> >>>> Linus'
>>>>>>> >>>> tree).
>>>>>>> >>>>
>>>>>>> >>>> The odd part is at some point in messing with this, I'm fairly sure
>>>>>>> >>>> it did work!
>>>>>>> >>>> That is,
>>>>>>> >>>>
>>>>>>> >>>> `watch -n 0.1 cat '/sys/bus/iio/devices/iio:device'*/*raw*`
>>>>>>> >>>
>>>>>>> >>> Can you send us a sample of the output? Also, would be
>>>>>>> >>> good to identify the exact driver for accel.
>>>>>>> >>
>>>>>>> >> cat /sys/bus/iio/devices/iio:device*/*raw*
>>>>>>> >> 65478
>>>>>>> >> 7
>>>>>>> >> 1023
>>>>>>> >> 0
>>>>>>> >> 0
>>>>>>> >> 0
>>>>>>> >> 100
>>>>>>> >> -539062
>>>>>>> >> -742187
>>>>>>> >> 1292968
>>>>>>> >> 1592
>>>>>>> >> 64932
>>>>>>> >> 2
>>>>>>> >> 275
>>>>>>> >> 0 0 0 0
>>>>>>> >>
>>>>>>> >> Now, I should say that I distinctly remember at some point waving my
>>>>>>> >> laptop around and seeing these values change ... but now they seem to
>>>>>>> >> be "stuck". Maybe it's a hardware issue or something special that
>>>>>>> >> WIndows does to leverage the IIO sensors?
>>>>>>> >>
>>>>>>> >>> Perhaps: cat /sys/bus/iio/devices/iio:device'*/name
>>>>>>> >>
>>>>>>> >> $ cat /sys/bus/iio/devices/iio:device*/name
>>>>>>> >> accel_3d
>>>>>>> >
>>>>>>> > Can you list the directory of iio:device with this name (it is:
>>>>>>> > drivers/iio/accel/hid-sensor-accel-3d.c).
>>>>>>> > This is something you will be looking at for accel debugging, but it
>>>>>>> > seems more like
>>>>>>> > standard
>>>>>>>
>>>>>>> /sys/bus/iio/devices/iio:device0/name
>>>>>>> gyro_3d
>>>>>>> /sys/bus/iio/devices/iio:device1/name
>>>>>>> dev_rotation
>>>>>>> /sys/bus/iio/devices/iio:device2/name
>>>>>>> als
>>>>>>> /sys/bus/iio/devices/iio:device3/name
>>>>>>> magn_3d
>>>>>>> /sys/bus/iio/devices/iio:device4/name
>>>>>>> accel_3d
>>>>>>> /sys/bus/iio/devices/iio:device5/name
>>>>>>> incli_3d
>>>>>>>
>>>>>>> are all the IIO sensors, sorry about that!
>>>>>>>
>>>>>>
>>>>>> I was more thinking what else is in iio:device4 directory, so that we can
>>>>>> see if it was initialized OK. Can you also grep the dmesg for any errors?
>>>>>
>>>>> Well, I just noticed the device #s are not consistent boot-to-boot, so
>>>>> this time it was device0. Trimming out the directories:
>>>>>
>>>
>>> This is correct/intended. You need to confirm "deviceX/name" each time.
>>
>> Got it!
>>
>>>>> /sys/bus/iio/devices/iio:device0/buffer
>>>>> cat: /sys/bus/iio/devices/iio:device0/buffer: Is a directory
>>>>> /sys/bus/iio/devices/iio:device0/dev
>>>>> 250:0
>>>>> /sys/bus/iio/devices/iio:device0/in_accel_hysteresis
>>>>> cat: /sys/bus/iio/devices/iio:device0/in_accel_hysteresis: Invalid argument
>>>>> /sys/bus/iio/devices/iio:device0/in_accel_offset
>>>>> 0
>>>>> /sys/bus/iio/devices/iio:device0/in_accel_sampling_frequency
>>>>> 8.000000
>>>>> /sys/bus/iio/devices/iio:device0/in_accel_scale
>>>>> 0.009806
>>>>> /sys/bus/iio/devices/iio:device0/in_accel_x_raw
>>>>> 65478
>>>>> /sys/bus/iio/devices/iio:device0/in_accel_y_raw
>>>>> 7
>>>>> /sys/bus/iio/devices/iio:device0/in_accel_z_raw
>>>>> 1023
>>>
>>> This seems like a valid number 1023 * 0.009806 = 10,031 m/s2 but X does not.
>>
>> Ok...
>>
>>>>> /sys/bus/iio/devices/iio:device0/name
>>>>> accel_3d
>>>>> /sys/bus/iio/devices/iio:device0/uevent
>>>>> MAJOR=250
>>>>> MINOR=0
>>>>> DEVNAME=iio:device0
>>>>> DEVTYPE=iio_device
>>>>>
>>>>> Another thing I just noticed:
>>>>>
>>>>> /sys/bus/iio/devices/iio:device0/buffer/enable
>>>>> 0
>>>
>>> This is buffer enable not chip enable. You can write 1 to that so it
>>> will be enables
>>> (echo "1" > /sys/bus/iio/devices/.../buffer/enable) and see what
>>> happens. It might be
>>> that it needs buffer to update properly (I haven't checked the code).
>>
>> Doesn't immediately seem to make a difference.
>>
>>>>>
>>>>> The only error I'm getting consistently is:
>>>>>
>>>>> [    1.115327] i2c_hid i2c-ITE8396:00: error in i2c_hid_init_report
>>>>> size:19 / ret_size:18
>>>>>
>>>>> which I don't think is relevant, but I might be wrong.
>>>
>>> If accel is i2c this might be a relevant error - and probe would also
>>> not fail, but error would
>>> repeat itself each time probably Maybe track where that line is in
>>> i2c_hid and see what it
>>> could mean.
>>
>> i2c_hid i2c-ITE8396:00: report (len=19): 12 00 5a ff ff ff ff ff ff ff
>> ff ff ff ff ff ff ff ff 06
>> i2c_hid i2c-ITE8396:00: error in i2c_hid_init_report size:19 / ret_size:18
>>
>> So it seems like the device indicates an expected return size of 18,
>> but actually gives 19 bytes.
>>
>> I don't know anything about i2c, but i'll dig around.
>

There is chance to read the /sys/bus/i2c/... device (maybe see the
address there?) directly.
However I would expect an i2c error each time you try to read a raw
value in driver if there would
be some. I hope someone more experienced can chime in...

> Another thought I had, reading through Google results for other Yoga
> laptops, the sensor device showed up in lsusb. Would I expect to see
> any such device in lsusb for the Yoga 900? I only get:
>
> Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> Bus 001 Device 003: ID 8087:0a2b Intel Corp.
> Bus 001 Device 002: ID 13d3:5664 IMC Networks
> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
>

I somehow doubt that accel is an usb device (which is what lsusb would
show), but if it
does then it should not show in iio.
There is however iioutils package which is around same as lsusb and
might be worth checking
out for you.
