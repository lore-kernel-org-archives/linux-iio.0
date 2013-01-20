Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46327 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752569Ab3ATVp6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 20 Jan 2013 16:45:58 -0500
Message-ID: <50FC6592.6030005@kernel.org>
Date: Sun, 20 Jan 2013 21:45:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, jbrenner@taosinc.com,
	amit.kucheria@verdurent.com, Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/5] iio:light:tsl2563 move out of staging
References: <1357986924-11471-1-git-send-email-jic23@kernel.org> <1357986924-11471-6-git-send-email-jic23@kernel.org> <alpine.DEB.2.01.1301201430180.18128@pmeerw.net>
In-Reply-To: <alpine.DEB.2.01.1301201430180.18128@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/20/2013 01:32 PM, Peter Meerwald wrote:
> Hello,
> 
>> This driver is simple, uses the latest interfaces and contains few if
>> any controversial elements.  All of its interfaces have been in place
>> for a long time now.  Hence let's move it out of staging.
> 
> two small nitpicks inline
> 
Thanks!
> regards, p.
...
>>  obj-$(CONFIG_ADJD_S311)		+= adjd_s311.o
>>  obj-$(CONFIG_SENSORS_LM3533)	+= lm3533-als.o
>> +obj-$(CONFIG_SENSORS_TSL2563)	+= tsl2563.o
> 
> there is the SENSORS_ prefix which is an inconsistency; there were some 
> arguments against it...
Hmm. I was holding off on this purely as it might break things.  It's used in
one of the omap board files for starters.

Tony, what are your views on cleaning this up? It's in
arch/arm/mach-omap2/board-rx51-peripherals.c.
There presumably isn't really a problem in a patch fixing this end
going via IIO and another to change the ifdef via your tree? At somepoint
the support won't be enabled but it won't cause any problems.

There is still a bit of debate on whether an IIO prefix makes sense
or if such prefixes should be dropped entirely so we end up with
CONFIG_TSL2563...


> 
>>  obj-$(CONFIG_VCNL4000)		+= vcnl4000.o
>>  obj-$(CONFIG_HID_SENSOR_ALS)	+= hid-sensor-als.o
>> diff --git a/drivers/iio/light/tsl2563.c b/drivers/iio/light/tsl2563.c
>> new file mode 100644
>> index 0000000..86bcadc
>> --- /dev/null
>> +++ b/drivers/iio/light/tsl2563.c
>> @@ -0,0 +1,887 @@
>> +/*
>> + * drivers/i2c/chips/tsl2563.c
> 
> this should be drivers/iio/light/tsl2563.c
> 
Good spot, thanks.
