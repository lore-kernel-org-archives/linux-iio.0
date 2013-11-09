Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51491 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126Ab3KIKus (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 9 Nov 2013 05:50:48 -0500
Message-ID: <527E21D1.4070706@kernel.org>
Date: Sat, 09 Nov 2013 11:51:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Dongsoo Nathaniel Kim <dongsoo.kim@gmail.com>
CC: linux-iio@vger.kernel.org
Subject: Re: About MLX90620 thermal array sensor (IR sensor)
References: <CAP+Vy9cm0apYAzEEV0mYn=2-Pq88eyZqR5_ERbd-Deto6c0cpg@mail.gmail.com> <69adfeb3-ef16-4cd4-a32b-db7be3b1b90b@email.android.com> <CAP+Vy9eJscydzxfw5HQhK7kroDZ=P+zzFmxFcn2zyqaGEJ=Wyg@mail.gmail.com>
In-Reply-To: <CAP+Vy9eJscydzxfw5HQhK7kroDZ=P+zzFmxFcn2zyqaGEJ=Wyg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/06/13 23:06, Dongsoo Nathaniel Kim wrote:
> Hi Jonathan,
> 
> On Thu, Nov 7, 2013 at 2:17 AM, Jonathan Cameron <jic23@kernel.org> wrote:
>> Hi Nate
>>
>> Dongsoo Nathaniel Kim <dongsoo.kim@gmail.com> wrote:
>>> Hi folks,
>>>
>>> I'm working on a 16x4 thermal array sensor from Melexis which parts
>>> number is MLX90620.
>>>
>>> Here is the datasheet of this device:
>>> http://www.melexis.com/Asset/Datasheet-IR-thermometer-16X4-sensor-array-MLX90620-DownloadLink-6099.aspx
>> Interesting little device.
>>>
>>> This device runs with 4 operation pins including I2C SCL and SDA,
>>> other two are VCC and ground.
>>>
>>> The IC alone cannot operate but needs some sort of resistors and
>>> electrical parts in form of break out board.
>>>
>>> *But there is no change in using I2C and 5V in*
>>>
>>> I'd like to ask you for a pointer to make driver name which I want to
>>> put in IIO framework.
>>>
>>> The breakout board name is RM-G212 from RoBoard and the standalone IC
>>> name is MLX90620.
>>>
>>> Which one will be appropriate for the driver name?
>> mlx... If the breakout board does anything to change the operation it should be represented in terms of regulators or other
>>  similar parts with perhaps a device tree snippet that others can use.
> 
> Currently I attached this breakout VCC to my target board GPIO header
> which gives out 5V. This breakout board provides only power indicator
> LED and I2C pullup resistors and vcc in, ground, i2c scl, sda are all
> on mlx device.
Doesn't sound like there is anything on their that would need describing.
> 
>>>
>>> rm-g212.c ? or mlx90620.c
>>>
>>> Sorry to bother you with such a trivial thing, but I thought the
>>> naming must be important when someone wants to try out his mlx90620
>>> device on Linux and looking for the driver.
>>> (And I'm also confused)
>>
>> Another interesting question is whether array sensors like this should be handled as cameras or whether IIO makes more sense.
>> If in IIO we need to think about how to handle the array coordinates.
> 
> I had in my mind to handle like a camera as a part of V4L2 but this
> device doesn't give out data in any colorspace but just temperature
> value per pixel.
There are plenty of black and white optical cameras out there and there is
always the option of adding core support to describe that it is a temperature
'camera'.
> It just works like a temperature sensor with 64 sensor heads.
The issue I have is establishing precedence.  What happens when a 128x128 element
thermal camera comes up? At what point do we make the jump to deciding they are
actually cameras?
> 
> 
>>
>> What do others think?
>>>
>>> Cheers,
>>>
>>> Nate
>>
>> --
>> Sent from my Android phone with K-9 Mail. Please excuse my brevity.
> 
> 
> 
