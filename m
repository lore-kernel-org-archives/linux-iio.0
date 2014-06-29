Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:55026 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752226AbaF2PLk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 29 Jun 2014 11:11:40 -0400
Message-ID: <53B02CA9.4020905@roeck-us.net>
Date: Sun, 29 Jun 2014 08:11:37 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Jan Kardell <jan.kardell@telliq.com>,
	Johannes Pointner <johannes.pointner@gmail.com>,
	Jean Delvare <jdelvare@suse.de>,
	Naveen Krishna Chatradhi <ch.naveen@samsung.com>
CC: lm-sensors@lm-sensors.org, linux-iio@vger.kernel.org
Subject: Re: hwmon: ntc_thermistor: Add another ntc(epcos) to the driver
References: <CAJKbBDDYdGATTtW0Vz6v1iqnwkLgjj8dB8-dgM0xPAb+UkHvAg@mail.gmail.com> <53B02147.1000608@telliq.com>
In-Reply-To: <53B02147.1000608@telliq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/29/2014 07:23 AM, Jan Kardell wrote:
> Johannes Pointner skriver:
>> As I saw in the latest patches for the ntc_thermistor, in which as
>> part of the patch the module description changed to :
>>
>> MODULE_DESCRIPTION("NTC Thermistor Driver from Murata");
>>
>> I wanted to know if it is intended to extend the driver for further
>> manufacturers like in my case for an epcos ntc in the future?
>>
>> Of course I would create the necessary patch.
>>
>> Thanks,
>> Hannes
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> Why not move the table to DT? There are lots of NTC types out there, and each type comes in an number of varietes. IMHO it seems impractical to change the code for each one, and the tables would grow to be very large.
>

I would not mandate it, but I would he happy to accept a patch.

Guenter


