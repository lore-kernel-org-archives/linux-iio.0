Return-Path: <SRS0=XwKU=6G=vanmierlo.com=m.brock@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Mon, 03 Jul 2017 10:42:31 +0200
From: Maarten Brock <m.brock@vanmierlo.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Angelo Compagnucci <angelo.compagnucci@gmail.com>,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: adc: mcp3422: Checking for error on probe
In-Reply-To: <20170701110729.767ec879@kernel.org>
References: <1498687088-28529-1-git-send-email-angelo.compagnucci@gmail.com>
 <1498687088-28529-2-git-send-email-angelo.compagnucci@gmail.com>
 <20170701110729.767ec879@kernel.org>
Message-ID: <74402be2661eab70db7bbdce58723a18@vanmierlo.com>
List-ID: <linux-iio@vger.kernel.org>

On 2017-07-01 12:07, Jonathan Cameron wrote:
> On Wed, 28 Jun 2017 23:53:10 +0200
> Angelo Compagnucci <angelo.compagnucci@gmail.com> wrote:
> 
>> Some part of the configuration are not touched after the probe
>> and if something goes wrong on writing the initial one,
>> the chip will misbehave.
>> Adding an error checking ensures that the inital configuration will
>> be written correctly. Moreover ensures that a sensible configuration
>> will be saved in driver data and used subsequently as intended.
>> 
>> Signed-off-by: Angelo Compagnucci <angelo.compagnucci@gmail.com>
> Applied to the togreg branch of iio.git and pushed out as testing.
> Added a reported by for Maarten.

Thanks. Also for the CC as I'm not (yet) subscribed to this list.

> 
> Jonathan

Would this fix mean that loading the driver fails if the update_config
fails? And thus if the driver is not a module, would require a reboot
of the OS?
Seems like a rather steep requirement for something that can be so
easily fixed later on by e.g. caching an invalid config channel.
There's not even a single retry. And I don't suppose the I2C driver
will auto-retry either.

Maarten

>> ---
>>  drivers/iio/adc/mcp3422.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
>> index 6737df8..63de705 100644
>> --- a/drivers/iio/adc/mcp3422.c
>> +++ b/drivers/iio/adc/mcp3422.c
>> @@ -382,7 +382,9 @@ static int mcp3422_probe(struct i2c_client 
>> *client,
>>  		| MCP3422_CHANNEL_VALUE(0)
>>  		| MCP3422_PGA_VALUE(MCP3422_PGA_1)
>>  		| MCP3422_SAMPLE_RATE_VALUE(MCP3422_SRATE_240));
>> -	mcp3422_update_config(adc, config);
>> +	err = mcp3422_update_config(adc, config);
>> +	if (err < 0)
>> +		return err;
>> 
>>  	err = devm_iio_device_register(&client->dev, indio_dev);
>>  	if (err < 0)
