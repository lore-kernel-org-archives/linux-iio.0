Return-Path: <gregor.boirie@parrot.com>
Message-ID: <56CAF1DD.8070807@parrot.com>
Date: Mon, 22 Feb 2016 12:32:45 +0100
From: Gregor Boirie <gregor.boirie@parrot.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>
CC: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH v1 2/2] iio:iio-interrupt-trigger: sysfs poll support
References: <cover.1455908065.git.gregor.boirie@parrot.com> <87bbff0671c93b998547114d7f595a0bee57e817.1455908065.git.gregor.boirie@parrot.com> <56CA195B.9010200@kernel.org>
In-Reply-To: <56CA195B.9010200@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 02/21/2016 09:08 PM, Jonathan Cameron wrote:
> On 19/02/16 19:18, Gregor Boirie wrote:
>> From: Grégor Boirie <gregor.boirie@parrot.com>
>>
> Hi Gregor.
>
> You certainly have some unusual requirements  - or perhaps you are
> simply the first person to show up with them here!
I would give preference to 2nd option :)
>> Add a sysfs file entry for each interrupt trigger instance allowing
>> userspace to :
>> * poll for interrupt events ;
> Why?
On our platform, several sensors are driven by a dedicated "real-time"
CPU (bare-metal context). This CPU interrupts Linux in a periodic manner
which in turn wakes a user process up to perform sensor fusion.
This sysfs poll support allows the user process to explictly wait for
this dedicated CPU interrupt to fetch data located in RAM then process
them.

>
>> * retrieve number of interrupts that occurred since trigger was
>> * initialized
> Again why?
Some critical process scheduled at higher priority might in rare cases defer
the execution of sensor data polling. To recover from such situations, our
sensor fusion algorithm needs to know if interrupt events were missed since
last polling iteration and how many.
>
> This is interesting stuff, but I'd like to fully understand the question
> of what you are doing with it before we go too far into the code.
>> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
>> ---
>>   .../ABI/testing/sysfs-bus-iio-trig-interrupt       | 22 ++++++
>>   drivers/iio/trigger/iio-trig-interrupt.c           | 88 ++++++++++++++++------
>>   2 files changed, 88 insertions(+), 22 deletions(-)
>>   create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-trig-interrupt
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-trig-interrupt b/Documentation/ABI/testing/sysfs-bus-iio-trig-interrupt
>> new file mode 100644
>> index 0000000..cb246d2
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-bus-iio-trig-interrupt
>> @@ -0,0 +1,22 @@
>> +What:		/sys/bus/iio/devices/triggerX/name
>> +KernelVersion:	3.11
>> +Contact:	linux-iio@vger.kernel.org
>> +Description:
>> +		The name attribute holds a description string for the current
>> +		trigger. In order to associate the trigger with an IIO device
>> +		one should write this name string to
>> +		/sys/bus/iio/devices/iio:deviceY/trigger/current_trigger.
>> +
>> +What:		/sys/bus/iio/devices/triggerX/count
>> +KernelVersion:	4.5
>> +Contact:	linux-iio@vger.kernel.org
>> +Description:
>> +		The count attribute is a unsigned int counter holding the number
>> +		of times the attached interrupt occurred since trigger was
>> +		initialized.
>> +		You can poll(2) on that file and poll(2) will return whenever
>> +		the interrupt was triggered. If you use poll(2), set the events
>> +		POLLPRI and POLLERR. If you use select(2), set the file
>> +		descriptor in exceptfds. After poll(2) returns, either lseek(2)
>> +		to the beginning of the sysfs file and read the new value or
>> +		close the file and re-open it to read the value.
>> diff --git a/drivers/iio/trigger/iio-trig-interrupt.c b/drivers/iio/trigger/iio-trig-interrupt.c
>> index 3c4e18f..1bf3986 100644
>> --- a/drivers/iio/trigger/iio-trig-interrupt.c
>> +++ b/drivers/iio/trigger/iio-trig-interrupt.c
>> @@ -17,14 +17,53 @@
>>   #include <linux/iio/iio.h>
>>   #include <linux/iio/trigger.h>
>>   
>> -
>>   struct iio_interrupt_trigger_info {
>> +	struct kernfs_node *poll;
>> +	atomic_t count;
>>   	unsigned int irq;
>>   };
>>   
>> +/*
>> + * If interested by counter value, userspace should read often enough since
>> + * counter may wrap. Userspace will miss interrupt events when counter wraps
>> + * twice or more between 2 consecutive reads.
>> + */
>> +ssize_t iio_interrupt_trigger_show_count(struct device *dev,
>> +					 struct device_attribute *attr,
>> +					 char *buf)
>> +{
>> +	struct iio_trigger *trig = to_iio_trigger(dev);
>> +	struct iio_interrupt_trigger_info *info = iio_trigger_get_drvdata(trig);
>> +	unsigned int count = atomic_read(&info->count);
>> +
>> +	return snprintf(buf, PAGE_SIZE, "%u\n", count);
>> +}
>> +
>> +static DEVICE_ATTR(count, S_IRUGO, iio_interrupt_trigger_show_count, NULL);
>> +
>> +static struct attribute *iio_interrupt_trigger_attrs[] = {
>> +	&dev_attr_count.attr,
>> +	NULL,
>> +};
>> +
>> +static const struct attribute_group iio_interrupt_trigger_attr_group = {
>> +	.attrs = iio_interrupt_trigger_attrs,
>> +};
>> +
>> +static const struct attribute_group *iio_interrupt_trigger_attr_groups[] = {
>> +	&iio_interrupt_trigger_attr_group,
>> +	NULL
>> +};
>> +
>>   static irqreturn_t iio_interrupt_trigger_poll(int irq, void *private)
>>   {
>> -	iio_trigger_poll(private);
>> +	struct iio_trigger *trig = private;
>> +	struct iio_interrupt_trigger_info *info = iio_trigger_get_drvdata(trig);
>> +
>> +	atomic_inc(&info->count);
>> +	sysfs_notify_dirent(info->poll);
>> +	iio_trigger_poll(trig);
>> +
>>   	return IRQ_HANDLED;
>>   }
>>   
>> @@ -36,17 +75,12 @@ static int iio_interrupt_trigger_probe(struct platform_device *pdev)
>>   {
>>   	struct iio_interrupt_trigger_info *trig_info;
>>   	struct iio_trigger *trig;
>> -	unsigned long irqflags;
>>   	struct resource *irq_res;
>>   	int irq, ret = 0;
>>   
>>   	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>> -
>> -	if (irq_res == NULL)
>> +	if (!irq_res)
>>   		return -ENODEV;
>> -
>> -	irqflags = (irq_res->flags & IRQF_TRIGGER_MASK) | IRQF_SHARED;
>> -
>>   	irq = irq_res->start;
>>   
>>   	trig = iio_trigger_alloc("irqtrig%d", irq);
>> @@ -60,27 +94,36 @@ static int iio_interrupt_trigger_probe(struct platform_device *pdev)
>>   		ret = -ENOMEM;
>>   		goto error_put_trigger;
>>   	}
>> -	iio_trigger_set_drvdata(trig, trig_info);
>> +
>> +	atomic_set(&trig_info->count, 0);
>>   	trig_info->irq = irq;
>> +	iio_trigger_set_drvdata(trig, trig_info);
>>   	trig->ops = &iio_interrupt_trigger_ops;
>> -	ret = request_irq(irq, iio_interrupt_trigger_poll,
>> -			  irqflags, trig->name, trig);
>> -	if (ret) {
>> -		dev_err(&pdev->dev,
>> -			"request IRQ-%d failed", irq);
>> +	trig->dev.groups = iio_interrupt_trigger_attr_groups;
>> +	ret = iio_trigger_register(trig);
>> +	if (ret)
>>   		goto error_free_trig_info;
>> +
>> +	/* Create a sysfs entry which the userspace may poll for irq events. */
>> +	trig_info->poll = sysfs_get_dirent(trig->dev.kobj.sd, "count");
>> +	if (!trig_info->poll) {
>> +		ret = -ENOENT;
>> +		goto error_unregister_trig;
>>   	}
>>   
>> -	ret = iio_trigger_register(trig);
>> -	if (ret)
>> -		goto error_release_irq;
>> -	platform_set_drvdata(pdev, trig);
>> +	ret = request_irq(irq, iio_interrupt_trigger_poll,
>> +			  (irq_res->flags & IRQF_TRIGGER_MASK) | IRQF_SHARED,
>> +			  trig->name, trig);
>> +	if (!ret) {
>> +		platform_set_drvdata(pdev, trig);
>> +		return 0;
>> +	}
>>   
>> -	return 0;
>> +	sysfs_put(trig_info->poll);
>>   
>>   /* First clean up the partly allocated trigger */
>> -error_release_irq:
>> -	free_irq(irq, trig);
>> +error_unregister_trig:
>> +	iio_trigger_unregister(trig);
>>   error_free_trig_info:
>>   	kfree(trig_info);
>>   error_put_trigger:
>> @@ -96,8 +139,9 @@ static int iio_interrupt_trigger_remove(struct platform_device *pdev)
>>   
>>   	trig = platform_get_drvdata(pdev);
>>   	trig_info = iio_trigger_get_drvdata(trig);
>> -	iio_trigger_unregister(trig);
>>   	free_irq(trig_info->irq, trig);
>> +	sysfs_put(trig_info->poll);
>> +	iio_trigger_unregister(trig);
>>   	kfree(trig_info);
>>   	iio_trigger_put(trig);
>>   
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
