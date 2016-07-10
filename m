Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39457 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752012AbcGJQAL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 10 Jul 2016 12:00:11 -0400
Subject: Re: [PATCH 0/5] hwmon: New hwmon registration API
To: Guenter Roeck <linux@roeck-us.net>,
	Jean Delvare <jdelvare@suse.com>
References: <1466911590-26296-1-git-send-email-linux@roeck-us.net>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Eduardo Valentin <edubezval@gmail.com>,
	linux-pm@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <d83c43cc-dfa3-684d-9315-e1eec5cd79fe@kernel.org>
Date: Sun, 10 Jul 2016 17:00:03 +0100
MIME-Version: 1.0
In-Reply-To: <1466911590-26296-1-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 26/06/16 04:26, Guenter Roeck wrote:
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
Some cool stuff hiding in there :)

I've only reviewed 1 and 7 and the intermediate ones are really either
correct or they aren't and they look fine to me.


So what's next? (beyond presumably a lot of driver conversions).

Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

