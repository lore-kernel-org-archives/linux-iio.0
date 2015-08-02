Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45694 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272AbbHBSRK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 2 Aug 2015 14:17:10 -0400
Subject: Re: [PATCH 4/7] iio:accel:stk8312: rework macro definitions
To: "Breana, Tiberiu A" <tiberiu.a.breana@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <cover.1437955135.git.knaack.h@gmx.de>
 <aa5a9b6fdfbd4d19d3b3eea3a8c4dbe53efd5a59.1437955135.git.knaack.h@gmx.de>
 <4586F61A4A291F4DA44D32824E7C0F4022187E9B@IRSMSX109.ger.corp.intel.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55BE5EA4.6070407@kernel.org>
Date: Sun, 2 Aug 2015 19:17:08 +0100
MIME-Version: 1.0
In-Reply-To: <4586F61A4A291F4DA44D32824E7C0F4022187E9B@IRSMSX109.ger.corp.intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/07/15 14:28, Breana, Tiberiu A wrote:
>> -----Original Message-----
>> From: Hartmut Knaack [mailto:knaack.h@gmx.de]
>> Sent: Tuesday, July 28, 2015 1:49 AM
>> To: linux-iio@vger.kernel.org
>> Cc: Jonathan Cameron; Lars-Peter Clausen; Peter Meerwald; Breana, Tiberiu
>> A
>> Subject: [PATCH 4/7] iio:accel:stk8312: rework macro definitions
>>
>> Make use of BIT to describe register bits, GENMASK for consecutive
>> bitmasks, rename and sort existing definitions, replace magic value with an
>> expressive definition, drop an unused definition.
>>
>> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
> 
> +1
> 
> Reviewed-by: Tiberiu Breana <tiberiu.a.breana@intel.com>
Start getting fuzz over the earlier patch that you are rerolling.
Hence will stop here until you have rerolled.

Jonathan
> 
>> ---
>>  drivers/iio/accel/stk8312.c | 25 +++++++++++++------------
>>  1 file changed, 13 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c index
>> 50a102ca44d3..8783f0bf7c53 100644
>> --- a/drivers/iio/accel/stk8312.c
>> +++ b/drivers/iio/accel/stk8312.c
>> @@ -37,16 +37,16 @@
>>  #define STK8312_REG_OTPDATA		0x3E
>>  #define STK8312_REG_OTPCTRL		0x3F
>>
>> -#define STK8312_MODE_ACTIVE		0x01
>> +#define STK8312_MODE_ACTIVE		BIT(0)
>>  #define STK8312_MODE_STANDBY		0x00
>> -#define STK8312_DREADY_BIT		0x10
>> -#define STK8312_INT_MODE		0xC0
>> -#define STK8312_RNG_MASK		0xC0
>> -#define STK8312_SR_MASK			0x07
>> -#define STK8312_SR_400HZ_IDX		0
>> +#define STK8312_MODE_INT_AH_PP		0xC0	/* active-high, push-
>> pull */
>> +#define STK8312_DREADY_BIT		BIT(4)
>> +#define STK8312_RNG_6G			1
>>  #define STK8312_RNG_SHIFT		6
>> -#define STK8312_READ_RETRIES		16
>> -#define STK8312_ALL_CHANNEL_MASK	7
>> +#define STK8312_RNG_MASK		GENMASK(7, 6)
>> +#define STK8312_SR_MASK			GENMASK(2, 0)
>> +#define STK8312_SR_400HZ_IDX		0
>> +#define STK8312_ALL_CHANNEL_MASK	GENMASK(2, 0)
>>  #define STK8312_ALL_CHANNEL_SIZE	3
>>
>>  #define STK8312_DRIVER_NAME		"stk8312"
>> @@ -144,7 +144,7 @@ static int stk8312_otp_init(struct stk8312_data *data)
>>  		if (ret < 0)
>>  			goto exit_err;
>>  		count--;
>> -	} while (!(ret & 0x80) && count > 0);
>> +	} while (!(ret & BIT(7)) && count > 0);
>>
>>  	if (count == 0) {
>>  		ret = -ETIMEDOUT;
>> @@ -560,11 +560,12 @@ static int stk8312_probe(struct i2c_client *client,
>>  		return ret;
>>  	}
>>  	data->sample_rate_idx = STK8312_SR_400HZ_IDX;
>> -	ret = stk8312_set_range(data, 1);
>> +	ret = stk8312_set_range(data, STK8312_RNG_6G);
>>  	if (ret < 0)
>>  		return ret;
>>
>> -	ret = stk8312_set_mode(data, STK8312_INT_MODE |
>> STK8312_MODE_ACTIVE);
>> +	ret = stk8312_set_mode(data,
>> +			       STK8312_MODE_INT_AH_PP |
>> STK8312_MODE_ACTIVE);
>>  	if (ret < 0)
>>  		return ret;
>>
>> @@ -685,7 +686,7 @@ MODULE_DEVICE_TABLE(acpi, stk8312_acpi_id);
>>
>>  static struct i2c_driver stk8312_driver = {
>>  	.driver = {
>> -		.name = "stk8312",
>> +		.name = STK8312_DRIVER_NAME,
>>  		.pm = STK8312_PM_OPS,
>>  		.acpi_match_table = ACPI_PTR(stk8312_acpi_id),
>>  	},
>> --
>> 2.4.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

