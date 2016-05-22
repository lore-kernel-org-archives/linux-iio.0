Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52786 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752583AbcEVVad (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 22 May 2016 17:30:33 -0400
Subject: Re: [RFC PATCH V2] iio:trigger: Experimental kthread tight loop
 trigger (thread only)
To: linux-iio@vger.kernel.org
References: <1457294576-10121-1-git-send-email-jic23@kernel.org>
Cc: gregor.boirie@parrot.com, lars@metafoo.de, pmeerw@pmeerw.net,
	daniel.baluta@intel.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <d469dc68-eff5-632a-6b80-67ec6a9d5ef2@kernel.org>
Date: Sun, 22 May 2016 22:30:27 +0100
MIME-Version: 1.0
In-Reply-To: <1457294576-10121-1-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/03/16 20:02, Jonathan Cameron wrote:
> This patch is in response to that of
> Gregor Boirie <gregor.boirie@parrot.com>
> who proposed using a tight kthread within a device driver (be it with the
> support factored out into a helper library) in order to basically spin as
> fast as possible.
> 
> It is meant as a talking point rather than a formal proposal of the code
> (though we are heading towards that I think).
> Also gives people some working code to mess around with.
> 
> I proposed that this could be done with a trigger with a few constraints
> and this is the proof (be it ugly) of that.
> 
> There are some constraints though, some of which we would want to relax
> if this were to move forward.
> 
> * Will only run the thread part of the registered pollfunc.  This is to
>   avoid the overhead of jumping in and out of interrupt context.  Is the
>   overhead significant?  Not certain but feels like it should be!
> 
> * This limitation precludes any device that 'must' do some work in
>   interrupt context.  However, that is true of few if any drivers and
>   I suspect that any that do will be restricted to using triggers they
>   provide themselves.  Usually we have a top half mainly to grab a
>   timestamp as soon after the dataready type signal as possible.
> 
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Any comments on this anyone?

Whilst we still haven't dealt with the question of neatly handling
the missing top halves (where relevant) I think it might be worth taking this
soonish as we have genuine use cases...

Would be easy enough to modify the pollfunc generic timestamp code to play
a few games to ensure it grabs a software timestamp in the threaded handler if needed
(inserting an appropriate access function into all users)..
say
iio_pollfunc_get_ts_best_effort() that uses the top half stored one if available
(also setting a 'new timestamp' available if from a hardware source) or if not
grabs one at call time in the threaded handler.


Jonathan
> ---
>  drivers/iio/trigger/Kconfig         |  12 +++
>  drivers/iio/trigger/Makefile        |   1 +
>  drivers/iio/trigger/iio-trig-loop.c | 143 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 156 insertions(+)
> 
> diff --git a/drivers/iio/trigger/Kconfig b/drivers/iio/trigger/Kconfig
> index 519e6772f6f5..9feabe95eeda 100644
> --- a/drivers/iio/trigger/Kconfig
> +++ b/drivers/iio/trigger/Kconfig
> @@ -24,6 +24,18 @@ config IIO_INTERRUPT_TRIGGER
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called iio-trig-interrupt.
>  
> +config IIO_TIGHTLOOP_TRIGGER
> +	tristate "A kthread based hammering loop trigger"
> +	depends on IIO_SW_TRIGGER
> +	help
> +	  An experimental trigger, used to allow sensors to be sampled as fast
> +	  as possible under the limitations of whatever else is going on.
> +	  Uses a tight loop in a kthread.  Will only work with lower half only
> +	  trigger consumers.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called iio-trig-loop.	  
> +
>  config IIO_SYSFS_TRIGGER
>  	tristate "SYSFS trigger"
>  	depends on SYSFS
> diff --git a/drivers/iio/trigger/Makefile b/drivers/iio/trigger/Makefile
> index fe06eb564367..aab4dc23303d 100644
> --- a/drivers/iio/trigger/Makefile
> +++ b/drivers/iio/trigger/Makefile
> @@ -7,3 +7,4 @@
>  obj-$(CONFIG_IIO_HRTIMER_TRIGGER) += iio-trig-hrtimer.o
>  obj-$(CONFIG_IIO_INTERRUPT_TRIGGER) += iio-trig-interrupt.o
>  obj-$(CONFIG_IIO_SYSFS_TRIGGER) += iio-trig-sysfs.o
> +obj-$(CONFIG_IIO_TIGHTLOOP_TRIGGER) += iio-trig-loop.o
> diff --git a/drivers/iio/trigger/iio-trig-loop.c b/drivers/iio/trigger/iio-trig-loop.c
> new file mode 100644
> index 000000000000..dc6be28f96fe
> --- /dev/null
> +++ b/drivers/iio/trigger/iio-trig-loop.c
> @@ -0,0 +1,143 @@
> +/*
> + * Copyright 2016 Jonathan Cameron <jic23@kernel.org>
> + *
> + * Licensed under the GPL-2.
> + *
> + * Based on a mashup of the hrtimer trigger and continuous sampling proposal of
> + * Gregor Boirie <gregor.boirie@parrot.com>
> + *
> + * Note this is still rather experimental and may eat babies.
> + *
> + * Todo
> + * * Protect against connection of devices that 'need' the top half
> + *   handler.
> + * * Work out how to run top half handlers in this context if it is
> + *   safe to do so (timestamp grabbing for example)
> + *
> + * Tested against a max1363. Used about 33% cpu for the thread and 20%
> + * for generic_buffer piping to /dev/null. Watermark set at 64 on a 128
> + * element kfifo buffer.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/irq_work.h>
> +#include <linux/kthread.h>
> +#include <linux/freezer.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/sw_trigger.h>
> +
> +struct iio_loop_info {
> +	struct iio_sw_trigger swt;
> +	struct task_struct *task;
> +};
> +
> +static struct config_item_type iio_loop_type = {
> +	.ct_owner = THIS_MODULE,
> +};
> +
> +static int iio_loop_thread(void *data)
> +{
> +	struct iio_trigger *trig = data;
> +
> +	set_freezable();
> +
> +	do {
> +		iio_trigger_poll_chained(trig);
> +	} while (likely(!kthread_freezable_should_stop(NULL)));
> +
> +	return 0;
> +}
> +
> +static int iio_loop_trigger_set_state(struct iio_trigger *trig, bool state)
> +{
> +	struct iio_loop_info *loop_trig = iio_trigger_get_drvdata(trig);
> +
> +	if (state) {
> +		loop_trig->task = kthread_run(iio_loop_thread,
> +					      trig, trig->name);
> +		if (unlikely(IS_ERR(loop_trig->task))) {
> +			dev_err(&trig->dev,
> +				"failed to create trigger loop thread\n");
> +			return PTR_ERR(loop_trig->task);
> +		}
> +	} else {
> +		kthread_stop(loop_trig->task);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct iio_trigger_ops iio_loop_trigger_ops = {
> +	.set_trigger_state = iio_loop_trigger_set_state,
> +	.owner = THIS_MODULE,
> +};
> +
> +static struct iio_sw_trigger *iio_trig_loop_probe(const char *name)
> +{
> +	struct iio_loop_info *trig_info;
> +	int ret;
> +
> +	trig_info = kzalloc(sizeof(*trig_info), GFP_KERNEL);
> +	if (!trig_info)
> +		return ERR_PTR(-ENOMEM);
> +
> +	trig_info->swt.trigger = iio_trigger_alloc("%s", name);
> +	if (!trig_info->swt.trigger) {
> +		ret = -ENOMEM;
> +		goto err_free_trig_info;
> +	}
> +
> +	iio_trigger_set_drvdata(trig_info->swt.trigger, trig_info);
> +	trig_info->swt.trigger->ops = &iio_loop_trigger_ops;
> +
> +	ret = iio_trigger_register(trig_info->swt.trigger);
> +	if (ret)
> +		goto err_free_trigger;
> +
> +	iio_swt_group_init_type_name(&trig_info->swt, name, &iio_loop_type);
> +
> +	return &trig_info->swt;
> +
> +err_free_trigger:
> +	iio_trigger_free(trig_info->swt.trigger);
> +err_free_trig_info:
> +	kfree(trig_info);
> +
> +	return ERR_PTR(ret);
> +}
> +
> +static int iio_trig_loop_remove(struct iio_sw_trigger *swt)
> +{
> +	struct iio_loop_info *trig_info;
> +
> +	trig_info = iio_trigger_get_drvdata(swt->trigger);
> +
> +	iio_trigger_unregister(swt->trigger);
> +	iio_trigger_free(swt->trigger);
> +	kfree(trig_info);
> +
> +	return 0;
> +}
> +
> +static const struct iio_sw_trigger_ops iio_trig_loop_ops = {
> +	.probe = iio_trig_loop_probe,
> +	.remove = iio_trig_loop_remove,
> +};
> +
> +static struct iio_sw_trigger_type iio_trig_loop = {
> +	.name = "loop",
> +	.owner = THIS_MODULE,
> +	.ops = &iio_trig_loop_ops,
> +};
> +
> +module_iio_sw_trigger_driver(iio_trig_loop);
> +
> +MODULE_AUTHOR("Jonathan Cameron <jic23@kernel.org>");
> +MODULE_DESCRIPTION("Loop based trigger for the iio subsystem");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:iio-trig-loop");
> 

