Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47741 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750947AbdDBJxs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Apr 2017 05:53:48 -0400
Subject: Re: [PATCH v4 2/4] iio: Documentation: Add max9611 sysfs
 documentation
To: Jacopo Mondi <jacopo+renesas@jmondi.org>, geert@linux-m68k.org,
        wsa+renesas@sang-engineering.com, magnus.damm@gmail.com,
        laurent.pinchart@ideasonboard.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com
References: <1490627578-15938-1-git-send-email-jacopo+renesas@jmondi.org>
 <1490627578-15938-3-git-send-email-jacopo+renesas@jmondi.org>
 <6b249f47-2a79-e9a0-0599-284301319a9d@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <afc46629-683b-1d28-4e76-ce10f372cb90@kernel.org>
Date: Sun, 2 Apr 2017 10:53:45 +0100
MIME-Version: 1.0
In-Reply-To: <6b249f47-2a79-e9a0-0599-284301319a9d@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/04/17 10:36, Jonathan Cameron wrote:
> On 27/03/17 16:12, Jacopo Mondi wrote:
>> Add documentation for max9611 driver.
>> Document attributes describing value of shunt resistor installed between
>> RS+ and RS- voltage sense inputs.
>>
>> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Good.  Will pick up once the binding is sorted.
> 
> Kick me if I don't!
Oops. Missed the units being micro ohms.  They want to be ohms to be consistent
within the ABI.

We let various odd units go in right back at the beginning to try and remain
compatible with hwmon.  Turned out to be a bad idea.  Also the ina2xx uses
ohms and you should stay consistent with that.

Thanks,

Jonathan
>> ---
>>  Documentation/ABI/testing/sysfs-bus-iio-adc-max9611 | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-max9611
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-max9611 b/Documentation/ABI/testing/sysfs-bus-iio-adc-max9611
>> new file mode 100644
>> index 0000000..5020d00
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-max9611
>> @@ -0,0 +1,17 @@
>> +What:		/sys/bus/iio/devices/iio:deviceX/in_power_shunt_resistor
>> +Date:		March 2017
>> +KernelVersion:	4.12
>> +Contact:	linux-iio@vger.kernel.org
>> +Description: 	The value of the shunt resistor used to compute power drain on
>> +                common input voltage pin (RS+). In micro Ohms.
>> +
>> +What:		/sys/bus/iio/devices/iio:deviceX/in_current_shunt_resistor
>> +Date:		March 2017
>> +KernelVersion:	4.12
>> +Contact:	linux-iio@vger.kernel.org
>> +Description: 	The value of the shunt resistor used to compute current flowing
>> +                between RS+ and RS- voltage sense inputs. In micro Ohms.
>> +
>> +These attributes describe a single physical component, exposed as two distinct
>> +attributes as it is used to calculate two different values: power load and
>> +current flowing between RS+ and RS- inputs.
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

