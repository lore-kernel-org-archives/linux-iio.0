Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46405 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755366AbaCQRTO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 17 Mar 2014 13:19:14 -0400
In-Reply-To: <5327186B.7030500@linux.intel.com>
References: <1394572557-8102-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1394572557-8102-3-git-send-email-srinivas.pandruvada@linux.intel.com> <53246E3A.7020702@kernel.org> <5327186B.7030500@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH 3/3] iio: ak8975: Don't bail out for irq setup error
From: Jonathan Cameron <jic23@kernel.org>
Date: Mon, 17 Mar 2014 17:18:54 +0000
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org
Message-ID: <c7ca8a3a-7feb-417c-8abe-c610a2ca04e8@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On March 17, 2014 3:44:43 PM GMT+00:00, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
>On 03/15/2014 08:14 AM, Jonathan Cameron wrote:
>> On 11/03/14 21:15, Srinivas Pandruvada wrote:
>>> This driver can very well work via polling, if request_irq failed.
>>> The problem is that many times i2c interrupts are shared. This
>>> driver is not ready for shared interrupt as it will return
>IRQ_HANDLED,
>>> in every case. Here we will get EBUSY when some other driver
>registered
>>> handler and this driver is grabbing in exclusive mode.
>>> So in this case just print error and continue in polling mode.
>>>
>>> Signed-off-by: Srinivas Pandruvada
><srinivas.pandruvada@linux.intel.com>
>> I'm not sure this is a good solution as it means that we will get
>very 
>> different
>> results depending on the probe order of various drivers.  How do
>other 
>> i2c drivers
>> cope with the fact that there is no way of knowing within the 
>> interrupt routine
>> that the device was the one causing the interrupt?
>>
>Agreed. The i2c driver currently don't receive irq flags in the client 
>structure. They
>only get irq number. We do get irq flags from the ACPI in this case or 
>from some
>platform init code. I have another patch to enhance ACPI i2c binding
>and 
>also enhance
>i2c_client structure.
>In addition this driver can be enhanced to use shared irq.
Let's hold this patch and do it properly once support is in place... 
>
>Thanks,
>Srinivas
>
>
>> A quick grep suggests that the normal trick is to had over to an irq 
>> thread
>> then return IRQ_NONE from that once we know it isn't our irq. Could
>we 
>> have
>> move the queue wakeup into a a thread (converting to a threaded 
>> interrupt) but
>> before it query the hardware to establish it is actually our
>interrupt?
>>> ---
>>>   drivers/iio/magnetometer/ak8975.c | 12 +++++++++---
>>>   1 file changed, 9 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/iio/magnetometer/ak8975.c 
>>> b/drivers/iio/magnetometer/ak8975.c
>>> index fe5e9c8..0f9c407 100644
>>> --- a/drivers/iio/magnetometer/ak8975.c
>>> +++ b/drivers/iio/magnetometer/ak8975.c
>>> @@ -236,9 +236,15 @@ static int ak8975_setup(struct i2c_client
>*client)
>>>       if (data->eoc_gpio > 0 || client->irq) {
>>>           ret = ak8975_setup_irq(data);
>>>           if (ret < 0) {
>>> -            dev_err(&client->dev,
>>> -                "Error setting data ready interrupt\n");
>>> -            return ret;
>>> +            if (ret == -EBUSY) {
>>> +                dev_err(&client->dev,
>>> +                    "device Intr busy:polling required\n");
>>> +                ret = 0;
>>> +            } else {
>>> +                dev_err(&client->dev,
>>> +                    "Error setting data ready interrupt\n");
>>> +                return ret;
>>> +            }
>>>           }
>>>       }
>>>
>>>
>>
>>
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
