Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40331 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751099AbdAVNgt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Jan 2017 08:36:49 -0500
Subject: Re: [PATCH] iio: dht11: Use usleep_range instead of msleep for start
 signal
To: Harald Geyer <harald@ccbib.org>, John Brooks <john@fastquake.com>
References: <20170118215008.GA12173@oldkitsune.fastquake.com>
 <E1cUAqD-0000MZ-0T@stardust.g4.wien.funkfeuer.at>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <03e7614a-8f7f-e4f4-07cd-d1c591480239@kernel.org>
Date: Sun, 22 Jan 2017 13:36:47 +0000
MIME-Version: 1.0
In-Reply-To: <E1cUAqD-0000MZ-0T@stardust.g4.wien.funkfeuer.at>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/01/17 11:25, Harald Geyer wrote:
> John Brooks writes:
>> The DHT22 (AM2302) datasheet specifies that the LOW start pulse should not
>> exceed 20ms. However, observations with an oscilloscope of an RPi Model 2B
>> (rev 1.1) communicating with a DHT22 sensor showed that the driver was
>> consistently sending start pulses longer than 20ms:
>>
>> Kernel 4.7.10-v7+ (n=132):
>>     Minimum pulse length: 20.20ms
>>     Maximum:              29.84ms
>>     Mean:                 24.96ms
>>     StDev:                2.82ms
>>     Sensor response rate: 100%
>>     Read success rate:    76%
>>
>> On kernel 4.8, the start pulse was so long that the sensor would not even
>> respond 97% of the time:
>>
>> Kernel 4.8.16-v7+ (n=100):
>>     Minimum pulse length: 30.4ms
>>     Maximum:              74.4ms
>>     Mean:                 39.3ms
>>     StDev:                10.2ms
>>     Sensor response rate: 3%
>>     Read success rate:    3%
>>
>> The driver would return ETIMEDOUT and write log messages like this:
>>
>> [   51.430987] dht11 dht11@0: Only 1 signal edges detected
>> [   66.311019] dht11 dht11@0: Only 0 signal edges detected
>>
>> Replacing msleep(18) with usleep_range(18000, 20000) made the pulse length
>> sane again and restored responsiveness:
>>
>> Kernel 4.8.16-v7+ with usleep_range (n=123):
>>     Minimum pulse length: 18.16ms
>>     Maximum:              20.20ms
>>     Mean:                 19.85ms
>>     StDev:                0.51ms
>>     Sensor response rate: 100%
>>     Read success rate:    84%
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: John Brooks <john@fastquake.com>
>> ---
>>  drivers/iio/humidity/dht11.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iio/humidity/dht11.c b/drivers/iio/humidity/dht11.c
>> index 9c47bc9..2a22ad9 100644
>> --- a/drivers/iio/humidity/dht11.c
>> +++ b/drivers/iio/humidity/dht11.c
>> @@ -71,7 +71,8 @@
>>   * a) select an implementation using busy loop polling on those systems
>>   * b) use the checksum to do some probabilistic decoding
>>   */
>> -#define DHT11_START_TRANSMISSION	18  /* ms */
>> +#define DHT11_START_TRANSMISSION_MIN	18000  /* us */
>> +#define DHT11_START_TRANSMISSION_MAX	20000  /* us */
> 
> If you want to stay strictly within the 20ms range, you might want to
> make this a bit lower like 19750. However, I don't care much either way.
> I think this is a reasonable change.
> 
> Reviewed-by: Harald Geyer <harald@ccbib.org>
> 
> I do wonder why there is a difference between 4.7 and 4.8. Is this a
> performance regression on the RPi or have there been changes to the
> scheduler, that make this actually expected behaviour. (Ie is this a
> bug or a feature?)
Agreed.  Any chance you can do a bisection on this John?

Either way - defence in depth!
Applied to the fixes-togreg branch of iio.git.

thanks,

Jonathan
> 
> Thanks for your patch,
> Harald
> 
>>  #define DHT11_MIN_TIMERES	34000  /* ns */
>>  #define DHT11_THRESHOLD		49000  /* ns */
>>  #define DHT11_AMBIG_LOW		23000  /* ns */
>> @@ -228,7 +229,8 @@ static int dht11_read_raw(struct iio_dev *iio_dev,
>>  		ret = gpio_direction_output(dht11->gpio, 0);
>>  		if (ret)
>>  			goto err;
>> -		msleep(DHT11_START_TRANSMISSION);
>> +		usleep_range(DHT11_START_TRANSMISSION_MIN,
>> +			     DHT11_START_TRANSMISSION_MAX);
>>  		ret = gpio_direction_input(dht11->gpio);
>>  		if (ret)
>>  			goto err;
>> -- 
>> 2.7.4
>>
> 

