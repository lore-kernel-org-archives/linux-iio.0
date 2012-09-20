Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:33326 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753074Ab2ITHno (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 20 Sep 2012 03:43:44 -0400
Received: by oago6 with SMTP id o6so1882581oag.19
        for <linux-iio@vger.kernel.org>; Thu, 20 Sep 2012 00:43:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5059FD50.80604@metafoo.de>
References: <CAEE_umptNVPOYeTANC4mtAo8AxizmFkrFoa0eLGoLFtTRgWzng@mail.gmail.com>
	<CAEE_umoJ-QmmFMkiXE0AvC3cE4PoD2DrsivFa-49jS2L=nG0ZA@mail.gmail.com>
	<5059FD50.80604@metafoo.de>
Date: Thu, 20 Sep 2012 09:43:43 +0200
Message-ID: <CAEE_umrYWXKz6hOF958E96DhRdafGTtSE7fz0UfdX_rPZrgqTQ@mail.gmail.com>
Subject: Re: Fwd: iio_trigger doesn't work
From: Denis Ciocca <denis.ciocca@gmail.com>
To: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

a little bit of code:

accelerometer_core.c

**
static irqreturn_t acc_trigger_handler(int irq, void *p)
{
	struct iio_poll_func *pf = p;
	struct iio_dev *indio_dev = pf->indio_dev;
	struct acc_data *adata = iio_priv(indio_dev);
	struct iio_buffer *buffer = indio_dev->buffer;

	pr_info("test.\n");

	iio_trigger_notify_done(indio_dev->trig);
	return IRQ_HANDLED;
}

static int __devinit acc_probe(struct i2c_client *client,
				const struct i2c_device_id *id)
{
...
	err = acc_probe_trigger(indio_dev);
	if(err < 0)
	{
		pr_err("%s(0x%x): acc_probe_trigger failed.\n",
					client->name, (u8)client->addr);
		goto acc_probe_trigger_error;
	}
indio_dev->pollfunc = iio_alloc_pollfunc(
						&iio_pollfunc_store_time,
						&acc_trigger_handler,
						IRQF_ONESHOT,
						indio_dev,
						"consumer%d",
						indio_dev->id);
	if(indio_dev->pollfunc == NULL)
	{
		ret = -ENOMEM;
		goto iio_alloc_pollfunc_error;
	}
	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
...
}
**


accelerometer_trigger.c

static enum hrtimer_restart iio_trig_hrtimer_trig(struct hrtimer *time)
{
	struct acc_data *adata = container_of(time, struct acc_data, timer);
	ktime_t period;

	period = ktime_set(0, NSEC_PER_SEC / adata->odr);
	hrtimer_forward_now(&adata->timer, period);
	pr_info("prova\n");
	iio_trigger_poll_chained(adata->trig, iio_get_time_ns());
	return HRTIMER_RESTART;
}

static const struct iio_trigger_ops iio_acc_trigger_ops = {
	.owner = THIS_MODULE,
};

int acc_probe_trigger(struct iio_dev *indio_dev)
{
	struct acc_data *adata;
	int err;

	adata = iio_priv(indio_dev);
	pr_info("%s(0x%x): trigger probe start.\n", adata->client->name,
						(u8)adata->client->addr);

	adata->trig = iio_trigger_alloc("%s-periodic_task-%d",
					indio_dev->name, indio_dev->id);
	if(adata->trig == NULL)
	{
		err = -ENOMEM;
		pr_err("%s(0x%x): failed to allocate iio trigger."
			"\n", adata->client->name, (u8)adata->client->addr);
		goto iio_trigger_alloc_error;
	}

	adata->trig->private_data = indio_dev;
	adata->trig->ops = &iio_acc_trigger_ops;
	adata->trig->dev.parent = &adata->client->dev;

	hrtimer_init(&adata->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
	adata->timer.function = iio_trig_hrtimer_trig;

	err = iio_trigger_register(adata->trig);
	if (err < 0)
	{
		pr_err("%s(0x%x): failed to register iio trigger."
			"\n", adata->client->name, (u8)adata->client->addr);
		goto iio_trigger_register_error;
	}
	indio_dev->trig = adata->trig;
hrtimer_start(&adata->timer, ktime_set(0, NSEC_PER_SEC/adata->odr),
			HRTIMER_MODE_REL);
	return 0;

iio_trigger_register_error:
	iio_trigger_free(adata->trig);
iio_trigger_alloc_error:
	return err;
}


I expect the message by pr_info is printed every delta time, but it
doesn't work. Can you help me? It is mandatory use buffer?
This is only an example, I am not expected that is useful.
Sorry for the code style but I am newby.
Thanks

Denis





2012/9/19 Lars-Peter Clausen <lars@metafoo.de>:
> On 09/19/2012 05:57 PM, Denis Ciocca wrote:
>> Hi everybody,
>>
>> [...]
>>
>> What I'm doing wrong?
>
> Hi,
>
> answering this certainly becomes easier if you'd post the code in
> question. :)
>
> - Lars
