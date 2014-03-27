Return-Path: <srinivas.pandruvada@linux.intel.com>
Message-ID: <53344647.2000405@linux.intel.com>
Date: Thu, 27 Mar 2014 08:39:51 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
To: Jean Delvare <jdelvare@suse.de>
CC: jic23@kernel.org, linux-iio@vger.kernel.org,
 linux-i2c@vger.kernel.org, ktsai@capellamicro.com
Subject: Re: [RFC Patch v0 1/3] i2c-smbus: Add poll interface for smbus alert
References: <1395880932-19124-1-git-send-email-srinivas.pandruvada@linux.intel.com> <20140327084456.26527b4d@endymion.delvare>
In-Reply-To: <20140327084456.26527b4d@endymion.delvare>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 03/27/2014 12:44 AM, Jean Delvare wrote:
> On Wed, 26 Mar 2014 17:42:10 -0700, Srinivas Pandruvada wrote:
>> The current i2c smbus alert module depends on smbus alert mechanism
>> supported by underlying bus drivers. By specifications, these alerts
>> can be polled if there is no hardware support.
>> Currently multiple drivers who needs smbus alerts are creating
>> a new i2c dummy device with address 0x0C (ARA register), by luck
>> they don't co-exist. Otherwise i2c device creation will fail.
>> Added a poll interface, so that all these driver can call a common
>> interface to poll. Even if they polli, all drivers bound to an
>> adapater will be notified by their alert callback if ARA register
>> read is successful.
>>
>> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>> ---
>>   drivers/i2c/i2c-smbus.c   | 23 +++++++++++++++++++++++
>>   include/linux/i2c-smbus.h |  3 +++
>>   2 files changed, 26 insertions(+)
>>
>> diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
>> index fc99f0d..e274f20 100644
>> --- a/drivers/i2c/i2c-smbus.c
>> +++ b/drivers/i2c/i2c-smbus.c
>> @@ -72,6 +72,29 @@ static int smbus_do_alert(struct device *dev, void *addrp)
>>   	return -EBUSY;
>>   }
>>   
>> +int i2c_smbus_ara_poll(const struct i2c_client *client)
>> +{
>> +	union i2c_smbus_data data;
>> +	int status;
>> +	struct alert_data alert_data;
>> +
>> +	status = i2c_smbus_xfer(client->adapter, 0x0C, 0,
>> +				I2C_SMBUS_READ, 0,
>> +				I2C_SMBUS_BYTE, &data);
>> +	if (status < 0)
>> +		return status;
>> +
>> +	alert_data.flag = data.byte & 1;
>> +	alert_data.addr = data.byte >> 1;
>> +
>> +	/* Notify driver for the device which issued the alert */
>> +	device_for_each_child(&client->adapter->dev, &alert_data,
>> +				smbus_do_alert);
>> +
>> +	return data.byte;
>> +}
> This is essentially duplicating code from smbus_alert(), but in a
> hackish way, as the ARA is never properly reserved. Your bus driver
> should really register the ARA with i2c_setup_smbus_alert().
>
> I see that the code may not properly deal with the polled case
> everywhere but it should be pretty trivial to deal with. For example,
> check for alert->irq > 0 before re-enabling the irq in smbus_alert(). I
> don't immediately see any other change needed.
>
> If SMBus alert polling is done from the i2c device driver, we'll have
> to find a standard way for i2c device drivers to retrieve the ara
> client associated with an i2c_adapter. However I still need to be
> convinced that this makes any sense at all. Ultimately the alert will
> call the i2c device drivers's alert() callback. If the i2c device
> driver needs to do that, there's no need to go through ARA, it might as
> well just call the callback by itself.
>
> So can you please explain what problem exactly you are trying to solve?
The current i2c clients and proposed patches are creating dummy devices.
You can't create two devices with same address. So they can't coexist.
Also 0x0c is a valid i2c address, so we can't create a new i2c device.
We have products there are devices on i2C on 0x0c. So don't you think
after calling
i2c_setup_smbus_alert()
the other device can really be setup by calling  i2c_new_device(). This 
function
does a busy_check for same addresses.

The idea is if some i2c client triggers ARA read,  it doesn't destroy the
real receiver of the the smb alert and call respective alert() callbacks,
>> +EXPORT_SYMBOL_GPL(i2c_smbus_ara_poll);
>> +
>>   /*
>>    * The alert IRQ handler needs to hand work off to a task which can issue
>>    * SMBus calls, because those sleeping calls can't be made in IRQ context.
>> diff --git a/include/linux/i2c-smbus.h b/include/linux/i2c-smbus.h
>> index 8f1b086..f70755d 100644
>> --- a/include/linux/i2c-smbus.h
>> +++ b/include/linux/i2c-smbus.h
>> @@ -48,4 +48,7 @@ struct i2c_client *i2c_setup_smbus_alert(struct i2c_adapter *adapter,
>>   					 struct i2c_smbus_alert_setup *setup);
>>   int i2c_handle_smbus_alert(struct i2c_client *ara);
>>   
>> +/* Interface to poll smbus alert */
>> +int i2c_smbus_ara_poll(const struct i2c_client *client);
>> +
>>   #endif /* _LINUX_I2C_SMBUS_H */
>
