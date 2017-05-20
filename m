Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60371 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752608AbdETQjF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 20 May 2017 12:39:05 -0400
Subject: Re: [PATCH 2/3] iio: adc: cpcap: Fix die temperature
To: Tony Lindgren <tony@atomide.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
        Marcel Partap <mpartap@gmx.net>,
        Michael Scott <michael.scott@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
References: <20170519034035.16795-1-tony@atomide.com>
 <20170519034035.16795-3-tony@atomide.com>
 <6b8ea7a4-5f5e-2d48-0893-94aa320433c6@kernel.org>
 <20170520163525.GM10472@atomide.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <8559e4a5-c005-1cd4-df34-b62f5b6b7853@kernel.org>
Date: Sat, 20 May 2017 17:39:03 +0100
MIME-Version: 1.0
In-Reply-To: <20170520163525.GM10472@atomide.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/05/17 17:35, Tony Lindgren wrote:
> * Jonathan Cameron <jic23@kernel.org> [170520 08:58]:
>> On 19/05/17 04:40, Tony Lindgren wrote:
>>> It seems that "MC13783 Power Management and Audio Ciruit User's Guide"
>>> MC1378UG.pdf documents several similar components as in the CPCAP PMIC.
>>>
>>> Chapter "9.5.5 Die Temperature and UID" says that the die temperature
>>> value is 282 at 25C with LSB of -1.14C. Converting CPCAP PMIC channel3
>>> values with following seems to produce values that make sense for a
>>> PMIC die:
>>>
>>> temperature = 25000 + ((regval - 282) * 114)
>>>
>>> As we don't have any other documentation, let's assume the die
>>> temperature is unconfigured in the Motorola mapphone Linux kernel
>>> and the current temperature conversion table should be only used
>>> for the battery thermistor and not for the die temperature.
>> Is there any route we have available to confirm this?  I.e. doe anyone
>> have one where we can check plausibility?
> 
> Well there is also a tmp105 sensor for SoC temperature on board
> that I used for some sanity checks :) For the Motorola kernel, it
> seems it's doing all the interesting ADC stuff in user space for
> battery estimates. So if ch3 is used, it must be using the raw
> values. My guess is that ch3 is only used by the PMIC firmware to
> automatically cut off power if it gets too hot.
> 
> The temperature values seem to make sense now when compared against
> the tmp105 values.. The following output is from an idle device with
> charger connected with reasonably full battery:
> 
> $ ./test-d4-temperature
> tmp105: 37187 bat ch0: 33675 die ch3: 46888
> tmp105: 37187 bat ch0: 33820 die ch3: 41074
> tmp105: 37187 bat ch0: 33525 die ch3: 40390
> tmp105: 37125 bat ch0: 33675 die ch3: 40162
> tmp105: 37125 bat ch0: 34410 die ch3: 40048
> tmp105: 37125 bat ch0: 34555 die ch3: 40162
> tmp105: 37125 bat ch0: 33525 die ch3: 40390
> ...
> 
> Add some load with two instances of dd if=/dev/urandom of=/dev/null:
> 
> $ ./test-d4-temperature
> tmp105: 44250 bat ch0: 37240 die ch3: 51790
> tmp105: 44250 bat ch0: 34705 die ch3: 48940
> tmp105: 44250 bat ch0: 34705 die ch3: 48484
> tmp105: 44250 bat ch0: 34850 die ch3: 48370
> tmp105: 44312 bat ch0: 37585 die ch3: 48142
> tmp105: 44312 bat ch0: 36895 die ch3: 48484
> tmp105: 44375 bat ch0: 34705 die ch3: 48484
> tmp105: 44375 bat ch0: 36895 die ch3: 48484
> ...
> 
> So ch3 for the PMIC die temperature seems to follow the load
> numbers and makes sense as it provides power to all the devices.
> The first value of ch3 often is all over the map though, probably
> no way around that..
> 
> The script I'm using is:
> 
> #!/bin/sh
> 
> while [ 1 ]; do
> 	echo -n "tmp105: $(cat /sys/class/hwmon/hwmon0/temp1_input) "
> 	echo -n "bat ch0: $(cat /sys/bus/iio/devices/iio:device0/in_temp0_input) "
> 	echo "die ch3: $(cat /sys/bus/iio/devices/iio:device0/in_temp3_input)"
> 	sleep 1
> done
> 
> Regards,
> 
> Tony
> 
thanks for the info.

I'm happy with the it looks plausible on real hardware answer.

Jonathan
