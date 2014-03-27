Return-Path: <srinivas.pandruvada@linux.intel.com>
Message-ID: <53349D41.4090209@linux.intel.com>
Date: Thu, 27 Mar 2014 14:50:57 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: Jean Delvare <jdelvare@suse.de>, linux-iio@vger.kernel.org,
 linux-i2c@vger.kernel.org, ktsai@capellamicro.com
Subject: Re: [RFC Patch v0 1/3] i2c-smbus: Add poll interface for smbus alert
References: <1395880932-19124-1-git-send-email-srinivas.pandruvada@linux.intel.com> <20140327084456.26527b4d@endymion.delvare> <2144b3b3-2ec6-4fe6-a6e5-2b89bb64c7b6@email.android.com>
In-Reply-To: <2144b3b3-2ec6-4fe6-a6e5-2b89bb64c7b6@email.android.com>
Content-Type: multipart/alternative;
 boundary="------------040901040201070900010106"
List-ID: <linux-iio@vger.kernel.org>

This is a multi-part message in MIME format.
--------------040901040201070900010106
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/27/2014 10:34 AM, Jonathan Cameron wrote:
>
> On March 27, 2014 7:44:56 AM GMT+00:00, Jean Delvare <jdelvare@suse.de> wrote:
>> On Wed, 26 Mar 2014 17:42:10 -0700, Srinivas Pandruvada wrote:
>>> The current i2c smbus alert module depends on smbus alert mechanism
>>> supported by underlying bus drivers. By specifications, these alerts
>>> can be polled if there is no hardware support.
>>> Currently multiple drivers who needs smbus alerts are creating
>>> a new i2c dummy device with address 0x0C (ARA register), by luck
>>> they don't co-exist. Otherwise i2c device creation will fail.
>>> Added a poll interface, so that all these driver can call a common
>>> interface to poll. Even if they polli, all drivers bound to an
>>> adapater will be notified by their alert callback if ARA register
>>> read is successful.
>>>
>>> Signed-off-by: Srinivas Pandruvada
>> <srinivas.pandruvada@linux.intel.com>
>>> ---
>>>   drivers/i2c/i2c-smbus.c   | 23 +++++++++++++++++++++++
>>>   include/linux/i2c-smbus.h |  3 +++
>>>   2 files changed, 26 insertions(+)
>>>
>>> diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
>>> index fc99f0d..e274f20 100644
>>> --- a/drivers/i2c/i2c-smbus.c
>>> +++ b/drivers/i2c/i2c-smbus.c
>>> @@ -72,6 +72,29 @@ static int smbus_do_alert(struct device *dev, void
>> *addrp)
>>>   	return -EBUSY;
>>>   }
>>>   
>>> +int i2c_smbus_ara_poll(const struct i2c_client *client)
>>> +{
>>> +	union i2c_smbus_data data;
>>> +	int status;
>>> +	struct alert_data alert_data;
>>> +
>>> +	status = i2c_smbus_xfer(client->adapter, 0x0C, 0,
>>> +				I2C_SMBUS_READ, 0,
>>> +				I2C_SMBUS_BYTE, &data);
>>> +	if (status < 0)
>>> +		return status;
>>> +
>>> +	alert_data.flag = data.byte & 1;
>>> +	alert_data.addr = data.byte >> 1;
>>> +
>>> +	/* Notify driver for the device which issued the alert */
>>> +	device_for_each_child(&client->adapter->dev, &alert_data,
>>> +				smbus_do_alert);
>>> +
>>> +	return data.byte;
>>> +}
>> This is essentially duplicating code from smbus_alert(), but in a
>> hackish way, as the ARA is never properly reserved. Your bus driver
>> should really register the ARA with i2c_setup_smbus_alert().
>>
>> I see that the code may not properly deal with the polled case
>> everywhere but it should be pretty trivial to deal with. For example,
>> check for alert->irq > 0 before re-enabling the irq in smbus_alert(). I
>> don't immediately see any other change needed.
>>
>> If SMBus alert polling is done from the i2c device driver, we'll have
>> to find a standard way for i2c device drivers to retrieve the ara
>> client associated with an i2c_adapter. However I still need to be
>> convinced that this makes any sense at all. Ultimately the alert will
>> call the i2c device drivers's alert() callback. If the i2c device
>> driver needs to do that, there's no need to go through ARA, it might as
>> well just call the callback by itself.
>>
>> So can you please explain what problem exactly you are trying to solve?
> As I understand it the issue is that some parts will not clear their internal interrupt status unless an at a read occurs and presumably the read has to get the correct address?
>
> To my mind we should have polling inside the core and it should ensure all devices that want to have replied.  Have I miss understood how Ara is supposed to work but should we not know which device to call the callback on?

This is summary: May be Jean can suggest some better solution:
- We have some sensor devices on i2C bus, which need to read ARA 
register to ack smbus alert signal. Without acking this, they will not 
allow further reads. They currently are calling  i2c_new_dummy() for 
reserving ARA (0x0C) register. But the problem is if there are two 
devices on this bus both have to read ARA, they can't call 
i2c_new_dummy() as one of them will fail (__i2c_check_addr_busy() will 
return -EBUSY).
- In above case, If they use hacked way to use i2_transfer function, but 
it will not address the real issue. Because one driver is reading ARA 
basically can acknowledge ALERT from wrong device.

So their needs to be a core level poll so that devices can be notified, 
if there is an alert for their device only.

 From physical interface level many i2controllers (including  x86s) 
don't have separate signal for SMBALERT#. So somewhere it needs polling. 
For some devices SMBALERT is wired through a GPIO for GPIO interrupt. 
But they still need to read ARA to ACK.

Also we can't blindly reserve 0x0c for every i2c-bus as 0x0C is a valid 
i2C address. There are already occupied (e.g. AK8963 slave address is 
0x0C on the same platforms). So can't call i2c_setup_smbus_alert from 
the bus driver for all i2c buses.

For polling, a bus driver can't decide periodic polling as this is 
power/perf drain. So my idea was to somehow kick a read on ARA on a bus 
from interested clients may be when the receive GPIO interrupt. But the 
results are notified to interested drivers who needs smbus alert processing.

Thanks,
Srinivas














>>> +EXPORT_SYMBOL_GPL(i2c_smbus_ara_poll);
>>> +
>>>   /*
>>>    * The alert IRQ handler needs to hand work off to a task which can
>> issue
>>>    * SMBus calls, because those sleeping calls can't be made in IRQ
>> context.
>>> diff --git a/include/linux/i2c-smbus.h b/include/linux/i2c-smbus.h
>>> index 8f1b086..f70755d 100644
>>> --- a/include/linux/i2c-smbus.h
>>> +++ b/include/linux/i2c-smbus.h
>>> @@ -48,4 +48,7 @@ struct i2c_client *i2c_setup_smbus_alert(struct
>> i2c_adapter *adapter,
>>>   					 struct i2c_smbus_alert_setup *setup);
>>>   int i2c_handle_smbus_alert(struct i2c_client *ara);
>>>   
>>> +/* Interface to poll smbus alert */
>>> +int i2c_smbus_ara_poll(const struct i2c_client *client);
>>> +
>>>   #endif /* _LINUX_I2C_SMBUS_H */


--------------040901040201070900010106
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">On 03/27/2014 10:34 AM, Jonathan
      Cameron wrote:<br>
    </div>
    <blockquote
      cite="mid:2144b3b3-2ec6-4fe6-a6e5-2b89bb64c7b6@email.android.com"
      type="cite">
      <pre wrap="">

On March 27, 2014 7:44:56 AM GMT+00:00, Jean Delvare <a class="moz-txt-link-rfc2396E" href="mailto:jdelvare@suse.de">&lt;jdelvare@suse.de&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">On Wed, 26 Mar 2014 17:42:10 -0700, Srinivas Pandruvada wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="">The current i2c smbus alert module depends on smbus alert mechanism
supported by underlying bus drivers. By specifications, these alerts
can be polled if there is no hardware support.
Currently multiple drivers who needs smbus alerts are creating
a new i2c dummy device with address 0x0C (ARA register), by luck
they don't co-exist. Otherwise i2c device creation will fail.
Added a poll interface, so that all these driver can call a common
interface to poll. Even if they polli, all drivers bound to an
adapater will be notified by their alert callback if ARA register
read is successful.

Signed-off-by: Srinivas Pandruvada
</pre>
        </blockquote>
        <pre wrap=""><a class="moz-txt-link-rfc2396E" href="mailto:srinivas.pandruvada@linux.intel.com">&lt;srinivas.pandruvada@linux.intel.com&gt;</a>
</pre>
        <blockquote type="cite">
          <pre wrap="">---
 drivers/i2c/i2c-smbus.c   | 23 +++++++++++++++++++++++
 include/linux/i2c-smbus.h |  3 +++
 2 files changed, 26 insertions(+)

diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
index fc99f0d..e274f20 100644
--- a/drivers/i2c/i2c-smbus.c
+++ b/drivers/i2c/i2c-smbus.c
@@ -72,6 +72,29 @@ static int smbus_do_alert(struct device *dev, void
</pre>
        </blockquote>
        <pre wrap="">*addrp)
</pre>
        <blockquote type="cite">
          <pre wrap=""> 	return -EBUSY;
 }
 
+int i2c_smbus_ara_poll(const struct i2c_client *client)
+{
+	union i2c_smbus_data data;
+	int status;
+	struct alert_data alert_data;
+
+	status = i2c_smbus_xfer(client-&gt;adapter, 0x0C, 0,
+				I2C_SMBUS_READ, 0,
+				I2C_SMBUS_BYTE, &amp;data);
+	if (status &lt; 0)
+		return status;
+
+	alert_data.flag = data.byte &amp; 1;
+	alert_data.addr = data.byte &gt;&gt; 1;
+
+	/* Notify driver for the device which issued the alert */
+	device_for_each_child(&amp;client-&gt;adapter-&gt;dev, &amp;alert_data,
+				smbus_do_alert);
+
+	return data.byte;
+}
</pre>
        </blockquote>
        <pre wrap="">
This is essentially duplicating code from smbus_alert(), but in a
hackish way, as the ARA is never properly reserved. Your bus driver
should really register the ARA with i2c_setup_smbus_alert().

I see that the code may not properly deal with the polled case
everywhere but it should be pretty trivial to deal with. For example,
check for alert-&gt;irq &gt; 0 before re-enabling the irq in smbus_alert(). I
don't immediately see any other change needed.

If SMBus alert polling is done from the i2c device driver, we'll have
to find a standard way for i2c device drivers to retrieve the ara
client associated with an i2c_adapter. However I still need to be
convinced that this makes any sense at all. Ultimately the alert will
call the i2c device drivers's alert() callback. If the i2c device
driver needs to do that, there's no need to go through ARA, it might as
well just call the callback by itself.

So can you please explain what problem exactly you are trying to solve?
</pre>
      </blockquote>
      <pre wrap="">
As I understand it the issue is that some parts will not clear their internal interrupt status unless an at a read occurs and presumably the read has to get the correct address?  

To my mind we should have polling inside the core and it should ensure all devices that want to have replied.  Have I miss understood how Ara is supposed to work but should we not know which device to call the callback on?
</pre>
    </blockquote>
    <br>
    This is summary: May be Jean can suggest some better solution:<br>
    - We have some sensor devices on i2C bus, which need to read ARA
    register to ack smbus alert signal. Without acking this, they will
    not allow further reads. They currently are calling  i2c_new_dummy()
    for reserving ARA (0x0C) register. But the problem is if there are
    two devices on this bus both have to read ARA, they can't call
    i2c_new_dummy() as one of them will fail (__i2c_check_addr_busy()
    will return -EBUSY).<br>
    - In above case, If they use hacked way to use i2_transfer function,
    but it will not address the real issue. Because one driver is
    reading ARA basically can acknowledge ALERT from wrong device.<br>
    <br>
    So their needs to be a core level poll so that devices can be
    notified, if there is an alert for their device only.<br>
    <br>
    From physical interface level many i2controllers (including  x86s)
    don't have separate signal for SMBALERT#. So somewhere it needs
    polling. For some devices SMBALERT is wired through a GPIO for GPIO
    interrupt. But they still need to read ARA to ACK.<br>
    <br>
    Also we can't blindly reserve 0x0c for every i2c-bus as 0x0C is a
    valid i2C address. There are already occupied (e.g. AK8963 slave
    address is 0x0C on the same platforms). So can't call
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    i2c_setup_smbus_alert from the bus driver for all i2c buses.<br>
    <br>
    For polling, a bus driver can't decide periodic polling as this is
    power/perf drain. So my idea was to somehow kick a read on ARA on a
    bus from interested clients may be when the receive GPIO interrupt.
    But the results are notified to interested drivers who needs smbus
    alert processing.<br>
    <br>
    Thanks,<br>
    Srinivas<br>
    <br>
    <br>
    <br>
    <br>
    <br>
     <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <blockquote
      cite="mid:2144b3b3-2ec6-4fe6-a6e5-2b89bb64c7b6@email.android.com"
      type="cite">
      <blockquote type="cite">
        <pre wrap="">
</pre>
        <blockquote type="cite">
          <pre wrap="">+EXPORT_SYMBOL_GPL(i2c_smbus_ara_poll);
+
 /*
  * The alert IRQ handler needs to hand work off to a task which can
</pre>
        </blockquote>
        <pre wrap="">issue
</pre>
        <blockquote type="cite">
          <pre wrap="">  * SMBus calls, because those sleeping calls can't be made in IRQ
</pre>
        </blockquote>
        <pre wrap="">context.
</pre>
        <blockquote type="cite">
          <pre wrap="">diff --git a/include/linux/i2c-smbus.h b/include/linux/i2c-smbus.h
index 8f1b086..f70755d 100644
--- a/include/linux/i2c-smbus.h
+++ b/include/linux/i2c-smbus.h
@@ -48,4 +48,7 @@ struct i2c_client *i2c_setup_smbus_alert(struct
</pre>
        </blockquote>
        <pre wrap="">i2c_adapter *adapter,
</pre>
        <blockquote type="cite">
          <pre wrap=""> 					 struct i2c_smbus_alert_setup *setup);
 int i2c_handle_smbus_alert(struct i2c_client *ara);
 
+/* Interface to poll smbus alert */
+int i2c_smbus_ara_poll(const struct i2c_client *client);
+
 #endif /* _LINUX_I2C_SMBUS_H */
</pre>
        </blockquote>
      </blockquote>
      <pre wrap="">
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------040901040201070900010106--
