Return-Path: <srinivas.pandruvada@linux.intel.com>
Message-ID: <5327186B.7030500@linux.intel.com>
Date: Mon, 17 Mar 2014 08:44:43 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: ak8975: Don't bail out for irq setup error
References: <1394572557-8102-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1394572557-8102-3-git-send-email-srinivas.pandruvada@linux.intel.com> <53246E3A.7020702@kernel.org>
In-Reply-To: <53246E3A.7020702@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 03/15/2014 08:14 AM, Jonathan Cameron wrote:
> On 11/03/14 21:15, Srinivas Pandruvada wrote:
>> This driver can very well work via polling, if request_irq failed.
>> The problem is that many times i2c interrupts are shared. This
>> driver is not ready for shared interrupt as it will return IRQ_HANDLED,
>> in every case. Here we will get EBUSY when some other driver registered
>> handler and this driver is grabbing in exclusive mode.
>> So in this case just print error and continue in polling mode.
>>
>> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> I'm not sure this is a good solution as it means that we will get very 
> different
> results depending on the probe order of various drivers.  How do other 
> i2c drivers
> cope with the fact that there is no way of knowing within the 
> interrupt routine
> that the device was the one causing the interrupt?
>
Agreed. The i2c driver currently don't receive irq flags in the client 
structure. They
only get irq number. We do get irq flags from the ACPI in this case or 
from some
platform init code. I have another patch to enhance ACPI i2c binding and 
also enhance
i2c_client structure.
In addition this driver can be enhanced to use shared irq.

Thanks,
Srinivas


> A quick grep suggests that the normal trick is to had over to an irq 
> thread
> then return IRQ_NONE from that once we know it isn't our irq. Could we 
> have
> move the queue wakeup into a a thread (converting to a threaded 
> interrupt) but
> before it query the hardware to establish it is actually our interrupt?
>> ---
>>   drivers/iio/magnetometer/ak8975.c | 12 +++++++++---
>>   1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iio/magnetometer/ak8975.c 
>> b/drivers/iio/magnetometer/ak8975.c
>> index fe5e9c8..0f9c407 100644
>> --- a/drivers/iio/magnetometer/ak8975.c
>> +++ b/drivers/iio/magnetometer/ak8975.c
>> @@ -236,9 +236,15 @@ static int ak8975_setup(struct i2c_client *client)
>>       if (data->eoc_gpio > 0 || client->irq) {
>>           ret = ak8975_setup_irq(data);
>>           if (ret < 0) {
>> -            dev_err(&client->dev,
>> -                "Error setting data ready interrupt\n");
>> -            return ret;
>> +            if (ret == -EBUSY) {
>> +                dev_err(&client->dev,
>> +                    "device Intr busy:polling required\n");
>> +                ret = 0;
>> +            } else {
>> +                dev_err(&client->dev,
>> +                    "Error setting data ready interrupt\n");
>> +                return ret;
>> +            }
>>           }
>>       }
>>
>>
>
>
