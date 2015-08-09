Return-Path: <linux@roeck-us.net>
Message-ID: <55C7B647.9040003@roeck-us.net>
Date: Sun, 09 Aug 2015 13:21:27 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>, Jonathan Cameron <jic23@kernel.org>,
 Ludovic Tancerel <ludovic.tancerel@maplehightech.com>,
 lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
 William.Markezana@meas-spec.com, Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH V2 3/6] iio: Add tsys02d meas-spec driver support
References: <1438248345-25820-1-git-send-email-ludovic.tancerel@maplehightech.com> <1438248345-25820-4-git-send-email-ludovic.tancerel@maplehightech.com> <55C63917.1030905@kernel.org> <55C74888.7060001@roeck-us.net> <55C7B45B.6040005@gmx.de>
In-Reply-To: <55C7B45B.6040005@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 08/09/2015 01:13 PM, Hartmut Knaack wrote:
> Guenter Roeck schrieb am 09.08.2015 um 14:33:
>> On 08/08/2015 10:15 AM, Jonathan Cameron wrote:
>>> On 30/07/15 10:25, Ludovic Tancerel wrote:
>>> The battery low indicator is certainly 'unusual' and undocumented on the
>>> datasheet mentioned here.
>>>
>>> Ah well.  Same owner point as with the previous driver. Otherwise
>>> seems fine to me.  Have cc'd the hwmon guys in case they have comments.
>>>
>>> Guenter / Jean, I would be more doubtful about having what is basically
>>> a straight forward (if accurate) temperature IC in IIO except that
>>> this is part of a series of parts including humidity and pressure sensors
>>> in combined forms which are more common IIO fodder.
>>
>> Agreed; I would really not like to have common code between iio and hwmon.
>>
>> Does the series include support for htu21d ? If so, we should probably drop
>> that driver from hwmon after it is available in iio.
>
> Yes, it does.
>
> http://www.spinics.net/lists/linux-iio/msg19918.html
>

Ok, then let's drop it from hwmon after the iio driver is in mainline.

Guenter
