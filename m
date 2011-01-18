Return-Path: <shubhrajyoti@ti.com>
Message-ID: <4D357E61.4010806@ti.com>
Date: Tue, 18 Jan 2011 17:19:53 +0530
From: Shubhrajyoti <shubhrajyoti@ti.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: linux-iio@vger.kernel.org, achew@nvidia.com
Subject: Re: [PATCH] [RFC] ak8975: Trivial optimisations
References: <1295333911-3762-1-git-send-email-shubhrajyoti@ti.com> <4D35765F.6060406@cam.ac.uk>
In-Reply-To: <4D35765F.6060406@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On Tuesday 18 January 2011 04:45 PM, Jonathan Cameron wrote:
> On 01/18/11 06:58, shubhrajyoti@ti.com wrote:
>> From: Shubhrajyoti Datta<shubhrajyoti@ti.com>
>>
>> The probe memory could be freed after init.
>>
>> Signed-off-by: Shubhrajyoti Datta<shubhrajyoti@ti.com>
> Acked-by: Jonathan Cameron<jic23@cam.ac.uk>
>
> Probably best to wait for Andrew to reply before sending this one on...
Yes , sure.
>> ---
>> Compile tested only.
>>   drivers/staging/iio/magnetometer/ak8975.c |    4 ++--
>>   1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/staging/iio/magnetometer/ak8975.c b/drivers/staging/iio/magnetometer/ak8975.c
>> index 420f206..694da1e 100644
>> --- a/drivers/staging/iio/magnetometer/ak8975.c
>> +++ b/drivers/staging/iio/magnetometer/ak8975.c
>> @@ -431,7 +431,7 @@ static struct attribute_group ak8975_attr_group = {
>>   	.attrs = ak8975_attr,
>>   };
>>
>> -static int ak8975_probe(struct i2c_client *client,
>> +static int __devinit ak8975_probe(struct i2c_client *client,
>>   			const struct i2c_device_id *id)
>>   {
>>   	struct ak8975_data *data;
>> @@ -510,7 +510,7 @@ exit:
>>   	return err;
>>   }
>>
>> -static int ak8975_remove(struct i2c_client *client)
>> +static int  __devexit ak8975_remove(struct i2c_client *client)
>>   {
>>   	struct ak8975_data *data = i2c_get_clientdata(client);
>>
