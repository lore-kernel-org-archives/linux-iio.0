Return-Path: <lars@metafoo.de>
Message-ID: <5187F23D.1000400@metafoo.de>
Date: Mon, 06 May 2013 20:11:09 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: Jacek Anaszewski <j.anaszewski@samsung.com>,
 linux-iio@vger.kernel.org, achew@nvidia.com,
 Kyungmin Park <kyungmin.park@samsung.com>
Subject: Re: [PATCH 1/2] iio: ak8975: Add support for gpios DT property
References: <1366123040-17917-1-git-send-email-j.anaszewski@samsung.com> <1366123040-17917-2-git-send-email-j.anaszewski@samsung.com> <5187DE08.6020002@kernel.org>
In-Reply-To: <5187DE08.6020002@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 05/06/2013 06:44 PM, Jonathan Cameron wrote:
> On 04/16/2013 03:37 PM, Jacek Anaszewski wrote:
[...]
>> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
>> index af6c320..eb17eca 100644
>> --- a/drivers/iio/magnetometer/ak8975.c
>> +++ b/drivers/iio/magnetometer/ak8975.c
>> @@ -29,6 +29,7 @@
>>  #include <linux/delay.h>
>>  
>>  #include <linux/gpio.h>
>> +#include <linux/of_gpio.h>
>>  
>>  #include <linux/iio/iio.h>
>>  #include <linux/iio/sysfs.h>
>> @@ -384,7 +385,9 @@ static int ak8975_probe(struct i2c_client *client,
>>  	int err;
>>  
>>  	/* Grab and set up the supplied GPIO. */
>> -	if (client->dev.platform_data == NULL)
>> +	if (client->dev.of_node)
>> +		eoc_gpio = of_get_gpio(client->dev.of_node, 0);
>> +	else if (client->dev.platform_data == NULL)
>>  		eoc_gpio = -1;
>>  	else
>>  		eoc_gpio = *(int *)(client->dev.platform_data);

Usually this is done in the opposite order. First check for platform_data,
then, of_node. Also it probably makes sense to check for -EPROBE_DEFER in the
of case.

- Lars
