Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from vern.gendns.com ([206.190.152.46]:36323 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751115AbdANSHy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 14 Jan 2017 13:07:54 -0500
Subject: Re: [PATCH 2/3] iio: adc: ti-ads7950: Drop "ti-" prefix from module
 name
To: Jonathan Cameron <jic23@kernel.org>, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
References: <1484157171-15571-1-git-send-email-david@lechnology.com>
 <1484157171-15571-3-git-send-email-david@lechnology.com>
 <4dd9883a-5e50-36a9-135c-802dac4f93b8@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
From: David Lechner <david@lechnology.com>
Message-ID: <83b36ce2-6b54-b5ee-6ad3-1f90d26f5e52@lechnology.com>
Date: Sat, 14 Jan 2017 12:07:51 -0600
MIME-Version: 1.0
In-Reply-To: <4dd9883a-5e50-36a9-135c-802dac4f93b8@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/14/2017 06:49 AM, Jonathan Cameron wrote:
> On 11/01/17 17:52, David Lechner wrote:
>> This drops the "ti-" prefix from the module name. It makes the module name
>> consistent with other iio ti-ads* drivers and it makes the driver work
>> with device tree (the spi subsystem drops the "ti," prefix when matching
>> compatible strings from device tree).
>>
>> Tested working on LEGO MINDSTORMS EV3 with the following device tree node:
>>
>> 	adc@3 {
>> 		compatible = "ti,ads7957";
>> 		reg = <3>;
>> 		#io-channel-cells = <1>;
>> 		spi-max-frequency = <10000000>;
>> 		vref-supply = <&adc_ref>;
>> 	};
>>
>> Signed-off-by: David Lechner <david@lechnology.com>
> What worries me here is that we might break existing setups.  I agree
> we should have gotten this 'right' in the first place, but can we fix
> it now.  Not so sure. We'd be better off perhaps adding an of_device_id
> table with the write entries for device tree.

As far as I can tell, this driver only exists in your testing branch. 
Does that really mean that it is too late to get it right?

>> ---
>>  drivers/iio/adc/ti-ads7950.c | 26 +++++++++++++-------------
>>  1 file changed, 13 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
>> index 0330361..b587fa6 100644
>> --- a/drivers/iio/adc/ti-ads7950.c
>> +++ b/drivers/iio/adc/ti-ads7950.c
>> @@ -459,25 +459,25 @@ static int ti_ads7950_remove(struct spi_device *spi)
>>  }
>>
>>  static const struct spi_device_id ti_ads7950_id[] = {
>> -	{"ti-ads7950", TI_ADS7950},
>> -	{"ti-ads7951", TI_ADS7951},
>> -	{"ti-ads7952", TI_ADS7952},
>> -	{"ti-ads7953", TI_ADS7953},
>> -	{"ti-ads7954", TI_ADS7954},
>> -	{"ti-ads7955", TI_ADS7955},
>> -	{"ti-ads7956", TI_ADS7956},
>> -	{"ti-ads7957", TI_ADS7957},
>> -	{"ti-ads7958", TI_ADS7958},
>> -	{"ti-ads7959", TI_ADS7959},
>> -	{"ti-ads7960", TI_ADS7960},
>> -	{"ti-ads7961", TI_ADS7961},
>> +	{ "ads7950", TI_ADS7950 },
>> +	{ "ads7951", TI_ADS7951 },
>> +	{ "ads7952", TI_ADS7952 },
>> +	{ "ads7953", TI_ADS7953 },
>> +	{ "ads7954", TI_ADS7954 },
>> +	{ "ads7955", TI_ADS7955 },
>> +	{ "ads7956", TI_ADS7956 },
>> +	{ "ads7957", TI_ADS7957 },
>> +	{ "ads7958", TI_ADS7958 },
>> +	{ "ads7959", TI_ADS7959 },
>> +	{ "ads7960", TI_ADS7960 },
>> +	{ "ads7961", TI_ADS7961 },
>>  	{ }
>>  };
>>  MODULE_DEVICE_TABLE(spi, ti_ads7950_id);
>>
>>  static struct spi_driver ti_ads7950_driver = {
>>  	.driver = {
>> -		.name	= "ti-ads7950",
>> +		.name	= "ads7950",
>>  	},
>>  	.probe		= ti_ads7950_probe,
>>  	.remove		= ti_ads7950_remove,
>>
>

