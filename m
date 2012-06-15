Return-Path: <jic23@cam.ac.uk>
Message-ID: <4FDB4DB9.7080402@cam.ac.uk>
Date: Fri, 15 Jun 2012 15:59:05 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: Bottom half trigger function never called when using the sysfs
 trigger
References: <4FDB33CD.2090805@metafoo.de> <4FDB3972.8090209@kernel.org> <4FDB4D3E.6050907@metafoo.de>
In-Reply-To: <4FDB4D3E.6050907@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 6/15/2012 3:57 PM, Lars-Peter Clausen wrote:
> On 06/15/2012 03:32 PM, Jonathan Cameron wrote:
>> On 6/15/2012 2:08 PM, Lars-Peter Clausen wrote:
>>> hi,
>>>
>>> The sysfs trigger uses iio_trigger_poll_chained which calls
>>> handle_nested_irq. The problem now is that for nested IRQs the primary
>>> handler is not called. Which obviously breaks drivers which have a bottom
>>> half trigger function.
>>>
>>> This behaviour was introduced in commit 1f785681 ("staging:iio:trigger sysfs
>>> userspace trigger rework."). The commit message says you are "awaiting
>>> comments on using the nested_irq_trick", but not why it is necessary to use
>>> nested IRQs. And honestly I don't get why it would be necessary either.
>>> handle_nested_irq is supposed to be used with chained IRQs if we are already
>>> running in a thread handler of parent. Neither seems to be true here.
>> It was a while ago so my memory is rather sketchy.
>> do you meant the bottom half?  Unless I'm very confused its the top half
>> that doesn't
>
> Uhm, yes the top half.
>
>> get called.. handle_nested_irq calls thread_fn which is the bottom half.
>>
>> It's the only way I've come up with for cleanly running through our trigger
>> distribution
>> given that is all irq based.  Top halves expect to be run in interrupt mode.
>> I don't know
>> of any way to ensure this is true if one is 'creating' the interrupt from
>> software.
>>
>> I did wonder at the time about putting an explicit call of the interrupt
>> handler in
>> to deal with the missing top halves. It's rather uggly though and suffers
>> from things
>> not being run in the state they expect to be run in....
>>
>> Other suggestions welcome.
>
> Hm, maybe not use interrupts for the trigger events... ;)
>
> On the other hand there is the new irq_work framework which lets you
> schedule events which should be run in hardirq context. The following patch
> seems to do the trick (Note the patch won't apply as my mail client will
> insert line breaks where it shouldn't. I'll sent a proper patch if you agree
> with the general idea).
Looks like someone else ran into the same problem and came up with
a much better solution than I did.

This certainly looks better than the current.
>
> diff --git a/drivers/staging/iio/trigger/Kconfig
> b/drivers/staging/iio/trigger/Kconfig
> index b8abf54..d44d3ad 100644
> --- a/drivers/staging/iio/trigger/Kconfig
> +++ b/drivers/staging/iio/trigger/Kconfig
> @@ -21,6 +21,7 @@ config IIO_GPIO_TRIGGER
>   config IIO_SYSFS_TRIGGER
>   	tristate "SYSFS trigger"
>   	depends on SYSFS
> +	select IRQ_WORK
>   	help
>   	  Provides support for using SYSFS entry as IIO triggers.
>   	  If unsure, say N (but it's safe to say "Y").
> diff --git a/drivers/staging/iio/trigger/iio-trig-sysfs.c
> index 552763b..fde93a8 100644
> --- a/drivers/staging/iio/trigger/iio-trig-sysfs.c
> +++ b/drivers/staging/iio/trigger/iio-trig-sysfs.c
> @@ -10,12 +10,14 @@
>   #include<linux/platform_device.h>
>   #include<linux/slab.h>
>   #include<linux/list.h>
> +#include<linux/irq_work.h>
>
>   #include<linux/iio/iio.h>
>   #include<linux/iio/trigger.h>
>
>   struct iio_sysfs_trig {
>   	struct iio_trigger *trig;
> +	struct irq_work work;
>   	int id;
>   	struct list_head l;
>   };
> @@ -89,11 +91,17 @@ static struct device iio_sysfs_trig_dev = {
>   	.release =&iio_trigger_sysfs_release,
>   };
>
> +static void iio_sysfs_trigger_work(struct irq_work *work)
> +{
> +	struct iio_sysfs_trig *trig = container_of(work, struct iio_sysfs_trig, work);
> +	iio_trigger_poll(trig->trig, 0);
> +}
> +
>   static ssize_t iio_sysfs_trigger_poll(struct device *dev,
>   		struct device_attribute *attr, const char *buf, size_t count)
>   {
> -	struct iio_trigger *trig = dev_get_drvdata(dev);
> -	iio_trigger_poll_chained(trig, 0);
> +	struct iio_sysfs_trig *trig = dev_get_drvdata(dev);
> +	irq_work_queue(&trig->work);
>
>   	return count;
>   }
> @@ -148,6 +156,9 @@ static int iio_sysfs_trigger_probe(int id)
>   	t->trig->dev.groups = iio_sysfs_trigger_attr_groups;
>   	t->trig->ops =&iio_sysfs_trigger_ops;
>   	t->trig->dev.parent =&iio_sysfs_trig_dev;
> +	dev_set_drvdata(&t->trig->dev, t);
> +
> +	init_irq_work(&t->work, iio_sysfs_trigger_work);
>
>   	ret = iio_trigger_register(t->trig);
>   	if (ret)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
