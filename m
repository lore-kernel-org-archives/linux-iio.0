Return-Path: <johannes.pointner@gmail.com>
MIME-Version: 1.0
Date: Thu, 21 Aug 2014 09:29:56 +0200
Message-ID: <CAJKbBDBCEVfB-f6W1NbpPhuyduYB4KQMoT=9=wF4yny3a6weKA@mail.gmail.com>
Subject: iio: iio_channel_get: ntc_thermistor isn't working since patch for of_iio_channel_get_by_name()
From: Johannes Pointner <johannes.pointner@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
	lm-sensors@lm-sensors.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Hello,

I found out that since this patch https://lkml.org/lkml/2014/6/11/201,
which fixes the return values in this function, the ntc_thermistor
driver isn't working anymore for me.
The problem is that before the driver asked for probe deferral because
the adc driver isn't loaded at this point and now the probe fails in
the function iio_channel_get_sys and returns -ENODEV.
My question is: Who is in this case responsible to request a deferral?
The driver or the subsystem?

Thanks,
Hannes
