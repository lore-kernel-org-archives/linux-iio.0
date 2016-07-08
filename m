Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:56648 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751836AbcGHJcl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 8 Jul 2016 05:32:41 -0400
From: Punit Agrawal <punit.agrawal@arm.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Eduardo Valentin <edubezval@gmail.com>,
	linux-pm@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] hwmon: New hwmon registration API
References: <1466911590-26296-1-git-send-email-linux@roeck-us.net>
Date: Fri, 08 Jul 2016 10:31:09 +0100
In-Reply-To: <1466911590-26296-1-git-send-email-linux@roeck-us.net> (Guenter
	Roeck's message of "Sat, 25 Jun 2016 20:26:23 -0700")
Message-ID: <87d1mobhnm.fsf@e105922-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Guenter,

Guenter Roeck <linux@roeck-us.net> writes:

> Up to now, each hwmon driver has to implement its own sysfs attributes.
> This requires a lot of template code, and distracts from the driver's
> core function to read and write chip registers.
>
> To be able to reduce driver complexity, move sensor attribute handling
> and thermal zone registration into the hwmon core. By using the new API,
> driver size is typically reduced by 20-50% depending on driver complexity
> and the number of sysfs attributes supported.
>
> The first patch of the series introduces the API as well as support
> for temperature sensors. Subsequent patches introduce support for
> voltage, current, power, energy, humidity, and fan speed sensors.
>
> The series was tested by converting several drivers (lm75, lm90, tmp102,
> tmp421, ltc4245) to the new API. Testing was done with with real chips
> as well as with the hwmon driver module test code available at
> https://github.com/groeck/module-tests.

I like this series - it takes all of the attributes' handling out of the
individual driver code and moving it to hwmon core.

Having attempted a port of scpi-hwmon.c, I think that driver will not
gain a big savings in line count. Though it'll help separate access to
sensors from sysfs related code - which I think is worth the change.

FWIW,

        Acked-by: Punit Agrawal <punit.agrawal@arm.com>

Thanks,
Punit

> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
