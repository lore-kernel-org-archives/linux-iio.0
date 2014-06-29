Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:56441 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771AbaF2OXJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 29 Jun 2014 10:23:09 -0400
Received: by mail-lb0-f177.google.com with SMTP id u10so5125388lbd.22
        for <linux-iio@vger.kernel.org>; Sun, 29 Jun 2014 07:23:07 -0700 (PDT)
Message-ID: <53B02147.1000608@telliq.com>
Date: Sun, 29 Jun 2014 16:23:03 +0200
From: Jan Kardell <jan.kardell@telliq.com>
MIME-Version: 1.0
To: Johannes Pointner <johannes.pointner@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jean Delvare <jdelvare@suse.de>,
	Naveen Krishna Chatradhi <ch.naveen@samsung.com>
CC: lm-sensors@lm-sensors.org, linux-iio@vger.kernel.org
Subject: Re: hwmon: ntc_thermistor: Add another ntc(epcos) to the driver
References: <CAJKbBDDYdGATTtW0Vz6v1iqnwkLgjj8dB8-dgM0xPAb+UkHvAg@mail.gmail.com>
In-Reply-To: <CAJKbBDDYdGATTtW0Vz6v1iqnwkLgjj8dB8-dgM0xPAb+UkHvAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Johannes Pointner skriver:
> As I saw in the latest patches for the ntc_thermistor, in which as
> part of the patch the module description changed to :
>
> MODULE_DESCRIPTION("NTC Thermistor Driver from Murata");
>
> I wanted to know if it is intended to extend the driver for further
> manufacturers like in my case for an epcos ntc in the future?
>
> Of course I would create the necessary patch.
>
> Thanks,
> Hannes
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Why not move the table to DT? There are lots of NTC types out there, and 
each type comes in an number of varietes. IMHO it seems impractical to 
change the code for each one, and the tables would grow to be very large.

//Jan

