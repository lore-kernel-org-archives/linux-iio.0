Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:33478 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753853AbbBNL3q (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 14 Feb 2015 06:29:46 -0500
Message-ID: <54DF31A9.3030009@kernel.org>
Date: Sat, 14 Feb 2015 11:29:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"octavian.purdila@intel.com" <octavian.purdila@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH 1/2] iio: light: jsa1212: Select REGMAP_I2C
References: <1423774815-26816-1-git-send-email-roberta.dobrescu@gmail.com>	<1423774815-26816-2-git-send-email-roberta.dobrescu@gmail.com> <CAEnQRZAr9N1iNxEhqLo8_1tiKW0zhPztP9mhQxoZjdDojhdgpw@mail.gmail.com>
In-Reply-To: <CAEnQRZAr9N1iNxEhqLo8_1tiKW0zhPztP9mhQxoZjdDojhdgpw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/02/15 07:59, Daniel Baluta wrote:
> On Thu, Feb 12, 2015 at 11:00 PM, Roberta Dobrescu
> <roberta.dobrescu@gmail.com> wrote:
>> This patch adds missing 'select' statement for jsa1212 driver.
>> Without regmap_i2c, we get the following error when loading the module:
>> Unknown symbol devm_regmap_init_i2c.
>>
>> Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
> 
> Reviewed-by: Daniel Baluta <daniel.baluta@intel.com>
Applied to a special branch for fixes dependent on those
patches that went in during the merge window...
fixes-post-3.20-rc1

Always fun for fixes around this point in the cycle!
> 
>> ---
>>  drivers/iio/light/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
>> index ae68c64..e0ed374 100644
>> --- a/drivers/iio/light/Kconfig
>> +++ b/drivers/iio/light/Kconfig
>> @@ -126,6 +126,7 @@ config HID_SENSOR_PROX
>>  config JSA1212
>>         tristate "JSA1212 ALS and proximity sensor driver"
>>         depends on I2C
>> +       select REGMAP_I2C
>>         help
>>          Say Y here if you want to build a IIO driver for JSA1212
>>          proximity & ALS sensor device.
>> --
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

