Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59724 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740AbbGENQy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 5 Jul 2015 09:16:54 -0400
Message-ID: <55992E44.1000104@kernel.org>
Date: Sun, 05 Jul 2015 14:16:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH 1/2] iio:light:ltr501: fix regmap dependency
References: <cover.1435487041.git.knaack.h@gmx.de>	<06cf34cbbfd8c82272c885ff3aab8f44dc72cb41.1435487041.git.knaack.h@gmx.de> <CAEnQRZCYQE-DPb+x1Xj2eR6bxNvk5b6hCJLLiLSHqVjN2=Kqfg@mail.gmail.com>
In-Reply-To: <CAEnQRZCYQE-DPb+x1Xj2eR6bxNvk5b6hCJLLiLSHqVjN2=Kqfg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/06/15 08:56, Daniel Baluta wrote:
> On Sun, Jun 28, 2015 at 1:31 PM, Hartmut Knaack <knaack.h@gmx.de> wrote:
>> The use of regmap in commit [1] requires REGMAP_I2C to be selected, in
>> order to meet all dependencies.
>>
>> [1]     2f2c96338afc9f90aa5a0fca04ece1a5c389ee31
>>         "iio: ltr501: Add regmap support."
> 
> The standard way to do this is:
> 
> Fixes: 2f2c96338afc ("iio: ltr501: Add regmap support.")
> 
>>
>> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
> 
> Otherwise,
> 
> Acked-by: Daniel Baluta <daniel.baluta@intel.com>
Hmm. My filters had eaten this patch for some reason...

Anyhow, dug it out and applied.

Hopefully nothing else has gone missing!

Jonathan
> 
>> ---
>>  drivers/iio/light/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
>> index 730fa80..1f1e103 100644
>> --- a/drivers/iio/light/Kconfig
>> +++ b/drivers/iio/light/Kconfig
>> @@ -199,6 +199,7 @@ config SENSORS_LM3533
>>  config LTR501
>>         tristate "LTR-501ALS-01 light sensor"
>>         depends on I2C
>> +       select REGMAP_I2C
>>         select IIO_BUFFER
>>         select IIO_TRIGGERED_BUFFER
>>         help
>> --
>> 2.3.6
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

