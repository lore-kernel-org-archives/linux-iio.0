Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from anchovy2.45ru.net.au ([203.30.46.146]:38466 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932283AbeA2CIV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Jan 2018 21:08:21 -0500
Subject: Re: [PATCH v3 2/2] iio: ad5272: Add support for Analog Devices
 digital potentiometers
To: Jonathan Cameron <jic23@kernel.org>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com,
        Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, alexandru.ardelean@analog.com
References: <1516160308-16937-1-git-send-email-preid@electromag.com.au>
 <1516160308-16937-3-git-send-email-preid@electromag.com.au>
 <20180120171241.7d36898d@archlinux>
From: Phil Reid <preid@electromag.com.au>
Message-ID: <59571332-0fd7-940a-7c45-c32a5e224195@electromag.com.au>
Date: Mon, 29 Jan 2018 10:08:16 +0800
MIME-Version: 1.0
In-Reply-To: <20180120171241.7d36898d@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/01/2018 01:12, Jonathan Cameron wrote:
> On Wed, 17 Jan 2018 11:38:28 +0800
> Phil Reid <preid@electromag.com.au> wrote:
> 
>> Add implementation for Analog Devices AD5272 and AD5274 digital
>> potentiometer devices.
>>
>> Signed-off-by: Phil Reid <preid@electromag.com.au>
> A couple more minor comments.
> 
...

>>   menu "Digital potentiometers"
>>   
>> +config AD5272
>> +	tristate "Analog Devices AD5272 Digital Potentiometer driver"
>> +	depends on I2C
>> +	help
>> +	  Say yes here to build support for the Analog Devices AD5272
>> +	  digital potentiometer chip.
> 
> You need to list he compatible parts here so that people looking for
> the driver can find it.  Usually the short text states 'and similar'
> and the help text contains a list of parts.  AD5274 is missing here.

ok

...

>> +	if (reset_gpio) {
>> +		udelay(1);
>> +		gpiod_set_value(reset_gpio, 1);
>> +	} else {
>> +		ad5272_write(data, AD5272_RESET, 0);
>> +	}
>> +	usleep_range(1000, 2000);
> kernel coding conventions (and readability) put a blank line
> before return statements.
> ok

-- 
Regards
Phil Reid

