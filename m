Return-Path: <srinivas.pandruvada@linux.intel.com>
Message-ID: <53398916.70505@linux.intel.com>
Date: Mon, 31 Mar 2014 08:26:14 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: Jean Delvare <jdelvare@suse.de>, linux-iio@vger.kernel.org,
 linux-i2c@vger.kernel.org, ktsai@capellamicro.com
Subject: Re: [RFC Patch v0 1/3] i2c-smbus: Add poll interface for smbus alert
References: <1395880932-19124-1-git-send-email-srinivas.pandruvada@linux.intel.com> <20140327084456.26527b4d@endymion.delvare> <2144b3b3-2ec6-4fe6-a6e5-2b89bb64c7b6@email.android.com> <53349D41.4090209@linux.intel.com> <53369D37.8010004@kernel.org>
In-Reply-To: <53369D37.8010004@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 03/29/2014 03:15 AM, Jonathan Cameron wrote:
> On 27/03/14 21:50, Srinivas Pandruvada wrote:
>> On 03/27/2014 10:34 AM, Jonathan Cameron wrote:
>>>
>>> On March 27, 2014 7:44:56 AM GMT+00:00, Jean 
>>> Delvare<jdelvare@suse.de>  wrote:
>>>> On Wed, 26 Mar 2014 17:42:10 -0700, Srinivas Pandruvada wrote:
>>>>> The current i2c smbus alert module depends on smbus alert mechanism
>>>>> supported by underlying bus drivers. By specifications, these alerts
>>>>> can be polled if there is no hardware support.
>>>>> Currently multiple drivers who needs smbus alerts are creating
>>>>> a new i2c dummy device with address 0x0C (ARA register), by luck
>>>>> they don't co-exist. Otherwise i2c device creation will fail.
>>>>> Added a poll interface, so that all these driver can call a common
>>>>> interface to poll. Even if they polli, all drivers bound to an
>>>>> adapater will be notified by their alert callback if ARA register
>>>>> read is successful.
>>>>>
>>>>> Signed-off-by: Srinivas Pandruvada
>>>> <srinivas.pandruvada@linux.intel.com>
>>>>> ---
>>>>>   drivers/i2c/i2c-smbus.c   | 23 +++++++++++++++++++++++
>>>>>   include/linux/i2c-smbus.h |  3 +++
>>>>>   2 files changed, 26 insertions(+)
>>>>>
>>>>> diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
>>>>> index fc99f0d..e274f20 100644
>>>>> --- a/drivers/i2c/i2c-smbus.c
>>>>> +++ b/drivers/i2c/i2c-smbus.c
>>>>> @@ -72,6 +72,29 @@ static int smbus_do_alert(struct device *dev, void
>>>> *addrp)
>>>>>       return -EBUSY;
>>>>>   }
>>>>>
>>>>> +int i2c_smbus_ara_poll(const struct i2c_client *client)
>>>>> +{
>>>>> +    union i2c_smbus_data data;
>>>>> +    int status;
>>>>> +    struct alert_data alert_data;
>>>>> +
>>>>> +    status = i2c_smbus_xfer(client->adapter, 0x0C, 0,
>>>>> +                I2C_SMBUS_READ, 0,
>>>>> +                I2C_SMBUS_BYTE, &data);
>>>>> +    if (status < 0)
>>>>> +        return status;
>>>>> +
>>>>> +    alert_data.flag = data.byte & 1;
>>>>> +    alert_data.addr = data.byte >> 1;
>>>>> +
>>>>> +    /* Notify driver for the device which issued the alert */
>>>>> + device_for_each_child(&client->adapter->dev, &alert_data,
>>>>> +                smbus_do_alert);
>>>>> +
>>>>> +    return data.byte;
>>>>> +}
>>>> This is essentially duplicating code from smbus_alert(), but in a
>>>> hackish way, as the ARA is never properly reserved. Your bus driver
>>>> should really register the ARA with i2c_setup_smbus_alert().
>>>>
>>>> I see that the code may not properly deal with the polled case
>>>> everywhere but it should be pretty trivial to deal with. For example,
>>>> check for alert->irq > 0 before re-enabling the irq in 
>>>> smbus_alert(). I
>>>> don't immediately see any other change needed.
>>>>
>>>> If SMBus alert polling is done from the i2c device driver, we'll have
>>>> to find a standard way for i2c device drivers to retrieve the ara
>>>> client associated with an i2c_adapter. However I still need to be
>>>> convinced that this makes any sense at all. Ultimately the alert will
>>>> call the i2c device drivers's alert() callback. If the i2c device
>>>> driver needs to do that, there's no need to go through ARA, it 
>>>> might as
>>>> well just call the callback by itself.
>>>>
>>>> So can you please explain what problem exactly you are trying to 
>>>> solve?
>>> As I understand it the issue is that some parts will not clear
>>> their internal interrupt status unless an at a read occurs and
>>> presumably the read has to get the correct address?
>>>
>>> To my mind we should have polling inside the core and it should
>>> ensure all devices that want to have replied. Have I miss
>>> understood how Ara is supposed to work but should we not know which
>>> device to call the callback on?
> Ah, I was barking up the wrong tree with this one and had missed the
> check that was conducted to ensure that only the right device is
> notified.  Sorry about that.
>
>> This is summary: May be Jean can suggest some better solution: - We
>> have some sensor devices on i2C bus, which need to read ARA register
>> to ack smbus alert signal. Without acking this, they will not allow
>> further reads. They currently are calling i2c_new_dummy() for
>> reserving ARA (0x0C) register. But the problem is if there are two
>> devices on this bus both have to read ARA, they can't call
>> i2c_new_dummy() as one of them will fail (__i2c_check_addr_busy()
>> will return -EBUSY). - In above case, If they use hacked way to use
>> i2_transfer function, but it will not address the real issue. Because
>> one driver is reading ARA basically can acknowledge ALERT from wrong
>> device.
>>
>> So their needs to be a core level poll so that devices can be
>> notified, if there is an alert for their device only.
> Agreed.  Right now at a quick glance, all devices are notified which
> seems odd...
>>
>> From physical interface level many i2controllers (including x86s)
>> don't have separate signal for SMBALERT#. So somewhere it needs
>> polling. For some devices SMBALERT is wired through a GPIO for GPIO
>> interrupt. But they still need to read ARA to ACK.
> If it is wired through a gpio interrupt (and that interrupt is shared
> by various smbalert equipped devices - or there is only one present
> on the i2c bus) then it should be handled using the existing
> infrastructure. (perhaps modified slightly)
If we somehow know that the interrupt is for SMBALERT, we could
do with the current mechanisms. The ACPI configuration only provides
an IRQ number for each device, but don't provide whether it is for SMBALERT.
If we know we can handle it better. I will ping ACPI committee, if they 
can add better support.
>>
>> Also we can't blindly reserve 0x0c for every i2c-bus as 0x0C is a
>> valid i2C address. There are already occupied (e.g. AK8963 slave
>> address is 0x0C on the same platforms). So can't call
>> i2c_setup_smbus_alert from the bus driver for all i2c buses.
> If platforms are wiring up both devices using this i2c address and
> smbus alert devices then we are in an irritating corner case.
> This is effectively the same as having two different smbus devices
> on the same address and relying on the fact they don't have
> overlapping address spaces.  Nuts but I guess we want to find some
> way of coping with it?
>
> Perhaps we need  away of allow multiple i2c devices to share a bus
> in this case?  Is this something that could be done via a nefarious
> hack of using a mux to pretend that they are separately wired
> (when they aren't).
>>
>> For polling, a bus driver can't decide periodic polling as this is
>> power/perf drain.
> Agreed, so hints from the drivers to the core would be needed.
>> So my idea was to somehow kick a read on ARA on a
>> bus from interested clients may be when the receive GPIO interrupt.
> Then you can end up with considerable waste if you have lots of devices
> using this functionality on the same bus.  Each driver polls at say
> 50Hz, because it wants 50Hz, but you have 20 devices hence you get
> uneven sampling at say 1kHz and might even block the i2c bus up entirely.
> Hence the polling needs to be handled by the core.  I'd suggest
> a call to request enabling of polling and a frequency.  Then the
> core just uses the highest frequency currently requested.
>
Agreed.
> It's a bit more complex than the nice sensible interrupt driven
> version, but if board designers are going to do silly things
> I guess we have to figure out how to make them work.
>
That is the reality.

Thanks,
Srinivas
>> But the results are notified to interested drivers who needs smbus
>> alert processing.
>> Thanks,
>> Srinivas
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>>>> +EXPORT_SYMBOL_GPL(i2c_smbus_ara_poll);
>>>>> +
>>>>>   /*
>>>>>    * The alert IRQ handler needs to hand work off to a task which can
>>>> issue
>>>>>    * SMBus calls, because those sleeping calls can't be made in IRQ
>>>> context.
>>>>> diff --git a/include/linux/i2c-smbus.h b/include/linux/i2c-smbus.h
>>>>> index 8f1b086..f70755d 100644
>>>>> --- a/include/linux/i2c-smbus.h
>>>>> +++ b/include/linux/i2c-smbus.h
>>>>> @@ -48,4 +48,7 @@ struct i2c_client *i2c_setup_smbus_alert(struct
>>>> i2c_adapter *adapter,
>>>>>                        struct i2c_smbus_alert_setup *setup);
>>>>>   int i2c_handle_smbus_alert(struct i2c_client *ara);
>>>>>
>>>>> +/* Interface to poll smbus alert */
>>>>> +int i2c_smbus_ara_poll(const struct i2c_client *client);
>>>>> +
>>>>>   #endif /* _LINUX_I2C_SMBUS_H */
>>
>
>
