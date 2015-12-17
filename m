Return-Path: <nish.aravamudan@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAOhV88MNVj9cs+VyjZGqW2T5-QTVFRJGj+VSHj-fuqXyQABsiA@mail.gmail.com>
References: <CAOhV88NP+bpN6oVk3_DbszNqKAo4T9z-umfVQAcyS3QArwguTA@mail.gmail.com>
	<CAEnQRZACu89UR2w=rN3mve8DFniqdf2=Y69FuBnoyXUber=kZA@mail.gmail.com>
	<CAOhV88PGnVWbnCjTf3W-jD22rtQYSXDVWez+gFkrPYky9kkQnw@mail.gmail.com>
	<CAKv63uvEKOycY2pPCRwVXvYR1yj8SbBaPJyw41_7mc4Vnftkew@mail.gmail.com>
	<CAOhV88OJZO_zO7WJ4WAvToAJGzcXp+zZ6y8v_xMeRgbBbhYrkg@mail.gmail.com>
	<CAKv63uv5806-ecxGXK8HSOSnoHciXp8UHBcyvEqYk14BX1snVQ@mail.gmail.com>
	<CAOhV88MNVj9cs+VyjZGqW2T5-QTVFRJGj+VSHj-fuqXyQABsiA@mail.gmail.com>
Date: Wed, 16 Dec 2015 21:27:38 -0800
Message-ID: <CAOhV88NrU1cXiMXkCpuZbGGkFiOet_ZxotusdZD5rA+76cyspw@mail.gmail.com>
Subject: Re: Issues with Lenovo Yoga 900 IIO devices (accelerometer, etc.)
From: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Crt Mori <cmo@melexis.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Wed, Dec 16, 2015 at 3:05 PM, Nish Aravamudan
<nish.aravamudan@gmail.com> wrote:
> On Wed, Dec 16, 2015 at 2:55 PM, Crt Mori <cmo@melexis.com> wrote:
>>
>> On Dec 16, 2015 11:37 PM, "Nish Aravamudan" <nish.aravamudan@gmail.com>
>> wrote:
>>>
>>> Hi,
>>>
>>> On Wed, Dec 16, 2015 at 2:22 PM, Crt Mori <cmo@melexis.com> wrote:
>>> > On 16 December 2015 at 22:41, Nish Aravamudan
>>> > <nish.aravamudan@gmail.com> wrote:
>>> >> Hi Daniel,
>>> >>
>>> >> On Wed, Dec 16, 2015 at 1:43 AM, Daniel Baluta
>>> >> <daniel.baluta@gmail.com> wrote:
>>> >>> On Tue, Dec 15, 2015 at 9:19 PM, Nish Aravamudan
>>> >>> <nish.aravamudan@gmail.com> wrote:
>>> >>>> So, I apologize in advance for this relatively vague report, but I'm
>>> >>>> fairly sure
>>> >>>> the Yoga 900 has an accelerometer amongst other sensors (ambient
>>> >>>> light?)
>>> >>>> exported over IIO.
>>> >>>>
>>> >>>> But, these sensors seem to not be updating at all with a 4.4-rc5+
>>> >>>> kernel (a
>>> >>>> set of patches from https://lkml.org/lkml/2015/11/30/441 applied to
>>> >>>> Linus'
>>> >>>> tree).
>>> >>>>
>>> >>>> The odd part is at some point in messing with this, I'm fairly sure
>>> >>>> it did work!
>>> >>>> That is,
>>> >>>>
>>> >>>> `watch -n 0.1 cat '/sys/bus/iio/devices/iio:device'*/*raw*`
>>> >>>
>>> >>> Can you send us a sample of the output? Also, would be
>>> >>> good to identify the exact driver for accel.
>>> >>
>>> >> cat /sys/bus/iio/devices/iio:device*/*raw*
>>> >> 65478
>>> >> 7
>>> >> 1023
>>> >> 0
>>> >> 0
>>> >> 0
>>> >> 100
>>> >> -539062
>>> >> -742187
>>> >> 1292968
>>> >> 1592
>>> >> 64932
>>> >> 2
>>> >> 275
>>> >> 0 0 0 0
>>> >>
>>> >> Now, I should say that I distinctly remember at some point waving my
>>> >> laptop around and seeing these values change ... but now they seem to
>>> >> be "stuck". Maybe it's a hardware issue or something special that
>>> >> WIndows does to leverage the IIO sensors?
>>> >>
>>> >>> Perhaps: cat /sys/bus/iio/devices/iio:device'*/name
>>> >>
>>> >> $ cat /sys/bus/iio/devices/iio:device*/name
>>> >> accel_3d
>>> >
>>> > Can you list the directory of iio:device with this name (it is:
>>> > drivers/iio/accel/hid-sensor-accel-3d.c).
>>> > This is something you will be looking at for accel debugging, but it
>>> > seems more like
>>> > standard
>>>
>>> /sys/bus/iio/devices/iio:device0/name
>>> gyro_3d
>>> /sys/bus/iio/devices/iio:device1/name
>>> dev_rotation
>>> /sys/bus/iio/devices/iio:device2/name
>>> als
>>> /sys/bus/iio/devices/iio:device3/name
>>> magn_3d
>>> /sys/bus/iio/devices/iio:device4/name
>>> accel_3d
>>> /sys/bus/iio/devices/iio:device5/name
>>> incli_3d
>>>
>>> are all the IIO sensors, sorry about that!
>>>
>>
>> I was more thinking what else is in iio:device4 directory, so that we can
>> see if it was initialized OK. Can you also grep the dmesg for any errors?
>
> Well, I just noticed the device #s are not consistent boot-to-boot, so
> this time it was device0. Trimming out the directories:
>
> /sys/bus/iio/devices/iio:device0/buffer
> cat: /sys/bus/iio/devices/iio:device0/buffer: Is a directory
> /sys/bus/iio/devices/iio:device0/dev
> 250:0
> /sys/bus/iio/devices/iio:device0/in_accel_hysteresis
> cat: /sys/bus/iio/devices/iio:device0/in_accel_hysteresis: Invalid argument
> /sys/bus/iio/devices/iio:device0/in_accel_offset
> 0
> /sys/bus/iio/devices/iio:device0/in_accel_sampling_frequency
> 8.000000
> /sys/bus/iio/devices/iio:device0/in_accel_scale
> 0.009806
> /sys/bus/iio/devices/iio:device0/in_accel_x_raw
> 65478
> /sys/bus/iio/devices/iio:device0/in_accel_y_raw
> 7
> /sys/bus/iio/devices/iio:device0/in_accel_z_raw
> 1023
> /sys/bus/iio/devices/iio:device0/name
> accel_3d
> /sys/bus/iio/devices/iio:device0/uevent
> MAJOR=250
> MINOR=0
> DEVNAME=iio:device0
> DEVTYPE=iio_device
>
> Another thing I just noticed:
>
> /sys/bus/iio/devices/iio:device0/buffer/enable
> 0
>
> The only error I'm getting consistently is:
>
> [    1.115327] i2c_hid i2c-ITE8396:00: error in i2c_hid_init_report
> size:19 / ret_size:18
>
> which I don't think is relevant, but I might be wrong.
>
>>> >> gyro_3d
>>> >> als
>>> >> magn_3d
>>> >> incli_3d
>>> >> dev_rotation
>>> >>
>>> >>
>>> >>>>
>>> >>>> showed updating values as I moved the laptop around.
>>> >>>>
>>> >>>> I've not done any accelerometer debugging before, so any suggestion
>>> >>>> on
>>> >>>> where to start would be greatly appreciated!
>>> >>>
>>> >>> Did you applied some patches and recompiled the kernel? Or when it did
>>> >>> stopped
>>> >>> working?
>>> >>
>>> >> As far as I can tell, it only worked that one one time and hasn't
>>> >> since. Although your question does make me wonder *which* kernel I was
>>> >> on that I experienced the values changing. Let me go back to a stock
>>> >> 4.4-rc5 and see.
>>> >
>>> > Did you compile the stock kernel? It might be that .dts file you are
>>> > using (or defconfig)
>>> > is not correct.
>>>
>>> I compiled the stock kernel, based off the the Ubuntu 15.04 .config,
>>> trimmed to account for the hardware I have on the system. I can attach
>>> the .config if that will be useful.
>>>
>>> I just went back to 4.4-rc4 and it also didn't seem to have any
>>> updates to the raw file contents.
>>>
>>
>> I hope full post of your defconfig will not be needed. However could you
>> double check that you have enabled all drivers for accel (check the kbuild
>> file in drivers/iio/accel). If they have driver for accel in main kernel (or
>> staging) then it will link with existing device tree nicely.
>
> I'll go back and enable everything just to be safe. Building now, will
> report the results once I have them.

Using the stock Ubuntu .config as the base, meaning many, many modules
(including all possible IIO accelerometers, it seems), I still see no
updates to the *raw* file contents.

-Nish
