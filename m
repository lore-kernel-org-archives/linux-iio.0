Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-eopbgr30098.outbound.protection.outlook.com ([40.107.3.98]:55332
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752095AbeDLOE5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 12 Apr 2018 10:04:57 -0400
Subject: Re: [PATCH 2/2] iio: afe: unit-converter: add support for adi,lt6106
To: "Andrew F. Davis" <afd@ti.com>, linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Fabio Estevam <festevam@gmail.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20180410152802.30958-1-peda@axentia.se>
 <20180411141555.15044-1-peda@axentia.se>
 <20180411141555.15044-3-peda@axentia.se>
 <a70e8467-d0da-2b37-5dfa-7e14b388634c@ti.com>
From: Peter Rosin <peda@axentia.se>
Message-ID: <f944e87f-13b4-ccef-edf9-6283b6dd67a7@axentia.se>
Date: Thu, 12 Apr 2018 16:04:37 +0200
MIME-Version: 1.0
In-Reply-To: <a70e8467-d0da-2b37-5dfa-7e14b388634c@ti.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2018-04-11 17:43, Andrew F. Davis wrote:
> On 04/11/2018 09:15 AM, Peter Rosin wrote:
>> This is a current sense amplifier from Analog Devices.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>  drivers/iio/afe/Kconfig              |  3 +-
>>  drivers/iio/afe/iio-unit-converter.c | 54 ++++++++++++++++++++++++++++++++++++
>>  2 files changed, 56 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/afe/Kconfig b/drivers/iio/afe/Kconfig
>> index 642ce4eb12a6..0e10fe8f459a 100644
>> --- a/drivers/iio/afe/Kconfig
>> +++ b/drivers/iio/afe/Kconfig
>> @@ -10,7 +10,8 @@ config IIO_UNIT_CONVERTER
>>  	depends on OF || COMPILE_TEST
>>  	help
>>  	  Say yes here to build support for the IIO unit converter
>> -	  that handles voltage dividers and current sense shunts.
>> +	  that handles voltage dividers, current sense shunts and
>> +	  the LT6106 Current Sense Amplifier from Analog Devices.
> 
> Could work better to split these out into separate drivers. Maybe a
> iio-shunt-resistor.c that does just voltage->current with the
> appropriate scaling. Then make a a separate lt6106.c.
> 
> "iio-unit-converter.c" isn't really doing what it says it is, it is not
> a generic "unit converter" like one would assume. Having the driver name
> describe what kind of device it physically represents will be better
> when more complex AFEs show up that, for instance, have programmable
> gains and need a larger driver.

If an AFE needs programming etc, then it is definitely an option to
write a specific driver for it. It was never my intention to cover
all AFEs in this one driver, only those that make sense. Presumably
that ends up being those doing linear scaling and perhaps requiring
a change of the iio channel type.

Cheers,
Peter
