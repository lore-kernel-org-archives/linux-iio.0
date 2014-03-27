Return-Path: <srinivas.pandruvada@linux.intel.com>
Message-ID: <53344315.3050807@linux.intel.com>
Date: Thu, 27 Mar 2014 08:26:13 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
To: Jean Delvare <jdelvare@suse.de>
CC: jic23@kernel.org, linux-iio@vger.kernel.org,
 linux-i2c@vger.kernel.org, ktsai@capellamicro.com
Subject: Re: [RFC Patch v0 2/3] i2c-smbus: Allow building with I2C_HELPER_AUTO
 support
References: <1395880932-19124-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1395880932-19124-2-git-send-email-srinivas.pandruvada@linux.intel.com> <20140327075712.5121d6ed@endymion.delvare>
In-Reply-To: <20140327075712.5121d6ed@endymion.delvare>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 03/26/2014 11:57 PM, Jean Delvare wrote:
> On Wed, 26 Mar 2014 17:42:11 -0700, Srinivas Pandruvada wrote:
>> Currentlty the config is conditional on !I2C_HELPER_AUTO.
>> I don't know their dependency, but without this we can't build.
> Nack. Just because you don't understand something and did not bother
> looking into it, is no good reason to break a perfectly working and
> valid mechanism.
That is why it RFC.
>
> Just read the Kconfig help text for I2C_HELPER_AUTO and you should be
> able to figure it out. Also grep the kernel tree for "select I2C_SMBUS".
>
> As a summary: any driver which depends on i2c-smbus, should select it
> in Kconfig.
>
>> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>> ---
>>   drivers/i2c/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
>> index 7b7ea32..212ed73 100644
>> --- a/drivers/i2c/Kconfig
>> +++ b/drivers/i2c/Kconfig
>> @@ -74,7 +74,7 @@ config I2C_HELPER_AUTO
>>   	  In doubt, say Y.
>>   
>>   config I2C_SMBUS
>> -	tristate "SMBus-specific protocols" if !I2C_HELPER_AUTO
>> +	tristate "SMBus-specific protocols"
>>   	help
>>   	  Say Y here if you want support for SMBus extensions to the I2C
>>   	  specification. At the moment, the only supported extension is
>
