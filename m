Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60495 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636AbcGXS4k (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 24 Jul 2016 14:56:40 -0400
Subject: Re: [PATCH v2] iio: accel: add support for the Domintech DMARD09
 3-axis accelerometer
To: Jelle van der Waa <jelle@vdwaa.nl>
References: <20160716195152.30109-1-jelle@vdwaa.nl>
 <20160718205423.13081-1-jelle@vdwaa.nl>
 <68c86474-aa4b-bb96-f412-38bafe3b9ff1@kernel.org>
 <20160724141107.GA3781@gmail.com>
Cc: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <80fbac7c-4657-14e1-e9ce-a3d2ffc8dd2f@kernel.org>
Date: Sun, 24 Jul 2016 19:56:35 +0100
MIME-Version: 1.0
In-Reply-To: <20160724141107.GA3781@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/07/16 15:11, Jelle van der Waa wrote:
> On 07/24/16 at 02:25pm, Jonathan Cameron wrote:
>> Hi Jelle,
>>
>> One quick process thing first.  If you are sending a new version, please
>> don't send it as a reply to the previous.  I leads to convoluted
>> and very deep threads where it isn't always clear which version
>> is being replied to!
> 
> Thanks,
> 
> I'm quiet new to Linux kernel development. I hope to address the last
> few comments today and send out a v3.
Cool, looking forward to it.  I may not be able to look at it
for a few weeks though as will be travelling a fair bit from next
Saturday.  May be mid August before I am able to get back on top
of things.

Jonathan
> 
> 
> ---
> Jelle van der Waa
> 
>>
>> Thanks,
>>
>> Jonathan
>>
>> On 18/07/16 21:54, Jelle van der Waa wrote:
>>> This patch adds basic read_raw support for the DMARD09 3-axis accelerometer
>>> which can be found in a q8 A33 Allwinner tablet. [0]
>>>
>>> The driver is based on the Android driver which can be found
>>> on Github. [1]
>>>
>>> Unfortunately there is no datatsheet of the DMARD09 available online.
>>>
>>> [0] http://linux-sunxi.org/TZX-723Qa4
>>> [1] https://github.com/JujuXIII/android_kernel_acer_v370_KK/tree/master/mediatek/custom/common/kernel/accelerometer/dmard09
>>>
>>> Changes in v2:
>>>   - Use ARRAY_SIZE instead of the #define DMARD09_AXES_NUM
>>>   - Use a function-like macro to generate the channel structs
>>>   - Remove duplicate 3-axis in driver description
>>>   - Don't initialize the u8 buf
>>>   - Use devm_iio_device_register and remove the now unrequired
>>>     dmard09_remove.
>>>   - Remove device from dmard09_data struct and use the client member to retrieve
>>>     the device.
>>>   - Describe the read strategy of the read_raw function
>>>   - Simplify reading the X, Y, Z axis, by introducing DMARD09_AXIS_N_OFFSET,
>>>         which removes the required if statements.
>>>   - Log the _STAT address in the dev_error in the dmard09_read_raw function.
>>>
>>>
>>> Jelle van der Waa (1):
>>>   iio: accel: add support for the Domintech DMARD09 3-axis accelerometer
>>>
>>>  .../devicetree/bindings/iio/accel/dmard09.txt      |  13 ++
>>>  drivers/iio/accel/Kconfig                          |  10 ++
>>>  drivers/iio/accel/Makefile                         |   1 +
>>>  drivers/iio/accel/dmard09.c                        | 149 +++++++++++++++++++++
>>>  4 files changed, 173 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/iio/accel/dmard09.txt
>>>  create mode 100644 drivers/iio/accel/dmard09.c
>>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

