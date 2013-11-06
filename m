Return-Path: <dongsoo.kim@gmail.com>
MIME-Version: 1.0
In-Reply-To: <69adfeb3-ef16-4cd4-a32b-db7be3b1b90b@email.android.com>
References: <CAP+Vy9cm0apYAzEEV0mYn=2-Pq88eyZqR5_ERbd-Deto6c0cpg@mail.gmail.com>
 <69adfeb3-ef16-4cd4-a32b-db7be3b1b90b@email.android.com>
From: Dongsoo Nathaniel Kim <dongsoo.kim@gmail.com>
Date: Thu, 7 Nov 2013 08:06:26 +0900
Message-ID: <CAP+Vy9eJscydzxfw5HQhK7kroDZ=P+zzFmxFcn2zyqaGEJ=Wyg@mail.gmail.com>
Subject: Re: About MLX90620 thermal array sensor (IR sensor)
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

On Thu, Nov 7, 2013 at 2:17 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> Hi Nate
>
> Dongsoo Nathaniel Kim <dongsoo.kim@gmail.com> wrote:
>>Hi folks,
>>
>>I'm working on a 16x4 thermal array sensor from Melexis which parts
>>number is MLX90620.
>>
>>Here is the datasheet of this device:
>>http://www.melexis.com/Asset/Datasheet-IR-thermometer-16X4-sensor-array-MLX90620-DownloadLink-6099.aspx
> Interesting little device.
>>
>>This device runs with 4 operation pins including I2C SCL and SDA,
>>other two are VCC and ground.
>>
>>The IC alone cannot operate but needs some sort of resistors and
>>electrical parts in form of break out board.
>>
>>*But there is no change in using I2C and 5V in*
>>
>>I'd like to ask you for a pointer to make driver name which I want to
>>put in IIO framework.
>>
>>The breakout board name is RM-G212 from RoBoard and the standalone IC
>>name is MLX90620.
>>
>>Which one will be appropriate for the driver name?
> mlx... If the breakout board does anything to change the operation it should be represented in terms of regulators or other
>  similar parts with perhaps a device tree snippet that others can use.

Currently I attached this breakout VCC to my target board GPIO header
which gives out 5V. This breakout board provides only power indicator
LED and I2C pullup resistors and vcc in, ground, i2c scl, sda are all
on mlx device.

>>
>>rm-g212.c ? or mlx90620.c
>>
>>Sorry to bother you with such a trivial thing, but I thought the
>>naming must be important when someone wants to try out his mlx90620
>>device on Linux and looking for the driver.
>>(And I'm also confused)
>
> Another interesting question is whether array sensors like this should be handled as cameras or whether IIO makes more sense.
> If in IIO we need to think about how to handle the array coordinates.

I had in my mind to handle like a camera as a part of V4L2 but this
device doesn't give out data in any colorspace but just temperature
value per pixel.
It just works like a temperature sensor with 64 sensor heads.


>
> What do others think?
>>
>>Cheers,
>>
>>Nate
>
> --
> Sent from my Android phone with K-9 Mail. Please excuse my brevity.



-- 
=
Dongsoo Nathaniel Kim
Linux kernel, media device S/W engineer / Ph.D Student
Dept. of Computer Science, KAIST
Real-time & Embedded Systems Lab.
