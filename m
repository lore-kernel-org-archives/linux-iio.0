Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:33471 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753853AbbBNL30 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 14 Feb 2015 06:29:26 -0500
Message-ID: <54DF3193.6010403@kernel.org>
Date: Sat, 14 Feb 2015 11:29:23 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"octavian.purdila@intel.com" <octavian.purdila@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH 2/2] iio: light: gp2ap020a00f: Select REGMAP_I2C
References: <1423774815-26816-1-git-send-email-roberta.dobrescu@gmail.com>	<1423774815-26816-3-git-send-email-roberta.dobrescu@gmail.com> <CAEnQRZDQ5iAP5_VGFk4b+RvRtbTmY6PVKEP01PPAmYUuCtvkhQ@mail.gmail.com>
In-Reply-To: <CAEnQRZDQ5iAP5_VGFk4b+RvRtbTmY6PVKEP01PPAmYUuCtvkhQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/02/15 08:00, Daniel Baluta wrote:
> On Thu, Feb 12, 2015 at 11:00 PM, Roberta Dobrescu
> <roberta.dobrescu@gmail.com> wrote:
>> This patch adds missing 'select' statement for gp2ap020a00f driver.
>> Without regmap_i2c, we get the following error when loading the module:
>> Unknown symbol devm_regmap_init_i2c.
>>
>> Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
> 
> Reviewed-by: Daniel Baluta <daniel.baluta@intel.com>
> 
Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan
>> ---
>>  drivers/iio/light/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
>> index e0ed374..a224afd 100644
>> --- a/drivers/iio/light/Kconfig
>> +++ b/drivers/iio/light/Kconfig
>> @@ -73,6 +73,7 @@ config CM36651
>>  config GP2AP020A00F
>>         tristate "Sharp GP2AP020A00F Proximity/ALS sensor"
>>         depends on I2C
>> +       select REGMAP_I2C
>>         select IIO_BUFFER
>>         select IIO_TRIGGERED_BUFFER
>>         select IRQ_WORK
>> --
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

