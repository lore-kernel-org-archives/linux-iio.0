Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53]:33789 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753951AbaF3Dsx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 29 Jun 2014 23:48:53 -0400
Received: by mail-qg0-f53.google.com with SMTP id i50so1475156qgf.26
        for <linux-iio@vger.kernel.org>; Sun, 29 Jun 2014 20:48:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <53B02CA9.4020905@roeck-us.net>
References: <CAJKbBDDYdGATTtW0Vz6v1iqnwkLgjj8dB8-dgM0xPAb+UkHvAg@mail.gmail.com>
 <53B02147.1000608@telliq.com> <53B02CA9.4020905@roeck-us.net>
From: Naveen Krishna Ch <naveenkrishna.ch@gmail.com>
Date: Mon, 30 Jun 2014 09:18:32 +0530
Message-ID: <CAHfPSqBwePFc5FfC-c0bAQ89s8Ga+vAizP+_mB6E1qE1DJCESg@mail.gmail.com>
Subject: Re: hwmon: ntc_thermistor: Add another ntc(epcos) to the driver
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jan Kardell <jan.kardell@telliq.com>,
	Johannes Pointner <johannes.pointner@gmail.com>,
	Jean Delvare <jdelvare@suse.de>,
	Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
	lm-sensors@lm-sensors.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Johannes Pointner skriver,


On 29 June 2014 20:41, Guenter Roeck <linux@roeck-us.net> wrote:
> On 06/29/2014 07:23 AM, Jan Kardell wrote:
>>
>> Johannes Pointner skriver:
>>>
>>> As I saw in the latest patches for the ntc_thermistor, in which as
>>> part of the patch the module description changed to :
>>>
>>> MODULE_DESCRIPTION("NTC Thermistor Driver from Murata");
>>>
>>> I wanted to know if it is intended to extend the driver for further
>>> manufacturers like in my case for an epcos ntc in the future?

The ntc_thermistor.c currently, supports ncpXXXX
(all thermistors from Murata).  Thus, My assumption.

Please post your patches for supporting other thermistors. If there
is enough compatibility.

We can drop off the "from Murata" in MODULE_DESCRIPTION()
and In the Kconfig file.
I can submit a change for the same.

>>>
>>> Of course I would create the necessary patch.
>>>
>>> Thanks,
>>> Hannes
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>> Why not move the table to DT? There are lots of NTC types out there, and
>> each type comes in an number of varietes. IMHO it seems impractical to
>> change the code for each one, and the tables would grow to be very large.
>>
>
> I would not mandate it, but I would he happy to accept a patch.
>
> Guenter
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Thanks & Regards,
(: Nav :)
