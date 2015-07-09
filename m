Return-Path: <knaack.h@gmx.de>
Message-ID: <559EB46B.8060104@gmx.de>
Date: Thu, 09 Jul 2015 19:50:35 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: "Breana, Tiberiu A" <tiberiu.a.breana@intel.com>,
 Jonathan Cameron <jic23@kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH 3/5] iio:light:stk3310: add more error handling
References: <cover.1436024257.git.knaack.h@gmx.de> <e0c5af9c11193697c772e0c5174e2434fe589037.1436024257.git.knaack.h@gmx.de> <559913F6.2010406@kernel.org> <4586F61A4A291F4DA44D32824E7C0F402216D8AA@IRSMSX109.ger.corp.intel.com>
In-Reply-To: <4586F61A4A291F4DA44D32824E7C0F402216D8AA@IRSMSX109.ger.corp.intel.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

Breana, Tiberiu A schrieb am 06.07.2015 um 11:30:
>> -----Original Message-----
>> From: Jonathan Cameron [mailto:jic23@kernel.org]
>> Sent: Sunday, July 5, 2015 2:25 PM
>> To: Hartmut Knaack; linux-iio@vger.kernel.org
>> Cc: Lars-Peter Clausen; Peter Meerwald; Breana, Tiberiu A
>> Subject: Re: [PATCH 3/5] iio:light:stk3310: add more error handling
>>
>> On 04/07/15 16:56, Hartmut Knaack wrote:
>>> Check for the following error cases:
>>>   * lower boundary for val in _write_event
>>>   * return value of regmap_(field_)read
>>>   * possible values for chan->type
>>>   * return value of stk3310_gpio_probe
>>>
>>> Also add an error-cleanup path in _probe to handle failure in
>>> iio_device_register and devm_request_threaded_irq.
>>>
>>> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
>> I'm not sure how I missed this before, but the probe order below is rather
>> unusual.  I'm a little bothered by the theoretical race condition between the
>> exposure of the device to userspace
>> (device_register) and the configuration of it's irq later.
>>
>> It is probably possible (in theory) to enable an event before the irq is
>> registered and get the event to fire, resulting in an unhandled interrupt.
>>
>> I'm going to hold back on the rest of this set until Tiberiu has had a chance to
>> comment on them anyway.
>>
>> Jonathan
> 
> Agreed, the probe order needs to be changed. Some comments below.
> 
> Tiberiu
> 
<...>
>>> -611,11 +631,14 @@ static int stk3310_probe(struct i2c_client *client,
>>>  	ret = iio_device_register(indio_dev);
>>>  	if (ret < 0) {
>>>  		dev_err(&client->dev, "device_register failed\n");
>>> -		stk3310_set_state(data, STK3310_STATE_STANDBY);
>>> +		goto err_standby;
>>>  	}
>>>
>>> -	if (client->irq <= 0)
>>> +	if (client->irq <= 0) {
> 
> Sort of unrelated to your patch, but I think this should be (client->irq < 0)
> I would appreciate it if you would include it in your next patch set :)
> 

No problem, this will be included in my new revision.

>>>  		client->irq = stk3310_gpio_probe(client);
>>> +		if (client->irq < 0)
>>> +			goto err_unregister;
>>> +	}
>>>
>>>  	if (client->irq >= 0) {
>>>  		ret = devm_request_threaded_irq(&client->dev, client->irq,
>> @@
>>> -624,11 +647,20 @@ static int stk3310_probe(struct i2c_client *client,
>>>  						IRQF_TRIGGER_FALLING |
>>>  						IRQF_ONESHOT,
>>>  						STK3310_EVENT, indio_dev);
>>> -		if (ret < 0)
>>> +		if (ret < 0) {
>>>  			dev_err(&client->dev, "request irq %d failed\n",
>>>  					client->irq);
>>> +			goto err_unregister;
>>> +		}
>>>  	}
>>>
>>> +	return 0;
>>> +
>>> +err_unregister:
>>> +	iio_device_unregister(indio_dev);
>> This made me nervous, as there is a very good reason the register is almost
>> always last in the probe function.  It exposes the interfaces to userspace (and
>> in kernel for that matter).  Everything must be ready before it is called.  Here
>> we could (though unlikely) get an unhandled interrupt as the handler has not
>> been registered as yet.
> 
> The iio_device_register block should indeed be moved to the end of _probe.
> 
>>> +err_standby:
>>> +	stk3310_set_state(data, STK3310_STATE_STANDBY);
>>> +
>>>  	return ret;
>>>  }
>>>
>>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
